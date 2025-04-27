Return-Path: <bpf+bounces-56799-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C95CA9E22F
	for <lists+bpf@lfdr.de>; Sun, 27 Apr 2025 11:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8B491899246
	for <lists+bpf@lfdr.de>; Sun, 27 Apr 2025 09:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8146E24BD1F;
	Sun, 27 Apr 2025 09:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kfr9RpCh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA99624C08D
	for <bpf@vger.kernel.org>; Sun, 27 Apr 2025 09:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745746893; cv=none; b=WHtwO7Rlw0WbxF/Loy6d8BDVYG6Zr4e842d6m0kLEmPN1J7G24ZSRX+YRJRWnNbE51dI6G9pYeePu7WT/YUXLBsUOeS+Ei/O38OZXIv5wgeXyJU5KV27icaXEYLqMOJ3JZh45z0LYLkmj/qQALLN6RUFeSREMM09dy+Tjkx3ItU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745746893; c=relaxed/simple;
	bh=Mc4hvb9z5CZb7t4r+oQuV2pkKLHcxELRJOCzuGN9B3E=;
	h=Date:Mime-Version:Message-ID:Subject:From:Cc:Content-Type; b=eEbGn0O26XxRSLTl8+5M803vEGnNdvr3abwJR8gHiUFhKK4072mdmoUZL+w4MbeXVAyf+QwU07eYbQaAMszRsQ1JCG8bdco+E9x1vu8i8Xh/u5hXifq800JXmbm2b8ZyoxhLUF9OtaGejHbD1VHe/DrNYB2O7r4j16IWTMpsxyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--nkapron.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kfr9RpCh; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--nkapron.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b0b2de67d6aso4022713a12.1
        for <bpf@vger.kernel.org>; Sun, 27 Apr 2025 02:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745746890; x=1746351690; darn=vger.kernel.org;
        h=cc:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T1QzW8ASYWJaLvx5FFC5RLETegsZ39C1u79HEntZtqU=;
        b=Kfr9RpChJyS8JGnhW6NdoVZl9OSN6mHz3jND6V2MdMbPnLYVQPd+V+O0PN0wmJXcDm
         KTJM50mTef01g5Gq1Vgf5NNyDNMmephsyZB9v//xmstl2qF3ObQ87deAyGDAKiCeb60P
         XOWzQTTXBGk1xxLf3Y5INxRcwFwapGXVyGmzO7pSz4eUj1dEM8BH+kfKs+/kNfSwz5Tg
         bUPIhmcZjzgbsCS4jMBu7YSRB9WJ0yo2JA/mkE42NMUAQiP2kkxM8qxJ0HLUU0ZnfNBY
         qbqMy1usruIEQh0zWY0wUpzmDBDNMmlMfs+H3gjRoYMLeonrmI9WQKuk+kaFPsLMcFPy
         1cVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745746890; x=1746351690;
        h=cc:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T1QzW8ASYWJaLvx5FFC5RLETegsZ39C1u79HEntZtqU=;
        b=JzXLumHKA/+/VrAGlDqUGo5J62Tt/f9f1+gYvyT9er3jo5ygvVSKG9Y/6tYpfQ9t72
         xrGdB85FNjfG698Vhyjf9W+eU0QwoYfyHkgf87RrhzItbb6wUmq6HecAEtod/YG6qc8B
         /SmpwscyCbe5mu29C0ISN2Kmv7ARutJBRcNyiYxSI4Jdw4p52hlQDm2k2TwwdtEwDEJG
         xGFTwQU+xbCMfev9wy8volqA/NwJIpxFZXyw1Rk3+v9iDLfcRHpZ4H/e0edf85AsFwWz
         fEy8ueBnkzo3hY5MvTNvolfeWOKeHsKKkzNtlH2D4OY0Gow63bI3RkJPzMjgvy5ngDT5
         u2mw==
X-Forwarded-Encrypted: i=1; AJvYcCVUN/KJuN2kwdSsD5/B1803LbC9VxhR0yrgLi9NXmRi1ygv+1tVpb8OSFl8X8KTCDfKuuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO2x5Y8YPnrk/MFQSjQ9/0wssxJJC4BNG+ZcMKJzK7f2uJApSD
	4cWKTzgGPNprPzo0945h1FQ2AfNyY6zp8qE0c7j+VEZNZG4BJIiwFQ/NaFjuYbXwXEJ6hCgc+Ja
	zQ8TUzA==
X-Google-Smtp-Source: AGHT+IE+YOK4bUXyeUihTdfe88MG12kjU7NJjnEZ1UiwKcYDjmIUXUZlOWiD5yJB6YrhY981Gpkc3u2UM024
X-Received: from pgbcp4.prod.google.com ([2002:a05:6a02:4004:b0:b11:14a9:1d8c])
 (user=nkapron job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:998c:b0:1f5:8903:860f
 with SMTP id adf61e73a8af0-2045b6ebb88mr12037759637.14.1745746890050; Sun, 27
 Apr 2025 02:41:30 -0700 (PDT)
Date: Sun, 27 Apr 2025 09:40:58 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.850.g28803427d3-goog
Message-ID: <20250427094103.3488304-2-nkapron@google.com>
Subject: [PATCH RESEND] selftests/seccomp: fix syscall_restart test for arm compat
From: Neill Kapron <nkapron@google.com>
Cc: nkapron@google.com, Kees Cook <kees@kernel.org>, 
	Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The inconsistencies in the systcall ABI between arm and arm-compat can
can cause a failure in the syscall_restart test due to the logic
attempting to work around the differences. The 'machine' field for an
ARM64 device running in compat mode can report 'armv8l' or 'armv8b'
which matches with the string 'arm' when only examining the first three
characters of the string.

This change adds additional validation to the workaround logic to make
sure we only take the arm path when running natively, not in arm-compat.

Fixes: 256d0afb11d6 ("selftests/seccomp: build and pass on arm64")
Signed-off-by: Neill Kapron <nkapron@google.com>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index b2f76a52215a..53bf6a9c801f 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -3166,12 +3166,15 @@ TEST(syscall_restart)
 	ret = get_syscall(_metadata, child_pid);
 #if defined(__arm__)
 	/*
-	 * FIXME:
 	 * - native ARM registers do NOT expose true syscall.
 	 * - compat ARM registers on ARM64 DO expose true syscall.
+	 * - values of utsbuf.machine include 'armv8l' or 'armb8b'
+	 *   for ARM64 running in compat mode.
 	 */
 	ASSERT_EQ(0, uname(&utsbuf));
-	if (strncmp(utsbuf.machine, "arm", 3) == 0) {
+	if ((strncmp(utsbuf.machine, "arm", 3) == 0) &&
+	    (strncmp(utsbuf.machine, "armv8l", 6) != 0) &&
+	    (strncmp(utsbuf.machine, "armv8b", 6) != 0)) {
 		EXPECT_EQ(__NR_nanosleep, ret);
 	} else
 #endif
-- 
2.49.0.850.g28803427d3-goog


