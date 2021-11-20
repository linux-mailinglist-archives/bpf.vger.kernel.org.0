Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE3FF457ACA
	for <lists+bpf@lfdr.de>; Sat, 20 Nov 2021 04:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234793AbhKTDgI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Nov 2021 22:36:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233478AbhKTDgE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Nov 2021 22:36:04 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5345C061574
        for <bpf@vger.kernel.org>; Fri, 19 Nov 2021 19:32:58 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id r130so10945692pfc.1
        for <bpf@vger.kernel.org>; Fri, 19 Nov 2021 19:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZmF24yrzEw00EzVXLQohzQU9+idce0hqZv+zSNXjQLQ=;
        b=GNtAo1vJ7eI8VPa63p198k1v9OPhBJ5KAPcxelrlGsV8kUO0SMCI2jh8t1mKrSM1rX
         DqsJYZtYT63SbFiId3MSJahAB+M2isls00iX46few1zDPCSTnLwAvPkgvfpaYEFnF49u
         AqS0Myp5SoZw9aARCqYwkOPSKhb0/LiPvXfrAsU94Z0CG9qyXPU+yXHcItB1dryAyOht
         biqv2RE4dUo913hn1E9sRBDtY9pmMLo59HdLVNDJ215+ADslUk0G5zlW1LxGnRPT3Mvq
         ulc67smy9+afW5TbveDzzi4ih/eyik9v/ebnGKW782BGZA+lxHWTKYJFSxkjKYSUsygg
         tLhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZmF24yrzEw00EzVXLQohzQU9+idce0hqZv+zSNXjQLQ=;
        b=3WWwvyMnvF1AE56lPFwaVc6vGeNrlebpIT0L3yzUtm4SgE1pWFa1RccVSkPEVFm1WO
         ISY58NxxPI9NvPycNcnZwH/MR84rs0PAxqKxXF6ik6SlPRNrzgOynRhhUqhVksAU715v
         BaynTuhVkxg5mBJB7YMMsDiQ/yorf830m4StayPA1FtkKHc+pdJ70+pAxUXPcbiDeQAp
         /N7xzfOKT9DeKanfQi36EV6zszFSRZqWbPY+Lb3edRZ7Y/h0qtMu/C45Hx1IHcPoGeAD
         mk5uY16jkSFoBcAbpszQji/nQCxC07IYm4m5Uuu7txb17EVqLAGCw3ObsVV7snmCJ8md
         CYDQ==
X-Gm-Message-State: AOAM5310rIsj/TTaToJQRh9gSUo3LNtBxp3Ngbl+SsF42TX0ZfHagzfH
        h3qyymJSUfNGNdLIuBcyn8I=
X-Google-Smtp-Source: ABdhPJz1W7wWkr2R+GoMnDvq2Bbms7jEOrRojkpNPhleA/8anNAiJwA1XNf6pFLXsmLT6hid2pYV6w==
X-Received: by 2002:a63:2b03:: with SMTP id r3mr6156344pgr.328.1637379178137;
        Fri, 19 Nov 2021 19:32:58 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:a858])
        by smtp.gmail.com with ESMTPSA id w37sm775273pgk.87.2021.11.19.19.32.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Nov 2021 19:32:57 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v3 bpf-next 00/13] bpf: CO-RE support in the kernel
Date:   Fri, 19 Nov 2021 19:32:42 -0800
Message-Id: <20211120033255.91214-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

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

Alexei Starovoitov (13):
  libbpf: Replace btf__type_by_id() with btf_type_by_id().
  bpf: Rename btf_member accessors.
  bpf: Prepare relo_core.c for kernel duty.
  bpf: Define enum bpf_core_relo_kind as uapi.
  bpf: Pass a set of bpf_core_relo-s to prog_load command.
  bpf: Add bpf_core_add_cands() and wire it into
    bpf_core_apply_relo_insn().
  libbpf: Use CO-RE in the kernel in light skeleton.
  libbpf: Support init of inner maps in light skeleton.
  selftests/bpf: Add lskel version of kfunc test.
  selftests/bpf: Improve inner_map test coverage.
  selftests/bpf: Convert map_ptr_kern test to use light skeleton.
  selftests/bpf: Additional test for CO-RE in the kernel.
  selftest/bpf: Revert CO-RE removal in test_ksyms_weak.

 include/linux/bpf.h                           |  11 +
 include/linux/btf.h                           |  89 ++++++++-
 include/uapi/linux/bpf.h                      |  78 +++++++-
 kernel/bpf/Makefile                           |   4 +
 kernel/bpf/bpf_struct_ops.c                   |   6 +-
 kernel/bpf/btf.c                              | 188 +++++++++++++++++-
 kernel/bpf/syscall.c                          |   2 +-
 kernel/bpf/verifier.c                         |  77 +++++++
 net/ipv4/bpf_tcp_ca.c                         |   6 +-
 tools/include/uapi/linux/bpf.h                |  78 +++++++-
 tools/lib/bpf/bpf_gen_internal.h              |   4 +
 tools/lib/bpf/btf.c                           |   2 +-
 tools/lib/bpf/gen_loader.c                    |  68 ++++++-
 tools/lib/bpf/libbpf.c                        | 116 +++++++----
 tools/lib/bpf/libbpf_internal.h               |   2 +-
 tools/lib/bpf/relo_core.c                     | 179 +++++++++++------
 tools/lib/bpf/relo_core.h                     |  71 +------
 tools/testing/selftests/bpf/Makefile          |   5 +-
 .../selftests/bpf/prog_tests/core_kern.c      |  14 ++
 .../selftests/bpf/prog_tests/kfunc_call.c     |  24 +++
 .../selftests/bpf/prog_tests/ksyms_btf.c      |   4 +-
 .../selftests/bpf/prog_tests/map_ptr.c        |  16 +-
 tools/testing/selftests/bpf/progs/core_kern.c |  60 ++++++
 .../selftests/bpf/progs/map_ptr_kern.c        |  16 +-
 .../selftests/bpf/progs/test_ksyms_weak.c     |   2 +-
 25 files changed, 911 insertions(+), 211 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/core_kern.c
 create mode 100644 tools/testing/selftests/bpf/progs/core_kern.c

-- 
2.30.2

