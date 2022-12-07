Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D623C6462D6
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 21:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiLGUvG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 15:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbiLGUub (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 15:50:31 -0500
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC8981DB8;
        Wed,  7 Dec 2022 12:49:41 -0800 (PST)
Received: by mail-qt1-f178.google.com with SMTP id r7so4524281qtx.6;
        Wed, 07 Dec 2022 12:49:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ge7ArlanrmSDH6ZAo9C+yxNluKmqau1XfrzR0bl/RY0=;
        b=XR8vEEX/1dAW/NXDUs6JLr5bOtJoL5kdDQnd32jBv3A03jNTAcfOyGXMDHUckmlV17
         FcDDeIIZX+ehzLiP9+SVR1S1r329Z8kkZ5WKw6IRCr/IOh3SP7Klsk6dlzAZXMGUE7+R
         ptP9ZklC+0G6wSBK1bkYflYxikjmNTSjzX3bGF1SPSyuIMPfaJjVIdzOrSaiAQjbTT53
         NrWLWQ1u3c/2tDH2lGXCyScJsDKBVdvyWCJzSZxQkC0MxhSu0pX3F2db0hLE2B7dmmd4
         8b2O8bGMIJzRXFSGShhKBp1waJ0gV4MrVf9HDk5+34we4hWcJd3sqzWT8v56QTbT/773
         3kPg==
X-Gm-Message-State: ANoB5pl1ASjycCFpEDB63kyrFuhB2PR0eMOfwVFHhZgD9/GkHbFO/+AT
        rE7q1rWyq+qo5gkZHVYAxzFK92+vBrlnjE56
X-Google-Smtp-Source: AA0mqf5zbsK/tT/nX9T8oJencDTpWzQWCEO1GAmeZhOT8abMtHhNR/xBPY49dsFNNobWldGoh6xmzQ==
X-Received: by 2002:ac8:6882:0:b0:3a7:e484:ebd3 with SMTP id m2-20020ac86882000000b003a7e484ebd3mr11807017qtq.285.1670446180300;
        Wed, 07 Dec 2022 12:49:40 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:629d])
        by smtp.gmail.com with ESMTPSA id y26-20020ac87c9a000000b003a7ef7a758dsm2707417qtv.59.2022.12.07.12.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 12:49:39 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH bpf-next v3 1/2] bpf/docs: Document struct task_struct * kfuncs
Date:   Wed,  7 Dec 2022 14:49:10 -0600
Message-Id: <20221207204911.873646-2-void@manifault.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221207204911.873646-1-void@manifault.com>
References: <20221207204911.873646-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf_task_acquire(), bpf_task_release(), and bpf_task_from_pid() are
kfuncs that were recently added to kernel/bpf/helpers.c. These are
"core" kfuncs in that they're available for use for any tracepoint or
struct_ops BPF program. Though they have no ABI stability guarantees, we
should still document them. This patch adds a new Core kfuncs section to
the BPF kfuncs doc, and adds entries for all of these task kfuncs.

Note that bpf_task_kptr_get() is not documented, as it still returns
NULL while we're working to resolve how it can use RCU to ensure struct
task_struct * lifetime.

Signed-off-by: David Vernet <void@manifault.com>
---
 Documentation/bpf/kfuncs.rst | 83 ++++++++++++++++++++++++++++++++++++
 kernel/bpf/helpers.c         |  2 +-
 2 files changed, 84 insertions(+), 1 deletion(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index b027fe16ee66..24ed109afc98 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -222,3 +222,86 @@ type. An example is shown below::
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
+		 * the task in a map, and the map will automatically
+		 * release it later. Here, we release it manually.
+		 */
+		bpf_task_release(acquired);
+		return 0;
+	}
+
+----
+
+A BPF program can also look up a task from a pid. This can be useful if the
+caller doesn't have a trusted pointer to a ``struct task_struct *`` object that
+it can acquire a reference on with bpf_task_acquire().
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
+			/* bpf_task_from_pid() looks up the task via its
+			 * globally-unique pid from the init_pid_ns. Thus,
+			 * the pid of the lookup task should always be the
+			 * same as the input task.
+			 */
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
index 284b3ffdbe48..1e4bf466b08f 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1904,7 +1904,7 @@ struct task_struct *bpf_task_kptr_get(struct task_struct **pp)
 }
 
 /**
- * bpf_task_release - Release the reference acquired on a struct task_struct *.
+ * bpf_task_release - Release the reference acquired on a task.
  * @p: The task on which a reference is being released.
  */
 void bpf_task_release(struct task_struct *p)
-- 
2.38.1

