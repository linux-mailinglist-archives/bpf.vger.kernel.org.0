Return-Path: <bpf+bounces-55648-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F018EA840E3
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 12:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEF67463128
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 10:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A264326B0BC;
	Thu, 10 Apr 2025 10:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RD/v87b9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37862673B7
	for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 10:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744281495; cv=none; b=s5TF1hw5Zjuo2CkQRjbuR7TrepVkWAY58CzwXWdqIDtwqqwW85t8fCXYfwRONOgwbomI364VCIbA0cXwpVtwWgCYjueCFZRHtCTYR6r9R2zrTuzXyej1PTQD2psjhhv0F7Yd/dTqo5d02LZFH/x7KtiLHujANl4lcMXo2ze+bEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744281495; c=relaxed/simple;
	bh=pZWBMvR/UFILLjbu4qIv3LDSHgOJn6gfhjVLqpfKnBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ARcYb4/UluWKIVXh3/7moKHbDEpv+AczJULq9hKC2uY5oMpVR2RxbSaRmcit0UNDSxUCVGuPaHYL2qy6HmBRzqXRp/B65TNhi8gpMNJ4J6O9UX1E69QRxgBYwvV65jxQnxkY5i1UwlSMDF3za77SRImUiwUsOQOJB3+yh2Ng+L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RD/v87b9; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7394945d37eso477952b3a.3
        for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 03:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744281493; x=1744886293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Woez80DgfEpwU/Y390HNcgu/zAIdN4bi9qui6fLBmW4=;
        b=RD/v87b94OJpVe+SKBd+6avVpr81UQrj6OXxM7ZGX+KInPgtt72vVeIAfQ0Fbdtrg7
         9tMeRFKJ9CCbXxeLxCkYUb06jhlSqDf/LHgV1+3/QI0wlk3sBj9PeKGSfTI3ogkYXyJA
         txdVz46Zse9hirDhCMs6TqgFltmnHBeA98VU2mJHCPjTqbRRG4WTyn9vQfWHfKjcqSZU
         3097BxNiDggUuCQo4+JpsJGF3dulePXJJX3wh6hE8iW7v1pgFFZ92SGlqnKf49WYxrJK
         PNA4hxNP0oaFs0yAwksTlzH02a00ojpoCEgfvcJTbPuTSsJWQhUWTowa5mvERx4C43HM
         QMxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744281493; x=1744886293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Woez80DgfEpwU/Y390HNcgu/zAIdN4bi9qui6fLBmW4=;
        b=sXBmhmCa5gG5+gxgdxFNkwMUXuklc28B47VgMU+tt7K7bHm3RgSlNO/ZxaB20u74az
         IFgmJG0PGJ3zfnqb9/71Gij/qx874Ti/YKOHPQm+TEGwviPyvbOYTQejqFrZKFwYlTce
         Ahe7T5wH52ZjH+drZOqmqbbPCI2YUq2sEbHpna1EJT69YxSp5Hu/x0B68uAjUeLne0GU
         IAPYeA+WO0lqQAi+zILeHHuVcQIYEPqr+Ds5N0aB3C/6b7FJ5CO+chau5Wy2VzbuCbAB
         GoFQZteXZPG+PSI5uoZuClT2GAHnipFyCp8zreTJ4p2+/xqNZMBc6hZYpjt9gelTKXxp
         KQZg==
X-Gm-Message-State: AOJu0Yx2ZmvHfn9CX5pnF1MYa1kolaOGPxnBkMgxkYUz3gTCMRIUNt+F
	PiE2zxIXe+EPay3KhAT3Kr69UZoVHfbqHLOssOcDwMrSyAge4Jh8LTPJe7hvck0=
X-Gm-Gg: ASbGncu/exotoP26RB3pCR19+ZWuL8ziy3Jh+3CrQNDESjQb4DbdgCs9dn3UGy/68+z
	YMfksvW543nbNwH4y4xZq9/85VS1i7YvB/7byKlatXb/DpIUBEDlQzG1Tbv2mGe6XS5hDXSII/d
	mN+RAg+9/ApAUER6D5KdCDFTdvlqlDy2Sk7gqStKkv5grtdSdlg2Vj965cOFSU8UDOEZhCKdIf8
	gi0Ufr5EhWmnxHDZwEI79n7tgwl0jZw6wg1lv9gldSb0bfREoyt4VqYNFv8JnHhqSoCiApRuptP
	x23yNKgYbNTvLpkxwwWojWzEDuV1nDNccLFFg4aatn2yhz7Zt4Z1wU81YO9v9moLbt0TChKBsbt
	GAmIjo2icQlTB
