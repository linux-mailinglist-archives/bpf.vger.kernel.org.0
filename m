Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29ACF6747B7
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 00:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbjASX7b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 18:59:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjASX7L (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 18:59:11 -0500
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F6C9FDF7;
        Thu, 19 Jan 2023 15:58:49 -0800 (PST)
Received: by mail-qt1-f172.google.com with SMTP id q15so3025262qtn.0;
        Thu, 19 Jan 2023 15:58:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dq/XFjJnJiWbDVyC0d12Dhba4pfFkLwME1GhoxP6Zr4=;
        b=BNrRi02dHCwB2lv7OxFzoVLL1Sa6RE6NoVslBsDOxR2xuuA7pZGPGqISkrXF2LHiYx
         1cFDgZwR6cUBxs7mV5e5tUbEK8mPSyAbEpmViNEPdL42ZpFfTlaj8rRXsUny9VURm/CU
         Ym8irZEkOGoNkbJGqc1MUSeV2tJ44P9wIuGeGMyknF/O3ZNn600wVm4Xqox5kuzbcmf2
         H0t89MGiL934709PC7zYDpJmQTlhayoYdCEZ6JQZXigE0cWZE3eNHDdgjykMjpYjGQyQ
         6wCZM6cckZG4f29hYd8MgSB5IQKMVgdvNjKzkBBRRFntmw0533Ja6WHnDzg8ATvTFlsr
         QF0g==
X-Gm-Message-State: AFqh2kpvVMgwEw1OsaScg1Zt26jqT7+qLeN0vWGJHcV02N6HdQf+HEES
        PsislVQKDrMfxelrTfH4v0WWg0uHBPOxkCul
X-Google-Smtp-Source: AMrXdXsVxDrXoeV8LGOgsmvO7Q+4VbwzvUxEEtrRizbIH/2dc76/jZdxztBeYd3AAT4Mj/c43DVAiw==
X-Received: by 2002:ac8:6a0e:0:b0:3ab:7928:526c with SMTP id t14-20020ac86a0e000000b003ab7928526cmr16642343qtr.17.1674172727437;
        Thu, 19 Jan 2023 15:58:47 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:2fc9])
        by smtp.gmail.com with ESMTPSA id b5-20020a05620a04e500b006ee8874f5fasm24356275qkh.53.2023.01.19.15.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 15:58:46 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, tj@kernel.org
Subject: [PATCH bpf-next 7/8] bpf/docs: Document cpumask kfuncs in a new file
Date:   Thu, 19 Jan 2023 17:58:32 -0600
Message-Id: <20230119235833.2948341-8-void@manifault.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119235833.2948341-1-void@manifault.com>
References: <20230119235833.2948341-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Now that we've added a series of new cpumask kfuncs, we should document
them so users can easily use them. This patch adds a new cpumasks.rst
file to document them.

Signed-off-by: David Vernet <void@manifault.com>
---
 Documentation/bpf/cpumasks.rst | 357 +++++++++++++++++++++++++++++++++
 Documentation/bpf/index.rst    |   1 +
 Documentation/bpf/kfuncs.rst   |  11 +
 kernel/bpf/cpumask.c           | 208 +++++++++++++++++++
 4 files changed, 577 insertions(+)
 create mode 100644 Documentation/bpf/cpumasks.rst

