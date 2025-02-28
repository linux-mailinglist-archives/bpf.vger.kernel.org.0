Return-Path: <bpf+bounces-52851-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA1FA49147
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 07:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E62F13B6F55
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 06:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FA21C1ADB;
	Fri, 28 Feb 2025 06:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/qRqXIv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EDC1BC099
	for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 06:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740722458; cv=none; b=hdV9BI7PlL5sYN1ECgg9w5DHiFWj6PQsf1fOqU/35imipXy7eYK+YJBdAiWVx2yBYG+L1pe1PrKcueM7pm58ORcMEDkumQ1d5MUSWNmGMjqK51GT5pk57NO5razFvNIlaXRuxQp4A1oo3PiAQ6xhlG+2KUgAdbwCZOJmlBDmJtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740722458; c=relaxed/simple;
	bh=/hVBpMKLh7MjSInrbYvHDTBA3SIOj0lhfAVVuOcw/bM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iLoTz2dLtKZohgVAAUjk8+Tb+EeCIP6QuW4UTcWctr00SNP4JPRgPRhKJMD6nj0HDTQ+1Q6wzxA8hBXVxX1HL4iEKuoHsumzSx1PSQXSZ+5XceskOrZKSAfAp/VwU0RHDq1A0D+DAUGxa+o7IGEUnhwnjlHSLaTUSangjeIJb3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i/qRqXIv; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22355618fd9so26954295ad.3
        for <bpf@vger.kernel.org>; Thu, 27 Feb 2025 22:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740722456; x=1741327256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gm+sjl3J9u3kbhVA84uM+yNYLfvVrXUtdXHiqBrDYII=;
        b=i/qRqXIvx50iDq91ToDBuTO3daw5Cqh+kHkW2KI5YePfmN4t+gqKp/iIc8dDK3mbvb
         6GasFc7Lxd50zm7t7Piq3TY1CNuWw94n46v/yMaE5VkJrp8N1D2B3M9gttHxjwIFqD3O
         FafRh2cQ91Bb2n+doYaewodFULE3nUXEUDL24l8D3mo/tEE8NC3LygovUc7W5mQFxaJb
         vCrq+MG2Bihoot5HN3WNzcubIKYTxsPtUry7pXBEtyrAxaCcD91M86ZssEPc0zE7v1ev
         zGXrw/qnZgNcNJTftdcxtTUEeSGmDTDYFxO3G0a8vScf4IQxbCWX0iv8At5YqetNTAz2
         Kl0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740722456; x=1741327256;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gm+sjl3J9u3kbhVA84uM+yNYLfvVrXUtdXHiqBrDYII=;
        b=oPF7HmLBNzW18rBcG9OrTdspiD7YkIJy+r8ysRCnY+/1GdHtIPSWvRsxxJag57yXJH
         sgJRSgMBg11aPO1jYZgfOLsRs06QWJxH0L9DLYFc4mrPc+NLAsEfzJWGY4rDtSUMrWxQ
         Pi7fkz0vX/X5akUW+9fI0Xubeinf6Hq4q7kHBmldc0RN/4cAAIiPinLK3VpMe/WYAUdm
         Ms6mWaqnVhYuATg0Y8gNI6lo0Knpm1t+nEVR8vaeUEqdUMIHz98i5BCU4lSIc3YQIPXt
         /Vx4G+rG9BW3A4okfUtwnfzSLxPrA2UIqxcizUWsa47V3iyldy3de6lmi1a0Z51WkVVQ
         5EYw==
X-Gm-Message-State: AOJu0YznYPRK8zodJlRHl25s5I+DEaKvj1Ry2MJ8YvxUE0RYEwcWjTO0
	1ByB6ZTRYNLXyl8JAvqvzFJisDJchxH3scwKxbkXsddmfPNXnpUkbgkJOg==
X-Gm-Gg: ASbGncuBlJj8gCLdU2l00i3seyLk1sg/tHPOcJwlUC/kSE8R4c2RBJXxef8mFO52KOj
	rzT8xRShr+zbls914fGvWEncSfkv/MINE/+8oLIJlPIzgx5dXZqDwL97Zk6W5OyimqdVyLckCuZ
	yjes75Buy2ZRAY3pKeW4qY04L3hLOBp1oV7m31ZaGXiSVNGSMpJ7wITQ6Bppmwv0D44zCx9WZsw
	cwtMyBlXvQEN7WbSUFYQp8woy+XLF5qKCmvRCLwwc+kOtRRoQy9e4atgZs+DprgVpceHhqhWoI5
	M49ByseDBbBGoVfPSoZaXA==
X-Google-Smtp-Source: AGHT+IEIHHfLAevjUVSLnkTdVN+AKdzkLYf63GMgtS9J9WECUOfKqR+pMKXa/lhN5SGDemjxG2yFEw==
X-Received: by 2002:a05:6a00:a8d:b0:730:949d:2d32 with SMTP id d2e1a72fcca58-734ac35dbc6mr3739789b3a.6.1740722456170;
        Thu, 27 Feb 2025 22:00:56 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a003eb97sm2927018b3a.148.2025.02.27.22.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 22:00:55 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	tj@kernel.org,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1 0/3] bpf: simple DFA-based live registers analysis
Date: Thu, 27 Feb 2025 22:00:29 -0800
Message-ID: <20250228060032.1425870-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set introduces a simple live register DFA analysis.
The analysis is performed as a separate step before the main
verification pass, and results are stored in `env->insn_aux_data` for
each instruction.

This change improves handling of iterator/callback-based loops, as
regular register liveness marks are not finalized while loops are
being processed. See veristat results for selftests and sched_ext in
patch #2.

The patch set was tested in branch [1] by disabling the current
register parentage chain liveness computation, using DFA-based
liveness for registers while assuming all stack slots as live.
No notable regressions were found in test_progs-based tests.

Note: For regular subprogram calls, the analysis conservatively
assumes that registers r1-r5 are used and that r0 is used at each
`exit` instruction. Experiments in [1] show that adding precise
handling for these cases has no impact on verification performance for
selftests and sched_ext.

This was previously shared as RFC [2].
Changes since RFC:
- The parameter count for helpers and kfuncs is now taken into
  account.
- The analysis is now enabled only in privileged mode (Alexei);
- The `copy_verifier_state()` bug fix was merged separately and is no
  longer a part of this patch set.

[1] https://github.com/eddyz87/bpf/tree/liveregs-dfa-std-liveregs-off
[2] https://lore.kernel.org/bpf/20250122120442.3536298-1-eddyz87@gmail.com/

Eduard Zingerman (3):
  bpf: simple DFA-based live registers analysis
  bpf: use register liveness information for func_states_equal
  selftests/bpf: test cases for compute_live_registers()

 include/linux/bpf_verifier.h                  |   7 +
 kernel/bpf/verifier.c                         | 394 +++++++++++++++--
 .../testing/selftests/bpf/prog_tests/align.c  |  11 +-
 .../bpf/prog_tests/compute_live_registers.c   |   9 +
 tools/testing/selftests/bpf/progs/bpf_misc.h  |  12 +
 .../bpf/progs/compute_live_registers.c        | 397 ++++++++++++++++++
 .../selftests/bpf/progs/verifier_gotol.c      |   6 +-
 .../bpf/progs/verifier_iterating_callbacks.c  |   6 +-
 8 files changed, 804 insertions(+), 38 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/compute_live_registers.c
 create mode 100644 tools/testing/selftests/bpf/progs/compute_live_registers.c

-- 
2.48.1


