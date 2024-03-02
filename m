Return-Path: <bpf+bounces-23234-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CFE86EE0A
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 03:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2D471C21295
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 02:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398A67462;
	Sat,  2 Mar 2024 02:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSZCyUjP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708326FB5
	for <bpf@vger.kernel.org>; Sat,  2 Mar 2024 02:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709344817; cv=none; b=h+xjUA+9gVMwo58Enxzg5ZLzQt5oCKNQtUcC6pKRGAQnyswrtDVGJhGgPIqpzL7AWAESZcbXGB2GGaeBt/lKLrMYwcOoUVUnhOq9h8ZwOwCa7b3laF1PevnFeC2Eeu0YL688G0omS3dhHWFPi0QVHRBMTScFgq65cWusotkhv0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709344817; c=relaxed/simple;
	bh=DBkmUZm1FspsuiBk8iCDcoTgAhLaWdKZomyvm5qVjMs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K5hbTKQvctO5mlB5Me67RqeXNj4U5KYpBBBLm9KB8C02dxexhaIxA67s2VY9IPLfRvfetAn9o8VWLqzAentz71tEH9rBugzNIe3V5vR42e0goQ4173rnhSh/D30tr7HjhokTPGJBYUKUu24FKb9Xd1Mem991DiDOci2494DPZTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fSZCyUjP; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5cddfe0cb64so2037244a12.0
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 18:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709344815; x=1709949615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SvUQkjQOBjNDnWI5xx0CDg+aP2D9UBcURy5Rh1nQCZM=;
        b=fSZCyUjPPC2I8R6xBH7DD2YJmbdqmtHUffj5Or4jhSWfHx5ixAYqJgD8ATAw13rZhZ
         crjaJ9kB5r47MaCqei2DWFvQy8PTI1lC3PJGbGRsl1QpixCJRRWAr5Obing+XwbRTopK
         rW9z3JKY2bxpIoHoU8a3lSLNQvAJCFSdNGd5qnm0cEXJCTm9f8mU2ydaTMO5e6NYSfZS
         3JRxNGPp0ikRdEDdS4jDt/b179kUgK6GKrbtNjiNLWHCY8XwExaqDdC4WBH4EHUnEG8x
         b/ukI8VXYm4nN71S2ZSV5pUJ+/7ZAXl3DuZFL2Cw4FoejPkihU3Fm3795hQ8upfGj2sX
         345g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709344815; x=1709949615;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SvUQkjQOBjNDnWI5xx0CDg+aP2D9UBcURy5Rh1nQCZM=;
        b=J3KbmPRh3UY32gAurKUmbtuzTTiRpV53DdjqyVGPRdqCMZqH4j4uXpI7U+WBF19CAZ
         WFhP8Eomhrd8kJ0Bi327A+xGLAwLK93MsStPWYd7KHwE9+zt4w2tpMX464MDjfc4Prg6
         USrzVDeiKaC8FcN+4VcqzDA3F2HBfCADlLEYPgBxz+CKgui76A13LLtSahjxnh4K2mrM
         ST+0QFj8qJLRtzpoakCmVPyXX7pAk4K1JRpth/4x9eUpDHo0tsIRQWsB0z33qbFEj2EO
         ohvHYkrp7B+J1IMcEc2elV4TthkvAXjL+UKj0v+Z3hNw61vSx6yppsW5veu7P99rb2KI
         3Diw==
X-Gm-Message-State: AOJu0YyC0DAidCJ72d2OJiX71UXYs7P/6153ZGhV+raFl63vdcrZI+wd
	EfYyuNMDTxPrI66Uf6NWaMEAL0AXcGfO4FJcjADwGp3Qt8TKWvyO3/+4nQdP
X-Google-Smtp-Source: AGHT+IFZ47knxUjiOKlGXM3SD51p5yownuw1gWmUxyE/4WD8m7ZG/3pflBKu5SSlSeFjlCOO3FA1jA==
X-Received: by 2002:a17:902:ce91:b0:1dc:9e62:75c2 with SMTP id f17-20020a170902ce9100b001dc9e6275c2mr3786674plg.57.1709344814755;
        Fri, 01 Mar 2024 18:00:14 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:8f17])
        by smtp.gmail.com with ESMTPSA id e8-20020a170902784800b001da001aed18sm4202962pln.54.2024.03.01.18.00.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 01 Mar 2024 18:00:13 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	john.fastabend@gmail.com,
	kernel-team@fb.com
Subject: [PATCH v4 bpf-next 0/4] bpf: Introduce may_goto and cond_break
Date: Fri,  1 Mar 2024 18:00:06 -0800
Message-Id: <20240302020010.95393-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

v3 -> v4:
- fix drained issue reported by John.
  may_goto insn could be implemented with sticky state (once
  reaches 0 it stays 0), but the verifier shouldn't assume that.
  It has to explore both branches.
  Arguably drained iterator state shouldn't be there at all.
  bpf_iter_css_next() is not sticky. Can be fixed, but auditing all
  iterators for stickiness. That's an orthogonal discussion.
- explained JMA name reasons in patch 1
- fixed test_progs-no_alu32 issue and added another test

v2 -> v3: Major change
- drop bpf_can_loop() kfunc and introduce may_goto instruction instead
  kfunc is a function call while may_goto doesn't consume any registers
  and LLVM can produce much better code due to less register pressure.
- instead of counting from zero to BPF_MAX_LOOPS start from it instead
  and break out of the loop when count reaches zero
- use may_goto instruction in cond_break macro
- recognize that 'exact' state comparison doesn't need to be truly exact.
  regsafe() should ignore precision and liveness marks, but range_within
  logic is safe to use while evaluating open coded iterators.

Alexei Starovoitov (4):
  bpf: Introduce may_goto instruction
  bpf: Recognize that two registers are safe when their ranges match
  bpf: Add cond_break macro
  selftests/bpf: Test may_goto

 include/linux/bpf_verifier.h                  |   2 +
 include/uapi/linux/bpf.h                      |   1 +
 kernel/bpf/core.c                             |   1 +
 kernel/bpf/disasm.c                           |   3 +
 kernel/bpf/verifier.c                         | 280 +++++++++++++-----
 tools/include/uapi/linux/bpf.h                |   1 +
 tools/testing/selftests/bpf/DENYLIST.s390x    |   1 +
 .../testing/selftests/bpf/bpf_experimental.h  |  12 +
 .../bpf/progs/verifier_iterating_callbacks.c  | 103 ++++++-
 9 files changed, 330 insertions(+), 74 deletions(-)

-- 
2.34.1


