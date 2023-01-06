Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA261660769
	for <lists+bpf@lfdr.de>; Fri,  6 Jan 2023 20:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235906AbjAFTwf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 Jan 2023 14:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235994AbjAFTwD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Jan 2023 14:52:03 -0500
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB3B81C1D;
        Fri,  6 Jan 2023 11:51:57 -0800 (PST)
Received: by mail-qt1-f181.google.com with SMTP id h21so2873118qta.12;
        Fri, 06 Jan 2023 11:51:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o3WKTTzsyF9L2n4exaUQ4PHJBY01kVHiqjVWVsJVBG0=;
        b=FCUce9fEDg3+GBzQ3Rdh02QiRMZgUaFjYs+ralx5WOBgsapj54xpcYwELpmbdm+rDA
         hNJR1ZD2eBEc2elw7qrHj+C7EoDxdojvsSdH1b3N5MHIUcu6EQFCDEu4oRpdUEU/dlIU
         3V637r67GMUNNEGuu87TGBNd2mRBIGWpDz7flmDQJLHaZGemDTAPhW9Wdaz4zepkKn2u
         IiPykBzgcuMWG9RAvsFu58srahljcf2KMqTWLwYWVMKo2NXo+vQHOk/0NWrKxlwdzW32
         FH9DAyjepQJGr/zee++wC4di1lgHVlgCqT4lsCpq4xGD+ngaKyTO+4wU/gsYRg5xnYjE
         J7hg==
X-Gm-Message-State: AFqh2koX1pnCmmN40rWBFzmIkVObOdSwCJDjEMlKZaJ48zjIbAJg3ddz
        NuSD3eGVUOr3mZ38FdcLry+CYQ0aN0dK1bwk
X-Google-Smtp-Source: AMrXdXsYyLpAUUow0P5Us2Ts478k3vTXZ+/RPhhERBIm0XwDI4XJMcfjcW2cRMGQIoRYreAaZIJ6nA==
X-Received: by 2002:ac8:5646:0:b0:3a7:f599:220e with SMTP id 6-20020ac85646000000b003a7f599220emr86787123qtt.55.1673034716529;
        Fri, 06 Jan 2023 11:51:56 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:a6f6])
        by smtp.gmail.com with ESMTPSA id e124-20020a37b582000000b0070495934152sm993606qkf.48.2023.01.06.11.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 11:51:56 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH bpf-next 2/3] bpf: Document usage of the new __bpf_kfunc macro
Date:   Fri,  6 Jan 2023 13:51:31 -0600
Message-Id: <20230106195130.1216841-3-void@manifault.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230106195130.1216841-1-void@manifault.com>
References: <20230106195130.1216841-1-void@manifault.com>
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

Now that the __bpf_kfunc macro has been added to linux/btf.h, include a
blurb about it in the kfuncs.rst file. In order for the macro to
successfully render with .. kernel-doc, we'll also need to add it to the
c_id_attributes array.

Signed-off-by: David Vernet <void@manifault.com>
---
 Documentation/bpf/kfuncs.rst | 18 ++++++++++++++++++
 Documentation/conf.py        |  3 +++
 2 files changed, 21 insertions(+)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 9fd7fb539f85..900f6b96487c 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -37,6 +37,7 @@ An example is given below::
         __diag_ignore_all("-Wmissing-prototypes",
                           "Global kfuncs as their definitions will be in BTF");
 
+        __bpf_kfunc
         struct task_struct *bpf_find_get_task_by_vpid(pid_t nr)
         {
                 return find_get_task_by_vpid(nr);
@@ -62,6 +63,7 @@ kfunc with a __tag, where tag may be one of the supported annotations.
 This annotation is used to indicate a memory and size pair in the argument list.
 An example is given below::
 
+        __bpf_kfunc
         void bpf_memzero(void *mem, int mem__sz)
         {
         ...
@@ -82,6 +84,7 @@ safety of the program.
 
 An example is given below::
 
+        __bpf_kfunc
         void *bpf_obj_new(u32 local_type_id__k, ...)
         {
         ...
@@ -121,6 +124,21 @@ flags on a set of kfuncs as follows::
 This set encodes the BTF ID of each kfunc listed above, and encodes the flags
 along with it. Ofcourse, it is also allowed to specify no flags.
 
+kfunc definitions should also always be annotated with the ``__bpf_kfunc``
+macro. This prevents issues such as the compiler inlining the kfunc if it's a
+static kernel function, or the function being elided in an LTO build as it's
+not used in the rest of the kernel. Developers should not manually add
+annotations to their kfunc to prevent these issues. If an annotation is
+required to prevent such an issue with your kfunc, it is a bug and should be
+added to the definition of the macro so that other kfuncs are similarly
+protected. An example is given below::
+
+        __bpf_kfunc
+        struct task_struct *bpf_get_task_pid(s32 pid)
+        {
+        ...
+        }
+
 2.4.1 KF_ACQUIRE flag
 ---------------------
 
diff --git a/Documentation/conf.py b/Documentation/conf.py
index a5c45df0bd83..05ff3186b243 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -110,6 +110,9 @@ if major >= 3:
 
             # include/linux/linkage.h:
             "asmlinkage",
+
+            # include/linux/btf.h
+            "__bpf_kfunc",
         ]
 
 else:
-- 
2.39.0

