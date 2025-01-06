Return-Path: <bpf+bounces-47986-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0EBA02EC2
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 18:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB5C63A4472
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 17:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3075D1DEFEE;
	Mon,  6 Jan 2025 17:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="LRBKxXOS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B411E1662E9
	for <bpf@vger.kernel.org>; Mon,  6 Jan 2025 17:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736183854; cv=none; b=HJl0/0uv4hPS/UFeBVShT+rD7o6NS7Kjm4b4LOYGwDaTWTkMg+KK5DsyIQq2E1kxqcElAA2YMRHEpl6vOgIXvXZRgRXt3cb6IW0mAsypXkpI7Z7DJ+RiooNWZ0x8xMqd5RPIXC1NX+Wc5VASJYrsFkZIS6vmEbcNGQBnGD1UQb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736183854; c=relaxed/simple;
	bh=UxqtV4SbtxCupf91XErW9+Yg18jcYmzfpXU27iTJTkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SatKU3AKZH1BXcGYHByj3Mbbnd7Pm6JHYdpj+sTYUq3EgkTggN/AcbOHV+XOVcyZFWKySJo12QvWfOaGdG9sCh0EisOYT5/TlmaaJbaeAFZvJuQuN9YJwECjjrZiIQwWgqC/PTPf7LXLMoaFL4lbyf1Ms/oNu3PZbIX5ntuxQzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=LRBKxXOS; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4363ae65100so151529105e9.0
        for <bpf@vger.kernel.org>; Mon, 06 Jan 2025 09:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1736183851; x=1736788651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ao2buTeBKgpBg5jLDZxMj75DXzBdGOGqo6Xu0Qkj0uM=;
        b=LRBKxXOSRwfqbAOIe4EB6xy7wVUF6phr+Bd9+bo/GM7JVQe6ftxWbpG4XBh9Vv0shp
         ZfCf6NTRfgweSn5W7kiuTJUlHGUo4qd0LoB3z4vIbIwzENTNg+M+X5zLTDtIb0yVnOj4
         X4OvofnGR9zZY/MDTLv2IglHymDHHVuL5arTdbvsVepE10mLOSdA8oUVxxY3XE3nzWok
         ooW/+OtKoIrmawPqF4GNJ7iBCftBNQFfBnrwmU+8Ehhz4nv5kGF1x/PK/pQIYorpzqVF
         3zdRQho/kU3SvFXN3tyUFCi8WApU60IRAnG084+71E4+y3YZIl7S7TlxVYQ1npBTYXxp
         pP7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736183851; x=1736788651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ao2buTeBKgpBg5jLDZxMj75DXzBdGOGqo6Xu0Qkj0uM=;
        b=DfsFwDpMCzQaPJTQgs6HLrHr+cUocWzuRz8OWFon9aUuW6Pmr17MDdRVNs5Du8tg1J
         i8gaAkFDRFfPinN4RT8RQjZ8a1Z/ndv0bJ9edvkrS35L+JmGU8k1t/P/znGF4UjPljph
         TnN1Kk7ybpzFiOk4LviW8xkiS3SMQasr+evjd1HcJV2g7QYN4E6gRvdGLhemETRIWwn5
         TxY1crS3AqqZjwqhNoaMz3M+eu2wXM2KdFATov+pJ83ScVt+jU7gqG55GuneEFP1s/Uu
         I48jFzoT0epdIHmRDYfkOy8ghYe9jZVZCIaeqF+nVSOV6riNU++5XHMisbw4R0S/7I3D
         jbxw==
X-Gm-Message-State: AOJu0YyKDQqGJcm6GXBcmKOaIlrz7t40ftFuqn3TjZqoPE4BH13rU9mG
	SR8fuW5jVE9t1b7gYcveplLhIOUtjNSHZI3daY5XcbTNTThS6H4JxRWZDMgDzTfDZkYnbN/zWnH
	xPb+Dkw==
X-Gm-Gg: ASbGncsiT0grWtGT9o3VoWkgqwZh+oqhzleuEyqpcDxj038sjtDYAUH1UrlCpIujor8
	BOxGqHwCBg+ERJY146Ef0Y86xxXSdJBQUFaPMuUx25AGNSAZlCd5kBVae4vG1IL34N171mXg2dH
	/L2vpyOmGjEHJRqd0ql4Y+s3fqBwx6IdrEUqrgiLmA4AYA0r/5iFFRHR1iJBFBW0oNmMve/XbYR
	DIKPx3CB8x/F62BYwvCd7pGXDZ8GyDI9ehiyQ==
X-Google-Smtp-Source: AGHT+IH5o7RpS3LHoo+2qcrpkzV5bKSGRkWhGFuyOArX+maZneUIORpURtuWagy40ejUMpg4iGTRPQ==
X-Received: by 2002:a05:600c:4709:b0:436:1ac2:1acf with SMTP id 5b1f17b1804b1-43668a3a35dmr446059895e9.20.1736183850621;
        Mon, 06 Jan 2025 09:17:30 -0800 (PST)
