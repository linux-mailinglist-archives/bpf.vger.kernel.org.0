Return-Path: <bpf+bounces-76612-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B6075CBED88
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 17:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 43B2030161DF
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 16:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DD613C8EA;
	Mon, 15 Dec 2025 16:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="Mc1u23L+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE4723D290
	for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 16:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765815211; cv=none; b=RYrLNtlvqoDvSL/qscvEq65ebBn6HjPpWSVO+6JsyUVOkEJ2qIrHA6kUoPjXUKkAcI6v2qjCYksyeB7TtnRZYrF2HV8ue5te4Yn8yz/etqBn7USwLi2nrUFTlqfAtuD/mklj/8n27iMXEtzEP1SqbSHrGftYakPkelEo/i+sghs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765815211; c=relaxed/simple;
	bh=bLdNCCXjPsQ55E0/2z63PFSmWxGoX+NyyUzSODv97Ws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BSgF2s8J+cjYucHw8qcX9eoInH9yPrkdtU/tXe+6sDWClnTK7RPhcflvJCnQ7lKh0aU6L5DhKNGkM/fA42ji7L5PDT7NM8AOIH/4yiiFEGmZY3wgO4P52t3eWx2GEx36XcwhsqyANCUfCIC9c7GqNhBPqZU+b24wMzzJnlO/11M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=Mc1u23L+; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8b2ea5a44a9so383065285a.0
        for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 08:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1765815207; x=1766420007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kSqGYl62zmomYhFF/RmsICq2RsnLGLg/3+MN6YEiEzc=;
        b=Mc1u23L+KzUbCE12dtcs6zK03BjU+axxhytamOLqRRubK3w5qGskO1dRb2Ekj5eOs2
         GQhP2U3FjzuNphGbNaYZO/OrgFG+tzFrqr+a/dcdVP8PsI4X5srBfSRaTP8GBSfWRzCB
         kxVcee1cxN7dNJPbj91xadOssdsFaZTpPeUmzuR0eCkl2yUDUzaDlkl37yXqQCBU11/U
         zHSiQ1gnxHBtGl8AG70zBjl8cRTppuNkEiuTy2G3uO8hPPsvtjl1od7gTqhhXQrgb8cK
         LA57Q6lkSDTL9h2Z/PcPPnRqwhKwJmitPPj/DxhVjKMk5YYty3VdQnA0jMFoejBG31hb
         UbDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765815207; x=1766420007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kSqGYl62zmomYhFF/RmsICq2RsnLGLg/3+MN6YEiEzc=;
        b=tnaqjUTXodyBxAZqG922IWzyd2JXEj/G1qmz5BRFGSjKPSBOTvz+zF6fz5JGZKFHfU
         bZzdc9MMyVHXNisrFz17FVqy/NTcHHx5OUoxpV0OC/9B7PaPuBi9e7bpJ6CnbMYla5sd
         S50E0f1kP7aXR5sxHuG/5Ku7tfu9fCRmTOfrG23bqbWWlm9yMFK2R9PQgjJ5+que79FI
         yEj8W5CTvIh6yMDYtLfRX8MrQHzkHKIJxJ+pjlV04yuGk2K3EnVBNnr3xOuY2lA2/u6S
         hVSPJME9CYwlLCkwU3IDG9T1qDHu4WcQdGHtmq7r2WBQiP6Bw9MIIpO4VZlbMJVE3LCq
         klxA==
X-Gm-Message-State: AOJu0YwTucIgOGeLqHQ+1Y4zViaLWS2vVCsx4zk++htsPGR3P4uFxlet
	oOzQgfX6O211ZGBxX70vuXoET7QgNxCb1v/i1cGDTr8rMKvnQMxREFeIcPjxpi1zzrZzxbk6zSv
	Bd9rU
