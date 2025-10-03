Return-Path: <bpf+bounces-70304-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B345BBB7703
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 18:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3823D3B97C5
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 16:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F9A29D29F;
	Fri,  3 Oct 2025 16:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWWXWTEs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A97623814D
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 16:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759507476; cv=none; b=RgXKc7xCABiAsIVhDtEpK/LY0a7ElcqPS2hxVhP/gpCTvqyqTWLvRJwE54ufaw9m2NPK3rCLhAO4FW2BHCMrPuOApt5+VPmUSf3402J8hek3ueTqJ2UE1v39Da7R2g14tK99YK6jWgQCs7L1xWXgAKz08mDXJQrrpfGE8lSEfRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759507476; c=relaxed/simple;
	bh=XE1gu7jKAWMSdwKl14HeHT0mCuJJG+WZId6TDfN+LEk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TvfYMimG1LaH5o1hW0fg8iWwp/ZAPzJuDeJQ63CVvn1bKQ5v3Ibop3Y/78UE55qUJwRArR+4l6wdm69JIiunkvbRbv70ikSqx68fkQyas3bn1PM6f9dV8+TAZED6VXE+idqQT8Q+l7nz874Fb/0Jfz+vDsOt2+/x56C15XXfHkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EWWXWTEs; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e37d6c21eso17720645e9.0
        for <bpf@vger.kernel.org>; Fri, 03 Oct 2025 09:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759507472; x=1760112272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ko9GEbQXfHKRIqVLeVUCOQHpgeSnf9HQJyhcsbgQFrs=;
        b=EWWXWTEs69bWKcgiQ9Al0KM9QfkwduETKCS9mP99Seyw26L9pp3cDK3mpu9b33fj3M
         zYMkFRIXoIvs/z5aQ3OfB6HVvhMAYcFIUjJH1aNILccKO5vfz+VCUj2faoM54uzyw7KH
         Oe9URlrgtHMCj5lndTm4tbj3/yQrMEhDxUIdnmz66tSsQCBpAJGYqPI3hksVr63KF/tW
         3sKMGrYBxYqlfnrMI0E8JtIIL7V1rgKpQ61KQpTvuQ+tAg6TaNB622c2Hg75ZD8BwDYf
         El8L4brQnzX4lHpSfYirI+1Yx71eDyT+9HWddhXE37IStSw1z6GWw4uaG9GHgdJ16GjH
         cMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759507472; x=1760112272;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ko9GEbQXfHKRIqVLeVUCOQHpgeSnf9HQJyhcsbgQFrs=;
        b=hGi8nW4E8qzM0juyIWylhnQiFXLzZSHGBLJU/xJ/pWjz1EMAlE8ryHlzqR3qwrhIgt
         udl3lA+LYWmj2EvD9LWf7MoeWTgc9s5csgGUHaRcJ9NEaVb0tfo364AtLmp/3xUYRm9Z
         OkfqRGtJ8hZAluB9npYK69xDvqQGSSJfRW3JzEKDVBHkBwYZJi+Qg9mGK4T1nXOp1faT
         IM9zZpLPXWSC4eRBY+dziXEgln32UKd5wNm4dylBYsZc0wA92jI8aV0Ja5h356jYkh39
         qdkvX3CLDhuWiWESEa1VusvAFd1XzyuvsZ+xxR+GHU5bpmwHTM8S+DcwnHmeQjLMNWUI
         Jnew==
X-Gm-Message-State: AOJu0YwLCDE4lZvIEbg3kSnsAoWhqSqFh5aggJQN+iSQfMroJOlov3Cc
	Ctj+HAqTMm1B1nJbq3o7QtriZqJ/BGyhT2n84n+ME8as3+obggvaMYwY82RB9w==
