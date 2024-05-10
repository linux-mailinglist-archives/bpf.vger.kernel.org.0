Return-Path: <bpf+bounces-29504-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00EB28C2A44
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 21:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABB5C2873EC
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 19:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F88645BF9;
	Fri, 10 May 2024 19:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wjr356MK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CF147F6F
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 19:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715367789; cv=none; b=qIjzrLWdGLT9uv3BF+G2GnC+FW6sBYGXJEMKX5HbqmbXx0a4qVW8T0vsxyweW/keLmHK5hc8Xjm3Dl6QrnHixXyDjr7c66ildZduUVHuXPjN5nKVxjJifoC6D+efQQJVmosDA1rJde0Mrb/LOCAzN9n+5z1a7sdjSSvQinBgnDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715367789; c=relaxed/simple;
	bh=VMyugVAQ8Ub1DGTFanqOI4/2k/P0xtDqyEZKFeH42jI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GLUvmBWk3j4EiwSstAVIh9dstNCGFQcbFTDHeg/+rGSzZRqvfdl+oKpzUmP6UdRylkai343jyRCeIR+Xb0WIBinADs8j6JvKYr+iYVEVTdloeDcGP0b+xiHpmu0eQ2omfSybMT6ZJiTpI04xD1K6jPllJHD7OmJHRsRXKJ+PECc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wjr356MK; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-7dab89699a8so234261439f.2
        for <bpf@vger.kernel.org>; Fri, 10 May 2024 12:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715367787; x=1715972587; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=o5Qphk0OKRqdStjeaxrPqPTmxPnx+FOSWajJd14XMpA=;
        b=wjr356MKaQzC3u+fgqp2IEtA057NAKoLs28/1i8tEQaN8vrQWQJyAS0hjz4tvB+Qrs
         TH/WWDgMK45+vUfy9oWq9f9tEgVAeGsI2LBQLYK5zPSg+A291KN+mceWzb0zstkwgjqp
         TWePi14UjA+yfbv+EvFHcNQZrl57n4OldfSfQRipJhTEwloR/OVxA3YWxddkfVGuHPsy
         gHzoWmkqqhlDBnT6cMMnbGo6a5rJFWmQlyHR9SiPyFIUrRboQiYekPn7hEedVfd6Qkeh
         fAk69Q2/HcIhXccfYWosMmNDe0Jg9h7/DkCHsYzptjrWRxuz/30l3QAj3Ofi7by106OT
         LdaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715367787; x=1715972587;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o5Qphk0OKRqdStjeaxrPqPTmxPnx+FOSWajJd14XMpA=;
        b=QWn8/s0Ccw6aexs5ITUeYUzO9FBv6wf0gtmwEVU+uxWR6oDcmoWgO5o99FGdQmQR2N
         /qh/V5j3naNNdmeS0PzG43GOrV+YxTHXaMs4v8DR94ixixtRFYo3K0HXXCjo1UM9E4GW
         LOb0PMAUNp3ZadqzurH4FxeA6sfKocyAwSdWb6/yx8PqoWE0flXttOCoi12VoTgL0Rfb
         aNoMaB3Q0OWa13cBtxm2KRW27ZShNjlQ8N/cxFKf0/8ISXA9kDi2BVCN6jZKo2qU6UBv
         R4XDqM9HgKXq9yQZHQno+YIjerkqaIjEoI/KbpBnpHopP5cXfIvOTWkaY9NEPZfUaGnU
         GrVw==
X-Gm-Message-State: AOJu0YzAwcNAHRWgKQNz12chRKMGcChWCNCUOrEUnGJGQxj7ts/nGUcF
	o0fH5At1e5fCG1x1Ti3mO1o/2QBAVLF0nuOIHQMKj/L6xojpXFVdyE9QkIhCbhPOL6O5u86NQ5q
	HZQdL28y0qw29nIJ5rYsUVCrV3uy3yT333WuPk2VgJ99rjps/KJe0sdGyAkKi2bTCCGz2hwz9xJ
	1OhpNx0I/a2yRyh0VeyzAwr64=
X-Google-Smtp-Source: AGHT+IH9MvaFKRLstHKq2Et97J3n4iTmX6fh7j0LE0aUv6M3Muldzo4QSXXpNLJjm/sjgQ0ULTEMIiBg+A==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a05:6638:140d:b0:488:7838:5ab6 with SMTP id
 8926c6da1cb9f-4895a1ac748mr175589173.5.1715367786811; Fri, 10 May 2024
 12:03:06 -0700 (PDT)
