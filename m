Return-Path: <bpf+bounces-15492-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6927F23A0
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 03:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EAE61C21631
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 02:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94EC14293;
	Tue, 21 Nov 2023 02:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OwJ2bX3S"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97140F4
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 18:07:42 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c87adce180so27084491fa.0
        for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 18:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700532460; x=1701137260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A0ghSxpKjD9gSMjDHKOOUuNA4BQMDyKp1g+4D9id6mg=;
        b=OwJ2bX3S0U8AhMJ6Ux936v0ntC1gBQrG8A8k7pPjcUUPY/mlosWz5URKK7ghRig5k3
         FqikBqLBfzjy66m4xl7Lk/dpMydwofLLGxY2n0Hvv07bw1A0vNE23Bs1Z5PB/79LCS/9
         LyR5pZspj3fN3rPojMoqlbm2x4h+VxCz4CiTAA1LUObMzH2AqKqmcvKNZ5/2ww+1GNca
         oCyMk/LvWthb7a7RXb9anBPGtc/JrvYsh/q5Wr8rZU+sgZJ746yJH6KkZDaCRABI5ZW9
         7mWWCV0KRIMTTbAoIZmzoUYHcoIyNiX9DQ6BfXHKMDCQnWKa8qav6K4/TP8Z6zpvUceH
         a81w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700532460; x=1701137260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A0ghSxpKjD9gSMjDHKOOUuNA4BQMDyKp1g+4D9id6mg=;
        b=KMIFBj4unHyPSWBUCGDbMJ+pcHf45FTwNAlbeuW4MpqiROGssHI4nZsndtMiW+jqgf
         w0X9qQucKVMvBuM72hhCnClV+j2H5uqBH6hvfuCFayIzyFU/fiwA22NxkfpfFdySO6AE
         Nfc9Rehgle42fcpway19FN4KLe8QSSitb7l3aT3FuwPP1eKdlGC8O4rIHKxb2nvhBS4o
         va60XUQ8dOVxqVPCGSC/0DnmdUizkIvZVQeLLE16y9JVIx6XgTGrwUPWSzQ1NPSD3Tav
         hwvC09tLkZNlI8cPnBB8fmx9G/pkIZUc2yyG8JVX2H4yhEtYlSqj/oTD8hfqMAqCCq1I
         Zokw==
X-Gm-Message-State: AOJu0YxMvLT6TD6zE+RyMtziZQrFyWmYoPzMd+5fz0BcEw8gqFi65gBl
	t6LPK2W2O8eB8B8fLBXdajSl4PRDkj0+wQ==
X-Google-Smtp-Source: AGHT+IFYcwETU5dHhGrvc3gCN48fZblIWgQc/VyfEwgg87hjnNitGdbKxtGcjAVS8cRqoPaELauK4w==
X-Received: by 2002:a2e:9e56:0:b0:2c5:724:fd64 with SMTP id g22-20020a2e9e56000000b002c50724fd64mr5189055ljk.46.1700532460217;
        Mon, 20 Nov 2023 18:07:40 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id ha7-20020a170906a88700b009fc990d9edbsm2426668ejb.192.2023.11.20.18.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 18:07:39 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	memxor@gmail.com,
	awerner32@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf v4 11/11] selftests/bpf: check if max number of bpf_loop iterations is tracked
Date: Tue, 21 Nov 2023 04:07:01 +0200
Message-ID: <20231121020701.26440-12-eddyz87@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231121020701.26440-1-eddyz87@gmail.com>
References: <20231121020701.26440-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check that even if bpf_loop() callback simulation does not converge to
a specific state, verification could proceed via "brute force"
simulation of maximal number of callback calls.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../bpf/progs/verifier_iterating_callbacks.c  | 75 +++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
index 598c1e984b26..5905e036e0ea 100644
--- a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
+++ b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
@@ -164,4 +164,79 @@ int unsafe_find_vma(void *unused)
 	return choice_arr[loop_ctx.i];
 }
 
+static int iter_limit_cb(__u32 idx, struct num_context *ctx)
+{
+	ctx->i++;
+	return 0;
+}
+
+SEC("?raw_tp")
+__success
+int bpf_loop_iter_limit_ok(void *unused)
+{
+	struct num_context ctx = { .i = 0 };
+
+	bpf_loop(1, iter_limit_cb, &ctx, 0);
+	return choice_arr[ctx.i];
+}
+
+SEC("?raw_tp")
+__failure __msg("invalid access to map value, value_size=2 off=2 size=1")
+int bpf_loop_iter_limit_overflow(void *unused)
+{
+	struct num_context ctx = { .i = 0 };
+
+	bpf_loop(2, iter_limit_cb, &ctx, 0);
+	return choice_arr[ctx.i];
+}
+
+static int iter_limit_level2a_cb(__u32 idx, struct num_context *ctx)
+{
+	ctx->i += 100;
+	return 0;
+}
+
+static int iter_limit_level2b_cb(__u32 idx, struct num_context *ctx)
+{
+	ctx->i += 10;
+	return 0;
+}
+
+static int iter_limit_level1_cb(__u32 idx, struct num_context *ctx)
+{
+	ctx->i += 1;
+	bpf_loop(1, iter_limit_level2a_cb, ctx, 0);
+	bpf_loop(1, iter_limit_level2b_cb, ctx, 0);
+	return 0;
+}
+
+/* Check that path visiting every callback function once had been
+ * reached by verifier. Variables 'ctx{1,2}i' below serve as flags,
+ * with each decimal digit corresponding to a callback visit marker.
+ */
+SEC("socket")
+__success __retval(111111)
+int bpf_loop_iter_limit_nested(void *unused)
+{
+	struct num_context ctx1 = { .i = 0 };
+	struct num_context ctx2 = { .i = 0 };
+	__u64 a, b, c;
+
+	bpf_loop(1, iter_limit_level1_cb, &ctx1, 0);
+	bpf_loop(1, iter_limit_level1_cb, &ctx2, 0);
+	a = ctx1.i;
+	b = ctx2.i;
+	/* Force 'ctx1.i' and 'ctx2.i' precise. */
+	c = choice_arr[(a + b) % 2];
+	/* This makes 'c' zero, but neither clang nor verifier know it. */
+	c /= 10;
+	/* Make sure that verifier does not visit 'impossible' states:
+	 * enumerate all possible callback visit masks.
+	 */
+	if (a != 0 && a != 1 && a != 11 && a != 101 && a != 111 &&
+	    b != 0 && b != 1 && b != 11 && b != 101 && b != 111)
+		asm volatile ("r0 /= 0;" ::: "r0");
+	return 1000 * a + b + c;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.42.1


