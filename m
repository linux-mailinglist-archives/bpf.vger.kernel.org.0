Return-Path: <bpf+bounces-11933-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5317C59DA
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 19:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B00AF282658
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 17:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9387D3E499;
	Wed, 11 Oct 2023 17:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTwTsXV5"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93994315BA;
	Wed, 11 Oct 2023 17:03:35 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E74A98;
	Wed, 11 Oct 2023 10:03:33 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-32d81864e3fso17966f8f.2;
        Wed, 11 Oct 2023 10:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697043811; x=1697648611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y14cfr9X7ZfqN6REntNnZLiNj9fIlAHdGv7Az327RZ4=;
        b=YTwTsXV5ghbHW9r5GGiJJiHto/7TCaShDZRTUR66yoPh9djrPwJYVxTVP5bBnmOsyt
         gqiNNAwQJqn/ajo585hKZmym9IEzTamUlBfG4Nm5lE9/RRL5hA6hlbs3L4pKaqfRM5Ta
         T3TJf7TNypKMKs7+gajPR9HjkflhsOnoJRNsRsk2MGw+SLg5BfoWpquJkcvl4hOm6GYc
         j8yf8nQZOH5b61pnw9omP4WigR8Y8SEvqshccN7JYgDwO82aKajjDk3qepBeUrgI1q0w
         1R2lT4Q0nASCr4pGN8FC2fr0e/fL4Kf6TS8/TBjzsAV8PVxB7bORtfZyBaYGXb7Lva2X
         6dKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697043811; x=1697648611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y14cfr9X7ZfqN6REntNnZLiNj9fIlAHdGv7Az327RZ4=;
        b=w1tBmswde2oFxZKqRqgrJINF7HAGf72LCuvsLQhPb6DwIgvFlTLW3eBrBvpLMeTRNi
         znuFn+CdVQyFgUIvGeTRRrnmUwOiau0cDXLEyZQplNdMZF2/eFcrzHaa1qwyqLuGE/nv
         9DUQJQBRkGnAQGHpMyYhexFV1Flt02lWMtsV3+7r4b2ONcNoXpaegL4Fbt9EYb1mJmp6
         fY5Hl41PEZFKPXe/9QwtX55QCFNRwQvJj9qIM3x9wIHEplTc9sFMwZ819xJjdxuyZvlP
         FpGGnX6DcXYlve6zWa6Abk4Hu8S1TDw0zYMC31z/iYFgK/c4uoFwnIsUvplM+TEJLK59
         UbGg==
X-Gm-Message-State: AOJu0Yzc9NMwvuttHo6Puo6uVO47HDv5+VqPGZSv9VG7DWcY5yhW6dqc
	ErnxZusSZ5P59LMCbdBrkWNICb4AHqkKH4rU
X-Google-Smtp-Source: AGHT+IFahw96QrCSj3iwIPfvK1hggG1PM7WhvHs4agyp21YTXMEOiEBvqE3DOXQ/46mMiuLVwtYmlw==
X-Received: by 2002:a05:6000:24d:b0:32d:8246:5c66 with SMTP id m13-20020a056000024d00b0032d82465c66mr2572465wrz.18.1697043811311;
        Wed, 11 Oct 2023 10:03:31 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:864b:8201:e534:34f4:1c34:8de7])
        by smtp.googlemail.com with ESMTPSA id h28-20020adfa4dc000000b003296b913bbesm2335480wrb.12.2023.10.11.10.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 10:03:30 -0700 (PDT)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
To: bpf@vger.kernel.org
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v10 1/9] selftests/bpf: Add missing section name tests for getpeername/getsockname
Date: Wed, 11 Oct 2023 19:03:10 +0200
Message-ID: <20231011170321.73950-2-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231011170321.73950-1-daan.j.demeyer@gmail.com>
References: <20231011170321.73950-1-daan.j.demeyer@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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


