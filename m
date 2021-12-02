Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3C87466A94
	for <lists+bpf@lfdr.de>; Thu,  2 Dec 2021 20:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234415AbhLBTqC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Dec 2021 14:46:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234089AbhLBTqA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Dec 2021 14:46:00 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50678C06174A
        for <bpf@vger.kernel.org>; Thu,  2 Dec 2021 11:42:38 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id f9so2560394ybq.10
        for <bpf@vger.kernel.org>; Thu, 02 Dec 2021 11:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4fY10ZQQgyrFYsUlat/fPvaNNLcOAa//6818rxzpS9s=;
        b=OQtDPTddtnk4wG/feBF3OWoztqYTbHBu2r7YjJzy+AMbX064Qhjgp+5zrGmQLLY0Po
         TzBY2CaO3ayMU3WpW87HxWImE0gexIrUCN01U5F5MKBso0O5kLgD20yCMBZgXkiiN3Tp
         MgQHZZh2nPqoGW8mifox3rdkCyZuxuSVtD7SAOQD00BoDnyNVU5zsKrRNjJX6thF/iTY
         G/fev7tXlRDQdeauwc10FHb9hyWFMqrMXNdb50Sf0X/fQRby10w7Mjnj/DRamxB4Ok05
         JzdHB7ubI9JXd1TOZU5XWU1UIDHqyvDRlTCg80x6Qpz2JekNsPkGMmC4wxBLn0olM/b2
         Iaew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4fY10ZQQgyrFYsUlat/fPvaNNLcOAa//6818rxzpS9s=;
        b=V3fbPSjij0NHMy202FoPMsCaM06Cv6UGxhU4RpNiFzBUXEbzFVk3jLalhTw6AyUtD7
         Ax8m0HvdlKYD5Yjh+0xCnWVK82ZYqIIoBGcOV8vPatsz1N81BSbwWxChQoRR4rnzVO6Z
         oExdZXE9wgpK7j1IBZOOKEtxYZcCgNecTIkGyhr+lHDAaxEv28jR6ErtBf8d3xnoPULc
         KaObReaMfN2HLC3GKSZEfr6/PvRmb+20CBKmvnXMh27qCXJgeLVHht5o5EX2M2ngNCKh
         aSLq4F7lYAfo5XJPsmoEXUxNzB+n2YL6tPHTTUtlbAlDgQ4dpWrJBhDBByRCyEm1SuSq
         fjAg==
X-Gm-Message-State: AOAM53050BrQUZ9zXDPMXWTIRp4USa+kjPtQb0zei/h2BA1fiVZHhbi+
        0P2E3fVl6AOz4h82yXqoMj4dn8p+iEePEpr6+xoVLOvqrpE=
X-Google-Smtp-Source: ABdhPJzm44Z9qOY2E+qf6KMouS5gwnbo6FsLcdYawPBXHDzUkGWmNWPTiXtO1PCtz0LyOS1JdHX1Gxjj4i31PDm6Oec=
X-Received: by 2002:a05:6902:1006:: with SMTP id w6mr19157065ybt.252.1638474157262;
 Thu, 02 Dec 2021 11:42:37 -0800 (PST)
MIME-Version: 1.0
References: <20211201181040.23337-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20211201181040.23337-1-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 2 Dec 2021 11:42:26 -0800
Message-ID: <CAEf4BzZ0Lc9jwtdsAp7Ka-if0tuxX3Uxv6qiN6sGa14Exdny5w@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 00/17] bpf: CO-RE support in the kernel
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 1, 2021 at 10:10 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> v4->v5:
> . Reduce number of memory allocations in candidate cache logic
> . Fix couple UAF issues
> . Add Andrii's patch to cleanup struct bpf_core_cand
> . More thorough tests
> . Planned followups:
>   - support -v in lskel
>   - move struct bpf_core_spec out of bpf_core_apply_relo_insn to
>     reduce stack usage
>   - implement bpf_core_types_are_compat
>

Applied to bpf-next, thanks.

