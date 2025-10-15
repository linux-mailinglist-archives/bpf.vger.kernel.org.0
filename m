Return-Path: <bpf+bounces-71018-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4938BDF961
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 18:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4187188497E
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 16:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DB6335BD3;
	Wed, 15 Oct 2025 16:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="De7sbxoI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548FB335BC6
	for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 16:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760544723; cv=none; b=sIzC+Bqz+0UkSFJYzTy06yS3kiPI0aRxiezulan7kC6SgahbK5bM9UaaqUTrBmlarz7HKAdGM6Vh2YApzu2DkV8yKs1GOyCJ0OAoU+oMGQ0BnoBGp6iVenpIr52EiydV6mzbuCvTSyDjW+U44944XTd6A6bXMOYamXpjzhL/o+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760544723; c=relaxed/simple;
	bh=RV1TfGnEJkB5DRX/tWGhXJyATdHWPYBrr0b6F7v5SCk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lu3hzviaUnEatkOkQikaS71XtZUzrQVEQniniJ7XDJMN4JJyQCQPwdOBBro9gBt96qfB/8uZKG7W0k2nlaW17i5Zc9CqrNrGB2S5D18RIiSbtM0hU7CTg6ldj9MhDmC8+bU51vA6F5bS6wbDgw+c9KnJZeoCo2kc3Vyud+gR694=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=De7sbxoI; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42557c5cedcso3643722f8f.0
        for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 09:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760544718; x=1761149518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m31zVKCcExDQCnamkP4O2kAvY81HAu+uRD1m8LoEEVc=;
        b=De7sbxoIC8ScdzgDlHNrHOoxa+M2WdoigwQYsA1gganuoBskYODzQjEFMewPUvuAzu
         WGAJNjqrcJs3S+BcMqDv0u5x31aQaPJNi262ugDBh/CUBybddgT3wfLReVPoEl6POzuw
         bMcETqRaSkE3JZqerghPDu3wUxdFx6ngUUhwUlNqadeSosvJoPQ7f0Vn/POYt5x2atJ/
         f393pYzdKox3Rtmvn+GwxXuiKWo4cLUXzFta22+0PCTdE1fhOIEr1tgCYL3JdtT2pkrT
         UbjdgeNDbMxioUy71qwOOslJB57jrlDlCWQwmOrWzXxgSgeL17ywcMuK8WUHno48Y8eL
         IObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760544718; x=1761149518;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m31zVKCcExDQCnamkP4O2kAvY81HAu+uRD1m8LoEEVc=;
        b=HPjEokHr4diKXiMO8cAA2bQNj48cibzD8OShE5PxgwITQUsuNOYVh8OpjQsi83aPeg
         zodXbAQt/KlIYSEBc0g98OD7df1w6UvKiCTW7WjC+ewTRpTscSt2mI5ZWQdqnAjK6Z/3
         nM9v/1sIYMXN6+Cz1bcYGpaOMpx7IExC4K2K0GK2TghX4htWiIpPMgBny3o2ErnlqdHp
         79lsn0ug8Krnrz/cpYqWdwOWTou4owhRKsytbVeCnUNsP9M6Ew0eOGDDs1vyUILCXCDy
         8qMl53PUexi7IzJNARVwLX3wMj2ZH+ejMWbBGduizcuuvxNML/Nr9APR16eG6HpXsvpk
         vUaw==
X-Gm-Message-State: AOJu0Yz6uyKgheV1mv/hYqPSjAj7f+IRaEsbc7rDdozFPi85njm5q7mL
	x4DlbZGa3xkUbOgtZxDZ/luFr2zTK66B0/db9GKzNIeoJnXuv6cUdptTPVE18g==
X-Gm-Gg: ASbGncvhUIGaSTep9gu3ndiXv4iQj52jsmQ/cB8RrXHwF6vrNACD+jgtI6lPBPyhJkL
	z136DzUZ2cG9MYiSLh8lMEuOntOR8h+bqyiyS7qaxuzUfcORHeRNSNeTRy7WffWXMDdFNtapIk4
	pOAQxNY/GHfrVuwBJJk2qIsa+ZOCIlH/DKliO9IEzNQ9oQKJg7LpsRqQhnV23QPuv80BmJ3t2qi
	5tVb3ltr8UciwJESUlIUaxB5TCyiLojXrk+xzU4f8oDSxDowRFYdh+6cM7R3mzSV6Z3LZeEkBKy
	Vg3dGlwF6L+n45CCpB57wgv2aOOSsyp1YP5Sfjc2TLY5XFHgXlESuzDDy1lshAKHXuQ2pW+sOFt
	yoBG+S/J8uTfPkP6d/OjcjRMHEKw5lqKtXkGzWrxmRCC+
X-Google-Smtp-Source: AGHT+IFkYeQkwhfbS5zPgm2k8gqVJ23P2a7QV4JTLnccmPUuOYqF+iRibn6tm6nMyoh6udKpjCwE9A==
X-Received: by 2002:a5d:64e7:0:b0:425:769d:4426 with SMTP id ffacd0b85a97d-4266e7dfff1mr17389015f8f.34.1760544718323;
        Wed, 15 Oct 2025 09:11:58 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426e50ef821sm15719518f8f.38.2025.10.15.09.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 09:11:57 -0700 (PDT)
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
Subject: [RFC PATCH v2 00/11] bpf: Introduce file dynptr
Date: Wed, 15 Oct 2025 17:11:44 +0100
Message-ID: <20251015161155.120148-1-mykyta.yatsenko5@gmail.com>
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

Mykyta Yatsenko (11):
  selftests/bpf: remove unnecessary kfunc prototypes
  bpf: widen dynptr size/offset to 64 bit
  lib: move freader into buildid.h
  lib/freader: support reading more than 2 folios
  bpf: verifier: centralize const dynptr check in
    unmark_stack_slots_dynptr()
  bpf: mark vm_area_struct as trusted
  bpf: add plumbing for file-backed dynptr
  bpf: add kfuncs and helpers support for file dynptrs
  bpf: verifier: refactor kfunc specialization
  bpf: dispatch to sleepable file dynptr
  selftests/bpf: add file dynptr tests

 MAINTAINERS                                   |   1 +
 include/linux/bpf.h                           |  30 +--
 include/linux/buildid.h                       |  25 +++
 include/uapi/linux/bpf.h                      |   8 +-
 kernel/bpf/helpers.c                          | 172 ++++++++++++++----
 kernel/bpf/log.c                              |   2 +
 kernel/bpf/verifier.c                         | 158 ++++++++++------
 kernel/trace/bpf_trace.c                      |  46 ++---
 lib/buildid.c                                 |  55 ++----
 tools/include/uapi/linux/bpf.h                |   8 +-
 tools/testing/selftests/bpf/bpf_kfuncs.h      |  12 +-
 .../selftests/bpf/prog_tests/file_reader.c    | 114 ++++++++++++
 .../selftests/bpf/progs/dynptr_success.c      |  12 +-
 .../testing/selftests/bpf/progs/file_reader.c | 157 ++++++++++++++++
 tools/testing/selftests/bpf/progs/find_vma.c  |   6 +-
 .../selftests/bpf/progs/ip_check_defrag.c     |   5 -
 .../bpf/progs/verifier_netfilter_ctx.c        |   5 -
 17 files changed, 624 insertions(+), 192 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/file_reader.c
 create mode 100644 tools/testing/selftests/bpf/progs/file_reader.c

-- 
2.51.0


