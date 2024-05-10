Return-Path: <bpf+bounces-29497-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA4F8C2A35
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 21:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A20B71C21CB5
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 19:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68EB41E525;
	Fri, 10 May 2024 19:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ciyo5hbO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7698244C77
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 19:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715367777; cv=none; b=VC2R13/YxPJRahNsFVi67vLKyi0WrJCVmo6elu9bIZYbOD6WSoZkOza2OuXxu2RLqp7YzjvhkV4CYrkPg6r9/70YXnBRA9iZpubjYb0nY+N9iSIv/uspLSHlH1kNbJfgjml2OjZRNlMBU6H0Dsm5OP2s9btwir8JtI70k1jsMO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715367777; c=relaxed/simple;
	bh=umwDCHMxWe2VleAcb0MR/ATgCNVJNqxCKDau+vAM1iI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qZCeeTzc99QH/fJIZquh9AlPZVSCUyVDszF/Sto/NCwbKEElzXVN99/dJkb0mX/DCiuWkM8UfPHm2mm4GIXf1L8ECDmYVpANWkQGLXnVfh2TBoVY86DakZ/8acScsm+Z+BUHiXtpR+QsJupoLY3GYUvuz8lZhbULY1qHR9ds5FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ciyo5hbO; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-7dece1fa472so212909739f.0
        for <bpf@vger.kernel.org>; Fri, 10 May 2024 12:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715367774; x=1715972574; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sHSfeVpMvwODzNEwypI4cGwPjJUiYaJQzLUjzCAkNHo=;
        b=Ciyo5hbOBe+dDCIf7I2IyGBtUiYAf8jEsBQRX5iYkIRkdbTiyzxbZNWXKcVcj0DRQ4
         +UbxmaBW+y8QKy1qQr3tQANDCuhryKu5CovbO8MzrSvvEcCgzXhxxocjiraFkReu6cHz
         NYSBBpRhIEauCFGZiJSn4LeDvjxc78So3jM0E2UTyKJH0mJgQ/uOvTMaJ/DmNhnWcnpx
         j49eLrs1q0E9pE+LIHBWrKoyElsTsEzilbvbBDcgtBDXSJkXewO5AoavPy/Dl+yXVcIT
         MBW9Qa/v34lr4z3dbw70MHlvM9ksXIKiPnM6OkJgRO8HFSM+mnX23C5/j/6rTVil2FOW
         lVWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715367774; x=1715972574;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sHSfeVpMvwODzNEwypI4cGwPjJUiYaJQzLUjzCAkNHo=;
        b=JQ8TlCan6+hU6BvEhs3YsGoVIOdPJ83Xalo22Jk7Yulf0lZmdCiaqktzGOB2/jOqcZ
         PFq/jkOQ1OYSM20GvnX9v5J/NHro29b+MoDS7WUpTdYxdGQjn97W6ehIqNs3CoUPcxSR
         T403vn1+du4JDICDAR1bZakAPJchM9y2V6b9ogbXxZLY3riMqS6Q6g4HFJSPCJkBXB7p
         nzJJyj2YahHI1NGbIx/3+lT032b3uINAZcFnfSvuMGqJDKFqB4SiHtGg9lP7n7BN00tJ
         pGyVRiUa6fvgG9yYoatbtzKwOWXv3MpAa7tDSWIfKka9oLhafbldOlyZUdLfApcPoOzW
         N8zg==
X-Gm-Message-State: AOJu0YwJNSWCtvDywitIzM5cbMD6A1t7C3zpGdOtoRFmgleP8gMsRY0T
	trEFNuD1l/6Y2jvphhwtpJvT10EKoru/0zG6UIT16z6q0QjtU7F+BQxiTKe+0HT6+k9r7rSgRwA
	dcPby2BxAYLb1O26tiZR55YH8PUQ8MKiRbsoIDCQ5d2QQMF7h8aD6IG0NVW5bm5pZdyeuSV1zoc
	qPSzfsFuiPOEAkgEG9oCe8Wg4=
