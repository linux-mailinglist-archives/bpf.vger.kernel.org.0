Return-Path: <bpf+bounces-29508-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B45DA8C2A4C
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 21:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D752C1C223EB
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 19:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D2D45C10;
	Fri, 10 May 2024 19:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T+3Bi89L"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D8448CE0
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 19:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715367796; cv=none; b=l2jfeYVIZlpv1dUq7Hl5lwfN7j9CW6kVbFZCLt+aRLDfXuogq2JlrQwWDm9JFe+LfGQE47gfhKqvCpKIWX1SURWrjPQSCwPBaVb4dwN1g5GAZF/+Fw9oKvGvwL7RVG6Y6I1TBp8lDgYBqX9sEMtENA+YYmv4EC5oSq/R9QJGXYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715367796; c=relaxed/simple;
	bh=bRcw1943cH77mG2/ZP6FPr847/uKREi3NhnnCguvWNg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OVmMUV4hKbg5W4sShJXl/xysQMHaWExVpyAHD/Tb/un3EpFCV9FBR+lXOcTvlwg0cMHyMI/et11AAbRTjrI9OtWXCAvwy2g0vH2EUjW0TEGNv5dhGMWD44PCoreVEPrLA2AHQHCXwpEAKVT2Na8yPxPDUB5ooVDiWgoHjoLIoeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T+3Bi89L; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de61a10141fso3341583276.1
        for <bpf@vger.kernel.org>; Fri, 10 May 2024 12:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715367794; x=1715972594; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r9uR3cPOO2I0btChfqLpnIYWCHE0wNIxkZ7R2oIXmu4=;
        b=T+3Bi89LMjj0OT2qPysx1WdyrTshd13wnnj+KMiIAGEJ3Aonzj46GnRPXIQ/0FgqkC
         WrXQu7db71DXea+pEpFVRbYXZIix11N6lzL6spEA37LLCqnLBZ+B+RCnlKdkzgM7GD9C
         LTa63YtlbsdIRCbgNJ9znh+kQBBFLTl6XsAVI1EU6Bj3/L8sbyuBEV/0jjoRwebdKKrM
         Cjd1UTWI8vXCUoNoZh2tg2hnBtj5IGsQKp/n6xeo1U0C8nQdNKucPn4DkdpLUsThLIvj
         M4bVRn9ZuLyY1Q5HKdKDsojwZKXnBMpk+tBKDrGrFUumoI0JS7jFx0NVqdCnqo/D1u/e
         SPWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715367794; x=1715972594;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r9uR3cPOO2I0btChfqLpnIYWCHE0wNIxkZ7R2oIXmu4=;
        b=iJsP8WODzG81IPs1spON/XxtL0mSy63/YO1AMSPUuW9eMaDczMmrJLbaDxjByFBbMP
         Gqw9tXzI+gn9czg1rnnFOzAN8CH4sRxZduOQpFintOF1SvU54+1P9ppFckL9Bpdy+NZR
         92FF2ae/l5JGt7SqYcNrqxf4DlEMSH/epvsllwrnbBv56D/tcCrFhM1e/M6Zg1BsMdKh
         zWm8to3B5TnT5SJSEreuM5Jby9PXChcr+JoRZ9C+zlxt3Xb0JA+/LWlAavHi33jfSh1S
         Vu5NXKr/y9v4A2Uu5OeaZn7tPhpVkd4qEieNmxONgPG0q9U4EExl0pdsG0rHd92Jd1Q5
         fCcQ==
X-Gm-Message-State: AOJu0YxGJ8GSPP5xwC3tA4Sy8di/NOFEZ5mszQqiwzVUe0DuaGjXxiez
	MQ2A28uWGS48ClhILaN4t5SxUa0CvpRP+EhDcM7cDGUwIirBNwOoTkcqDNpc/Pb1n6hJkgLxXeP
	EXDIDvTfmHLOn87GP27on1g4aflzLjxVpJQOBe0kbsK/yGuGLZ7k/TFhp5imbiYHcl4XSdSo3aw
	2h5ZNNPEc9oju3/ojOWghskpQ=
