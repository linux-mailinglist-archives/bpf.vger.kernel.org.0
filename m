Return-Path: <bpf+bounces-5429-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6601675A846
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 09:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80C261C2127B
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 07:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE5B171D2;
	Thu, 20 Jul 2023 07:52:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACB2168AA
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 07:52:40 +0000 (UTC)
X-Greylist: delayed 1367 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 20 Jul 2023 00:52:37 PDT
Received: from bjm7-spam02.kuaishou.com (smtpcn03.kuaishou.com [103.107.217.217])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FA52135;
	Thu, 20 Jul 2023 00:52:37 -0700 (PDT)
Received: from bjm7-spam02.kuaishou.com (localhost [127.0.0.2] (may be forged))
	by bjm7-spam02.kuaishou.com with ESMTP id 36K7TohW080274;
	Thu, 20 Jul 2023 15:29:50 +0800 (GMT-8)
	(envelope-from yangyifei03@kuaishou.com)
Received: from bjm7-pm-mail12.kuaishou.com ([172.28.1.94])
	by bjm7-spam02.kuaishou.com with ESMTPS id 36K7RmOj078771
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 20 Jul 2023 15:27:54 +0800 (GMT-8)
	(envelope-from yangyifei03@kuaishou.com)
DKIM-Signature: v=1; a=rsa-sha256; d=kuaishou.com; s=dkim; c=relaxed/relaxed;
	t=1689838068; h=from:subject:to:date:message-id;
	bh=2hvt2nAb9FQGc8JWV2zRVOy7HcAR3TW4z5ZsrMla/mw=;
	b=Ov9ON0jOMvPY7tYxtSF27RXIYX5/ESwleAfyzbMcRkfahhvPD8+vCRgUolm4nuFAX7xrxXLLqLP
	VC0ugqxGe1jauqIjydi7S9YH2M2vjCjTteErwqG546qEglqgQx2dxnNycFZVOCvZX9fbPRgt69Um7
	2ew2dB1E6Kom/DkdCz0=
Received: from public-bjmt-d51.idcyz.hb1.kwaidc.com (172.28.1.32) by
 bjm7-pm-mail12.kuaishou.com (172.28.1.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Thu, 20 Jul 2023 15:27:48 +0800
From: Efly Young <yangyifei03@kuaishou.com>
To: <hannes@cmpxchg.org>
CC: <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: [PATCH] mm:vmscan: fix inaccurate reclaim during proactive reclaim
Date: Thu, 20 Jul 2023 15:27:08 +0800
Message-ID: <20230720072708.55067-1-yangyifei03@kuaishou.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.28.1.32]
X-ClientProxiedBy: bjxm-pm-mail02.kuaishou.com (172.28.128.2) To
 bjm7-pm-mail12.kuaishou.com (172.28.1.94)
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:bjm7-spam02.kuaishou.com 36K7TohW080274
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Before commit f53af4285d77 ("mm: vmscan: fix extreme overreclaim and
swap floods"), proactive reclaim will extreme overreclaim sometimes.
But proactive reclaim still inaccurate and some extent overreclaim.

Problematic case is easy to construct. Allocate lots of anonymous
memory (e.g., 20G) in a memcg, then swapping by writing memory.recalim
and there is a certain probability of overreclaim. For example, request
1G by writing memory.reclaim will eventually reclaim 1.7G or other
values more than 1G.

The reason is that reclaimer may have already reclaimed part of requested
memory in one loop, but before adjust sc->nr_to_reclaim in outer loop,
call shrink_lruvec() again will still follow the current sc->nr_to_reclaim
to work. It will eventually lead to overreclaim. In theory, the amount
of reclaimed would be in [request, 2 * request).

Reclaimer usually tends to reclaim more than request. But either direct
or kswapd reclaim have much smaller nr_to_reclaim targets, so it is
less noticeable and not have much impact.

Proactive reclaim can usually come in with a larger value, so the error
is difficult to ignore. Considering proactive reclaim is usually low
frequency, handle the batching into smaller chunks is a better approach.

Signed-off-by: Efly Young <yangyifei03@kuaishou.com>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memcontrol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4b27e24..d36cf88 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6741,8 +6741,8 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
 			lru_add_drain_all();
 
 		reclaimed = try_to_free_mem_cgroup_pages(memcg,
-						nr_to_reclaim - nr_reclaimed,
-						GFP_KERNEL, reclaim_options);
+					min(nr_to_reclaim - nr_reclaimed, SWAP_CLUSTER_MAX),
+					GFP_KERNEL, reclaim_options);
 
 		if (!reclaimed && !nr_retries--)
 			return -EAGAIN;
-- 
1.8.3.1


