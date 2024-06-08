Return-Path: <bpf+bounces-31625-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED38900EED
	for <lists+bpf@lfdr.de>; Sat,  8 Jun 2024 02:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B674D1F21F6A
	for <lists+bpf@lfdr.de>; Sat,  8 Jun 2024 00:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F36D6125;
	Sat,  8 Jun 2024 00:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YwDakmbK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100DA81E
	for <bpf@vger.kernel.org>; Sat,  8 Jun 2024 00:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717807493; cv=none; b=csYlwfp6xlCsEK0DS5h2ujR6L8iySGO/nvNx0+qD83tXgI8dWzYoJe/mMGA+yGJZnIHVKwxTft6/YUGQ8MAc+jtpYfurqDmte0OcYo1sz+eHuIGdvz29YjdC46BPxIfr59uTx8lhf9peZ/BUs2G8kCcOZgzUoZBiyIXjBljti38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717807493; c=relaxed/simple;
	bh=9TwIyCPWpmXJjHKKg8VgmwoBbvu4mJJCJ/qlbmmChj8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZRLE64D5E4n0XMOl4nL/uiIDKD1BsMF9zP4CthtBgKTNoCZCgZJocYBmq7raeKoUDPASVEIz2WSSSi7fC67/XH+dEY2Qk4xCGrtHGTQ/PMPHNmgruI4tJBzZX/3nYqi4qziunTf1gSDmVzRmIpGnGwKy58gzig5yWUAPhzRYcrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YwDakmbK; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f692d6e990so26764725ad.3
        for <bpf@vger.kernel.org>; Fri, 07 Jun 2024 17:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717807491; x=1718412291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fWOCVpKDv1i3dHIEFscg6t/UNTjiT+VAY/Zl1V0pMfM=;
        b=YwDakmbKKg55EdZU+JIQds4f/r8Qgf+aMnjGrJwVe6Z7+CLC0qcDo/yamIeqMSvZXf
         SpZPK67uk3q7NPJLK1Vn6haKHfQqX8yCpiAbIIR2KZxxp6CfMWuQVAI/GhrhDNugLf5k
         HoM5L3OcHKPdqLtQFQhB0+FrEl84uFi6jMsB3Ao6+HXhA88kS2M5RnEkMkEUe4oSJieT
         xJf8uaj7pFLFrku8j2kvPwfolaM49xGz/6xAqrk+gi7Kh+u991Gpu0s2fXy2wk7RwDsl
         jknYwLwTMD/vNKyXEhKj4cx5kVekSTWMs38fKWH+nVYEakeyx6I0+ojuhVdrXdr52yzL
         Nq5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717807491; x=1718412291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fWOCVpKDv1i3dHIEFscg6t/UNTjiT+VAY/Zl1V0pMfM=;
        b=YuKGYWCUONBgn4ig522Y+t1poS6DOOZonuUgrFrraVFytRPgJF6E66+Tnth5+MpLBq
         eFHYSy1ui9Sm/ZB5ZleHS8tuH+57jhsAA+mH59B5Y89ptFkwVHbwmFB+nX3qPMV3uSdm
         I/tMuefVN78FYwKSxiYqk6LhXPyZUMR6oL6LQ80E3tTAAOx5c9dkHwj8KW5pCPtt6Vyu
         49gjuOo7cGqe6hkKPuNaEgV4bL+WrWUAPIcFxYnMxZwbbX1Spl/QocsQWOaXwu+Pjwqa
         Fl/iE5T5jp2GMTC9vXedtzUqvJpQKwIVrDQlpZ26+/Na9XkJAG0bzV+ShTW8fns0zadb
         qSrg==
X-Gm-Message-State: AOJu0Yx9AX7d4nSdlOmbokE1tXJbGy60eKDoHx/Tqt0Mq3LhU0OQlHPQ
	hPLkKz9w0Kpu9dIQmowOwq+kUOx3GwZ48yVEWblL0JlIqx73HALf+XecAw==
X-Google-Smtp-Source: AGHT+IHWsJxQaqPTl/ukpM6goW6gFET4ce5UUyYF5AZuMPKOWbIQ9BdPCRTRcILiWw9cgKMNSJZsMQ==
X-Received: by 2002:a17:902:7b89:b0:1f6:1c5f:e089 with SMTP id d9443c01a7336-1f6d039b122mr36875625ad.60.1717807490550;
        Fri, 07 Jun 2024 17:44:50 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:81a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd7e03e2sm40421005ad.188.2024.06.07.17.44.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 07 Jun 2024 17:44:49 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	kernel-team@fb.com
Subject: [PATCH bpf-next 0/4] bpf: Track delta between "linked" registers.
Date: Fri,  7 Jun 2024 17:44:42 -0700
Message-Id: <20240608004446.54199-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

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
arena_htab.bpf.o                    arena_htab_llvm         18656        768  -17888 (-95.88%)
arena_htab_asm.bpf.o                arena_htab_asm          18523        586  -17937 (-96.84%)
iters.bpf.o                         iter_subprog_iters       1109        981    -128 (-11.54%)
verifier_iterating_callbacks.bpf.o  cond_break1               110        121     +11 (+10.00%)
verifier_iterating_callbacks.bpf.o  cond_break2               113         91     -22 (-19.47%)

Alexei Starovoitov (4):
  bpf: Relax tuple len requirement for sk helpers.
  bpf: Track delta between "linked" registers.
  bpf: Support can_loop/cond_break on big endian
  selftests/bpf: Add tests for add_const

 include/linux/bpf_verifier.h                  |  12 +-
 kernel/bpf/log.c                              |   4 +-
 kernel/bpf/verifier.c                         |  90 +++++++++--
 net/core/filter.c                             |  24 +--
 .../testing/selftests/bpf/bpf_experimental.h  |  28 ++++
 .../testing/selftests/bpf/progs/arena_htab.c  |  16 +-
 .../bpf/progs/verifier_iterating_callbacks.c  | 150 ++++++++++++++++++
 7 files changed, 298 insertions(+), 26 deletions(-)

-- 
2.43.0


