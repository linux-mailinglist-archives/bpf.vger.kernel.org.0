Return-Path: <bpf+bounces-45738-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BACCA9DAD62
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 19:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFE45166501
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 18:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA35201114;
	Wed, 27 Nov 2024 18:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5O16qev"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7BB201103
	for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 18:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732733500; cv=none; b=C/p9ote4oGHiL8Z/g0BZlo+dD0NzBV+IOXbigJUwjITKVbowD3oaplGSX0BxjIXVoA0i0esGt9JkeSNTsmkwfcHtKdNc0UBwtfarr9YEJrBLpzCnLmDWopT68FcAtt6104ubDqGj1D4som+ZAAIu9cAKx52z/eDsFFD4I/OR+8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732733500; c=relaxed/simple;
	bh=rmoPgA3AGYfDxAt1nMkrY+mgRarTzgOE/2HKXfgi6fE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RHixm6KgLFsgjWyHws3+cP5CY0j89WN235yktJew6CQORGQ2fWHrjNBeskQyoKZeA5FEHa2gQZ9hwE/I2dgRpgn3gCkxuvGwPsctH0BsZ8a0l9VyOjzjreT3c1JM55J0bDZhtUGI/FFvvTdpkkn+nz50MIAzzUXJIlU+PZ/BuSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k5O16qev; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-432d86a3085so64804085e9.2
        for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 10:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732733497; x=1733338297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lVQ4r0ZiJoyKQtTEzXyImutcReABvOR1aV0gtN3uTx4=;
        b=k5O16qev67Iw/UYT29YtdvbdLR8Ug6uI8hKSkcHAyaB5iIlzKiPdQqLVxCiWZv+iNG
         Nm+CIXdJ6StqDQDbPzSlA6vgDQfss9iSChhXTo3MYaCWYADSqiEk9qVXfFTO1eRFoCDl
         u+o71kZoPb1dSIkejh4tUf1BIywxcJCfao7b9XcjuuIlD+/dXjP1V2gSxHpO6BwoNmnv
         jgxfLuz/ZZUftdGNQtgpGV3e3TjdIwgxyT4d1Hq9nUbfZ4GLr4K71pbVIrSWy1sWF0YS
         JDHbY8YHursqmtfS87mTM8JGxHF8p0QXuaNA+9QJRnmuGLct7y7VXGXET3dhNymWxSgm
         je9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732733497; x=1733338297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lVQ4r0ZiJoyKQtTEzXyImutcReABvOR1aV0gtN3uTx4=;
        b=TQKt/L6gRhEkiAJxYWoS2NTbCb5c0E8hI5xoHnh9AO32iMtNsOAF9R0yngzGSD8wxk
         XIlE/v26NIoBuGx8kETa6cE+xA1n8/qVRGZzgOmp/379t59mWFd0kGXCY/ulEGjDM05u
         nvXzBUacbScpiUue2Uevd8KGHee8bvB4pdP1vQuevafcNyVxAn1RkXlYFfxI33BmPS1/
         HpATw+ptk7e91l4vl9QBpAQ2NbF3NqQUCg+8iZDh3FrVO31sTw7g9WW37z87/+Vp76hA
         Ecqo7RGOTK1u1j/pU+tx1GtPNlBOxi6Nz7BaoJo2zjIIbY4fDt1QEO9YdDTzD4Mct4OZ
         mrog==
X-Gm-Message-State: AOJu0YysSY9KFm/9x+4YLgYDe+jDa3tk6CflkAerM5UWg/4NSRgKAaJu
	4VS8HgKA91PhPadHhQknRZI0J6Mp8s9T/P/8F9ors+1ROZWOnjA+dUtH0zDHIo8=
X-Gm-Gg: ASbGnctf99EvyWyzr/7wGZghL/ZIU02MsZ4KuKDqa4ax0PvMGiCyAJmqewAzMwY+L34
	Fvjm7sE1zFjfyKd+u23O501F9xQsedGmOxDoKpdDSNJhUyM/FcOcEBNdFdWAS+uQBUIFvH3z5j4
	Utt+1b48F3tTnv8x+W79IWaBlJyLckKpCudLQbJd94576t45NuK7G8NUsC4O/9UNNU3/qlboKpV
	XaaJxeGP6YNBlmpeq3+17j1VMsHGW98JwDB4rJtngmUfCeEA3woiWhlFR9+o+ubAkqJti9rBkbY
	9Q==
