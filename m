Return-Path: <bpf+bounces-13685-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2317B7DC66B
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 07:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B05DD1F22239
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 06:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6E0101F8;
	Tue, 31 Oct 2023 06:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLkPKecR"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6032F107B4
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 06:18:54 +0000 (UTC)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B6EEE
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 23:09:30 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-778925998cbso373240485a.0
        for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 23:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698732570; x=1699337370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MoFSLdNv9BgdZXMvRsLNv+khDd0bU37YBKNQN5ndCUM=;
        b=cLkPKecR4objqz1QIrgHbCCi9WKoLl0QCd1pKvso5TB8fDDyd5n/9yXweCaPpKH9cp
         qb3owUQB5XLMIzsrF3C+Xk2sg73uCi8R+fg3lEzx1cAk9Z5mIQ0ts/iU4VvwEckStaoZ
         GliZan1j8sJgJFv4xw1QuZFXNIDWe9W97hzduRWtF8qEKVnlNG3vfp9+ZDjUFqMVQTeA
         CIuaZIMyewb5anPPlv4dOaukWN3U10kvj9Rvopodpm28NHanhQVGXsX/d4jJXtvbi86t
         VQorewtYogfibZdlV93UX9QBZNyrYmmXBUAaMyRqfnfcKkCLaX+ed3yOLEUGIa2TsVJ5
         L/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698732570; x=1699337370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MoFSLdNv9BgdZXMvRsLNv+khDd0bU37YBKNQN5ndCUM=;
        b=O1dGFr1mUhINdqG5wMVrAVxpLalNY35D8gD2ZMcLbHXQJgcQ/Kg6Q2zcYObqOZZvTz
         opYjbpln5rDYnL4BBOxi6jZimKa+RcSko0mhTaj9CuoY0OPz59YDt61ztBaHRWQlqE7C
         zd6z6a6Z7Vtw9hItM8ODtpC8+ScRe8l6Rjm0wiFuOTjenNqZwnd7yPGfMLYCsUEpM2hu
         c6zf4kwHz9c61bgHlgj5vbD4Trxu5nzeA/q48B83fktnVoEjYM0+LwUjasslLUfH+OXc
         PzjXrbFWiv08Z6wJ93nHeqVmhVGiBMVlvYsBBDHuhxaXmYP9VFp7IxINkPGmcBxZj+rB
         Ys5w==
X-Gm-Message-State: AOJu0YzhqqfeuXnBJXgt60RxUreVJtWXu5Ak8mbKdFccynnj7diXB2AJ
	I9aTrSQ+6Po60MoOEJEb6hGjvzfK5kZ7/A==
X-Google-Smtp-Source: AGHT+IFgahv4dofu1sz24kDo1ybg8cdXKxmHnl6Ij28tDiq9Ni78XN2pgtV51tBIwMF+yEg4VU5G1w==
X-Received: by 2002:a17:902:e803:b0:1cc:482c:bc4d with SMTP id u3-20020a170902e80300b001cc482cbc4dmr4371642plg.5.1698732026837;
        Mon, 30 Oct 2023 23:00:26 -0700 (PDT)
Received: from ubuntu.. ([203.205.141.13])
        by smtp.googlemail.com with ESMTPSA id x5-20020a170902b40500b001cc50f67fbasm460683plr.281.2023.10.30.23.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 23:00:26 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	keescook@chromium.org,
	luto@amacapital.net,
	wad@chromium.org,
	hengqi.chen@gmail.com
Subject: [PATCH bpf-next 2/6] bpf: Add test_run support for seccomp program type
Date: Tue, 31 Oct 2023 01:24:03 +0000
Message-Id: <20231031012407.51371-3-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231031012407.51371-1-hengqi.chen@gmail.com>
References: <20231031012407.51371-1-hengqi.chen@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement test_run for seccomp program type. Default
is to use an empty struct seccomp_data as bpf_context,
but can be overridden by userspace. This will be used
in selftests.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 include/linux/bpf.h |  3 +++
 kernel/seccomp.c    |  1 +
 net/bpf/test_run.c  | 27 +++++++++++++++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b4825d3cdb29..e25338e67ec4 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2376,6 +2376,9 @@ int bpf_prog_test_run_sk_lookup(struct bpf_prog *prog,
 int bpf_prog_test_run_nf(struct bpf_prog *prog,
 			 const union bpf_attr *kattr,
 			 union bpf_attr __user *uattr);
+int bpf_prog_test_run_seccomp(struct bpf_prog *prog,
+			      const union bpf_attr *kattr,
+			      union bpf_attr __user *uattr);
 bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 		    const struct bpf_prog *prog,
 		    struct bpf_insn_access_aux *info);
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 5a6ed8630566..1fa2312654a5 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -2517,6 +2517,7 @@ int proc_pid_seccomp_cache(struct seq_file *m, struct pid_namespace *ns,
 
 #if defined(CONFIG_SECCOMP_FILTER) && defined(CONFIG_BPF_SYSCALL)
 const struct bpf_prog_ops seccomp_prog_ops = {
+	.test_run = bpf_prog_test_run_seccomp,
 };
 
 static bool seccomp_is_valid_access(int off, int size, enum bpf_access_type type,
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 0841f8d82419..db159b9c56ca 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -20,6 +20,7 @@
 #include <linux/smp.h>
 #include <linux/sock_diag.h>
 #include <linux/netfilter.h>
+#include <linux/seccomp.h>
 #include <net/netdev_rx_queue.h>
 #include <net/xdp.h>
 #include <net/netfilter/nf_bpf_link.h>
@@ -1665,6 +1666,32 @@ int bpf_prog_test_run_nf(struct bpf_prog *prog,
 	return ret;
 }
 
+int bpf_prog_test_run_seccomp(struct bpf_prog *prog,
+			      const union bpf_attr *kattr,
+			      union bpf_attr __user *uattr)
+{
+	void __user *ctx_in = u64_to_user_ptr(kattr->test.ctx_in);
+	__u32 ctx_size_in = kattr->test.ctx_size_in;
+	struct seccomp_data ctx = {};
+	__u32 retval;
+
+	if (kattr->test.flags || kattr->test.cpu || kattr->test.batch_size)
+		return -EINVAL;
+
+	if (ctx_size_in && ctx_size_in < sizeof(ctx))
+		return -EINVAL;
+
+	if (ctx_size_in && copy_from_user(&ctx, ctx_in, sizeof(ctx)))
+		return -EFAULT;
+
+	retval = bpf_prog_run_pin_on_cpu(prog, &ctx);
+
+	if (copy_to_user(&uattr->test.retval, &retval, sizeof(retval)))
+		return -EFAULT;
+
+	return 0;
+}
+
 static const struct btf_kfunc_id_set bpf_prog_test_kfunc_set = {
 	.owner = THIS_MODULE,
 	.set   = &test_sk_check_kfunc_ids,
-- 
2.34.1


