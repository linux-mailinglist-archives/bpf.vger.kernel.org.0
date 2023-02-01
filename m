Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0264686D09
	for <lists+bpf@lfdr.de>; Wed,  1 Feb 2023 18:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbjBARbU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 12:31:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbjBARaw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 12:30:52 -0500
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0088977DFB;
        Wed,  1 Feb 2023 09:30:23 -0800 (PST)
Received: by mail-qt1-f174.google.com with SMTP id v17so7838807qto.3;
        Wed, 01 Feb 2023 09:30:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GMUIMRDtOkpySHrb7MIScjLqI4hTvf6fpXHhnvoXlBE=;
        b=MYAvEWUZkns0jkI7JFb8JHm9eUtgrNYCNMZ9nSA2pVNO3XXxmDrOze2o6KQmIXvRYC
         HoeSWJfJTCJL0BFDhnks2dEXdeSQP5AUrNu0M+QUKNcHr1A8mKVVhJLti0vBBErcKhFD
         su+ibMK/uG+wq1APIJWp3CowiKlfKFyop53wiHtP3dSiJbeSmVZ23Ra0+BTzHkw2zk1W
         8lD42FQgq9bRYp924ddBQFRHJwL/LK8QWvGOxzqysknm2rn4a7c0d/FJIyJ7HYpCRbKY
         C2aLfiacPMx0rEwEzpvlQErT1gfQzx3SPe8gb7wBR3y+ETenBiTxteA0c4pzovEOXyZy
         qc8Q==
X-Gm-Message-State: AO0yUKUxmQGoAx6TyUQe1sIVnUFCYLtEUKzM0+eYaN8HEDM05EsVzQBV
        FBOiMsoyRGMKwIlvdydwma/WtpqZWFmcnNQj
X-Google-Smtp-Source: AK7set9rYUVj4S4C0wdhWMBG3uZmYLE2xShbzvtUp+gUlin5sskcAlCzDUQ8IPHB0oO4e6U2RcwXBQ==
X-Received: by 2002:a05:622a:607:b0:3b8:330c:c966 with SMTP id z7-20020a05622a060700b003b8330cc966mr4541813qta.51.1675272622538;
        Wed, 01 Feb 2023 09:30:22 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:1971])
        by smtp.gmail.com with ESMTPSA id hh5-20020a05622a618500b0039cc0fbdb61sm12002744qtb.53.2023.02.01.09.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 09:30:22 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, corbet@lwn.net, hch@infradead.org,
        acme@kernel.org, alan.maguire@oracle.com
Subject: [PATCH bpf-next v3 1/4] bpf: Add __bpf_kfunc tag for marking kernel functions as kfuncs
Date:   Wed,  1 Feb 2023 11:30:13 -0600
Message-Id: <20230201173016.342758-2-void@manifault.com>
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

kfuncs are functions defined in the kernel, which may be invoked by BPF
programs. They may or may not also be used as regular kernel functions,
implying that they may be static (in which case the compiler could e.g.
inline it away, or elide one or more arguments), or it could have
external linkage, but potentially be elided in an LTO build if a
function is observed to never be used, and is stripped from the final
kernel binary.

This has already resulted in some issues, such as those discussed in [0]
wherein changes in DWARF that identify when a parameter has been
optimized out can break BTF encodings (and in general break the kfunc).

[0]: https://lore.kernel.org/all/1675088985-20300-2-git-send-email-alan.maguire@oracle.com/

We therefore require some convenience macro that kfunc developers can
use just add to their kfuncs, and which will prevent all of the above
issues from happening. This is in contrast with what we have today,
where some kfunc definitions have "noinline", some have "__used", and
others are static and have neither.

Note that longer term, this mechanism may be replaced by a macro that
more closely resembles EXPORT_SYMBOL_GPL(), as described in [1]. For
now, we're going with this shorter-term approach to fix existing issues
in kfuncs.

[1]: https://lore.kernel.org/lkml/Y9AFT4pTydKh+PD3@maniforge.lan/

Note as well that checkpatch complains about this patch with the
following:

ERROR: Macros with complex values should be enclosed in parentheses
+#define __bpf_kfunc __used noinline

There seems to be a precedent for using this pattern in other places
such as compiler_types.h (see e.g. __randomize_layout and noinstr), so
it seems appropriate.

Acked-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: David Vernet <void@manifault.com>
---
 include/linux/btf.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index e9b90d9c3569..49e0fe6d8274 100644
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