Date: Fri, 10 May 2024 14:02:28 -0500
In-Reply-To: <20240510190246.3247730-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510190246.3247730-1-jrife@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510190246.3247730-12-jrife@google.com>
Subject: [PATCH v1 bpf-next 11/17] selftests/bpf: Migrate ATTACH_REJECT test cases
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

Migrate test case from bpf/test_sock_addr.c ensuring that program
attachment fails when using an inappropriate attach type.

Signed-off-by: Jordan Rife <jrife@google.com>
---
 .../selftests/bpf/prog_tests/sock_addr.c      | 102 ++++++++++++
 tools/testing/selftests/bpf/test_sock_addr.c  | 146 ------------------
 2 files changed, 102 insertions(+), 146 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_addr.c b/tools/testing/selftests/bpf/prog_tests/sock_addr.c
index 8c7c56f997549..ebd5e58e38c5c 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_addr.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_addr.c
@@ -438,13 +438,19 @@ static void prog_name##_destroy(void *skel) \
 }
 
 BPF_SKEL_FUNCS(bind4_prog, bind_v4_prog);
+BPF_SKEL_FUNCS_RAW(bind4_prog, bind_v4_prog);
 BPF_SKEL_FUNCS(bind6_prog, bind_v6_prog);
+BPF_SKEL_FUNCS_RAW(bind6_prog, bind_v6_prog);
 BPF_SKEL_FUNCS(connect4_prog, connect_v4_prog);
+BPF_SKEL_FUNCS_RAW(connect4_prog, connect_v4_prog);
 BPF_SKEL_FUNCS(connect6_prog, connect_v6_prog);
+BPF_SKEL_FUNCS_RAW(connect6_prog, connect_v6_prog);
 BPF_SKEL_FUNCS(connect_unix_prog, connect_unix_prog);
 BPF_SKEL_FUNCS(sendmsg4_prog, sendmsg_v4_prog);
+BPF_SKEL_FUNCS_RAW(sendmsg4_prog, sendmsg_v4_prog);
 BPF_SKEL_FUNCS(sendmsg4_prog, sendmsg_v4_deny_prog);
 BPF_SKEL_FUNCS(sendmsg6_prog, sendmsg_v6_prog);
+BPF_SKEL_FUNCS_RAW(sendmsg6_prog, sendmsg_v6_prog);
 BPF_SKEL_FUNCS(sendmsg6_prog, sendmsg_v6_deny_prog);
 BPF_SKEL_FUNCS(sendmsg6_prog, sendmsg_v6_preserve_dst_prog);
 BPF_SKEL_FUNCS(sendmsg6_prog, sendmsg_v6_v4mapped_prog);
@@ -506,6 +512,22 @@ static struct sock_addr_test tests[] = {
 		NULL,
 		LOAD_REJECT,
 	},
