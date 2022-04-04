Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5E44F1F54
	for <lists+bpf@lfdr.de>; Tue,  5 Apr 2022 00:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236188AbiDDWuV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 4 Apr 2022 18:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241870AbiDDWuH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Apr 2022 18:50:07 -0400
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645685FF31;
        Mon,  4 Apr 2022 15:03:22 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id qh7so12790956ejb.11;
        Mon, 04 Apr 2022 15:03:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hmBtyCSBQacoipPmCsuxywFD7dGIDZdmjd0lU4ylOC0=;
        b=pazOs1LZxFd2QSm53DZDOmnlSGL7KVTCzaflxn6GZaEfIhOmBo2eYNSD3QyaUBlMmF
         PDvUVKoKWwkTjbOfqyeXnfh9Jgb82xStxac7ZU875JYlSRaNL589m0Eag3qEXKtfl0Rt
         u3jfzSQdgDMP49rqHXDyezikswxxal3NDEn2EC3i1e+ZnwP+8OW4gIJAU20PTAye15h1
         jJ4guY3Hh9bfSmL6OtBSx96yWxu6cVNe54f7A1DuQn2NdDa2gTWtnqlvzq0PIH6p3Jx8
         GsYc4yBDYZTLS7lPy2kRe/oLtBaTn3OdMYAmbUjkb6mC0CMBRlKFcb3b7uDsDCA7fP7c
         fQug==
X-Gm-Message-State: AOAM533VVEVS3sx303nMNd4gvHwft/JbswCrWXKcHggDLOF3Z9HWFSjU
        Wj6L3Kj/MBrQMbMntLG8cJ3gixiuGD0=
X-Google-Smtp-Source: ABdhPJxKA6fBw682sFl4Rl5c6DEScQABE7R7uLVGQ9ljvzFS17MEqGICnW1ZnXnU+j/LkFmf4Gl7rw==
X-Received: by 2002:a17:907:9482:b0:6da:a24e:e767 with SMTP id dm2-20020a170907948200b006daa24ee767mr292233ejc.479.1649109800676;
        Mon, 04 Apr 2022 15:03:20 -0700 (PDT)
Received: from t490s.teknoraver.net (net-93-144-169-96.cust.dsl.teletu.it. [93.144.169.96])
        by smtp.gmail.com with ESMTPSA id q16-20020a170906145000b006bdaf981589sm4806743ejc.81.2022.04.04.15.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 15:03:20 -0700 (PDT)
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] bpf: make unprivileged BPF a compile time choice
Date:   Tue,  5 Apr 2022 00:03:14 +0200
Message-Id: <20220404220314.112912-1-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

Add a compile time option to permanently disable unprivileged BPF and
the corresponding sysctl handler so that there's absolutely no
concern about unprivileged BPF being enabled from userspace during
runtime. Special purpose kernels can benefit from the build-time
assurance that unprivileged eBPF is disabled in all of their kernel
builds rather than having to rely on userspace to permanently disable
it at boot time.
The default behaviour is left unchanged, which is: unprivileged BPF
compiled in but disabled at boot.

Signed-off-by: Matteo Croce <mcroce@microsoft.com>
---
 kernel/bpf/Kconfig   | 10 +++++++++-
 kernel/bpf/syscall.c |  4 +++-
 kernel/sysctl.c      |  4 ++++
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
index d56ee177d5f8..dfaef1ac1516 100644
--- a/kernel/bpf/Kconfig
+++ b/kernel/bpf/Kconfig
@@ -67,10 +67,18 @@ config BPF_JIT_DEFAULT_ON
 	def_bool ARCH_WANT_DEFAULT_BPF_JIT || BPF_JIT_ALWAYS_ON
 	depends on HAVE_EBPF_JIT && BPF_JIT
 
+config BPF_UNPRIV
+	bool "Unprivileged BPF"
+	default y
+	depends on BPF_SYSCALL
+	help
+	  Enables unprivileged BPF and the corresponding
+	  /proc/sys/kernel/unprivileged_bpf_disabled knob.
+
 config BPF_UNPRIV_DEFAULT_OFF
 	bool "Disable unprivileged BPF by default"
 	default y
-	depends on BPF_SYSCALL
+	depends on BPF_UNPRIV
 	help
 	  Disables unprivileged BPF by default by setting the corresponding
 	  /proc/sys/kernel/unprivileged_bpf_disabled knob to 2. An admin can
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index cdaa1152436a..b7e6aca87a18 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -53,7 +53,9 @@ static DEFINE_IDR(link_idr);
 static DEFINE_SPINLOCK(link_idr_lock);
 
 int sysctl_unprivileged_bpf_disabled __read_mostly =
-	IS_BUILTIN(CONFIG_BPF_UNPRIV_DEFAULT_OFF) ? 2 : 0;
+	IS_BUILTIN(CONFIG_BPF_UNPRIV) ?
+		(IS_BUILTIN(CONFIG_BPF_UNPRIV_DEFAULT_OFF) ? 2 : 0)
+		: 1;
 
 static const struct bpf_map_ops * const bpf_map_types[] = {
 #define BPF_PROG_TYPE(_id, _name, prog_ctx_type, kern_ctx_type)
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 830aaf8ca08e..a5b6e960ca58 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -184,6 +184,7 @@ void __weak unpriv_ebpf_notify(int new_state)
 {
 }
 
+#ifdef CONFIG_BPF_UNPRIV
 static int bpf_unpriv_handler(struct ctl_table *table, int write,
 			      void *buffer, size_t *lenp, loff_t *ppos)
 {
@@ -206,6 +207,7 @@ static int bpf_unpriv_handler(struct ctl_table *table, int write,
 
 	return ret;
 }
+#endif /* CONFIG_BPF_UNPRIV */
 #endif /* CONFIG_BPF_SYSCALL && CONFIG_SYSCTL */
 
 /*
@@ -2300,6 +2302,7 @@ static struct ctl_table kern_table[] = {
 	},
 #endif
 #ifdef CONFIG_BPF_SYSCALL
+#ifdef CONFIG_BPF_UNPRIV
 	{
 		.procname	= "unprivileged_bpf_disabled",
 		.data		= &sysctl_unprivileged_bpf_disabled,
@@ -2309,6 +2312,7 @@ static struct ctl_table kern_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_TWO,
 	},
+#endif
 	{
 		.procname	= "bpf_stats_enabled",
 		.data		= &bpf_stats_enabled_key.key,
-- 
2.35.1

