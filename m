Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2A4445B418
	for <lists+bpf@lfdr.de>; Wed, 24 Nov 2021 07:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233093AbhKXGFX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Nov 2021 01:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbhKXGFV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Nov 2021 01:05:21 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AB8C061574
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 22:02:12 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id gb13-20020a17090b060d00b001a674e2c4a8so1609405pjb.4
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 22:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bl5vJebf+uHS1AmYhuojm8/9ZcGunu7jgbFHCZx5c4Q=;
        b=oi5u2BHqp0/oetlxpCpUk732xjdjnOhQ3LcwAdoM/3qLmUnsYGEA87En5g5QLkFbkd
         Fd+6zcHaTengN1bOGqGQW+Bo7sMFaF7YKLcvQvCGipYYtX0eWa4LnAD2SCRH6W4qkNFK
         R3rn2mj571e06qew9udJiewTZD6VbRidQGwsO7NkKqGf3wdI4v+kz9P317jzFlT+BFNj
         cUyvRY7XxHCAwwnGowsmZwtDJYhbEINpSHOlLqmnD89qalEs53dhCoJ3vyB1gg7qfhNn
         eEek1zXwJqpICHuudNSA1/mJqirutGav7k5KnZk3m61T2pWBiwFqOUDPVJjZyNfVLEnL
         x2/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bl5vJebf+uHS1AmYhuojm8/9ZcGunu7jgbFHCZx5c4Q=;
        b=1htVoEslZfbrQbxLsIC1HwRFCxyXO4qUZqxW8v7frouVWLYFHP7QBXVKlDUOz5+T8h
         5r7xJtjhriGUYssRo/ffpbqK7kks7WeGzGWxKKDfgJOLqwyslZ0JKp5hirYbGhit3YpJ
         xH8jA6mKjNCCwDUfjsY96fJtGwmw99GJHcsYvBZJuJSo3rAuK7FLejl8vC+LmELibX75
         s43Cr52WawTcQ9OsmYPXJJ4b7hRufldGzJ/LZwONcFY/xN7uJIoNiaxo1zQw4+UH/hk8
         Mi6A+U1358e7+fH4Jo5d8fHZfi+YuVQxHko5yR6jl5tyzymAiF1sE5n9rumoeU1n3XYw
         obOA==
X-Gm-Message-State: AOAM53058UP1DgazldGlxLoQ6STLOgWxQO8C1E/8EU6brwgcvI5VPL4U
        rp5uveCousoiOJx+2RbAOdU=
X-Google-Smtp-Source: ABdhPJx+zOVKnzx369yYxehphLeDXKDiSmGJe5XDFrkMEvoBti6A5wYiw6j0TNpid3HsHFhZmYadEg==
X-Received: by 2002:a17:902:b588:b0:143:b732:834 with SMTP id a8-20020a170902b58800b00143b7320834mr14782650pls.22.1637733732418;
        Tue, 23 Nov 2021 22:02:12 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:8fd1])
        by smtp.gmail.com with ESMTPSA id q18sm15667721pfj.46.2021.11.23.22.02.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Nov 2021 22:02:11 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v4 bpf-next 00/16] bpf: CO-RE support in the kernel
Date:   Tue, 23 Nov 2021 22:01:53 -0800
Message-Id: <20211124060209.493-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

v3->v4:
. complete refactor of find candidates logic.
  Now it has small permanent cache.
  I haven't completed testing of all corner cases,
  but the patches are clean enough for review.
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

 include/linux/bpf.h                           |   8 +
 include/linux/btf.h                           |  89 +++++-
 include/uapi/linux/bpf.h                      |  78 ++++-
 kernel/bpf/Makefile                           |   4 +
 kernel/bpf/bpf_struct_ops.c                   |   6 +-
 kernel/bpf/btf.c                              | 300 +++++++++++++++++-
 kernel/bpf/syscall.c                          |   2 +-
 kernel/bpf/verifier.c                         |  76 +++++
 net/ipv4/bpf_tcp_ca.c                         |   6 +-
 tools/include/uapi/linux/bpf.h                |  78 ++++-
 tools/lib/bpf/bpf_gen_internal.h              |   4 +
 tools/lib/bpf/btf.c                           |   2 +-
 tools/lib/bpf/gen_loader.c                    |  72 ++++-
 tools/lib/bpf/libbpf.c                        | 116 +++++--
 tools/lib/bpf/libbpf_internal.h               |   2 +-
 tools/lib/bpf/relo_core.c                     | 179 +++++++----
 tools/lib/bpf/relo_core.h                     |  73 +----
 tools/testing/selftests/bpf/Makefile          |   5 +-
 .../selftests/bpf/prog_tests/core_kern.c      |  14 +
 .../selftests/bpf/prog_tests/kfunc_call.c     |  24 ++
 .../selftests/bpf/prog_tests/map_ptr.c        |  16 +-
 tools/testing/selftests/bpf/progs/core_kern.c |  87 +++++
 .../selftests/bpf/progs/map_ptr_kern.c        |  16 +-
 .../selftests/bpf/progs/test_ksyms_weak.c     |   2 +-
 .../selftests/bpf/progs/test_verif_scale2.c   |   4 +-
 25 files changed, 1050 insertions(+), 213 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/core_kern.c
 create mode 100644 tools/testing/selftests/bpf/progs/core_kern.c

-- 
2.30.2

