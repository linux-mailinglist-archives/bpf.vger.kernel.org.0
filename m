Return-Path: <bpf+bounces-73710-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F64C37B2F
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 21:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BDCB3A58DE
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 20:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CF434E771;
	Wed,  5 Nov 2025 20:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="eMTJLRR+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CC134DB79
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 20:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762374009; cv=none; b=gWUh60aezGnwO3jVKfT8iME/CQfUT/DVOIzCEY2rOwDP/4A86BOwknc/3UKjvv6EN0KDU86a6FbDQR7qwfGC91AI9znR9u0n9uTtjOtD3W0I/K4pWLHoHVioCY+xZMLwdklYtNnKVMQoW/eHBY9fjewMT2Lf6Dzij87rvrs5bSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762374009; c=relaxed/simple;
	bh=Y2LdFSioG8g7ODW7ylq50FrnsN/jGmVNxn8bY70Dfxs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I/S/GaTRo5P0pgQTMzXUtcU3TE+8t5vOBpFHiN5hkcni7kXB1d/DJZBbuIQM+4Jj2/SSyNdfvDb4Z46BRTTYcJHgCf2O9OT7hgmtwCuR1362fYp9rkm10ZdyNipAuGgVYD8mo1mIxfMyJIEhcfIX2T9UQt/ODKOCjgbvX1bEDUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=eMTJLRR+; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-640aaa89697so291209a12.3
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 12:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1762374005; x=1762978805; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=smKSa5PEnPQYiO/xTRww69R1IfUnmprG+VxEw4Hb8Ac=;
        b=eMTJLRR+jkI/QUR5Jx15hzt07jmo4SiW8TdnB3gQ7ya6cnmTdu1oGJFTrZbtSbjCMG
         1sxEcrTnha1qXPnQfNRj7rjIJV9X0m29jMogrhCEaz0oeanYim0EXiovHAWMy9uLO+J/
         iU4VXemE9t0o2Lab/FGEPdNivcI9lncEM0Kx6Et6F+kndeqDzi5oE0WEM446zx3b+75z
         aa8H4wwlf1lNCaCp8GceeZKF5IKOTcT8PhZWXT4L25jSuSoVWCmkmiFQadjFJgTaHmmi
         g6R3T1qt4YziyL6f01MOWbEESvaqEr0iz8TBaweTcGBwYQZO0ei+BnpiU8T94qHtvsjl
         7FOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762374005; x=1762978805;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=smKSa5PEnPQYiO/xTRww69R1IfUnmprG+VxEw4Hb8Ac=;
        b=ZEXq6gjN071BU3rV4tmDEPVb6jIWL2Za5Xc64VDsttFLTtBc94jVlu1PYVUVtg6JfH
         lAKJMVPwCtpJgYKuTjWuUZdJCcAg09d8fVA8UqRWqEw3I1xb82xahCSAP4Y0Y10+mNhi
         OwKoANrAaSsAGO4h9c8dmfNXGD/bO0R3PhztxqNAK67xUK6oe93vF7iLH8bVsi9OL/WE
         DQcIcAi58Jh/jJAnifuAZNNdtrAVuHeRNwpFPJVRdwkTjG29LlV8XPfFRuYrJYG+CtEg
         CDY2NMOFX/VXnKoestzrzTtqpiYYmcbVq8moOgdn6wg7nGVcjwZ584fYkhbWVXGwbIoE
         U9zw==
X-Gm-Message-State: AOJu0YyHOjfPe6bS4EwSBqgSOik8SWv2gH3/UXf+SEuBEkM6F2TwnRqu
	h/S1EqBRnrxGEuPhq7QlhwRsRojOFLVUt1RJO4FYbZmj3Hf70TPlATCFnRoC6dg4I04=
X-Gm-Gg: ASbGncsB4EZRs/Q9cJezsx34OVElYo5pc5VjS8bnBr1Yw8D0xJelJ2stClAb6YWTiKa
	aInJ8bDH1f6J6+r5ww5emUPpx/e1WCqNmkVUdh7e/XD119T6soxrfVmrlQ9v8X1wAoW25U/bVet
	x0R+MpNe+I4r3RKjrjPRXSkYhx5q+iarHQsXeJXhm559Zlv/x2PkX0NVNgbS0NBHV1pMBqZA4qM
	wtgwrHXoUQJ4kdFCZ91F+otpsGS2WCSYPvaQUP7p0hRqKA48TaELeXXgaXh5+i8HYbVjGuxcB7o
	ZL9J18PEkw4jwqb6CDegJXHI3As8UCb0W+ZZ7FPszuwjASIhtITRc6+DWRXvLvPbk5iOY2Rl2lU
	dZv8kHV7WdY2NSsZnFukuZv90v+3Wbdkuz786ulcOXy7POa+FJyJO28HvtRmasvGOzdG8BO5830
	NMSVVr3kRAy3SsYbYX85EFIZKuwGEvbOJb+w2L9jLcAOlRg7NmOcYwUenR
X-Google-Smtp-Source: AGHT+IFNXQINzOeV4swYoRdovmW3cf+3ri/ZC3LWiqRh2j7kLPwbPrOZR0TyAh5EZR3b9uCSKLi0kA==
X-Received: by 2002:a05:6402:35d6:b0:63c:690d:6a46 with SMTP id 4fb4d7f45d1cf-641058d0b39mr4080673a12.13.1762374005502;
        Wed, 05 Nov 2025 12:20:05 -0800 (PST)