+	{
+		SOCK_ADDR_TEST_BIND,
+		"bind4: attach prog with wrong attach type",
+		bind_v4_prog_load_raw,
+		bind_v4_prog_destroy_raw,
+		BPF_CGROUP_INET6_BIND,
+		&user_ops,
+		AF_INET,
+		SOCK_STREAM,
+		NULL,
+		0,
+		NULL,
+		0,
+		NULL,
+		ATTACH_REJECT,
+	},
 	{
 		SOCK_ADDR_TEST_BIND,
 		"bind6: bind (stream)",
@@ -554,6 +576,22 @@ static struct sock_addr_test tests[] = {
 		NULL,
 		LOAD_REJECT,
 	},
+	{
+		SOCK_ADDR_TEST_BIND,
+		"bind6: attach prog with wrong attach type",
+		bind_v6_prog_load_raw,
+		bind_v6_prog_destroy_raw,
+		BPF_CGROUP_INET4_BIND,
+		&user_ops,
+		AF_INET,
+		SOCK_STREAM,
+		NULL,
+		0,
+		NULL,
+		0,
+		NULL,
+		ATTACH_REJECT,
+	},
 
 	/* bind - kernel calls */
 	{
@@ -670,6 +708,22 @@ static struct sock_addr_test tests[] = {
 		NULL,
 		LOAD_REJECT,
 	},
+	{
+		SOCK_ADDR_TEST_CONNECT,
+		"connect4: attach prog with wrong attach type",
+		connect_v4_prog_load_raw,
+		connect_v4_prog_destroy_raw,
+		BPF_CGROUP_INET6_CONNECT,
+		&user_ops,
+		AF_INET,
+		SOCK_STREAM,
+		NULL,
+		0,
+		NULL,
+		0,
+		NULL,
+		ATTACH_REJECT,
+	},
 	{
 		SOCK_ADDR_TEST_CONNECT,
 		"connect6: connect (stream)",
@@ -718,6 +772,22 @@ static struct sock_addr_test tests[] = {
 		NULL,
 		LOAD_REJECT,
 	},
+	{
+		SOCK_ADDR_TEST_CONNECT,
+		"connect6: attach prog with wrong attach type",
+		connect_v6_prog_load_raw,
+		connect_v6_prog_destroy_raw,
+		BPF_CGROUP_INET4_CONNECT,
+		&user_ops,
+		AF_INET,
+		SOCK_STREAM,
+		NULL,
+		0,
+		NULL,
+		0,
+		NULL,
+		ATTACH_REJECT,
+	},
 	{
 		SOCK_ADDR_TEST_CONNECT,
 		"connect_unix: connect (stream)",
@@ -866,6 +936,22 @@ static struct sock_addr_test tests[] = {
 		NULL,
 		LOAD_REJECT,
 	},
+	{
+		SOCK_ADDR_TEST_SENDMSG,
+		"sendmsg4: attach prog with wrong attach type",
+		sendmsg_v4_prog_load_raw,
+		sendmsg_v4_prog_destroy_raw,
+		BPF_CGROUP_UDP6_SENDMSG,
+		&user_ops,
+		AF_INET,
+		SOCK_DGRAM,
+		NULL,
+		0,
+		NULL,
+		0,
+		NULL,
+		ATTACH_REJECT,
+	},
 	{
 		SOCK_ADDR_TEST_SENDMSG,
 		"sendmsg6: sendmsg (dgram)",
@@ -962,6 +1048,22 @@ static struct sock_addr_test tests[] = {
 		NULL,
 		LOAD_REJECT,
 	},
+	{
+		SOCK_ADDR_TEST_SENDMSG,
+		"sendmsg6: attach prog with wrong attach type",
+		sendmsg_v6_prog_load_raw,
+		sendmsg_v6_prog_destroy_raw,
+		BPF_CGROUP_UDP4_SENDMSG,
+		&user_ops,
+		AF_INET6,
+		SOCK_DGRAM,
+		NULL,
+		0,
+		NULL,
+		0,
+		NULL,
+		ATTACH_REJECT,
+	},
 	{
 		SOCK_ADDR_TEST_SENDMSG,
 		"sendmsg_unix: sendmsg (dgram)",
diff --git a/tools/testing/selftests/bpf/test_sock_addr.c b/tools/testing/selftests/bpf/test_sock_addr.c
index 4ecbc72477f1f..311eda4f48645 100644
--- a/tools/testing/selftests/bpf/test_sock_addr.c
+++ b/tools/testing/selftests/bpf/test_sock_addr.c
@@ -88,89 +88,11 @@ struct sock_addr_test {
 	} expected_result;
 };
 
-static int bind4_prog_load(const struct sock_addr_test *test);
-static int bind6_prog_load(const struct sock_addr_test *test);
-static int connect4_prog_load(const struct sock_addr_test *test);
-static int connect6_prog_load(const struct sock_addr_test *test);
 static int sendmsg4_rw_asm_prog_load(const struct sock_addr_test *test);
 static int sendmsg6_rw_asm_prog_load(const struct sock_addr_test *test);
 
 static struct sock_addr_test tests[] = {
-	/* bind */
-	{
-		"bind4: attach prog with wrong attach type",
-		bind4_prog_load,
-		BPF_CGROUP_INET4_BIND,
-		BPF_CGROUP_INET6_BIND,
-		AF_INET,
-		SOCK_STREAM,
-		NULL,
-		0,
-		NULL,
-		0,
-		NULL,
-		ATTACH_REJECT,
-	},
-	{
-		"bind6: attach prog with wrong attach type",
-		bind6_prog_load,
-		BPF_CGROUP_INET6_BIND,
-		BPF_CGROUP_INET4_BIND,
-		AF_INET,
-		SOCK_STREAM,
-		NULL,
-		0,
-		NULL,
-		0,
-		NULL,
-		ATTACH_REJECT,
-	},
-
-	/* connect */
-	{
-		"connect4: attach prog with wrong attach type",
-		connect4_prog_load,
-		BPF_CGROUP_INET4_CONNECT,
-		BPF_CGROUP_INET6_CONNECT,
-		AF_INET,
-		SOCK_STREAM,
-		NULL,
-		0,
-		NULL,
-		0,
-		NULL,
-		ATTACH_REJECT,
-	},
-	{
-		"connect6: attach prog with wrong attach type",
-		connect6_prog_load,
-		BPF_CGROUP_INET6_CONNECT,
-		BPF_CGROUP_INET4_CONNECT,
-		AF_INET,
-		SOCK_STREAM,
-		NULL,
-		0,
-		NULL,
-		0,
-		NULL,
-		ATTACH_REJECT,
-	},
-
 	/* sendmsg */
-	{
-		"sendmsg4: attach prog with wrong attach type",
-		sendmsg4_rw_asm_prog_load,
-		BPF_CGROUP_UDP4_SENDMSG,
-		BPF_CGROUP_UDP6_SENDMSG,
-		AF_INET,
-		SOCK_DGRAM,
-		NULL,
-		0,
-		NULL,
-		0,
-		NULL,
-		ATTACH_REJECT,
-	},
 	{
 		"sendmsg4: rewrite IP & port (asm)",
 		sendmsg4_rw_asm_prog_load,
@@ -185,20 +107,6 @@ static struct sock_addr_test tests[] = {
 		SRC4_REWRITE_IP,
 		SUCCESS,
 	},
-	{
-		"sendmsg6: attach prog with wrong attach type",
-		sendmsg6_rw_asm_prog_load,
-		BPF_CGROUP_UDP6_SENDMSG,
-		BPF_CGROUP_UDP4_SENDMSG,
-		AF_INET6,
-		SOCK_DGRAM,
-		NULL,
-		0,
-		NULL,
-		0,
-		NULL,
-		ATTACH_REJECT,
-	},
 	{
 		"sendmsg6: rewrite IP & port (asm)",
 		sendmsg6_rw_asm_prog_load,
@@ -234,60 +142,6 @@ static int load_insns(const struct sock_addr_test *test,
 	return ret;
 }
 
-static int load_path(const struct sock_addr_test *test, const char *path)
-{
-	struct bpf_object *obj;
-	struct bpf_program *prog;
-	int err;
-
-	obj = bpf_object__open_file(path, NULL);
-	err = libbpf_get_error(obj);
-	if (err) {
-		log_err(">>> Opening BPF object (%s) error.\n", path);
-		return -1;
-	}
-
-	prog = bpf_object__next_program(obj, NULL);
-	if (!prog)
-		goto err_out;
-
-	bpf_program__set_type(prog, BPF_PROG_TYPE_CGROUP_SOCK_ADDR);
-	bpf_program__set_expected_attach_type(prog, test->expected_attach_type);
-	bpf_program__set_flags(prog, testing_prog_flags());
-
-	err = bpf_object__load(obj);
-	if (err) {
-		if (test->expected_result != LOAD_REJECT)
-			log_err(">>> Loading program (%s) error.\n", path);
-		goto err_out;
-	}
-
-	return bpf_program__fd(prog);
-err_out:
-	bpf_object__close(obj);
-	return -1;
-}
-
-static int bind4_prog_load(const struct sock_addr_test *test)
-{
-	return load_path(test, BIND4_PROG_PATH);
-}
-
-static int bind6_prog_load(const struct sock_addr_test *test)
-{
-	return load_path(test, BIND6_PROG_PATH);
-}
-
-static int connect4_prog_load(const struct sock_addr_test *test)
-{
-	return load_path(test, CONNECT4_PROG_PATH);
-}
-
-static int connect6_prog_load(const struct sock_addr_test *test)
-{
-	return load_path(test, CONNECT6_PROG_PATH);
-}
-
 static int sendmsg4_rw_asm_prog_load(const struct sock_addr_test *test)
 {
 	struct sockaddr_in dst4_rw_addr;
-- 
2.45.0.118.g7fe29c98d7-goog


