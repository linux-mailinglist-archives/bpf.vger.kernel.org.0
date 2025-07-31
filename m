Return-Path: <bpf+bounces-64788-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 230C9B16E8D
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 11:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 117A062075B
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 09:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846272BDC0E;
	Thu, 31 Jul 2025 09:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHooIH2I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74FC2BE043;
	Thu, 31 Jul 2025 09:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753953892; cv=none; b=ZeBj6ezPbmzSoh40r6mpJdLcjtPl+rG2Z4L1xH5sZ8xl0Rk4s6VUuGG52wpo0GG4h5uzD5IqRfTMNKw8pKWf6XVYYpKP+Cpie5Y1cuZQhrufcSRcroW7QukasEjR/+IqFCTV1Wa8pOfSnhoQXL/ZkH7el8YQ09wrkIR7iJdDhGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753953892; c=relaxed/simple;
	bh=TGw2ul2ZAldEcVHaU0fnT+T9Zm5AaMY7QcEq1fLdVSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EJb+KUTqWQnE7RXHaLOKusrCcYMVthr2uADY0JqfuEz1ha7UJ8IcU9gPyDJp0n1UFSzCZqw9IMaOly1e+wUjFoGywDX0rvF1srUZaL1tR3Wul3V6x8V58wFA1T1zqk7JyxhTFHH7KxiSc7HQepyrR2MOaR2vEiRg5uhynO3Nyqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BHooIH2I; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-7425bd5a83aso627117b3a.0;
        Thu, 31 Jul 2025 02:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753953890; x=1754558690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGBbLIiLGqrmFvSwaYDbAojdCre78exL+6ZjHnBuXvE=;
        b=BHooIH2IAYMcpBhNatGwdhjNO8bOKMHIyiTQaJ6M8kDzcsuXyBev00hRITLy0eSzLV
         tgJTHkGptSaaNACfQF28riBvR2+FoQ0P8NJwBjdqY9PC9hHu3o8UP8KjtnvnGfrBDqxW
         YeYf3pAIOSgt1LZWerlMCVROyOu9OowTfqaRAlvIKUnn9xUT0AyHt6fNnbAkls5Ptu8N
         XIsS7kc2h7hG6WQJhw4VSsI6gWNNrkg2IvuNgjgBlUlkO96VgIeBBWCadGJNP5AM0FMs
         fpaDtICwHQeh6C+sSYhaWTQqMPyJRdwwlKE0QWto0PAm7tljC5PKJsTj+Ts22f/nMJvR
         A0BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753953890; x=1754558690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DGBbLIiLGqrmFvSwaYDbAojdCre78exL+6ZjHnBuXvE=;
        b=SKMwxY8tIAhSIlFh53Hqw7GQpNrQwMtCFK89Q+Jc9idFl2AHpDblJd+VlAHehSrdpj
         68ZIJeF0tE5oh1ZDXduJR5V5EmSOBp/R7wlH7P7P/blCQ+T+AQ3KSxx5zYq++dG099Iq
         RgylsN7dbLGmsYyGIulvInFOVE1ZxuxSMr/mUqhkN2OnOQeEgsllU/+Ylrp4lspWvcYB
         2Cxttr6atYmnCGHsY4kvPC4x58uPWQdwufxVegWoyJoFThU+4cCopUUdHTLcsKtnCyPn
         aF2Vbez/PVL6kClnn2632VhTY/5XVJaPZV62u12OLtmGDgY7Fy/EKM03uQ+2M7qQtDZO
         kkCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhSNCjNY10GHaYDjuEN6mhBpgWz0N58Y7y2/1Mow8/f2BF3HQJ5hhbGklObUgJ5+fitH4ycz9/3FsF4uhx@vger.kernel.org, AJvYcCV+knHiYisP6dyv1C+xLEnQk9GDlYX8W/w3QNeTNPMemoIvtw5zrRk9S4lPLWA7wk5v3Rs=@vger.kernel.org, AJvYcCXV5fc86LHwWxipvKPv/mLfb2OcGXI2tWduWJlyJL+KOJ0i6rN8T4XEK8snU+tq9kCQVYTKfpKul/GISKvLu2TNhiKp@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/bT+8ho4h7V0znoVRhifb+0INtBHp7kbymlg5EB4cJucMHc3U
	cHm9HrHI2W7grq6wl+F1PJYCENuWXQChUOBTwacs4oYPiJV8B4mByfdc
X-Gm-Gg: ASbGncsWO7ktd4piWxjicIEu8AK33S1UPEVKD8BavOHXnarTCVFXwkyzp3DRbTX91CN
	AKv9uoyR+tG9yy2b/wDUUmUNCkVcGSI8Q/LNUyCNnPTvHmB7kBYQkr5VmZnTiisXrM1W8s4xAmg
	zMoItgbU19H9gdMbzQYm6CYAC0UED2/cwOXBNIh7Uf+KNe8HKEYMun2AFMeaq2g8l8RTuZomrdu
	25dkHEslMg6PjjjddfrqWoumgLqHLMSwFN5qmFpMQ5jFM0WkQVff8zADG/Wdb62H8kb3aKQv8r/
	ck1zoDD28nkOmc8qGbWPHY8ZhdElvyeHnmeyZXEW28CIKzV03Sg22VCKnBzrhvffTVTSUKRycHd
	E9tDkr7tYGZ+edGJ4nfrrgOEQ4Kd/Hg==
X-Google-Smtp-Source: AGHT+IHNh/ANB2dkQCa0nO9BTR+DxCH4IthcpzCHKS7zI734G3ATILS/eyr6az5628hpfcauKorqWA==
X-Received: by 2002:a05:6a20:258f:b0:237:d013:8a78 with SMTP id adf61e73a8af0-23dc0e99cd2mr11483916637.37.1753953889900;
        Thu, 31 Jul 2025 02:24:49 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfbd1a7sm1108143b3a.73.2025.07.31.02.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 02:24:49 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: mhiramat@kernel.org,
	olsajiri@gmail.com
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	hca@linux.ibm.com,
	revest@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 3/4] selftests/bpf: skip recursive functions for kprobe_multi
Date: Thu, 31 Jul 2025 17:24:26 +0800
Message-ID: <20250731092433.49367-4-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250731092433.49367-1-dongml2@chinatelecom.cn>
References: <20250731092433.49367-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some functions is recursive for the kprobe_multi and impact the benchmark
results. So just skip them.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 tools/testing/selftests/bpf/trace_helpers.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
index d24baf244d1f..9da9da51b132 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -559,6 +559,22 @@ static bool skip_entry(char *name)
 	if (!strncmp(name, "__ftrace_invalid_address__",
 		     sizeof("__ftrace_invalid_address__") - 1))
 		return true;
+
+	if (!strcmp(name, "migrate_disable"))
+		return true;
+	if (!strcmp(name, "migrate_enable"))
+		return true;
+	if (!strcmp(name, "rcu_read_unlock_strict"))
+		return true;
+	if (!strcmp(name, "preempt_count_add"))
+		return true;
+	if (!strcmp(name, "preempt_count_sub"))
+		return true;
+	if (!strcmp(name, "__rcu_read_lock"))
+		return true;
+	if (!strcmp(name, "__rcu_read_unlock"))
+		return true;
+
 	return false;
 }
 
-- 
2.50.1


