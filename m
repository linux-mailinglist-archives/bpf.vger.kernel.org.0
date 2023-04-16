Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7076E3640
	for <lists+bpf@lfdr.de>; Sun, 16 Apr 2023 10:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbjDPIts (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 16 Apr 2023 04:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjDPItm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 16 Apr 2023 04:49:42 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60524A4;
        Sun, 16 Apr 2023 01:49:41 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id e3so10572920qtm.12;
        Sun, 16 Apr 2023 01:49:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681634980; x=1684226980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bsE9U0MMwp7wZrIbIbCM0Lvuc4kI+kVHJ8gjGciCgfw=;
        b=l+9EFTz6hfRyKCsz0WE0Z2OgDEbn75dOQJKBJZG4KBDuC5Dhg7z7c3ZbNDvilLqQ2x
         WzeMXcXdJucfT9s5n4o1Hp5NgmLiF+XYXWHOjQxCxlV8rDVSC2qgX0mF0qY8J+UUKigE
         pM9LNZQ+gOHfPHF/fAbxdcR+fhFThyOQTY/+wnHRGQhvAmNkhS8Q1Ysvck51GIBByUMI
         Lu9n4BE4sGQyOjYc2jkhrbtJB05u6SmlY9gPMcz2NxmuZgjBlg+jo0TxtHuEy4G+hY6f
         R6+UC+FJIa3RPGuZmJjP3Co/6dHwwImdmH5XaoboGFRYFqTv0M3DVa8sJHdLNOYNVPD0
         MaxA==
X-Gm-Message-State: AAQBX9fy2lqNwYrZi/O66vpLKokgAIw4ywRWe4tH6U79Hy1vfdkH+WQ9
        5UIiruCCif7sxQB+59ApovU3Irmdaf3gjcEjE7C08g==
X-Google-Smtp-Source: AKy350YDg4GE2SDrWaZTVd0wP5z9LzyzFhFukoi1IIYrsdmO+3TvEtXD0gQnEB+0bypZRLbEbsXABg==
X-Received: by 2002:a05:622a:1056:b0:3e6:332a:70db with SMTP id f22-20020a05622a105600b003e6332a70dbmr18558382qte.37.1681634980093;
        Sun, 16 Apr 2023 01:49:40 -0700 (PDT)
Received: from localhost ([24.1.27.177])
        by smtp.gmail.com with ESMTPSA id d17-20020a05620a205100b0074d673f1b47sm645582qka.31.2023.04.16.01.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 01:49:39 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, memxor@gmail.com
Subject: [PATCH bpf-next v2 3/3] bpf,docs: Remove KF_KPTR_GET from documentation
Date:   Sun, 16 Apr 2023 03:49:28 -0500
Message-Id: <20230416084928.326135-4-void@manifault.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230416084928.326135-1-void@manifault.com>
References: <20230416084928.326135-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

