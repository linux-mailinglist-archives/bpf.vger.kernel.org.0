Return-Path: <bpf+bounces-23213-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0674F86EDC5
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 02:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31A3B1C22008
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 01:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7169D6FCA;
	Sat,  2 Mar 2024 01:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VEkbgeZl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3045363D5
	for <bpf@vger.kernel.org>; Sat,  2 Mar 2024 01:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709342379; cv=none; b=D2UW3KFnHbfttR9DSA1lhhkiqcznKRfpMieUmt1zU09Z7rI3BsZCRG+aUDHIDnwJLYwPvammRjRnf6C8mJHHsNUO1gssBTjb5/nbMUSnvHkSqq1+lFTSXimMh0m08Fm7uigzxBBMfAHCdh5UVxRk5v3RvEOOE80MDV2zAyPPFRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709342379; c=relaxed/simple;
	bh=+/7512ls0nx43WR6FdeD5KlfXRruIV68iW1LrOMm0/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H7f5hBZfoDY6UM2O9WF2TGVmpM+BCC5tO6glbk3ZLvMAHbTAERDLJ4gQfJsX1iGzun7VYuWIisjek5jso74rgS3l6dWmUWSR0xcBqjbJBw09qaPNmrvp4UJjcmvTpHbT2UAe1A3iFx43J4XV6gKaOsNk18G0QhIUwXZ1e/39Log=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VEkbgeZl; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d2ab9c5e83so27821031fa.2
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 17:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709342375; x=1709947175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b38v/KtlzfGvNHdI3bvQHZ2X8+/n/aIxrofQlVVKaN4=;
        b=VEkbgeZlesEXHHXEZe4+WE0tKyKjzRBEkWU1CrX7FBsM30SPvoGTAqy2rF2R+YXMR6
         6pg+nBkK8n/6o6W6Fm5vfL6CzxTKZAl/Yb0RyzBIaBHTlojEAdlgyog2Xcqje0yAY5Mp
         qqy3Kb/4+bbkjb1pGaSGJSEqa7816dlYb3+up4Dhi61sFNwOj4dxZ/iNdQqVZ/CmFhMO
         i0yUQcU0yKPVm/Qec9qFkStKHz1MBYu9Qpkb3vlnJD1iozSDE4/tvuALy8VveBOgDylu
         fi69TQMLadCO/huuEO06wXRg3kONEz81wLncRVBy6du1VARu1XI3OdN1lL9dRlpSTJrL
         +V3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709342375; x=1709947175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b38v/KtlzfGvNHdI3bvQHZ2X8+/n/aIxrofQlVVKaN4=;
        b=p0PQlDhc1kdR08mMst4aGWYNfCBF6V/7oI/NAVHDhxDdl1dhR4POxt+78z3JWEG2hr
         sD8lB6reXcbCJ3Ok+dSLFU+C7ya0n2IO/B0e5pXNLbfIoYXAq3wQKdDMiVkuJzMdYuUr
         pMq040TQX846MA0CJ9JSxt1GXSztVHc/L6mydhsq2TmsDEPDIgfwOLQvvx8Nfg48m78e
         mmA7IPEJSiyJKg5DoGm4dx61/rMudwqsLgyuNC+pfWqTxHfXbRadkpyh9MUDXQYqbqmc
         v1LF0psNsU/COjq3suBHb3EDgujwvJ403irrL1obBKF9cUAUcHfGZdf6BD8mUYbWJesV
         L4UQ==
X-Gm-Message-State: AOJu0YzNHX46wmfYu5UH7niOCqnYpi2ejb5mUL/+0Mzjil+BqTklVAv4
	Gc+s59IVoIacLkO4HMvYzFRiIPmm61xAv0v+OiOrcAxz6Y9jIf/wjfKiI4QW
X-Google-Smtp-Source: AGHT+IEYRv1LsV7n/0KN8fMS9Hpb9uwDhboNzMgrp7FUk45cjM8yw9QBC6k+kMc2CGpH9BtpaA174A==
X-Received: by 2002:a2e:a4c5:0:b0:2d2:c8ff:d2b6 with SMTP id p5-20020a2ea4c5000000b002d2c8ffd2b6mr2277294ljm.1.1709342374665;
        Fri, 01 Mar 2024 17:19:34 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id z23-20020a2e9657000000b002d295828d3fsm767386ljh.9.2024.03.01.17.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 17:19:34 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	void@manifault.com,
	sinquersw@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 00/15] libbpf: type suffixes and autocreate flag for struct_ops maps
Date: Sat,  2 Mar 2024 03:19:05 +0200
Message-ID: <20240302011920.15302-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tweak struct_ops related APIs to allow the following features:
- specify version suffixes for stuct_ops map types;
- share same BPF program between several map definitions with
  different local BTF types, assuming only maps with same
  kernel BTF type would be selected for load;
- toggle autocreate flag for struct_ops maps;
- automatically toggle autoload for struct_ops programs referenced
  from struct_ops maps, depending on autocreate status of the
  corresponding map;
- use SEC("?.struct_ops") and SEC("?.struct_ops.link")
  to define struct_ops maps with autocreate == false after object open.