diff --git a/Documentation/bpf/cpumasks.rst b/Documentation/bpf/cpumasks.rst
new file mode 100644
index 000000000000..ae6238965c50
--- /dev/null
+++ b/Documentation/bpf/cpumasks.rst
@@ -0,0 +1,357 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. _cpumasks-header-label:
+
+==================
+BPF cpumask kfuncs
+==================
+
+1. Introduction
+===============
+
+``struct cpumask`` is a bitmap data structure in the kernel whose indices
+reflect the CPUs on the system. Commonly, cpumasks are used to track which CPUs
+a task is affinitized to, but they can also be used to e.g. track which cores
+are associated with a scheduling domain, which cores on a machine are idle,
+etc.
+
+BPF provides programs with a set of :ref:`kfuncs-header-label` that can be
+used to allocate, mutate, query, and free cpumasks.
+
+2. BPF cpumask objects
+======================
+
+There are two different types of cpumasks that can be used by BPF programs.
+
+2.1 ``struct bpf_cpumask *``
+----------------------------
+
+``struct bpf_cpumask *`` is a cpumask that is allocated by BPF, on behalf of a
+BPF program, and whose lifecycle is entirely controlled by BPF. These cpumasks
+are RCU-protected, can be mutated, can be used as kptrs, and can be safely cast
+to a ``struct cpumask *``.
+
+2.1.1 ``struct bpf_cpumask *`` lifecycle
+----------------------------------------
+
+A ``struct bpf_cpumask *`` is allocated, acquired, and released, using the
+following functions:
+
+.. kernel-doc:: kernel/bpf/cpumask.c
+  :identifiers: bpf_cpumask_create
+
+.. kernel-doc:: kernel/bpf/cpumask.c
+  :identifiers: bpf_cpumask_acquire
+
+.. kernel-doc:: kernel/bpf/cpumask.c
+  :identifiers: bpf_cpumask_release
+
+For example:
+
+.. code-block:: c
+
+	/**
+	 * A trivial example tracepoint program that shows how to
+	 * acquire and release a struct bpf_cpumask *.
+	 */
+	SEC("tp_btf/task_newtask")
+	int BPF_PROG(task_acquire_release_example, struct task_struct *task, u64 clone_flags)
+	{
+		struct bpf_cpumask *cpumask, *acquired;
+
+		cpumask = bpf_cpumask_create();
+		if (!cpumask)
+			return 1;
+
+		acquired = bpf_cpumask_acquire(cpumask);
+		bpf_cpumask_release(cpumask);
+		bpf_cpumask_acquire(acquired);
+
+		return 0;
+	}
+
+----
+
+2.1.1 ``struct bpf_cpumask *`` as kptrs
+---------------------------------------
+
+As mentioned above, these ``struct bpf_cpumask *`` objects can also be stored
+in a map and used as kptrs. If a ``struct bpf_cpumask *`` is in a map, the
+reference can be removed from the map with bpf_kptr_xchg(), or
+opportunistically acquired with bpf_cpumask_kptr_get():
+
+
+.. kernel-doc:: kernel/bpf/cpumask.c
+  :identifiers: bpf_cpumask_kptr_get
+
+Here is an example of a ``struct bpf_cpumask *`` being retrieved from a map:
+
+.. code-block:: c
+
+	/* struct containing the struct bpf_cpumask kptr which is actually stored in the map. */
+	struct __bpf_cpumasks_kfunc_map_value {
+		struct bpf_cpumask __kptr_ref * bpf_cpumask;
+	};
+
+	/* The map containing struct __bpf_cpumasks_kfunc_map_value entries. */
+	struct {
+		__uint(type, BPF_MAP_TYPE_ARRAY);
+		__type(key, int);
+		__type(value, struct __bpf_cpumasks_kfunc_map_value);
+		__uint(max_entries, 1);
+	} __bpf_cpumasks_kfunc_map SEC(".maps");
+
+	/* ... */
+
+	/**
+	 * A simple example tracepoint program showing how a
+	 * struct bpf_cpumask * kptr that is stored in a map can
+	 * be acquired using the bpf_cpumask_kptr_get() kfunc.
+	 */
+	SEC("tp_btf/cgroup_mkdir")
+	int BPF_PROG(cgrp_ancestor_example, struct cgroup *cgrp, const char *path)
+	{
+		struct bpf_cpumask *kptr;
+		struct __bpf_cpumasks_kfunc_map_value *v;
+		u32 key = 0;
+
+		/* Assume a bpf_cpumask * kptr was previously stored in the map. */
+		v = bpf_map_lookup_elem(&__bpf_cpumasks_kfunc_map, &key);
+		if (!v)
+			return -ENOENT;
+
+		/* Acquire a reference to the bpf_cpumask * kptr that's already stored in the map. */
+		kptr = bpf_cpumask_kptr_get(&v->cpumask);
+		if (!kptr)
+			/* If no bpf_cpumask was present in the map, it's because
+			 * we're racing with another CPU that removed it with
+			 * bpf_kptr_xchg() between the bpf_map_lookup_elem()
+			 * above, and our call to bpf_cpumask_kptr_get().
+			 * bpf_cpumask_kptr_get() internally safely handles this
+			 * race, and will return NULL if the cpumask is no longer
+			 * present in the map by the time we invoke the kfunc.
+			 */
+			return -EBUSY;
+
+		/* Free the reference we just took above. Note that the
+		 * original struct bpf_cpumask * kptr is still in the map. It will
+		 * be freed either at a later time if another context deletes
+		 * it from the map, or automatically by the BPF subsystem if
+		 * it's still present when the map is destroyed.
+		 */
+		bpf_cpumask_release(kptr);
+
+		return 0;
+	}
+
+----
+
+2.2 ``struct cpumask``
+----------------------
+
+``struct cpumask`` is the object that actually contains the cpumask bitmap
+being queried, mutated, etc. A ``struct bpf_cpumask`` wraps a ``struct
+cpumask``, which is why it's safe to cast it as such (note however that it is
+**not** safe to cast a ``struct cpumask *`` to a ``struct bpf_cpumask *``, and
+the verifier will reject any program that tries to do so).
+
+As we'll see below, any kfunc that mutates its cpumask argument will take a
+``struct bpf_cpumask *`` as that argument. Any argument that simply queries the
+cpumask will instead take a ``struct cpumask *``.
+
+3. cpumask kfuncs
+=================
+
+Above, we described the kfuncs that can be used to allocate, acquire, release,
+etc a ``struct bpf_cpumask *``. This section of the document will describe the
+kfuncs for mutating and querying cpumasks.
+
+3.1 Mutating cpumasks
+---------------------
+
+Some cpumask kfuncs are "read-only" in that they don't mutate any of their
+arguments, whereas others mutate at least one argument (which means that the
+argument must be a ``struct bpf_cpumask *``, as described above).
+
+This section will describe all of the cpumask kfuncs which mutate at least one
+argument. :ref:`cpumasks-querying-label` below describes the read-only kfuncs.
+
+3.1.1 Setting and clearing CPUs
+-------------------------------
+
+bpf_cpumask_set_cpu() and bpf_cpumask_clear_cpu() can be used to set and clear
+a CPU in a ``struct bpf_cpumask`` respectively:
+
+.. kernel-doc:: kernel/bpf/cpumask.c
+   :identifiers: bpf_cpumask_set_cpu bpf_cpumask_clear_cpu
+
+These kfuncs are pretty straightforward, and can be used, for example, as
+follows:
+
+.. code-block:: c
+
+        /**
+         * A sample tracepoint showing how a cpumask can be queried.
+         */
+        SEC("tp_btf/task_newtask")
+        int BPF_PROG(test_set_clear_cpu, struct task_struct *task, u64 clone_flags)
+        {
+                struct bpf_cpumask *cpumask;
+
+                cpumask = bpf_cpumask_create();
+                if (!cpumask)
+                        return -ENOMEM;
+
+                bpf_cpumask_set_cpu(0, cpumask);
+                if (!bpf_cpumask_test_cpu(0, cast(cpumask)))
+                        /* Should never happen. */
+                        goto release_exit;
+
+                bpf_cpumask_clear_cpu(0, cpumask);
+                if (bpf_cpumask_test_cpu(0, cast(cpumask)))
+                        /* Should never happen. */
+                        goto release_exit;
+
+                /* struct cpumask * pointers such as task->cpus_ptr can also be queried. */
+                if (bpf_cpumask_test_cpu(0, task->cpus_ptr))
+                        bpf_printk("task %s can use CPU %d", task->comm, 0);
+
+                release_exit:
+                        bpf_cpumask_release(cpumask);
+                        return 0;
+        }
+
+----
+
+bpf_cpumask_test_and_set_cpu() and bpf_cpumask_test_and_clear_cpu() are
+analogous kfuncs that allow callers to atomically test and set (or clear) CPUs:
+
+.. kernel-doc:: kernel/bpf/cpumask.c
+   :identifiers: bpf_cpumask_test_and_set_cpu bpf_cpumask_test_and_clear_cpu
+
+----
+
+We can also set and clear entire ``struct bpf_cpumask *`` objects in one
+operation using bpf_cpumask_setall() and bpf_cpumask_clear():
+
+.. kernel-doc:: kernel/bpf/cpumask.c
+   :identifiers: bpf_cpumask_setall bpf_cpumask_clear
+
+3.1.2 Operations between cpumasks
+---------------------------------
+
+In addition to setting and clearing individual CPUs in a single cpumask,
+callers can also perform bitwise operations between multiple cpumasks using
+bpf_cpumask_and(), bpf_cpumask_or(), and bpf_cpumask_xor():
+
+.. kernel-doc:: kernel/bpf/cpumask.c
+   :identifiers: bpf_cpumask_and bpf_cpumask_or bpf_cpumask_xor
+
+The following is an example of how they may be used. Note that some of the
+kfuncs shown in this example will be covered in more detail below.
+
+.. code-block:: c
+
+        /**
+         * A sample tracepoint showing how a cpumask can be mutated using
+           bitwise operators (and queried).
+         */
+        SEC("tp_btf/task_newtask")
+        int BPF_PROG(test_set_clear_cpu, struct task_struct *task, u64 clone_flags)
+        {
+                struct bpf_cpumask *mask1, *mask2, *dst1, *dst2;
+                int ret = -EINVAL;
+
+                mask1 = bpf_cpumask_create();
+                if (!mask1)
+                        return -ENOMEM;
+
+                mask2 = bpf_cpumask_create();
+                if (!mask2) {
+                        bpf_cpumask_release(mask1);
+                        return -ENOMEM;
+                }
+
+                // ...Safely create the other two masks... */
+
+                bpf_cpumask_set_cpu(0, mask1);
+                bpf_cpumask_set_cpu(1, mask2);
+                bpf_cpumask_and(dst1, (const struct cpumask *)mask1, (const struct cpumask *)mask2);
+                if (!bpf_cpumask_empty((const struct cpumask *)dst1))
+                        /* Should never happen. */
+                        goto release_exit;
+
+                bpf_cpumask_or(dst1, (const struct cpumask *)mask1, (const struct cpumask *)mask2);
+                if (!bpf_cpumask_test_cpu(0, (const struct cpumask *)dst1))
+                        /* Should never happen. */
+                        goto release_exit;
+
+                if (!bpf_cpumask_test_cpu(1, (const struct cpumask *)dst1))
+                        /* Should never happen. */
+                        goto release_exit;
+
+                bpf_cpumask_xor(dst2, (const struct cpumask *)mask1, (const struct cpumask *)mask2);
+                if (!bpf_cpumask_equal((const struct cpumask *)dst1,
+                                       (const struct cpumask *)dst2))
+                        /* Should never happen. */
+                        goto release_exit;
+
+                err = 0;
+
+         release_exit:
+                bpf_cpumask_release(mask1);
+                bpf_cpumask_release(mask2);
+                bpf_cpumask_release(dst1);
+                bpf_cpumask_release(dst2);
+                return 0;
+        }
+
+----
+
+The contents of an entire cpumask may be copied to another using
+bpf_cpumask_copy():
+
+.. kernel-doc:: kernel/bpf/cpumask.c
+   :identifiers: bpf_cpumask_copy
+
+----
+
+.. _cpumasks-querying-label:
+
+3.2 Querying cpumasks
+---------------------
+
+In addition to the above kfuncs, there is also a set of read-only kfuncs that
+can be used to query the contents of cpumasks.
+
+.. kernel-doc:: kernel/bpf/cpumask.c
+   :identifiers: bpf_cpumask_first bpf_cpumask_first_zero bpf_cpumask_test_cpu
+
+.. kernel-doc:: kernel/bpf/cpumask.c
+   :identifiers: bpf_cpumask_equal bpf_cpumask_intersects bpf_cpumask_subset
+                 bpf_cpumask_empty bpf_cpumask_full
+
+.. kernel-doc:: kernel/bpf/cpumask.c
+   :identifiers: bpf_cpumask_any bpf_cpumask_any_and
+
+----
+
+Some example usages of these querying kfuncs were shown above. We will not
+replicate those exmaples here. Note, however, that all of the aforementioned
+kfuncs are tested in `tools/testing/selftests/bpf/progs/cpumask_success.c`_, so
+please take a look there if you're looking for more examples of how they can be
+used.
+
+.. _tools/testing/selftests/bpf/progs/cpumask_success.c:
+   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/tools/testing/selftests/bpf/progs/cpumask_success.c
+
+
+4. Adding BPF cpumask kfuncs
+============================
+
+The set of supported BPF cpumask kfuncs are not (yet) a 1-1 match with the
+cpumask operations in include/linux/cpumask.h. Any of those cpumask operations
+could easily be encapsulated in a new kfunc if and when required. If you'd like
+to support a new cpumask operation, please feel free to submit a patch. If you
+do add a new cpumask kfunc, please document it here, and add any relevant
+selftest testcases to the cpumask selftest suite.
diff --git a/Documentation/bpf/index.rst b/Documentation/bpf/index.rst
index b81533d8b061..dbb39e8f9889 100644
--- a/Documentation/bpf/index.rst
+++ b/Documentation/bpf/index.rst
@@ -20,6 +20,7 @@ that goes into great technical depth about the BPF Architecture.
    syscall_api
    helpers
    kfuncs