X-Google-Smtp-Source: AGHT+IF2vx2mvKaznh69agyLGV4TJu6P99uk59E4irjdIMulVyMqjYJ9SY/w317ejYRLei6HeUqwEw==
X-Received: by 2002:a05:600c:3b02:b0:434:a968:89a3 with SMTP id 5b1f17b1804b1-434a9dc4ff8mr39512335e9.9.1732733497094;
        Wed, 27 Nov 2024 10:51:37 -0800 (PST)
Received: from localhost (fwdproxy-cln-038.fbsv.net. [2a03:2880:31ff:26::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa6f3d11sm30108525e9.0.2024.11.27.10.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 10:51:36 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Tao Lyu <tao.lyu@epfl.ch>,
	Mathias Payer <mathias.payer@nebelwelt.net>,
	Meng Xu <meng.xu.cs@uwaterloo.ca>,
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Subject: [PATCH bpf-next v1 0/4] Fixes for stack with allow_ptr_leaks
Date: Wed, 27 Nov 2024 10:51:31 -0800
Message-ID: <20241127185135.2753982-1-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1015; h=from:subject; bh=rmoPgA3AGYfDxAt1nMkrY+mgRarTzgOE/2HKXfgi6fE=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnR2oxDMJhUMxBeHb/S1j+ayaq3laGDBQAgVRYhShk XFLNAmuJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ0dqMQAKCRBM4MiGSL8RyrBNEA CPoygrVWmsKGetb7Ue8slfWy4PKcw+7TANFmMYhO82EaT1ZuOasL9RxpXreBsPgGrorOGIixh9npRU nxT0gtaGuF9u6Ff6gT9YSgEJQhngcDTwDlu9Hs+fHXMZP3e+NOyU0h352CPAq+Ce3ojUQCcCbrkQy6 YkW9v5zLolG5Y9eHWdJY1BdbI0Aeb8G2i8gZknAvsZCjRd4HfxdqovjujL5zeZi/XewY6P3u80dvuT A0sGuI1ZlOptdrSh34GCP6gzpswm+HCTo4xpsYhpmxtrouC0xVw5Mb2kQcPp9mGR4tP6EqXcz5TR0x C9gu08jU+9YqDbiASEb2LyFDjtudzoE8vUC5dIwGKCQafUhq9hYPJG9BleIs0HtRa79SZ65OmEkQVD QkdkrwkQyJHkHyzNHpe04p5tl3dnxASsUZHL0F4TuLo7I/3U2U/+j7bnTWwxYOvXKh1CFQtPtS9UrQ 6UYWFmrKdk/gq0YiVReK89uJxGA1MRRVMIOBZFjTXakLepPX+qbbaCRG6VKwP9FVDyDIoJfYn7v9QH EO6nmm6inYOg/izuz0B2gkeF35kaAj1MOiifBR6Zs590N8tU+XkaweGpRW9p41pCM6RftaJjFTuW+l cBng+z39qxZOMrgig3CUWjTOUBfUvi+qk1AGQ4sTc8a0nGEC9QRAqUWNgMPg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Two fixes for usability/correctness gaps when interacting with the stack
without CAP_PERFMON (i.e. with allow_ptr_leaks = false). See the commits
for details. I've verified that the tests fail when run without the fixes.

Kumar Kartikeya Dwivedi (3):
  bpf: Don't relax STACK_INVALID to STACK_MISC when not allow_ptr_leaks
  selftests/bpf: Add test for reading from STACK_INVALID slots
  selftests/bpf: Add test for narrow spill into 64-bit spilled scalar

Tao Lyu (1):
  bpf: Fix narrow scalar spill onto 64-bit spilled scalar slots

 kernel/bpf/verifier.c                         |  3 +-
 .../selftests/bpf/prog_tests/verifier.c       | 41 ++++++++++++++++---
 .../selftests/bpf/progs/verifier_spill_fill.c | 18 ++++----
 .../bpf/progs/verifier_stack_noperfmon.c      | 36 ++++++++++++++++
 4 files changed, 82 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_stack_noperfmon.c


base-commit: c8d02b547363880d996f80c38cc8b997c7b90725
-- 
2.43.5


