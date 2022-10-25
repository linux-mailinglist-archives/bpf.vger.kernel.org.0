Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F29260D3DE
	for <lists+bpf@lfdr.de>; Tue, 25 Oct 2022 20:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbiJYSqW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Oct 2022 14:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbiJYSqM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Oct 2022 14:46:12 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF91E7C183
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 11:45:51 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1666723550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U65HfBA0C20uBOwI9V1N9lStQVA6wiJc2iT+c+d93ps=;
        b=jrPM4hwPfxJFommyFzOYiJDrlSqifQshC/JXHWyMqLha0n62qC0qVklwfohtFovkvO0Q5Y
        XveG8QonaII+xAjSWzyLtKzIaDrduskv9pInoLg2BOWiOOztruo94ZCQ3tBcSYPhEGjTDe
        usNS9X5LVFcX8BRBUfJ22UKdFUUWzmA=
From:   Martin KaFai Lau <martin.lau@linux.dev>
To:     bpf@vger.kernel.org
Cc:     'Alexei Starovoitov ' <ast@kernel.org>,
        'Andrii Nakryiko ' <andrii@kernel.org>,
        'Daniel Borkmann ' <daniel@iogearbox.net>,
        'Song Liu ' <songliubraving@meta.com>, kernel-team@meta.com
Subject: [PATCH bpf-next 6/9] bpf: bpf_task_storage_delete_recur does lookup first before the deadlock check
Date:   Tue, 25 Oct 2022 11:45:21 -0700
Message-Id: <20221025184524.3526117-7-martin.lau@linux.dev>
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

Similar to the earlier change in bpf_task_storage_get_recur.
This patch changes bpf_task_storage_delete_recur such that it
does the lookup first.  It only returns -EBUSY if it needs to
take the spinlock to do the deletion when potential deadlock
is detected.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 kernel/bpf/bpf_task_storage.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
index c3a841be438f..f3f79b618a68 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -184,7 +184,8 @@ static int bpf_pid_task_storage_update_elem(struct bpf_map *map, void *key,
 	return err;
 }
 
-static int task_storage_delete(struct task_struct *task, struct bpf_map *map)
+static int task_storage_delete(struct task_struct *task, struct bpf_map *map,
+			       bool nobusy)
 {
 	struct bpf_local_storage_data *sdata;
 
@@ -192,6 +193,9 @@ static int task_storage_delete(struct task_struct *task, struct bpf_map *map)
 	if (!sdata)
 		return -ENOENT;
 
+	if (!nobusy)
+		return -EBUSY;
+
 	bpf_selem_unlink(SELEM(sdata), true);
 
 	return 0;
@@ -220,7 +224,7 @@ static int bpf_pid_task_storage_delete_elem(struct bpf_map *map, void *key)
 	}
 
 	bpf_task_storage_lock();
-	err = task_storage_delete(task, map);
+	err = task_storage_delete(task, map, true);
 	bpf_task_storage_unlock();
 out:
 	put_pid(pid);
@@ -289,21 +293,21 @@ BPF_CALL_5(bpf_task_storage_get, struct bpf_map *, map, struct task_struct *,
 BPF_CALL_2(bpf_task_storage_delete_recur, struct bpf_map *, map, struct task_struct *,
 	   task)
 {
+	bool nobusy;
 	int ret;
 
 	WARN_ON_ONCE(!bpf_rcu_lock_held());
 	if (!task)
 		return -EINVAL;
 
-	if (!bpf_task_storage_trylock())
-		return -EBUSY;
-
+	nobusy = bpf_task_storage_trylock();
 	/* This helper must only be called from places where the lifetime of the task
 	 * is guaranteed. Either by being refcounted or by being protected
 	 * by an RCU read-side critical section.
 	 */
-	ret = task_storage_delete(task, map);
-	bpf_task_storage_unlock();
+	ret = task_storage_delete(task, map, nobusy);
+	if (nobusy)
+		bpf_task_storage_unlock();
 	return ret;
 }
 
-- 
2.30.2

