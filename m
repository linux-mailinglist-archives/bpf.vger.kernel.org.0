Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D22B59A7E3
	for <lists+bpf@lfdr.de>; Fri, 19 Aug 2022 23:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234960AbiHSVnd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Aug 2022 17:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237986AbiHSVnb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Aug 2022 17:43:31 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D57B13F42
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 14:43:30 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id t2-20020a17090a4e4200b001f21572f3a4so6054658pjl.0
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 14:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=hlhfOcaAISwN7vZVN/qowrmOmS21KIl/i8kYcPwYBWw=;
        b=Bo7ngEGAgqshf64Hk3UhRCye2nuSJtKiFuIEWtkcQrpI3Bp5Rc0Ivs8kuR2tm/Uqd4
         Gq9K4X9mkcd9GoK8DhXBxcwPbDrVnU/IZgkLWZ2ZY3VX3/XqDtPo0PSDXQME6kYZZgy9
         SOWxP+QrgzwqNI0KD36PGnUNtRaDAz+5fGRCUvwek0erbNqC9c75KYwk5SUtf55Y6nrV
         h2qnCbxyWH48zBO8tEMoguAl2Fmh8iIzmNFTTLBxXxBzr4SfhxDkx9DTTdX6FBUw2cbv
         Q6bcs+bT8f5dNRU4Tjt2soXAl/EaPj6paYfRtmM/zBqPNzW2oYcCQptEQzA3Y0IclSiv
         u8lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=hlhfOcaAISwN7vZVN/qowrmOmS21KIl/i8kYcPwYBWw=;
        b=0h1ElDtlUX2UNl0MCOy1v8O4spxDyL70t21dcjY1OTnLz0KiVFDTA681ipvd6q6PcV
         xMaQ35gEQ/8CTuGLyY8doLQRlXpi4pIiQe5vH8DiTSxB+MbBGAR4dUVpTMQl2Q4/7jQa
         MOj6vMlnZTVyCS2IKgHhv3Sfw1zCIs4TrqMS+c4UuxTqb3n0ZJO63uIo0zsLKbIAvu1Q
         GZKVzVYnvavSQZ3Ri+/OeJQepUtyd7J8uDJjJZ3JcPg5Pk9tH2ajEpg9LW0R6YtR79OQ
         S4RpTMaojShEBtz1LLoq1nll7mK7ylDxd1sPBs07KNwz5bcdqjJhlGKXmkH+gQWAkuGb
         hQPg==
X-Gm-Message-State: ACgBeo1/oc5s55F9mCjX1MP8/DMj5JyTqhNxXogpwwFxLy9ekl+V49xf
        zs9QIVY8xpynC67aRpkyeHg=
X-Google-Smtp-Source: AA6agR7dFh/IrUInZSWKnwoEMLFomgZNUtWGBrCJIt/X6KdkfB0oFBN+QytwAbcGDFIfY/yhtxOZVQ==
X-Received: by 2002:a17:90a:9f96:b0:1fa:b4fb:6297 with SMTP id o22-20020a17090a9f9600b001fab4fb6297mr10349716pjp.80.1660945409961;
        Fri, 19 Aug 2022 14:43:29 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:500::1:c4b1])
        by smtp.gmail.com with ESMTPSA id d135-20020a621d8d000000b0052d4b0d0c74sm3893099pfd.70.2022.08.19.14.43.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Aug 2022 14:43:29 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        memxor@gmail.com, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 bpf-next 15/15] bpf: Introduce sysctl kernel.bpf_force_dyn_alloc.
Date:   Fri, 19 Aug 2022 14:42:32 -0700
Message-Id: <20220819214232.18784-16-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220819214232.18784-1-alexei.starovoitov@gmail.com>
References: <20220819214232.18784-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Introduce sysctl kernel.bpf_force_dyn_alloc to force dynamic allocation in bpf
hash map. All selftests/bpf should pass with bpf_force_dyn_alloc 0 or 1 and all
bpf programs (both sleepable and not) should not see any functional difference.
The sysctl's observable behavior should only be improved memory usage.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/filter.h | 2 ++
 kernel/bpf/core.c      | 2 ++
 kernel/bpf/hashtab.c   | 5 +++++
 kernel/bpf/syscall.c   | 9 +++++++++
 4 files changed, 18 insertions(+)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index a5f21dc3c432..eb4d4a0c0bde 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1009,6 +1009,8 @@ bpf_run_sk_reuseport(struct sock_reuseport *reuse, struct sock *sk,
 }
 #endif
 
+extern int bpf_force_dyn_alloc;
+
 #ifdef CONFIG_BPF_JIT
 extern int bpf_jit_enable;
 extern int bpf_jit_harden;
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 639437f36928..a13e78ea4b90 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -533,6 +533,8 @@ void bpf_prog_kallsyms_del_all(struct bpf_prog *fp)
 	bpf_prog_kallsyms_del(fp);
 }
 
+int bpf_force_dyn_alloc __read_mostly;
+
 #ifdef CONFIG_BPF_JIT
 /* All BPF JIT sysctl knobs here. */
 int bpf_jit_enable   __read_mostly = IS_BUILTIN(CONFIG_BPF_JIT_DEFAULT_ON);
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 89f26cbddef5..f68a3400939e 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -505,6 +505,11 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 
 	bpf_map_init_from_attr(&htab->map, attr);
 
+	if (!lru && bpf_force_dyn_alloc) {
+		prealloc = false;
+		htab->map.map_flags |= BPF_F_NO_PREALLOC;
+	}
+
 	if (percpu_lru) {
 		/* ensure each CPU's lru list has >=1 elements.
 		 * since we are at it, make each lru list has the same
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 850270a72350..c201796f4997 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5297,6 +5297,15 @@ static struct ctl_table bpf_syscall_table[] = {
 		.mode		= 0644,
 		.proc_handler	= bpf_stats_handler,
 	},
+	{
+		.procname	= "bpf_force_dyn_alloc",
+		.data		= &bpf_force_dyn_alloc,
+		.maxlen		= sizeof(int),
+		.mode		= 0600,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
 	{ }
 };
 
-- 
2.30.2

