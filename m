Return-Path: <bpf+bounces-37130-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D03909510BC
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 01:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B0481F24558
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 23:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC701AC451;
	Tue, 13 Aug 2024 23:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lk6nj1TH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1A416BE34;
	Tue, 13 Aug 2024 23:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723592593; cv=none; b=iQLDaF24gCB/w3ryf4cXBtZc+ImPlm1jhs52G0vKqvjZmEf2mEKd0NYDWKcq/kDBw4sICJ31y4jQHj12BZ8Ifk0bKZbdtek/a5sF7vNeAkdPqyk4WBiNdnn6MmZaMbuRyGsoYIFlBmLzdtnI21mgAwPhvUUWhSFKFK0vwY8Ksxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723592593; c=relaxed/simple;
	bh=ZfMQddyR4VMROisJI2TkO82wkmQw5Dh8ZMYlE15Cg7g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l1RCilQR5NIC/ER+NMgQBUVN8oySf8FIWo0qxlaR7qzEJ1y1eFgQjP4pjPOJrLI83fz8S6htQW71MkFakbfj5SfH5M9PtsKCIXFoW2IMRulMFG5iqnNP7g2AaE6+qZ/CCMY1l7HijtrEMZHz8VIupSHHTceScQ+GGdlllizeJZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lk6nj1TH; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fc5296e214so58011875ad.0;
        Tue, 13 Aug 2024 16:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723592591; x=1724197391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8YlYlablwzelVOdHb3auZk1KYuThzW8ziJWSrPypAD8=;
        b=lk6nj1TH9habK2cHBs6jikvMWgV+HnnONUD5rfjV2x8J8HtJ61fZobTQBGE99MvtkF
         v4LdPIWWDI6unuSTlr/XiX7XWgSR9X1RHS84Yvzjfw9hJ7SF9pexeiRzlKRZ/0Ur33XU
         vSaONSeo3C3ME1OLxXVH7v2AZydZW23HtJypspTtqgAa6rBV+6ahwm9z3TbzN5ego2My
         /yLyBU9ZLeigIQiCO312hEVVJalgfhgTmd2qDZZnhuK+9N3Om5ZvGwDzktJryo3h0WmN
         Bzngf0ZQgdTt74Fm3wqTPz0VotLovgxDARPjLZ6E3avZvyoQsawsyiy1a0r/fI0BYfgn
         vyIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723592591; x=1724197391;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8YlYlablwzelVOdHb3auZk1KYuThzW8ziJWSrPypAD8=;
        b=SPCaBDamo4FLGNA2bsNG+cfRJYUUsA8Cx3xqeCUme5pAC/oVi5BXUcrxm5Nk2bcqJc
         3LxrIs1BbTg+tEPEMyUR+NfGpQ/ONBg6QUQtWbJaAEhDchsTmkHY7+z+DCwJP6xmUdqy
         OUKtQzIy+cC62+tDsOPYZyx6wcNJTNCPY8Wlw93cGfCs0GoYeRLsCcVzssI5W/fjl1uI
         0cVNnqvlGS1wJWcgyhfgK6LghhLNdQ3FWCE6IKbAKz/zH9uW7uXc55sMbcN7JmThV2v0
         XHAaaDxyB9LZb49E2j2QuaIS1zxz9BB/LCpJux4fgJ6MZWY5ruBAy8FmjKZF+VJx/iua
         mgEg==
X-Forwarded-Encrypted: i=1; AJvYcCUzymLBo6BZ58CWUl/OD1nH3nZ5c6Y1TXFGZsZqLU3Nh96qCxh4v7jMEomXLsblsxLVRMDem78=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNp7yuBqtACeunudGUBRph1Gq5bQtZMGu2I2Le3+IfPoRGAR0N
	5MQ7NPI5ZzU1ifqgSp8FpnkqgothGEk0ZqGWqBzifjil9JorD/lA
X-Google-Smtp-Source: AGHT+IH0GL6af1pA8zksuvMNp84AGZzVGr7AjhFG3EMFCfx5Fsq6rzzBzjkAn+31T/UzZB0C/XFGAA==
X-Received: by 2002:a17:902:db10:b0:200:9a4f:19ad with SMTP id d9443c01a7336-201d648802emr11586605ad.46.1723592590932;
        Tue, 13 Aug 2024 16:43:10 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:66ca])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1aa80csm18844525ad.146.2024.08.13.16.43.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 13 Aug 2024 16:43:10 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org
Subject: [GIT PULL] bpf for v6.11-rc4
Date: Tue, 13 Aug 2024 16:43:07 -0700
Message-Id: <20240813234307.82773-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit d74da846046aeec9333e802f5918bd3261fb5509:

  Merge tag 'platform-drivers-x86-v6.11-3' of git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86 (2024-08-12 08:21:52 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-6.11-rc4

for you to fetch changes up to 100bff23818eb61751ed05d64a7df36ce9728a4d:

  perf/bpf: Don't call bpf_overflow_handler() for tracing events (2024-08-13 10:25:28 -0700)

----------------------------------------------------------------
- Fix bpftrace regression from Kyle Huey.
  Tracing bpf prog was called with perf_event input arguments causing
  bpftrace produce garbage output.

- Fix verifier crash in stacksafe() from Yonghong Song.
  Daniel Hodges reported verifier crash when playing with sched-ext.
  The stack depth in the known verifier state was larger than
  stack depth in being explored state causing out-of-bounds access.

- Fix update of freplace prog in prog_array from Leon Hwang.
  freplace prog type wasn't recognized correctly.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
----------------------------------------------------------------
Kyle Huey (1):
      perf/bpf: Don't call bpf_overflow_handler() for tracing events

Leon Hwang (1):
      bpf: Fix updating attached freplace prog in prog_array map

Yonghong Song (2):
      bpf: Fix a kernel verifier crash in stacksafe()
      selftests/bpf: Add a test to verify previous stacksafe() fix

 include/linux/bpf_verifier.h              |  4 +--
 kernel/bpf/verifier.c                     |  5 +--
 kernel/events/core.c                      |  3 +-
 tools/testing/selftests/bpf/progs/iters.c | 54 +++++++++++++++++++++++++++++++
 4 files changed, 61 insertions(+), 5 deletions(-)

