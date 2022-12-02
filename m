Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECAC641055
	for <lists+bpf@lfdr.de>; Fri,  2 Dec 2022 23:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234771AbiLBWHr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Dec 2022 17:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234429AbiLBWHm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Dec 2022 17:07:42 -0500
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D634C12631;
        Fri,  2 Dec 2022 14:07:40 -0800 (PST)
Received: by mail-qt1-f179.google.com with SMTP id y15so7135412qtv.5;
        Fri, 02 Dec 2022 14:07:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yfSdIJlgEUCcO+cc0K2PSPr4Zaqt1pUT0K2lkmBRQSQ=;
        b=Bcl1BzShhcg44VmJfNjfN9PvjImUsZhdln7ssQ+V/ziUNdarR2tbhUYLkWkZg1G+s7
         t9JMJ4D1ENPggVcoZJ8v9pAnP3bLwJaEyOpwoSzLIxsFEz7N0AE4Txz4u6cSgoh2JeBt
         Jlp1RcXl6/B5baSwihVXFqFy323SN9kv4hRCYlvfxZC0NVpPH/zBQnktxluWD+BRNP3T
         cxN2D2DTsLGkHw2jKtwoEX+X28+X1LOJcgVaT4nySXNSxaTReSoESVUpqviDSGx29eaL
         cbAD7XFAgbkBMMd369wzFyxBdb7RRtDDgL2rR4UJbDHkXksQYUhCFWsPJckjYlKVbQZW
         oiSg==
X-Gm-Message-State: ANoB5pm6EgDiJPaMDbSMlFMwcZP4Tw7hH/vORozKOlDwHxSW9497AClY
        AVWXf7/mlKxlyHmvVllwgGRadl5YkII8dZPC
X-Google-Smtp-Source: AA0mqf5PU1xPFSsu30JUsU+Cwv7zLkWowlyiruZxoYvNBuTH6D8QzGzKhKszrZt85Vw6bZeTcd/NWw==
X-Received: by 2002:ae9:f012:0:b0:6fc:a53a:16a8 with SMTP id l18-20020ae9f012000000b006fca53a16a8mr8770712qkg.88.1670018859595;
        Fri, 02 Dec 2022 14:07:39 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:6d2e])
        by smtp.gmail.com with ESMTPSA id j10-20020ac806ca000000b003a4f22c6507sm4766155qth.48.2022.12.02.14.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 14:07:39 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH bpf-next 1/2] bpf/docs: Document struct task_struct * kfuncs
Date:   Fri,  2 Dec 2022 16:07:35 -0600
Message-Id: <20221202220736.521227-2-void@manifault.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221202220736.521227-1-void@manifault.com>
References: <20221202220736.521227-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf_task_acquire(), bpf_task_release(), bpf_task_kptr_get(), and
bpf_task_from_pid() are kfuncs that were recently added to
kernel/bpf/helpers.c. These are "core" kfuncs in that they're available
for use for any tracepoint or struct_ops BPF program. Though they have
no ABI stability guarantees, we should still document them. This patch
adds a new Core kfuncs section to the BPF kfuncs doc, and adds entries
for all of these task kfuncs.

Signed-off-by: David Vernet <void@manifault.com>
---
 Documentation/bpf/kfuncs.rst | 148 +++++++++++++++++++++++++++++++++++
 kernel/bpf/helpers.c         |   8 +-
 2 files changed, 152 insertions(+), 4 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 90774479ab7a..b0c35ad6fad4 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -213,3 +213,151 @@ type. An example is shown below::
                 return register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_task_kfunc_set);
         }
         late_initcall(init_subsystem);
