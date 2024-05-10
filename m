Return-Path: <bpf+bounces-29499-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E21D8C2A3A
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 21:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 043E0286937
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 19:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904194643B;
	Fri, 10 May 2024 19:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vP+mtKRf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C1F45977
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 19:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715367781; cv=none; b=iil2/5/p5j5C+/TTq/f26O6oDtzq2YK86CAb2sJIB2ucXN78+VAexl1ge8LTk40H9j1L3J3/4h5vuuNC+kr0CzvbDPCNehMio799j9XJcvvHZIYhUrnwxkJVS8V4K0/ivrVe91AGO0u19eChfJ1T+je6bu79+G/tVFTTGn86ZNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715367781; c=relaxed/simple;
	bh=ZKBym8bL+87iuEO1eTLqx0aH90HS+ZXJ37G/jaGUc0E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YkFpQWr1Y6rtBfbe7hVAJHtNXQxvKxcoqkpLJStmk0yWLJhTF5tgifoCaTzedmjhvDPuVsglAYpRK9rxxrMH7LsjtBfqTUrL8LK0KP//15PKJ6Jx6JC46UnI/3fwJSSmFEmKSH9X3Ksw6PMXRQpRjLtNi7sWys3DTuePtchyMzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vP+mtKRf; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61bea0ca5e2so38491987b3.2
        for <bpf@vger.kernel.org>; Fri, 10 May 2024 12:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715367779; x=1715972579; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xkbaFBJQy7+phzuNx/G3f0fc96jsJ3oP7IdhCfgCmIk=;
        b=vP+mtKRf/zPMlToE3CNoFqVyx25QKqp/zrzh/qiMVTkBbQc32UI6mxtaKZOPAf3mI0
         IDZcZCx16LgHTTseUKnatpJ1rjBZXvdHMijOe8nnjEjIElWKaaS/QKXbNTBVyFXjHuFj
         OqaA3GEIy2R81CgrWZsBcLi/oEZWs8cMPng84Wrs2K9hBCTSwNpqsqqFjmVyWEATi9fO
         50lAyAvVdZMImoPDMZ+188pu1GkgaCN1bvzOf7bmcA+MhItKPi/1uH06UBw7w+Pgk90A
         h/xrd4pBlzVuYFEmlQtuRQ1RKwqLTXIKgScP7aNba70s77mGDBEUScUnPNVSamHud665
         aXcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715367779; x=1715972579;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xkbaFBJQy7+phzuNx/G3f0fc96jsJ3oP7IdhCfgCmIk=;
        b=krIgxdjxwIklsNJc/+X34H3R85QisGUS5vXxPGKQRub7C0ZY1x+lE/TQflgpjhwK5J
         Zz9SHx42Wwt6sYFFcIdikoG3TutoJTbk7VvOwrr920OOvZiS79+JEmLakkI9RK0bkC9N
         Si9+H2QzvdG+RonK/vCBYeTTKVTtTwUNpOmHrH0MQA+qtj7I6lc9y9oGYu9KYxCbMxi1
         oqOsuz2nIzS65yp+CsWZ1KqCxP05bgDaBrYSgQlXKJJ1tkVDKNX5RLWqJxzvw2wXWEEJ
         8P1d0unBpOh3PSKc5rzD2hxMqoeE8t7YpR2V2jtANQp6txqVIPo+O1oujZIrOtQlhHlU
         JOGg==
X-Gm-Message-State: AOJu0YyDhbXVXC697MKvFv1w8PGfowbpMI4xpBgzkobxUTSZ3cNV2c9q
	hpsrTA/GJ6UsR9k8G9LU/oQCwUmtTPFn4vMNT8BOpMJPcNHnpmJjHi2V0waYpra7mycz1c+dmmB
	LdqahfFmZ/L72V+oIz5eBrg78w5KMMKrU/fRvP3cfzPzf3BqNRP6W9lfGgeP08mqAhTQXGDbF8v
	jA/KiP3l0r9ktM8yB7ZDmKLQU=