X-Google-Smtp-Source: AGHT+IFOCD3TK76hgg1j2I7tXKXE7izW2vzfDFqxJjwb3/5fLciGU/CDmRC/k8ISZGXSusfSzdRRFO4Jkg==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a05:6638:8625:b0:488:d668:d201 with SMTP id
 8926c6da1cb9f-4895856f59emr201108173.1.1715367773669; Fri, 10 May 2024
 12:02:53 -0700 (PDT)
Date: Fri, 10 May 2024 14:02:20 -0500
In-Reply-To: <20240510190246.3247730-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510190246.3247730-1-jrife@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510190246.3247730-4-jrife@google.com>
Subject: [PATCH v1 bpf-next 03/17] selftests/bpf: Handle LOAD_REJECT test cases
From: Jordan Rife <jrife@google.com>
To: bpf@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Geliang Tang <tanggeliang@kylinos.cn>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In preparation to move test cases from bpf/test_sock_addr.c that expect
LOAD_REJECT, this patch adds expected_attach_type and extends load_fn to
accept an expected attach type and a flag indicating whether or not
rejection is expected.

Signed-off-by: Jordan Rife <jrife@google.com>
---
 .../selftests/bpf/prog_tests/sock_addr.c      | 103 +++++++++++++++++-
 1 file changed, 98 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_addr.c b/tools/testing/selftests/bpf/prog_tests/sock_addr.c
index 039c3e38e1bc2..3033641fd7567 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_addr.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_addr.c
@@ -52,7 +52,9 @@ enum sock_addr_test_type {
 	SOCK_ADDR_TEST_GETPEERNAME,
 };
 
