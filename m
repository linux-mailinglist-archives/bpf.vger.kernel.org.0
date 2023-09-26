Return-Path: <bpf+bounces-10894-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E24327AF519
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 22:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 05A2B1C209DC
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 20:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CF64A548;
	Tue, 26 Sep 2023 20:28:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891E84A531;
	Tue, 26 Sep 2023 20:28:12 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6BD0136;
	Tue, 26 Sep 2023 13:28:10 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9ae7383b7ecso1843867766b.0;
        Tue, 26 Sep 2023 13:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695760089; x=1696364889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y14cfr9X7ZfqN6REntNnZLiNj9fIlAHdGv7Az327RZ4=;
        b=THPiNnioygpgfFzBpZiyZfKHfaB3TRT6GgoSkSct/KffbZhvpoS7IbmaJoi9jduP3R
         a/t7QeatiSU+RKPKkqLqWfW7pqYI4DWpUAxziFGQwkhGXUXUeB79OIiHMGFPCJ2EL5va
         ZJ/cOp/TOO32t40nRW26k+lTNE1qcoNBJjLS5kQPdYY3GITnGBeKHjyibXvH7NvTFuDN
         we0ixG9BuAxXDJuxoRd/dapuSsaGl9WAFP2UvOSrs54cn5hoWw3zV7ZhwBjPWAEIN03v
         6iqnL1okq6E4+C8VCGAoo4R9+DWHlzesRHcVXmKZUadQeFydtgsV2k3MI3ZtOLZ+1Adm
         uxUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695760089; x=1696364889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y14cfr9X7ZfqN6REntNnZLiNj9fIlAHdGv7Az327RZ4=;
        b=wAW7dECSZUajm2iGX7vbaidukwvfow6mZPzQhCRLtWucgxQ1N9WNProe0zFhP1DyzB
         adWgW5ZCbdrYjAKTJj5xRDhwFtL4cl8XToDu5Qc5pMlgLXUgl4v11qAGhD9TdClokJUd
         gJb4itiryGFiEdle3ainC+NZiEln6xXa+TpNxJroLgeSmuuFiODPyMbZAaNg+yh6VP9m
         tkUhwpD8TWnpStqLs/LTvQFxWBHB1VyOA59cdTeIIg3UzwdMjNRyqvyWhRXyUddM7Ypk
         CFIvWItdAHh328Pf9/n2DJcJjI6SbKksCLTZ0dQ9xky2WTUAC3onLJFb4eSezltsKkWe
         Pjxg==
X-Gm-Message-State: AOJu0YzBEEYsRlB9bGTXLMySiHdxD2YtLSryLWyeyRjYQwOt/OnJ/Ndd
	7twf8do4lYdF+e9/ciIZL/oLNoUwH2fNNav1
X-Google-Smtp-Source: AGHT+IG4cFTTPll+MPCv6DQiSLQO93QeT75ofMt8IZdnSnFxYEyYC8ZlEWptTvTGlJivFE7K9aNCKw==
X-Received: by 2002:a17:907:c1e:b0:9a5:794f:f3c5 with SMTP id ga30-20020a1709070c1e00b009a5794ff3c5mr5974738ejc.6.1695760088608;
        Tue, 26 Sep 2023 13:28:08 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:864b:8201:e534:34f4:1c34:8de7])
        by smtp.googlemail.com with ESMTPSA id c19-20020a170906529300b00992e94bcfabsm8204664ejm.167.2023.09.26.13.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 13:28:08 -0700 (PDT)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
To: bpf@vger.kernel.org
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v6 1/9] selftests/bpf: Add missing section name tests for getpeername/getsockname
Date: Tue, 26 Sep 2023 22:27:40 +0200
Message-ID: <20230926202753.1482200-2-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230926202753.1482200-1-daan.j.demeyer@gmail.com>
References: <20230926202753.1482200-1-daan.j.demeyer@gmail.com>
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


