Return-Path: <bpf+bounces-29510-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 571EC8C2A50
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 21:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C21761F21BC8
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 19:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF694C61B;
	Fri, 10 May 2024 19:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SwD3aY8S"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4A14AEDA
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 19:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715367799; cv=none; b=WqSp9Z20qx2G+hNqjDK6tt5Urd78DUkFl5ChdA2UQVSQlgMAwXsDIOdzofqlMOxfBthz+ab/JuhBmpMeph2L6ou3tPek4MY8mpzKph+ykYRBvy7kqq9GAB84aNjFm62EujBLCrOQWzuvfhI+hGBZVH6pZfHPfgFIpzH0LM/1p9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715367799; c=relaxed/simple;
	bh=QPt649Dq3mtHzhRuSP7r3zVF2ZsUvH7Go6Z0gBLMFMs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tyojjtkbNugkPOWcncxSscb8jtQ1Cuz4R6mv1Al8O4P4KlmvrAbuOWIj4M5gPBlgKigE3ycVOUf+bjK6gBn/ymgI5ScyOmTWDfYzIIZZpcv8zhQM+VWBDkWaJbWw6NKIAvpS2+PCqCrBY7Bdaebx6pdM/n8BrhARQMlZdKuch04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SwD3aY8S; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-7e1ac2fbcb7so217981139f.0
        for <bpf@vger.kernel.org>; Fri, 10 May 2024 12:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715367797; x=1715972597; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IbaVMkO2P+QgmzRRc4Phg/jScUnbUBiKXRLvfEhKm3I=;
        b=SwD3aY8Srhw9bA5wHdZY72yS3ztIZ6Am7p6Bgomy5toaB4BgFluJvSzG4WHymFGgfV
         PX8NHAICDPDt6he9s9T6mVOB4LI8eZL32NT7gbjOBO0iWSoTRWBvSmmsUV1q+fISZYX8
         qo9CeA43EraCEDk6xBfq09exFDu/kYANyJrbwdzHVJ+mcSopTlcV7kEg2MNwIiCF58FH
         LygpdNKdzABBloBE2mX97r7ntw6/GO9h4uqK9RVcS7E2VVg2HB5UKTYwlqkZv22D+ga/
         hWtITy+ngfKLrBr9XKNIX4zH23fYC3A73T+5fj3B+7LhFTnBnlBWJMTKwEO6llhx0gtb
         ucLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715367797; x=1715972597;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IbaVMkO2P+QgmzRRc4Phg/jScUnbUBiKXRLvfEhKm3I=;
        b=A974Hy2OKCFw6x3SxZv1WGxmsawwUw1tFjxdEolWjQgV3R9r+IvjJNP4fIQ8wkCDfI
         H1mGEsSxM8nGuh0+H7WmzrV3vH/pgiQWRqaGFGnjrQHd1oOEGs+uUGLhNBP4OLnbfhzc
         /I7vJyliIt9tD1oLieD5vTVFFE3aGV32LNXBqD+H8MXbi1tRU2C/tR9lUXYcPu2v6Mo6
         MTpcpdv/HYDumeIWKhpmGLOYDBE2smuCLKAvyvtk2xjeODedfNM5Tf6m8q+wGQk37Lc/
         TR4hxars4Ls1WBWFSk2WMYAI8sr0qG23xYv1NMgBy7XxXaDKrQ1dHoQmYp+yrGU/miew
         G2aw==
X-Gm-Message-State: AOJu0YyQXEfXxYF4StmopvCb5Fmod5KXWg2wycw27Sz/w5tLVJbmUFie
	f3P1vvUfMec7ZS4H8Y1tLARPjuKpobvVP9C+r1erqWAU5h11r0clLHqMBK1JWMDW9iQSAtpU1hu
	//qmMmLvQ2seYpXclUKQ8u6ERjeMoXoXm13iZf/O7HcZNuK2tWX4AbXBvZx5FSA0BFjHP8rCd0L
	2uKKvW10ArHmuONNpoGCYmfio=
X-Google-Smtp-Source: AGHT+IE7+mASQWmwirWTE6yXAEFJCe7/EnyVUryg635Q/JMBNIpF0Ze9+QR3WVcNWK828oKdagiV0KtiyA==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a05:6638:379a:b0:488:d489:3940 with SMTP id
 8926c6da1cb9f-48958c05a44mr197721173.3.1715367796897; Fri, 10 May 2024
 12:03:16 -0700 (PDT)