> v3->v4:
> . complete refactor of find candidates logic.
>   Now it has small permanent cache.
> . Fix a bug in gen_loader related to attach_kind.
> . Fix BTF log size limit.
> . More tests.
>
> v2->v3:
> . addressed Andrii's feedback in every patch.
>   New field in union bpf_attr changed from "core_relo" to "core_relos".
> . added one more test and checkpatch.pl-ed the set.
>
> v1->v2:
> . Refactor uapi to pass 'struct bpf_core_relo' from LLVM into libbpf and further
> into the kernel instead of bpf_core_apply_relo() bpf helper. Because of this
> change the CO-RE algorithm has an ability to log error and debug events through
> the standard bpf verifer log mechanism which was not possible with helper
> approach.
> . #define RELO_CORE macro was removed and replaced with btf_member_bit_offset() patch.
>
> This set introduces CO-RE support in the kernel.
> There are several reasons to add such support:
> 1. It's a step toward signed BPF programs.
> 2. It allows golang like languages that struggle to adopt libbpf
>    to take advantage of CO-RE powers.
> 3. Currently the field accessed by 'ldx [R1 + 10]' insn is recognized
>    by the verifier purely based on +10 offset. If R1 points to a union
>    the verifier picks one of the fields at this offset.
>    With CO-RE the kernel can disambiguate the field access.
>
> Alexei Starovoitov (16):
>   libbpf: Replace btf__type_by_id() with btf_type_by_id().
>   bpf: Rename btf_member accessors.
>   bpf: Prepare relo_core.c for kernel duty.
>   bpf: Define enum bpf_core_relo_kind as uapi.
>   bpf: Pass a set of bpf_core_relo-s to prog_load command.
>   bpf: Adjust BTF log size limit.
>   bpf: Add bpf_core_add_cands() and wire it into
>     bpf_core_apply_relo_insn().
>   libbpf: Use CO-RE in the kernel in light skeleton.
>   libbpf: Support init of inner maps in light skeleton.
>   libbpf: Clean gen_loader's attach kind.
>   selftests/bpf: Add lskel version of kfunc test.
>   selftests/bpf: Improve inner_map test coverage.
>   selftests/bpf: Convert map_ptr_kern test to use light skeleton.
>   selftests/bpf: Additional test for CO-RE in the kernel.
>   selftests/bpf: Revert CO-RE removal in test_ksyms_weak.
>   selftests/bpf: Add CO-RE relocations to verifier scale test.
>
> Andrii Nakryiko (1):
>   libbpf: Cleanup struct bpf_core_cand.
>
>  include/linux/bpf.h                           |   8 +
>  include/linux/btf.h                           |  89 +++-
>  include/uapi/linux/bpf.h                      |  78 +++-
>  kernel/bpf/Makefile                           |   4 +
>  kernel/bpf/bpf_struct_ops.c                   |   6 +-
>  kernel/bpf/btf.c                              | 396 +++++++++++++++++-
>  kernel/bpf/syscall.c                          |   2 +-
>  kernel/bpf/verifier.c                         |  76 ++++
>  net/ipv4/bpf_tcp_ca.c                         |   6 +-
>  tools/include/uapi/linux/bpf.h                |  78 +++-
>  tools/lib/bpf/bpf_gen_internal.h              |   4 +
>  tools/lib/bpf/btf.c                           |   2 +-
>  tools/lib/bpf/gen_loader.c                    |  72 +++-
>  tools/lib/bpf/libbpf.c                        | 147 ++++---
>  tools/lib/bpf/libbpf_internal.h               |   2 +-
>  tools/lib/bpf/relo_core.c                     | 179 +++++---
>  tools/lib/bpf/relo_core.h                     |  73 +---
>  tools/testing/selftests/bpf/Makefile          |   5 +-
>  .../selftests/bpf/prog_tests/core_kern.c      |  14 +
>  .../selftests/bpf/prog_tests/kfunc_call.c     |  24 ++
>  .../selftests/bpf/prog_tests/map_ptr.c        |  16 +-
>  tools/testing/selftests/bpf/progs/core_kern.c | 104 +++++
>  .../selftests/bpf/progs/map_ptr_kern.c        |  16 +-
>  .../selftests/bpf/progs/test_ksyms_weak.c     |   2 +-
>  .../selftests/bpf/progs/test_verif_scale2.c   |   4 +-
>  25 files changed, 1179 insertions(+), 228 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/core_kern.c
>  create mode 100644 tools/testing/selftests/bpf/progs/core_kern.c
>
> --
> 2.30.2
>