X-Google-Smtp-Source: AGHT+IExMfyEtNP5nY9FWVOf4elIuRS+nOct7NTPxs0AoYN7KiRd1mdk1gSXpLfdshqClFW4EjkLP3FB6Q==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a25:1982:0:b0:dcd:2f3e:4d18 with SMTP id
 3f1490d57ef6-dee4f364f84mr276030276.12.1715367793177; Fri, 10 May 2024
 12:03:13 -0700 (PDT)
Date: Fri, 10 May 2024 14:02:32 -0500
In-Reply-To: <20240510190246.3247730-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510190246.3247730-1-jrife@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510190246.3247730-16-jrife@google.com>
Subject: [PATCH v1 bpf-next 15/17] sefltests/bpf: Expand sockaddr hook deny tests
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

This patch expands test coverage for EPERM tests to include connect and
bind calls and rounds out the coverage for sendmsg by adding tests for
sendmsg_unix.

Signed-off-by: Jordan Rife <jrife@google.com>
---
 .../selftests/bpf/prog_tests/sock_addr.c      | 342 ++++++++++++++++++
 .../testing/selftests/bpf/progs/bind4_prog.c  |   6 +
 .../testing/selftests/bpf/progs/bind6_prog.c  |   6 +
 .../selftests/bpf/progs/connect4_prog.c       |   6 +
 .../selftests/bpf/progs/connect6_prog.c       |   6 +
 .../selftests/bpf/progs/connect_unix_prog.c   |   6 +
 .../selftests/bpf/progs/sendmsg_unix_prog.c   |   6 +
 7 files changed, 378 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_addr.c b/tools/testing/selftests/bpf/prog_tests/sock_addr.c
index ebd5e58e38c5c..0477b4080b2e8 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_addr.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_addr.c
@@ -439,13 +439,18 @@ static void prog_name##_destroy(void *skel) \
 
 BPF_SKEL_FUNCS(bind4_prog, bind_v4_prog);
 BPF_SKEL_FUNCS_RAW(bind4_prog, bind_v4_prog);
+BPF_SKEL_FUNCS(bind4_prog, bind_v4_deny_prog);
 BPF_SKEL_FUNCS(bind6_prog, bind_v6_prog);
 BPF_SKEL_FUNCS_RAW(bind6_prog, bind_v6_prog);
+BPF_SKEL_FUNCS(bind6_prog, bind_v6_deny_prog);
 BPF_SKEL_FUNCS(connect4_prog, connect_v4_prog);
 BPF_SKEL_FUNCS_RAW(connect4_prog, connect_v4_prog);
+BPF_SKEL_FUNCS(connect4_prog, connect_v4_deny_prog);
 BPF_SKEL_FUNCS(connect6_prog, connect_v6_prog);
 BPF_SKEL_FUNCS_RAW(connect6_prog, connect_v6_prog);
+BPF_SKEL_FUNCS(connect6_prog, connect_v6_deny_prog);
 BPF_SKEL_FUNCS(connect_unix_prog, connect_unix_prog);
+BPF_SKEL_FUNCS(connect_unix_prog, connect_unix_deny_prog);
 BPF_SKEL_FUNCS(sendmsg4_prog, sendmsg_v4_prog);
 BPF_SKEL_FUNCS_RAW(sendmsg4_prog, sendmsg_v4_prog);
 BPF_SKEL_FUNCS(sendmsg4_prog, sendmsg_v4_deny_prog);
@@ -456,6 +461,7 @@ BPF_SKEL_FUNCS(sendmsg6_prog, sendmsg_v6_preserve_dst_prog);
 BPF_SKEL_FUNCS(sendmsg6_prog, sendmsg_v6_v4mapped_prog);
 BPF_SKEL_FUNCS(sendmsg6_prog, sendmsg_v6_wildcard_prog);
 BPF_SKEL_FUNCS(sendmsg_unix_prog, sendmsg_unix_prog);
+BPF_SKEL_FUNCS(sendmsg_unix_prog, sendmsg_unix_deny_prog);
 BPF_SKEL_FUNCS(recvmsg4_prog, recvmsg4_prog);
 BPF_SKEL_FUNCS(recvmsg6_prog, recvmsg6_prog);
 BPF_SKEL_FUNCS(recvmsg_unix_prog, recvmsg_unix_prog);
