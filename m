Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF1067A9D4
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 06:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbjAYFEN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 00:04:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbjAYFEM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 00:04:12 -0500
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF67474EA;
        Tue, 24 Jan 2023 21:04:11 -0800 (PST)
Received: by mail-pl1-f171.google.com with SMTP id 5so11542965plo.3;
        Tue, 24 Jan 2023 21:04:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/fu5eVF7dMpmGGWY5c48C3xPPttDeaZkjkMTCdf0Gr0=;
        b=kIi6vNhFdCUBiYn0YOepitNgdaTLqRijrHYZZC28pri4S/wFsF0Oa3UO1xksD1n3/B
         EqxEWRJ5tILyqoYNvMlIadQ/xJihozoul7Z1s5yvI9TsQimHDKs2ZztFhDdWipEE9Qij
         6PD5K+j055fw5X7ScWvsbVU0Mg5X5knE8kJRbE4vL/xo4PbqF9duvgbHXOjCJ2NFHqTU
         d50UmXWoEPwjL9kAzGiIRVQI7ZcjRyStEfiPPEUn3hLe1N7eOAOk6h3FZHtKpOH2qspI
         rJ+gNmxLKfo52tWwUufE5u/vyFicnckAL85FRwRE+CltHBOfRrVBClgFKRgcjD3YMrQn
         BwIg==
X-Gm-Message-State: AFqh2krFS3xZVg/UjxTy5zreSbTXOXdVQzUWg5XIym/tmy9dmOc6OKQM
        7AInlZ66GekIXu4vh1PcnriqZ+qTcDh+UkbS
X-Google-Smtp-Source: AMrXdXvDu37oZhSd49uMxE5+zx/xnsdSjUfXs2pVcj4mQt2QJEbT/xcu17HtaXmasC19ywfHUxxeVg==
X-Received: by 2002:a17:902:ce8f:b0:195:f3e6:ab9f with SMTP id f15-20020a170902ce8f00b00195f3e6ab9fmr21115616plg.51.1674623050295;
        Tue, 24 Jan 2023 21:04:10 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:d24a])
        by smtp.gmail.com with ESMTPSA id m9-20020a170902bb8900b001931c37da2dsm2578963pls.20.2023.01.24.21.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 21:04:09 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, tj@kernel.org
Subject: [PATCH bpf-next v3 2/4] libbpf: Support sleepable struct_ops.s section
Date:   Tue, 24 Jan 2023 23:03:57 -0600
Message-Id: <20230125050359.339273-3-void@manifault.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230125050359.339273-1-void@manifault.com>
References: <20230125050359.339273-1-void@manifault.com>
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

