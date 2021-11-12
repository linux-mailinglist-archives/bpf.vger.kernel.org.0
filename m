Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9E544E137
	for <lists+bpf@lfdr.de>; Fri, 12 Nov 2021 06:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhKLFFX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Nov 2021 00:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbhKLFFX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Nov 2021 00:05:23 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38925C061766
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 21:02:33 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id y1so7455249plk.10
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 21:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M0RF3iRMxgW4xyDdcYpZABSEVhk5i9qnuxjM6v9dYKs=;
        b=P6wv/lad+jq4pv9vCumMHC+//Lo6Fc4mmpLQpUaxaQoEFwXCEIGGZC56plrS4lpOAf
         S984NWJ3AwRN3U3uu+2EDw+YL+Nw14cQU7rzYAf1gF0h4F0Qmz7StkKqQq0CcqwGeGTR
         2OMkvjAPqGGrm6y+DliV0SpIKiCG66m0FWgHQDYcBcq5SDRD7uoELqCyOhVOl99OeVyD
         t4CMekecPaZnYta0Fbs6P+B///sk2SeTWKV10/Q+LQDcypxsuaS1vlcAJoxgh9x2Za1E
         Jaulm3dI5h+4+hxHaLtjF90uaRMhUp5AImljSq2XEDxe8aZNn6G/tpZaCX7V3QQHh0Ai
         VkKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M0RF3iRMxgW4xyDdcYpZABSEVhk5i9qnuxjM6v9dYKs=;
        b=vZqh/KmnH3Zuy7LUeBVSTz8znj+5yN/09OWwxyPMM6RA1XlDzPQ3jmcEEb+7A8QZty
         8gAeh51amQoP2jMm1t3zGJtTEbV38PtCjRNgSuxTKkZP8RzqRQKo8Zrrb/C11QdA/phR
         lBfQQnoO7TyH1seyt3XD/aP1NW6YYJDuDjfBCrTH4q4cqaL0zU8OrGTMS/gxjB+AJ6M/
         cKkG9NOKuAt5sxCZr0ypEvy1Dbq0nzkLnXY1Y5DtzYIXI2xMWP0/pUGMVdKiWhLDUzMb
         wdu+n+twmVljFIpuPA9Oz4jykAFh+DCTFy//KKAV6fuqF6ee2HyUh8DFN3wrfnpdWQf1
         xECA==
X-Gm-Message-State: AOAM530uFGbwpCiMBre1L4x+a4wjKAspPeerRZ7w1QX/9ZgZCfCORz23
        Z/+ALmssGmdly1Cn2I7YMIs=
X-Google-Smtp-Source: ABdhPJxMGZdDe/feHQOWqYvKCfDGC2Lk/xuarn+pYxdIlM2V31Q8IklMoMJ83XCTWyIyTo8kC9U8zw==
X-Received: by 2002:a17:90b:1c0e:: with SMTP id oc14mr33708397pjb.113.1636693352587;
        Thu, 11 Nov 2021 21:02:32 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:3dc4])
        by smtp.gmail.com with ESMTPSA id d19sm4820350pfl.169.2021.11.11.21.02.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Nov 2021 21:02:32 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v2 bpf-next 00/12] bpf: CO-RE support in the kernel
Date:   Thu, 11 Nov 2021 21:02:18 -0800
Message-Id: <20211112050230.85640-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

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

Alexei Starovoitov (12):
  libbpf: s/btf__type_by_id/btf_type_by_id/.
  bpf: Rename btf_member accessors.
  bpf: Prepare relo_core.c for kernel duty.
  bpf: Define enum bpf_core_relo_kind as uapi.
  bpf: Pass a set of bpf_core_relo-s to prog_load command.
  bpf: Add bpf_core_add_cands() and wire it into
    bpf_core_apply_relo_insn().
  libbpf: Use CO-RE in the kernel in light skeleton.
  libbpf: Support init of inner maps in light skeleton.
  selftests/bpf: Convert kfunc test with CO-RE to lskel.
  selftests/bpf: Improve inner_map test coverage.
  selftests/bpf: Convert map_ptr_kern test to use light skeleton.
  selftests/bpf: Additional test for CO-RE in the kernel.

 include/linux/bpf.h                           |   3 +
 include/linux/btf.h                           |  90 ++++++++-
 include/uapi/linux/bpf.h                      |  78 +++++++-
 kernel/bpf/Makefile                           |   4 +
 kernel/bpf/bpf_struct_ops.c                   |   6 +-
 kernel/bpf/btf.c                              | 187 +++++++++++++++++-
 kernel/bpf/syscall.c                          |   2 +-
 kernel/bpf/verifier.c                         |  71 +++++++
 net/ipv4/bpf_tcp_ca.c                         |   6 +-
 tools/include/uapi/linux/bpf.h                |  78 +++++++-
 tools/lib/bpf/bpf_gen_internal.h              |   4 +
 tools/lib/bpf/btf.c                           |   2 +-
 tools/lib/bpf/gen_loader.c                    |  68 ++++++-
 tools/lib/bpf/libbpf.c                        | 112 ++++++++---
 tools/lib/bpf/libbpf_internal.h               |   2 +-
 tools/lib/bpf/relo_core.c                     | 171 ++++++++++------
 tools/lib/bpf/relo_core.h                     |  71 -------
 tools/testing/selftests/bpf/Makefile          |   3 +-
 .../selftests/bpf/prog_tests/core_kern.c      |  21 ++
 .../selftests/bpf/prog_tests/kfunc_call.c     |  10 +-
 .../selftests/bpf/prog_tests/map_ptr.c        |  16 +-
 tools/testing/selftests/bpf/progs/core_kern.c |  60 ++++++
 .../selftests/bpf/progs/map_ptr_kern.c        |  16 +-
 23 files changed, 877 insertions(+), 204 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/core_kern.c
 create mode 100644 tools/testing/selftests/bpf/progs/core_kern.c

-- 
2.30.2

