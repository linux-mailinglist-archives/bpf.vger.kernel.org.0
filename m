Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58516782B2
	for <lists+bpf@lfdr.de>; Mon, 23 Jan 2023 18:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbjAWRPY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Jan 2023 12:15:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbjAWRPX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Jan 2023 12:15:23 -0500
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FBF2BF38;
        Mon, 23 Jan 2023 09:15:16 -0800 (PST)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-4a2f8ad29d5so181294177b3.8;
        Mon, 23 Jan 2023 09:15:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xCvkxNfOd/aJ/4NyFm02XVnNNOSaCLc/2W9e18Wtpm0=;
        b=rSnF7pdTefxHrQUrjAJxbn7P8FuthoYjFDhf15CWDsgoJwzLKsKbCS2KXfv8s3S1ZX
         pKtPUrK6zwnIDosL8l4gw8P4a+oaq2Ep2kVvxoEMlSoFWjraf1QJjPN9XLUjrvr6xuRz
         Pv+en6w5waxzC34kJt/yAUNIveDKi+rYcYPnrZrLKsyG3onoGJTJ2M4RIq/lu86wWib6
         ZIykQu4P6kU1DkRkkPAjiuWWEr0pNrvFDO9A3/gR0/P842eqSkBTnRscUjz5Kwx7nqQH
         zwOYLXLBcQa3aNKPZ3sEYA+eYVIM2VqAf79y9AueUSy+WBgzy1hIpjLHOrLflHQuq6W/
         j7Sg==
X-Gm-Message-State: AFqh2kpGxfD2SGHhxXL9ynC85k9Eu4Ecr38WyupHNxiN9t80zQlN+sI8
        lXTgIatxXAg85u0MpYm1bzpA/2Z+tTWQ1tLP
X-Google-Smtp-Source: AMrXdXvWzH+CTAQ1y/GbMr8m5Ub22Gzcl3qEjyFt9QAyTf1n9J5yoFfxbcoZKQsoaJFkhKnIUQc9pQ==
X-Received: by 2002:a81:1b4c:0:b0:4ed:5f40:b293 with SMTP id b73-20020a811b4c000000b004ed5f40b293mr13140534ywb.1.1674494114895;
        Mon, 23 Jan 2023 09:15:14 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:93a0])
        by smtp.gmail.com with ESMTPSA id f1-20020a05620a280100b00706b6ce386fsm10889646qkp.70.2023.01.23.09.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 09:15:14 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, memxor@gmail.com
Subject: [PATCH bpf-next v2 1/3] bpf: Add BPF_KFUNC macro for defining kfuncs
Date:   Mon, 23 Jan 2023 11:15:04 -0600
Message-Id: <20230123171506.71995-2-void@manifault.com>
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

kfuncs are functions defined in the kernel, which may be invoked by BPF
programs. They may or may not also be used as regular kernel functions,
implying that they may be static (in which case the compiler could e.g.
inline it away), or it could have external linkage, but potentially be
elided in an LTO build if a function is observed to never be used, and
is stripped from the final kernel binary.

We therefore require some convenience macro that kfunc developers can
use when defining a kfunc, and which will prevent all of the above
issues from happening. This is in contrast with what we have today,
where some kfunc definitions have "noinline", some have "__used", and
others are static and have neither.

In addition to providing the obvious correctness benefits, having such a
macro also provides an easy way to query for if kfuncs, as Christoph
suggested at the kernel maintainers summit
(https://lwn.net/Articles/908464/). This is currently possible by
grepping for BTF_ID_FLAGS(func, but having something more self
describing is useful.

Note that checkpatch complains about this patch with the following:

ERROR: Macros with multiple statements should be enclosed in a do - while loop
+#define BPF_KFUNC(proto)       \
+       proto;                  \
+       __used noinline proto

Given that we're wrapping the function definition and also including its
prototype, using do { } while(0) isn't an option. Hopefully it's
therefore inappropriate to ignore the warning.

Signed-off-by: David Vernet <void@manifault.com>
---
 include/linux/btf.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 5f628f323442..593a1c2615e7 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -72,6 +72,16 @@
 #define KF_DESTRUCTIVE  (1 << 6) /* kfunc performs destructive actions */
 #define KF_RCU          (1 << 7) /* kfunc only takes rcu pointer arguments */
 
+/*
+ * Macro for defining a kfunc. This is meant to minimize the amount of
+ * copy-paste that kfunc authors have to include for correctness so as to avoid
+ * issues such as the compiler inlining or eliding either a static kfunc, or a
+ * global kfunc in an LTO build.
+ */
+#define BPF_KFUNC(proto)	\
+	proto;			\
+	__used noinline proto
+
 /*
  * Return the name of the passed struct, if exists, or halt the build if for
  * example the structure gets renamed. In this way, developers have to revisit
-- 
2.39.0

