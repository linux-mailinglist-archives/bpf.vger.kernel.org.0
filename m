Return-Path: <bpf+bounces-32011-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B66B906128
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 03:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE0EE1F22683
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 01:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDD4DF71;
	Thu, 13 Jun 2024 01:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FB28A8q5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50131182C5
	for <bpf@vger.kernel.org>; Thu, 13 Jun 2024 01:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718242702; cv=none; b=CTi9WSQ9iD5BblNqs0gO7ZK/yW4X90TtwdM43IwPfPc53mj7nstE4b0z0htYt+0XFn45cnL50SB/hTLBDYOJ8mFnUwiE3Ewxz658WvQi6NeBgAo1pnMYpNBsbxNfhphO30G7ygwSTwOtSzMq+mCGUV2B6tt7hB/PKwmn6CWzGMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718242702; c=relaxed/simple;
	bh=junRdX8XxGuvhWbLqwhalOG9U7TjChQijY5t0QDwpIY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X+/efk1K19uuOvWUUCDDNMOY2fNHoyKlkmmCaRCCAoHWaWoSxzp0Uv9zWXYINjCNK1tSTRY7RPKHbcXNE7CDkGaQobNFRw7jl2+Cg/i7lVXcDfKEsHLfi4LM5eDxuNUH3gy3e/Bg1pufcmYuzLLsji5WaCfMqh4dfpnR1rj9ZGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FB28A8q5; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7041053c0fdso340582b3a.3
        for <bpf@vger.kernel.org>; Wed, 12 Jun 2024 18:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718242700; x=1718847500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GMITcN+zpi8+wx3p1pVnd6geN1jHouVGDyJHUCYT840=;
        b=FB28A8q5S25gF6om3LlMeROIVEFDCl5CskdnoDzHh7Sl6Iyp6L7FKq+LYXNRXATQ8H
         qLF+feD05g5L/BQkitfzdD/3xj7eEZAMdJpOWW6pOLwaMOudMAI9O8wmEGbsDdVr0AxY
         tplVs/JmmX+siE69gnBFVXZ9+7DxMAYCoea3eTr7F8O6LZqcr4736rSpiR5AG+mnSAXB
         mKqNovruQr0qS8AfW1Ft+f4hHdTx4tQ3tNJL84sCfoiKr/8Dbmjqi3ywhUvVptgeE2sf
         2F1dI7Yt4BUgXKRf29MR3GIqrsiyyPC7UdwX5/P/Ld0ucl+Y+nWGmPi/1+ZHg1w0e0T0
         QIwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718242700; x=1718847500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GMITcN+zpi8+wx3p1pVnd6geN1jHouVGDyJHUCYT840=;
        b=nQoVYXkUL8kKyG0hvNQfpi47n7RqUym9v8yjXcf4XznZxn3YdVKIczm7zjzUob9Qj2
         lJ8Nkw2ZgxGyQgq83BZXzk5pVkmaJTO3Bkb5VKkHx0b/I3sYnDrXSfOVa5mxjnTUslt0
         q/9oLOpw0wRow/3gMj25AqqfmIR/Qm4k5mMJNN0Ei0s0aP/AiY64vWH5hm+L1glZJ6jz
         y6rk6g6jm7+qLd09juqYCdytk4o/a+Aco26Ceb76n4FVU8mEjU15NHiMy/HVu5m3RzDn
         uawfHcfuPPnlC83tdDdWc7S7BEPE0N3Xte5kvbAFls5btzY0dqYMxXzS9GSHmp/1A1Jx
         NPZg==
X-Gm-Message-State: AOJu0Yy8XTjyT3zMiXBOg9Ds7RbQ51xe/91fKRqVOhaj8Tn77xK6dtZO
	cvlPUnI5BWt3dwj3dsMnA2yvIfvcUt5HOeb2rRh6ku8xXi4PERLLnvy+kA==
X-Google-Smtp-Source: AGHT+IH4Ktp1u13n2jECwJ/I45GoBwRdSiYHnSqryUcmbRLJNxCRbZMBa06V7al/MEIZhDqMNQtynw==
X-Received: by 2002:a05:6a00:23c2:b0:705:9748:7ba9 with SMTP id d2e1a72fcca58-705bccf6760mr4520686b3a.0.1718242699775;
        Wed, 12 Jun 2024 18:38:19 -0700 (PDT)
Received: from macbook-pro-49.dhcp.thefacebook.com ([2620:10d:c090:400::5:b914])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb6b4fasm210692b3a.150.2024.06.12.18.38.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 12 Jun 2024 18:38:19 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	kernel-team@fb.com
Subject: [PATCH v3 bpf-next 0/4] bpf: Track delta between "linked" registers.
Date: Wed, 12 Jun 2024 18:38:11 -0700
Message-Id: <20240613013815.953-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

v2->v3:
- Fixed test_verifier due to output change
- Fixed regsafe()
- Add another test

v1->v2:
- Fixed find_equal_scalars() logic. off,id,add_const flag must be
  preserved.
- Fixed mark_precise_scalar_ids() that should ignore add_const bit in ID.
- Fixed asm test and added two more tests.
- Gate the feature by cap_bpf.

v1:
Compilers can generate the code
  r1 = r2
  r1 += 0x1
  if r2 < 1000 goto ...
  use knowledge of r2 range in subsequent r1 operations

The "undo" pass was introduced in LLVM
https://reviews.llvm.org/D121937
to prevent this optimization, but it cannot cover all cases.
Instead of fighting middle end optimizer in BPF backend teach the verifier
about this pattern.

The veristat difference:
File                                Program             Insns (A)  Insns (B)  Insns     (DIFF)
----------------------------------  ------------------  ---------  ---------  ----------------
arena_htab.bpf.o                    arena_htab_llvm         18656        747  -17909 (-96.00%)
arena_htab_asm.bpf.o                arena_htab_asm          18523        618  -17905 (-96.66%)
iters.bpf.o                         iter_subprog_iters       1109        981    -128 (-11.54%)
verifier_iterating_callbacks.bpf.o  cond_break2               113        128     +15 (+13.27%)

Alexei Starovoitov (4):
  bpf: Relax tuple len requirement for sk helpers.
  bpf: Track delta between "linked" registers.
  bpf: Support can_loop/cond_break on big endian
  selftests/bpf: Add tests for add_const

 include/linux/bpf_verifier.h                  |  12 +-
 kernel/bpf/log.c                              |   4 +-
 kernel/bpf/verifier.c                         |  95 ++++++-
 net/core/filter.c                             |  24 +-
 .../testing/selftests/bpf/bpf_experimental.h  |  28 +++
 .../testing/selftests/bpf/progs/arena_htab.c  |  16 +-
 .../bpf/progs/verifier_iterating_callbacks.c  | 236 ++++++++++++++++++
 .../testing/selftests/bpf/verifier/precise.c  |  22 +-
 8 files changed, 398 insertions(+), 39 deletions(-)

-- 
2.43.0


