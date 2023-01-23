Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263226782B3
	for <lists+bpf@lfdr.de>; Mon, 23 Jan 2023 18:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbjAWRP0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Jan 2023 12:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233403AbjAWRPY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Jan 2023 12:15:24 -0500
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA1F2C675;
        Mon, 23 Jan 2023 09:15:17 -0800 (PST)
Received: by mail-vs1-f53.google.com with SMTP id 187so13645753vsv.10;
        Mon, 23 Jan 2023 09:15:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qwfyXOwnFjSLejeyuihpTx6+nDSKI2AEDITjv1M4Kjs=;
        b=pwNSlB/mR/9/9aryavTNxExoS9X3Fvqn7A9vZGfbNKzq3X1IP17l87MwjOz4njG8FZ
         qqOlHZMkfOcMmSEBTMdsrSwxcQabD7qwufCnPOfXx4021kqZVq6gQ+QefVH274WH4um6
         wvodPuwwuPKtj6ZrIC82aSkgH92pS1X9534Eg26EvAfNdFDhyuQbhOFn/ytNdNnPel5t
         7bbzRFP1EaF088O9m9ZpzV7dqa9g+x1308qH9fBJdNPOmwznlmLhr++fuijJwj1cbVlV
         px9511Y3j0ESAfsopjUyGCIoUfvEqUslEk5nBWazhDvn7dXVGFrscbm5IB30oPGL1BYN
         VuyA==
X-Gm-Message-State: AFqh2koataQIDEuj/PqHjRdOQ1hKTdk2I8cf6pdHD1Xo4AKm6EjMSxYx
        8t3CeX0OKhJVs8JeTnPU9zWjGGaEyIQgvgnj
X-Google-Smtp-Source: AMrXdXtROEP40fg4oY1pAvXEDVNW4RTiR/0tqbXveNNBsW4y/WW0e8cn1c2GcKMHdg9E5h60YJJihw==
X-Received: by 2002:a05:6102:34d0:b0:3ce:dbc0:5a6d with SMTP id a16-20020a05610234d000b003cedbc05a6dmr15218951vst.21.1674494116451;
        Mon, 23 Jan 2023 09:15:16 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:93a0])
        by smtp.gmail.com with ESMTPSA id w26-20020a05620a0e9a00b006fa22f0494bsm12217724qkm.117.2023.01.23.09.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 09:15:16 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, memxor@gmail.com
Subject: [PATCH bpf-next v2 2/3] bpf: Document usage of the new BPF_KFUNC macro
Date:   Mon, 23 Jan 2023 11:15:05 -0600
Message-Id: <20230123171506.71995-3-void@manifault.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230123171506.71995-1-void@manifault.com>
References: <20230123171506.71995-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Now that the BPF_KFUNC macro has been added to linux/btf.h, include a
description of how to use it in the kfuncs.rst file. Along the way, do
some cleanup of kfuncs.rst which allows the description to be more
cleanly integrated into the doc.

Signed-off-by: David Vernet <void@manifault.com>
---
 Documentation/bpf/kfuncs.rst | 93 +++++++++++++++++++-----------------
 1 file changed, 50 insertions(+), 43 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 9fd7fb539f85..372f65aa87f7 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -14,55 +14,56 @@ kernel.
 2. Defining a kfunc
 ===================
 
-There are two ways to expose a kernel function to BPF programs, either make an
-existing function in the kernel visible, or add a new wrapper for BPF. In both
-cases, care must be taken that BPF program can only call such function in a
-valid context. To enforce this, visibility of a kfunc can be per program type.
+There are two ways to expose a kernel function to BPF programs: either make an
+existing function in the kernel visible, or add a new function that is only
+invoked from BPF. In both cases, care must be taken that BPF program can only
+call the function in a valid context. To enforce this, attributes may be set on
+a kfunc which inform the verifier of how the kfunc should be invoked in order
+to ensure safety. Additionally, when kfuncs are first registered, they are
+registered for a specific program type.
+
+2.1 Using BPF_KFUNC macro
+-------------------------
+
+When defining a kfunc, always wrap its signature in the ``BPF_KFUNC`` macro.
+This macro adds the necessary attributes to prevent the compiler from
+optimizing away dead code, as some kfuncs may not be invoked anywhere in the
+kernel itself, or may e.g. be removed in LTO builds. If an additional
+annotation is required to prevent such an issue with your kfunc, it is likely a
+bug and should be added to the definition of the macro so that other kfuncs are
+similarly protected. This macro also provides an easy way to grep for kfunc
+definitions.
+
+An example is given below:
 
