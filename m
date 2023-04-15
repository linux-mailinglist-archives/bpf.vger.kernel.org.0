Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58ED86E3094
	for <lists+bpf@lfdr.de>; Sat, 15 Apr 2023 12:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjDOKcq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 15 Apr 2023 06:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjDOKcn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 15 Apr 2023 06:32:43 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F185583;
        Sat, 15 Apr 2023 03:32:42 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id a23so16908865qtj.8;
        Sat, 15 Apr 2023 03:32:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681554761; x=1684146761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bsE9U0MMwp7wZrIbIbCM0Lvuc4kI+kVHJ8gjGciCgfw=;
        b=WgWD0mXMRbzHmvxltHOK9pGEDT0epNt1+sOywJQfwypk9XSn/E+av0Fb1BMPbBLCyq
         5D5M7MTTZzTiJ9n4Ow+6rGStQvjGV/Z7msCi2PJTQQbYYny/WlJd36zn2aWAKh99pk5F
         K6+29tXKUk5aZu0MkQLi0GvquiHJW3UcxKMNK+lob/bpYMQY6xlcD85WRFufLl/JLM2S
         E/imqB3AjT43NFltZVTmyGoXsJtLNGB9b+Eaqn46FwiyMAOVP70ERmphdVGZHq8aApC/
         FsoyNiphXUogBhOv+kqbgBJqChcD/qxPB9Pd50GUcvaRqXwh1IEd18f6k5LYv/kd5u6m
         IIXg==
X-Gm-Message-State: AAQBX9fvi2139KJOoVp4UA6b4uAlqyn6WJ8G4pWbp7uJlxsypw3tZFdw
        376Dv0vBoW+055CGJPkXErsDtwUQvijUQ1+uhAE=
X-Google-Smtp-Source: AKy350aQG49NMz/3L6zMLlF1OewBXa5TMpMehsFIP0Z8mRB0xr6cUpXBsN7jToGFl1BKPoRi+OZTyw==
X-Received: by 2002:ac8:5a0a:0:b0:3e8:b9a0:babf with SMTP id n10-20020ac85a0a000000b003e8b9a0babfmr13293626qta.12.1681554760689;
        Sat, 15 Apr 2023 03:32:40 -0700 (PDT)
Received: from localhost ([24.1.27.177])
        by smtp.gmail.com with ESMTPSA id j13-20020a05620a288d00b0073b8745fd39sm1827669qkp.110.2023.04.15.03.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 03:32:40 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, memxor@gmail.com
Subject: [PATCH bpf-next 3/3] bpf,docs: Remove KF_KPTR_GET from documentation
Date:   Sat, 15 Apr 2023 05:32:31 -0500
Message-Id: <20230415103231.236063-4-void@manifault.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230415103231.236063-1-void@manifault.com>
References: <20230415103231.236063-1-void@manifault.com>
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

A prior patch removed KF_KPTR_GET from the kernel. Now that it's no
longer accessible to kfunc authors, this patch removes it from the BPF
kfunc documentation.

Signed-off-by: David Vernet <void@manifault.com>
---
 Documentation/bpf/kfuncs.rst | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 3b42cfe12437..ea2516374d92 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -184,16 +184,7 @@ in. All copies of the pointer being released are invalidated as a result of
 invoking kfunc with this flag. KF_RELEASE kfuncs automatically receive the
 protection afforded by the KF_TRUSTED_ARGS flag described below.
 
-2.4.4 KF_KPTR_GET flag
-----------------------
-
-The KF_KPTR_GET flag is used to indicate that the kfunc takes the first argument
-as a pointer to kptr, safely increments the refcount of the object it points to,
-and returns a reference to the user. The rest of the arguments may be normal
-arguments of a kfunc. The KF_KPTR_GET flag should be used in conjunction with
-KF_ACQUIRE and KF_RET_NULL flags.
-
-2.4.5 KF_TRUSTED_ARGS flag
+2.4.4 KF_TRUSTED_ARGS flag
 --------------------------
 
 The KF_TRUSTED_ARGS flag is used for kfuncs taking pointer arguments. It
@@ -205,7 +196,7 @@ exception described below).
 There are two types of pointers to kernel objects which are considered "valid":
 
 1. Pointers which are passed as tracepoint or struct_ops callback arguments.
-2. Pointers which were returned from a KF_ACQUIRE or KF_KPTR_GET kfunc.
+2. Pointers which were returned from a KF_ACQUIRE kfunc.
 
 Pointers to non-BTF objects (e.g. scalar pointers) may also be passed to
 KF_TRUSTED_ARGS kfuncs, and may have a non-zero offset.
@@ -232,13 +223,13 @@ In other words, you must:
 2. Specify the type and name of the trusted nested field. This field must match
    the field in the original type definition exactly.
 
-2.4.6 KF_SLEEPABLE flag
+2.4.5 KF_SLEEPABLE flag
 -----------------------
 
 The KF_SLEEPABLE flag is used for kfuncs that may sleep. Such kfuncs can only
 be called by sleepable BPF programs (BPF_F_SLEEPABLE).
 
-2.4.7 KF_DESTRUCTIVE flag
+2.4.6 KF_DESTRUCTIVE flag
 --------------------------
 
 The KF_DESTRUCTIVE flag is used to indicate functions calling which is
@@ -247,7 +238,7 @@ rebooting or panicking. Due to this additional restrictions apply to these
 calls. At the moment they only require CAP_SYS_BOOT capability, but more can be
 added later.
 
-2.4.8 KF_RCU flag
+2.4.7 KF_RCU flag
 -----------------
 
 The KF_RCU flag is a weaker version of KF_TRUSTED_ARGS. The kfuncs marked with
@@ -260,7 +251,7 @@ also be KF_RET_NULL.
 
 .. _KF_deprecated_flag:
 
-2.4.9 KF_DEPRECATED flag
+2.4.8 KF_DEPRECATED flag
 ------------------------
 
 The KF_DEPRECATED flag is used for kfuncs which are scheduled to be
-- 
2.40.0

