Return-Path: <bpf+bounces-15148-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 042D07ED93D
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 03:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFAB8280F54
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 02:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA868F74;
	Thu, 16 Nov 2023 02:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YURxgT+B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063BCA6
	for <bpf@vger.kernel.org>; Wed, 15 Nov 2023 18:18:47 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9d267605ceeso40230866b.2
        for <bpf@vger.kernel.org>; Wed, 15 Nov 2023 18:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700101125; x=1700705925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fE7HVCtp7LqjDVUWaVlJ2gXiaM3EpDCNv9IEbE1iFL4=;
        b=YURxgT+BFZqRGEV+Hrv/wGRC62gC2eYZZKSakmoBCx62LcMCsRQoQxuGBOlTJTECFf
         AlT2daRbtmetWMXv/YQmO3F1VBmvTniPJLaRhDk6fOK0b1b18tpdVdMeg+4RmrgY+ht8
         vzuIW3hScDrfG1eVibijsgak8kN7TDW/uEILIGr3p65oT/qR2PwJ92arfwoKl8kOvVX+
         IvZfku3rScn6URqHzStSlc3MJVMrxxslaTCIBqEt9sl6ZwGAq92wVAnVd4sO4WDsheJP
         rO7qirNQevnyFym7MuVoxjZNRJmQg3nCT2QxbaeY+Djat0n2bBzM7gY/QNzJT6ADmbbQ
         9izw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700101125; x=1700705925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fE7HVCtp7LqjDVUWaVlJ2gXiaM3EpDCNv9IEbE1iFL4=;
        b=Yj+NUIpiH5P9S8jf1TPDeyKwdwh9/jRFpos3owqNDjCPWBuie+DBpvIbQCSVQxHrIX
         R1Tt/om57lQC4EwUe7iZ9xmmlwZlP2bxFIECgbLqRTuHOsfD2MZu7qwyMkKRY9u0Vj+D
         dc7QBmxDSZP+FAP1tTdxj/5W09/9jayid/hhfCdAEYXnEfg4H9ZaoHQy6R8KQLVbna+N
         9jRfPUC2MAJeQsUodSVbGyOCkF0Np6n+g3imygNhkV2mXYiw9V03lz10glf6X5M8YNvq
         0uifA1lYlGkQw9Q/qsfCIdjtG1v/WXDrEAjskTQeGAb7ABsmuKRyrpTvi98rtpirB7dg
         g4Pw==
X-Gm-Message-State: AOJu0YxC6DN4P1PByfPbf0v7SiU13NtrkFxywPijjCwlxmkYsaomdBVe
	d1M5MgRwXvOkRK3QZz42IuStLjak4B6cyw==
X-Google-Smtp-Source: AGHT+IFDSi3utF8UEi+l2s2AmLsZMylBZaMAcvn5Aek60Zk1T+J4uPZRdALvHkzMNFoFunodG8GKFQ==
X-Received: by 2002:a17:906:16c2:b0:9be:d55a:81c3 with SMTP id t2-20020a17090616c200b009bed55a81c3mr10734427ejd.67.1700101125117;
        Wed, 15 Nov 2023 18:18:45 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id ay1-20020a170906d28100b009dd606ce80fsm7774064ejb.31.2023.11.15.18.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 18:18:44 -0800 (PST)
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
Subject: [PATCH bpf 12/12] selftests/bpf: check if max number of bpf_loop iterations is tracked
Date: Thu, 16 Nov 2023 04:18:03 +0200
Message-ID: <20231116021803.9982-13-eddyz87@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231116021803.9982-1-eddyz87@gmail.com>
References: <20231116021803.9982-1-eddyz87@gmail.com>
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
 .../bpf/progs/verifier_iterating_callbacks.c  | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
index 598c1e984b26..da10ce57da5e 100644
--- a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
+++ b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
@@ -164,4 +164,71 @@ int unsafe_find_vma(void *unused)
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
+/* Check that last verified exit from the program visited each
+ * callback expected number of times: one visit per callback for each
+ * top level bpf_loop call.
+ */
+__msg("r1 = *(u64 *)(r10 -16)       ; R1_w=111111 R10=fp0 fp-16=111111")
+/* Ensure that read above is the last one by checking that there are
+ * no more reads for ctx.i.
+ */
+__not_msg("r1 = *(u64 *)(r10 -16)	; R1_w=")
+int bpf_loop_iter_limit_nested(void *unused)
+{
+	struct num_context ctx = { .i = 0 };
+
+	bpf_loop(1, iter_limit_level1_cb, &ctx, 0);
+	ctx.i *= 1000;
+	bpf_loop(1, iter_limit_level1_cb, &ctx, 0);
+	return choice_arr[ctx.i % 2];
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.42.0


