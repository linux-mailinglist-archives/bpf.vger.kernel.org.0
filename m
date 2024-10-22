Return-Path: <bpf+bounces-42790-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC1D9AB212
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 17:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D9DC1C21F58
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 15:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A46D1AA788;
	Tue, 22 Oct 2024 15:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kM7Aig6e"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B561A4F0C
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 15:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729610963; cv=none; b=HIPmZmVbITSynWunlZKrOBpjlM8EcxEIEz8W/6PEUx4HEnIUBirauuinE1i8rHyfqs/yVO5KDQKs22tJpFw7z2zNcpnBA6IRf+WHNe9IxcGCsOh2ZTlmV697SCpajE7Lo9PfQv5cWyjABdvHYLiIrVb1DlHAhPA0/cUAgxmE7d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729610963; c=relaxed/simple;
	bh=PIBElrUWYvv2PwD1OtHxNlMP6ZaEK/i5ZNf+lnSa2TI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BR4USsVmVBvCy+46Ac4vvJFhk+Ov2Yga6p8GHrkhDnzfJ2vXCa0zgqoNs5VDsfHdjpo/Ubm/Yddt1lXabObWwPv8/u2Blt2Clmri+UzYtk3lDpvMtvnY9GEWRWSsZK7cdphlZRQ0bi4AXVgqFkhVjkMFKEhNTWhz5E2a3LQ3wd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kM7Aig6e; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7eaac1e95ffso5074021a12.2
        for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 08:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729610961; x=1730215761; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uAWSt/btbjFtiBghyaLDlopKWtLgN/X+E84XHJl7PxM=;
        b=kM7Aig6eMmwXb6714N/rEyLSJpmzjgpeNqg/LSazH5d9vzWe43UaStusP2BT12FjA5
         8DqcrKQQcV7xRrSHsqp/wSpDijlTdhuM8WABhAescKSNx5Lx4FPbEFAlSnu9HrGNCOdW
         BVsfRKF77RgBD9pfiVkXu+K8Q5Reh6IO1GhMrfKcG5LaT/PXAn45pODnakBkH81jjDsm
         wWbDc6XrWd4Hzt3j0ZXDxm6tMXKaEya1FkA+AEWnd5GYWUTs4wyJ2pWoTgBG9q5IBNrY
         5Wv4hjhpB3tEZGE0+VLdEolPmPz65i9/Af8hn2qISDlZ5Glz9nOHnIGJEkyrVPnUGmcR
         9URQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729610961; x=1730215761;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uAWSt/btbjFtiBghyaLDlopKWtLgN/X+E84XHJl7PxM=;
        b=LJMMaA8dQAqJ/wO7WqaRdiaXzO5RzWO1gTb3m9abheAhRFYLhFRSTw1ngQJcneCPrw
         yiNDt9WWd0SyRaCpD6jemmPyzXPDCXVXcTto9tgHRyIY0/jy3OLsp08Bnrl8zoeImHB2
         t4MGhR9QO/GWZwwvuuPnKC/B6rbajeUGbhv41vJCEx5zyb7bNGR4i5ITH9MHnt7lgxoL
         /JCmvCG8hLWwWQMAbHuYCoxtzY7Up8E+AWHn8i6prBoGVkTn0MJ7yFZ0R15dCD7Ds58e
         HTq4dhJsKkafFB1ZT9pd6v7Zu/SQWJb2Wnhxjg6aSNDAn48Xnh9dG/Gy+JadW8hephiz
         11NA==
X-Gm-Message-State: AOJu0YyQYv++1xhLEuf/TBLIwiPEdIw+hQLh1UD82dVnO6sZMd012K/U
	GXo/wD0vw3/HcooQKwCzqcyTD/G6ft/qn1ptz4w/7NkpOMVTWc6qH2AptgyaDqCz499BTC2uY/v
	sPeAg3VITNVxsbkK9kkjzP7MMfGtGUT4UMvH4A5ra2ssgELUX4eqe41kDYZ1aRFHmVVtwAJtZ9f
	MMF9vyFNKPtT4v1ypvTjdmWaw=
X-Google-Smtp-Source: AGHT+IG+8WtYAIvE5hMOTDDIDnESEKs9cooxGmHJzmkpUQR6rSf3ErATiOoioVL9hjQPnMGv1+BjKVw55A==
X-Received: from jrife-kvm.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:63c1])
 (user=jrife job=sendgmr) by 2002:a63:3741:0:b0:7ea:7e29:be5 with SMTP id
 41be03b00d2f7-7eacc86642bmr17501a12.6.1729610959685; Tue, 22 Oct 2024
 08:29:19 -0700 (PDT)
Date: Tue, 22 Oct 2024 15:29:02 +0000
In-Reply-To: <20241022152913.574836-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241022152913.574836-1-jrife@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Message-ID: <20241022152913.574836-3-jrife@google.com>
Subject: [PATCH bpf-next v2 2/4] selftests/bpf: Migrate LOAD_REJECT test cases
 to prog_tests
From: Jordan Rife <jrife@google.com>
To: bpf@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, "Daniel T. Lee" <danieltimlee@gmail.com>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Move LOAD_REJECT test cases from test_sock.c to an equivalent set of
verifier tests in progs/verifier_sock.c.

