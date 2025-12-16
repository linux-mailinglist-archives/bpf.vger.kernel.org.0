Return-Path: <bpf+bounces-76734-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE83ECC4B94
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 18:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32FC03070F34
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 17:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C1733985A;
	Tue, 16 Dec 2025 17:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="TZJYT6R3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F83E338F45
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 17:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765906510; cv=none; b=cixfiqM8GP0YnXEN7u4w1iF2VepSmMdsbuZXOGJxwzzsT9110LoWjmKE7PS2fKz3Wb3+9UcldC7RZHAgFfStAqilUlWDm9rZcKt4NuVNJyHlYRbY8VrEnl07UTZk/x7+e3zY3uKQb4G0yiZNpxmVgL+14x/JowktItP3gPHqgQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765906510; c=relaxed/simple;
	bh=cwsh3xRAxDYt4YTC9Wf/BniyW5lMpKM/BTuXMdI7pzM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=INyiSu/xKdOHhUjaPL0NeglOq/VVLNItNyIyDLH3py3i0SQ/caQN2P0qft90f1/GAXXaqD7zNUVNr//k+3yIhs9Fn5iyw43s8+7Yrl0jjqZ/u31owobTCq1IN5zHdfIH4e1mQ3Z++GrkILWWk+xgbrcszQAj0b+7luAtdSyHArQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=TZJYT6R3; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4f1b4bb40aaso29173971cf.3
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 09:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1765906502; x=1766511302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XuDZ4LDRyUyyHY+nc5RuJWTbrW38h9C1TaWT7NF6ycw=;
        b=TZJYT6R3kPGlogyNYi7XDUSK/XcK5WTbrjGDlH3yZowUQZ63X4Mfyx+UoYDc+751u0
         vMNBFZ8kmOMvCsOaI0rdIrA60cBuf2/qQ1zsjZjfVHFNNL8ByosRL06CtjRAs/ojUl2H
         9GVwQpD9FEqVyzu03C+zNq0jRQQnKoIZ8vfLk1KrG/JUPIVHekzVvM9k+1hK5cGy7Q4v
         ocelwRAcFKKEPn22Fya4+qIfq174YOlzOV76o2dKb79q2vThRcdYzzj6a4WWqQ/90VeT
         XbiLz4MXML3Viek9+ijOpauyU/SmfKF8su6rX4EeJC1HCX4iIkwqNB7V/3+A0t2xItj8
         8h7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765906502; x=1766511302;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XuDZ4LDRyUyyHY+nc5RuJWTbrW38h9C1TaWT7NF6ycw=;
        b=jyCri1MfTO+Jh4MLho6cdGEqr4/kQu25UorMoZ5rw49iYkNz6z4aZtGlIH1CzkjAXG
         BVFIRsvfSkeM2zHLKjKZ4xV745xRpTRnnwhdPhISQmtAmRASRgJfbL9Jiz5QLKLDV/7+
         P9Ke7A/stfNh9ROyqy2knMIGXqfr5tB8YmMWurJJ5v0bgWyELYCCBjB3c4yZobW3i1S6
         3yYkE0kywXB2dxTZAew9SnanWWjva48xj2m1KdFnPN2WXvYay4BXSSW+Stiu8mZHU/O1
         0UC0jk6fErQv8fppMApIeI2xv+0fHBrS2ezEKhJBPrSieppTQqY/2OXxiS3GL/AIetcN
         zsAA==
X-Gm-Message-State: AOJu0YwnUOf16muJK60hkEgnLSyBnEKDa//3aD29N/navg7vF6YJHOJ1
	CC/bm3yBqfOPPMRikyHPq1oSD069daUZB/G7nKfVCyatFd2b9HsUV1eC8fOj5biLja0ovEphh87
	/4SIUns0=
X-Gm-Gg: AY/fxX5lgJCywUpproGJsgichMOGC0hxiYBXhWSQkaxOYeRe03ouZuVNX46HfB0qgy8
	sU/yDuFLQe+QXzN8g6iQKhph1euZWjuyb4sRwnN9xDDbneI0HiVLuq6Q9E+j7fIEAM60VD/Y+H5
	5oU/0xx/G9s08haLo0t7kfqKoghN0jLXgdrWLYrF0HBJmvu9aGJlcjEFHqd5wSVuZF7yuUX6I+O
	wvmc5A5b8UsfF/eE0bYcPpe/ttrWey1n3CDOg2VHngqAvyLK77ODfduCPAc5yEB1lEmeYD/yho2
	rQW2nx5/WvQgA5wRv5p/e3wTAR/o4nFWdHjg9hKhLsZL0UOChIQwWjbflJeaoucc1SLoOSUwy/Y
	a2CJ30gYU2Jm+BjBMmY0W+f4ikEQBY35k+gXpIYqV6QKVasSnI2/3xfsFrTnvF9u+paN8nvlWEM
	w5itAVSzbfNA==
X-Google-Smtp-Source: AGHT+IGWtgoNj/IOwcHucr7vDFX1//Jb58hlHTAdJlYtUnvDZvEyLs+0EzI/eaz3OtMluvlRfr0QnQ==
X-Received: by 2002:a05:622a:1925:b0:4ed:627d:49fe with SMTP id d75a77b69052e-4f1d064f3d8mr189330721cf.75.1765906501964;
        Tue, 16 Dec 2025 09:35:01 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-889a860f8basm79310456d6.56.2025.12.16.09.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 09:35:01 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	memxor@gmail.com,
	yonghong.song@linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH v4 0/5] libbpf: move arena variables out of the zero page
Date: Tue, 16 Dec 2025 12:33:20 -0500
Message-ID: <20251216173325.98465-1-emil@etsalapatis.com>
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

v3->v4: (https://lore.kernel.org/bpf/20251215161313.10120-1-emil@etsalapatis.com/T/#t)

- Added Acks by Eduard
- Changed jumptable sym_off to unsigned int for consistency (AI)
- Adjusted selftests to ensure arena globals are actually mapped in (Eduard)
- (Patch 2) Adjusted selftests that were failing because they were expecting the
  now removed "direct map offset" error message

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
 tools/lib/bpf/libbpf.c                        | 31 ++++---
 .../selftests/bpf/prog_tests/verifier.c       |  4 +
 .../bpf/progs/verifier_arena_globals1.c       | 87 +++++++++++++++++++
 .../bpf/progs/verifier_arena_globals2.c       | 49 +++++++++++
 .../bpf/progs/verifier_arena_large.c          | 21 ++++-
 .../bpf/verifier/direct_value_access.c        |  4 +-
 7 files changed, 179 insertions(+), 22 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_arena_globals1.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_arena_globals2.c

-- 
2.49.0


