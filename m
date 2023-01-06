Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28FB1660767
	for <lists+bpf@lfdr.de>; Fri,  6 Jan 2023 20:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjAFTwc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 Jan 2023 14:52:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235935AbjAFTwB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Jan 2023 14:52:01 -0500
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330D181C35;
        Fri,  6 Jan 2023 11:51:43 -0800 (PST)
Received: by mail-qt1-f178.google.com with SMTP id c7so2933928qtw.8;
        Fri, 06 Jan 2023 11:51:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZYrl92Bs5kLd8/Xn6wcvV1TfQz6dnaLpN3KH9T11XBU=;
        b=ijx1hLNR2tr+i24b/addY4gly4F91eGR03wXF5yMU5Bsdu6zJKnAIVW4V8XKmkw5G+
         1T0kMCNWcw5gET/K9S6vn99abm4Xuu/wXBBBo1bPvgbOiaQzCwi+NdlpC0xmRDqeSDbn
         9HbqiKGxGEdK/qSC9WS9QAnbTqxtZ6TuOld+dLa7N4vV4jwcvTvO4wrUtJ1mnwcugKs7
         f+gT2K9cUSFGa0x3BwaqWQEJJncLEDTEFKOwlxryzPOUXJYuaGZdR+pJ6UyAxVDaMZNU
         Jpu/188Op9/QJr9EOnMsQ+JuYfoc9cZDW7CPqlS3w+zms/iE2RDRpk8CWR3cPep1z2Pm
         e3+Q==
X-Gm-Message-State: AFqh2kroGbJA5ekYZ5Vfxa/3ewezx+foHwaKrV+/73fQkbn0aDvcvXsX
        eYV6YfAQCCSV+nbymrY8VqUrNXNB/CmocJTP
X-Google-Smtp-Source: AMrXdXusUo9vdw2WrW7QHizF1qYNpXqLAhlAvy515B3ESvpKehS+PzL5NNEQVRvVhux0Go4XFaX/2Q==
X-Received: by 2002:a05:622a:1246:b0:3a6:91f2:62bf with SMTP id z6-20020a05622a124600b003a691f262bfmr85762750qtx.37.1673034701909;
        Fri, 06 Jan 2023 11:51:41 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:a6f6])
        by smtp.gmail.com with ESMTPSA id u16-20020a05620a121000b006fa84082b6dsm980478qkj.128.2023.01.06.11.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 11:51:41 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH bpf-next 1/3] bpf: Add __bpf_kfunc tag for marking kernel functions as kfuncs
Date:   Fri,  6 Jan 2023 13:51:28 -0600
Message-Id: <20230106195130.1216841-2-void@manifault.com>
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

kfuncs are functions defined in the kernel, which may be invoked by BPF
programs. They may or may not also be used as regular kernel functions,
implying that they may be static (in which case the compiler could e.g.
inline it away), or it could have external linkage, but potentially be
elided in an LTO build if a function is observed to never be used, and
is stripped from the final kernel binary.

We therefore require some convenience macro that kfunc developers can
use just add to their kfuncs, and which will prevent all of the above
issues from happening. This is in contrast with what we have today,
where some kfunc definitions have "noinline", some have "__used", and
others are static and have neither.

In addition to providing the obvious correctness benefits, having such a
macro / tag also provides the following advantages:

- Giving an easy and intuitive thing to query for if people are looking
  for kfuncs, as Christoph suggested at the kernel maintainers summit
  (https://lwn.net/Articles/908464/). This is currently possible by
  grepping for BTF_ID_FLAGS(func, but having something more self
  describing would be useful as well.

- In the future, the tag can be expanded with other useful things such
  as the ability to suppress -Wmissing-prototype for the kfuncs rather
  than requiring developers to surround the kfunc with __diags to
  suppress the warning (this requires compiler support that as far as I
  know currently does not exist).

Note that checkpatch complains about this patch with the following:

ERROR: Macros with complex values should be enclosed in parentheses
+#define __bpf_kfunc __used noinline

There seems to be a precedent for using this pattern in other places
such as compiler_types.h (see e.g. __randomize_layout and noinstr), so
it seems appropriate.

Signed-off-by: David Vernet <void@manifault.com>
---
 include/linux/btf.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 5f628f323442..ff62fa63dc19 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -72,6 +72,14 @@
 #define KF_DESTRUCTIVE  (1 << 6) /* kfunc performs destructive actions */
 #define KF_RCU          (1 << 7) /* kfunc only takes rcu pointer arguments */
 
+/*
+ * Tag marking a kernel function as a kfunc. This is meant to minimize the
+ * amount of copy-paste that kfunc authors have to include for correctness so
+ * as to avoid issues such as the compiler inlining or eliding either a static
+ * kfunc, or a global kfunc in an LTO build.
+ */
+#define __bpf_kfunc __used noinline
+
 /*
  * Return the name of the passed struct, if exists, or halt the build if for
  * example the structure gets renamed. In this way, developers have to revisit
-- 
2.39.0

