Return-Path: <bpf+bounces-71464-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 709FFBF3E2D
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 00:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0002118A61F4
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 22:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CE42F12C6;
	Mon, 20 Oct 2025 22:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFViLRHX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709822EFDBB
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 22:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760999148; cv=none; b=aWeTLf1pZgVmatJKjmM8m3WCiwdL48SG1xUuCEmIpXnPrai8I1O4W/GkThLDg5XOLSZGQt0t0ZUInGARKDCy4chZputNYiV5McCve6TIKIjoOwPNEES9Ibwk0vnS6kJtHXJJSaD1UI6RZz6o01tvjj4ZABr/7BlUtjZFPZ6ylN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760999148; c=relaxed/simple;
	bh=0UbnSjIfq7HuX3s/eJ9FmfqU1EP43gug2ciiREh4tOw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CiFCGd7zUAib6vxDQqialGznf0VOMJ6sAlXndklR3avK44hSKYvUsUZxPfa6QXOX14Ec86TWN65JKxLy8B6Vh6ZRMSXRCijWjCB7W180ySPNPGv+DkUoOcRYSybRYd0BJASINJNRFL9KEWvv2lw2dL6ddzWqKWXK7M8CTvA4Vzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jFViLRHX; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-421851bca51so3921431f8f.1
        for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 15:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760999145; x=1761603945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xtXTXMNk1apHPImNeVoHdE9is3iQOOg0vBXFXec+OZI=;
        b=jFViLRHXfGZTR0mdN8fs7rCfXpYUD8LyTvIN9Utj5glCIPw2da8+GERw/+ZF6cATsD
         sEWmjcAoDI20YebcPGemLAMAoJwB2RNfln7ff3tIKuV6dPvyWUIH6X09+XeHv6E/MC8F
         91O244CHQH2JmMe6W8Jg85Zl7IxcS/4KhcNFQS2/Il1TQ3FPTNdkFmyoBWe+38bBY22r
         gyPOBJta2uSzUv/pmi81f14lDbdsexW5kwcS1SC4fWKfHl62eOrghm8gyd9I5graowrU
         lrQeCG2vgH9gTNuf6hxhdSTDWu90PzVcIECUy3zj6ciiefxzl6dK3LprfO3aQ9Hn7Tq1
         rFKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760999145; x=1761603945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xtXTXMNk1apHPImNeVoHdE9is3iQOOg0vBXFXec+OZI=;
        b=bAosz0QZmPaeO3HZWN3j62hhJY3GCaC1eMpGkHiCY/BYTO9SZtkaU3vydR9oZ+0Bou
         UsGqoWtuoUBijjE5CMIti6VwFsRJ1vbL1zjx/zHW8PHG5texi1pOLLTWbfqCX1oZTRTW
         fZFmQlML1CsKrGW7rRd4Al8WwwnZL73spm3MU9rO1EJkul3XFocsIElBLxaNJDW5qZ1j
         HPDOFrf68UklrB6z1jqT6v+jNk6PxyLjvMCkBRRCalpCjSv0rczuvHedBmeZA0WxufwO
         /ZqTbM8ygpwh1xYmSpHv5lljZVXZ/yHAkLAWcZCLssWM7wMSnqCFkYzWJ9r2zET4YXLA
         BBiw==
X-Gm-Message-State: AOJu0Ywef2XUp0iPyLxaiL5bg+Eu1d4emd08oulsej5rGAv2BTg3whdb
	rt+lxDSTNg3yw+RZRiPMyxGsZnx2gyWfNaTYu8MfCl+Vte9fxjkXm5WYWxioBQ==
X-Gm-Gg: ASbGnctkcTOBjs9gMSqaYNKhWDo+6cHCOYLFMbwLBqthanWJd/3/t1oNWreErTAwVvX
	sQzj262r6glGa+xzuTK0Ie623dmcFED0NGNUGSZjixi5x/sE7bopmulkQuuOG/WZxeqddPpdOnj
	tMsHjSkg9fuGiyC52nGRbLE5uQrWyALIW2AsD+eERW5NmPALjzito3TO6PRpXqBnelTOiQA/IjS
	blGAm6QUzZbRFpcqNGefJog9pOSIhd+IagDHm/EQqqRgaatAPJMiOmi/57KiJFmm+rdoLW3bdd7
	tnVT5YyY5uqV4NaAepAerjo3hvkKU55MLmb3RlkQ8mjCcZlODmIVKSdnS+hCfETIZ0ftWeCTTfo
	jOdmoZN3fXVXEoUq+VouZq8H1vq+dt5ZWu6J8fXLq9JlVKs3fF8Q5ed040goN/d8PL4sDxQ==
X-Google-Smtp-Source: AGHT+IHWlgK6BPHVlt8OOAS12jjGT2MNgRzKA62xEDVybGFbCpsuabDxnoAovEk/mdM2lIstzNUjeg==
X-Received: by 2002:a05:6000:1789:b0:427:606:b220 with SMTP id ffacd0b85a97d-4270606b280mr9046861f8f.51.1760999144486;
        Mon, 20 Oct 2025 15:25:44 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::5:2617])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00b9f71sm17297805f8f.37.2025.10.20.15.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 15:25:44 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 00/10] bpf: Introduce file dynptr
Date: Mon, 20 Oct 2025 23:25:28 +0100
Message-ID: <20251020222538.932915-1-mykyta.yatsenko5@gmail.com>
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
The final patch adds a selftest that verifies file reads fetch the same
data in BPF and userspace. Verify that page faults are handled in the
sleepable context and not supported in non-sleepable.

Changelog:
---
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
 kernel/bpf/helpers.c                          | 172 +++++++++++++----
 kernel/bpf/log.c                              |   2 +
 kernel/bpf/verifier.c                         | 173 +++++++++++------
 kernel/trace/bpf_trace.c                      |  46 ++---
 lib/buildid.c                                 |  56 ++----
 tools/include/uapi/linux/bpf.h                |   8 +-
 tools/testing/selftests/bpf/bpf_kfuncs.h      |  12 +-
 .../selftests/bpf/prog_tests/file_reader.c    | 118 ++++++++++++
 .../selftests/bpf/progs/dynptr_success.c      |  12 +-
 .../testing/selftests/bpf/progs/file_reader.c | 178 ++++++++++++++++++
 .../selftests/bpf/progs/file_reader_fail.c    |  52 +++++
 .../selftests/bpf/progs/ip_check_defrag.c     |   5 -
 .../bpf/progs/verifier_netfilter_ctx.c        |   5 -
 17 files changed, 709 insertions(+), 194 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/file_reader.c
 create mode 100644 tools/testing/selftests/bpf/progs/file_reader.c
 create mode 100644 tools/testing/selftests/bpf/progs/file_reader_fail.c

-- 
2.51.0


