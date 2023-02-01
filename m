Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F33686D0B
	for <lists+bpf@lfdr.de>; Wed,  1 Feb 2023 18:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbjBARbY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 12:31:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbjBARax (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 12:30:53 -0500
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A227D6CE;
        Wed,  1 Feb 2023 09:30:25 -0800 (PST)
Received: by mail-qt1-f178.google.com with SMTP id f10so4102851qtv.1;
        Wed, 01 Feb 2023 09:30:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=13KNfT/+JOQqYlkhtzi2SYuhI4+Je2/xoJvmyEaI8R4=;
        b=1WOFnItPm8cfLydzOcTpVyi9IUz47dRXzGcITOyiJapfdt1eu7KyqNWnbwezL3x45M
         UJqfTTSYa1AboaLGiBd2ETMZLmkl+/XGbkhhzlmx2YBb4hIungH6sO1fFkzoTpuot6lF
         8vpnU6qg6wJLluMmfatmpQKqRqb6WnpWT4tXa5kFr37kmz4OodWziDu0kVdZtWXY9mLA
         Gwd0t7N96Gp4Jcc75ZeEWThzXLMWFizk4oHYXyHR1+VLhhhWX7DVbFAlI/PUsJF2PqXh
         X5wZ8xrJHgnJ3LnOCkBaqSV1SsunV4Yrsi17ffNbiAcj1OB3PlrfP7FPEq3UjRykORi3
         gP7g==
X-Gm-Message-State: AO0yUKVxmuYIRivshwXv5L5u7JskZY0YG0zSOm3CdC9AVYPYmO/mpcue
        skziUDT3aMd5lIii5ii0UL2ZLyBvWq1czN7n
X-Google-Smtp-Source: AK7set8gDUM85Zrq24nQC9jG/YhLtejz6JWWARcOkU0uuhtoi0Zhn2aEqASBbHAKEz/Ct82F/dIsRg==
X-Received: by 2002:a05:622a:34e:b0:3b9:bda7:bfa7 with SMTP id r14-20020a05622a034e00b003b9bda7bfa7mr3145620qtw.40.1675272624232;
        Wed, 01 Feb 2023 09:30:24 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:1971])
        by smtp.gmail.com with ESMTPSA id x14-20020a05620a258e00b0071b368cf074sm9158367qko.118.2023.02.01.09.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 09:30:23 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, corbet@lwn.net, hch@infradead.org,
        acme@kernel.org, alan.maguire@oracle.com
Subject: [PATCH bpf-next v3 2/4] bpf: Document usage of the new __bpf_kfunc macro
Date:   Wed,  1 Feb 2023 11:30:14 -0600
Message-Id: <20230201173016.342758-3-void@manifault.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230201173016.342758-1-void@manifault.com>
References: <20230201173016.342758-1-void@manifault.com>
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

Acked-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: David Vernet <void@manifault.com>
---
 Documentation/bpf/kfuncs.rst | 20 +++++++++++++++++---
 Documentation/conf.py        |  3 +++
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 1a683225d080..0bd07b39c2a4 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -41,7 +41,7 @@ An example is given below::
         __diag_ignore_all("-Wmissing-prototypes",
                           "Global kfuncs as their definitions will be in BTF");
 
-        struct task_struct *bpf_find_get_task_by_vpid(pid_t nr)
+        __bpf_kfunc struct task_struct *bpf_find_get_task_by_vpid(pid_t nr)
         {
                 return find_get_task_by_vpid(nr);
         }
@@ -66,7 +66,7 @@ kfunc with a __tag, where tag may be one of the supported annotations.
 This annotation is used to indicate a memory and size pair in the argument list.
 An example is given below::
 
-        void bpf_memzero(void *mem, int mem__sz)
+        __bpf_kfunc void bpf_memzero(void *mem, int mem__sz)
         {
         ...
         }
@@ -86,7 +86,7 @@ safety of the program.
 
 An example is given below::
 
-        void *bpf_obj_new(u32 local_type_id__k, ...)
+        __bpf_kfunc void *bpf_obj_new(u32 local_type_id__k, ...)
         {
         ...
         }
@@ -125,6 +125,20 @@ flags on a set of kfuncs as follows::
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
+        __bpf_kfunc struct task_struct *bpf_get_task_pid(s32 pid)
+        {
+        ...
+        }
+
 2.4.1 KF_ACQUIRE flag
 ---------------------
 
diff --git a/Documentation/conf.py b/Documentation/conf.py
index d927737e3c10..8b4e5451a02d 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -116,6 +116,9 @@ if major >= 3:
 
             # include/linux/linkage.h:
             "asmlinkage",
+
+            # include/linux/btf.h
+            "__bpf_kfunc",
         ]
 
 else:
-- 
2.39.0

