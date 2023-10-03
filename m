Return-Path: <bpf+bounces-11257-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 993697B657F
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 11:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 42232281BD0
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 09:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D991FC10;
	Tue,  3 Oct 2023 09:30:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92504DF61;
	Tue,  3 Oct 2023 09:30:43 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E7BB7;
	Tue,  3 Oct 2023 02:30:41 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9ad8d47ef2fso115430766b.1;
        Tue, 03 Oct 2023 02:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696325439; x=1696930239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y14cfr9X7ZfqN6REntNnZLiNj9fIlAHdGv7Az327RZ4=;
        b=WuBMQS4+Y5Mm4l8GF+QG75mSUU3NL3tImYhuI2V5i0+Pt3wzb9vwwg0Ov5dKQDH6eA
         r29ZNUQHnmGpolbvb5nqRQ1jaSiZLaIOpd0wZH8R1vqDnIxIqLiaJemt1R9WXIRXKmi5
         z7tH/hmb9PoNl9z9SNYMzUvhCsAzr51UmiUHQKpL1TH/GZgEhrqXvJVLyuXp1BDiAkGx
         hFxkH1/j4YZlP8nVvrcY42o8mO+TVl92tXQmdAJCMCZqL+iqVZBu/ZWiytBeLrVmL5UZ
         DCragqvbnV5wfGi4GlBl83okRxaTvE+qwaGLM2SS58PGMt7mlmD31SMXlATEO/qvFXzG
         nEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696325439; x=1696930239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y14cfr9X7ZfqN6REntNnZLiNj9fIlAHdGv7Az327RZ4=;
        b=HPBw8xpwH+1EmiMicHeFZju2F3qPPdT8wle4nsCYY8h5NFpdUXjVuBNGEmQgeMIut+
         MDYCJezH466mnasJ0F9wIzWoxZZHOLMwyqjIBOmyildfy5Rfi89RrR1h6vZIpbnTDou7
         sziv3nA38HEJ6tivK7jkBtNj6xVUy2U4tA1IwNaxiWQi/lNz9Pcb7gy1BdMez7DLdaRq
         TiazO4qxcx3NjID2tz6VFK0vf2oRpyBU72HhRVS86V4c4E50QDYI1q3TCW776w3Uh7mK
         b4wLb1STbm3mM4aqFy48oA93id/CF6m7SqLaY1YP2xTJ+iODblkL3BovQagYw4aZZ4kp
         2N8A==
X-Gm-Message-State: AOJu0Ywl2cssOI9E4D2bxizmua0qZtaFaBdB486bXjMc9x1gsIESnsgQ
	XTWJ0dAGH8MpuoWU5xJUvMQzudE9S66bfSOJ
X-Google-Smtp-Source: AGHT+IEA1rl3zxb7SBSMtyzV+M7kTOfmZz3FCz83DHE+gXN6OSWCGzoGLcdkhLjzuX92pmVOjpfxWg==
X-Received: by 2002:a17:906:3196:b0:9ae:52fb:2202 with SMTP id 22-20020a170906319600b009ae52fb2202mr13249261ejy.40.1696325438898;
        Tue, 03 Oct 2023 02:30:38 -0700 (PDT)
Received: from daandemeyer-fedora-PC1EV17T.thefacebook.com (2001-1c05-3310-3500-15f4-3ba0-176b-cb00.cable.dynamic.v6.ziggo.nl. [2001:1c05:3310:3500:15f4:3ba0:176b:cb00])
        by smtp.googlemail.com with ESMTPSA id g5-20020a170906594500b0098f33157e7dsm749851ejr.82.2023.10.03.02.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 02:30:38 -0700 (PDT)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
To: bpf@vger.kernel.org
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v7 1/9] selftests/bpf: Add missing section name tests for getpeername/getsockname
Date: Tue,  3 Oct 2023 11:30:15 +0200
Message-ID: <20231003093025.475450-2-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003093025.475450-1-daan.j.demeyer@gmail.com>
References: <20231003093025.475450-1-daan.j.demeyer@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

These were missed when these hooks were first added so add them now
instead to make sure every sockaddr hook has a matching section name
test.

Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
---
 .../selftests/bpf/prog_tests/section_names.c  | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/section_names.c b/tools/testing/selftests/bpf/prog_tests/section_names.c
index 8b571890c57e..fc5248e94a01 100644
--- a/tools/testing/selftests/bpf/prog_tests/section_names.c
+++ b/tools/testing/selftests/bpf/prog_tests/section_names.c
@@ -158,6 +158,26 @@ static struct sec_name_test tests[] = {
 		{0, BPF_PROG_TYPE_CGROUP_SOCKOPT, BPF_CGROUP_SETSOCKOPT},
 		{0, BPF_CGROUP_SETSOCKOPT},
 	},
+	{
+		"cgroup/getpeername4",
+		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_INET4_GETPEERNAME},
+		{0, BPF_CGROUP_INET4_GETPEERNAME},
+	},
+	{
+		"cgroup/getpeername6",
+		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_INET6_GETPEERNAME},
+		{0, BPF_CGROUP_INET6_GETPEERNAME},
+	},
+	{
+		"cgroup/getsockname4",
+		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_INET4_GETSOCKNAME},
+		{0, BPF_CGROUP_INET4_GETSOCKNAME},
+	},
+	{
+		"cgroup/getsockname6",
+		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_INET6_GETSOCKNAME},
+		{0, BPF_CGROUP_INET6_GETSOCKNAME},
+	},
 };
 
 static void test_prog_type_by_name(const struct sec_name_test *test)
-- 
2.41.0