Signed-off-by: Jordan Rife <jrife@google.com>
---
 .../selftests/bpf/progs/verifier_sock.c       | 60 +++++++++++++++++++
 tools/testing/selftests/bpf/test_sock.c       | 52 ----------------
 2 files changed, 60 insertions(+), 52 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_sock.c b/tools/testing/selftests/bpf/progs/verifier_sock.c
index ee76b51005ab..d3e70e38e442 100644
--- a/tools/testing/selftests/bpf/progs/verifier_sock.c
+++ b/tools/testing/selftests/bpf/progs/verifier_sock.c
@@ -977,4 +977,64 @@ l1_%=:	r0 = *(u8*)(r7 + 0);				\
 	: __clobber_all);
 }
 
+SEC("cgroup/post_bind4")
+__description("sk->src_ip6[0] [load 1st byte]")
+__failure __msg("invalid bpf_context access off=28 size=2")
+__naked void post_bind4_read_src_ip6(void)
+{
+	asm volatile ("					\
+	r6 = r1;					\
+	r7 = *(u16*)(r6 + %[bpf_sock_src_ip6_0]);	\
+	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm_const(bpf_sock_src_ip6_0, offsetof(struct bpf_sock, src_ip6[0]))
+	: __clobber_all);
+}
+
+SEC("cgroup/post_bind4")
+__description("sk->mark [load mark]")
+__failure __msg("invalid bpf_context access off=16 size=2")
+__naked void post_bind4_read_mark(void)
+{
+	asm volatile ("					\
+	r6 = r1;					\
+	r7 = *(u16*)(r6 + %[bpf_sock_mark]);		\
+	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm_const(bpf_sock_mark, offsetof(struct bpf_sock, mark))
+	: __clobber_all);
+}
+
+SEC("cgroup/post_bind6")
+__description("sk->src_ip4 [load src_ip4]")
+__failure __msg("invalid bpf_context access off=24 size=2")
+__naked void post_bind6_read_src_ip4(void)
+{
+	asm volatile ("					\
+	r6 = r1;					\
+	r7 = *(u16*)(r6 + %[bpf_sock_src_ip4]);		\
+	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm_const(bpf_sock_src_ip4, offsetof(struct bpf_sock, src_ip4))
+	: __clobber_all);
+}
+
+SEC("cgroup/sock_create")
+__description("sk->src_port [word load]")
+__failure __msg("invalid bpf_context access off=44 size=2")
+__naked void sock_create_read_src_port(void)
+{
+	asm volatile ("					\
+	r6 = r1;					\
+	r7 = *(u16*)(r6 + %[bpf_sock_src_port]);	\
+	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm_const(bpf_sock_src_port, offsetof(struct bpf_sock, src_port))
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_sock.c b/tools/testing/selftests/bpf/test_sock.c
index 9ed908163d98..26dff88abbaa 100644
--- a/tools/testing/selftests/bpf/test_sock.c
+++ b/tools/testing/selftests/bpf/test_sock.c
@@ -47,58 +47,6 @@ struct sock_test {
 };
 
 static struct sock_test tests[] = {
-	{
-		.descr = "bind4 load with invalid access: src_ip6",
-		.insns = {
-			BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
-			BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_6,
-				    offsetof(struct bpf_sock, src_ip6[0])),
-			BPF_MOV64_IMM(BPF_REG_0, 1),
-			BPF_EXIT_INSN(),
-		},
-		.expected_attach_type = BPF_CGROUP_INET4_POST_BIND,
-		.attach_type = BPF_CGROUP_INET4_POST_BIND,
-		.result = LOAD_REJECT,
-	},
-	{
-		.descr = "bind4 load with invalid access: mark",
-		.insns = {
-			BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
-			BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_6,
-				    offsetof(struct bpf_sock, mark)),
-			BPF_MOV64_IMM(BPF_REG_0, 1),
-			BPF_EXIT_INSN(),
-		},
-		.expected_attach_type = BPF_CGROUP_INET4_POST_BIND,
-		.attach_type = BPF_CGROUP_INET4_POST_BIND,
-		.result = LOAD_REJECT,
-	},
-	{
-		.descr = "bind6 load with invalid access: src_ip4",
-		.insns = {
-			BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
-			BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_6,
-				    offsetof(struct bpf_sock, src_ip4)),
-			BPF_MOV64_IMM(BPF_REG_0, 1),
-			BPF_EXIT_INSN(),
-		},
-		.expected_attach_type = BPF_CGROUP_INET6_POST_BIND,
-		.attach_type = BPF_CGROUP_INET6_POST_BIND,
-		.result = LOAD_REJECT,
-	},
-	{
-		.descr = "sock_create load with invalid access: src_port",
-		.insns = {
-			BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
-			BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_6,
-				    offsetof(struct bpf_sock, src_port)),
-			BPF_MOV64_IMM(BPF_REG_0, 1),
-			BPF_EXIT_INSN(),
-		},
-		.expected_attach_type = BPF_CGROUP_INET_SOCK_CREATE,
-		.attach_type = BPF_CGROUP_INET_SOCK_CREATE,
-		.result = LOAD_REJECT,
-	},
 	{
 		.descr = "sock_create load w/o expected_attach_type (compat mode)",
 		.insns = {
-- 
2.47.0.105.g07ac214952-goog


