Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E3A60D3DC
	for <lists+bpf@lfdr.de>; Tue, 25 Oct 2022 20:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbiJYSqS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Oct 2022 14:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbiJYSqL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Oct 2022 14:46:11 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7E66D85E
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 11:45:47 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1666723545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mYqDFUp3qEFv/Og4QdrUPNe1D2znr6G+dC04OZPmTB8=;
        b=Cr33Je17hB4Gm+r9Ged+Fa9Unx7UWLuhNQmnQJhKTXO8/jIZXkS61Gx2XJXlfbOlIAiBMY
        7wqXPVu9oX/JwtcdSMn9DfvOp9dgUhw5P6/gomZtJjEMJ84yI4XOEfxnKNPHDtY0DW3BaJ
        5GVwNj8b6R+E95NACC+C+VZOoD9RhT0=
From:   Martin KaFai Lau <martin.lau@linux.dev>
To:     bpf@vger.kernel.org
Cc:     'Alexei Starovoitov ' <ast@kernel.org>,
        'Andrii Nakryiko ' <andrii@kernel.org>,
        'Daniel Borkmann ' <daniel@iogearbox.net>,
        'Song Liu ' <songliubraving@meta.com>, kernel-team@meta.com
Subject: [PATCH bpf-next 4/9] bpf: Avoid taking spinlock in bpf_task_storage_get if potential deadlock is detected
Date:   Tue, 25 Oct 2022 11:45:19 -0700
Message-Id: <20221025184524.3526117-5-martin.lau@linux.dev>
In-Reply-To: <20221025184524.3526117-1-martin.lau@linux.dev>
References: <20221025184524.3526117-1-martin.lau@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Martin KaFai Lau <martin.lau@kernel.org>

bpf_task_storage_get() does a lookup and optionally inserts
new data if BPF_LOCAL_STORAGE_GET_F_CREATE is present.

During lookup, it will cache the lookup result and caching requires to
acquire a spinlock.  When potential deadlock is detected (by the
bpf_task_storage_busy pcpu-counter added in
commit bc235cdb423a ("bpf: Prevent deadlock from recursive bpf_task_storage_[get|delete]")),
the current behavior is returning NULL immediately to avoid deadlock.  It is
too pessimistic.  This patch will go ahead to do a lookup (which is a
lockless operation) but it will avoid caching it in order to avoid
acquiring the spinlock.

When lookup fails to find the data and BPF_LOCAL_STORAGE_GET_F_CREATE
is set, an insertion is needed and this requires acquiring a spinlock.
This patch will still return NULL when a potential deadlock is detected.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 kernel/bpf/bpf_local_storage.c |  1 +
 kernel/bpf/bpf_task_storage.c  | 15 ++++++++-------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 9dc6de1cf185..781d14167140 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -242,6 +242,7 @@ void bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool use_trace_rcu)
 	__bpf_selem_unlink_storage(selem, use_trace_rcu);
 }
 
+/* If cacheit_lockit is false, this lookup function is lockless */
 struct bpf_local_storage_data *
 bpf_local_storage_lookup(struct bpf_local_storage *local_storage,
 			 struct bpf_local_storage_map *smap,
diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
index 2726435e3eda..bc52bc8b59f7 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -230,17 +230,17 @@ static int bpf_pid_task_storage_delete_elem(struct bpf_map *map, void *key)
 /* Called by bpf_task_storage_get*() helpers */
 static void *__bpf_task_storage_get(struct bpf_map *map,
 				    struct task_struct *task, void *value,
-				    u64 flags, gfp_t gfp_flags)
+				    u64 flags, gfp_t gfp_flags, bool nobusy)
 {
 	struct bpf_local_storage_data *sdata;
 
-	sdata = task_storage_lookup(task, map, true);
+	sdata = task_storage_lookup(task, map, nobusy);
 	if (sdata)
 		return sdata->data;
 
 	/* only allocate new storage, when the task is refcounted */
 	if (refcount_read(&task->usage) &&
-	    (flags & BPF_LOCAL_STORAGE_GET_F_CREATE)) {
+	    (flags & BPF_LOCAL_STORAGE_GET_F_CREATE) && nobusy) {
 		sdata = bpf_local_storage_update(
 			task, (struct bpf_local_storage_map *)map, value,
 			BPF_NOEXIST, gfp_flags);
@@ -254,17 +254,18 @@ static void *__bpf_task_storage_get(struct bpf_map *map,
 BPF_CALL_5(bpf_task_storage_get_recur, struct bpf_map *, map, struct task_struct *,
 	   task, void *, value, u64, flags, gfp_t, gfp_flags)
 {
+	bool nobusy;
 	void *data;
 
 	WARN_ON_ONCE(!bpf_rcu_lock_held());
 	if (flags & ~BPF_LOCAL_STORAGE_GET_F_CREATE || !task)
 		return (unsigned long)NULL;
 
-	if (!bpf_task_storage_trylock())
-		return (unsigned long)NULL;
+	nobusy = bpf_task_storage_trylock();
 	data = __bpf_task_storage_get(map, task, value, flags,
-				      gfp_flags);
-	bpf_task_storage_unlock();
+				      gfp_flags, nobusy);
+	if (nobusy)
+		bpf_task_storage_unlock();
 	return (unsigned long)data;
 }
 
-- 
2.30.2

