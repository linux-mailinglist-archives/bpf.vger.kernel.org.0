Return-Path: <bpf+bounces-72242-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 526A7C0A960
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 15:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BE5D94E6691
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 14:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6012EAB7D;
	Sun, 26 Oct 2025 14:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="TZ29X/wy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0DD2EA14D
	for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 14:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761488336; cv=none; b=jdOrh5MnZBE4ZKGPo/3TpEvvsTLaXIfk+HYDYbIC6T8eeTGMFScJ8RoifKbV0gip0igT+cTBFd4DVF+wpsGGr7UGwT2eF3NrpseoyHkHq6OtP8dEfzrrULVcXYh74VOq3c7vIrujVDJprwOUDy0TuAcSFQL8NvnFq19Ftpsbc78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761488336; c=relaxed/simple;
	bh=QLtifLAo6DoQNQzqPAPg3BdJ/ZCpnYmryjgKOcJtCDU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QelFSVj0xsW89f2LHzgswCUOU8c54sbsAiirh/a5Jp2z9ifrQWyXOdQeMjDj6a87AOpv7wH/NcRrpKbEp1qPKp2sexSCURFLWONn/sKzIeenPCdnetNjSCOZRSbAYTy0P5ay/3CX+JO0qJPc0tq/3Y5Nnzy6y2OHF91CKWpvGyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=TZ29X/wy; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b6d855ca585so298446666b.0
        for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 07:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1761488333; x=1762093133; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L7z6z0qFsyvfpYZ94W/vWTb8pxF4QWqgrEJLgT+yyI8=;
        b=TZ29X/wykdPsK79dkwfMtI0mH9vyh363JFB3AvWPze5TAyVTaysb4GmY/nJPbDtFoL
         DImjhMSZFJfxZAfTQmgjjaqBs69ya4fqXwlQN9CVXm96WNGLqPhYqLc1Hk7ggvjJrBaD
         gryxx6WXZjdOLlrexpRaHHxAYxOZV7cxU8IwsoGIKiInGgAydy5URVAc4Pe5l7a/S1cO
         PNrqnRqYBIG2mrKLc3GIejDHYkJmAYQWj/xOsMlvi8T7s3EB8d05vkPOwTTB32kjNvLI
         I9EPr5DvvLDLs6FNaeBlT+mytY+Cl4D3bQQM6N5wXbpC+m14Z2jZ/F00GDYmBPl9pfYl
         ZTUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761488333; x=1762093133;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L7z6z0qFsyvfpYZ94W/vWTb8pxF4QWqgrEJLgT+yyI8=;
        b=slcCNNlHW1mMW3UU7es6ntv+C55HOD8SX+C5rnR0xnvOzw2LrUEeFEzRPoVnZVJ7Sv
         UoIV1O7mDtzl0s9yVUWMBmtB9WpqA/I/kdt1gpuEa47jf+Tc6EZ1+N9wmjCr+HIsuLWD
         CMay7OB1QYu7YMYgSYpxaAyU6LwoJ3F9dhKlOGoi2dLwCN+mF/WVm8GQz38xj311ZCLN
         bI1+AVdGeiivWLUkIMnIgBJ2i8OaB3KhW6MAsxmTQmCV7udUYLJ+6msFWjAfMMjxkR8m
         sP/HkZl0EKv8x2+eo1SOf7XJBHxVZI+BAs0LkDSsDodTr/KcsfMfGfi8Fah0WiKupDbW
         NT/g==
X-Gm-Message-State: AOJu0YwDorenJ3qji/zBqHQLB+RsAEQxgkW/52jv7HqGf0KyJHi51dwr
	2sz8LDphOqoOt1sT8FAUst6CQuHHIMj3TVYuPpXDnYh14vcTVWZ9QT3vLFO7c8IEC9M=
X-Gm-Gg: ASbGncuEvC4116tBMwKIfF7cuMx6QqULIYKqt3gk1inDalH/RAugJcnkUjOTX6o2jxG
	t+8fKmKWkN7g2L8tETzu0tuWoqd1xA8/euiv2VxkBt6qcG1nCXIBfinhHHAIAe8XelezKSmPKOy
	KQzQ9PP1GZbfaR6ECJUwzFJR2cDZ9weocEKSxEdmA2GFstOMsxGeDW//xhDMfKZT9WSYzsFvzLj
	3hi4ROw2jBeeEnjGxsQGbYi5iBCwgIHYcsUVtUJPTEUYMtq3TNsmEckidlbkB1OqWYxVc/y6nF/
	/9Q81UP2fi5WTy5Xu1GMcuRFO16vblYXEf2nQ7Eh5GDRzxARu3JI6nEpnq+5UwKinJ8v+FrGdga
	uam1wHTo7FXflyJ9KE1RXgCyECuLlZASZVWeT1ecyLwCLGA5zXk+k9yti9btSGrn/xwNdVNFLhV
	oXJ8BlqF9JQrcIUVAP4PUFTxRbxe7Wim/4gFJw8CTUGLE10w==
X-Google-Smtp-Source: AGHT+IHJvlwy7v1F8N3cycRZrmkjSsl1meGJXvz7OXM7p5PUXryDbr4CaoiylSWqji6oVKxWBeztiw==
X-Received: by 2002:a17:906:81d9:b0:b6d:5b0c:289e with SMTP id a640c23a62f3a-b6d5b0c447fmr707687466b.0.1761488332693;
        Sun, 26 Oct 2025 07:18:52 -0700 (PDT)
Received: from cloudflare.com (79.184.211.13.ipv4.supernova.orange.pl. [79.184.211.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85359687sm475555166b.23.2025.10.26.07.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 07:18:52 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sun, 26 Oct 2025 15:18:31 +0100
Subject: [PATCH bpf-next v3 11/16] selftests/bpf: Dump skb metadata on
 verification failure
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251026-skb-meta-rx-path-v3-11-37cceebb95d3@cloudflare.com>
References: <20251026-skb-meta-rx-path-v3-0-37cceebb95d3@cloudflare.com>
In-Reply-To: <20251026-skb-meta-rx-path-v3-0-37cceebb95d3@cloudflare.com>
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
index 11288b20f56c..74d7e2aab2ef 100644
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
+			  &meta_want[0x00], &meta_have[0x10]);
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