+   cpumasks
    programs
    maps
    bpf_prog_run
diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 9fd7fb539f85..a74f9e74087b 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -1,3 +1,7 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. _kfuncs-header-label:
+
 =============================
 BPF Kernel Functions (kfuncs)
 =============================
@@ -420,3 +424,10 @@ the verifier. bpf_cgroup_ancestor() can be used as follows:
 		bpf_cgroup_release(parent);
 		return 0;
 	}
+
+3.3 struct cpumask * kfuncs
+---------------------------
+
+BPF provides a set of kfuncs that can be used to query, allocate, mutate, and
+destroy struct cpumask * objects. Please refer to :ref:`cpumasks-header-label`
+for more details.
diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
index e1fa15a7e079..91fdd07ee9fc 100644
--- a/kernel/bpf/cpumask.c
+++ b/kernel/bpf/cpumask.c
@@ -35,6 +35,16 @@ static bool cpu_valid(u32 cpu)
 	return cpu < nr_cpu_ids;
 }
 
+/**
+ * bpf_cpumask_create() - Create a mutable BPF cpumask.
+ *
+ * Allocates a cpumask that can be queried, mutated, acquired, and released by
+ * a BPF program. The cpumask returned by this function must either be embedded
+ * in a map as a kptr, or freed with bpf_cpumask_release().
+ *
+ * bpf_cpumask_create() allocates memory using the BPF memory allocator, and
+ * will not block. It may return NULL if no memory is available.
+ */
 struct bpf_cpumask *bpf_cpumask_create(void)
 {
 	struct bpf_cpumask *cpumask;
@@ -49,12 +59,31 @@ struct bpf_cpumask *bpf_cpumask_create(void)
 	return cpumask;
 }
 