X-Google-Smtp-Source: AGHT+IEnUdFgZ3SDhkY3B9LOnHEJlb4pHhYF8GxCtgmQffiVDZIyHiOEGpEpTF5Wfn5B8slwQa39S/H19A==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a05:6902:150a:b0:dc2:2ace:860 with SMTP id
 3f1490d57ef6-dee4f3117c3mr274015276.2.1715367778597; Fri, 10 May 2024
 12:02:58 -0700 (PDT)
Date: Fri, 10 May 2024 14:02:23 -0500
In-Reply-To: <20240510190246.3247730-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510190246.3247730-1-jrife@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510190246.3247730-7-jrife@google.com>
Subject: [PATCH v1 bpf-next 06/17] selftests/bpf: Migrate WILDCARD_IP test
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

Move wildcard IP sendmsg test case out of bpf/test_sock_addr.c into
prog_tests/sock_addr.c.

Signed-off-by: Jordan Rife <jrife@google.com>
---
 .../selftests/bpf/prog_tests/sock_addr.c      | 50 +++++++++++++++++++
 .../selftests/bpf/progs/sendmsg6_prog.c       |  6 +++
 tools/testing/selftests/bpf/test_sock_addr.c  | 20 --------
 3 files changed, 56 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_addr.c b/tools/testing/selftests/bpf/prog_tests/sock_addr.c
index 626be900a8fdf..37e9ef5a5ae16 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_addr.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_addr.c
@@ -40,6 +40,7 @@
 #define SERV6_V4MAPPED_IP       "::ffff:192.168.0.4"
 #define SRC6_IP                 "::1"
 #define SRC6_REWRITE_IP         TEST_IPV6
+#define WILDCARD6_IP            "::"
 #define SERV6_PORT              6060
 #define SERV6_REWRITE_PORT      6666
 
@@ -443,6 +444,7 @@ BPF_SKEL_FUNCS(connect6_prog, connect_v6_prog);
 BPF_SKEL_FUNCS(connect_unix_prog, connect_unix_prog);
 BPF_SKEL_FUNCS(sendmsg4_prog, sendmsg_v4_prog);
 BPF_SKEL_FUNCS(sendmsg6_prog, sendmsg_v6_prog);
+BPF_SKEL_FUNCS(sendmsg6_prog, sendmsg_v6_preserve_dst_prog);
 BPF_SKEL_FUNCS(sendmsg_unix_prog, sendmsg_unix_prog);
 BPF_SKEL_FUNCS(recvmsg4_prog, recvmsg4_prog);
 BPF_SKEL_FUNCS(recvmsg6_prog, recvmsg6_prog);
@@ -780,6 +782,22 @@ static struct sock_addr_test tests[] = {
 		SRC6_REWRITE_IP,
 		SUCCESS,
 	},
