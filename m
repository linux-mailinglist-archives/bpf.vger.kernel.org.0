Return-Path: <bpf+bounces-21154-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FEC848D57
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 13:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC46D1C20F79
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 12:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C5C2232B;
	Sun,  4 Feb 2024 12:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+Oy01f2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F31D2209A
	for <bpf@vger.kernel.org>; Sun,  4 Feb 2024 12:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707048135; cv=none; b=gBRNtZCLY5cP6t3XofFsAamG8RFMiEdPU8mb8ycFUGnSzw6yMyXTNsvw55XIiBKLN6GlPvkdR3+BQHb9U4yjSKTGr4L1qo7g08T6ChLnA1ujUfJbiRqQMiGGYDsqL7z34j7V3gzkfZvq7zpzhia5+MH6iKBse6sS34oefrR8zSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707048135; c=relaxed/simple;
	bh=vOfXCj5nyvMeGpvQ8z5vf5+7WAKs747+6Ym2DgHJMOA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QPYEfYF+5H1Q1xZPyQM8tAF9oqIy+k27Wz9I/vG328E8yX/tVZcqWtnQysmi9mBH8sx6V/fv8pFJrH3I7AVh8c0OHblhLokQ6afeoQ4PMYcK55eC40Pu1L829ruxDsLZPbQDk8sEkVHBZfq65oUzeiA+1tv5SwpmxU1mUIObXzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+Oy01f2; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-56061d07bffso72681a12.2
        for <bpf@vger.kernel.org>; Sun, 04 Feb 2024 04:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707048131; x=1707652931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q6sFwC4hgE+7mfq8JldFwhvZzWDaTZ82YvoKSQs6QMk=;
        b=E+Oy01f2jA3lWdCPdZAt1kMvUMXNmsmihoHetx7x76FN42lmZv6b7dXac44ZhMrWwU
         J3F/pflMwfEnsA5pzI/p2LPDeeg2skFmO0aLqn0QD7deh+KhP9G/lbVhc2ZfzMh1gdiN
         ktNQuGmjnPJJ1wxvzvXRODbA8J+rUYu0uHay9YtMypDEhONkn+7UU6mnHXDX74fqrHV/
         GG+llwDWX+vUxMvsfagX4pTXrT7W+TK8yQzMk8z6+vvZJdfXhA3nMvnzGT4R/ck4CpE7
         2WgU2dk3Aaw7FLPK4brCzRAdwG3eJXb+MPSZQ/SWgNxF0980EYuPn8vzCsfGA7DVkVbs
         L9zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707048131; x=1707652931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q6sFwC4hgE+7mfq8JldFwhvZzWDaTZ82YvoKSQs6QMk=;
        b=W59/yjT+kBeuok34EsLoTik+9JdZQBZRg3Nj+lDzDrZm7Dt5CVJvPob6E/ebKwmcol
         Nf0St3dY9SIzuliM9v8t8bXguHjhV+37xv1Z3/DwQR6wdAKGmO4ny2fUwzZ0vY5G9OMH
         BtCCD4n8MxvzH17UByw+Cwc2fZ09pPOuqFwmPkTm2gxSxy+OJVtm61s0rf8L7hBsaeJp
         D3m/vEeiIb7Jl9jHbMu3HqH/hnuCzoUdHkWRsoV2sqDhox2+++/2aFUW9wCbLVOATZ3X
         4306TWzUbyM4QWUxcR6o2Hhj68SouV7CunVyRTcFdPHbzLjPQs9VJF0pENnKIpSh6XLl
         q8dA==
X-Gm-Message-State: AOJu0YwB9eQPLnEFsQnVxN7IUnGZ6SM1s6dBHY4VB182sG5JVE7XPnCN
	JkGC1r+eyMinVpdPtlxa+a0VPcFBLw85/ZLWzVeQ4EoXApx1EfhAnJChGaW6rKY=
