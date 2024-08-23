Return-Path: <bpf+bounces-37916-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 394B795C2FE
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 03:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8073EB221A8
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 01:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8361D530;
	Fri, 23 Aug 2024 01:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Lsm/MmQO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C231CD31
	for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 01:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724377724; cv=none; b=qT6KoP8c6CCVVFJ3qy9I+YJqfM6pXsStIyzd3bjTJZcVUW61rTVelkRGnqbaxKrXPdXA7f9NPzN1XCEetVV3TE3esGPRCq6fpZ8X/lFv2N9fLUJAV+SJ5HlDBtFpVjuSo3UNJMTskAfukxRKvy28wLTKrhCSbAPJRhlgj2Bzxy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724377724; c=relaxed/simple;
	bh=0BbKF++PKaq1i5yYuCZNH2yPvoAqTN3M876SxYRmVWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rbOeQu3Zhrn/8/tXkt9jHHKXw4lnBfj9gLDLG4MC3b4e85+E765D7cA6OkQ2bypU8OrDHeNCY394TOQDCVLwP6SHrKYYbo4TNpbWZO03PCM1DhSCj22qwFH3MFtgXkVP3h7gRN/pAcYfocO28asRfF/yIs5ggyP1xBw59vXBYCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Lsm/MmQO; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-371afae614aso696743f8f.0
        for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 18:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724377721; x=1724982521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i4JwmTdEUSSkkUga1FYXioC0KGPP04BzkybNO2RcnDY=;
        b=Lsm/MmQO7Zp5KTAPPrg/SpHWDyjm1nhlSvoQB2VMA62BlvRXk/BRD57DViL4A+Q26Y
         82yoQMQyBjX1C0u5OF1La2C3QTG93fkaJ7XnOP84gdP4gZTDPb4a1q+zPSn4KHdfHCmb
         CGK1jnK8JgTm7ZQ4ZwTL4Jhnt1qdDqLmfXy+WnAw4ryN2fA/o84pmuPpzgE1X3YDaspL
         V5erJpJAERwO0qs7FZbmaNyMFX6p8uUps5cLWJ86Dxg4s9LJIHRxCEp3sZXalYWaCTvk
         zyEst1ZnQxnq0Osw+/WnQcJU8qVacOBkZ9glm7zhTaIYZwCMcyAW3E0ispB6BqDY35JA
         2FZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724377721; x=1724982521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i4JwmTdEUSSkkUga1FYXioC0KGPP04BzkybNO2RcnDY=;
        b=rXjGlXtH5vGx34Bkw9pwAdSjwCRge8Kl8JgBzZfXHSeIGi4pNM17V0pkki1+XPwvly
         eSgo5OPGn3mIW8Tznp5+Xivda7Rj3uAzspr3MLrXhEfCbsZZ1QCGK0tcljsraNLoHybe
         IvGYFCdDIa4A/t+jy7+IBxuvrItJ6tmInZAGC/7UG5KIyVvvZMOhusp5vRxUMB5dckj6
         X75fbNRlO5tEDFCXtMKViUYGmu2Xp6lXDALygdqdadW0RlNIzMMkUae+F0/tyGsi8XJX
         4NntJvw34oEVGpGBkNkJ5oWBVXzU2bt4o7+1q4+25jOI1DVXLzzACZiTHMoyokVn1Yge
         r80A==
X-Gm-Message-State: AOJu0YxgXEOL1C/GBTL2KvLm93DQqZ6Vd0wb4Ti456yEsv+Rw4zh9+OS
	UYu/2RZcYr0g2ZK5H2YSbU9vYWzTn/fD8vYebClalVj4BS15FiK95KFoi9yrZAU=
X-Google-Smtp-Source: AGHT+IFCJDkWLwsDk4+ydS60CisBZYncl8PYxYWq5iTjPTVgqyPIHKblpr7HOlXJA/hk3vkNIYUv5g==
X-Received: by 2002:adf:b309:0:b0:367:4e05:bb7b with SMTP id ffacd0b85a97d-373118e3c8emr265065f8f.53.1724377720650;
        Thu, 22 Aug 2024 18:48:40 -0700 (PDT)
Received: from localhost (27-51-129-77.adsl.fetnet.net. [27.51.129.77])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-714343403b1sm1982337b3a.211.2024.08.22.18.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 18:48:40 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: bpf@vger.kernel.org,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH stable 6.6 2/2] selftests/bpf: Add a test to verify previous stacksafe() fix
Date: Fri, 23 Aug 2024 09:48:29 +0800
Message-ID: <20240823014829.115038-2-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240823014829.115038-1-shung-hsi.yu@suse.com>
References: <20240823014829.115038-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yonghong Song <yonghong.song@linux.dev>

[ Upstream commit 662c3e2db00f92e50c26e9dc4fe47c52223d9982 ]

A selftest is added such that without the previous patch,
a crash can happen. With the previous patch, the test can
run successfully. The new test is written in a way which
mimics original crash case:
  main_prog
    static_prog_1
      static_prog_2
where static_prog_1 has different paths to static_prog_2
and some path has stack allocated and some other path
does not. A stacksafe() checking in static_prog_2()
triggered the crash.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
Link: https://lore.kernel.org/r/20240812214852.214037-1-yonghong.song@linux.dev
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 tools/testing/selftests/bpf/progs/iters.c | 54 +++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/selftests/bpf/progs/iters.c
index c20c4e38b71c..5685c2810fe5 100644
--- a/tools/testing/selftests/bpf/progs/iters.c
+++ b/tools/testing/selftests/bpf/progs/iters.c
@@ -1411,4 +1411,58 @@ __naked int checkpoint_states_deletion(void)
 	);
 }
 
+__u32 upper, select_n, result;
+__u64 global;
+
+static __noinline bool nest_2(char *str)
+{
+	/* some insns (including branch insns) to ensure stacksafe() is triggered
+	 * in nest_2(). This way, stacksafe() can compare frame associated with nest_1().
+	 */
+	if (str[0] == 't')
+		return true;
+	if (str[1] == 'e')
+		return true;
+	if (str[2] == 's')
+		return true;
+	if (str[3] == 't')
+		return true;
+	return false;
+}
+
+static __noinline bool nest_1(int n)
+{
+	/* case 0: allocate stack, case 1: no allocate stack */
+	switch (n) {
+	case 0: {
+		char comm[16];
+
+		if (bpf_get_current_comm(comm, 16))
+			return false;
+		return nest_2(comm);
+	}
+	case 1:
+		return nest_2((char *)&global);
+	default:
+		return false;
+	}
+}
+
+SEC("raw_tp")
+__success
+int iter_subprog_check_stacksafe(const void *ctx)
+{
+	long i;
+
+	bpf_for(i, 0, upper) {
+		if (!nest_1(select_n)) {
+			result = 1;
+			return 0;
+		}
+	}
+
+	result = 2;
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.46.0