Date: Fri, 10 May 2024 14:02:34 -0500
In-Reply-To: <20240510190246.3247730-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510190246.3247730-1-jrife@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510190246.3247730-18-jrife@google.com>
Subject: [PATCH v1 bpf-next 17/17] selftests/bpf: Expand ATTACH_REJECT tests
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

This expands coverage for ATTACH_REJECT tests to include connect_unix,
sendmsg_unix, recvmsg*, getsockname*, and getpeername*.

Signed-off-by: Jordan Rife <jrife@google.com>
---
 .../selftests/bpf/prog_tests/sock_addr.c      | 187 ++++++++++++++++++
 1 file changed, 187 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_addr.c b/tools/testing/selftests/bpf/prog_tests/sock_addr.c
index a0a40bdcfe45c..b880c564a2047 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_addr.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_addr.c
@@ -454,6 +454,7 @@ BPF_SKEL_FUNCS(connect6_prog, connect_v6_prog);
 BPF_SKEL_FUNCS_RAW(connect6_prog, connect_v6_prog);
 BPF_SKEL_FUNCS(connect6_prog, connect_v6_deny_prog);
 BPF_SKEL_FUNCS(connect_unix_prog, connect_unix_prog);
+BPF_SKEL_FUNCS_RAW(connect_unix_prog, connect_unix_prog);
 BPF_SKEL_FUNCS(connect_unix_prog, connect_unix_deny_prog);
 BPF_SKEL_FUNCS(sendmsg4_prog, sendmsg_v4_prog);
 BPF_SKEL_FUNCS_RAW(sendmsg4_prog, sendmsg_v4_prog);
@@ -465,16 +466,26 @@ BPF_SKEL_FUNCS(sendmsg6_prog, sendmsg_v6_preserve_dst_prog);
 BPF_SKEL_FUNCS(sendmsg6_prog, sendmsg_v6_v4mapped_prog);
 BPF_SKEL_FUNCS(sendmsg6_prog, sendmsg_v6_wildcard_prog);
 BPF_SKEL_FUNCS(sendmsg_unix_prog, sendmsg_unix_prog);
+BPF_SKEL_FUNCS_RAW(sendmsg_unix_prog, sendmsg_unix_prog);
 BPF_SKEL_FUNCS(sendmsg_unix_prog, sendmsg_unix_deny_prog);
 BPF_SKEL_FUNCS(recvmsg4_prog, recvmsg4_prog);
+BPF_SKEL_FUNCS_RAW(recvmsg4_prog, recvmsg4_prog);
 BPF_SKEL_FUNCS(recvmsg6_prog, recvmsg6_prog);
+BPF_SKEL_FUNCS_RAW(recvmsg6_prog, recvmsg6_prog);
 BPF_SKEL_FUNCS(recvmsg_unix_prog, recvmsg_unix_prog);
+BPF_SKEL_FUNCS_RAW(recvmsg_unix_prog, recvmsg_unix_prog);
 BPF_SKEL_FUNCS(getsockname_unix_prog, getsockname_unix_prog);
+BPF_SKEL_FUNCS_RAW(getsockname_unix_prog, getsockname_unix_prog);
 BPF_SKEL_FUNCS(getsockname4_prog, getsockname_v4_prog);
+BPF_SKEL_FUNCS_RAW(getsockname4_prog, getsockname_v4_prog);
 BPF_SKEL_FUNCS(getsockname6_prog, getsockname_v6_prog);
+BPF_SKEL_FUNCS_RAW(getsockname6_prog, getsockname_v6_prog);
 BPF_SKEL_FUNCS(getpeername_unix_prog, getpeername_unix_prog);
+BPF_SKEL_FUNCS_RAW(getpeername_unix_prog, getpeername_unix_prog);
 BPF_SKEL_FUNCS(getpeername4_prog, getpeername_v4_prog);
+BPF_SKEL_FUNCS_RAW(getpeername4_prog, getpeername_v4_prog);
 BPF_SKEL_FUNCS(getpeername6_prog, getpeername_v6_prog);
