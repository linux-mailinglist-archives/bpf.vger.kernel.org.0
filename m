Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCB167B72F
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 17:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235668AbjAYQrr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 11:47:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235653AbjAYQrp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 11:47:45 -0500
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0691540D8;
        Wed, 25 Jan 2023 08:47:45 -0800 (PST)
Received: by mail-qt1-f173.google.com with SMTP id s4so16449992qtx.6;
        Wed, 25 Jan 2023 08:47:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/fu5eVF7dMpmGGWY5c48C3xPPttDeaZkjkMTCdf0Gr0=;
        b=wNpoY2n+4DsfrQ9AjqljcGc3+4BZxaC+YvoNLxjQ3X+ePDRJNT5wgwJ7pn7I0p3BWr
         tCXhLfYI5RaHiS2TVhAouwR0CGPs7IY1SpFoiQhXfHoMWSZ8nBnFbJ8kl5rPaw3rsI8X
         q87bi2SP+rDfR10Vi/2JamBE0oxzxqTvJizPt7gdP5IpqJZbUwyxSXDr5SylY1yc2T0W
         tOa7tadoiykz2t4YY3cbhCeF4prwzar8HdZk2/xdyBMzii7RkB5c6Vi622UamBQ7Q8f+
         VNS5tZYRpYJaLlP+KcOk1YJJvU2WvSUlzdLxR3hZphhq0dH7tno2oKfViQY+A3i97nEn
         pXDg==
X-Gm-Message-State: AO0yUKVqMHBWuH2AzmxMNNQFMnkaBzUz3ZRs8f6wc5Fh4kAVhPODJk7V
        7JyC9Ax1wAuOox30MYBYU4+uqf2XIFSeuWnE
X-Google-Smtp-Source: AK7set89XLlO2EFbSFY81FMbJuZE9/Fh9FJJSzxHIzB5EjHXdDjyJJOJrQxf4VNANhOrO7/e0q/JOQ==
X-Received: by 2002:ac8:5c0f:0:b0:3b6:38cf:1277 with SMTP id i15-20020ac85c0f000000b003b638cf1277mr5384935qti.64.1674665263814;
        Wed, 25 Jan 2023 08:47:43 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:113e])
        by smtp.gmail.com with ESMTPSA id j129-20020a378787000000b00706a1551428sm3859774qkd.6.2023.01.25.08.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 08:47:43 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, tj@kernel.org
Subject: [PATCH bpf-next v4 2/4] libbpf: Support sleepable struct_ops.s section
Date:   Wed, 25 Jan 2023 10:47:33 -0600
Message-Id: <20230125164735.785732-3-void@manifault.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230125164735.785732-1-void@manifault.com>
References: <20230125164735.785732-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In a prior change, the verifier was updated to support sleepable
BPF_PROG_TYPE_STRUCT_OPS programs. A caller could set the program as
sleepable with bpf_program__set_flags(), but it would be more ergonomic
and more in-line with other sleepable program types if we supported
suffixing a struct_ops section name with .s to indicate that it's
sleepable.

Signed-off-by: David Vernet <void@manifault.com>
---
 tools/lib/bpf/libbpf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 27d9faa80471..eed5cec6f510 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8605,6 +8605,7 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("cgroup/setsockopt",	CGROUP_SOCKOPT, BPF_CGROUP_SETSOCKOPT, SEC_ATTACHABLE),
 	SEC_DEF("cgroup/dev",		CGROUP_DEVICE, BPF_CGROUP_DEVICE, SEC_ATTACHABLE_OPT),
 	SEC_DEF("struct_ops+",		STRUCT_OPS, 0, SEC_NONE),
+	SEC_DEF("struct_ops.s+",	STRUCT_OPS, 0, SEC_SLEEPABLE),
 	SEC_DEF("sk_lookup",		SK_LOOKUP, BPF_SK_LOOKUP, SEC_ATTACHABLE),
 };
 
-- 
2.39.0