+/**
+ * bpf_cpumask_acquire() - Acquire a reference to a BPF cpumask.
+ * @cpumask: The BPF cpumask being acquired. The cpumask must be a trusted
+ *	     pointer.
+ *
+ * Acquires a reference to a BPF cpumask. The cpumask returned by this function
+ * must either be embedded in a map as a kptr, or freed with
+ * bpf_cpumask_release().
+ */
 struct bpf_cpumask *bpf_cpumask_acquire(struct bpf_cpumask *cpumask)
 {
 	refcount_inc(&cpumask->usage);
 	return cpumask;
 }
 
+/**
+ * bpf_cpumask_kptr_get() - Attempt to acquire a reference to a BPF cpumask
+ *			    stored in a map.
+ * @cpumaskp: A pointer to a BPF cpumask map value.
+ *
+ * Attempts to acquire a reference to a BPF cpumask stored in a map value. The
+ * cpumask returned by this function must either be embedded in a map as a
+ * kptr, or freed with bpf_cpumask_release(). This function may return NULL if
+ * no BPF cpumask was found in the specified map value.
+ */
 struct bpf_cpumask *bpf_cpumask_kptr_get(struct bpf_cpumask **cpumaskp)
 {
 	struct bpf_cpumask *cpumask;
@@ -73,6 +102,14 @@ struct bpf_cpumask *bpf_cpumask_kptr_get(struct bpf_cpumask **cpumaskp)
 	return cpumask;
 }
 
