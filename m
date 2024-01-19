Return-Path: <bpf+bounces-19946-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 688EE83318D
	for <lists+bpf@lfdr.de>; Sat, 20 Jan 2024 00:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68BC41C23924
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 23:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392CF5A79A;
	Fri, 19 Jan 2024 23:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lF0JiOvD"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE7A5A792;
	Fri, 19 Jan 2024 23:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705707079; cv=none; b=Tqhw618PbzPBxPdsHjkuirGp8gjmZF41vtIWRmhbonYmHfQ1gr+50R+qmbID0IDHqlx7laOgnFZPzMzZLpwZaydAbi9L2B2NfYE+jtMzco5HQ2tRwEJeUofIUqVqaj5jpthj3jgmRYyC37iKUbcOOtGDfGuBHFWEWOkpI1U4zew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705707079; c=relaxed/simple;
	bh=meNYqu0YNaFTAm5+BjD0H0A6IXvQTHaUHm0t63qW7Tc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CFLmX6bUhcXrv8eVONw/P1Qb0dIqkvVOCcymcOzt+fNefz5oW9end1xkWI3wCZ/h4skIx4/6qsck5uNCz0CJXhaun5BDCERqYVCYNifjOt9CQV67HTiS6sWLRHr+ceTgcqAjhQHoLH6WQIC43YdjL7SBsyfb1xq21aDVHzZXNdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lF0JiOvD; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705707078; x=1737243078;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=meNYqu0YNaFTAm5+BjD0H0A6IXvQTHaUHm0t63qW7Tc=;
  b=lF0JiOvDYzsLXfs2Shu43SoZUFnK+Ffpg5e6s+KIB5KQJloLb8chcpIF
   vrxwKArsmUeUstDH+2bzVVsyc9nT6BiqLskJWf802QDZC0vF0YG45OJgS
   LAPO3V+aOttw/C5bvECxAN8KP6wHnP2bdOKDVRnAVVMXEXDdoEYP/+3vH
   R6iM2lvfCHvONpGfW84w7anc6K1a7wQY6oJ1wweBnztUPWPd1tn/n0CiE
   rFk3z5TTpV+WU+vYRn7jzknVFUCq0HY3FfAlP8GXqefLz1QWXN2dLpT0h
   PUVmuxo1nCsTiPpqY1XFLzCOUKk3ctz4MmYjbmWqzgYRWiBtRCYuqSBB6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="771660"
X-IronPort-AV: E=Sophos;i="6.05,206,1701158400"; 
   d="scan'208";a="771660"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 15:31:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="904277450"
X-IronPort-AV: E=Sophos;i="6.05,206,1701158400"; 
   d="scan'208";a="904277450"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmsmga002.fm.intel.com with ESMTP; 19 Jan 2024 15:31:15 -0800
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	bjorn@kernel.org,
	maciej.fijalkowski@intel.com,
	echaudro@redhat.com,
	lorenzo@kernel.org,
	martin.lau@linux.dev,
	tirthendu.sarkar@intel.com,
	john.fastabend@gmail.com
Subject: [PATCH v4 bpf 09/11] xdp: reflect tail increase for MEM_TYPE_XSK_BUFF_POOL
Date: Sat, 20 Jan 2024 00:30:35 +0100
Message-Id: <20240119233037.537084-10-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240119233037.537084-1-maciej.fijalkowski@intel.com>
References: <20240119233037.537084-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

XSK ZC Rx path calculates the size of data that will be posted to XSK Rx
queue via subtracting xdp_buff::data_end from xdp_buff::data.

In bpf_xdp_frags_increase_tail(), when underlying memory type of
xdp_rxq_info is MEM_TYPE_XSK_BUFF_POOL, add offset to data_end in tail
fragment, so that later on user space will be able to take into account
the amount of bytes added by XDP program.

Fixes: 24ea50127ecf ("xsk: support mbuf on ZC RX")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 net/core/filter.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 8e0cd8ca461e..9270b4d7acee 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4093,6 +4093,8 @@ static int bpf_xdp_frags_increase_tail(struct xdp_buff *xdp, int offset)
 	memset(skb_frag_address(frag) + skb_frag_size(frag), 0, offset);
 	skb_frag_size_add(frag, offset);
 	sinfo->xdp_frags_size += offset;
+	if (rxq->mem.type == MEM_TYPE_XSK_BUFF_POOL)
+		xsk_buff_get_tail(xdp)->data_end += offset;
 
 	return 0;
 }
-- 
2.34.1


