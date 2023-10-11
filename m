Return-Path: <bpf+bounces-11948-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F126E7C5CFA
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 20:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D8931C21040
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 18:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A329528DC6;
	Wed, 11 Oct 2023 18:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFRZj5ub"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D63C1D54E;
	Wed, 11 Oct 2023 18:51:29 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5B794;
	Wed, 11 Oct 2023 11:51:27 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40675f06f1fso8513915e9.1;
        Wed, 11 Oct 2023 11:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697050285; x=1697655085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y14cfr9X7ZfqN6REntNnZLiNj9fIlAHdGv7Az327RZ4=;
        b=gFRZj5ubFH9UsJ1srM7nWVaOiQ2wvrAwFZitfW+Uvwn3+mdxE1wuDIoO7qjFc2Zw0L
         ppU2FnvECGdCHkY5sHin6dYrS0I8+XRlmydtus+U+BX2Ab+P6d+yh7xrk2tFonK7l9U8
         J4Wl7W5mHnfHh3fL0WhYjLGOlHWqO6EqhDY32S/M/ODdy0vd9uDmkFg23p4XG/UhPuwr
         kb3+f4GWCtOuonMeJcQLxSBvbFmV1GEya8dmMoVwKWbXc8r4omYRn2q920frlCzzVHWe
         iIT36YakJHANg2SRvF18u6yo3pUWY4XY7s1vrrzRoPztdH2Ufi548coDGvIslw7YndgL
         c4KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697050285; x=1697655085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y14cfr9X7ZfqN6REntNnZLiNj9fIlAHdGv7Az327RZ4=;
        b=ricmeaU4vcEdDW0o31d8GaFEc0sbPHgXAoNgiIamKQUGZQ8hd0IOKxBaPdKruqpHuf
         SohNXQ5BKnt7vbNiG/ujIZw+g7NgKz4d18X+k4ReyPnIj7UnHHGhMxGpXN1GVNeUP2V6
         Zd/cGD8mYPxrD2xaJX6RH+5nNrKXBefHQ4n/AzuG/i74XxnHFqV16oGLgONY6WKoG6zV
         kNHTSFbaLo+jB50sz3qELw/1xZkC3r05x3NcdV/kpWIKOb4bBFyz4kWoPbViZ6JAQsBR
         kNHtMRxxTVQjOv0tUrnj8VI8rgAE3XkuZgKeU7pIDR5AzZPfAiFPsxPf/9Nf/7FM26B5
         W9Kw==
X-Gm-Message-State: AOJu0YyyBWiw+RO9VIL7ldQ/pbeXLtt2yNtTB3EILlhO0jW7XOzHaCau
	FPjHpkMvsA5C+9G+dj3Dv5rZCcq1Gq00dFA9
X-Google-Smtp-Source: AGHT+IHAsXeroYS5GJPNz9VDkBpKlgTsNR/ByTRpsZqlWhJ2RzjKuIVEBYC7zo9DjsWKe7c2dSzHPA==
X-Received: by 2002:a5d:5c07:0:b0:31f:d50e:a14f with SMTP id cc7-20020a5d5c07000000b0031fd50ea14fmr21524868wrb.10.1697050285696;
        Wed, 11 Oct 2023 11:51:25 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:864b:8201:e534:34f4:1c34:8de7])
        by smtp.googlemail.com with ESMTPSA id h9-20020a5d6889000000b0031c52e81490sm16424484wru.72.2023.10.11.11.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 11:51:25 -0700 (PDT)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
To: bpf@vger.kernel.org
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v11 1/9] selftests/bpf: Add missing section name tests for getpeername/getsockname
Date: Wed, 11 Oct 2023 20:51:03 +0200
Message-ID: <20231011185113.140426-2-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231011185113.140426-1-daan.j.demeyer@gmail.com>
References: <20231011185113.140426-1-daan.j.demeyer@gmail.com>
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


