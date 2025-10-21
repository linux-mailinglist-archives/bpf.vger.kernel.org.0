Return-Path: <bpf+bounces-71623-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB16BF87FA
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 22:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 149724FA483
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 20:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4DA275B15;
	Tue, 21 Oct 2025 20:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gek2j8Hk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823FD1A3029
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 20:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761077024; cv=none; b=DRjhli34SbKJ2X03IB9WoInbyTE5lI7U7ulYIryTqACGnEykY2mJ35PU6+gadCO1qiQqW4c6N8VsReD4Ezk7vXvH1xB99We/1C8kBiF+8cA93glfjdBaAlWbN/FsFBwJHmKDvkbIBUkTvka4bnZrtPnW9wmwVj5tgTqsrfH5DtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761077024; c=relaxed/simple;
	bh=xTEY5Iuko/dNvcR4oq1Bd0e9lR42cgNzQz8+uE+7DrU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LYSDxCI9vi3CrsFlzl1g29qoU5GlBpl3zVIEn/4VJBksGYfwjJdBBGfLSYBzLlP7xJrXi+3mnc/L1by3lgQjM2+XsZy0wssD0bgiOc2vJgzj6lFzmYrGR8q7gb4uxsRvpZarmwbqyisNoClHBljyY4l2Z0NwDhaT2MMhofIGX6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gek2j8Hk; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4711f3c386eso30086005e9.0
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 13:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761077021; x=1761681821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GeIIsYUBKHVmDhw3CC+Ti0ZDX/QmV97lil4puHmgtpI=;
        b=gek2j8HkbxRMX5bGchkHduloTQbmRmQJpL1iN4laEfpNqfIrRMJefCBeD3wOVNGHcR
         7zep9Ank1tVbRfww0D8AIqJZYg/IT2JvN4jM+mAIA/QrXyuEI/+Le8sDklcJuVEK0sEv
         vFditMerImhWJEgOU07/+s0gJXTHavOh0BSmWmLh98ceJhC9LK+5MrxWKNKb1KeUD57q
         +ar7lFflxy/QOeYg7MfbVF0/r12xJavTdt69hutF0nn5Fm49DZ5Lcp3hgIMjLeuQnoQS
         CbX4dfCXSIRk4wRh694xvXeVoFDHHZ3SWaY9ZhUBuLMm0YZFE75pnbUp9Vebx12u9x4W
         ZwCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761077021; x=1761681821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GeIIsYUBKHVmDhw3CC+Ti0ZDX/QmV97lil4puHmgtpI=;
        b=SQZkPU9HBhRfqTnlSiWFlj2AIKyBKi+D/FXNUyXqHVBdoL1tpYpJKdvjQeYcr8SGHc
         jBebrghobfz9k83EX2EsFk9j7PSIY0H5YZ4fQw+9XjxEEVQg04enbOtCiC4x0NeMAtMD
         YGEjgNZLgTUMqsGxQLrDijFbHn/CYfVtQKxy8cH87FXP5oVQP0aBd1XxAYxgPLMp+VKu
         3Pdr8gDhH0AMk6hWvNQHbgvVPbBa/a279E9x1DZ40VjxbjAbo5flZeTS/9RYFwlLlpRe
         MS1J/l+Z5NtAlMX3WO0eduigMZdCHJAp6nQxDQFDbTlWIcj+C66ZGfzkc711Vf6UBztQ
         uOUw==
X-Gm-Message-State: AOJu0YzWcaB+tGCrXXoE9WWh8KjwanVB++/uTMUphHg4uuAadySTLQKA
	6MDzLfrbQXfYXRmsA+DZny0wL5d3Ybop/EoKqse+pp/KK9I6o14U3qhurmZBxw==
X-Gm-Gg: ASbGncunVUFEJUe/dGj80mGb2jNd20M0bceBcESDCXR5YZ/h4ZSN/G4kwqu5Dlj3pFh
	h2DLiNfFDPkhEl1bX2klGumFltc22cOVF9XkB8vKZgezbEKaASmyzl9bO2hbWcb9ntPXs+x3GrF
	yWiBP6guzoHJmeuUTbgQal1Zubrm8PGSye+E0G0cWJ1U5G2BBk91WEBR8g2b8JVWaoeLugvtasD
	4yuoNa+xhgC8FRFsbXIcv/T1M54X8uZPr292W1fdYuljj/9TZogkBwwHdFUruH/fFs+4gTqswVw
	uKz3h3SLiPYAOwTdvjlmKKokN8eJTa2P6RG0ei7ATbPk3SNet4Iq7yk6q3xzK9zBTLsKiPSwg8B
	bhGw39Y3/aNcdHGowld/Pkwni0DpaezyOmuSTiZ/YC1hM8gpMZp3QSWeQ8b/jD9dCG7sjcCQ=
