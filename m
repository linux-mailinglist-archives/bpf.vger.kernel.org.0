Return-Path: <bpf+bounces-70966-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC20BDC2FD
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 04:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E69134F266F
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 02:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455FF30C61C;
	Wed, 15 Oct 2025 02:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HozLeFDr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5D030C35C
	for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 02:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760496199; cv=none; b=HeCLOtxvtmXMMY/BbkKAEJzFhT/MKJhpgX8W5FpgML6ifYO/62JC4HdEnsBiXx+PhOgyqGaexo1LkTUAX+J6T9wg3U5dHIRgK0YVQCN334lrRDtkJ2lLJAyxF4VzFCZB/X3fFy4V/0wOo4PGY8PDAVqx3XlZzZ7Cj6JJh2N0+ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760496199; c=relaxed/simple;
	bh=t//g5VVLiPoLZPOOcpwnhEVNvTW5Ewzb8nEaC/GEjNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M5tsnSWqXzKqvQFssnJ12iDqrb3bnArdYo1Lqf+yZrWyAYD9QvEW12grcYiYaMMy+RaS5jcytPh9reg3N99BaJB3x/b1hP3nn/kgxRp41sY3OCHbCMhu7f6iKS2BPABE1tsSDrlzYOpB6QveJ40Uej7AM2A4amaGCfLWhkioNg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HozLeFDr; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-78af3fe5b17so4758987b3a.2
        for <bpf@vger.kernel.org>; Tue, 14 Oct 2025 19:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760496197; x=1761100997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ww7AEVPWYxv683vdKSv1Q2nTcJqkJpCk/tVO10MV/Jo=;
        b=HozLeFDrL3ZIq9YXEGs28n9LA+XMP/UyXEOPPrGMbk5Ed7wm8VioizVSmLEBrMSdU/
         uupJgkrcS77G1hLfFhXSCAdfgS6obNHreH5dNelRgOQ0I+rbOypat7RU1xWOD4tJZJhJ
         TyGYMaj9hG+G2itvTAnIr2Sl4d9qLPCNWFP8R/E3BH5iCgbpdEl3a+XS/Xpk6ybxAe8n
         Q1AAcDtVgJ6P9xsoup07sQv6oXpX4qIfblXQ6PU1pQsJTVPGmUKOkhUEfglCvRDrsLie
         qiupedvAK1tIE/7mtuQioLD1Zi7s5HHheZReKHEQJQZk63Fh4edctg7T6V4YFEsQsfnC
         LhXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760496197; x=1761100997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ww7AEVPWYxv683vdKSv1Q2nTcJqkJpCk/tVO10MV/Jo=;
        b=r2AtaJs5Ngbfn25f9clV32t6nke6Z/0tSv4XDAv2RPXUxHY6lixqP14ILWESsAoElL
         hchhP7rfoQu/0EeliCFjZOHGfK40l9+fVdh4oFOKS/Km2hap3QhUe+Ruq7137sLue7I7
         6glWiW1ifbHiHV8OJq6+q/VNTi/JQQFGUzZngjTFZ2QCJLzY+qQtCehwxMx2zKurCxMI
         hm1lj5WdTMxgFA9eb0wlJTfkCxMQFuOq7EV8Mz4I/bPBXgCDE00s9q+AEXomTg4EUdSv
         JcA3m3KO3UocOHTiaJ2QgBsKVJF0Zqih+z5C/RLbdxdS+i0kyf6Ft03G5HKa/E/QF3YB
         n5pw==
X-Forwarded-Encrypted: i=1; AJvYcCUX6BudVe4oClPCz1+3LFZWMLuYIP/M/n+HzvSKnLJW+G3m0sajzZdSYfhomH+L8NlbqSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEr+skLIIQrLMADt6es2DQ0TaQvjYaciC9dVtT0zBd36eVWS4f
	qm+adHZ9afdNOS3fsFOXkbMzWGkATe49jpDx1ae7pQq9CZhgh3J4+Yoi
X-Gm-Gg: ASbGncvmMvxChB/63q2be2DqX6U5/xTCEeYlva92h2ZvdnRO/iGjsqSsIM4R7m73Peb
	M5UnudLLa055SwZ2Sx5TJyMujvyDzLGhE0gI52NJ5fs/EclphPd1QyG+xxmlQDEYJydjOkAdM6q
	UQr62fJDKGxdMo92H+HnCZ0RbvSm4gSex4zNustsa5Z3+QRHzpSWpjIJSQxugoOKChLxnoOs/Wd
	JzzVgaC3L1+JSBXarOJCLWE9JDEUiEcPZr+uwkrUsWyPoA8dMv6ftQx24HvrVDTiQsRrFA4oZmt
	GQjmlkPGqJyydNPKTkX8MpuXkzy9QN3XeKb0sq9HTOU+9O7VGBhuDYAjr+tLxLHXzHgl+wTbv9B
	4tB5UKHAXdRxZz00pa8Mpe0zaQuFpbnLBxWxkzpJWnmcUMiq+DKcoHPIVROQZ948ueEPl4nBEkK
	BH76JXSqpZwS9GIRvvLJceSnBvWQ==
X-Google-Smtp-Source: AGHT+IEt1SxZtCv1Oh0+AgCvEiPU+i3eNUmwLRgEruP6G09hcjBe8TPswgqdEwYBwFPDhGSlSKpPaQ==
X-Received: by 2002:a05:6a00:2302:b0:77b:943e:7615 with SMTP id d2e1a72fcca58-793878294a4mr30781877b3a.16.1760496197201;
        Tue, 14 Oct 2025 19:43:17 -0700 (PDT)
Received: from laptop.dhcp.broadcom.net ([192.19.38.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0e2774sm16660548b3a.63.2025.10.14.19.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 19:43:16 -0700 (PDT)
From: Xing Guo <higuoxing@gmail.com>
To: andrii.nakryiko@gmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	higuoxing@gmail.com,
	linux-kselftest@vger.kernel.org,
	olsajiri@gmail.com,
	sveiss@meta.com
Subject: [PATCH v2] selftests: arg_parsing: Ensure data is flushed to disk before reading.
Date: Wed, 15 Oct 2025 10:43:07 +0800
Message-ID: <20251015024307.7924-1-higuoxing@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <CAEf4BzZw_YJKdb4D6Vaj7Vg1koMGuKwcYuEbDvTn35i5tDYEug@mail.gmail.com>
References: <CAEf4BzZw_YJKdb4D6Vaj7Vg1koMGuKwcYuEbDvTn35i5tDYEug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for reviewing! Here's the revised patch.

---
 tools/testing/selftests/bpf/prog_tests/arg_parsing.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/arg_parsing.c b/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
index bb143de68875..0f99f06116ea 100644
--- a/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
+++ b/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
@@ -140,9 +140,11 @@ static void test_parse_test_list_file(void)
 	fprintf(fp, "testA/subtest2\n");
 	fprintf(fp, "testC_no_eof_newline");
 	fflush(fp);
-
-	if (!ASSERT_OK(ferror(fp), "prepare tmp"))
-		goto out_fclose;
+	if (!ASSERT_OK(ferror(fp), "prepare tmp")) {
+		fclose(fp);
+		goto out_remove;
+	}
+	fclose(fp);
 
 	init_test_filter_set(&set);
 
@@ -160,8 +162,6 @@ static void test_parse_test_list_file(void)
 
 	free_test_filter_set(&set);
 
-out_fclose:
-	fclose(fp);
 out_remove:
 	remove(tmpfile);
 }
-- 
2.51.0


