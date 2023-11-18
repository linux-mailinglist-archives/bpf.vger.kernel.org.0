Return-Path: <bpf+bounces-15292-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 282B17EFCFD
	for <lists+bpf@lfdr.de>; Sat, 18 Nov 2023 02:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D780E28141C
	for <lists+bpf@lfdr.de>; Sat, 18 Nov 2023 01:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5043723D3;
	Sat, 18 Nov 2023 01:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCYJAzPx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E5210D0
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 17:34:21 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-53de8fc1ad8so3786480a12.0
        for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 17:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700271259; x=1700876059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVsk1nWNIlqwH15IZDJI/xiM/rM1Xw6z9gHylJp7wfE=;
        b=VCYJAzPxv3IRjsq7SfKjGCvom7K4PadTVtyyng5xuKkWqN5fhQuGuLvzUr3roFsoOE
         HYz2moapOBwnZIqseSngn8pVrqv7LgL7eV2rRqJ4a0m0tvs7yXoN8aSHcKxXGiMMkKgp
         rZSNeRViKaWpplmKxYJiRCUK6ZO2l6OZJaEoxc1s+lys6riZvb5BiKNetrnng8Kiq4HN
         mX2ZYrARyw+Q+7K5k/TP2QB4quTBeMyou/6B4Ro8ugeoIkLn/LF356IWnR/8QLtB51Lq
         fPCI0/6nMZkyTEa8gWT1AmdhrWCO0vUdfCrVTkUopHGDD/Uu83ZZ0tktZEXdD3ynsdby
         AZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700271259; x=1700876059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oVsk1nWNIlqwH15IZDJI/xiM/rM1Xw6z9gHylJp7wfE=;
        b=B5gQXz+xGPYVgh0eAb6QlamdDt2TP+b03pyyf+bF/hDGdAwAiUmH6MAR5RgvUyB/Yo
         gn/A7/lsaNtWVuMOrlt8TAVYIY18jft1LzSSBxNaDmP0y9VrnDD/dLmaH7/GzyF08k7p
         lcV9qPFmtSxyFYPNktDw7+KKuLoyKwKbDIYy/gGB7b4AQhawVFIsBLJnX+OoV6xYSW2Q
         r0d5FdH47pUbT7wFlzoNQKLj1zJSspk7t+Hqym47GoOVv1fYjntzaNpMNnIqD3a839Q5
         zQO7wjM0fnmBdBJrwCxI5UzU+5RyPOGwmLWEV21mjHGPMciYtXegviDqwZfnhFaxjnZW
         IbIQ==
X-Gm-Message-State: AOJu0YwK0UZMqpVJQe3gC1HGospu8HdyxaPy8ZfcYeY6VYQz/b8lmWA3
	RoSrkW9RZY2J5K5pu2Vc2JTHsG4wMqQ=
X-Google-Smtp-Source: AGHT+IH3sS8lPbOEdOXI+VqeOhL5PpA/EpSbZBCVACtB4IqRlq34sNY2gOsrZy+KbE26cB/plp09Cg==
X-Received: by 2002:a17:907:d409:b0:994:555a:e49f with SMTP id vi9-20020a170907d40900b00994555ae49fmr886188ejc.31.1700271259491;
        Fri, 17 Nov 2023 17:34:19 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id v27-20020a170906489b00b009d2eb40ff9dsm1359284ejq.33.2023.11.17.17.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 17:34:19 -0800 (PST)
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
Subject: [PATCH bpf v2 11/11] selftests/bpf: check if max number of bpf_loop iterations is tracked
Date: Sat, 18 Nov 2023 03:33:55 +0200
Message-ID: <20231118013355.7943-12-eddyz87@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231118013355.7943-1-eddyz87@gmail.com>
References: <20231118013355.7943-1-eddyz87@gmail.com>
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
 .../bpf/progs/verifier_iterating_callbacks.c  | 83 +++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
index 598c1e984b26..fe0ce06de55f 100644
--- a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
+++ b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
@@ -164,4 +164,87 @@ int unsafe_find_vma(void *unused)
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
+SEC("?raw_tp")
+__success __log_level(2)
+/* Check that path visiting every callback function once had been
+ * reached by verifier. Variable 'i' below (stored as r2) serves
+ * as a flag, with each decimal digit corresponding to a callback
+ * visit marker.
+ */
+__msg("(73) *(u8 *)(r1 +0) = r2          ; R1_w=map_value(off=0,ks=4,vs=2,imm=0) R2_w=111111")
+int bpf_loop_iter_limit_nested(void *unused)
+{
+	struct num_context ctx1 = { .i = 0 };
+	struct num_context ctx2 = { .i = 0 };
+	/* Set registers for 'i' and 'p' to get guaranteed asm
+	 * instruction shape for __msg matching.
+	 */
+	register unsigned i asm("r2");
+	register __u8 *p asm("r1");
+	unsigned a, b;
+
+	bpf_loop(1, iter_limit_level1_cb, &ctx1, 0);
+	bpf_loop(1, iter_limit_level1_cb, &ctx2, 0);
+	a = ctx1.i;
+	b = ctx2.i;
+	i = a * 1000 + b;
+	/* Force 'ctx1.i' and 'ctx2.i' precise. */
+	p = &choice_arr[(a % 2 + b % 2) % 2];
+	/* Make sure that verifier does not visit 'impossible' states:
+	 * enumerate all possible callback visit masks.
+	 */
+	if (a != 0 && a != 1 && a != 11 && a != 101 && a != 111 &&
+	    b != 0 && b != 1 && b != 11 && b != 101 && b != 111)
+		asm volatile ("r0 /= 0;" ::: "r0");
+	/* Instruction for match in __msg spec. */
+	asm volatile ("*(u8 *)(r1 + 0) = r2;" :: "r"(p), "r"(i) : "memory");
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.42.1