+/**
+ * bpf_cpumask_release() - Release a previously acquired BPF cpumask.
+ * @cpumask: The cpumask being released.
+ *
+ * Releases a previously acquired reference to a BPF cpumask. When the final
+ * reference of the BPF cpumask has been released, it is subsequently freed in
+ * an RCU callback in the BPF memory allocator.
+ */
 void bpf_cpumask_release(struct bpf_cpumask *cpumask)
 {
 	if (!cpumask)
@@ -85,16 +122,36 @@ void bpf_cpumask_release(struct bpf_cpumask *cpumask)
 	}
 }
 
+/**
+ * bpf_cpumask_first() - Get the index of the first nonzero bit in the cpumask.
+ * @cpumask: The cpumask being queried.
+ *
+ * Find the index of the first nonzero bit of the cpumask. A struct bpf_cpumask
+ * pointer may be safely passed to this function.
+ */
 u32 bpf_cpumask_first(const struct cpumask *cpumask)
 {
 	return cpumask_first(cpumask);
 }
 
+/**
+ * bpf_cpumask_first_zero() - Get the index of the first unset bit in the
+ *			      cpumask.
+ * @cpumask: The cpumask being queried.
+ *
+ * Find the index of the first unset bit of the cpumask. A struct bpf_cpumask
+ * pointer may be safely passed to this function.
+ */
 u32 bpf_cpumask_first_zero(const struct cpumask *cpumask)
 {
 	return cpumask_first_zero(cpumask);
 }
 
