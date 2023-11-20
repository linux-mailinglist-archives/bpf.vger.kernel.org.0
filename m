Return-Path: <bpf+bounces-15450-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C617F211A
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 00:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9879B214D6
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 23:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA8B3B28B;
	Mon, 20 Nov 2023 23:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXXIXHL5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689F4A2
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 15:00:22 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50aab0ca90aso2554130e87.0
        for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 15:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700521220; x=1701126020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A0ghSxpKjD9gSMjDHKOOUuNA4BQMDyKp1g+4D9id6mg=;
        b=IXXIXHL5AVmNNxD03Uh3+8lcN5mW3IUqWEYAXfdikJlPh+b8k7DTyUsGp2kfwNDKAn
         Yl3rUxSjONuhIrCH/c/cM6treTTzuEj9ywk1tQo3T0chy+GlCrggY9gBVRXPG7gD79ug
         SzyvqdQkeb7we5UmWse5GVVd6JFoHFHYb9kaGwrSFbTwbm6Qj5gzWiNBRWWbUEY6uNd5
         pGluf5v0SNRkeV1eaBb05sRrtGW721q1bDoq+P/fgHwfUyyuqzNaBD3/Z5xsCvx1t4it
         5Gou9kTMNB0sIkZaKnnp8wt5+rFpcO1jWSRmbIniR/Z621/hi4CSoTuGwck91UmVWpKH
         7Hsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700521220; x=1701126020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A0ghSxpKjD9gSMjDHKOOUuNA4BQMDyKp1g+4D9id6mg=;
        b=vCnA/wpyZCmyvisxhUJbyH/q/4qSwftrLTqwaU5cYWMx95hMSHQDMhzpGB/nzGMUTU
         G3l35mmVa5Ws5/pkFUBjbCjQpkCqyqiAIWoLUIZRTy49BeASIykU5YyylJU/eRN1Sr68
         9na5429zj/vuwX0EbCphJ4de7igiGJ6tWFlCShuqrF5G/04zxBUifzQp1rr2WMzjL7Dy
         UIN5siI2BxI/cTVeo6fuPi/xyitDYKmB3z+M/L0kdcB3wENvnAl/AGMtfIz5rlfWhZao
         mNKkIOZdb22jxQRy/Z8PXud5r48EJuS88i/V9qCHmWEHn3g6ZP9FwfXLEyA8BHDKQci6
         NpMA==
X-Gm-Message-State: AOJu0Yz6qgAT2ynEvtkjch0kHbKuPfPXeC9wnBs9YehN14Z3nR4ktg3/
	4vK7tZYvOHbhMiJgf+V/hZnAHCbvVZqp0Q==
X-Google-Smtp-Source: AGHT+IEdQL9eFnZvW2mGwZ8ZxVvt11Aq51CdQa/roTt7KRBR3cnB3ybutR8MdPsqw/bqxYa5y0s7Xw==
X-Received: by 2002:a2e:7013:0:b0:2c4:ff4c:64b0 with SMTP id l19-20020a2e7013000000b002c4ff4c64b0mr5022339ljc.50.1700521220011;
        Mon, 20 Nov 2023 15:00:20 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id a9-20020a170906468900b009fd6a22c2e9sm1968039ejr.138.2023.11.20.15.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 15:00:18 -0800 (PST)
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
Subject: [PATCH bpf v3 11/11] selftests/bpf: check if max number of bpf_loop iterations is tracked
Date: Tue, 21 Nov 2023 00:59:45 +0200
Message-ID: <20231120225945.11741-12-eddyz87@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231120225945.11741-1-eddyz87@gmail.com>
References: <20231120225945.11741-1-eddyz87@gmail.com>
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