-If you are not creating a BPF wrapper for existing kernel function, skip ahead
-to :ref:`BPF_kfunc_nodef`.
-
-2.1 Creating a wrapper kfunc
-----------------------------
-
-When defining a wrapper kfunc, the wrapper function should have extern linkage.
-This prevents the compiler from optimizing away dead code, as this wrapper kfunc
-is not invoked anywhere in the kernel itself. It is not necessary to provide a
-prototype in a header for the wrapper kfunc.
-
-An example is given below::
-
-        /* Disables missing prototype warnings */
-        __diag_push();
-        __diag_ignore_all("-Wmissing-prototypes",
-                          "Global kfuncs as their definitions will be in BTF");
+.. code-block:: c
 
-        struct task_struct *bpf_find_get_task_by_vpid(pid_t nr)
+        BPF_KFUNC(void bpf_memzero(void *mem, int mem__sz))
         {
-                return find_get_task_by_vpid(nr);
+        ...
         }
 
-        __diag_pop();
-
-A wrapper kfunc is often needed when we need to annotate parameters of the
-kfunc. Otherwise one may directly make the kfunc visible to the BPF program by
-registering it with the BPF subsystem. See :ref:`BPF_kfunc_nodef`.
+It is not necessary to provide a prototype in a header for a kfunc (the macro
+also takes care of this), though you may provide one if the kfunc is invoked
+elsewhere in the main kernel.
 
 2.2 Annotating kfunc parameters
 -------------------------------
 
-Similar to BPF helpers, there is sometime need for additional context required
-by the verifier to make the usage of kernel functions safer and more useful.
-Hence, we can annotate a parameter by suffixing the name of the argument of the
-kfunc with a __tag, where tag may be one of the supported annotations.
+Similar to BPF helpers, the verifier sometimes requires additional context to
+make the usage of kernel functions safer and more useful.  Hence, we can
+annotate a parameter by suffixing the name of the argument of the kfunc with a
+__tag, where tag may be one of the following supported annotations.
 
 2.2.1 __sz Annotation
 ---------------------
 
 This annotation is used to indicate a memory and size pair in the argument list.
-An example is given below::
+An example is given below:
+
+.. code-block:: c
 
-        void bpf_memzero(void *mem, int mem__sz)
+        BPF_KFUNC(void bpf_memzero(void *mem, int mem__sz))
         {
         ...
         }
@@ -80,9 +81,11 @@ the verifier must check the scalar argument to be a known constant, which does
 not indicate a size parameter, and the value of the constant is relevant to the
 safety of the program.
 
-An example is given below::
+An example is given below:
+
+.. code-block:: c
 
-        void *bpf_obj_new(u32 local_type_id__k, ...)
+        BPF_KFUNC(void *bpf_obj_new(u32 local_type_id__k, ...))
         {
         ...
         }
@@ -96,8 +99,6 @@ Hence, whenever a constant scalar argument is accepted by a kfunc which is not a
 size parameter, and the value of the constant matters for program safety, __k
 suffix should be used.
 
-.. _BPF_kfunc_nodef:
-
 2.3 Using an existing kernel function
 -------------------------------------
 
@@ -109,17 +110,21 @@ and whether it is safe to do so.
 2.4 Annotating kfuncs
 ---------------------
 
-In addition to kfuncs' arguments, verifier may need more information about the
+In addition to kfunc arguments, verifier may need more information about the
 type of kfunc(s) being registered with the BPF subsystem. To do so, we define
-flags on a set of kfuncs as follows::
+flags on a set of kfuncs as follows:
+
+.. code-block:: c
 
         BTF_SET8_START(bpf_task_set)
         BTF_ID_FLAGS(func, bpf_get_task_pid, KF_ACQUIRE | KF_RET_NULL)
         BTF_ID_FLAGS(func, bpf_put_pid, KF_RELEASE)
+        BTF_ID_FLAGS(func, bpf_task_is_kthread) /* Flags are optional */
         BTF_SET8_END(bpf_task_set)
 
-This set encodes the BTF ID of each kfunc listed above, and encodes the flags
-along with it. Ofcourse, it is also allowed to specify no flags.
+This set encodes the BTF ID of each kfunc listed above, along with an optional
+set of flags which provide context to the verifier about how the kfunc should
+be invoked.
 
 2.4.1 KF_ACQUIRE flag
 ---------------------
@@ -205,7 +210,9 @@ into consideration.
 
 Once the kfunc is prepared for use, the final step to making it visible is
 registering it with the BPF subsystem. Registration is done per BPF program
-type. An example is shown below::
+type. An example is shown below:
+
+.. code-block:: c
 
         BTF_SET8_START(bpf_task_set)
         BTF_ID_FLAGS(func, bpf_get_task_pid, KF_ACQUIRE | KF_RET_NULL)
-- 
2.39.0

