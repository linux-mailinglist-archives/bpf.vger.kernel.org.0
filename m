Return-Path: <bpf+bounces-21180-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60814849119
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 23:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DDC8B2167E
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 22:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA033306D;
	Sun,  4 Feb 2024 22:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0QwID8V"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com [209.85.208.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0109A32C89
	for <bpf@vger.kernel.org>; Sun,  4 Feb 2024 22:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707085437; cv=none; b=Bh8z25yFpSVcW5LeFGGd5BfJ63MO4vvgMss9WKBXlxXc9ClLLZvvWcrWViXsNf/zoMj2PqeRrxHCS4r4rfnjB/YiCyilx4Sm2TJfupOY89Fw3tpL7azb8mD28PH+NKdEeW+4lnQkNVEOKL3anwebTmsTJbemqy/a5Qbjazkcsgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707085437; c=relaxed/simple;
	bh=XlVGccAMCI4kQ82Ls3xgzmyKMfOfsYyl1e8aefd1IJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k7orsrMPKmSQKB6G6a35vMdA327Se7fureq8mvHQrFAXLxOCC7+VtMf6YI4MqTn6QRcSCN5yMi1K002jNPAaXYaLmjMD4xAqDMl15YzYLWpXKCAEMqKiYcqk7zXa1vBBzyWmy6Kgd7tuKWoWKcA40vzdLq2D5eimabrwPb40LYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B0QwID8V; arc=none smtp.client-ip=209.85.208.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f195.google.com with SMTP id 38308e7fff4ca-2d08d34ce3dso20433881fa.0
        for <bpf@vger.kernel.org>; Sun, 04 Feb 2024 14:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707085433; x=1707690233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VVgWbM5LoZ892lrNUYxdHR7INkePd6xfx3uwdr4im5A=;
        b=B0QwID8VNy4QJjuut3loJxTgq3IqXd2A2v3nIIg0erWUHpppJgShH5suyEgFfwhpJi
         Bg0QA4RF4fcL4kSCMIpjbyZcwHiPxKjPDjBJV0RW/8Sy/Tew3Q4j/FthSYCdBvo5m5Bj
         UEriOeuQrSrlyfh7MjoWasICoGC83yskp+ARp72/FU4cmwXtXQE6BaJpu58qb0rxdQMR
         HyFcjudl49L+fh99gx0wSDnA1nOZZb1Z7XxrVju2UeDTLagtZorWmet/kdqZyU2ojw91
         59xdFb7Whb4HpsrudL2sqpkC+BJQU0MhQYccSxOzgoZkt9dMQHYFpLDOe2bjCKdZ6N5S
         +I5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707085433; x=1707690233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VVgWbM5LoZ892lrNUYxdHR7INkePd6xfx3uwdr4im5A=;
        b=fus+WtrRFinqWPynC7huGg89ZpOWnhhaAB2RVaG9luhXFlkd+ySA3Mxo8B44GEDpho
         b+fsxqugwMGWdFfkjzljB4jUvTLW5urrO1H4N49OoraxUgdXgOmSH4BDXdJ1/YoRGSK8
         3YbJUOnw6c3LxzWpTaQ7rdgeLhSbTWW7LuPBIjevL/WyfPR2Jh045x52fXtPz4oSEQyj
         ppT0eU6RHsdj0YalLsbQtdcwsPbOvsHVZ+F1W0ZL4hZOJUZL2sJ5086e+Df1AMLu92/J
         dk+tTrNGgDBpGeWhOZpBCzy067xuFl43n/CafmvpxLZs4GAPiQ15g/BNsBK5gX4qs6Tp
         qExQ==
X-Gm-Message-State: AOJu0YzitjUOv9cX7wDTeCJTciBwqNyPhot/NKZgwkxms9OXQyXjNDuf
	fUtHYLK4YGnHVKuXuTUgn+yBpdWh+e4/gCQTySNKpMawMU7C6z1znjf6WiBG0Vc=