X-Gm-Gg: ASbGnctyMu+NjA+Lz366prNFuPqfhiENDVM7ubPiQSSzyY/+Ws90J4wJm7HyWXMKejW
	Wlcqwv1NMO6uSDyG61iFFenCcvFMAQNlRcv03qM90X2Tdfk/bWlCxT6Bdmny+UBScVM3tB6SMKQ
	ozjhwRqZP78T98cs9q/2OxghEoJHridHfY780gvh2/e6JQYksNRBbG+J7ZFVYWnA5ECC5V3XFVD
	XSWA9gN0IGzy2T/Cm1N6b9boFdsCEHJ9Ttp8q4jkkDqQKac2I7TPOEI+N57NC8UrOMKK6B7Ui5N
	VfBMmuszQf/UFnzi50PNDCXgmlqSCaaaJzoONPUX5bbDWC4uZVTPQlkqpyunPM73Fd+y/Nev0/a
	8j6VX81yYBg/dokQpxuhKgZ5l2ExckXBAWIa8
X-Google-Smtp-Source: AGHT+IG8sXnyvsBo01dmu4Yh0ok8hczwb54ewEQrhQRFnxCYTFPn3SDVnK1IfxzLFoCMX8uL1X9gmA==
X-Received: by 2002:a05:600c:1f8e:b0:46e:1cc6:25f7 with SMTP id 5b1f17b1804b1-46e711022d1mr24124825e9.9.1759507472174;
        Fri, 03 Oct 2025 09:04:32 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::5:5b97])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e619c396esm132912365e9.8.2025.10.03.09.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 09:04:31 -0700 (PDT)
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
Subject: [RFC PATCH v1 00/10] bpf: Introduce file dynptr
Date: Fri,  3 Oct 2025 17:04:06 +0100
Message-ID: <20251003160416.585080-1-mykyta.yatsenko5@gmail.com>
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

Open challenges:
Patch 6 introduces mechanism for handling dynptrs destruction in
kfuncs, it feels hacky as we need to check for concrete kfunc id to tell
verifier to destroy dynptr, also the way we pass release_regno could be
better. I'm open to suggestions on how to implement this.

Testing:
The final patch adds a selftest that parses the executable’s ELF to
locate thread-local symbol information, demonstrating the file dynptr
workflow end-to-end.

Mykyta Yatsenko (10):
  selftests/bpf: remove unnecessary kfunc prototypes
  bpf: widen dynptr size/offset to 64 bit
  lib: extract freader into a separate files
  lib/freader: support reading more than 2 folios
  bpf: verifier: centralize const dynptr check in
    unmark_stack_slots_dynptr()
  bpf: add plumbing for file-backed dynptr
  bpf: add kfuncs and helpers support for file dynptrs
  bpf: verifier: refactor kfunc specialization
  bpf: dispatch to sleepable file dynptr
  selftests/bpf: add file dynptr tests

 include/linux/bpf.h                           |  30 ++-
 include/linux/bpf_verifier.h                  |   2 +
 include/linux/freader.h                       |  32 +++
 kernel/bpf/helpers.c                          | 170 +++++++++---
 kernel/bpf/log.c                              |   2 +
 kernel/bpf/verifier.c                         | 137 ++++++----
 kernel/trace/bpf_trace.c                      |  46 ++--
 lib/Makefile                                  |   2 +-
 lib/buildid.c                                 | 145 +----------
 lib/freader.c                                 | 138 ++++++++++
 tools/testing/selftests/bpf/bpf_kfuncs.h      |  12 +-
 .../selftests/bpf/prog_tests/file_reader.c    |  81 ++++++
 .../selftests/bpf/progs/dynptr_success.c      |  12 +-
 .../testing/selftests/bpf/progs/file_reader.c | 241 ++++++++++++++++++
 .../selftests/bpf/progs/file_reader_fail.c    |  57 +++++
 .../selftests/bpf/progs/ip_check_defrag.c     |   5 -
 .../bpf/progs/verifier_netfilter_ctx.c        |   5 -
 17 files changed, 840 insertions(+), 277 deletions(-)
 create mode 100644 include/linux/freader.h
 create mode 100644 lib/freader.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/file_reader.c
 create mode 100644 tools/testing/selftests/bpf/progs/file_reader.c
 create mode 100644 tools/testing/selftests/bpf/progs/file_reader_fail.c

-- 
2.51.0


