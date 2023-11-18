Return-Path: <bpf+bounces-15288-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6048D7EFCFA
	for <lists+bpf@lfdr.de>; Sat, 18 Nov 2023 02:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 923A01C20B0E
	for <lists+bpf@lfdr.de>; Sat, 18 Nov 2023 01:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888C3110F;
	Sat, 18 Nov 2023 01:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="my5mdesl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1CA310C6
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 17:34:18 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9d0b4dfd60dso339017366b.1
        for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 17:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700271257; x=1700876057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VDHW3ADAkp5F/1MEfzINlWWS3hggbIBOqT1LI9K91KA=;
        b=my5mdeslXtiRpUXiDgwfjR/qjjP+y3Zgm5SG12DTOykhgFEyERaQoQ82PwSo23RWA+
         hfT7fqZjNd4skpcRFmbs9b7ih4pQWGbs3GeqTdPgWrLIVBw4mh5ktPupHjse11KfrZVb
         a3pvzpvjGP1jPkCtsi4qP2FJfG3JRtMzZB9pnA7O/Szv4kmqC6HykIp+INmP870MsFjE
         ft8K7uipC0cD2ZdPaza5DjBlqzXm/vpckIqnIBV2RL+nP7b84gZphV2ikn7iPg7wdmHK
         5LHhZwAvIKPDXSXnDhwBi1FP1GHuWoH/x/sNpKfYdoIsDxvTuvwhmv8cLVsg+MyX24ck
         uVYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700271257; x=1700876057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VDHW3ADAkp5F/1MEfzINlWWS3hggbIBOqT1LI9K91KA=;
        b=tcygcqEELTvQURdEu15SpuGqp11YGvN0BNq3Wper431obrb+ehC5CWKgh0JWmT5EJQ
         DeEOZSrIYFe3bjJQcWs6smuuV6C8xzmy07gLDnkhmKE/XWq/8QkE26Y//XH97PzfzqMV
         XdjQsFiE0KyJeGvoC7lZlvgAmJeqe3mSi3yTcCYHSbukeJGOTwtt6NJRoJqXdLvorYyI
         Srt/2RZ09HHktIffgDbTKitXqTTxb9r0bcRKxAdYAYynMZ1G3CEW3R5AjteIsSYGxHqg
         PQC+WiUCeyjYlIfIHJkXvOcxDcCag3wv8odylqUtLwv2Wwfr5mKsgA2EL7x2zKNvVeYL
         YdrA==
X-Gm-Message-State: AOJu0YxvflM171zr0EPVWN8mlFZtLOnu7YV2ypKoZOhU6XgC0ZXio3df
	F/QMC7k/Bty0QnsLDcd1KoZNYv/k+RA=
X-Google-Smtp-Source: AGHT+IEB6VMYUI8y2QO4ICPebTwQbxlNB2dIk/likhoLDVg9kWRp0Tjvm8wPNQstNy9P3hcrVAYCQA==
X-Received: by 2002:a17:907:3f19:b0:9d0:51d4:4d87 with SMTP id hq25-20020a1709073f1900b009d051d44d87mr991121ejc.62.1700271257119;
        Fri, 17 Nov 2023 17:34:17 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id v27-20020a170906489b00b009d2eb40ff9dsm1359284ejq.33.2023.11.17.17.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 17:34:16 -0800 (PST)
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
Subject: [PATCH bpf v2 09/11] selftests/bpf: test widening for iterating callbacks
Date: Sat, 18 Nov 2023 03:33:53 +0200
Message-ID: <20231118013355.7943-10-eddyz87@gmail.com>
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


