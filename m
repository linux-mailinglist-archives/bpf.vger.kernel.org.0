Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCA4675DFA
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 20:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjATT0C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 14:26:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbjATTZw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 14:25:52 -0500
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E88DB7B2;
        Fri, 20 Jan 2023 11:25:41 -0800 (PST)
Received: by mail-qt1-f173.google.com with SMTP id fd15so4929552qtb.9;
        Fri, 20 Jan 2023 11:25:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=szLEwMFPNAUcOlQXjDN9W13GrrQRzdrtWVVmponsE0I=;
        b=rg0K5vLlJ1/duQCEdGhTRWDn8hSn4CMh5fQIqVkuFZhJi5A3vYVKb+lCKtQhZsuF4B
         8k97URDwpmd52xvHS4IipjEDYjMx0m+EGLI8MBBpBirYp5/pVuDi9h72aBKzT5mAi7rb
         CoIz5dSa3wPqd0Nt8iBPPVrTw3HV9ZqnXs/HE0Vk9JoWg5gl+n+EN5azOPwL7nsyvGhb
         UGy3l9EjT8ijU4bryL4IypbOz4yOcDS5R6w9JTcgwwsfYDQG/gnCjdEH4FWavdOGTpcf
         cYNzZ2cca/GVKWwI0ibhbKO+/PdLID24o9jEov6YcSCyUGnlitZJf7wZeQhoyPtVvKBK
         2xJw==
X-Gm-Message-State: AFqh2komDKBTUgiiPVW7IEz8LJu4W/32RG7FXi6J0dEyhyjnDlGRLk7z
        cHDU4RqVOQ2tZjTXmc5px6OIptD21N7WSD68
X-Google-Smtp-Source: AMrXdXv7Y85Ukwu8PZzKZVTLrrczBz2d2iHtjpto6gc8Y1KcWTDUAGXAVu6V8+IL550ygOe5rXy8pQ==
X-Received: by 2002:a05:622a:1c15:b0:3b6:8d71:fd2b with SMTP id bq21-20020a05622a1c1500b003b68d71fd2bmr11406552qtb.48.1674242739803;
        Fri, 20 Jan 2023 11:25:39 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:2fc9])
        by smtp.gmail.com with ESMTPSA id bw5-20020a05622a098500b003b64f1b1f40sm4451070qtb.40.2023.01.20.11.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 11:25:39 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, tj@kernel.org, memxor@gmail.com
Subject: [PATCH bpf-next v2 8/9] bpf/docs: Document how nested trusted fields may be defined
Date:   Fri, 20 Jan 2023 13:25:22 -0600
Message-Id: <20230120192523.3650503-9-void@manifault.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230120192523.3650503-1-void@manifault.com>
References: <20230120192523.3650503-1-void@manifault.com>
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

A prior change defined a new BTF_TYPE_SAFE_NESTED macro in the verifier
which allows developers to specify when a pointee field in a struct type
should inherit its parent pointer's trusted status. This patch updates
the kfuncs documentation to specify this macro and how it can be used.

Signed-off-by: David Vernet <void@manifault.com>
---
 Documentation/bpf/kfuncs.rst | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index a74f9e74087b..560f4ede3a9f 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -167,7 +167,8 @@ KF_ACQUIRE and KF_RET_NULL flags.
 The KF_TRUSTED_ARGS flag is used for kfuncs taking pointer arguments. It
 indicates that the all pointer arguments are valid, and that all pointers to
 BTF objects have been passed in their unmodified form (that is, at a zero
-offset, and without having been obtained from walking another pointer).
+offset, and without having been obtained from walking another pointer, with one
+exception described below).
 
 There are two types of pointers to kernel objects which are considered "valid":
 
@@ -180,6 +181,25 @@ KF_TRUSTED_ARGS kfuncs, and may have a non-zero offset.
 The definition of "valid" pointers is subject to change at any time, and has
 absolutely no ABI stability guarantees.
 
+As mentioned above, a nested pointer obtained from walking a trusted pointer is
+no longer trusted, with one exception. If a struct type has a field that is
+guaranteed to be valid as long as its parent pointer is trusted, the
+``BTF_TYPE_SAFE_NESTED`` macro can be used to express that to the verifier as
+follows:
+
+.. code-block:: c
+
+	BTF_TYPE_SAFE_NESTED(struct task_struct) {
+		const cpumask_t *cpus_ptr;
+	};
+
+In other words, you must:
+
+1. Wrap the trusted pointer type in the ``BTF_TYPE_SAFE_NESTED`` macro.
+
+2. Specify the type and name of the trusted nested field. This field must match
+   the field in the original type definition exactly.
+
 2.4.6 KF_SLEEPABLE flag
 -----------------------
 
-- 
2.39.0