X-Gm-Gg: AY/fxX66jlkAWhXvkC5+Z2L7a4PMA0NHKGLi9apMh+QLw4Pxkr7ZH5sJXL7LUZWW1LT
	haBtpCQ59CI6k7fA2WmwVbXj+V591wKMmmIodAzyb4PqDvuy0oIwN11E0uQ6doN6QcQBhm13lwp
	BWTLf+Sd46Nz4Xxpb0QjkqedQhyVDFsLAeYB+Ihk3+skKdyxekFPLzkYnWQgaSMkR5Fp4UdoDNe
	RHqCFzj0diImpUvRz3uQ++j9U5sBqP/8NDLzmz52y7TgqFVFUZ8RYBaD6CfxtWrZ4EuX0vbuequ
	VaaP3f0+yx51WiNgpa7ZyBn7bUy9ZmM9Wd0YSzwFxJ9xut9sk+3UZQcD4kAR7Pz9gi+fPDSlSeb
	wTmMfqXtow1IUzc9qN2ysWZOotRisBtW/0vnRkvbA1N/32YBi6hdfwjz3iua1dFKjkNst+m1xMC
	WPf8g5D+Uuqw==
X-Google-Smtp-Source: AGHT+IHLT5D+XUZVHfcDLQGe+k9Ib45s05uvEaGePIKsNfovtYxdjgRZ3WMyPX6m5su9YHtsbCm30A==
X-Received: by 2002:a05:620a:10a9:b0:8bb:7dd8:1922 with SMTP id af79cd13be357-8bb7dd81988mr1052160085a.40.1765815207494;
        Mon, 15 Dec 2025 08:13:27 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8bab5c3c85bsm1142195585a.26.2025.12.15.08.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 08:13:27 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	memxor@gmail.com,
	yonghong.song@linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH v3 0/5] libbpf: move arena variables out of the zero page
Date: Mon, 15 Dec 2025 11:13:08 -0500
Message-ID: <20251215161313.10120-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify libbpf to place arena globals at the end of the arena mapping
instead of the very beginning. This allows programs to leave the
"zero page" of the arena unmapped, so that NULL arena pointer
dereferences trigger a page fault and associated backtrace in BPF streams.
In contrast, the current policy of placing global data in the zero pages
means that NULL dereferences silently corrupt global data, e.g, arena
qspinlock state. This makes arena bugs more difficult to debug.

The patchset adds code to libbpf to move global arena data to the end of
the arena. At load time, libbpf adjusts each symbol's location within
the arena to point to the right location in the arena. The patchset 
also adjusts the arena skeleton pointer to point to the arena globals,
now that they are not in the beginning of the arena region.

CHANGESET
=========

v2->v3: (https://lore.kernel.org/bpf/20251203162625.13152-1-emil@etsalapatis.com/)

- Remove unnecessary kernel bounds check in resolve_pseudo_ldimm64
  (Andrii)
- Added patch to turn sym_off unsigned to prevent overflow (AI)
- Remove obsolete references to offsets from test patch description
  (Andrii)
- Use size_t for arena_data_off (Andrii)
- Remove extra mutable variable from offset calculations (Andrii)

v1->v2: (https://lore.kernel.org/bpf/20251118030058.162967-1-emil@etsalapatis.com)

- Moved globals to the end of the mapping: (Andrii)
	- Removed extra parameter for offset and parameter picking logic
	- Removed padding in the skeleton
	- Removed additional libbpf call
- Added Reviewed-by from Eduard on patch 1

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

Emil Tsalapatis (5):
  selftests/bpf: explicitly account for globals in verifier_arena_large
  bpf/verifier: do not limit maximum direct offset into arena map
  libbpf: turn relo_core->sym_off unsigned
  libbpf: move arena globals to the end of the arena
  selftests/bpf: add tests for the arena offset of globals

 kernel/bpf/verifier.c                         |  5 --
 tools/lib/bpf/libbpf.c                        | 21 ++++--
 .../selftests/bpf/prog_tests/verifier.c       |  4 +
 .../bpf/progs/verifier_arena_globals1.c       | 75 +++++++++++++++++++
 .../bpf/progs/verifier_arena_globals2.c       | 49 ++++++++++++
 .../bpf/progs/verifier_arena_large.c          | 21 +++++-
 6 files changed, 160 insertions(+), 15 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_arena_globals1.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_arena_globals2.c

-- 
2.49.0