X-Google-Smtp-Source: AGHT+IFKJfcGtXYGHsMid5prPKFXhFSdDd/U5ebGrwNzHnsoNfG9YLimYzRkwlUMfUjW51ostwqTUg==
X-Received: by 2002:a05:6402:b71:b0:560:4dbd:4f15 with SMTP id cb17-20020a0564020b7100b005604dbd4f15mr730771edb.5.1707048130912;
        Sun, 04 Feb 2024 04:02:10 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUoC74OXNq49/l1Wh7EA1Omcg0/xarUUDyHRhU1+cCsoYecpLpbGT73HEPnQ+DAS2hMl+G4EF4NPWttpTcIdV9JFmUAvYtd8ebKPW5TUO/IO/CV6hKDqRqSJQNpIFb68H35WowDNZ1g/ktTjVbUJDqvkqsFQRa0/SDJZt5bdH/iTB4REqo2JhBiX1oFbGgUhw4cIudvsGIMMicCx9hGgeyB3Zs=
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id o4-20020aa7c504000000b0055efaddeafdsm2651044edq.86.2024.02.04.04.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 04:02:10 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Barret Rhoden <brho@google.com>,
	David Vernet <void@manifault.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next v1 2/2] selftests/bpf: Add test for static subprog call in lock cs
Date: Sun,  4 Feb 2024 12:02:06 +0000
Message-Id: <20240204120206.796412-3-memxor@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240204120206.796412-1-memxor@gmail.com>
References: <20240204120206.796412-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4303; i=memxor@gmail.com; h=from:subject; bh=vOfXCj5nyvMeGpvQ8z5vf5+7WAKs747+6Ym2DgHJMOA=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBlv3qDsB58utGcUQxd/uuhT4CehfMCJ6IUmGh69 ctjoHxXJTeJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZb96gwAKCRBM4MiGSL8R yhD3D/94jEFeag7TuGHwiu/Lv5clwax//NeuBp54r7dd5d0B+p3FG6P2yyHWp+G5YjVOHpdQVjq 81RK+vFo8Iu6H6jbx+Ijh4FTduOqPcgcEmf0Kn137k3piyM5F3nYYaBAezqipqznGoqn/6lO5JA 0kdmmkzwW/+i3M1PQkOzzmgojxhgNrRyTZb8TLzljqIL9ZAYOWjyuk2F81JuEay/RbkfizfCqIX g++TjojLLl9anF3mpzyD1szheOgsBT0sPRugeYIV10SV57ctL/fYd52tnqCUisZsqffgfgNSI8b 87TmyySm9Gs+l13pwgOb4AJKWlA++vT6vKKXblUywQ9Fxn8nKVTTiR3Ibj8hhllutVke4MQh67f Nav5qe5qTsfCxYz416mVPdlSZdRPw1sNe4Fk79HoxAblJi3DXu48baXaxmnMcXUZCagdfst33Zo cLGsXRc4Ufmh92co4oi6qgo0X4LHl1qoGHfbwz1L6HodtjVOS5hXRYzyyx+7BeIKCiNBFYmVe1t lh4dvMl+rYK3s8wMvJZ8q3j2MCCKEFA5QtNUqPeOdJI9z6FnIv08XFwQqZoO/6oBswrT5C7teFQ wyIF7y6rbnFgwTOz7KhrYx57m3tjUgSq0MhWac0dDNZ6+BmXBrIVYhVO6swO83Zv6T0OLDera3n 48ZY+JZSRiJ9lwg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Add selftests for static subprog calls within bpf_spin_lock critical
section, and ensure we still reject global subprog calls. Also test the
case where a subprog call will unlock the caller's held lock, or the
caller will unlock a lock taken by a subprog call, ensuring correct
transfer of lock state across frames on exit.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/spin_lock.c      |  2 +
 .../selftests/bpf/progs/test_spin_lock.c      | 65 +++++++++++++++++++
 .../selftests/bpf/progs/test_spin_lock_fail.c | 44 +++++++++++++
 3 files changed, 111 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/spin_lock.c b/tools/testing/selftests/bpf/prog_tests/spin_lock.c
index 18d451be57c8..6a4962ca0e5e 100644
--- a/tools/testing/selftests/bpf/prog_tests/spin_lock.c
+++ b/tools/testing/selftests/bpf/prog_tests/spin_lock.c
@@ -48,6 +48,8 @@ static struct {
 	{ "lock_id_mismatch_innermapval_kptr", "bpf_spin_unlock of different lock" },
 	{ "lock_id_mismatch_innermapval_global", "bpf_spin_unlock of different lock" },
 	{ "lock_id_mismatch_innermapval_mapval", "bpf_spin_unlock of different lock" },
+	{ "lock_global_subprog_call1", "function calls are not allowed while holding a lock" },
+	{ "lock_global_subprog_call2", "function calls are not allowed while holding a lock" },
 };
 
 static int match_regex(const char *pattern, const char *string)
