Return-Path: <bpf+bounces-53166-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FE8A4D528
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 08:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFE5A7A1845
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 07:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DC51F9A90;
	Tue,  4 Mar 2025 07:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXtYUbx7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDB01F7911
	for <bpf@vger.kernel.org>; Tue,  4 Mar 2025 07:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741074220; cv=none; b=qn/KGi9YIzrS3mkdcYRqWoJidiUaPW5Ot7Xz0s70vONIrQWfxWcC4mbMcTJH22ia7Gy6d6REoQ+O1SYYtC7Ismh6kmyjHYDPBs2GBysNfXjAZ3kjIVA9t1tH/V9QrIEAE/QBk2RgjXBdIqMS0NV8CdmoTFoMRHQfrtmYN9wZXRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741074220; c=relaxed/simple;
	bh=PCQdLRxjKvHFO1yqXwfCwogHxixDx6gynApK78++UsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u8H/bPVuoc1tsUaX+0wci9t0l7/fNutPtJTg3AMQzQK7qMYgmAooZpTSUAJUypuj4M7OjlIY1gz5DtGivQ92fZfaphyQYIj1COHvVl1SOtorwDTD7blEp0CRfCXYb1rEkr0yL1yEtyDvgzqDSkIjOfY8a+hyEbCOPH/34MSRRwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OXtYUbx7; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2238e884f72so42817185ad.3
        for <bpf@vger.kernel.org>; Mon, 03 Mar 2025 23:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741074218; x=1741679018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V/0dbNPwpjW9vvj7nYaWsADN23DLvBd0w+nLTNBlLA0=;
        b=OXtYUbx700Fjr7MIlf6/aPu0CVSsfnvjzqbwIGUxqkI7UPn78EXuPjedi2EMrFHRCY
         vkdnn4n6wr75GpNh1nfzvHJx3kix4ZKLpe5lf+kXRwNMIF7LA5jYvZWXMZvLqoMAZX/r
         Q8NRzIpweG+n136GeMwsY2TwrdFEA+/faNzrEMjfBoAydhCpJlyisyifEQlZRWy1bljp
         M6aRU6OP7Q/i3DieiV5w51SW2aKhAW+ihlh6llehO/oXkI4X/GzsaMWWzl02W0FvflOJ
         TX04tFLBFzrStYdFwUBp123JrcE3fCXFMOpuQbYqjsQRRx6Fv8EFAD5W1w+Q4ffN+Tzf
         LmQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741074218; x=1741679018;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V/0dbNPwpjW9vvj7nYaWsADN23DLvBd0w+nLTNBlLA0=;
        b=id+f9bi4aBWqHpi4xKUDNMdtKH76IIoHaNNM7u92oPYLcvF35ypGOjxcGb50nF+SAO
         xDU+peV8lFFeqZlJ206w61B50wprV0tadm1PMdbrU7kTd01tZfQy60juMY3tSxgGcBxo
         TVFj4pGlmZpxpi+44kZ/jpXN5JfRe+Yn5LK0jUacgUoTUHf/f1+4yX2CRBO+17v4cyqf
         0bdWNue33n/C1mEF0DIc3t2PbTENuBq1aOw/GmJ5Z8E0aE8WYe/9Liqg6V9qzEc6GCKd
         LEDSE8EQOJUMAoyBGt+Hjtbj23koulhXPAmIp6PCSwDdv3SUASqvXzoEfKSC5n0Gz4tf
         lgHw==
X-Gm-Message-State: AOJu0YyqzIPawM6G03FtnxHlQptIsVsJmjvyOz0rXnqELrO/VxSet9ok
	t0usWnJ+zU7JScqr2vcg2PlXJoOGhDgqv853LOEM+7GZdrCZk9ViMBrqfg==
