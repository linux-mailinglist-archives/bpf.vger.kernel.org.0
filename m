Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83EBC4654C5
	for <lists+bpf@lfdr.de>; Wed,  1 Dec 2021 19:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352129AbhLASOP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Dec 2021 13:14:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352098AbhLASOG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Dec 2021 13:14:06 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB80C061756
        for <bpf@vger.kernel.org>; Wed,  1 Dec 2021 10:10:43 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id np6-20020a17090b4c4600b001a90b011e06so2331808pjb.5
        for <bpf@vger.kernel.org>; Wed, 01 Dec 2021 10:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ti9K3fYiaLxPKKSCJ8HRx9mhZhZy1t7d7UBcpiq/0Z4=;
        b=RVffyA11eiCGza2yOhH8T2g4fvsTkhzw/V8EdG0sqY/NlQrx7SqF6TqmegHPVODfEZ
         syMlhrWu7TCTyy+0s2t3gISaHRuNuAK9NzNF105SdJDE8NWx5eyM6NrcMF3XSXu1F3LR
         ddSa/m06a7kdmsPGN8+XZdXHBnR5IvVU5ws7PfJ61kzPlE1R7bprzTKOxgffpqq0Y6lY
         8qUrDMs5YpMRO3K6DxEwSDXijYa3EQEoCEkHcCWU35e13QxQLjPWhbRf5LpNptlWZmry
         y4JP4ehzLoWWpkCVj1kaKFlIGVJiCggvQDb2d5Sm4H5NCEsIbQ7Tqb7F+IDdoPn9+ZFk
         /VAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ti9K3fYiaLxPKKSCJ8HRx9mhZhZy1t7d7UBcpiq/0Z4=;
        b=345HzXff320BPNi1s3omwj1RsMLphQEU47JZw8w+XDMBHMLJsdwE3RQjUbKTONpB6y
         iy5yGc/dptI85NkH7qJuhf3YCclw0plHk1Bq4lEggaQZ4M98MKzgIMJKWR3TMo2YbK/n
         vF42kQxDDGlR5ia1DoRsm33DClmdMgXj5FH6o8axR2RZwvUXFoLxY+Kp3Mb64q5paYzM
         xcxVG3etvaum54Z9uNSIviwmK4btTuf7E4Tz5XvBTZ8AqkYAfW7j199SDweYuBBk7X2t
         BTAQtpr9jikWY02HuZgCol43Z+UC2So1OpVCMqEEJtEP4iQ6f/HldWu2MKsHOoRpT5gQ
         2HBg==
X-Gm-Message-State: AOAM532vzzyQguakAU/89lJ24N9E1zxDzPA9nuMvuWrDFVsuyZydG3uS
        Vj5wFInRSbxDCV13Pi3OK4g=
X-Google-Smtp-Source: ABdhPJzOVHfAsMZ7CwKp2UMcO/cwOd0gzsuf1Bl9IlLtRY1qUrOXLTUt0YgwRZxY8jK5uKhC4CfY+A==
X-Received: by 2002:a17:903:249:b0:143:c077:59d3 with SMTP id j9-20020a170903024900b00143c07759d3mr9097048plh.26.1638382242631;
        Wed, 01 Dec 2021 10:10:42 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:620c])
        by smtp.gmail.com with ESMTPSA id oa17sm5198pjb.37.2021.12.01.10.10.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Dec 2021 10:10:42 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v5 bpf-next 00/17] bpf: CO-RE support in the kernel
Date:   Wed,  1 Dec 2021 10:10:23 -0800
Message-Id: <20211201181040.23337-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

v4->v5:
. Reduce number of memory allocations in candidate cache logic
. Fix couple UAF issues
. Add Andrii's patch to cleanup struct bpf_core_cand
. More thorough tests
. Planned followups:
  - support -v in lskel
  - move struct bpf_core_spec out of bpf_core_apply_relo_insn to
    reduce stack usage
  - implement bpf_core_types_are_compat

v3->v4:
. complete refactor of find candidates logic.
  Now it has small permanent cache.
. Fix a bug in gen_loader related to attach_kind.
. Fix BTF log size limit.
. More tests.

