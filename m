Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B5269F01E
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 09:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjBVIYh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 03:24:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjBVIYg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 03:24:36 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6616E30B14
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 00:24:35 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id z10so4782417ple.6
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 00:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ntjc1AG7bS/NZwMi6SdezQQErnVKK3wkQNeZ1LjsKAk=;
        b=TcLEWNbJBNf5ZFkb4nP9BWfg1+PJbQUj3EZ9dX49ySrRedEOo3VATf0ck/p5J20M7s
         ydPU/elb0EEJKqGu2A1qrgKM4VztYWKunfJIMorpgXUkNZ3SzFtaPRstBawWMkufopSQ
         y1HVIrTgkguFLlKJ8yETBqQib35Tfw3I3cU7f0gUG3JloQmmCyvpKnPtM++DY9Jl6BSK
         bGJYmSW01Yh9fpA9S3erjpV0SYClF3qx+v6UsUM9I7TtuCoZ7W/V7vuC3sWisNw0YJy4
         BHNsRxH2lH9ngN5PoKFCsgh3AJhJiK0cgghEx0NwvR4CJhkru4v/qWCKcy7r9pW2iwHz
         eYmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ntjc1AG7bS/NZwMi6SdezQQErnVKK3wkQNeZ1LjsKAk=;
        b=MEkP+Au9a70EXzr8bExybPAFcoujAQih3D/GnRLSsy21fGNVSZ4cBkXhq6phArq41D
         LbO9HEQZw5LCfTbVDcHjagQY8EqW4dm9J9kF9GuO5VLjt9hGKpSSgO//oSlVHcqvOzhD
         op/QoW4j6AsIpwdurMp+fww/3tASSbYlyXr5TfsBbk0RxZ/7YVntSdmVO5rwZI3PJaUS
         O1QSUSwpZKL8sC1I+EW6PhspquNLZ3uwBzUK1DeVAo8rEOKBqmOB8qcAc7n7QdkWcyfv
         AfbloQ66ESaMedw3vREi69vMQeQvbT274yq29fa3IuFzdnqhRF4j6FRRBL7HaSmH5Gsi
         KcuQ==
X-Gm-Message-State: AO0yUKUmBmHQO2sHPS7bFDzegvz+v31aYFDMuaIjKoukg/vBxt5VhiV5
        r+mjTFSIgKrIw77M/aEEgbKNhg==
X-Google-Smtp-Source: AK7set/BQ4/3js1DOgao1/ohxjXlwWMNW/T4wHiUuE50HYmjz45J+v6/R7Wztgr7KBqL4sjp15oYRg==
X-Received: by 2002:a05:6a21:6d9f:b0:c7:8779:4168 with SMTP id wl31-20020a056a216d9f00b000c787794168mr8779993pzb.62.1677054274808;
        Wed, 22 Feb 2023 00:24:34 -0800 (PST)
Received: from localhost ([122.172.83.155])
        by smtp.gmail.com with ESMTPSA id k22-20020aa792d6000000b0058bcb42dd1asm3801283pfa.111.2023.02.22.00.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 00:24:34 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] bpf: Fix undeclared function 'barrier_nospec' warning
Date:   Wed, 22 Feb 2023 13:54:31 +0530
Message-Id: <9c476aa64c9588205817833dbaa622f87c0e0081.1677051600.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add the missing header for architectures that don't define
the barrier_nospec() macro. The nospec.h header is added after the
inclusion of barrier.h to avoid redefining the macro for architectures
that already define barrier_nospec() in their respective barrier.h
headers.

Fixes: 74e19ef0ff80 ("uaccess: Add speculation barrier to copy_from_user()")
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Linus's master branch fails currently to build for arm64 without this commit.

 kernel/bpf/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 933869983e2a..92aeb388e422 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -38,6 +38,8 @@
 #include <linux/memcontrol.h>
 
 #include <asm/barrier.h>
+#include <linux/nospec.h>
+
 #include <asm/unaligned.h>
 
 /* Registers */
-- 
2.31.1.272.g89b43f80a514

