Return-Path: <bpf+bounces-30126-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFBF8CB238
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 18:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCF871F21CE7
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 16:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8426973539;
	Tue, 21 May 2024 16:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CnOGdM79"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1A217556
	for <bpf@vger.kernel.org>; Tue, 21 May 2024 16:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716309245; cv=none; b=YzBy2+vMOSPgvKGFcFGz8/3B81/Ja9wJAHoeu5hRz/caxQFf/8tlzdGieKMRTOYPJ23ekCf9AN6BI9ElRsBfM/lFQNMzdhQv0Z9Pg1Lytw1TLr8gTJwFEdi4AY8ShijDnVJcqSzSQyu5QdMDFI7jNjrQWaxEpwB2MDukHzCVx3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716309245; c=relaxed/simple;
	bh=hWu7DcsdPHBH0sDdS3S37HYLwCYxksAFaT7E/XBUW0I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=URoaqrawdYFlxwiaeCcE8WaEyl65P3tUZ7Ll1aJEO1m6bbCbM10DhMuWSS5sm8wm/NZX3DYIL7FzIcZHUVuKrlCZiU8weUDR2IZr8vk4llvkikDPmhRHSTPweAl4MjMxhPJf8C4XxkM7KTW+219Zvp/kexHXp1FxkQFLEOccBm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CnOGdM79; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76EE8C2BD11;
	Tue, 21 May 2024 16:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716309244;
	bh=hWu7DcsdPHBH0sDdS3S37HYLwCYxksAFaT7E/XBUW0I=;
	h=From:To:Cc:Subject:Date:From;
	b=CnOGdM79A/z1Ix50CvF99TREfJNx5J+dsKs2uaQ8iAY89BVb2HIqoIrtkVDKgR/0U
	 F+TFmLfFPetM/aTPBq/TmKLSJ2Y9LnAvVSuVwFCWN2b+ZbBfu8YR/Nguq+zMvKPJba
	 /hnweJj1a+ygQBcLEEMfbZXL1bx3+FaM00ipFrwpvtfhJQc7qjceki3s//qQprcKq7
	 1g4nWz3oQ/VaPlvTn8jY6/bFPTMMCghfiRm2vAqgY492jjQcqGq5C8I1yNWy2ACELH
	 X1QEELLg65Z3CkCiQzB98pn3zq2Cq0g2lp1i2bK6z4EsynDeGC6jrVpACVsfkV1rT8
	 8VbJtfzKj/zZg==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf 0/5] Fix BPF multi-uprobe PID filtering logic
Date: Tue, 21 May 2024 09:33:56 -0700
Message-ID: <20240521163401.3005045-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It turns out that current implementation of multi-uprobe PID filtering logic
is broken. It filters by thread, while the promise is filtering by process.
Patch #1 fixes the logic trivially. The rest is testing and mitigations that
are necessary for libbpf to not break users of USDT programs.

v1->v2:
  - fix selftest in last patch (CI);
  - use semicolon in patch #3 (Jiri).

Andrii Nakryiko (5):
  bpf: fix multi-uprobe PID filtering logic
  bpf: remove unnecessary rcu_read_{lock,unlock}() in multi-uprobe
    attach logic
  libbpf: detect broken PID filtering logic for multi-uprobe
  selftests/bpf: extend multi-uprobe tests with child thread case
  selftests/bpf: extend multi-uprobe tests with USDTs

 kernel/trace/bpf_trace.c                      |  10 +-
 tools/lib/bpf/features.c                      |  31 +++-
 .../bpf/prog_tests/uprobe_multi_test.c        | 134 ++++++++++++++++--
 .../selftests/bpf/progs/uprobe_multi.c        |  50 ++++++-
 4 files changed, 206 insertions(+), 19 deletions(-)

-- 
2.43.0