-typedef void *(*load_fn)(int cgroup_fd);
+typedef void *(*load_fn)(int cgroup_fd,
+			 enum bpf_attach_type attach_type,
+			 bool expect_reject);
 typedef void (*destroy_fn)(void *skel);
 
 static int cmp_addr(const struct sockaddr_storage *addr1, socklen_t addr1_len,
@@ -343,6 +345,7 @@ struct sock_addr_test {
 	/* BPF prog properties */
 	load_fn loadfn;
 	destroy_fn destroyfn;
+	enum bpf_attach_type attach_type;
 	/* Socket operations */
 	struct sock_ops *ops;
 	/* Socket properties */
@@ -354,15 +357,34 @@ struct sock_addr_test {
 	const char *expected_addr;
 	unsigned short expected_port;
 	const char *expected_src_addr;
+	/* Expected test result */
+	enum {
+		LOAD_REJECT,
+		ATTACH_REJECT,
+		SYSCALL_EPERM,
+		SYSCALL_ENOTSUPP,
+		SUCCESS,
+	} expected_result;
 };
 
 #define BPF_SKEL_FUNCS(skel_name, prog_name) \
-static void *prog_name##_load(int cgroup_fd) \
+static void *prog_name##_load(int cgroup_fd, \
+			      enum bpf_attach_type attach_type, \
+			      bool expect_reject) \
 { \
-	struct skel_name *skel; \
-	skel = skel_name##__open_and_load(); \
+	struct skel_name *skel = skel_name##__open(); \
 	if (!ASSERT_OK_PTR(skel, "skel_open")) \
 		goto cleanup; \
+	if (!ASSERT_OK(bpf_program__set_expected_attach_type(skel->progs.prog_name, \
+							     attach_type), \
+		       "set_expected_attach_type")) \
+		goto cleanup; \
+	if (skel_name##__load(skel)) { \
+		ASSERT_TRUE(expect_reject, "unexpected rejection"); \
+		goto cleanup; \
+	} \
+	if (!ASSERT_FALSE(expect_reject, "expected rejection")) \
+		goto cleanup; \
 	skel->links.prog_name = bpf_program__attach_cgroup( \
 		skel->progs.prog_name, cgroup_fd); \
 	if (!ASSERT_OK_PTR(skel->links.prog_name, "prog_attach")) \
@@ -398,6 +420,7 @@ static struct sock_addr_test tests[] = {
 		"bind4: bind (stream)",
 		bind_v4_prog_load,
 		bind_v4_prog_destroy,
+		BPF_CGROUP_INET4_BIND,
 		&user_ops,
 		AF_INET,
 		SOCK_STREAM,
@@ -406,12 +429,14 @@ static struct sock_addr_test tests[] = {
 		SERV4_REWRITE_IP,
 		SERV4_REWRITE_PORT,
 		NULL,
+		SUCCESS,
 	},
 	{
 		SOCK_ADDR_TEST_BIND,
 		"bind4: bind (dgram)",
 		bind_v4_prog_load,
 		bind_v4_prog_destroy,
+		BPF_CGROUP_INET4_BIND,
 		&user_ops,
 		AF_INET,
 		SOCK_DGRAM,
@@ -420,12 +445,14 @@ static struct sock_addr_test tests[] = {
 		SERV4_REWRITE_IP,
 		SERV4_REWRITE_PORT,
 		NULL,
+		SUCCESS,
 	},
 	{
 		SOCK_ADDR_TEST_BIND,
 		"bind6: bind (stream)",
 		bind_v6_prog_load,
 		bind_v6_prog_destroy,
+		BPF_CGROUP_INET6_BIND,
 		&user_ops,
 		AF_INET6,
 		SOCK_STREAM,
@@ -434,12 +461,14 @@ static struct sock_addr_test tests[] = {
 		SERV6_REWRITE_IP,
 		SERV6_REWRITE_PORT,
 		NULL,
+		SUCCESS,
 	},
 	{
 		SOCK_ADDR_TEST_BIND,
 		"bind6: bind (dgram)",
 		bind_v6_prog_load,
 		bind_v6_prog_destroy,
+		BPF_CGROUP_INET6_BIND,
 		&user_ops,
 		AF_INET6,
 		SOCK_DGRAM,
@@ -448,6 +477,7 @@ static struct sock_addr_test tests[] = {
 		SERV6_REWRITE_IP,
 		SERV6_REWRITE_PORT,
 		NULL,
+		SUCCESS,
 	},
 
 	/* bind - kernel calls */
@@ -456,6 +486,7 @@ static struct sock_addr_test tests[] = {
 		"bind4: kernel_bind (stream)",
 		bind_v4_prog_load,
 		bind_v4_prog_destroy,
+		BPF_CGROUP_INET4_BIND,
 		&kern_ops_sock_sendmsg,
 		AF_INET,
 		SOCK_STREAM,
@@ -463,12 +494,15 @@ static struct sock_addr_test tests[] = {
 		SERV4_PORT,
 		SERV4_REWRITE_IP,
 		SERV4_REWRITE_PORT,
+		NULL,
+		SUCCESS,
 	},
 	{
 		SOCK_ADDR_TEST_BIND,
 		"bind4: kernel_bind (dgram)",
 		bind_v4_prog_load,
 		bind_v4_prog_destroy,
+		BPF_CGROUP_INET4_BIND,
 		&kern_ops_sock_sendmsg,
 		AF_INET,
 		SOCK_DGRAM,
@@ -476,12 +510,15 @@ static struct sock_addr_test tests[] = {
 		SERV4_PORT,
 		SERV4_REWRITE_IP,
 		SERV4_REWRITE_PORT,
+		NULL,
+		SUCCESS,
 	},
 	{
 		SOCK_ADDR_TEST_BIND,
 		"bind6: kernel_bind (stream)",
 		bind_v6_prog_load,
 		bind_v6_prog_destroy,
+		BPF_CGROUP_INET6_BIND,
 		&kern_ops_sock_sendmsg,
 		AF_INET6,
 		SOCK_STREAM,
@@ -489,12 +526,15 @@ static struct sock_addr_test tests[] = {
 		SERV6_PORT,
 		SERV6_REWRITE_IP,
 		SERV6_REWRITE_PORT,
+		NULL,
+		SUCCESS,
 	},
 	{
 		SOCK_ADDR_TEST_BIND,
 		"bind6: kernel_bind (dgram)",
 		bind_v6_prog_load,
 		bind_v6_prog_destroy,
+		BPF_CGROUP_INET6_BIND,
 		&kern_ops_sock_sendmsg,
 		AF_INET6,
 		SOCK_DGRAM,
@@ -502,6 +542,8 @@ static struct sock_addr_test tests[] = {
 		SERV6_PORT,
 		SERV6_REWRITE_IP,
 		SERV6_REWRITE_PORT,
+		NULL,
+		SUCCESS,
 	},
 
 	/* connect - system calls */
@@ -510,6 +552,7 @@ static struct sock_addr_test tests[] = {
 		"connect4: connect (stream)",
 		connect_v4_prog_load,
 		connect_v4_prog_destroy,
+		BPF_CGROUP_INET4_CONNECT,
 		&user_ops,
 		AF_INET,
 		SOCK_STREAM,
@@ -518,12 +561,14 @@ static struct sock_addr_test tests[] = {
 		SERV4_REWRITE_IP,
 		SERV4_REWRITE_PORT,
 		SRC4_REWRITE_IP,
+		SUCCESS,
 	},
 	{
 		SOCK_ADDR_TEST_CONNECT,
 		"connect4: connect (dgram)",
 		connect_v4_prog_load,
 		connect_v4_prog_destroy,
+		BPF_CGROUP_INET4_CONNECT,
 		&user_ops,
 		AF_INET,
 		SOCK_DGRAM,
@@ -532,12 +577,14 @@ static struct sock_addr_test tests[] = {
 		SERV4_REWRITE_IP,
 		SERV4_REWRITE_PORT,
 		SRC4_REWRITE_IP,
+		SUCCESS,
 	},
 	{
 		SOCK_ADDR_TEST_CONNECT,
 		"connect6: connect (stream)",
 		connect_v6_prog_load,
 		connect_v6_prog_destroy,
+		BPF_CGROUP_INET6_CONNECT,
 		&user_ops,
 		AF_INET6,
 		SOCK_STREAM,
@@ -546,12 +593,14 @@ static struct sock_addr_test tests[] = {
 		SERV6_REWRITE_IP,
 		SERV6_REWRITE_PORT,
 		SRC6_REWRITE_IP,
+		SUCCESS,
 	},
 	{
 		SOCK_ADDR_TEST_CONNECT,
 		"connect6: connect (dgram)",
 		connect_v6_prog_load,
 		connect_v6_prog_destroy,
+		BPF_CGROUP_INET6_CONNECT,
 		&user_ops,
 		AF_INET6,
 		SOCK_DGRAM,
@@ -560,12 +609,14 @@ static struct sock_addr_test tests[] = {
 		SERV6_REWRITE_IP,
 		SERV6_REWRITE_PORT,
 		SRC6_REWRITE_IP,
+		SUCCESS,
 	},
 	{
 		SOCK_ADDR_TEST_CONNECT,
 		"connect_unix: connect (stream)",
 		connect_unix_prog_load,
 		connect_unix_prog_destroy,
+		BPF_CGROUP_UNIX_CONNECT,
 		&user_ops,
 		AF_UNIX,
 		SOCK_STREAM,
@@ -574,6 +625,7 @@ static struct sock_addr_test tests[] = {
 		SERVUN_REWRITE_ADDRESS,
 		0,
 		NULL,
+		SUCCESS,
 	},
 
 	/* connect - kernel calls */
@@ -582,6 +634,7 @@ static struct sock_addr_test tests[] = {
 		"connect4: kernel_connect (stream)",
 		connect_v4_prog_load,
 		connect_v4_prog_destroy,
+		BPF_CGROUP_INET4_CONNECT,
 		&kern_ops_sock_sendmsg,
 		AF_INET,
 		SOCK_STREAM,
@@ -590,12 +643,14 @@ static struct sock_addr_test tests[] = {
 		SERV4_REWRITE_IP,
 		SERV4_REWRITE_PORT,
 		SRC4_REWRITE_IP,
+		SUCCESS,
 	},
 	{
 		SOCK_ADDR_TEST_CONNECT,
 		"connect4: kernel_connect (dgram)",
 		connect_v4_prog_load,
 		connect_v4_prog_destroy,
+		BPF_CGROUP_INET4_CONNECT,
 		&kern_ops_sock_sendmsg,
 		AF_INET,
 		SOCK_DGRAM,
@@ -604,12 +659,14 @@ static struct sock_addr_test tests[] = {
 		SERV4_REWRITE_IP,
 		SERV4_REWRITE_PORT,
 		SRC4_REWRITE_IP,
+		SUCCESS,
 	},
 	{
 		SOCK_ADDR_TEST_CONNECT,
 		"connect6: kernel_connect (stream)",
 		connect_v6_prog_load,
 		connect_v6_prog_destroy,
+		BPF_CGROUP_INET6_CONNECT,
 		&kern_ops_sock_sendmsg,
 		AF_INET6,
 		SOCK_STREAM,
@@ -618,12 +675,14 @@ static struct sock_addr_test tests[] = {
 		SERV6_REWRITE_IP,
 		SERV6_REWRITE_PORT,
 		SRC6_REWRITE_IP,
+		SUCCESS,
 	},
 	{
 		SOCK_ADDR_TEST_CONNECT,
 		"connect6: kernel_connect (dgram)",
 		connect_v6_prog_load,
 		connect_v6_prog_destroy,
+		BPF_CGROUP_INET6_CONNECT,
 		&kern_ops_sock_sendmsg,
 		AF_INET6,
 		SOCK_DGRAM,
@@ -632,12 +691,14 @@ static struct sock_addr_test tests[] = {
 		SERV6_REWRITE_IP,
 		SERV6_REWRITE_PORT,
 		SRC6_REWRITE_IP,
+		SUCCESS,
 	},
 	{
 		SOCK_ADDR_TEST_CONNECT,
 		"connect_unix: kernel_connect (dgram)",
 		connect_unix_prog_load,
 		connect_unix_prog_destroy,
+		BPF_CGROUP_UNIX_CONNECT,
 		&kern_ops_sock_sendmsg,
 		AF_UNIX,
 		SOCK_STREAM,
@@ -646,6 +707,7 @@ static struct sock_addr_test tests[] = {
 		SERVUN_REWRITE_ADDRESS,
 		0,
 		NULL,
+		SUCCESS,
 	},
 
 	/* sendmsg - system calls */
@@ -654,6 +716,7 @@ static struct sock_addr_test tests[] = {
 		"sendmsg4: sendmsg (dgram)",
 		sendmsg_v4_prog_load,
 		sendmsg_v4_prog_destroy,
+		BPF_CGROUP_UDP4_SENDMSG,
 		&user_ops,
 		AF_INET,
 		SOCK_DGRAM,
@@ -662,12 +725,14 @@ static struct sock_addr_test tests[] = {
 		SERV4_REWRITE_IP,
 		SERV4_REWRITE_PORT,
 		SRC4_REWRITE_IP,
+		SUCCESS,
 	},
 	{
 		SOCK_ADDR_TEST_SENDMSG,
 		"sendmsg6: sendmsg (dgram)",
 		sendmsg_v6_prog_load,
 		sendmsg_v6_prog_destroy,
+		BPF_CGROUP_UDP6_SENDMSG,
 		&user_ops,
 		AF_INET6,
 		SOCK_DGRAM,
@@ -676,12 +741,14 @@ static struct sock_addr_test tests[] = {
 		SERV6_REWRITE_IP,
 		SERV6_REWRITE_PORT,
 		SRC6_REWRITE_IP,
+		SUCCESS,
 	},
 	{
 		SOCK_ADDR_TEST_SENDMSG,
 		"sendmsg_unix: sendmsg (dgram)",
 		sendmsg_unix_prog_load,
 		sendmsg_unix_prog_destroy,
+		BPF_CGROUP_UNIX_SENDMSG,
 		&user_ops,
 		AF_UNIX,
 		SOCK_DGRAM,
@@ -690,6 +757,7 @@ static struct sock_addr_test tests[] = {
 		SERVUN_REWRITE_ADDRESS,
 		0,
 		NULL,
+		SUCCESS,
 	},
 
 	/* sendmsg - kernel calls (sock_sendmsg) */
@@ -698,6 +766,7 @@ static struct sock_addr_test tests[] = {
 		"sendmsg4: sock_sendmsg (dgram)",
 		sendmsg_v4_prog_load,
 		sendmsg_v4_prog_destroy,
+		BPF_CGROUP_UDP4_SENDMSG,
 		&kern_ops_sock_sendmsg,
 		AF_INET,
 		SOCK_DGRAM,
@@ -706,12 +775,14 @@ static struct sock_addr_test tests[] = {
 		SERV4_REWRITE_IP,
 		SERV4_REWRITE_PORT,
 		SRC4_REWRITE_IP,
+		SUCCESS,
 	},
 	{
 		SOCK_ADDR_TEST_SENDMSG,
 		"sendmsg6: sock_sendmsg (dgram)",
 		sendmsg_v6_prog_load,
 		sendmsg_v6_prog_destroy,
+		BPF_CGROUP_UDP6_SENDMSG,
 		&kern_ops_sock_sendmsg,
 		AF_INET6,
 		SOCK_DGRAM,
@@ -720,12 +791,14 @@ static struct sock_addr_test tests[] = {
 		SERV6_REWRITE_IP,
 		SERV6_REWRITE_PORT,
 		SRC6_REWRITE_IP,
+		SUCCESS,
 	},
 	{
 		SOCK_ADDR_TEST_SENDMSG,
 		"sendmsg_unix: sock_sendmsg (dgram)",
 		sendmsg_unix_prog_load,
 		sendmsg_unix_prog_destroy,
+		BPF_CGROUP_UNIX_SENDMSG,
 		&kern_ops_sock_sendmsg,
 		AF_UNIX,
 		SOCK_DGRAM,
@@ -734,6 +807,7 @@ static struct sock_addr_test tests[] = {
 		SERVUN_REWRITE_ADDRESS,
 		0,
 		NULL,
+		SUCCESS,
 	},
 
 	/* sendmsg - kernel calls (kernel_sendmsg) */
@@ -742,6 +816,7 @@ static struct sock_addr_test tests[] = {
 		"sendmsg4: kernel_sendmsg (dgram)",
 		sendmsg_v4_prog_load,
 		sendmsg_v4_prog_destroy,
+		BPF_CGROUP_UDP4_SENDMSG,
 		&kern_ops_kernel_sendmsg,
 		AF_INET,
 		SOCK_DGRAM,
@@ -750,12 +825,14 @@ static struct sock_addr_test tests[] = {
 		SERV4_REWRITE_IP,
 		SERV4_REWRITE_PORT,
 		SRC4_REWRITE_IP,
+		SUCCESS,
 	},
 	{
 		SOCK_ADDR_TEST_SENDMSG,
 		"sendmsg6: kernel_sendmsg (dgram)",
 		sendmsg_v6_prog_load,
 		sendmsg_v6_prog_destroy,
+		BPF_CGROUP_UDP6_SENDMSG,
 		&kern_ops_kernel_sendmsg,
 		AF_INET6,
 		SOCK_DGRAM,
@@ -764,12 +841,14 @@ static struct sock_addr_test tests[] = {
 		SERV6_REWRITE_IP,
 		SERV6_REWRITE_PORT,
 		SRC6_REWRITE_IP,
+		SUCCESS,
 	},
 	{
 		SOCK_ADDR_TEST_SENDMSG,
 		"sendmsg_unix: sock_sendmsg (dgram)",
 		sendmsg_unix_prog_load,
 		sendmsg_unix_prog_destroy,
+		BPF_CGROUP_UNIX_SENDMSG,
 		&kern_ops_kernel_sendmsg,
 		AF_UNIX,
 		SOCK_DGRAM,
@@ -778,6 +857,7 @@ static struct sock_addr_test tests[] = {
 		SERVUN_REWRITE_ADDRESS,
 		0,
 		NULL,
+		SUCCESS,
 	},
 
 	/* recvmsg - system calls */
@@ -786,6 +866,7 @@ static struct sock_addr_test tests[] = {
 		"recvmsg4: recvfrom (dgram)",
 		recvmsg4_prog_load,
 		recvmsg4_prog_destroy,
+		BPF_CGROUP_UDP4_RECVMSG,
 		&user_ops,
 		AF_INET,
 		SOCK_DGRAM,
@@ -794,12 +875,14 @@ static struct sock_addr_test tests[] = {
 		SERV4_REWRITE_IP,
 		SERV4_REWRITE_PORT,
 		SERV4_IP,
+		SUCCESS,
 	},
 	{
 		SOCK_ADDR_TEST_RECVMSG,
 		"recvmsg6: recvfrom (dgram)",
 		recvmsg6_prog_load,
 		recvmsg6_prog_destroy,
+		BPF_CGROUP_UDP6_RECVMSG,
 		&user_ops,
 		AF_INET6,
 		SOCK_DGRAM,
@@ -808,12 +891,14 @@ static struct sock_addr_test tests[] = {
 		SERV6_REWRITE_IP,
 		SERV6_REWRITE_PORT,
 		SERV6_IP,
+		SUCCESS,
 	},
 	{
 		SOCK_ADDR_TEST_RECVMSG,
 		"recvmsg_unix: recvfrom (dgram)",
 		recvmsg_unix_prog_load,
 		recvmsg_unix_prog_destroy,
+		BPF_CGROUP_UNIX_RECVMSG,
 		&user_ops,
 		AF_UNIX,
 		SOCK_DGRAM,
@@ -822,12 +907,14 @@ static struct sock_addr_test tests[] = {
 		SERVUN_REWRITE_ADDRESS,
 		0,
 		SERVUN_ADDRESS,
+		SUCCESS,
 	},
 	{
 		SOCK_ADDR_TEST_RECVMSG,
 		"recvmsg_unix: recvfrom (stream)",
 		recvmsg_unix_prog_load,
 		recvmsg_unix_prog_destroy,
+		BPF_CGROUP_UNIX_RECVMSG,
 		&user_ops,
 		AF_UNIX,
 		SOCK_STREAM,
@@ -836,6 +923,7 @@ static struct sock_addr_test tests[] = {
 		SERVUN_REWRITE_ADDRESS,
 		0,
 		SERVUN_ADDRESS,
+		SUCCESS,
 	},
 
 	/* getsockname - system calls */
@@ -844,6 +932,7 @@ static struct sock_addr_test tests[] = {
 		"getsockname_unix",
 		getsockname_unix_prog_load,
 		getsockname_unix_prog_destroy,
+		BPF_CGROUP_UNIX_GETSOCKNAME,
 		&user_ops,
 		AF_UNIX,
 		SOCK_STREAM,
@@ -852,6 +941,7 @@ static struct sock_addr_test tests[] = {
 		SERVUN_REWRITE_ADDRESS,
 		0,
 		NULL,
+		SUCCESS,
 	},
 
 	/* getpeername - system calls */
@@ -860,6 +950,7 @@ static struct sock_addr_test tests[] = {
 		"getpeername_unix",
 		getpeername_unix_prog_load,
 		getpeername_unix_prog_destroy,
+		BPF_CGROUP_UNIX_GETPEERNAME,
 		&user_ops,
 		AF_UNIX,
 		SOCK_STREAM,
@@ -868,6 +959,7 @@ static struct sock_addr_test tests[] = {
 		SERVUN_REWRITE_ADDRESS,
 		0,
 		NULL,
+		SUCCESS,
 	},
 };
 
@@ -1249,7 +1341,8 @@ void test_sock_addr(void)
 		if (!test__start_subtest(test->name))
 			continue;
 
-		skel = test->loadfn(cgroup_fd);
+		skel = test->loadfn(cgroup_fd, test->attach_type,
+				    test->expected_result == LOAD_REJECT);
 		if (!skel)
 			continue;
 
-- 
2.45.0.118.g7fe29c98d7-goog