X-Google-Smtp-Source: AGHT+IFyjvRmJ0zOndvPsHMswYkbdSCQQL2itQWzY0d4sW4g+b+8k/e/GkLVVEH9M7KehfbA2+xk0w==
X-Received: by 2002:a05:6a00:ac8:b0:736:7960:981f with SMTP id d2e1a72fcca58-73bbee433e9mr3964979b3a.8.1744281492598;
        Thu, 10 Apr 2025 03:38:12 -0700 (PDT)
Received: from malayaVM.mrout-thinkpadp16vgen1.punetw6.csb ([103.133.229.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bb1d2b3e3sm3003324b3a.10.2025.04.10.03.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 03:38:11 -0700 (PDT)
From: Malaya Kumar Rout <malayarout91@gmail.com>
To: andrii.nakryiko@gmail.com,
	alexei.starovoitov@gmail.com
Cc: bpf@vger.kernel.org,
	Malaya Kumar Rout <malayarout91@gmail.com>
Subject: RE:[PATCH RESEND bpf-next v3] selftests/bpf: close the file descriptor to avoid resource leaks
Date: Thu, 10 Apr 2025 16:08:04 +0530
Message-ID: <20250410103804.49250-1-malayarout91@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAADnVQJbBOK25Fx3zEG-ZH=zTFRfPNQye673b5TnpdTdMEXAUA@mail.gmail.com>
References: <CAADnVQJbBOK25Fx3zEG-ZH=zTFRfPNQye673b5TnpdTdMEXAUA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Static analysis found an issue in bench_htab_mem.c

cppcheck output before this patch:
tools/testing/selftests/bpf/benchs/bench_htab_mem.c:284:3: error: Resource leak: fd [resourceLeak]
tools/testing/selftests/bpf/prog_tests/sk_assign.c:41:3: error: Resource leak: tc [resourceLeak]

cppcheck output after this patch:
No resource leaks found

Fix the issue by closing the file descriptors fd and tc.

Signed-off-by: Malaya Kumar Rout <malayarout91@gmail.com>
---
 tools/testing/selftests/bpf/benchs/bench_htab_mem.c | 3 +--
 tools/testing/selftests/bpf/prog_tests/sk_assign.c  | 4 +++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/benchs/bench_htab_mem.c b/tools/testing/selftests/bpf/benchs/bench_htab_mem.c
index 926ee822143e..297e32390cd1 100644
--- a/tools/testing/selftests/bpf/benchs/bench_htab_mem.c
+++ b/tools/testing/selftests/bpf/benchs/bench_htab_mem.c
@@ -279,6 +279,7 @@ static void htab_mem_read_mem_cgrp_file(const char *name, unsigned long *value)
 	}
 
 	got = read(fd, buf, sizeof(buf) - 1);
+	close(fd);
 	if (got <= 0) {
 		*value = 0;
 		return;
@@ -286,8 +287,6 @@ static void htab_mem_read_mem_cgrp_file(const char *name, unsigned long *value)
 	buf[got] = 0;
 
 	*value = strtoull(buf, NULL, 0);
-
-	close(fd);
 }
 
 static void htab_mem_measure(struct bench_res *res)
diff --git a/tools/testing/selftests/bpf/prog_tests/sk_assign.c b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
index 0b9bd1d6f7cc..10a0ab954b8a 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_assign.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
@@ -37,8 +37,10 @@ configure_stack(void)
 	tc = popen("tc -V", "r");
 	if (CHECK_FAIL(!tc))
 		return false;
-	if (CHECK_FAIL(!fgets(tc_version, sizeof(tc_version), tc)))
+	if (CHECK_FAIL(!fgets(tc_version, sizeof(tc_version), tc))) {
+		pclose(tc);
 		return false;
+	}
 	if (strstr(tc_version, ", libbpf "))
 		prog = "test_sk_assign_libbpf.bpf.o";
 	else
-- 
2.43.0


