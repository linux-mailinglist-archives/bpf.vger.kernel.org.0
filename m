Return-Path: <bpf+bounces-61997-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C489AF0411
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 21:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4834816C2EF
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 19:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01819277813;
	Tue,  1 Jul 2025 19:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8R3hU9k"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD59415C0
	for <bpf@vger.kernel.org>; Tue,  1 Jul 2025 19:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751399289; cv=none; b=CK1Zz/5Ly+OsSo6oSW1xAg0I9kujOErBJ3O4ersBhBkiTxaL5ptYu61hPDS7VXwV76+9tMdeCIyBOl5nVtBvnhfvMJ+6yNXpS7MWFct2yAkv17K1omJNY+ZpU0p4/Ex2k8/rGscOAAnDv8u5Ml/xMaPG36IUCT3vVViRxExZp6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751399289; c=relaxed/simple;
	bh=81nMluBZCK0NnfYEjNNGmNZ5oWQ9s0g6zFW2tk8kW9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bApAppFlcEH5hP4GiGNAsSS4UZ8HVGykSVsCLu70DolCbomHqa45rn/6WR/afLZgFOLCYpW1FrdGeQ+5teME/+Wo5Zttege6/a04RbownY87VzBiqZ9p4Qbw4hdwPoeOLRwtHIa6UAdGhundNUHSzSQxLu6xMmbiAhJyT/3vQS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a8R3hU9k; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4538bc1cffdso35392405e9.0
        for <bpf@vger.kernel.org>; Tue, 01 Jul 2025 12:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751399286; x=1752004086; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4jWDxp9zZGAPmfNO1a4b9i/YIezILtIrSS1BiIPyqEs=;
        b=a8R3hU9k7rhYYB/GW7MgMCwpLQJlbpizw+PTIL/NcyNgJ+f4eUmPEOqEv4KWTHAuMd
         y5fsRplHncj4PJxrksvBSqXnVdhYU6pNijMIUruEfSQy5/QErvwO5kyq0/I4Iil6d0yK
         YjM54la2/GNRzYTihO9fkBWnFfsSyVsJq1JxHXKJ98Bl+CRotbq3K1u4bJJpRhlw6DeH
         DjTWgSh09SKSKJUbhT/dptqQtDerWcUvea/nQDiASA0+jIF3lAnWSe05iBjsee3d7FEK
         Bfm/DEgvZ9TM2teSnh2Y49vsbflEIbjPex62jTWDl3IKy8KGaIzwShwCAaxjxS2vzjDN
         CPvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751399286; x=1752004086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4jWDxp9zZGAPmfNO1a4b9i/YIezILtIrSS1BiIPyqEs=;
        b=a2uDSCu4bE2rhxdP8FzYM4sL5Z70bgsn6s/ibD6l8G6bvVoqyEGmFpIyQpYvWwy3Le
         6AtoaJXhEUs5gbHNe1ZsdNb6YSCQnRKDSYttfiPs3kxr6RkBwvc8PZF6g0Kk9EoZ6QKE
         tOJnosvpw8/7YHffC8UyHkdz5CTnOn/s3cwlrzxpJfUYgUmY7gdmHWG8+GJkiqGKbGtC
         iqK1OcpZP0e4Fi8hHHRhp8N4oRx9nNsrMm4aFkyTCKWfIPFPqTegwzMEqKjZYzMsJxQA
         UxfrCe2cQiRq6SXDRyobhvguW/HEx9udx6ef7X6eF/5tgNCEu83qJG36QCiA+56EHtii
         M7tw==
X-Gm-Message-State: AOJu0YyCuFcMgCJ07EEv7e+8+C5NMsOWQ48AAKfl1ihBr8ohJK6UyfE2
	mH3e4v+n1ZjJ7/ZY56hy4TW3d1AwUIjJ5T7mcXe/dG3cwYytGSt22WalVI99y4ja
X-Gm-Gg: ASbGncudWrhhie1XUF2gt/mQFVNZvxfVJ358+mRWaCXlmk4L3lFTzlVrn9xdkbI2+8D
	A/TvsPznyONkbt/ZqbTP7+36zwiiCcgfyE4VC7yOURu1bzxSZrbP/BjuiXmkeF7Pwshi2LPi6Jg
	oOU5tY8+bbLKWGv/RTSFD25ixQ27xveCe9vVX289C4QZzIQDjorsgoRhzz+o39us77AlRhoNroo
	m/QxP0xp1BEC0z5kH1HOsMTFqIHOfTO6wfM3poYS4UR4vpnN+sTaJOZBQrpoC83GKVc3NcY5ESF
	0N/UpH/vSNrgxolL9oALL20GUbYVPe3Vhh8Vq20EDEFp6W0ORdaCboOm+2YJrkI1L8/mLkyeqXm
	lGhIBC+ziLQCpxXR1osT2KmJL1MD1ZTX6yVLlMnBfDsOF4CjPbw==
X-Google-Smtp-Source: AGHT+IFCE/V/7hI9doZaQL1rJxFGAsBbXt01Oux9zp9DElcrLWrdKlG1ERkASEwri1SjctGLEVyr4g==
X-Received: by 2002:a05:600c:628c:b0:450:cea0:1781 with SMTP id 5b1f17b1804b1-454a3703310mr4212365e9.16.1751399285901;
        Tue, 01 Jul 2025 12:48:05 -0700 (PDT)
Received: from Tunnel (2a01cb089436c00024ac52d8fa7f8001.ipv6.abo.wanadoo.fr. [2a01:cb08:9436:c000:24ac:52d8:fa7f:8001])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453822c6b9fsm204539925e9.0.2025.07.01.12.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 12:48:05 -0700 (PDT)
Date: Tue, 1 Jul 2025 21:48:03 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Florent Revest <revest@chromium.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf v2 2/2] selftests/bpf: Add negative test cases for
 snprintf
Message-ID: <0669bf6eb4f9e5bb10e949d60311c06e2d942447.1751395489.git.paul.chaignon@gmail.com>
References: <a0e06cc479faec9e802ae51ba5d66420523251ee.1751395489.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0e06cc479faec9e802ae51ba5d66420523251ee.1751395489.git.paul.chaignon@gmail.com>

This patch adds a couple negative test cases with a trailing % at the
end of the format string. The %p% case was fixed by the previous commit,
whereas the %s% case was already successfully rejected before.

Acked-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
Changes in v2:
  - Clarified %s% test case already worked without the previous patch,
    per Yonghong's review.
  - Rebased.

 tools/testing/selftests/bpf/prog_tests/snprintf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/snprintf.c b/tools/testing/selftests/bpf/prog_tests/snprintf.c
index 4be6fdb78c6a..594441acb707 100644
--- a/tools/testing/selftests/bpf/prog_tests/snprintf.c
+++ b/tools/testing/selftests/bpf/prog_tests/snprintf.c
@@ -116,6 +116,8 @@ static void test_snprintf_negative(void)
 	ASSERT_ERR(load_single_snprintf("%llc"), "invalid specifier 7");
 	ASSERT_ERR(load_single_snprintf("\x80"), "non ascii character");
 	ASSERT_ERR(load_single_snprintf("\x1"), "non printable character");
+	ASSERT_ERR(load_single_snprintf("%p%"), "invalid specifier 8");
+	ASSERT_ERR(load_single_snprintf("%s%"), "invalid specifier 9");
 }
 
 void test_snprintf(void)
-- 
2.43.0


