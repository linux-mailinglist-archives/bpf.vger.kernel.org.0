Return-Path: <bpf+bounces-42349-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 161F69A3100
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 00:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3B36284504
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 22:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED0B1D8A10;
	Thu, 17 Oct 2024 22:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yc9v3RtZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC111D7E54
	for <bpf@vger.kernel.org>; Thu, 17 Oct 2024 22:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729205452; cv=none; b=r6lP8Orlb7+30txDLfyd1GtaBnce0cT+AZqQRAcnyFHDhfJAGmiOneAxHk55JuS3X7inWkS1NZ+QwlpZf6VfTXs+HSIDL+LssAVmLxGNuw+6qmYiWbS8QNysDQwYC/dYdlZoo0DBWnVZtadwPJemtVPa6JAlfyupy1Jbm+Qrl8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729205452; c=relaxed/simple;
	bh=zNtTQAOcD3V7MZIfh1VZleyN9yYCuQCnRGc4gKhaM6A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mVrlpGgbEMFOC0EYh3UXYyfKC5SkLDQM+5f1i5WSHzm8FnE+LzewRhIQL1rs9RFRRX21djWD31TArAgpa+0SXWuSVfNi9r1/BMXF1GDvv+y3D8EohRisAwUqYQcdudA2NFlA7JKn1N2tde/f61Rkzy/fGSiiQzva6D/TNyQh6JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yc9v3RtZ; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-71e467c39a4so1586805b3a.3
        for <bpf@vger.kernel.org>; Thu, 17 Oct 2024 15:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729205451; x=1729810251; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TVVEjCnGSeHGjB5BCp65K1C6/nSGfUiVK4HRp7lOBZo=;
        b=yc9v3RtZgv9oLuUPeuSH87f2FfGNh1+/V2Qr9WnBrKh10Y+M5Kdjr6T5Fm86bY3cw8
         mQKrwMBOpN6CHpuLQJ6M+q3Gq5HOIAz8nnZmbXsRhbyNAEbrZaA3MU/hLLOGMto4Hewx
         Gjrp2KDN6O8LE0B/DfRs1Y/x4kVLdVZb3Ts3XddqpZGMyUhC2s5MvS+QU/rAwtSZHSGH
         JKRt/Az9BoXV04iNHg5OmVzP0KPcL2IDY17C+E8fLLBd/fca8fCZ6oF5LlHMjA6WumAW
         nAM3xUbtGZawdPG6uVfkhDzWZbST3ERs1vP5YCM1xdg7PmNJ3TmBCiHXGz+ag7HRrrlU
         fNUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729205451; x=1729810251;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TVVEjCnGSeHGjB5BCp65K1C6/nSGfUiVK4HRp7lOBZo=;
        b=rcRYTcECDaxiUF0iVk315ICwM6nq+k7+fuswp3x5v2ICO7/pPM9TLws4uXnPmEKoCe
         Qx0IX3Mb8ydBNOa4Wofqg5BqPJLTNIFA9bsVoNq3hvbccMd/ozC7fafcAOCvNDitFzdR
         vyPq2f09WEQP5hy7ys/pyTpM3it8lwzdvDpSRUn5MGTgastcDLZukwwqARFuPgtLwby2
         oKyQAfHeETNpgqn8y5LeGqctxsvrFrIXziQU92T0E6wGH6XbBpYn+bsXccEdDNaNvF7u
         /6frDivklBCnU0SzudplAPLROXsVJxTWFU3qGi2oitQSTdMpDl4TfJIqjoQW8441lUwv
         mOfw==
X-Gm-Message-State: AOJu0Yy09PvBi+IqH/q0iJcSOt5zoH2ObareN3KNserfUcGMNQW/h8TZ
	ohrozQzONXrWsobQcylUwXvuc4yiQfsRK/ErR2iWP/TEJI62ABvK/S/hsAJDr53W/t6ZU+FR4pY
	thK10adN96K7PuHD+zc12vdMIJTOEBjakeDEB8mQQnx4RUWi8nSLTxJVs0V88/R3Wrz0XwuKyHv
	zeVtEOZDEkZiEDwWKRfctBrcU=
X-Google-Smtp-Source: AGHT+IHqPG81x2uHUSiDaoedIKmJnC0t2Mz+tYnbTiSVCL4TsthYAtX1ADHfR/OO7/kFtNY9WFiS/mKc0w==
X-Received: from jrife-kvm.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:63c1])
 (user=jrife job=sendgmr) by 2002:a05:6a00:3e15:b0:71e:6122:d9c with SMTP id
 d2e1a72fcca58-71ea323e075mr674b3a.4.1729205450485; Thu, 17 Oct 2024 15:50:50
 -0700 (PDT)
Date: Thu, 17 Oct 2024 22:49:20 +0000
In-Reply-To: <20241017225031.2448426-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241017225031.2448426-1-jrife@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241017225031.2448426-3-jrife@google.com>
Subject: [PATCH bpf-next v1 2/4] selftests/bpf: Migrate LOAD_REJECT test cases
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
2.47.0.rc1.288.g06298d1525-goog