+/**
+ * bpf_cpumask_set_cpu() - Set a bit for a CPU in a BPF cpumask.
+ * @cpu: The CPU to be set in the cpumask.
+ * @cpumask: The BPF cpumask in which a bit is being set.
+ */
 void bpf_cpumask_set_cpu(u32 cpu, struct bpf_cpumask *cpumask)
 {
 	if (!cpu_valid(cpu))
@@ -103,6 +160,11 @@ void bpf_cpumask_set_cpu(u32 cpu, struct bpf_cpumask *cpumask)
 	cpumask_set_cpu(cpu, (struct cpumask *)cpumask);
 }
 
+/**
+ * bpf_cpumask_clear_cpu() - Clear a bit for a CPU in a BPF cpumask.
+ * @cpu: The CPU to be cleared from the cpumask.
+ * @cpumask: The BPF cpumask in which a bit is being cleared.
+ */
 void bpf_cpumask_clear_cpu(u32 cpu, struct bpf_cpumask *cpumask)
 {
 	if (!cpu_valid(cpu))
@@ -111,6 +173,15 @@ void bpf_cpumask_clear_cpu(u32 cpu, struct bpf_cpumask *cpumask)
 	cpumask_clear_cpu(cpu, (struct cpumask *)cpumask);
 }
 
+/**
+ * bpf_cpumask_test_cpu() - Test whether a CPU is set in a cpumask.
+ * @cpu: The CPU being queried for.
+ * @cpumask: The cpumask being queried for containing a CPU.
+ *
+ * Return:
+ * * true  - @cpu is set in the cpumask
+ * * false - @cpu was not set in the cpumask, or @cpu is an invalid cpu.
+ */
 bool bpf_cpumask_test_cpu(u32 cpu, const struct cpumask *cpumask)
 {
 	if (!cpu_valid(cpu))
@@ -119,6 +190,15 @@ bool bpf_cpumask_test_cpu(u32 cpu, const struct cpumask *cpumask)
 	return cpumask_test_cpu(cpu, (struct cpumask *)cpumask);
 }
 
+/**
+ * bpf_cpumask_test_and_set_cpu() - Atomically test and set a CPU in a BPF cpumask.
+ * @cpu: The CPU being set and queried for.
+ * @cpumask: The BPF cpumask being set and queried for containing a CPU.
+ *
+ * Return:
+ * * true  - @cpu is set in the cpumask
+ * * false - @cpu was not set in the cpumask, or @cpu is invalid.
+ */
 bool bpf_cpumask_test_and_set_cpu(u32 cpu, struct bpf_cpumask *cpumask)
 {
 	if (!cpu_valid(cpu))
@@ -127,6 +207,16 @@ bool bpf_cpumask_test_and_set_cpu(u32 cpu, struct bpf_cpumask *cpumask)
 	return cpumask_test_and_set_cpu(cpu, (struct cpumask *)cpumask);
 }
 