Received: from bobby.. ([2a09:bac1:27c0:58::241:2f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c828bd3sm47658263f8f.10.2025.01.06.09.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 09:17:30 -0800 (PST)
From: Arthur Fabre <afabre@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	kernel-team@cloudflare.com,
	Arthur Fabre <afabre@cloudflare.com>
Subject: [PATCH bpf v3 2/2] selftests/bpf: Test r0 and ref lifetime after BPF-BPF call with abnormal return
Date: Mon,  6 Jan 2025 18:15:25 +0100
Message-ID: <20250106171709.2832649-3-afabre@cloudflare.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250106171709.2832649-1-afabre@cloudflare.com>
References: <20250106171709.2832649-1-afabre@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In all three cases where a callee can abnormally return (tail_call(),
LD_ABS, and LD_IND), test the verifier doesn't know the bounds of:

- r0 / what the callee returned.
- References to the caller's stack passed to the callee.

Additionally, ensure the tail_call fallthrough case can't access r0, as
bpf_tail_call() returns nothing on failure.

Signed-off-by: Arthur Fabre <afabre@cloudflare.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_abnormal_ret.c         | 115 ++++++++++++++++++
 2 files changed, 117 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_abnormal_ret.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 3ee40ee9413a..6bed606544e3 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -3,6 +3,7 @@
 #include <test_progs.h>
 
 #include "cap_helpers.h"
+#include "verifier_abnormal_ret.skel.h"
 #include "verifier_and.skel.h"
 #include "verifier_arena.skel.h"
 #include "verifier_arena_large.skel.h"
@@ -133,6 +134,7 @@ static void run_tests_aux(const char *skel_name,
 
 #define RUN(skel) run_tests_aux(#skel, skel##__elf_bytes, NULL)
 
+void test_verifier_abnormal_ret(void)         { RUN(verifier_abnormal_ret); }
 void test_verifier_and(void)                  { RUN(verifier_and); }
 void test_verifier_arena(void)                { RUN(verifier_arena); }
 void test_verifier_arena_large(void)          { RUN(verifier_arena_large); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_abnormal_ret.c b/tools/testing/selftests/bpf/progs/verifier_abnormal_ret.c
new file mode 100644
index 000000000000..185c19ba3329
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_abnormal_ret.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "../../../include/linux/filter.h"
+#include "bpf_misc.h"
+
+#define TEST(NAME, CALLEE) \
+	SEC("socket")					\
+	__description("r0: " #NAME)	\
+	__failure __msg("math between ctx pointer and register with unbounded min value") \
+	__naked int check_abnormal_ret_r0_##NAME(void)	\
+	{						\
+		asm volatile("				\
+		r6 = r1;				\
+		r2 = r10;				\
+		r2 += -8;				\
+		call " #CALLEE ";			\
+		r6 += r0;				\
+		r0 = 0;					\
+		exit;					\
+	"	:					\
+		:					\
+		: __clobber_all);			\
+	}						\
+							\
+	SEC("socket")					\
+	__description("ref: " #NAME)	\
+	__failure __msg("math between ctx pointer and register with unbounded min value") \
+	__naked int check_abnormal_ret_ref_##NAME(void)	\
+	{						\
+		asm volatile("				\
+		r6 = r1;				\
+		r7 = r10;				\
+		r7 += -8;				\
+		r2 = r7;				\
+		call " #CALLEE ";			\
+		r0 = *(u64*)(r7 + 0);			\
+		r6 += r0;				\
+		exit;					\
+	"	:					\
+		:					\
+		: __clobber_all);			\
+	}
+
+TEST(ld_abs, callee_ld_abs);
+TEST(ld_ind, callee_ld_ind);
+TEST(tail_call, callee_tail_call);
+
+static __naked __noinline __used
+int callee_ld_abs(void)
+{
+	asm volatile("					\
+	r6 = r1;					\
+	r9 = r2;					\
+	.8byte %[ld_abs];				\
+	*(u64*)(r9 + 0) = 1;				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_insn(ld_abs, BPF_LD_ABS(BPF_W, 0))
+	: __clobber_all);
+}
+
+static __naked __noinline __used
+int callee_ld_ind(void)
+{
+	asm volatile("					\
+	r6 = r1;					\
+	r7 = 1;						\
+	r9 = r2;					\
+	.8byte %[ld_ind];				\
+	*(u64*)(r9 + 0) = 1;				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_insn(ld_ind, BPF_LD_IND(BPF_W, BPF_REG_7, 0))
+	: __clobber_all);
+}
+
+SEC("socket")
+__auxiliary __naked
+int dummy_prog(void)
+{
+	asm volatile("r0 = 1; exit;");
+}
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(int));
+	__array(values, void(void));
+} map_prog SEC(".maps") = {
+	.values = {
+		[0] = (void *)&dummy_prog,
+	},
+};
+
+static __noinline __used
+int callee_tail_call(struct __sk_buff *skb, __u64 *foo)
+{
+	bpf_tail_call(skb, &map_prog, 0);
+	*foo = 1;
+	return 0;
+}
+
+SEC("socket")
+__description("r0 not set by tail_call")
+__failure __msg("R0 !read_ok")
+int check_abnormal_ret_tail_call_fail(struct __sk_buff *skb)
+{
+	return bpf_tail_call(skb, &map_prog, 0);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.0


