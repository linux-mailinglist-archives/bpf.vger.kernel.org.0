Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E29BA6AFF3C
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 08:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjCHHAQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Mar 2023 02:00:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjCHHAO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Mar 2023 02:00:14 -0500
Received: from out-4.mta1.migadu.com (out-4.mta1.migadu.com [IPv6:2001:41d0:203:375::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA510A1FDA
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 23:00:13 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1678258812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UVK+7aVsZBZbHw4uT6sVYjoHjigsAu6AGe0/Ho5JF00=;
        b=pSWjb6F7Fe5mx1oGc5qcCdYqJtFuqynLWjcc7szlY8Mn5Wsp5q8cq+o2zhseVxw/EXeNwk
        XVITEAagYVELkSawxwXe86IQUPbuot8vHK87JzQVoqeMd34QK0yV+Nf5SV/UiL5DaPy4km
        rIoVgvHJzAVNKthjs+VbhLld++Ud+o0=
From:   Martin KaFai Lau <martin.lau@linux.dev>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com
Subject: [PATCH v2 bpf-next 08/17] bpf: Add bpf_selem_free_rcu callback
Date:   Tue,  7 Mar 2023 22:59:27 -0800
Message-Id: <20230308065936.1550103-9-martin.lau@linux.dev>
In-Reply-To: <20230308065936.1550103-1-martin.lau@linux.dev>
References: <20230308065936.1550103-1-martin.lau@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Martin KaFai Lau <martin.lau@kernel.org>

Add bpf_selem_free_rcu() callback to do the kfree() instead
of using kfree_rcu. It is a preparation work for using
bpf_mem_cache_alloc/free in a later patch.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 kernel/bpf/bpf_local_storage.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 715deaaefe13..146e9caeda96 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -109,15 +109,20 @@ static void bpf_local_storage_free_rcu(struct rcu_head *rcu)
 		kfree_rcu(local_storage, rcu);
 }
 
-static void bpf_selem_free_trace_rcu(struct rcu_head *rcu)
+static void bpf_selem_free_rcu(struct rcu_head *rcu)
 {
 	struct bpf_local_storage_elem *selem;
 
 	selem = container_of(rcu, struct bpf_local_storage_elem, rcu);
+	kfree(selem);
+}
+
+static void bpf_selem_free_trace_rcu(struct rcu_head *rcu)
+{
 	if (rcu_trace_implies_rcu_gp())
-		kfree(selem);
+		bpf_selem_free_rcu(rcu);
 	else
-		kfree_rcu(selem, rcu);
+		call_rcu(rcu, bpf_selem_free_rcu);
 }
 
 /* local_storage->lock must be held and selem->local_storage == local_storage.
@@ -174,7 +179,7 @@ static bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_stor
 	if (!reuse_now)
 		call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_trace_rcu);
 	else
-		kfree_rcu(selem, rcu);
+		call_rcu(&selem->rcu, bpf_selem_free_rcu);
 
 	if (rcu_access_pointer(local_storage->smap) == smap)
 		RCU_INIT_POINTER(local_storage->smap, NULL);
-- 
2.34.1