@@ -480,6 +486,22 @@ static struct sock_addr_test tests[] = {
 		NULL,
 		SUCCESS,
 	},
+	{
+		SOCK_ADDR_TEST_BIND,
+		"bind4: bind deny (stream)",
+		bind_v4_deny_prog_load,
+		bind_v4_deny_prog_destroy,
+		BPF_CGROUP_INET4_BIND,
+		&user_ops,
+		AF_INET,
+		SOCK_STREAM,
+		SERV4_IP,
+		SERV4_PORT,
+		SERV4_REWRITE_IP,
+		SERV4_REWRITE_PORT,
+		NULL,
+		SYSCALL_EPERM,
+	},
 	{
 		SOCK_ADDR_TEST_BIND,
 		"bind4: bind (dgram)",
@@ -496,6 +518,22 @@ static struct sock_addr_test tests[] = {
 		NULL,
 		SUCCESS,
 	},
+	{
+		SOCK_ADDR_TEST_BIND,
+		"bind4: bind deny (dgram)",
+		bind_v4_deny_prog_load,
+		bind_v4_deny_prog_destroy,
+		BPF_CGROUP_INET4_BIND,
+		&user_ops,
+		AF_INET,
+		SOCK_DGRAM,
+		SERV4_IP,
+		SERV4_PORT,
+		SERV4_REWRITE_IP,
+		SERV4_REWRITE_PORT,
+		NULL,
+		SYSCALL_EPERM,
+	},
 	{
 		SOCK_ADDR_TEST_BIND,
 		"bind4: load prog with wrong expected attach type",
@@ -544,6 +582,22 @@ static struct sock_addr_test tests[] = {
 		NULL,
 		SUCCESS,
 	},
+	{
+		SOCK_ADDR_TEST_BIND,
+		"bind6: bind deny (stream)",
+		bind_v6_deny_prog_load,
+		bind_v6_deny_prog_destroy,
+		BPF_CGROUP_INET6_BIND,
+		&user_ops,
+		AF_INET6,
+		SOCK_STREAM,
+		SERV6_IP,
+		SERV6_PORT,
+		SERV6_REWRITE_IP,
+		SERV6_REWRITE_PORT,
+		NULL,
+		SYSCALL_EPERM,
+	},
 	{
 		SOCK_ADDR_TEST_BIND,
 		"bind6: bind (dgram)",
@@ -560,6 +614,22 @@ static struct sock_addr_test tests[] = {
 		NULL,
 		SUCCESS,
 	},
+	{
+		SOCK_ADDR_TEST_BIND,
+		"bind6: bind deny (dgram)",
+		bind_v6_deny_prog_load,
+		bind_v6_deny_prog_destroy,
+		BPF_CGROUP_INET6_BIND,
+		&user_ops,
+		AF_INET6,
+		SOCK_DGRAM,
+		SERV6_IP,
+		SERV6_PORT,
+		SERV6_REWRITE_IP,
+		SERV6_REWRITE_PORT,
+		NULL,
+		SYSCALL_EPERM,
+	},
 	{
 		SOCK_ADDR_TEST_BIND,
 		"bind6: load prog with wrong expected attach type",
@@ -610,6 +680,22 @@ static struct sock_addr_test tests[] = {
 		NULL,
 		SUCCESS,
 	},
+	{
+		SOCK_ADDR_TEST_BIND,
+		"bind4: kernel_bind deny (stream)",
+		bind_v4_deny_prog_load,
+		bind_v4_deny_prog_destroy,
+		BPF_CGROUP_INET4_BIND,
+		&kern_ops_sock_sendmsg,
+		AF_INET,
+		SOCK_STREAM,
+		SERV4_IP,
+		SERV4_PORT,
+		SERV4_REWRITE_IP,
+		SERV4_REWRITE_PORT,
+		NULL,
+		SYSCALL_EPERM,
+	},
 	{
 		SOCK_ADDR_TEST_BIND,
 		"bind4: kernel_bind (dgram)",
@@ -626,6 +712,22 @@ static struct sock_addr_test tests[] = {
 		NULL,
 		SUCCESS,
 	},
+	{
+		SOCK_ADDR_TEST_BIND,
+		"bind4: kernel_bind deny (dgram)",
+		bind_v4_deny_prog_load,
+		bind_v4_deny_prog_destroy,
+		BPF_CGROUP_INET4_BIND,
+		&kern_ops_sock_sendmsg,
+		AF_INET,
+		SOCK_DGRAM,
+		SERV4_IP,
+		SERV4_PORT,
+		SERV4_REWRITE_IP,
+		SERV4_REWRITE_PORT,
+		NULL,
+		SYSCALL_EPERM,
+	},
 	{
 		SOCK_ADDR_TEST_BIND,
 		"bind6: kernel_bind (stream)",
@@ -642,6 +744,22 @@ static struct sock_addr_test tests[] = {
 		NULL,
 		SUCCESS,
 	},
+	{
+		SOCK_ADDR_TEST_BIND,
+		"bind6: kernel_bind deny (stream)",
+		bind_v6_deny_prog_load,
+		bind_v6_deny_prog_destroy,
+		BPF_CGROUP_INET6_BIND,
+		&kern_ops_sock_sendmsg,
+		AF_INET6,
+		SOCK_STREAM,
+		SERV6_IP,
+		SERV6_PORT,
+		SERV6_REWRITE_IP,
+		SERV6_REWRITE_PORT,
+		NULL,
+		SYSCALL_EPERM,
+	},
 	{
 		SOCK_ADDR_TEST_BIND,
 		"bind6: kernel_bind (dgram)",
@@ -658,6 +776,22 @@ static struct sock_addr_test tests[] = {
 		NULL,
 		SUCCESS,
 	},
+	{
+		SOCK_ADDR_TEST_BIND,
+		"bind6: kernel_bind deny (dgram)",
+		bind_v6_deny_prog_load,
+		bind_v6_deny_prog_destroy,
+		BPF_CGROUP_INET6_BIND,
+		&kern_ops_sock_sendmsg,
+		AF_INET6,
+		SOCK_DGRAM,
+		SERV6_IP,
+		SERV6_PORT,
+		SERV6_REWRITE_IP,
+		SERV6_REWRITE_PORT,
+		NULL,
+		SYSCALL_EPERM,
+	},
 
 	/* connect - system calls */
 	{
@@ -676,6 +810,22 @@ static struct sock_addr_test tests[] = {
 		SRC4_REWRITE_IP,
 		SUCCESS,
 	},
+	{
+		SOCK_ADDR_TEST_CONNECT,
+		"connect4: connect deny (stream)",
+		connect_v4_deny_prog_load,
+		connect_v4_deny_prog_destroy,
+		BPF_CGROUP_INET4_CONNECT,
+		&user_ops,
+		AF_INET,
+		SOCK_STREAM,
+		SERV4_IP,
+		SERV4_PORT,
+		SERV4_REWRITE_IP,
+		SERV4_REWRITE_PORT,
+		SRC4_REWRITE_IP,
+		SYSCALL_EPERM,
+	},
 	{
 		SOCK_ADDR_TEST_CONNECT,
 		"connect4: connect (dgram)",
@@ -692,6 +842,22 @@ static struct sock_addr_test tests[] = {
 		SRC4_REWRITE_IP,
 		SUCCESS,
 	},
+	{
+		SOCK_ADDR_TEST_CONNECT,
+		"connect4: connect deny (dgram)",
+		connect_v4_deny_prog_load,
+		connect_v4_deny_prog_destroy,
+		BPF_CGROUP_INET4_CONNECT,
+		&user_ops,
+		AF_INET,
+		SOCK_DGRAM,
+		SERV4_IP,
+		SERV4_PORT,
+		SERV4_REWRITE_IP,
+		SERV4_REWRITE_PORT,
+		SRC4_REWRITE_IP,
+		SYSCALL_EPERM,
+	},
 	{
 		SOCK_ADDR_TEST_CONNECT,
 		"connect4: load prog with wrong expected attach type",
@@ -740,6 +906,22 @@ static struct sock_addr_test tests[] = {
 		SRC6_REWRITE_IP,
 		SUCCESS,
 	},
+	{
+		SOCK_ADDR_TEST_CONNECT,
+		"connect6: connect deny (stream)",
+		connect_v6_deny_prog_load,
+		connect_v6_deny_prog_destroy,
+		BPF_CGROUP_INET6_CONNECT,
+		&user_ops,
+		AF_INET6,
+		SOCK_STREAM,
+		SERV6_IP,
+		SERV6_PORT,
+		SERV6_REWRITE_IP,
+		SERV6_REWRITE_PORT,
+		SRC6_REWRITE_IP,
+		SYSCALL_EPERM,
+	},
 	{
 		SOCK_ADDR_TEST_CONNECT,
 		"connect6: connect (dgram)",
@@ -756,6 +938,22 @@ static struct sock_addr_test tests[] = {
 		SRC6_REWRITE_IP,
 		SUCCESS,
 	},
+	{
+		SOCK_ADDR_TEST_CONNECT,
+		"connect6: connect deny (dgram)",
+		connect_v6_deny_prog_load,
+		connect_v6_deny_prog_destroy,
+		BPF_CGROUP_INET6_CONNECT,
+		&user_ops,
+		AF_INET6,
+		SOCK_DGRAM,
+		SERV6_IP,
+		SERV6_PORT,
+		SERV6_REWRITE_IP,
+		SERV6_REWRITE_PORT,
+		SRC6_REWRITE_IP,
+		SYSCALL_EPERM,
+	},
 	{
 		SOCK_ADDR_TEST_CONNECT,
 		"connect6: load prog with wrong expected attach type",
@@ -804,6 +1002,22 @@ static struct sock_addr_test tests[] = {
 		NULL,
 		SUCCESS,
 	},
+	{
+		SOCK_ADDR_TEST_CONNECT,
+		"connect_unix: connect deny (stream)",
+		connect_unix_deny_prog_load,
+		connect_unix_deny_prog_destroy,
+		BPF_CGROUP_UNIX_CONNECT,
+		&user_ops,
+		AF_UNIX,
+		SOCK_STREAM,
+		SERVUN_ADDRESS,
+		0,
+		SERVUN_REWRITE_ADDRESS,
+		0,
+		NULL,
+		SYSCALL_EPERM,
+	},
 
 	/* connect - kernel calls */
 	{
@@ -822,6 +1036,22 @@ static struct sock_addr_test tests[] = {
 		SRC4_REWRITE_IP,
 		SUCCESS,
 	},
+	{
+		SOCK_ADDR_TEST_CONNECT,
+		"connect4: kernel_connect deny (stream)",
+		connect_v4_deny_prog_load,
+		connect_v4_deny_prog_destroy,
+		BPF_CGROUP_INET4_CONNECT,
+		&kern_ops_sock_sendmsg,
+		AF_INET,
+		SOCK_STREAM,
+		SERV4_IP,
+		SERV4_PORT,
+		SERV4_REWRITE_IP,
+		SERV4_REWRITE_PORT,
+		SRC4_REWRITE_IP,
+		SYSCALL_EPERM,
+	},
 	{
 		SOCK_ADDR_TEST_CONNECT,
 		"connect4: kernel_connect (dgram)",
@@ -838,6 +1068,22 @@ static struct sock_addr_test tests[] = {
 		SRC4_REWRITE_IP,
 		SUCCESS,
 	},
+	{
+		SOCK_ADDR_TEST_CONNECT,
+		"connect4: kernel_connect deny (dgram)",
+		connect_v4_deny_prog_load,
+		connect_v4_deny_prog_destroy,
+		BPF_CGROUP_INET4_CONNECT,
+		&kern_ops_sock_sendmsg,
+		AF_INET,
+		SOCK_DGRAM,
+		SERV4_IP,
+		SERV4_PORT,
+		SERV4_REWRITE_IP,
+		SERV4_REWRITE_PORT,
+		SRC4_REWRITE_IP,
+		SYSCALL_EPERM,
+	},
 	{
 		SOCK_ADDR_TEST_CONNECT,
 		"connect6: kernel_connect (stream)",
@@ -854,6 +1100,22 @@ static struct sock_addr_test tests[] = {
 		SRC6_REWRITE_IP,
 		SUCCESS,
 	},
+	{
+		SOCK_ADDR_TEST_CONNECT,
+		"connect6: kernel_connect deny (stream)",
+		connect_v6_deny_prog_load,
+		connect_v6_deny_prog_destroy,
+		BPF_CGROUP_INET6_CONNECT,
+		&kern_ops_sock_sendmsg,
+		AF_INET6,
+		SOCK_STREAM,
+		SERV6_IP,
+		SERV6_PORT,
+		SERV6_REWRITE_IP,
+		SERV6_REWRITE_PORT,
+		SRC6_REWRITE_IP,
+		SYSCALL_EPERM,
+	},
 	{
 		SOCK_ADDR_TEST_CONNECT,
 		"connect6: kernel_connect (dgram)",
@@ -870,6 +1132,22 @@ static struct sock_addr_test tests[] = {
 		SRC6_REWRITE_IP,
 		SUCCESS,
 	},
+	{
+		SOCK_ADDR_TEST_CONNECT,
+		"connect6: kernel_connect deny (dgram)",
+		connect_v6_deny_prog_load,
+		connect_v6_deny_prog_destroy,
+		BPF_CGROUP_INET6_CONNECT,
+		&kern_ops_sock_sendmsg,
+		AF_INET6,
+		SOCK_DGRAM,
+		SERV6_IP,
+		SERV6_PORT,
+		SERV6_REWRITE_IP,
+		SERV6_REWRITE_PORT,
+		SRC6_REWRITE_IP,
+		SYSCALL_EPERM,
+	},
 	{
 		SOCK_ADDR_TEST_CONNECT,
 		"connect_unix: kernel_connect (dgram)",
@@ -886,6 +1164,22 @@ static struct sock_addr_test tests[] = {
 		NULL,
 		SUCCESS,
 	},
+	{
+		SOCK_ADDR_TEST_CONNECT,
+		"connect_unix: kernel_connect deny (dgram)",
+		connect_unix_deny_prog_load,
+		connect_unix_deny_prog_destroy,
+		BPF_CGROUP_UNIX_CONNECT,
+		&kern_ops_sock_sendmsg,
+		AF_UNIX,
+		SOCK_STREAM,
+		SERVUN_ADDRESS,
+		0,
+		SERVUN_REWRITE_ADDRESS,
+		0,
+		NULL,
+		SYSCALL_EPERM,
+	},
 
 	/* sendmsg - system calls */
 	{
@@ -1080,6 +1374,22 @@ static struct sock_addr_test tests[] = {
 		NULL,
 		SUCCESS,
 	},
+	{
+		SOCK_ADDR_TEST_SENDMSG,
+		"sendmsg_unix: sendmsg deny (dgram)",
+		sendmsg_unix_deny_prog_load,
+		sendmsg_unix_deny_prog_destroy,
+		BPF_CGROUP_UNIX_SENDMSG,
+		&user_ops,
+		AF_UNIX,
+		SOCK_DGRAM,
+		SERVUN_ADDRESS,
+		0,
+		SERVUN_REWRITE_ADDRESS,
+		0,
+		NULL,
+		SYSCALL_EPERM,
+	},
 
 	/* sendmsg - kernel calls (sock_sendmsg) */
 	{
@@ -1178,6 +1488,22 @@ static struct sock_addr_test tests[] = {
 		NULL,
 		SUCCESS,
 	},
+	{
+		SOCK_ADDR_TEST_SENDMSG,
+		"sendmsg_unix: sock_sendmsg deny (dgram)",
+		sendmsg_unix_deny_prog_load,
+		sendmsg_unix_deny_prog_destroy,
+		BPF_CGROUP_UNIX_SENDMSG,
+		&kern_ops_sock_sendmsg,
+		AF_UNIX,
+		SOCK_DGRAM,
+		SERVUN_ADDRESS,
+		0,
+		SERVUN_REWRITE_ADDRESS,
+		0,
+		NULL,
+		SYSCALL_EPERM,
+	},
 
 	/* sendmsg - kernel calls (kernel_sendmsg) */
 	{
@@ -1276,6 +1602,22 @@ static struct sock_addr_test tests[] = {
 		NULL,
 		SUCCESS,
 	},
+	{
+		SOCK_ADDR_TEST_SENDMSG,
+		"sendmsg_unix: kernel_sendmsg deny (dgram)",
+		sendmsg_unix_deny_prog_load,
+		sendmsg_unix_deny_prog_destroy,
+		BPF_CGROUP_UNIX_SENDMSG,
+		&kern_ops_kernel_sendmsg,
+		AF_UNIX,
+		SOCK_DGRAM,
+		SERVUN_ADDRESS,
+		0,
+		SERVUN_REWRITE_ADDRESS,
+		0,
+		NULL,
+		SYSCALL_EPERM,
+	},
 
 	/* recvmsg - system calls */
 	{
diff --git a/tools/testing/selftests/bpf/progs/bind4_prog.c b/tools/testing/selftests/bpf/progs/bind4_prog.c
index 66005c1a5b367..b7ddf8ec4ee89 100644
--- a/tools/testing/selftests/bpf/progs/bind4_prog.c
+++ b/tools/testing/selftests/bpf/progs/bind4_prog.c
@@ -158,4 +158,10 @@ int bind_v4_prog(struct bpf_sock_addr *ctx)
 	return 1;
 }
 
+SEC("cgroup/bind4")
+int bind_v4_deny_prog(struct bpf_sock_addr *ctx)
+{
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/bind6_prog.c b/tools/testing/selftests/bpf/progs/bind6_prog.c
index 9c86c712348cf..501c3fc11d356 100644
--- a/tools/testing/selftests/bpf/progs/bind6_prog.c
+++ b/tools/testing/selftests/bpf/progs/bind6_prog.c
@@ -175,4 +175,10 @@ int bind_v6_prog(struct bpf_sock_addr *ctx)
 	return 1;
 }
 
+SEC("cgroup/bind6")
+int bind_v6_deny_prog(struct bpf_sock_addr *ctx)
+{
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/connect4_prog.c b/tools/testing/selftests/bpf/progs/connect4_prog.c
index bec529da7c9d2..9e9ebf27b8784 100644
--- a/tools/testing/selftests/bpf/progs/connect4_prog.c
+++ b/tools/testing/selftests/bpf/progs/connect4_prog.c
@@ -199,4 +199,10 @@ int connect_v4_prog(struct bpf_sock_addr *ctx)
 	return do_bind(ctx) ? 1 : 0;
 }
 
+SEC("cgroup/connect4")
+int connect_v4_deny_prog(struct bpf_sock_addr *ctx)
+{
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/connect6_prog.c b/tools/testing/selftests/bpf/progs/connect6_prog.c
index 40266d2c737c2..e98573b00ddb2 100644
--- a/tools/testing/selftests/bpf/progs/connect6_prog.c
+++ b/tools/testing/selftests/bpf/progs/connect6_prog.c
@@ -90,4 +90,10 @@ int connect_v6_prog(struct bpf_sock_addr *ctx)
 	return 1;
 }
 
+SEC("cgroup/connect6")
+int connect_v6_deny_prog(struct bpf_sock_addr *ctx)
+{
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/connect_unix_prog.c b/tools/testing/selftests/bpf/progs/connect_unix_prog.c
index 2ef0e0c46d17b..ba60adadb3355 100644
--- a/tools/testing/selftests/bpf/progs/connect_unix_prog.c
+++ b/tools/testing/selftests/bpf/progs/connect_unix_prog.c
@@ -36,4 +36,10 @@ int connect_unix_prog(struct bpf_sock_addr *ctx)
 	return 1;
 }
 
+SEC("cgroup/connect_unix")
+int connect_unix_deny_prog(struct bpf_sock_addr *ctx)
+{
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/sendmsg_unix_prog.c b/tools/testing/selftests/bpf/progs/sendmsg_unix_prog.c
index d8869b03dda9b..332d0eb1116f8 100644
--- a/tools/testing/selftests/bpf/progs/sendmsg_unix_prog.c
+++ b/tools/testing/selftests/bpf/progs/sendmsg_unix_prog.c
@@ -36,4 +36,10 @@ int sendmsg_unix_prog(struct bpf_sock_addr *ctx)
 	return 1;
 }
 
+SEC("cgroup/sendmsg_unix")
+int sendmsg_unix_deny_prog(struct bpf_sock_addr *ctx)
+{
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.45.0.118.g7fe29c98d7-goog