This would allow loading programs like below:

    SEC("struct_ops/foo") int BPF_PROG(foo) { ... }
    SEC("struct_ops/bar") int BPF_PROG(bar) { ... }

    struct bpf_testmod_ops___v1 {
        int (*foo)(void);
    };

    struct bpf_testmod_ops___v2 {
        int (*foo)(void);
        int (*bar)(void);
    };

    /* Assume kernel type name to be 'test_ops' */
    SEC(".struct_ops.link")
    struct test_ops___v1 map_v1 = {
        /* Program 'foo' shared by maps with
         * different local BTF type
         */
        .foo = (void *)foo
    };

    SEC(".struct_ops.link")
    struct test_ops___v2 map_v2 = {
        .foo = (void *)foo,
        .bar = (void *)bar
    };

Assuming the following tweaks are done before loading:

    /* to load v1 */
    bpf_map__set_autocreate(skel->maps.map_v1, true);
    bpf_map__set_autocreate(skel->maps.map_v2, false);

    /* to load v2 */
    bpf_map__set_autocreate(skel->maps.map_v1, false);
    bpf_map__set_autocreate(skel->maps.map_v2, true);

Patch #8 ties autocreate and autoload flags for struct_ops maps and
programs. While discussion for v1 concluded that such feature is
useful, it is an outlier compared to the rest of libbpf API that
treats autoload / autocreate flags in most simple way possible.
An alternative might be a dedicated API call, e.g.:

  int bpf_object__infer_struct_ops_progs_autoload(struct bpf_object *)
  
That would set programs autoload flags depending on user defined state
of autocreate flags of struct_ops map.

It might even be accompanied by an API call:

  int bpf_object__infer_struct_ops_maps_autocreate(struct bpf_object *)

That would check which struct_ops maps definitions could be loaded
with current kernel, or report error if there are ambiguities.

Changelog:
- v1 [1] -> v2:
  - fixed memory leak in patch #1 (Kui-Feng);
  - improved error messages in patch #2 (Martin, Andrii);
  - in bad_struct_ops selftest from patch #6 added .test_2
    map member setup (David);
  - added utility functions to capture libbpf log from selftests (David)
  - in selftests replaced usage of ...__open_and_load by separate
    calls to ..._open() and ..._load() (Andrii);
  - removed serial_... in selftest definitions (Andrii);
  - improved comments in selftest struct_ops_autocreate
    from patch #7 (David);
  - removed autoload toggling logic incompatible with shadow variables
    from bpf_map__set_autocreate(), instead struct_ops programs
    autoload property is computed at struct_ops maps load phase,
    see patch #8 (Kui-Feng, Martin, Andrii);
  - added support for SEC("?.struct_ops") and SEC("?.struct_ops.link")
    (Andrii).

[1] https://lore.kernel.org/bpf/20240227204556.17524-1-eddyz87@gmail.com/

Eduard Zingerman (15):
  libbpf: allow version suffixes (___smth) for struct_ops types
  libbpf: tie struct_ops programs to kernel BTF ids, not to local ids
  libbpf: honor autocreate flag for struct_ops maps
  selftests/bpf: test struct_ops map definition with type suffix
  selftests/bpf: utility functions to capture libbpf log in test_progs
  selftests/bpf: bad_struct_ops test
  selftests/bpf: test autocreate behavior for struct_ops maps
  libbpf: sync progs autoload with maps autocreate for struct_ops maps
  selftests/bpf: verify struct_ops autoload/autocreate sync
  libbpf: replace elf_state->st_ops_* fields with SEC_ST_OPS sec_type
  libbpf: struct_ops in SEC("?.struct_ops") and SEC("?.struct_ops.link")
  libbpf: rewrite btf datasec names starting from '?'
  selftests/bpf: test case for SEC("?.struct_ops")
  bpf: allow '?' at the beginning of DATASEC names
  selftests/bpf: test cases for '?' in BTF names

 kernel/bpf/btf.c                              |  17 +-
 tools/lib/bpf/features.c                      |  22 +++
 tools/lib/bpf/libbpf.c                        | 174 ++++++++++++------
 tools/lib/bpf/libbpf_internal.h               |   2 +
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  25 +++
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |   4 +
 .../selftests/bpf/prog_tests/bad_struct_ops.c |  67 +++++++
 tools/testing/selftests/bpf/prog_tests/btf.c  |  46 +++++
 .../bpf/prog_tests/struct_ops_autocreate.c    | 124 +++++++++++++
 .../bpf/prog_tests/test_struct_ops_module.c   |  33 +++-
 .../selftests/bpf/progs/bad_struct_ops.c      |  25 +++
 .../selftests/bpf/progs/bad_struct_ops2.c     |  14 ++
 .../bpf/progs/struct_ops_autocreate.c         |  52 ++++++
 .../selftests/bpf/progs/struct_ops_module.c   |  21 ++-
 tools/testing/selftests/bpf/test_progs.c      |  57 ++++++
 tools/testing/selftests/bpf/test_progs.h      |   3 +
 16 files changed, 614 insertions(+), 72 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bad_struct_ops.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate.c
 create mode 100644 tools/testing/selftests/bpf/progs/bad_struct_ops.c
 create mode 100644 tools/testing/selftests/bpf/progs/bad_struct_ops2.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_autocreate.c

-- 
2.43.0


