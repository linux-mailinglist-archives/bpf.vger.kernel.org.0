Return-Path: <bpf+bounces-5294-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A27E67596D3
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 15:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EB57281B01
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 13:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC2418015;
	Wed, 19 Jul 2023 13:25:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E1517FF1;
	Wed, 19 Jul 2023 13:25:19 +0000 (UTC)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51A610A;
	Wed, 19 Jul 2023 06:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689773117; x=1721309117;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r8FOV+1rWdy3G3c1L5QIshu4tGRWQGvf8+jf8b0e4Gs=;
  b=c6wCSKW5Y6Qh01m+20oMrpoPXLE7z/tBcU79o3qd0X0k584UAiR4GG3i
   yne9j2T4OAMHNBQsokdsoiZswCCWPAT+EzRYXJR5trKHQRfZq7D6wAJdf
   cKW7vT3Vll1z4Y5aGCjuWDYbEKV4o0jHVuwe8NlF2rlt+SnXP9Vsg3yCU
   e4k70D8eH68/wvGLub7YJcR/fsUFb1NRP96XpMnBLzyQvBUCkRuIN9DPN
   1fe58vMd5fQkmGELopz81/tKb0S0pZeSRQ87qTevBGAt0pyW39z2Osb4o
   i6911rKjghg25GJ+LNWqU+MpNSkmiHnKCU4LpV1Ea4NblnbHBTuSg1+zb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="363920599"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="363920599"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 06:25:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="717978082"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="717978082"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orsmga007.jf.intel.com with ESMTP; 19 Jul 2023 06:24:59 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	bjorn@kernel.org,
	toke@kernel.org,
	kuba@kernel.org,
	horms@kernel.org,
	tirthendu.sarkar@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v7 bpf-next 09/24] xsk: discard zero length descriptors in Tx path
Date: Wed, 19 Jul 2023 15:24:06 +0200
Message-Id: <20230719132421.584801-10-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230719132421.584801-1-maciej.fijalkowski@intel.com>
References: <20230719132421.584801-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Tirthendu Sarkar <tirthendu.sarkar@intel.com>

Descriptors with zero length are not supported by many NICs. To preserve
uniform behavior discard any zero length desc as invvalid desc.

Signed-off-by: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 net/xdp/xsk_queue.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index 5752c9fd8ce7..bac32027f865 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -140,6 +140,9 @@ static inline bool xp_aligned_validate_desc(struct xsk_buff_pool *pool,
 {
 	u64 offset = desc->addr & (pool->chunk_size - 1);
 
+	if (!desc->len)
+		return false;
+
 	if (offset + desc->len > pool->chunk_size)
 		return false;
 
@@ -156,6 +159,9 @@ static inline bool xp_unaligned_validate_desc(struct xsk_buff_pool *pool,
 {
 	u64 addr = xp_unaligned_add_offset_to_addr(desc->addr);
 
+	if (!desc->len)
+		return false;
+
 	if (desc->len > pool->chunk_size)
 		return false;
 
-- 
2.34.1