+	{
+		SOCK_ADDR_TEST_SENDMSG,
+		"sendmsg6: sendmsg [::] (BSD'ism) (dgram)",
+		sendmsg_v6_preserve_dst_prog_load,
+		sendmsg_v6_preserve_dst_prog_destroy,
+		BPF_CGROUP_UDP6_SENDMSG,
+		&user_ops,
+		AF_INET6,
+		SOCK_DGRAM,
+		WILDCARD6_IP,
+		SERV6_PORT,
+		SERV6_REWRITE_IP,
+		SERV6_PORT,
+		SRC6_IP,
+		SUCCESS,
+	},
 	{
 		SOCK_ADDR_TEST_SENDMSG,
 		"sendmsg_unix: sendmsg (dgram)",
@@ -830,6 +848,22 @@ static struct sock_addr_test tests[] = {
 		SRC6_REWRITE_IP,
 		SUCCESS,
 	},
+	{
+		SOCK_ADDR_TEST_SENDMSG,
+		"sendmsg6: sock_sendmsg [::] (BSD'ism) (dgram)",
+		sendmsg_v6_preserve_dst_prog_load,
+		sendmsg_v6_preserve_dst_prog_destroy,
+		BPF_CGROUP_UDP6_SENDMSG,
+		&kern_ops_sock_sendmsg,
+		AF_INET6,
+		SOCK_DGRAM,
+		WILDCARD6_IP,
+		SERV6_PORT,
+		SERV6_REWRITE_IP,
+		SERV6_PORT,
+		SRC6_IP,
+		SUCCESS,
+	},
 	{
 		SOCK_ADDR_TEST_SENDMSG,
 		"sendmsg_unix: sock_sendmsg (dgram)",
@@ -880,6 +914,22 @@ static struct sock_addr_test tests[] = {
 		SRC6_REWRITE_IP,
 		SUCCESS,
 	},
+	{
+		SOCK_ADDR_TEST_SENDMSG,
+		"sendmsg6: kernel_sendmsg [::] (BSD'ism) (dgram)",
+		sendmsg_v6_preserve_dst_prog_load,
+		sendmsg_v6_preserve_dst_prog_destroy,
+		BPF_CGROUP_UDP6_SENDMSG,
+		&kern_ops_kernel_sendmsg,
+		AF_INET6,
+		SOCK_DGRAM,
+		WILDCARD6_IP,
+		SERV6_PORT,
+		SERV6_REWRITE_IP,
+		SERV6_PORT,
+		SRC6_IP,
+		SUCCESS,
+	},
 	{
 		SOCK_ADDR_TEST_SENDMSG,
 		"sendmsg_unix: sock_sendmsg (dgram)",
diff --git a/tools/testing/selftests/bpf/progs/sendmsg6_prog.c b/tools/testing/selftests/bpf/progs/sendmsg6_prog.c
index bf9b46b806f6a..03956a654ce58 100644
--- a/tools/testing/selftests/bpf/progs/sendmsg6_prog.c
+++ b/tools/testing/selftests/bpf/progs/sendmsg6_prog.c
@@ -59,4 +59,10 @@ int sendmsg_v6_prog(struct bpf_sock_addr *ctx)
 	return 1;
 }
 
+SEC("cgroup/sendmsg6")
+int sendmsg_v6_preserve_dst_prog(struct bpf_sock_addr *ctx)
+{
+	return 1;
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_sock_addr.c b/tools/testing/selftests/bpf/test_sock_addr.c
index 40e33167bec20..ab8ef02c9c556 100644
--- a/tools/testing/selftests/bpf/test_sock_addr.c
+++ b/tools/testing/selftests/bpf/test_sock_addr.c
@@ -92,7 +92,6 @@ static int bind4_prog_load(const struct sock_addr_test *test);
 static int bind6_prog_load(const struct sock_addr_test *test);
 static int connect4_prog_load(const struct sock_addr_test *test);
 static int connect6_prog_load(const struct sock_addr_test *test);
-static int sendmsg_allow_prog_load(const struct sock_addr_test *test);
 static int sendmsg_deny_prog_load(const struct sock_addr_test *test);
 static int sendmsg4_rw_asm_prog_load(const struct sock_addr_test *test);
 static int sendmsg6_rw_asm_prog_load(const struct sock_addr_test *test);
@@ -343,20 +342,6 @@ static struct sock_addr_test tests[] = {
 		SRC6_REWRITE_IP,
 		SUCCESS,
 	},
-	{
-		"sendmsg6: preserve dst IP = [::] (BSD'ism)",
-		sendmsg_allow_prog_load,
-		BPF_CGROUP_UDP6_SENDMSG,
-		BPF_CGROUP_UDP6_SENDMSG,
-		AF_INET6,
-		SOCK_DGRAM,
-		WILDCARD6_IP,
-		SERV6_PORT,
-		SERV6_REWRITE_IP,
-		SERV6_PORT,
-		SRC6_IP,
-		SUCCESS,
-	},
 	{
 		"sendmsg6: deny call",
 		sendmsg_deny_prog_load,
@@ -457,11 +442,6 @@ static int xmsg_ret_only_prog_load(const struct sock_addr_test *test,
 	return load_insns(test, insns, ARRAY_SIZE(insns));
 }
 
-static int sendmsg_allow_prog_load(const struct sock_addr_test *test)
-{
-	return xmsg_ret_only_prog_load(test, /*rc*/ 1);
-}
-
 static int sendmsg_deny_prog_load(const struct sock_addr_test *test)
 {
 	return xmsg_ret_only_prog_load(test, /*rc*/ 0);
-- 
2.45.0.118.g7fe29c98d7-goog