X-Gm-Gg: ASbGncvtnBUK4rv24Cyxq0QIjWgvU0BoznzwsJbiYIQNc86bEBaMgegJSS4R5d8w3tU
	sg0Z84mjf3i1Z0bmJSgGvC5NxAwr7ac1Hmf3AKnO1WTjzhloYaTu7A44C9aSDFh0GU+MpMaBS8Z
	VMPXBQu9guheg3/HF5GFMcsN9UvLXDSQb5T5j2IKk1d1K/w96NZmg798+6EQRauWOyzk0Jfh5Hh
	ahJzBAF4Dui6Bfky/OJen6XI5KvI1YPlHGXhlltXKsxS+SqvgcMrUdYW5lVsM0v0nK2Wb/26qeX
	/uZrfrO5uUUJ8MQr08szd3Cy61NmkuXrwPGQm4wp
X-Google-Smtp-Source: AGHT+IEmnRlyKpxHuzRODTU/Xvac97NvoC0WMoppKctv+WSaujOQobrKLeRn0+oI1I8S96jcK78hyg==
X-Received: by 2002:a17:903:2ca:b0:220:c63b:d945 with SMTP id d9443c01a7336-22368f75627mr275044515ad.14.1741074218092;
        Mon, 03 Mar 2025 23:43:38 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2235050d7c1sm89545125ad.198.2025.03.03.23.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 23:43:37 -0800 (PST)
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
Subject: [PATCH bpf-next v2 0/5] bpf: simple DFA-based live registers analysis
Date: Mon,  3 Mar 2025 23:42:34 -0800
Message-ID: <20250304074239.2328752-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch-set introduces a simple live registers DFA analysis.
Analysis is done as a separate step before main verification pass.
Results are stored in the env->insn_aux_data for each instruction.

The change helps with iterator/callback based loops handling,
as regular register liveness marks are not finalized while
loops are processed. See veristat results in patch #2.

Note: for regular subprogram calls analysis conservatively assumes
that r1-r5 are used, and r0 is used at each 'exit' instruction.
Experiments show that adding logic handling these cases precisely has
no impact on verification performance.

The patch set was tested by disabling the current register parentage
chain liveness computation, using DFA-based liveness for registers
while assuming all stack slots as live. See discussion in [1].

Changes v1 -> v2:
- added a refactoring commit extracting utility functions:
  jmp_offset(), verbose_insn() (Alexei);
- added a refactoring commit extracting utility function
  get_call_summary() in order to share helper/kfunc related code with
  mark_fastcall_pattern_for_call() (Alexei);
- comment in the compute_insn_live_regs() extended (Alexei).

Changes RFC -> v1:
- parameter count for helpers and kfuncs is taken into account;
- copy_verifier_state() bugfix had been merged as a separate
  patch-set and is no longer a part of this patch set.

RFC: https://lore.kernel.org/bpf/20250122120442.3536298-1-eddyz87@gmail.com/
v1:  https://lore.kernel.org/bpf/20250228060032.1425870-1-eddyz87@gmail.com/
[1]  https://lore.kernel.org/bpf/cc29975fbaf163d0c2ed904a9a4d6d9452177542.camel@gmail.com/

Eduard Zingerman (5):
  bpf: jmp_offset() and verbose_insn() utility functions
  bpf: get_call_summary() utility function
  bpf: simple DFA-based live registers analysis
  bpf: use register liveness information for func_states_equal
  selftests/bpf: test cases for compute_live_registers()

 include/linux/bpf_verifier.h                  |   6 +
 kernel/bpf/verifier.c                         | 484 ++++++++++++++----
 .../testing/selftests/bpf/prog_tests/align.c  |  11 +-
 .../bpf/prog_tests/compute_live_registers.c   |   9 +
 tools/testing/selftests/bpf/progs/bpf_misc.h  |  12 +
 .../bpf/progs/compute_live_registers.c        | 397 ++++++++++++++
 .../selftests/bpf/progs/verifier_gotol.c      |   6 +-
 .../bpf/progs/verifier_iterating_callbacks.c  |   6 +-
 8 files changed, 829 insertions(+), 102 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/compute_live_registers.c
 create mode 100644 tools/testing/selftests/bpf/progs/compute_live_registers.c

-- 
2.48.1


