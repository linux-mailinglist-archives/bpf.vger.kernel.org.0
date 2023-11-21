Return-Path: <bpf+bounces-15490-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 961077F239D
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 03:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C771A1C218AA
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 02:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5C9134C7;
	Tue, 21 Nov 2023 02:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fybtherk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8928E7
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 18:07:38 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-a00191363c1so155455666b.0
        for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 18:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700532456; x=1701137256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VDHW3ADAkp5F/1MEfzINlWWS3hggbIBOqT1LI9K91KA=;
        b=fybtherkhRQQgoMK9nnTHfXZvuL50TvfnRAygd7ELaBZ1Yoj6MZvp+77JCWb5gLxNO
         U0p14EcGkc5v5gaNw/Dr60jIChgkS3JQnyQgXp3MwehekK6V7LQZPIoxnD2M8jMY1CB6
         sh6/8kP+T7LaMEpBf1hC5mwYztCfsQKf0bjQhRXHlWIpdpU739PWSI6lbsrLGRkVOWG6
         4iIFqP25wQH8XkjD5zF62xEaHZCRtKmv49NnIM8lo5RpePW3CxRg7CBlzrKyvMCuZcTX
         QH0IqF9J/f7sMgezMYqu962CTKD6tQZLNgoV/QvFOKBv2RiZfmUfLPK5gkyquU1ao1vX
         Lqfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700532456; x=1701137256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VDHW3ADAkp5F/1MEfzINlWWS3hggbIBOqT1LI9K91KA=;
        b=eA7xL/YBmMyngMM0oonGgaMC1MpmrCDRpQeObX3NkBxhfPV7elSZsrcQzJvFwEgmen
         TA1e3IQ8N//SRYbCREaQAsXvyUJ3zbo+nVXJ52IZ66MCzSrEYedDRmhu2v0g6NAiMJHz
         9Fk/z4l478o042CJZrnze9RTp4xES/j+U0SwK3GcCL9ZoZ7WCN+DvwquYmajOPwuM2EL
         Xq0WmTb0Iai8DSkZr/kh8JZxPXJ7QkwH8PbyO1qDeR0TohQnRdxeJRzA1Jsgs33fRbNU
         DLnJ8ZJ/iXJGEpkWTWTXzCFb/0XCN0x4liu54PK9nUnVQhK0PMP9AYIzGCkngHHRB8Qh
         Lmvg==
X-Gm-Message-State: AOJu0YygP3GS3gdaStnLuQBbVW8oRhJIqWG9RsRCPZqcCLr1gOwg0mrk
	/lLdvDhkDa+R+KOXVKweT9Aw/S6pbdhf0g==
X-Google-Smtp-Source: AGHT+IFDn44K5PBTp0tWAV1xT23L+OJs4wHTqABv5UVPKTxyoSu/bvssWT76rFyUjhxkCW1gE8bB+Q==
X-Received: by 2002:a17:906:25b:b0:a00:8b77:f621 with SMTP id 27-20020a170906025b00b00a008b77f621mr1708218ejl.22.1700532456450;
        Mon, 20 Nov 2023 18:07:36 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id ha7-20020a170906a88700b009fc990d9edbsm2426668ejb.192.2023.11.20.18.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 18:07:35 -0800 (PST)
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
Subject: [PATCH bpf v4 09/11] selftests/bpf: test widening for iterating callbacks
Date: Tue, 21 Nov 2023 04:06:59 +0200
Message-ID: <20231121020701.26440-10-eddyz87@gmail.com>
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


