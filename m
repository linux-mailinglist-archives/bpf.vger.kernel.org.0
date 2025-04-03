Return-Path: <bpf+bounces-55268-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 179E8A7B1EA
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 00:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99845177D69
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 22:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D086D1A3154;
	Thu,  3 Apr 2025 22:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ji6pgFDB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C73136E37
	for <bpf@vger.kernel.org>; Thu,  3 Apr 2025 22:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743718126; cv=none; b=HnjDSlfptkERPWLbNLqjl2FU7uYdMAkkY1Mf2kdZr3TjGqey5IFg6lWSV6tWDmmQs1ItGClJcX4o8IUZFqA2nK/aanGbWPFAVvm2730fdJq156NKiNDnWAkqWw9ozZicGD/wB+2UKTiKLPXcu7bMi0ttUaHeNhSuu4tvJ+yi+3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743718126; c=relaxed/simple;
	bh=66jaw6xA6JHGm0Gyc7o67JUIV1YDuWGqo2E+F0GCark=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CQQz2VFeeBqvQU8UZieCYli4NpSkRD3bvCancOS4BHPJr13D6a1xHmXAsE4rBrNHbXklC8HfGEULkKLb5I204T2Ce1mjT+MX6t/eLRNx7US4r87pF9AmKhrdI8F7/zHhKbuSL1X6Rei8WIDHZmB0vApnQqtKs+9OEzSMFw5l2Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ji6pgFDB; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-43cf680d351so14413635e9.0
        for <bpf@vger.kernel.org>; Thu, 03 Apr 2025 15:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743718123; x=1744322923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P4hX8Je49r8vM+NsvREzdyUzc0sNEPIOk+3cHDaz/lI=;
        b=Ji6pgFDBI3SaadnqtgQz0iKSirEqogj1aSEccFlmX83ple1W4Ip4goWVHwkSWZHK4l
         XnmKSJvRQogMaJhruxh6iP4T/AkGSF28S0LjsYlglopreSjW0DIxyn45kOO7Jz0AF6nZ
         2MwgYPhGEQRdWeWsz6NA55GeXBYA6DNETYsfpGHW+F0C9EAsie+xmfkCHj0Tr0krtn4s
         bYNEUXHfM/bYUw66kJQddsyylFE6OrYNhDProLJK9WUf5Fclb4wAO8PNwRBOewxt6Cdm
         Pf+TwLIQb2VZWjNXfPLlCpwXef4P+cXXwVaPO0TAw/maGdLtd4eMt5s+96JwGcbb5TUy
         11xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743718123; x=1744322923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P4hX8Je49r8vM+NsvREzdyUzc0sNEPIOk+3cHDaz/lI=;
        b=KZWaZB/Gts2dWDw8H/edsXIQHWMBAo4vMd6PEQURPN/NV6WqNPfxayU+t6TNOy+cn9
         JrlTyTYjaEMRVML2pz7UbHmELrn1MV7nJXhdNRojhLH/Uqy4on3Qr5Q/GFejD3iAYk1y
         GM0Yyr6wCDLFJGzQXRMaGPI2mv8ToWoKELKa/6hDQd+/Ggrs1BSXyRjRwFeNgIcC3fnt
         luRTjyynBqPl4wT+HYHDIeRb2q61NHcJ04iqZyP1NDMNQFUzPlRGNy7SVZ7l8d8Vt43T
         4zsOgEF3i67OJ26zl1T49OwXGldKJCwgcFCdpmPGuBeo6k99Ca9qR5NJAqjruGKsDgJJ
         hzdg==
X-Gm-Message-State: AOJu0YwVDLhEZPwtvnlf0eUCj7t5H2wpG9sqA/i5tzdveiDy5S7IHAST
	0BVpBMMPQIIqOt5g32I+P/IZJ6voGAQyQsXSdI1Ynt6stf1PI4/JBtITR4j3bno=
X-Gm-Gg: ASbGncu5E08xQ/uF+w5HcVFsTCgCNEd76eublWM7hqfSoAPWO+hWvzeksEH/jcGBeyG
	a84gwwGDb+ogOoIP9MRR5yz8L1G2vESt2vWMJdpNne1eStJrgFn63wMZ8THAwopp+lExLt2MGHi
	SQvhaw/eEGIU1tXDHcsiU/gs63pJ0J4Iw+RPxOlVk/SevgogoeGRZByzIMkDVf7oOzaFnGhreN1
	DPqdX5GZWBqWQhlYGtl42yJMbx7Yp7EvjmvdZJxUZiqZ5RGL3ijsqJyNgotgwjUZL42mOx5EYaO
	rUmzGkghSLzlnfWwc34t0aoUmwvU5aPNPx4lsx+QYYJx
