Return-Path: <bpf+bounces-8898-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1885D78C236
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 12:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E61A1C209AE
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 10:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BD814F91;
	Tue, 29 Aug 2023 10:19:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6784714F82
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 10:19:23 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D71619A
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 03:19:15 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-52a069edca6so5872953a12.3
        for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 03:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693304354; x=1693909154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y14cfr9X7ZfqN6REntNnZLiNj9fIlAHdGv7Az327RZ4=;
        b=MCC1LSvpudwllF1svJbmhHDXgNBFX15mSQ8TPH/qrtqmlYu0pTYTq0YgChXRb4D+CJ
         D5zd7ZXGAMwkYFnSP8HsjRFbh8SC8Z9gZ8IwENHgq5RcohmL2UdR1Btyb0IfaX5C8jnb
         JY14//E55NyhFv3JhATDeHnL19maOzOc/bsY2UrldfYwKW2PQ7LP8tlsKrs4rlLdyxY5
         RZxu6EY18w504WNgP9JSC/CLgIu5O63xSBWnLlFpt1T84tjO/aQyHgu848ifad/1qPdA
         SbYGW5ECwXiUHuI0ldJoWmZneZugb238RWO7FsM+zzgA53eGsGAcZ8etrs8h/hoxoGt5
         W4VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693304354; x=1693909154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y14cfr9X7ZfqN6REntNnZLiNj9fIlAHdGv7Az327RZ4=;
        b=ODEqomElPhXe0I+moUTYBks09oo6vzdJ2NQkXh6jZ7FslnPb85uzAzUMWtyibaUKPl
         QI5Qe7VeuEkF82KUOXxKFu6oiavLIOJoMdosNpo/5K1Ui1ODMlZygYCYb5esTT8CE2R/
         ML+ff4cj4O6tY08PXOltLbEy4ZRhJdXbHhcI/t5bAx7wUX1HgQZyfF16jis1CVIrJGV7
         oQ/Sk42JoaVEEMmRTRHUM//c15MlGRNjUitADiVEAelfMYttYdrJcJiYmj5UAtDLVGWK
         Owun9z+nKMrEyQdw8sFpjr290QkM3LnkuoyIj345U2x7zDQSJ7dBMRrRotrKp77At9kb
         Emzw==
X-Gm-Message-State: AOJu0YxBENJnkxCihJIlDzIwzerko2gvt00ncpA4lPE3Y3KPFcw+QS1j
	twbTnfNP0kS4FdNcVDK13i95/TRhNqLHGdag55E=
X-Google-Smtp-Source: AGHT+IF2hv4PlyQ88alZkZovIA5SeosJBV949to+4DT3WEkSBUlN41NhVgri9kGGAnzDFJb2oGfXEg==
X-Received: by 2002:aa7:d058:0:b0:523:406a:5f6 with SMTP id n24-20020aa7d058000000b00523406a05f6mr21492859edo.12.1693304353706;
        Tue, 29 Aug 2023 03:19:13 -0700 (PDT)
Received: from daandemeyer-fedora-PC1EV17T.thefacebook.com (2001-1c05-3310-3500-67a4-023c-67c4-b186.cable.dynamic.v6.ziggo.nl. [2001:1c05:3310:3500:67a4:23c:67c4:b186])
        by smtp.googlemail.com with ESMTPSA id f15-20020a50ee8f000000b0051e2670d599sm5545606edr.4.2023.08.29.03.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 03:19:13 -0700 (PDT)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
To: bpf@vger.kernel.org
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>,
	martin.lau@linux.dev,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 1/9] selftests/bpf: Add missing section name tests for getpeername/getsockname
Date: Tue, 29 Aug 2023 12:18:25 +0200
Message-ID: <20230829101838.851350-2-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230829101838.851350-1-daan.j.demeyer@gmail.com>
References: <20230829101838.851350-1-daan.j.demeyer@gmail.com>
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