Received: from cloudflare.com (79.184.211.13.ipv4.supernova.orange.pl. [79.184.211.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f86e12fsm42874a12.34.2025.11.05.12.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 12:20:05 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 05 Nov 2025 21:19:48 +0100
Subject: [PATCH bpf-next v4 11/16] selftests/bpf: Dump skb metadata on
 verification failure
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-skb-meta-rx-path-v4-11-5ceb08a9b37b@cloudflare.com>
References: <20251105-skb-meta-rx-path-v4-0-5ceb08a9b37b@cloudflare.com>
In-Reply-To: <20251105-skb-meta-rx-path-v4-0-5ceb08a9b37b@cloudflare.com>
To: bpf@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
 KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Arthur Fabre <arthur@arthurfabre.com>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, 
 kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

Add diagnostic output when metadata verification fails to help with
troubleshooting test failures. Introduce a check_metadata() helper that
prints both expected and received metadata to the BPF program's stderr
stream on mismatch. The userspace test reads and dumps this stream on
failure.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../bpf/prog_tests/xdp_context_test_run.c          | 24 ++++++++++++++++++---
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 25 ++++++++++++++++++----
 2 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index 93a1fbe6a4fd..db3027564261 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -171,6 +171,21 @@ static int write_test_packet(int tap_fd)
 	return 0;
 }
 
+static void dump_err_stream(const struct bpf_program *prog)
+{
+	char buf[512];
+	int ret;
+
+	ret = 0;
+	do {
+		ret = bpf_prog_stream_read(bpf_program__fd(prog),
+					   BPF_STREAM_STDERR, buf, sizeof(buf),
+					   NULL);
+		if (ret > 0)
+			fwrite(buf, sizeof(buf[0]), ret, stderr);
+	} while (ret > 0);
+}
+
 void test_xdp_context_veth(void)
 {
 	LIBBPF_OPTS(bpf_tc_hook, tc_hook, .attach_point = BPF_TC_INGRESS);
@@ -249,7 +264,8 @@ void test_xdp_context_veth(void)
 	if (!ASSERT_OK(ret, "send_test_packet"))
 		goto close;
 
-	ASSERT_TRUE(skel->bss->test_pass, "test_pass");
+	if (!ASSERT_TRUE(skel->bss->test_pass, "test_pass"))
+		dump_err_stream(tc_prog);
 
 close:
 	close_netns(nstoken);
@@ -314,7 +330,8 @@ static void test_tuntap(struct bpf_program *xdp_prog,
 	if (!ASSERT_OK(ret, "write_test_packet"))
 		goto close;
 
-	ASSERT_TRUE(*test_pass, "test_pass");
+	if (!ASSERT_TRUE(*test_pass, "test_pass"))
+		dump_err_stream(tc_prio_2_prog ? : tc_prio_1_prog);
 
 close:
 	if (tap_fd >= 0)
@@ -385,7 +402,8 @@ static void test_tuntap_mirred(struct bpf_program *xdp_prog,
 	if (!ASSERT_OK(ret, "write_test_packet"))
 		goto close;
 
-	ASSERT_TRUE(*test_pass, "test_pass");
+	if (!ASSERT_TRUE(*test_pass, "test_pass"))
+		dump_err_stream(tc_prog);
 
 close:
 	if (tap_fd >= 0)
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index 11288b20f56c..3b137c4eed6c 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -27,6 +27,23 @@ static const __u8 meta_want[META_SIZE] = {
 	0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38,
 };
 
+static bool check_metadata(const char *file, int line, __u8 *meta_have)
+{
+	if (!__builtin_memcmp(meta_have, meta_want, META_SIZE))
+		return true;
+
+	bpf_stream_printk(BPF_STREAM_STDERR,
+			  "FAIL:%s:%d: metadata mismatch\n"
+			  "  have:\n    %pI6\n    %pI6\n"
+			  "  want:\n    %pI6\n    %pI6\n",
+			  file, line,
+			  &meta_have[0x00], &meta_have[0x10],
+			  &meta_want[0x00], &meta_want[0x10]);
+	return false;
+}
+
+#define check_metadata(meta_have) check_metadata(__FILE__, __LINE__, meta_have)
+
 SEC("tc")
 int ing_cls(struct __sk_buff *ctx)
 {
@@ -36,7 +53,7 @@ int ing_cls(struct __sk_buff *ctx)
 	if (meta_have + META_SIZE > data)
 		goto out;
 
-	if (__builtin_memcmp(meta_want, meta_have, META_SIZE))
+	if (!check_metadata(meta_have))
 		goto out;
 
 	test_pass = true;
@@ -54,7 +71,7 @@ int ing_cls_dynptr_read(struct __sk_buff *ctx)
 	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
 	bpf_dynptr_read(meta_have, META_SIZE, &meta, 0, 0);
 
-	if (__builtin_memcmp(meta_want, meta_have, META_SIZE))
+	if (!check_metadata(meta_have))
 		goto out;
 
 	test_pass = true;
@@ -92,7 +109,7 @@ int ing_cls_dynptr_slice(struct __sk_buff *ctx)
 	if (!meta_have)
 		goto out;
 
-	if (__builtin_memcmp(meta_want, meta_have, META_SIZE))
+	if (!check_metadata(meta_have))
 		goto out;
 
 	test_pass = true;
@@ -153,7 +170,7 @@ int ing_cls_dynptr_offset_rd(struct __sk_buff *ctx)
 		goto out;
 	__builtin_memcpy(dst, src, chunk_len);
 
-	if (__builtin_memcmp(meta_want, meta_have, META_SIZE))
+	if (!check_metadata(meta_have))
 		goto out;
 
 	test_pass = true;

-- 
2.43.0