v2->v3:
. addressed Andrii's feedback in every patch.
  New field in union bpf_attr changed from "core_relo" to "core_relos".
. added one more test and checkpatch.pl-ed the set.

v1->v2:
. Refactor uapi to pass 'struct bpf_core_relo' from LLVM into libbpf and further
into the kernel instead of bpf_core_apply_relo() bpf helper. Because of this
change the CO-RE algorithm has an ability to log error and debug events through
the standard bpf verifer log mechanism which was not possible with helper
approach.
. #define RELO_CORE macro was removed and replaced with btf_member_bit_offset() patch.

This set introduces CO-RE support in the kernel.
There are several reasons to add such support:
1. It's a step toward signed BPF programs.
2. It allows golang like languages that struggle to adopt libbpf
   to take advantage of CO-RE powers.
3. Currently the field accessed by 'ldx [R1 + 10]' insn is recognized
   by the verifier purely based on +10 offset. If R1 points to a union
   the verifier picks one of the fields at this offset.
   With CO-RE the kernel can disambiguate the field access.

Alexei Starovoitov (16):
  libbpf: Replace btf__type_by_id() with btf_type_by_id().
  bpf: Rename btf_member accessors.
  bpf: Prepare relo_core.c for kernel duty.
  bpf: Define enum bpf_core_relo_kind as uapi.
  bpf: Pass a set of bpf_core_relo-s to prog_load command.
  bpf: Adjust BTF log size limit.
  bpf: Add bpf_core_add_cands() and wire it into
    bpf_core_apply_relo_insn().
  libbpf: Use CO-RE in the kernel in light skeleton.
  libbpf: Support init of inner maps in light skeleton.
  libbpf: Clean gen_loader's attach kind.
  selftests/bpf: Add lskel version of kfunc test.
  selftests/bpf: Improve inner_map test coverage.
  selftests/bpf: Convert map_ptr_kern test to use light skeleton.
  selftests/bpf: Additional test for CO-RE in the kernel.
  selftests/bpf: Revert CO-RE removal in test_ksyms_weak.
  selftests/bpf: Add CO-RE relocations to verifier scale test.

Andrii Nakryiko (1):
  libbpf: Cleanup struct bpf_core_cand.

 include/linux/bpf.h                           |   8 +
 include/linux/btf.h                           |  89 +++-
 include/uapi/linux/bpf.h                      |  78 +++-
 kernel/bpf/Makefile                           |   4 +
 kernel/bpf/bpf_struct_ops.c                   |   6 +-
 kernel/bpf/btf.c                              | 396 +++++++++++++++++-
 kernel/bpf/syscall.c                          |   2 +-
 kernel/bpf/verifier.c                         |  76 ++++
 net/ipv4/bpf_tcp_ca.c                         |   6 +-
 tools/include/uapi/linux/bpf.h                |  78 +++-
 tools/lib/bpf/bpf_gen_internal.h              |   4 +
 tools/lib/bpf/btf.c                           |   2 +-
 tools/lib/bpf/gen_loader.c                    |  72 +++-
 tools/lib/bpf/libbpf.c                        | 147 ++++---
 tools/lib/bpf/libbpf_internal.h               |   2 +-
 tools/lib/bpf/relo_core.c                     | 179 +++++---
 tools/lib/bpf/relo_core.h                     |  73 +---
 tools/testing/selftests/bpf/Makefile          |   5 +-
 .../selftests/bpf/prog_tests/core_kern.c      |  14 +
 .../selftests/bpf/prog_tests/kfunc_call.c     |  24 ++
 .../selftests/bpf/prog_tests/map_ptr.c        |  16 +-
 tools/testing/selftests/bpf/progs/core_kern.c | 104 +++++
 .../selftests/bpf/progs/map_ptr_kern.c        |  16 +-
 .../selftests/bpf/progs/test_ksyms_weak.c     |   2 +-
 .../selftests/bpf/progs/test_verif_scale2.c   |   4 +-
 25 files changed, 1179 insertions(+), 228 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/core_kern.c
 create mode 100644 tools/testing/selftests/bpf/progs/core_kern.c

-- 
2.30.2