X-Google-Smtp-Source: AGHT+IECyJ4QtMPSC4a4sDnxCMH3oie9HHKwHu18UcLaVmfp8yMf1zjzX3XZYecU9mmu3+kA0i/eKw==
X-Received: by 2002:a2e:be87:0:b0:2d0:9344:a0d2 with SMTP id a7-20020a2ebe87000000b002d09344a0d2mr4522059ljr.42.1707085433175;
        Sun, 04 Feb 2024 14:23:53 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUrMt3MceCTNTFDoR1A5eIUbHst3ucmopBW8mSwf/Z0QlwcjwTIBef2GNH6dvT/sCxEYaHcoI/oRKST8yzP+xk1q3U/fyNtHW7PDfnIRygOYqnihdXRDmo4eD4qV5YCgD3Wa8fCD66wSPRx8FH+sBoMWAwdz67zI7Y9FJcSnrs47oKpXJc0i/aVbd9zzW//kCmzI+XrHiyaSI0VUQ2yeFfGIXft2r7oOhpf7+QYz3npVsaX
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ig12-20020a056402458c00b0055c46f452c2sm3090293edb.65.2024.02.04.14.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 14:23:52 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Yonghong Song <yonghong.song@linux.dev>,
	David Vernet <void@manifault.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Barret Rhoden <brho@google.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Add test for static subprog call in lock cs
Date: Sun,  4 Feb 2024 22:23:49 +0000
Message-Id: <20240204222349.938118-3-memxor@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240204222349.938118-1-memxor@gmail.com>
References: <20240204222349.938118-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4413; i=memxor@gmail.com; h=from:subject; bh=XlVGccAMCI4kQ82Ls3xgzmyKMfOfsYyl1e8aefd1IJ0=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBlwAwrRadKFaKn49QpbhpDBXnVtSfXUinExWb4F iwgI2UVYgmJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZcAMKwAKCRBM4MiGSL8R ytNSD/0djkET4SKCpv7CfPExVa43ej2EWJ12KZn8vsMmnm+jBSceXnUlhiaQ8xIuPMcDetMpPqO xd/+GzqLEQyjjeuEkTlOys03CqDDJOY2Usn77IQObNe2jCeIdjqPwJtQWuEQkJ4zt/Av5MSfBez /8ihgsCYSFOcRJ1WAsXFntJ2EmZsTkSsq1r6Bdf5N1TUHOxD72vDvTK2BmHiJ45GWqIY6/vFjFy SHREc8s+60BRXM2oTM9LgPhupDIIEk5Ux9QizXeDVzHcbVRRxNRtExV5rDj7zbtLPUtL+3WAl+q JBGcWt7/RedV8zlYjI2DQrhAF/eUZLdVs2pdMyON4s1ka6XcvJet1AvCwVH5Dm+dD0bqH6W8BKm VRvOhJr23jb7gV7CFUawSA8EES7CIkM+oHVw2oTlf7BJ9jUlhHV7HTYSW9xkJoaNnxYV3E1d/Vq bXSMrwo7di8BXZS/TJwTA3eQTDVSGU8HuArTVFNolw538E2SuvclWhFqUXP+8Pf74pigXYAGAVP jJ+a4+PDSzmy8Ep23CredcTOONHJi2W2Apxu+MGRDQcnQuFqu0nfEaYMGkE5G5lqACNsYRZyZLS of3P9qgjI8pK8XixR3R5pleF4K7TSqJXgoa1tnyKkE0Goe7ArU/gFpUBdVsNMbHVDtWVj5ujalq h2X4WIwWqflfylw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Add selftests for static subprog calls within bpf_spin_lock critical
section, and ensure we still reject global subprog calls. Also test the
case where a subprog call will unlock the caller's held lock, or the
caller will unlock a lock taken by a subprog call, ensuring correct
transfer of lock state across frames on exit.

Acked-by: Yonghong Song <yonghong.song@linux.dev>
Acked-by: David Vernet <void@manifault.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/spin_lock.c      |  2 +
 .../selftests/bpf/progs/test_spin_lock.c      | 65 +++++++++++++++++++
 .../selftests/bpf/progs/test_spin_lock_fail.c | 44 +++++++++++++
 3 files changed, 111 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/spin_lock.c b/tools/testing/selftests/bpf/prog_tests/spin_lock.c
index 18d451be57c8..2b0068742ef9 100644
--- a/tools/testing/selftests/bpf/prog_tests/spin_lock.c
+++ b/tools/testing/selftests/bpf/prog_tests/spin_lock.c
@@ -48,6 +48,8 @@ static struct {
 	{ "lock_id_mismatch_innermapval_kptr", "bpf_spin_unlock of different lock" },
 	{ "lock_id_mismatch_innermapval_global", "bpf_spin_unlock of different lock" },
 	{ "lock_id_mismatch_innermapval_mapval", "bpf_spin_unlock of different lock" },
+	{ "lock_global_subprog_call1", "global function calls are not allowed while holding a lock" },
+	{ "lock_global_subprog_call2", "global function calls are not allowed while holding a lock" },
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