+
+3. Core kfuncs
+==============
+
+The BPF subsystem provides a number of "core" kfuncs that are potentially
+applicable to a wide variety of different possible use cases and programs.
+Those kfuncs are documented here.
+
+3.1 struct task_struct * kfuncs
+-------------------------------
+
+There are a number of kfuncs that allow ``struct task_struct *`` objects to be
+used as kptrs:
+
+.. kernel-doc:: kernel/bpf/helpers.c
+   :identifiers: bpf_task_acquire bpf_task_release
+
+These kfuncs are useful when you want to acquire or release a reference to a
+``struct task_struct *`` that was passed as e.g. a tracepoint arg, or a
+struct_ops callback arg. For example:
+
+.. code-block:: c
+
+	/**
+	 * A trivial example tracepoint program that shows how to
+	 * acquire and release a struct task_struct * pointer.
+	 */
+	SEC("tp_btf/task_newtask")
+	int BPF_PROG(task_acquire_release_example, struct task_struct *task, u64 clone_flags)
+	{
+		struct task_struct *acquired;
+
+		acquired = bpf_task_acquire(task);
+
+		/*
+		 * In a typical program you'd do something like store
+		 * the task in a map. Here, we just release it.
+		 */
+		bpf_task_release(acquired);
+		return 0;
+	}
+
+If you want to acquire a reference to a ``struct task_struct`` kptr that's
+already stored in a map, you can use bpf_task_kptr_get():
+
+.. kernel-doc:: kernel/bpf/helpers.c
+   :identifiers: bpf_task_kptr_get
+
+Here's an example of how it can be used:
+
+.. code-block:: c
+
+	/* struct containing the struct task_struct kptr which is actually stored in the map. */
+	struct __tasks_kfunc_map_value {
+		struct task_struct __kptr_ref * task;
+	};
+
+	/* The map containing struct __tasks_kfunc_map_value entries. */
+	struct hash_map {
+		__uint(type, BPF_MAP_TYPE_HASH);
+		__type(key, int);
+		__type(value, struct __tasks_kfunc_map_value);
+		__uint(max_entries, 1);
+	} __tasks_kfunc_map SEC(".maps");
+
+	/* ... */
+
+	/**
+	 * A simple example tracepoint program showing how a
+	 * struct task_struct kptr that is stored in a map can
+	 * be acquired using the bpf_task_kptr_get() kfunc.
+	 */
+	 SEC("tp_btf/task_newtask")
+	 int BPF_PROG(task_kptr_get_example, struct task_struct *task, u64 clone_flags)
+	 {
+		struct task_struct *kptr;
+		struct __tasks_kfunc_map_value *v;
+		s32 pid;
+		long status;
+
+		status = bpf_probe_read_kernel(&pid, sizeof(pid), &task->pid);
+		if (status)
+			return status;
+
+		/* Assume a task kptr was previously stored in the map. */
+		v = bpf_map_lookup_elem(&__tasks_kfunc_map, &pid);
+		if (!v)
+			return -ENOENT;
+
+		/* Acquire a reference to the task kptr that's already stored in the map. */
+		kptr = bpf_task_kptr_get(&v->task);
+		if (!kptr)
+			/* If no task was present in the map, it's because
+			 * we're racing with another CPU that removed it with
+			 * bpf_kptr_xchg() between the bpf_map_lookup_elem()
+			 * above, and our call to bpf_task_kptr_get().
+			 * bpf_task_kptr_get() internally safely handles this
+			 * race, and will return NULL if the task is no longer
+			 * present in the map by the time we invoke the kfunc.
+			 */
+			return -EBUSY;
+
+		/* Free the reference we just took above. Note that the
+		 * original struct task_struct kptr is still in the map.
+		 * It will be freed either at a later time if another
+		 * context deletes it from the map, or automatically by
+		 * the BPF subsystem if it's still present when the map
+		 * is destroyed.
+		 */
+		bpf_task_release(kptr);
+
+		return 0;
+        }
+
+Finally, a BPF program can also look up a task from a pid. This can be useful
+if the caller doesn't have a trusted pointer to a ``struct task_struct *``
+object that it can acquire a reference on with bpf_task_acquire().
+
+.. kernel-doc:: kernel/bpf/helpers.c
+   :identifiers: bpf_task_from_pid
+
+Here is an example of it being used:
+
+.. code-block:: c
+
+	SEC("tp_btf/task_newtask")
+	int BPF_PROG(task_get_pid_example, struct task_struct *task, u64 clone_flags)
+	{
+		struct task_struct *lookup;
+
+		lookup = bpf_task_from_pid(task->pid);
+		if (!lookup)
+			/* A task should always be found, as %task is a tracepoint arg. */
+			return -ENOENT;
+
+		if (lookup->pid != task->pid) {
+			/* The pid of the lookup task should be the same as the input task. */
+			bpf_task_release(lookup);
+			return -EINVAL;
+		}
+
+		/* bpf_task_from_pid() returns an acquired reference,
+		 * so it must be dropped before returning from the
+		 * tracepoint handler.
+		 */
+		bpf_task_release(lookup);
+		return 0;
+	}
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index a5a511430f2a..004afbc14bbf 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1868,10 +1868,10 @@ struct task_struct *bpf_task_kptr_get(struct task_struct **pp)
 }
 
 /**
- * bpf_task_release - Release the reference acquired on a struct task_struct *.
- * If this kfunc is invoked in an RCU read region, the task_struct is
- * guaranteed to not be freed until the current grace period has ended, even if
- * its refcount drops to 0.
+ * bpf_task_release - Release the reference acquired on a task.  If this kfunc
+ * is invoked in an RCU read region, the task_struct is guaranteed to not be
+ * freed until the current grace period has ended, even if its refcount drops
+ * to 0.
  * @p: The task on which a reference is being released.
  */
 void bpf_task_release(struct task_struct *p)
-- 
2.38.1