+/**
+ * bpf_cpumask_test_and_clear_cpu() - Atomically test and clear a CPU in a BPF
+ *				      cpumask.
+ * @cpu: The CPU being cleared and queried for.
+ * @cpumask: The BPF cpumask being cleared and queried for containing a CPU.
+ *
+ * Return:
+ * * true  - @cpu is set in the cpumask
+ * * false - @cpu was not set in the cpumask, or @cpu is invalid.
+ */
 bool bpf_cpumask_test_and_clear_cpu(u32 cpu, struct bpf_cpumask *cpumask)
 {
 	if (!cpu_valid(cpu))
@@ -135,16 +225,36 @@ bool bpf_cpumask_test_and_clear_cpu(u32 cpu, struct bpf_cpumask *cpumask)
 	return cpumask_test_and_clear_cpu(cpu, (struct cpumask *)cpumask);
 }
 
+/**
+ * bpf_cpumask_setall() - Set all of the bits in a BPF cpumask.
+ * @cpumask: The BPF cpumask having all of its bits set.
+ */
 void bpf_cpumask_setall(struct bpf_cpumask *cpumask)
 {
 	cpumask_setall((struct cpumask *)cpumask);
 }
 
+/**
+ * bpf_cpumask_clear() - Clear all of the bits in a BPF cpumask.
+ * @cpumask: The BPF cpumask being cleared.
+ */
 void bpf_cpumask_clear(struct bpf_cpumask *cpumask)
 {
 	cpumask_clear((struct cpumask *)cpumask);
 }
 
+/**
+ * bpf_cpumask_and() - AND two cpumasks and store the result.
+ * @dst: The BPF cpumask where the result is being stored.
+ * @src1: The first input.
+ * @src2: The second input.
+ *
+ * Return:
+ * * true  - @dst has at least one bit set following the operation
+ * * false - @dst is empty following the operation
+ *
+ * struct bpf_cpumask pointers may be safely passed to @src1 and @src2.
+ */
 bool bpf_cpumask_and(struct bpf_cpumask *dst,
 		     const struct cpumask *src1,
 		     const struct cpumask *src2)
@@ -152,6 +262,14 @@ bool bpf_cpumask_and(struct bpf_cpumask *dst,
 	return cpumask_and((struct cpumask *)dst, src1, src2);
 }
 
+/**
+ * bpf_cpumask_or() - OR two cpumasks and store the result.
+ * @dst: The BPF cpumask where the result is being stored.
+ * @src1: The first input.
+ * @src2: The second input.
+ *
+ * struct bpf_cpumask pointers may be safely passed to @src1 and @src2.
+ */
 void bpf_cpumask_or(struct bpf_cpumask *dst,
 		    const struct cpumask *src1,
 		    const struct cpumask *src2)
@@ -159,6 +277,14 @@ void bpf_cpumask_or(struct bpf_cpumask *dst,
 	cpumask_or((struct cpumask *)dst, src1, src2);
 }
 
+/**
+ * bpf_cpumask_xor() - XOR two cpumasks and store the result.
+ * @dst: The BPF cpumask where the result is being stored.
+ * @src1: The first input.
+ * @src2: The second input.
+ *
+ * struct bpf_cpumask pointers may be safely passed to @src1 and @src2.
+ */
 void bpf_cpumask_xor(struct bpf_cpumask *dst,
 		     const struct cpumask *src1,
 		     const struct cpumask *src2)
@@ -166,41 +292,123 @@ void bpf_cpumask_xor(struct bpf_cpumask *dst,
 	cpumask_xor((struct cpumask *)dst, src1, src2);
 }
 
