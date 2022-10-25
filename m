Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A7A60D3DB
	for <lists+bpf@lfdr.de>; Tue, 25 Oct 2022 20:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbiJYSqP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Oct 2022 14:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232898AbiJYSpw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Oct 2022 14:45:52 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9309A69182
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 11:45:45 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1666723543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U2vo90GX2ReVHnobyCn7t/Qs/5AyO2Em2JVC4c9JtA8=;
        b=aSOMUQYvBJ1wWwagYh/HALq22YOIcCtdw2yo9yeXvFV3Rs4EyNYSv1+BktSfZDIVa5bES7
        2exgG0Jz/v87Pny2+yeMt5sPDEUAJDBYk4aF8aqrhgnrhzffWUrD9+QcIK09W81FCVRzNU
        bqwWKRbFzXpo6+bcMsTsMmAH6esNoto=
From:   Martin KaFai Lau <martin.lau@linux.dev>
To:     bpf@vger.kernel.org
Cc:     'Alexei Starovoitov ' <ast@kernel.org>,
        'Andrii Nakryiko ' <andrii@kernel.org>,
        'Daniel Borkmann ' <daniel@iogearbox.net>,
        'Song Liu ' <songliubraving@meta.com>, kernel-team@meta.com
Subject: [PATCH bpf-next 3/9] bpf: Refactor the core bpf_task_storage_get logic into a new function
Date:   Tue, 25 Oct 2022 11:45:18 -0700
Message-Id: <20221025184524.3526117-4-martin.lau@linux.dev>
In-Reply-To: <20221025184524.3526117-1-martin.lau@linux.dev>
References: <20221025184524.3526117-1-martin.lau@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Martin KaFai Lau <martin.lau@kernel.org>

This patch creates a new function __bpf_task_storage_get() and
moves the core logic of the existing bpf_task_storage_get()
into this new function.   This new function will be shared
by another new helper proto in the latter patch.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 kernel/bpf/bpf_task_storage.c | 44 +++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
index bce50ae03f42..2726435e3eda 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -227,37 +227,45 @@ static int bpf_pid_task_storage_delete_elem(struct bpf_map *map, void *key)
 	return err;
 }
 
-/* *gfp_flags* is a hidden argument provided by the verifier */
-BPF_CALL_5(bpf_task_storage_get_recur, struct bpf_map *, map, struct task_struct *,
-	   task, void *, value, u64, flags, gfp_t, gfp_flags)
+/* Called by bpf_task_storage_get*() helpers */
+static void *__bpf_task_storage_get(struct bpf_map *map,
+				    struct task_struct *task, void *value,
+				    u64 flags, gfp_t gfp_flags)
 {
 	struct bpf_local_storage_data *sdata;
 
-	WARN_ON_ONCE(!bpf_rcu_lock_held());
-	if (flags & ~(BPF_LOCAL_STORAGE_GET_F_CREATE))
-		return (unsigned long)NULL;
-
-	if (!task)
-		return (unsigned long)NULL;
-
-	if (!bpf_task_storage_trylock())
-		return (unsigned long)NULL;
-
 	sdata = task_storage_lookup(task, map, true);
 	if (sdata)
-		goto unlock;
+		return sdata->data;
 
 	/* only allocate new storage, when the task is refcounted */
 	if (refcount_read(&task->usage) &&
-	    (flags & BPF_LOCAL_STORAGE_GET_F_CREATE))
+	    (flags & BPF_LOCAL_STORAGE_GET_F_CREATE)) {
 		sdata = bpf_local_storage_update(
 			task, (struct bpf_local_storage_map *)map, value,
 			BPF_NOEXIST, gfp_flags);
+		return IS_ERR(sdata) ? NULL : sdata->data;
+	}
 
-unlock:
+	return NULL;
+}
+
+/* *gfp_flags* is a hidden argument provided by the verifier */
+BPF_CALL_5(bpf_task_storage_get_recur, struct bpf_map *, map, struct task_struct *,
+	   task, void *, value, u64, flags, gfp_t, gfp_flags)
+{
+	void *data;
+
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
+	if (flags & ~BPF_LOCAL_STORAGE_GET_F_CREATE || !task)
+		return (unsigned long)NULL;
+
+	if (!bpf_task_storage_trylock())
+		return (unsigned long)NULL;
+	data = __bpf_task_storage_get(map, task, value, flags,
+				      gfp_flags);
 	bpf_task_storage_unlock();
-	return IS_ERR_OR_NULL(sdata) ? (unsigned long)NULL :
-		(unsigned long)sdata->data;
+	return (unsigned long)data;
 }
 
 BPF_CALL_2(bpf_task_storage_delete_recur, struct bpf_map *, map, struct task_struct *,
-- 
2.30.2

