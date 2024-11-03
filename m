Return-Path: <bpf+bounces-43852-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6B49BA96D
	for <lists+bpf@lfdr.de>; Sun,  3 Nov 2024 23:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A72CB217AA
	for <lists+bpf@lfdr.de>; Sun,  3 Nov 2024 22:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991DD18C013;
	Sun,  3 Nov 2024 22:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmqsjXt+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AEE154C08
	for <bpf@vger.kernel.org>; Sun,  3 Nov 2024 22:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730674786; cv=none; b=aY48Dfute3dJALCju0aIZo3yJkeAfcH30mPDz6BDPbPpcwZdB8S3kX7WiQA3MjUpSaX5UOU6nzViFg8I7e2tClcU4axFIAaOAkT6ctTBXiPM1mfyHV/c/xUJV0nS7qSfuk8ko/iOFy5HO99WjLJiRQbP32vt466wB73QSEAwxCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730674786; c=relaxed/simple;
	bh=+Wmltbn6JvYqL/3KyA9Z+ePV11nRBeTpuv1ZhO+IpbM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gsoc7bGY7qhwk5QOFqBOKppAWI0XI0IzhDcl2WapSp6iCZR0vF5jcai1nwU8p4eJQ1fKKw9Em7dD2qiZ4uVEXvlFb01EiAoFA080OTeNoFhzw4jip2R6oIs/CF6UVwBi1KsR/t+sWznvAG3MZxGGVaVGeDjDYeOTL6ierd2AI6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LmqsjXt+; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-431688d5127so28040605e9.0
        for <bpf@vger.kernel.org>; Sun, 03 Nov 2024 14:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730674782; x=1731279582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3GtuvnqVBV0Zle4wTZVsmCPj0sQzVWy+s6UMhbH0Kw0=;
        b=LmqsjXt++0Kv1U9Y8objIHm3hLjngP4LpwHje5v8eLaBz62sw7KW1/vQJTsicRpGlx
         avIqjf6voG8QlrXmZo3j2Q5trqDTsxsELUEkiuO4UpphkcLGn13sVDjPWL/pBAdlxCtq
         WpID0Wa8dROdXPwc7N+LonQ/dG2FXuPJx4Gdh+7AptEMov235wGjMd6BqUqX+Iq+eWAn
         fx+MBgc1YvrAFqt3LGzH92zxwd5ces3+jfMp6fWWpoJ52AH8o4UBRd7l4AsVEhSRlGAk
         zXvvxWAQlqh6cm4F+A6R+CxztTslF5SdO0aWoZ1IaLxaGJdp9WNa52ZXwqwa7oiFjAtC
         Phng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730674782; x=1731279582;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3GtuvnqVBV0Zle4wTZVsmCPj0sQzVWy+s6UMhbH0Kw0=;
        b=HtqatrjeeZT+oMo9/DLAEAZx3JcF8XzoACqBx9QzYf8pmmxVCEJ9IplY4Zoy/ybI+D
         1dIZLwEermk0uThVppIk549+SjJEVkWm43zrqciPd3VhcgDLVtj90YQJh2z4XPkgVlB3
         hvYznTmowqf+4H8q3BFZe3cUtl/rhSTLIb6P4CUQc2uur0qW9GGINWAn+W/SA9Zg+D/y
         QHuh+XGtRK//o9+hkzx1fUz1hVP5awax9SmfH6oArkfyhhZhGG4agNNxXjesemOoJLPH
         Bghl49khuf7NVoRNNm/e1dbMAmGRB3nK1hyZL9o01PpaDsfZLgRt6QIXtZsMbuUJK8SP
         kJRQ==
X-Gm-Message-State: AOJu0YyZ9WJ7nYUoxAyr3iTfL8fkV6Mki22XQCt/oqN8QphkJBBgU34X
	e05YBnen92yMliw4Ma7eDtQ5ZH32koTHxSDVWENRDpdKTt/U6VW2ADR57IN+X5/xlw==
X-Google-Smtp-Source: AGHT+IEqW/tK3AL1oZUE4qypJDpzuEkVcUR5H/NE+8PMiVzSeJCXZ7KtyEM1+LNXFqTg3lcoHkQGYQ==
X-Received: by 2002:a05:600c:1c01:b0:431:9a68:ec84 with SMTP id 5b1f17b1804b1-4319ad04780mr242485205e9.23.1730674781909;
        Sun, 03 Nov 2024 14:59:41 -0800 (PST)
