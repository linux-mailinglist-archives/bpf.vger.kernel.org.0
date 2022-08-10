Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373EE58F170
	for <lists+bpf@lfdr.de>; Wed, 10 Aug 2022 19:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbiHJRTT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Aug 2022 13:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233662AbiHJRSk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Aug 2022 13:18:40 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B8E667AC2F;
        Wed, 10 Aug 2022 10:18:34 -0700 (PDT)
Received: from pwmachine.numericable.fr (85-170-37-153.rev.numericable.fr [85.170.37.153])
        by linux.microsoft.com (Postfix) with ESMTPSA id 01E4B210C8B3;
        Wed, 10 Aug 2022 10:18:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 01E4B210C8B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1660151914;
        bh=iXUHheSzUfdxocFNJ+xyTMnGHmXWV9gO99MJy2MdGuQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d7n9wTywcZMRua59gPPfvfaU+rNEyuTkLy9kZxk8JvF9l4VCCjFSamaYmPoAoWag/
         T58jQEeFatPyOT4gK7UIY5FIZDy+pZTvlmusITw3QwLPhAwxcMyVpgKFs+dPEtjAbW
         OJHkxTEVtYNkjJecX09BL7M2tEIK9s4RWh8gtI8I=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     bpf@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Francis Laniel <flaniel@linux.microsoft.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Geliang Tang <geliang.tang@suse.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
Subject: [RFC PATCH v1 2/3] do not merge: Temporary fix for is_power_of_2.
Date:   Wed, 10 Aug 2022 19:16:53 +0200
Message-Id: <20220810171702.74932-3-flaniel@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220810171702.74932-1-flaniel@linux.microsoft.com>
References: <20220810171702.74932-1-flaniel@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Signed-off-by: Francis Laniel <flaniel@linux.microsoft.com>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index e89cc9c885b3..5d0e997c85ea 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4945,7 +4945,7 @@ static void bpf_map__destroy(struct bpf_map *map);
 
 static bool is_pow_of_2(size_t x)
 {
-	return x && (x & (x - 1));
+	return x && (x & (x - 1)) == 0;
 }
 
 static size_t adjust_ringbuf_sz(size_t sz)
-- 
2.25.1

