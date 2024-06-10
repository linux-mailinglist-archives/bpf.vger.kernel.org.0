Return-Path: <bpf+bounces-31758-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A431902C38
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 01:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DB891C20D55
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 23:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B7C1514E4;
	Mon, 10 Jun 2024 23:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qg3k++eZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8141BC39
	for <bpf@vger.kernel.org>; Mon, 10 Jun 2024 23:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718060936; cv=none; b=Co6KoXd9nL12guNtr6Z5A00FLqK6OHwKHipM4CIDwAdmNLQDbI46Xg7D8HWe+DhnEXW4DNwCae5A/Pnt/pCKjb64tWHqQ7yuezas6xvOYjjWuXFs+gEEcrx2St2+SwJuPq3oD0gAeIlZLJjC9j7/B1qFsK7CVPF+zmN5lo/yvPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718060936; c=relaxed/simple;
	bh=XrPJ5+hiRTig+OHNk4w7mZ/umva14qDdsEQzYynxIpk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aUQ/BOsestg+jbY4AUTzWpzG+LL833NUKthrMVmiChyrgwLINN0b+udB9TQmiIjJs8eYl70Ht2DcnEM0/P8zw6IpeCHWXFTQPRIly2lJIU7sgNc6ug5WZUoVQ4bnLXFSUOjXiSxwDPMzvC6xYCo5nWbKSCnvFbhUGBs5hOKWqNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qg3k++eZ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f480624d0dso3341035ad.1
        for <bpf@vger.kernel.org>; Mon, 10 Jun 2024 16:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718060933; x=1718665733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F8y5OUWG9fHdA77oHQ6pueWO8KZduV48Svu0fKwQNlw=;
        b=Qg3k++eZ9qWMd3d5ZUpAQ4JCKL5nOdJD1yAsFGBEQWecii3uMKfRk1t3hGeKUK6ZQ4
         kC9dKx2rKgguvbcOsAJ8mlvYHKnlG9E4KpkMYYcRV16FA8UN/T/zcKQNizU5ryTfMjdT
         NJqXirjyKoE7XzgINnuyq9+L4av+0OA5gMkqmkwhTL5qIYXha5PxyD72X9YfaIhDEftZ
         ctcuzCQXy8iHwpVWmlsYmtfXjYxS5lI0nSqe+nIMEPsG8FQlWIpTVRMlus7Afz43pGXS
         z7f+/cJ0aXV0J9Hks3FPqJFm688jh3BjKFa0iMgYBR8XIRgWqXFELWAWKJtMIKftes+P
         JXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718060933; x=1718665733;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F8y5OUWG9fHdA77oHQ6pueWO8KZduV48Svu0fKwQNlw=;
        b=aClQ19S2jz+GjxajgnyHyBJFedKYHQbEynjtLeSbp8wFzV4/IMlG/IB20kvIfwBwFE
         dW/qWe7eUipV0xqnFh3rHLrhFDXEo3pWOE9Ot+nzLdB5NAG/f31GPdd2sh/xRL/lH+Gx
         dxzUcpz6declveZBW9ry7A682PABmFdYo3lpFdyMsVXKIFHFEriZ49AYdqrkryByPc8Z
         mho5dn7mTXDbDl7PL4c2XRMOwim/Q21WLEIs/JJ8p+4S6nkYPUnec1oJkfiZu6/k9I/P
         jlUIUB+swo06SPz+elSroDAamDFtY8NOPKS6aQUYUrl815YNe8HRYxHmsPZr8mzKAPLn
         SjPw==
X-Gm-Message-State: AOJu0YwkSJ7P4wit+6LvxMJfn28oRtyXu7YwuO0VZ47QdOCIFilYL1e6
	pxDYjonXrFAV/0x0TNl7fZ+MhW1weAvTHUkVJ6BdROfTtfADRzi5jdki4w==
X-Google-Smtp-Source: AGHT+IFfL9v3yS4yz1GsEZ/eZMMwTRyUIxPLwZCAisSrXbjzV5KASnp3GfsAvrHgz+Lu0RrDrnykow==
X-Received: by 2002:a17:902:d504:b0:1f7:195d:8e7d with SMTP id d9443c01a7336-1f7195d912fmr38517515ad.54.1718060933163;
        Mon, 10 Jun 2024 16:08:53 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:cfaa])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f72477b312sm8610405ad.92.2024.06.10.16.08.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 10 Jun 2024 16:08:52 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	kernel-team@fb.com
Subject: [PATCH v2 bpf-next 0/4] bpf: Track delta between "linked" registers.
Date: Mon, 10 Jun 2024 16:08:45 -0700
Message-Id: <20240610230849.80820-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

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
 kernel/bpf/verifier.c                         |  89 +++++++-
 net/core/filter.c                             |  24 +-
 .../testing/selftests/bpf/bpf_experimental.h  |  28 +++
 .../testing/selftests/bpf/progs/arena_htab.c  |  16 +-
 .../bpf/progs/verifier_iterating_callbacks.c  | 208 ++++++++++++++++++
 7 files changed, 353 insertions(+), 28 deletions(-)

-- 
2.43.0


