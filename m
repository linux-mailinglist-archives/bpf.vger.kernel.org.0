Return-Path: <bpf+bounces-72275-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C13B3C0B356
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 21:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 949164E6FBC
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 20:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884D3257830;
	Sun, 26 Oct 2025 20:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZhhRlHA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5052F1C84D0
	for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 20:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761511149; cv=none; b=acP5SNs7z82kCnziXBZGfctTUqhksnlokEEFJ15lMraq4b2feOspdcmrXnhhfDRKbr15tdJzxjjrP1+goLRxpcFR9+PjzhwPY84wmRJkxJOmWgLWXxiRM8U+XmIuaYOTtyhOnjCIgtm7tVktSbVUB2Cp4w9xL1RqVXaGG/Rfv5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761511149; c=relaxed/simple;
	bh=1s1JaAoYzEThD8sfeGEoSpslRVAwFxl1Orku/qvd/w0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r2kbFAXqG5wZ7Xds0c17BDhfG2T1j5Yr6y8rqkzXBih85oBcAYeqZWEsEOnPXRXcR4OSPM7XLhFSckpHwVEzBAVR8OpdWfqWs+/PO4JDnglpJbaGGYcqTrEkli5STXYO9HMljrg3ztqa9f716YHx1gLnv3KHgDS4t6fJX2TyZdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZhhRlHA; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4770c34ca8eso7014125e9.0
        for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 13:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761511142; x=1762115942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s+V4C2NaonEi6ov6sMgk1qukTIlqm+NfAxlFkCdN5HI=;
        b=LZhhRlHAum3CaCwrnQ71X5fYzx7kuAPyfHF0r+o/vq4nnQXbkRF5ugRqFZKGkJy3dM
         mfjWIJ2Gs17fC1MoH3ajyygXexkndyrkCqOjH8Ot+vhbzXZGOGnjX4tF+7WrxQ0vwze8
         n2IssVv4q8fbVS06Y4BAQFnMPWK0vOBcs78pDklN7zlOwhYlB3Rdicreb5lZTwkBMzYj
         AGmBXV8/kEUvxMRcq05Wzc6sDyKTkhUXHwuXmxfBfll7ULlgINqc2CqkTTW5YTLMH+jZ
         EbWzDNgNiGQtpY6OVMeTbc/JMZchLkj2TzJQWd0LrlgEIJojv9fwHO0gu9fVtImehxEC
         b9gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761511142; x=1762115942;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s+V4C2NaonEi6ov6sMgk1qukTIlqm+NfAxlFkCdN5HI=;
        b=jIryDbVcb1eY8+JyStnR/zcM+smy3T8lCVYu3bVLKGhcTQbwocJ4u7M0kVSbDKzWzU
         Wb/5ebzYjwp8R9stPTM7gNtXVcPg5RkJ4b5xC27H8gtchj2RJ/IO1dWRp4GSZdePDxZF
         YDvkZKC3VbXvB0zqF1pxqas0TfOxRYwFIHwgpgSyPEPycS62BejU72eVVL+5bKH1GE5Z
         7a6wiuVHIC+9omv0VpQiCvUU/H/zYZfkyOox1cEAtArRNct6Lxm14DYYVbkC6RTF0aZE
         Ro/mt8xo5mMuhgwpUqVrL05GpzNL8hP7oPS/PgkdXJO+0D7VcuFBfcZ0qDriTAccBM79
         eJKA==
X-Gm-Message-State: AOJu0YzN4ebC7U8Bf70pbR0SDzSDmLRU3Otgx6+hD9uOUOY108bLZ2O/
	q9gDaM4yEBu1W2vlJuAl7DttAtfjrFEY2mFkRt02A1LCL62zI/53vWsHeNwcKg==
X-Gm-Gg: ASbGnctMBa47ELh/hDO8xtW7jCD4W/qJ5YG9n0QRVWY/3vkPfKUTBwygPmRMPK42+CX
	TrCgG4hNNAMIlRFzJl8TmpAEWIE/f1jUPsWU1W7ft67JMlT0MU+KDhIbZ7ZEqZRSECtbIul6ny6
	zFymU3t/tRWTxibxwHGQd768O3O1lnVNEVhnN+j7RHFc2T87K1KbjVqmCmWJlNPIEEusIvITecu
	k5C6kZQ6ovYWeN/rCal+0tT24AIGkjn3GURzOvPYtwUnvhxgVDgPcCS+8y7YecGONEt7y4U8EM3
	eSgZanXCCUfE+2+YQeHvb1gjaraYd0V23N+7dEs+qayo6rPspPWJLMChqPXdAonKW7kaey75nPb
	xTXAq6d7MMRuRUVKpdG0QzRbDmu2KAIYtACX0L9EkFlLGZEIqrznO8jiEKpY=
X-Google-Smtp-Source: AGHT+IEOyyiisFwqU/pmGqdIP3iEH9mczA9ed1AoIoPNDAgjqzi7MWm7Bmi8z4crAYqqyAFfwLcWkw==
X-Received: by 2002:a05:600c:3acf:b0:475:dd05:93f with SMTP id 5b1f17b1804b1-475dd050a09mr43007735e9.36.1761511142340;
        Sun, 26 Oct 2025 13:39:02 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::5:4ccd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd4894c9sm95415685e9.5.2025.10.26.13.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 13:39:02 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v5 00/10] bpf: Introduce file dynptr
Date: Sun, 26 Oct 2025 20:38:43 +0000
Message-ID: <20251026203853.135105-1-mykyta.yatsenko5@gmail.com>
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
The final patch adds a selftest that validates BPF program reads the
same data as userspace, page faults are enabled in sleepable context and
disabled in non-sleepable.

Changelog:
---
v4 -> v5
v4: https://lore.kernel.org/all/20251021200334.220542-1-mykyta.yatsenko5@gmail.com/
 * Inlined and removed kfunc_call_imm(), run overflow check for call_imm
 only if !bpf_jit_supports_far_kfunc_call().

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
 kernel/bpf/verifier.c                         | 151 +++++++++------
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
 17 files changed, 649 insertions(+), 195 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/file_reader.c
 create mode 100644 tools/testing/selftests/bpf/progs/file_reader.c
 create mode 100644 tools/testing/selftests/bpf/progs/file_reader_fail.c

-- 
2.51.0


