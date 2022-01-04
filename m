Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA4C483DC7
	for <lists+bpf@lfdr.de>; Tue,  4 Jan 2022 09:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbiADIKl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Jan 2022 03:10:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41445 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234023AbiADIKa (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 4 Jan 2022 03:10:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641283829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JbESpHRfLlaK1ly+p+PbLjsNNtlw/IID6NZUFBkK2J0=;
        b=Qjd5QNyiKntvc0fWzJhcTZHFe3o3o/nL4bOwi3BU1ibe3iBo14yrYeqY9aWqk3x06lj8c1
        7XvBkDhPwTqU+Pt4ym0XgA9fObnFyfuMtKjXMr6Jn+vAE2v00Lla+LosNtpPV3v452KgsF
        jJ/nekahypvVF4GwUHSphLF22SppQVg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-540-p4M_s4N4MuK2Oht31lTFJQ-1; Tue, 04 Jan 2022 03:10:28 -0500
X-MC-Unique: p4M_s4N4MuK2Oht31lTFJQ-1
Received: by mail-ed1-f72.google.com with SMTP id w6-20020a05640234c600b003f916e1b615so15501386edc.17
        for <bpf@vger.kernel.org>; Tue, 04 Jan 2022 00:10:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JbESpHRfLlaK1ly+p+PbLjsNNtlw/IID6NZUFBkK2J0=;
        b=eIIzekKRuSmy7hIlLDx/ZlNFK9Q4aoLvs/IfbxCDsPUFUQUjHl8lYQsRw+IKs7yIB+
         4+rbnB0hhv+Ao+xeZ6uWfK5ph/JewhUiG+HI8YzD+s8HtvNZM67k4OND78MIpQUik3bK
         1CWTz6SpkCfQrFP8GlXjXxhyTcEkdJ24wu34W8HTuq+IMiIlHzPmU/mEScOlo0RyoqdP
         cZjXUn3G75ldWEFpssyjzfybzNwkP/igNVcTGtqfOX5KwZiPRheQ/qjua/kn7Z9b35AC
         w3qbiI9tbtL2THIk1G1Dq2jlZv+Kf8MJ5GBHYC5kMhbAPlPg2MDnA5yPZkNdtNAOiIAT
         GyhQ==
X-Gm-Message-State: AOAM530kBFbbUcWxXfXzQr909ZV3e+asxItbDthZHPq0dp7PmWLoWPjh
        7t6tZZUVsfwdDK5sKm4W6+75jOYQbjiPdGYYLS1GJKcRf/tfoQKA2zLf7yuzxR0GpM15J36cI3A
        c2DnBBni7v0tu
X-Received: by 2002:a17:907:2d28:: with SMTP id gs40mr37541389ejc.765.1641283827371;
        Tue, 04 Jan 2022 00:10:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyWSI+W+Gb0MYq2Q3RCIFt9uJG0i7vLA8kleMXMypThKFPfIgJ/6256a7Vq6em8dK5Du3tmQw==
X-Received: by 2002:a17:907:2d28:: with SMTP id gs40mr37541383ejc.765.1641283827248;
        Tue, 04 Jan 2022 00:10:27 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id ne31sm11347262ejc.48.2022.01.04.00.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 00:10:27 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 07/13] samples/kprobes: Add support for multi kretprobe interface
Date:   Tue,  4 Jan 2022 09:09:37 +0100
Message-Id: <20220104080943.113249-8-jolsa@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220104080943.113249-1-jolsa@kernel.org>
References: <20220104080943.113249-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding support to test multi kprobe interface. It's now possible
to register multiple functions for the module handler, like:

  # modprobe kretprobe_example.ko func='sched_fork,kernel_clone'

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 samples/kprobes/kretprobe_example.c | 43 +++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/samples/kprobes/kretprobe_example.c b/samples/kprobes/kretprobe_example.c
index 228321ecb161..2181cf0d6e4a 100644
--- a/samples/kprobes/kretprobe_example.c
+++ b/samples/kprobes/kretprobe_example.c
@@ -25,6 +25,8 @@
 #include <linux/ktime.h>
 #include <linux/limits.h>
 #include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/string.h>
 
 static char func_name[NAME_MAX] = "kernel_clone";
 module_param_string(func, func_name, NAME_MAX, S_IRUGO);
@@ -80,17 +82,54 @@ static struct kretprobe my_kretprobe = {
 
 static int __init kretprobe_init(void)
 {
+	char **symbols = NULL;
 	int ret;
 
 	my_kretprobe.kp.symbol_name = func_name;
+
+#ifdef CONFIG_HAVE_KPROBES_MULTI_ON_FTRACE
+	if (strchr(func_name, ',')) {
+		char *p, *tmp;
+		int cnt;
+
+		tmp = kstrdup(func_name, GFP_KERNEL);
+		if (!tmp)
+			return -ENOMEM;
+
+		p = strchr(tmp, ',');
+		while (p) {
+			*p = ' ';
+			p = strchr(p + 1, ',');
+		}
+
+		symbols = argv_split(GFP_KERNEL, tmp, &cnt);
+		kfree(tmp);
+		if (!symbols) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		my_kretprobe.kp.multi.symbols = (const char **) symbols;
+		my_kretprobe.kp.multi.cnt = cnt;
+	}
+#endif
 	ret = register_kretprobe(&my_kretprobe);
 	if (ret < 0) {
 		pr_err("register_kretprobe failed, returned %d\n", ret);
 		return ret;
 	}
-	pr_info("Planted return probe at %s: %p\n",
+
+	if (symbols) {
+		pr_info("Planted multi return kprobe to %s\n", func_name);
+	} else {
+		pr_info("Planted return probe at %s: %p\n",
 			my_kretprobe.kp.symbol_name, my_kretprobe.kp.addr);
-	return 0;
+	}
+
+out:
+	if (symbols)
+		argv_free(symbols);
+	return ret;
 }
 
 static void __exit kretprobe_exit(void)
-- 
2.33.1