+/**
+ * bpf_cpumask_equal() - Check two cpumasks for equality.
+ * @src1: The first input.
+ * @src2: The second input.
+ *
+ * Return:
+ * * true   - @src1 and @src2 have the same bits set.
+ * * false  - @src1 and @src2 differ in at least one bit.
+ *
+ * struct bpf_cpumask pointers may be safely passed to @src1 and @src2.
+ */
 bool bpf_cpumask_equal(const struct cpumask *src1, const struct cpumask *src2)
 {
 	return cpumask_equal(src1, src2);
 }
 
+/**
+ * bpf_cpumask_intersects() - Check two cpumasks for overlap.
+ * @src1: The first input.
+ * @src2: The second input.
+ *
+ * Return:
+ * * true   - @src1 and @src2 have at least one of the same bits set.
+ * * false  - @src1 and @src2 don't have any of the same bits set.
+ *
+ * struct bpf_cpumask pointers may be safely passed to @src1 and @src2.
+ */
 bool bpf_cpumask_intersects(const struct cpumask *src1, const struct cpumask *src2)
 {
 	return cpumask_intersects(src1, src2);
 }
 
+/**
+ * bpf_cpumask_subset() - Check if a cpumask is a subset of another.
+ * @src1: The first cpumask being checked as a subset.
+ * @src2: The second cpumask being checked as a superset.
+ *
+ * Return:
+ * * true   - All of the bits of @src1 are set in @src2.
+ * * false  - At least one bit in @src1 is not set in @src2.
+ *
+ * struct bpf_cpumask pointers may be safely passed to @src1 and @src2.
+ */
 bool bpf_cpumask_subset(const struct cpumask *src1, const struct cpumask *src2)
 {
 	return cpumask_subset(src1, src2);
 }
 
+/**
+ * bpf_cpumask_empty() - Check if a cpumask is empty.
+ * @cpumask: The cpumask being checked.
+ *
+ * Return:
+ * * true   - None of the bits in @cpumask are set.
+ * * false  - At least one bit in @cpumask is set.
+ *
+ * A struct bpf_cpumask pointer may be safely passed to @cpumask.
+ */
 bool bpf_cpumask_empty(const struct cpumask *cpumask)
 {
 	return cpumask_empty(cpumask);
 }
 
+/**
+ * bpf_cpumask_full() - Check if a cpumask has all bits set.
+ * @cpumask: The cpumask being checked.
+ *
+ * Return:
+ * * true   - All of the bits in @cpumask are set.
+ * * false  - At least one bit in @cpumask is cleared.
+ *
+ * A struct bpf_cpumask pointer may be safely passed to @cpumask.
+ */
 bool bpf_cpumask_full(const struct cpumask *cpumask)
 {
 	return cpumask_full(cpumask);
 }
 
+/**
+ * bpf_cpumask_copy() - Copy the contents of a cpumask into a BPF cpumask.
+ * @dst: The BPF cpumask being copied into.
+ * @src: The cpumask being copied.
+ *
+ * A struct bpf_cpumask pointer may be safely passed to @src.
+ */
 void bpf_cpumask_copy(struct bpf_cpumask *dst, const struct cpumask *src)
 {
 	cpumask_copy((struct cpumask *)dst, src);
 }
 
+/**
+ * bpf_cpumask_any() - Return a random set CPU from a cpumask.
+ * @cpumask: The cpumask being queried.
+ *
+ * Return:
+ * * A random set bit within [0, num_cpus) if at least one bit is set.
+ * * >= num_cpus if no bit is set.
+ *
+ * A struct bpf_cpumask pointer may be safely passed to @src.
+ */
 u32 bpf_cpumask_any(const struct cpumask *cpumask)
 {
 	return cpumask_any(cpumask);
 }
 
+/**
+ * bpf_cpumask_any_and() - Return a random set CPU from the AND of two
+ *			   cpumasks.
+ * @src1: The first cpumask.
+ * @src2: The second cpumask.
+ *
+ * Return:
+ * * A random set bit within [0, num_cpus) if at least one bit is set.
+ * * >= num_cpus if no bit is set.
+ *
+ * struct bpf_cpumask pointers may be safely passed to @src1 and @src2.
+ */
 u32 bpf_cpumask_any_and(const struct cpumask *src1, const struct cpumask *src2)
 {
 	return cpumask_any_and(src1, src2);
-- 
2.39.0

