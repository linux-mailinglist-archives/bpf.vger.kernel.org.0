Return-Path: <bpf+bounces-56798-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BD0A9E217
	for <lists+bpf@lfdr.de>; Sun, 27 Apr 2025 11:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC7B91A84B1E
	for <lists+bpf@lfdr.de>; Sun, 27 Apr 2025 09:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E7E2517A3;
	Sun, 27 Apr 2025 09:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gM16h1RP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED729247288
	for <bpf@vger.kernel.org>; Sun, 27 Apr 2025 09:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745745785; cv=none; b=FYQ3WeraK2f73vd+Od5ZIYwC9N/6p8mcXpIQhdnEKlbaTWg0Tf1m/Gbdly3l36ZkpXcimUQ49BbaKbdeuHGyEw82nVzjn1U7WqnMPoQZ6LmeMGLw4Y48e9tMZZkKODRxQiLaGn5tWwTtPHtwYIOIQk+ndFMn2tldBccZnJc6Ts4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745745785; c=relaxed/simple;
	bh=WZ/aViUI4SyDQrmZUo2zgeycetmsihbA8iFnIGRSmJM=;
	h=Date:Mime-Version:Message-ID:Subject:From:Cc:Content-Type; b=rXZdtP7KjB9fNGCN8z0Kj1Ii0RlBHEJbPvdUhkh6okz3nsZunQopjZMUZZSvbCXd/tpBxJkBxRPq13oTo6FxZCUlIOQGGKrmKiz8UMAqXjBJVhLS+++ixCYZ6Zrb+u5Jag4gmohPhUVfwjFjt5OavXf5sLju7YMBjP/bByJYK6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--nkapron.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gM16h1RP; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--nkapron.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7395095a505so2752456b3a.1
        for <bpf@vger.kernel.org>; Sun, 27 Apr 2025 02:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745745782; x=1746350582; darn=vger.kernel.org;
        h=cc:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PvB0WFJ8LpaALOYW8Xx/CWM6owL785SHgzuXle7StY8=;
        b=gM16h1RP3bFG/l55L4AsvWk9oPA86Z+GT0D0wXwiB+szdPDF0poQFNwDy+RO6w5bNF
         OhTSfDgl0xwbTK2HIuNZFloAB/YmmFvaFuFm4fciIL1VF5dAMzxArfe5+DYTrUNo7u96
         rsEbfEQ9s6+5T12/4yw9HKKP/QVJWSzMN+IrYY0OBvXCiTCq6vjOXimVstbxJYvqNeuT
         jn4cYgZAoL1qdqYtYBU8lPs+XQAqZ2hAuflSaVjD3+Hbjhh0KX7Ek5q/M8W1ak37ZTWZ
         tGjoIyOmkvv3xw4hoefLmuS0Ir+Z060aICrUaj/JNpLD+bZl2roECnWuCaz9vl+Krq4i
         sKVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745745782; x=1746350582;
        h=cc:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PvB0WFJ8LpaALOYW8Xx/CWM6owL785SHgzuXle7StY8=;
        b=WysjzY1PvuawstD9ZwBECoih5jMiLO7hRs7kIkEDkq1pu3EULmCshgMg9k40/R9sUB
         RVAVdLFd4EtwJIQhdFnRhnfNoklHFaT736mbeqCrY1xjLk5GZZzwdCzY005pJo5Db6ua
         xTgfUhKDCY891yyFSzggHbt3hJIAtIsYRRj5JaRXf7wvxa6s6WacdHuOkmL59SCrz3lW
         6Oa40dy9R5BjDdMvm9tz1cCdU/GsCaIfpK+T0MFKQWLES4IuFkBfTk22UOgBvLhmvMCL
         oAk9Rjs+Balo+QVv52qSZ3oOu/y/pK92A+Qajr3pSV84tkyc+AIL6w8wxQvw9Cvhu1eF
         9Ceg==
X-Forwarded-Encrypted: i=1; AJvYcCUQob56uHUi59cQJH9siCDTGZgpBaeD7aV7rPBibqV00mWeuQ545qs+wS/+YIOYRaEEFsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIU7E/pejDIxwyolTYTh/MpIDSaVKmyKRuS9EEkNvzmP5Ur8vE
	+LgSo5P90bFcrewFPJGrYWTORrS5BiG9W2YjoGLyLH7X2XHTYi7N520aJYlXV92m3DmATNrgs/6
	7V9CHXg==
X-Google-Smtp-Source: AGHT+IEC4fmk5RMrs7/B+YYVWJOa7hQpxIGr9ZZpihwteVlFumQgJhCsLJ6cnOjAFz222TCymBv/P8REh+hL
X-Received: from pfbkr16.prod.google.com ([2002:a05:6a00:4b50:b0:73e:780:270e])
 (user=nkapron job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1490:b0:736:5dc6:a14b
 with SMTP id d2e1a72fcca58-73ff72ce6c3mr6571771b3a.13.1745745782292; Sun, 27
 Apr 2025 02:23:02 -0700 (PDT)
Date: Sun, 27 Apr 2025 09:21:19 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.850.g28803427d3-goog
Message-ID: <20250427092134.3482407-1-nkapron@google.com>
Subject: [PATCH] selftests/seccomp: fix syscall_restart test for arm compat
From: FirstName LastName <nkapron@google.com>
Cc: nkapron@google.com, Kees Cook <kees@kernel.org>, 
	Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Neill Kapron <nkapron@google.com>

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