X-Google-Smtp-Source: AGHT+IFKVl6dVH5RtPjGgMSRWXeEjbwZGMEjQyVsQNW6jeUmYFRhoaaVQYSiUH5uNK39TcXZqGXWyw==
X-Received: by 2002:a05:600c:4ec9:b0:46e:2562:e7b8 with SMTP id 5b1f17b1804b1-471179123admr132472885e9.21.1761077020400;
        Tue, 21 Oct 2025 13:03:40 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::6:c0ff])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c42d828asm9004505e9.17.2025.10.21.13.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 13:03:40 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v4 00/10] bpf: Introduce file dynptr
Date: Tue, 21 Oct 2025 21:03:24 +0100
Message-ID: <20251021200334.220542-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

This series adds a new dynptr kind, file dynptr, which enables BPF
programs to perform safe reads from files in a structured way.
Initial motivations include:
 * Parsing the executable’s ELF to locate thread-local variable symbols
 * Capturing stack traces when frame pointers are disabled

By leveraging the existing dynptr abstraction, we reuse the verifier’s
lifetime/size checks and keep the API consistent with existing dynptr
read helpers.

Technical details:
1. Reuses the existing freader library to read files a folio at a time.
2. bpf_dynptr_slice() and bpf_dynptr_read() always copy data from folios
into a program-provided buffer; zero-copy access is intentionally not
supported to keep it simple.
3. Reads may sleep if the requested folios are not in the page cache.
4. Few verifier changes required:
  * Support dynptr destruction in kfuncs
  * Add kfunc address substitution based on whether the program runs in
  a sleepable or non-sleepable context.

Testing:
The final patch adds a selftest that parses the executable’s ELF to
locate thread-local symbol information, demonstrating the file dynptr
workflow end-to-end.

Changelog:
---
v3 -> v4
v3: https://lore.kernel.org/bpf/20251020222538.932915-1-mykyta.yatsenko5@gmail.com/
 * Remove ringbuf usage from selftests
 * bpf_dynptr_set_null(ptr) when discarding file dynptr
 * call kfunc_call_imm() in specialize_kfunc() only, removed
 call from add_kfunc_call()

v2 -> v3
v2: https://lore.kernel.org/bpf/20251015161155.120148-1-mykyta.yatsenko5@gmail.com/
 * Add negative tests
 * Rewrote tests to use LSM for bpf_get_task_exe_file()
 * Move call_imm overflow check into kfunc_call_imm()

v1 -> v2
v1: https://lore.kernel.org/bpf/20251003160416.585080-1-mykyta.yatsenko5@gmail.com/
 * Remove ELF parsing selftest
 * Expanded u32 -> u64 refactoring, changes in include/uapi/linux/bpf.h
 * Removed freader.{c,h}, instead move freader definitions into
 buildid.h.
 * Small refactoring of the multiple folios reading algorithm
 * Directly return error after unmark_stack_slots_dynptr().
 * Make kfuncs receive trusted arguments.
 * Remove enum bpf_is_sleepable, use bool instead
 * Remove unnecessary sorting from specialize_kfunc()
 * Remove bool kfunc_in_sleepable_ctx; field from the struct
 bpf_insn_aux_data, rely on non_sleepable field introduced by Kumar
 * Refactor selftests, do madvise(...MADV_PAGEOUT) for all pages read by
 the test
 * Introduce the test for non-sleepable case, verify it fails with -EFAULT

Mykyta Yatsenko (10):
  selftests/bpf: remove unnecessary kfunc prototypes
  bpf: widen dynptr size/offset to 64 bit
  lib: move freader into buildid.h
  lib/freader: support reading more than 2 folios
  bpf: verifier: centralize const dynptr check in
    unmark_stack_slots_dynptr()
  bpf: add plumbing for file-backed dynptr
  bpf: add kfuncs and helpers support for file dynptrs
  bpf: verifier: refactor kfunc specialization
  bpf: dispatch to sleepable file dynptr
  selftests/bpf: add file dynptr tests

 MAINTAINERS                                   |   1 +
 include/linux/bpf.h                           |  30 +--
 include/linux/buildid.h                       |  25 +++
 include/uapi/linux/bpf.h                      |   8 +-
 kernel/bpf/helpers.c                          | 173 ++++++++++++++----
 kernel/bpf/log.c                              |   2 +
 kernel/bpf/verifier.c                         | 157 ++++++++++------
 kernel/trace/bpf_trace.c                      |  46 ++---
 lib/buildid.c                                 |  56 ++----
 tools/include/uapi/linux/bpf.h                |   8 +-
 tools/testing/selftests/bpf/bpf_kfuncs.h      |  12 +-
 .../selftests/bpf/prog_tests/file_reader.c    | 113 ++++++++++++
 .../selftests/bpf/progs/dynptr_success.c      |  12 +-
 .../testing/selftests/bpf/progs/file_reader.c | 145 +++++++++++++++
 .../selftests/bpf/progs/file_reader_fail.c    |  52 ++++++
 .../selftests/bpf/progs/ip_check_defrag.c     |   5 -
 .../bpf/progs/verifier_netfilter_ctx.c        |   5 -
 17 files changed, 655 insertions(+), 195 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/file_reader.c
 create mode 100644 tools/testing/selftests/bpf/progs/file_reader.c
 create mode 100644 tools/testing/selftests/bpf/progs/file_reader_fail.c

-- 
2.51.0