Received: from localhost (fwdproxy-cln-021.fbsv.net. [2a03:2880:31ff:15::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd917f0bsm161438445e9.17.2024.11.03.14.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 14:59:41 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v1 0/3] Fix resource leak checks for tail calls
Date: Sun,  3 Nov 2024 14:59:37 -0800
Message-ID: <20241103225940.1408302-1-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1830; h=from:subject; bh=+Wmltbn6JvYqL/3KyA9Z+ePV11nRBeTpuv1ZhO+IpbM=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnJ//pIXO4g3azQ9Lp124yXi8mC925pYKFfNSYDR9P VXggSoaJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZyf/6QAKCRBM4MiGSL8Rym00D/ 4j4KOOMu6lxcB7dsz4coeQVla+5ZTXS258czMrh08Qe/FCYKwpuKXVGjp9+ygf8X6haXMUuJfWahxH Sn4cU8L4CBWhNeSF6A+JhK70ZlWnA3GQ/YUoFjSDAWps+KPIDq8do7oKvnbHoTBFr3s9KxhbVcb9JG bWaxd5jEwBHqws02MVO56G38FDRN4oVJWPD5pR/cp0fThLOA5ertCT69WFRLqGvq9Cdw5GFuTW76iJ 2zi5yom3CQhfqxKZ4DLbRFNqhjRSLZfLtQc2YMcC9vOmxVzICQQ0s41iyVqeGwqcUbJQ/2cdX4TMS1 Oowl9NJ3qRFE0j7QOFHRWKIJ48X9/eHKlebBWOfyUi/GPmrstNdWFdt7wcz6hRrL/vftUm7gyggvlK dnV/OKX35PcYkq+pU71lMU2pDhvgydRC7faEal2sdJT6+mA2/XGjnhpdSPXC6pSnW6fgi/zgqtASEX kJOztrM+IPrSXfHH1G5y9xnPWnvd3NEaOAB5L9LGFr9vAEGHS9LMMENQ8tV8EGsd2fosFaqE3sr0VN m2esknZuflaj7v0BeD/l8VOlMYqVy7Py5RmX56PjS53A4PLt9G3p4S+i+io0x0JwJBeG/Vvg/16S2+ pPTUIvzEupSZEyx+V5hE2v9vnkwP024cVvmQyGy4iueTrwcebw/PGf3VsH2w==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

This set contains a fix for detecting unreleased RCU read locks or
unfinished preempt_disable sections when performing a tail call. Spin
locks are prevented by accident since they don't allow any function
calls, including tail calls (modelled as call instruction to a helper),
so we ensure they are checked as well, in preparation for relaxing
function call restricton for critical sections in the future.

Then, in the second patch, all the checks for reference leaks and locks
are unified into a single function that can be called from different
places. This unification patch is kept separate and placed after the fix
to allow independent backport of the fix to older kernels without a
depdendency on the clean up.

Naturally, this creates a divergence in the disparate error messages,
therefore selftests that rely on the exact error strings need to be
updated to match the new verifier log message.

A selftest is included to ensure no regressions occur wrt this behavior.

Kumar Kartikeya Dwivedi (3):
  bpf: Tighten tail call checks for lingering locks, RCU,
    preempt_disable
  bpf: Unify resource leak checks
  selftests/bpf: Add tests for tail calls with locks and refs

 kernel/bpf/verifier.c                         | 75 +++++++++----------
 .../selftests/bpf/prog_tests/tailcalls.c      |  8 ++
 .../selftests/bpf/progs/exceptions_fail.c     |  4 +-
 .../selftests/bpf/progs/preempt_lock.c        | 14 ++--
 .../selftests/bpf/progs/tailcall_fail.c       | 64 ++++++++++++++++
 .../bpf/progs/verifier_ref_tracking.c         |  4 +-
 .../selftests/bpf/progs/verifier_spin_lock.c  |  2 +-
 7 files changed, 118 insertions(+), 53 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_fail.c


base-commit: 77017b9c46820d72596e50a3986bd0734c1340a9
-- 
2.43.5


