Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2125B67F889
	for <lists+bpf@lfdr.de>; Sat, 28 Jan 2023 15:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbjA1OPo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 28 Jan 2023 09:15:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233962AbjA1OPo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 28 Jan 2023 09:15:44 -0500
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5837222E5;
        Sat, 28 Jan 2023 06:15:42 -0800 (PST)
Received: by mail-qt1-f182.google.com with SMTP id o5so6375383qtr.11;
        Sat, 28 Jan 2023 06:15:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RGvJt1CIXlJpnOyOHccjEzuYOqE3E3OGNf/JWtRVof0=;
        b=hwd7whjt/yGdxQC2L6JOM5CHlyoY5+CrcsQNzvd33/IOGD2UuAr6dt/ZeaeU0JVVpm
         WKVSp6Bv1yUT9eN9NiQOj/CMoJhtnmmUYnBLb4tNKdESYoCuSLcso0R8Ldj9l8rf6FmT
         mS1AfwDJbP2euZ86dtySJS/fSZlelipiefjyTQCphxzywTHEbtRivKM/9tbdUz5WMgTW
         E5qBrxEiVjFXKax9niAOgG9JS/Xk2niu+Aj+WAPeJmvdq4AUj46JujVul4tuPHYuFIub
         cNFs9t3vUUtVNaiyfogsfxhLye9lIGk3EEYnQh3swczlgT15CfOFiF9nN7giSvd6n/ut
         72Gg==
X-Gm-Message-State: AFqh2koHKx4Dg/DQG8rk2qhhvJ8lj/kHr2roxiMhKs02rqlr4PLWQ9ww
        YhLkyhZOfAnr+VuOnfUC3EtBiP8s8eI6v8v7
X-Google-Smtp-Source: AMrXdXtGrYWS4a1ZtoG0OGekQz4cKcpJVVVNL5OeN7OZSdOBHH5kPdReLeNAonJLZc4SK5h5FJoiZA==
X-Received: by 2002:ac8:6bd2:0:b0:3b2:2195:e2a2 with SMTP id b18-20020ac86bd2000000b003b22195e2a2mr61632690qtt.45.1674915341076;
        Sat, 28 Jan 2023 06:15:41 -0800 (PST)
Received: from localhost ([24.1.27.177])
        by smtp.gmail.com with ESMTPSA id f8-20020ac840c8000000b003b84b92052asm515845qtm.57.2023.01.28.06.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jan 2023 06:15:40 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH bpf-next] bpf: Build-time assert that cpumask offset is zero
Date:   Sat, 28 Jan 2023 08:15:37 -0600
Message-Id: <20230128141537.100777-1-void@manifault.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The first element of a struct bpf_cpumask is a cpumask_t. This is done
to allow struct bpf_cpumask to be cast to a struct cpumask. If this
element were ever moved to another field, any BPF program passing a
struct bpf_cpumask * to a kfunc expecting a const struct cpumask * would
immediately fail to load. Add a build-time assertion so this is
assumption is captured and verified.

Signed-off-by: David Vernet <void@manifault.com>
---
 kernel/bpf/cpumask.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
index 25355a0a367a..6bbb67dfc998 100644
--- a/kernel/bpf/cpumask.c
+++ b/kernel/bpf/cpumask.c
@@ -52,6 +52,9 @@ struct bpf_cpumask *bpf_cpumask_create(void)
 {
 	struct bpf_cpumask *cpumask;
 
+	/* cpumask must be the first element so struct bpf_cpumask be cast to struct cpumask. */
+	BUILD_BUG_ON(offsetof(struct bpf_cpumask, cpumask) != 0);
+
 	cpumask = bpf_mem_alloc(&bpf_cpumask_ma, sizeof(*cpumask));
 	if (!cpumask)
 		return NULL;
-- 
2.39.0