+BPF_SKEL_FUNCS_RAW(getpeername6_prog, getpeername_v6_prog);
 
 static struct sock_addr_test tests[] = {
 	/* bind - system calls */
@@ -1026,6 +1037,22 @@ static struct sock_addr_test tests[] = {
 		NULL,
 		SYSCALL_EPERM,
 	},
+	{
+		SOCK_ADDR_TEST_CONNECT,
+		"connect_unix: attach prog with wrong attach type",
+		connect_unix_prog_load_raw,
+		connect_unix_prog_destroy_raw,
+		BPF_CGROUP_INET4_CONNECT,
+		&user_ops,
+		AF_UNIX,
+		SOCK_STREAM,
+		SERVUN_ADDRESS,
+		0,
+		SERVUN_REWRITE_ADDRESS,
+		0,
+		NULL,
+		ATTACH_REJECT,
+	},
 
 	/* connect - kernel calls */
 	{
@@ -1398,6 +1425,22 @@ static struct sock_addr_test tests[] = {
 		NULL,
 		SYSCALL_EPERM,
 	},
+	{
+		SOCK_ADDR_TEST_SENDMSG,
+		"sendmsg_unix: attach prog with wrong attach type",
+		sendmsg_unix_prog_load_raw,
+		sendmsg_unix_prog_destroy_raw,
+		BPF_CGROUP_UDP4_SENDMSG,
+		&user_ops,
+		AF_UNIX,
+		SOCK_DGRAM,
+		SERVUN_ADDRESS,
+		0,
+		SERVUN_REWRITE_ADDRESS,
+		0,
+		NULL,
+		ATTACH_REJECT,
+	},
 
 	/* sendmsg - kernel calls (sock_sendmsg) */
 	{
@@ -1644,6 +1687,22 @@ static struct sock_addr_test tests[] = {
 		SERV4_IP,
 		SUCCESS,
 	},
+	{
+		SOCK_ADDR_TEST_RECVMSG,
+		"recvmsg4: attach prog with wrong attach type",
+		recvmsg4_prog_load_raw,
+		recvmsg4_prog_destroy_raw,
+		BPF_CGROUP_UDP6_RECVMSG,
+		&user_ops,
+		AF_INET,
+		SOCK_DGRAM,
+		SERV4_REWRITE_IP,
+		SERV4_REWRITE_PORT,
+		SERV4_REWRITE_IP,
+		SERV4_REWRITE_PORT,
+		SERV4_IP,
+		ATTACH_REJECT,
+	},
 	{
 		SOCK_ADDR_TEST_RECVMSG,
 		"recvmsg6: recvfrom (dgram)",
@@ -1660,6 +1719,22 @@ static struct sock_addr_test tests[] = {
 		SERV6_IP,
 		SUCCESS,
 	},
+	{
+		SOCK_ADDR_TEST_RECVMSG,
+		"recvmsg6: attach prog with wrong attach type",
+		recvmsg6_prog_load_raw,
+		recvmsg6_prog_destroy_raw,
+		BPF_CGROUP_UDP4_RECVMSG,
+		&user_ops,
+		AF_INET6,
+		SOCK_DGRAM,
+		SERV6_REWRITE_IP,
+		SERV6_REWRITE_PORT,
+		SERV6_REWRITE_IP,
+		SERV6_REWRITE_PORT,
+		SERV6_IP,
+		ATTACH_REJECT,
+	},
 	{
 		SOCK_ADDR_TEST_RECVMSG,
 		"recvmsg_unix: recvfrom (dgram)",
@@ -1692,6 +1767,22 @@ static struct sock_addr_test tests[] = {
 		SERVUN_ADDRESS,
 		SUCCESS,
 	},
+	{
+		SOCK_ADDR_TEST_RECVMSG,
+		"recvmsg_unix: attach prog with wrong attach type",
+		recvmsg_unix_prog_load_raw,
+		recvmsg_unix_prog_destroy_raw,
+		BPF_CGROUP_UDP4_RECVMSG,
+		&user_ops,
+		AF_INET6,
+		SOCK_STREAM,
+		SERVUN_REWRITE_ADDRESS,
+		0,
+		SERVUN_REWRITE_ADDRESS,
+		0,
+		SERVUN_ADDRESS,
+		ATTACH_REJECT,
+	},
 
 	/* getsockname - system calls */
 	{
@@ -1726,6 +1817,22 @@ static struct sock_addr_test tests[] = {
 		NULL,
 		SUCCESS,
 	},
+	{
+		SOCK_ADDR_TEST_GETSOCKNAME,
+		"getsockname4: attach prog with wrong attach type",
+		getsockname_v4_prog_load_raw,
+		getsockname_v4_prog_destroy_raw,
+		BPF_CGROUP_INET6_GETSOCKNAME,
+		&user_ops,
+		AF_INET,
+		SOCK_DGRAM,
+		SERV4_REWRITE_IP,
+		SERV4_REWRITE_PORT,
+		SERV4_IP,
+		SERV4_PORT,
+		NULL,
+		ATTACH_REJECT,
+	},
 	{
 		SOCK_ADDR_TEST_GETSOCKNAME,
 		"getsockname6: getsockname (stream)",
@@ -1758,6 +1865,22 @@ static struct sock_addr_test tests[] = {
 		NULL,
 		SUCCESS,
 	},
+	{
+		SOCK_ADDR_TEST_GETSOCKNAME,
+		"getsockname6: attach prog with wrong attach type",
+		getsockname_v6_prog_load_raw,
+		getsockname_v6_prog_destroy_raw,
+		BPF_CGROUP_INET4_GETSOCKNAME,
+		&user_ops,
+		AF_INET6,
+		SOCK_DGRAM,
+		SERV6_REWRITE_IP,
+		SERV6_REWRITE_PORT,
+		SERV6_IP,
+		SERV6_PORT,
+		NULL,
+		ATTACH_REJECT,
+	},
 	{
 		SOCK_ADDR_TEST_GETSOCKNAME,
 		"getsockname_unix: getsockname",
@@ -1774,6 +1897,22 @@ static struct sock_addr_test tests[] = {
 		NULL,
 		SUCCESS,
 	},
+	{
+		SOCK_ADDR_TEST_GETSOCKNAME,
+		"getsockname_unix: attach prog with wrong attach type",
+		getsockname_unix_prog_load_raw,
+		getsockname_unix_prog_destroy_raw,
+		BPF_CGROUP_INET4_GETSOCKNAME,
+		&user_ops,
+		AF_UNIX,
+		SOCK_STREAM,
+		SERVUN_ADDRESS,
+		0,
+		SERVUN_REWRITE_ADDRESS,
+		0,
+		NULL,
+		ATTACH_REJECT,
+	},
 
 	/* getsockname - kernel calls */
 	{
@@ -1890,6 +2029,22 @@ static struct sock_addr_test tests[] = {
 		NULL,
 		SUCCESS,
 	},
+	{
+		SOCK_ADDR_TEST_GETPEERNAME,
+		"getpeername4: attach prog with wrong attach type",
+		getpeername_v4_prog_load_raw,
+		getpeername_v4_prog_destroy_raw,
+		BPF_CGROUP_INET6_GETSOCKNAME,
+		&user_ops,
+		AF_UNIX,
+		SOCK_DGRAM,
+		SERV4_REWRITE_IP,
+		SERV4_REWRITE_PORT,
+		SERV4_IP,
+		SERV4_PORT,
+		NULL,
+		ATTACH_REJECT,
+	},
 	{
 		SOCK_ADDR_TEST_GETPEERNAME,
 		"getpeername6: getpeername (stream)",
@@ -1922,6 +2077,22 @@ static struct sock_addr_test tests[] = {
 		NULL,
 		SUCCESS,
 	},
+	{
+		SOCK_ADDR_TEST_GETPEERNAME,
+		"getpeername6: attach prog with wrong attach type",
+		getpeername_v6_prog_load_raw,
+		getpeername_v6_prog_destroy_raw,
+		BPF_CGROUP_INET4_GETSOCKNAME,
+		&user_ops,
+		AF_INET6,
+		SOCK_DGRAM,
+		SERV6_REWRITE_IP,
+		SERV6_REWRITE_PORT,
+		SERV6_IP,
+		SERV6_PORT,
+		NULL,
+		ATTACH_REJECT,
+	},
 	{
 		SOCK_ADDR_TEST_GETPEERNAME,
 		"getpeername_unix: getpeername",
@@ -1938,6 +2109,22 @@ static struct sock_addr_test tests[] = {
 		NULL,
 		SUCCESS,
 	},
+	{
+		SOCK_ADDR_TEST_GETPEERNAME,
+		"getpeername_unix: attach prog with wrong attach type",
+		getpeername_unix_prog_load_raw,
+		getpeername_unix_prog_destroy_raw,
+		BPF_CGROUP_INET4_GETSOCKNAME,
+		&user_ops,
+		AF_UNIX,
+		SOCK_STREAM,
+		SERVUN_ADDRESS,
+		0,
+		SERVUN_REWRITE_ADDRESS,
+		0,
+		NULL,
+		ATTACH_REJECT,
+	},
 
 	/* getpeername - kernel calls */
 	{
-- 
2.45.0.118.g7fe29c98d7-goog