diff --git a/tools/testing/selftests/bpf/progs/test_spin_lock.c b/tools/testing/selftests/bpf/progs/test_spin_lock.c
index b2440a0ff422..d8d77bdffd3d 100644
--- a/tools/testing/selftests/bpf/progs/test_spin_lock.c
+++ b/tools/testing/selftests/bpf/progs/test_spin_lock.c
@@ -101,4 +101,69 @@ int bpf_spin_lock_test(struct __sk_buff *skb)
 err:
 	return err;
 }
+
+struct bpf_spin_lock lockA __hidden SEC(".data.A");
+
+__noinline
+static int static_subprog(struct __sk_buff *ctx)
+{
+	volatile int ret = 0;
+
+	if (ctx->protocol)
+		return ret;
+	return ret + ctx->len;
+}
+
+__noinline
+static int static_subprog_lock(struct __sk_buff *ctx)
+{
+	volatile int ret = 0;
+
+	ret = static_subprog(ctx);
+	bpf_spin_lock(&lockA);
+	return ret + ctx->len;
+}
+
+__noinline
+static int static_subprog_unlock(struct __sk_buff *ctx)
+{
+	volatile int ret = 0;
+
+	ret = static_subprog(ctx);
+	bpf_spin_unlock(&lockA);
+	return ret + ctx->len;
+}
+
+SEC("tc")
+int lock_static_subprog_call(struct __sk_buff *ctx)
+{
+	int ret = 0;
+
+	bpf_spin_lock(&lockA);
+	if (ctx->mark == 42)
+		ret = static_subprog(ctx);
+	bpf_spin_unlock(&lockA);
+	return ret;
+}
+
+SEC("tc")
+int lock_static_subprog_lock(struct __sk_buff *ctx)
+{
+	int ret = 0;
+
+	ret = static_subprog_lock(ctx);
+	bpf_spin_unlock(&lockA);
+	return ret;
+}
+
+SEC("tc")
+int lock_static_subprog_unlock(struct __sk_buff *ctx)
+{
+	int ret = 0;
+
+	bpf_spin_lock(&lockA);
+	ret = static_subprog_unlock(ctx);
+	return ret;
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/test_spin_lock_fail.c b/tools/testing/selftests/bpf/progs/test_spin_lock_fail.c
index 86cd183ef6dc..43f40c4fe241 100644
--- a/tools/testing/selftests/bpf/progs/test_spin_lock_fail.c
+++ b/tools/testing/selftests/bpf/progs/test_spin_lock_fail.c
@@ -201,4 +201,48 @@ CHECK(innermapval_mapval, &iv->lock, &v->lock);
 
 #undef CHECK
 
+__noinline
+int global_subprog(struct __sk_buff *ctx)
+{
+	volatile int ret = 0;
+
+	if (ctx->protocol)
+		ret += ctx->protocol;
+	return ret + ctx->mark;
+}
+
+__noinline
+static int static_subprog_call_global(struct __sk_buff *ctx)
+{
+	volatile int ret = 0;
+
+	if (ctx->protocol)
+		return ret;
+	return ret + ctx->len + global_subprog(ctx);
+}
+
+SEC("?tc")
+int lock_global_subprog_call1(struct __sk_buff *ctx)
+{
+	int ret = 0;
+
+	bpf_spin_lock(&lockA);
+	if (ctx->mark == 42)
+		ret = global_subprog(ctx);
+	bpf_spin_unlock(&lockA);
+	return ret;
+}
+
+SEC("?tc")
+int lock_global_subprog_call2(struct __sk_buff *ctx)
+{
+	int ret = 0;
+
+	bpf_spin_lock(&lockA);
+	if (ctx->mark == 42)
+		ret = static_subprog_call_global(ctx);
+	bpf_spin_unlock(&lockA);
+	return ret;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.40.1