X-Google-Smtp-Source: AGHT+IHMNX7oJLIA9KmZec7Z0MmQ4ma+4WDum8pNvT0cO0YPyVFZ9gGoNJG08+BcOjs31sP56jVPjQ==
X-Received: by 2002:a05:6000:2489:b0:390:e9ee:f27a with SMTP id ffacd0b85a97d-39cba94dac8mr676915f8f.28.1743718122597;
        Thu, 03 Apr 2025 15:08:42 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:4::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301a79bfsm2890008f8f.36.2025.04.03.15.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 15:08:42 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1] selftests/bpf: Make res_spin_lock test less verbose
Date: Thu,  3 Apr 2025 15:08:41 -0700
Message-ID: <20250403220841.66654-1-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1426; h=from:subject; bh=GDipxQcCtjY3UDn16JdfgurQZ4fOmljH/+711PeefXo=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBn7wamBmLtO79TfUnI8GOI8E61ZaX04sTfmqyfdEpA x2HjxqyJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ+8GpgAKCRBM4MiGSL8RytmaEA CBGnC+YpluaXkIldRI5MlD9nlecD6pWSYwEZcN1fOWTfYAJjwvqXSZ0C3HmAtJ5A7lscyErcZZAx8c ufvf7dTUlDT6LtNBfUObCC4bu+Yhb6Ej3Ku57wlXfggHaQN14F51+aFK7AMDAtixOTr6Hve2s0L5LJ EfCzgsAZK1s2q6rw32vYmJ+msHS68ez4Th0+gkXP/+tK1wpqh7FsVpwWJHB5VosXNmIsByJ5JU6J5+ RmzY2QGeN+MIyCYFVRIImyceLPrf/hOqNDs4+Bq9JXN0LaZs8mZ0JgE5ZNJPN6peAvO90Ok9xz/HAw Kym2zQIlWg4kNdZeScRgPjPNB1fcKo3Ubuhl/OfZUUfyvFgTjJY04WMtfF8QAH2X8P+Vdm5NmJFNNi vRTcF0IKMYR9hMOGHxcgSjmgL7goozTddt4tbUTbwRfAPWf4E6E7oqL4zQAhs+kaTd0WzUkE/RJ8wm gTBR6u5z9cT4n5X1SWrYHreRlMcMO25JbEL3QFHr8A7l+TWpt/EkYlJbnvwMtSr+cIOTnSM/fbdA1S ffOJDIBLeKlxpMdvQAjOiiCTpxJL6ler2IVb0cb8etBRlfPDa+1FnFy3ObyKjBi5MBOIPCgZjIXmCT mkT8TxbEV26NOTzKQ7Qt5gJPpoueaAfvoNBfON4vcq2TNBeAv6ZgY0VFaMYQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Currently, the res_spin_lock test is too chatty as it constantly prints
the test_run results for each iteration in each thread, so in case
verbose output is requested or things go wrong, it will flood the logs
of CI and other systems with repeated messages that offer no valuable
insight. Reduce this by doing assertions when the condition actually
flips, and proceed to break out and exit the threads. We still assert
to mark the test as failed and print the expected and reported values.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/res_spin_lock.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/res_spin_lock.c b/tools/testing/selftests/bpf/prog_tests/res_spin_lock.c
index 115287ba441b..0703e987df89 100644
--- a/tools/testing/selftests/bpf/prog_tests/res_spin_lock.c
+++ b/tools/testing/selftests/bpf/prog_tests/res_spin_lock.c
@@ -25,8 +25,11 @@ static void *spin_lock_thread(void *arg)

 	while (!READ_ONCE(skip)) {
 		err = bpf_prog_test_run_opts(prog_fd, &topts);
-		ASSERT_OK(err, "test_run");
-		ASSERT_OK(topts.retval, "test_run retval");
+		if (err || topts.retval) {
+			ASSERT_OK(err, "test_run");
+			ASSERT_OK(topts.retval, "test_run retval");
+			break;
+		}
 	}
 	pthread_exit(arg);
 }
--
2.47.1


