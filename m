Return-Path: <bpf+bounces-37833-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51EA695B0B8
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 10:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD158B2505A
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 08:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3790417084F;
	Thu, 22 Aug 2024 08:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FagwdOe0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A61216DEDF
	for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 08:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724316090; cv=none; b=Gemb+KQDTb0tVcNSm7+ySKl+PqCgCp+aCgWg0NYq6v3nwGzFl2ZmnWvdRnAS+HB+5FkALXpB+tv/NaGbV7N/oljQwJh4rwPbz7tJQd0kejW7zElQ8AvV9Hy4R/YLL2xIvesXzyW77hUP8u4JzxrVs4zFn74vjjLAgrFPxP0UxDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724316090; c=relaxed/simple;
	bh=HdeVYQoaA4xHbwCAD6mS9WoTFVa2JgR6eIFSiz5pQHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eSJjtcfaO8QMjyVbwyUA17f223uqsKDvohAsqAbxGFXvVbvNUcOLp5+m872OVvvFIQ6QupIAKNkVFiCjnWDDngDFqbkdQsJ9WWizGa/m48fsjV+UIs8e6mC6fgOrQYFayKkNekOdnQN3VaNb1cMrAEyT4PNp8tnZSIqbCc82Wko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FagwdOe0; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-27012aa4a74so281227fac.0
        for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 01:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724316088; x=1724920888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/IPYRKXvcgxoiZL17SrnXVzhEJkqOA8RnWDy6vPB1h8=;
        b=FagwdOe0rwZlUI9Tz/FavrUACyHVOJZeU5Aigyh+GKQihm3XZqpn2Su0u1K5LjCL0A
         6GKcZE4B/b+W7okJiEOya6vOAmh45CHRk79zWZOVYMgNBkrSX5fkZNrVa0JdonOwdrl7
         zbeN8o33CW0jHH5hyLTQ/y1sTFO5VfpKH5md/SCHk8mUg6leQkNhl+O93zC3hAvnjUgE
         XVzZRF8A8/bnRRTy3Xk2/yrCA6Dg35U1kQYTaqwaXN3zJYWVG/kgWClale/tmOZwuya2
         hOgGR+/P3Ron0rc9qIiPPBmvWQvZ8nII0P+J6uldLD7mMy9K+bOlflpAZaqL6E9zBa0G
         41Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724316088; x=1724920888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/IPYRKXvcgxoiZL17SrnXVzhEJkqOA8RnWDy6vPB1h8=;
        b=p5Y+rmJeKhdT0kbLTvoBDQ/hGb2Uc9fp65MbNVXjI0zh0mTJxQ6p3hYyVKFPuiz52Z
         c7EPLaMupm9+sObKc+K6aQdCy7PZ4+MvOhbwjdmt0fAIRHr2rzULOc54kD4UnVAR0hH9
         grpQkL4Lecnx79kfFNh5nYm19effYDNRFQ9F8+HIUi0LRhwvkWC/Ofksg3izI6YLwJTE
         KeIRycVXhvYCMoJ1ViR7actQkJal75ii6FTADgl5OZiyMSlVn0HaBcrbh+XFi3kQMK7r
         HVK6PK5X75U9kXD0Qxh5Gv1oU1CjY04Odl1SicPbJEC8Or5qMVitTrd87UgYkjdklfMi
         LGdQ==
X-Gm-Message-State: AOJu0Yyb1jvESZAEEVu14LHrLsIn8T/QyzOLfo6wyZi4UkuqQz0Re6UB
	DH7PwqOiw5Jw/Swt/C2fKU2llXLjmRT5aPDl8Et25MzZtrYS5ORIB85hYhQW
X-Google-Smtp-Source: AGHT+IGHQwEXdQqbvCvB9miTKwBL2ZdMGxSwHJC5mB1qbQ2Q0utraRx4O0OH01RCLmmCwZm9KeYKOQ==
X-Received: by 2002:a05:6870:d146:b0:261:1deb:f0ee with SMTP id 586e51a60fabf-273cfc5666bmr1434909fac.13.1724316087926;
        Thu, 22 Aug 2024 01:41:27 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71434340449sm881692b3a.218.2024.08.22.01.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 01:41:27 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 0/6] support bpf_fastcall patterns for calls to kfuncs
Date: Thu, 22 Aug 2024 01:41:06 -0700
Message-ID: <20240822084112.3257995-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As an extension of [1], allow bpf_fastcall patterns for kfuncs:
- pattern rules are the same as for helpers;
- spill/fill removal is allowed only for kfuncs listed in the
  is_fastcall_kfunc_call (under assumption that such kfuncs would
  always be members of special_kfunc_list).

Allow bpf_fastcall rewrite for bpf_cast_to_kern_ctx() and
bpf_rdonly_cast() in order to conjure selftests for this feature.

After this patch-set verifier would rewrite the program below:

  r2 = 1
  *(u64 *)(r10 - 32) = r2
  call %[bpf_cast_to_kern_ctx]
  r2 = *(u64 *)(r10 - 32)
  r0 = r2;"

As follows:

  r2 = 1   /* spill/fill at r10[-32] is removed */
  r0 = r1  /* replacement for bpf_cast_to_kern_ctx() */
  r0 = r2
  exit

Also, attribute used by LLVM implementation of the feature had been
changed from no_caller_saved_registers to bpf_fastcall (see [2]).
This patch-set replaces references to nocsr by references to
bpf_fastcall to keep LLVM and Kernel parts in sync.

[1] no_caller_saved_registers attribute for helper calls
    https://lore.kernel.org/bpf/20240722233844.1406874-1-eddyz87@gmail.com/
[2] [BPF] introduce __attribute__((bpf_fastcall))
    https://github.com/llvm/llvm-project/pull/105417

Changes v2->v3:
- added a patch fixing arch_mask handling in test_loader,
  otherwise newly added tests for the feature were skipped
  (a fix for regression introduced by a recent commit);
- fixed warning regarding unused 'params' variable;
- applied stylistical fixes suggested by Yonghong;
- added acks from Yonghong;

Changes v1->v2:
- added two patches replacing all mentions of nocsr by bpf_fastcall
  (suggested by Andrii);
- removed KF_NOCSR flag (suggested by Yonghong).

v1: https://lore.kernel.org/bpf/20240812234356.2089263-1-eddyz87@gmail.com/
v2: https://lore.kernel.org/bpf/20240817015140.1039351-1-eddyz87@gmail.com/

Eduard Zingerman (6):
  bpf: rename nocsr -> bpf_fastcall in verifier
  selftests/bpf: rename nocsr -> bpf_fastcall in selftests
  bpf: support bpf_fastcall patterns for kfuncs
  bpf: allow bpf_fastcall for bpf_cast_to_kern_ctx and bpf_rdonly_cast
  selftests/bpf: by default use arch mask allowing all archs
  selftests/bpf: check if bpf_fastcall is recognized for kfuncs

 include/linux/bpf.h                           |   6 +-
 include/linux/bpf_verifier.h                  |  18 +-
 kernel/bpf/helpers.c                          |   2 +-
 kernel/bpf/verifier.c                         | 181 +++++++++++-------
 .../selftests/bpf/prog_tests/verifier.c       |   4 +-
 ...rifier_nocsr.c => verifier_bpf_fastcall.c} |  81 ++++++--
 tools/testing/selftests/bpf/test_loader.c     |   2 +-
 7 files changed, 192 insertions(+), 102 deletions(-)
 rename tools/testing/selftests/bpf/progs/{verifier_nocsr.c => verifier_bpf_fastcall.c} (89%)

-- 
2.45.2


