Return-Path: <bpf+bounces-15447-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6427F2117
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 00:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 185941C20E5B
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 23:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202203B285;
	Mon, 20 Nov 2023 23:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCJADCNC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824F9CD
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 15:00:18 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a00c200782dso97837566b.1
        for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 15:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700521216; x=1701126016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VDHW3ADAkp5F/1MEfzINlWWS3hggbIBOqT1LI9K91KA=;
        b=XCJADCNCASRUfARDpSRvN0HYbuoW0vz93BsEis+f57oy2D4dX57O50y+WkYzuYtfXO
         y3ZA4cniHrozSonOvvuWgpNJgQLxUyTorey2c4JQ1zEBoe77aMq3dJJ0URVh5+fsIh7h
         EgoawpIDxYYa3ZSwBCWBcxHAPpYzUAqiz3PrIxKC2xFq1QlX/QoRDokik3M5H/a69MeR
         qz6yFddopgbxbmP/l/lycf9BxrElXQkYq99qTpcQeGfBDBoc+B8/Nk7oazVgsn4e+6BZ
         HACKFnrGF533zCJaD5ulkHc25Z6uXABFRpQUfxRQlbZbW6zJAiay00Ka2qcS+YPPx/yu
         bElw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700521216; x=1701126016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VDHW3ADAkp5F/1MEfzINlWWS3hggbIBOqT1LI9K91KA=;
        b=jIPzr7Y+RDgpQxTUxcvhreVKNaZYcJejVPWdun8JeoFRCk87HEjV5l8qela7E7mTIo
         g4swQA8mfufQs++TVg1jtAVgA5G0pGfNBlN5Lv1qfhdN/59WJMdmnFo5tzMr1rt60SJq
         bfS/9Tfz+GWatkHh6rjPGFoVCK23Hev3L/IQbDB4teCorLaQXcuwq2MYJMQdSwsvVC92
         2/P0M05TdZGRJk0vj0U0lhhvXVV0X43+hva7AYTl/Uiv+lZyd7j3ItuYkRxG7xryOmzD
         PhFFgKYJgEl+pIeBtQWlvvzqfgk28WQ9VyRJjSBeGU+W3JZN2XiO8mLeIyzespy86YWB
         Dc6Q==
X-Gm-Message-State: AOJu0YwX/0GLVIwSm4gMVSiekuot1nGDguEqockqdxfKSAvaSPW/n9Zz
	gWhHJf57jJmcemzNAl/hCRllJkV2i3mOGw==
X-Google-Smtp-Source: AGHT+IEvf9wTOrYYa54mzhSBn6cVzX29yQ+M+/KK8ZR2BrTIRdt4GTDi2PMHMiRX3lTSyLynX6OrLA==
X-Received: by 2002:a17:906:da:b0:9a2:225a:8d01 with SMTP id 26-20020a17090600da00b009a2225a8d01mr5730406eji.7.1700521216018;
        Mon, 20 Nov 2023 15:00:16 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id a9-20020a170906468900b009fd6a22c2e9sm1968039ejr.138.2023.11.20.15.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 15:00:15 -0800 (PST)
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
Subject: [PATCH bpf v3 09/11] selftests/bpf: test widening for iterating callbacks
Date: Tue, 21 Nov 2023 00:59:43 +0200
Message-ID: <20231120225945.11741-10-eddyz87@gmail.com>
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

A test case to verify that imprecise scalars widening is applied to
callback entering state, when callback call is simulated repeatedly.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../bpf/progs/verifier_iterating_callbacks.c  | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
index fa9429f77a81..598c1e984b26 100644
--- a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
+++ b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
@@ -25,6 +25,7 @@ struct buf_context {
 
 struct num_context {
 	__u64 i;
+	__u64 j;
 };
 
 __u8 choice_arr[2] = { 0, 1 };
@@ -69,6 +70,25 @@ int unsafe_on_zero_iter(void *unused)
 	return choice_arr[loop_ctx.i];
 }
 
+static int widening_cb(__u32 idx, struct num_context *ctx)
+{
+	++ctx->i;
+	return 0;
+}
+
+SEC("?raw_tp")
+__success
+int widening(void *unused)
+{
+	struct num_context loop_ctx = { .i = 0, .j = 1 };
+
+	bpf_loop(100, widening_cb, &loop_ctx, 0);
+	/* loop_ctx.j is not changed during callback iteration,
+	 * verifier should not apply widening to it.
+	 */
+	return choice_arr[loop_ctx.j];
+}
+
 static int loop_detection_cb(__u32 idx, struct num_context *ctx)
 {
 	for (;;) {}
-- 
2.42.1


