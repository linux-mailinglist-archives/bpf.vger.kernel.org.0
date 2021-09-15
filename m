Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 381BB40BC8C
	for <lists+bpf@lfdr.de>; Wed, 15 Sep 2021 02:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbhIOAXe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 20:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbhIOAXd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 20:23:33 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE874C061574
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 17:22:15 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id z18so1934073ybg.8
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 17:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qHwqyM6r5eqOvNeAVLk2tVeqYrOLhiLdZ590lWwVaeg=;
        b=SkDIhvqQVb4ACu556P8rEJEOpGoBnHlmqqj58ozpi//4wMgZLneA75ttCutavo2ACL
         sY7D1B5zM21dxClwv8kkZPSY29qeWO/Ug2zj30e5wVLQ4TfvtvwCCTNbiyCgbCMsvsmH
         Vp/xbplVmu9p8OODqtU+L9QCJqUC6pi+tY2RqkPIerqAtYsEevMRclShsvLYa1Hb83yS
         V5P2GGCymVLeS2WcwdJGyEjaSlP+Y6WdvZ5xobDXmysDIRLr+C3oFwU8jJeKWQlV6ItR
         mr5oO15nFG6vVPxSGEnvQC5TxBiRBqAU1LTfaZYVITtzm1KLGHIKpj9fUsQDGg1bsv55
         vDoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qHwqyM6r5eqOvNeAVLk2tVeqYrOLhiLdZ590lWwVaeg=;
        b=LKYZ10FRLI/KRh6ajOXXZpiLIfsKZT5E+KP58G4ycrYgqHAj/lTiaHYKP7nPYrrtRD
         Anqb63kJD0aN5kH1o3jibg5TmNMOGA4XEwdaUym+CutkVNoFOriIKS8DLyDIi4Kl2RPQ
         jwWtacWsVXU759rhLYSA/bZdCUOK9ZOH4L2fa8L4rw1MQByzEvz3mqw1IRx0a5idz7ld
         AnWojbMWiD5rWGJtr0Cz/NdRzjhYz7Hd31omDLr7laga9Li046AmcryMj9c0xVwezP+f
         B0j/wHNYiAUJbEMNFGCABqM38P1r61071hyP6t5mSnzvNevePhyJvF5MI0dKTWKMppGx
         eCgQ==
X-Gm-Message-State: AOAM530VUswZ/S4mRjqFG/fr5fIbMbDXONQzZSIG5qDdfHvqwg/jXpdG
        ozv3dJokFrh9yV9nd2bc2mvA/Rn/PsPeTCJhrRE=
X-Google-Smtp-Source: ABdhPJwaT04jB3j/YRCRx5IYdmT4lW99L81HfrJDe8dZrZe/Q3tC8kSNH2kELdIFhZbBckX9Frp57lbjs9Sb6Pq88jI=
X-Received: by 2002:a25:bbc4:: with SMTP id c4mr2628792ybk.114.1631665334923;
 Tue, 14 Sep 2021 17:22:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210914223004.244411-1-yhs@fb.com>
In-Reply-To: <20210914223004.244411-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 14 Sep 2021 17:22:03 -0700
Message-ID: <CAEf4BzYfoOotgqVzeQgx-3VeYpAk4ra_QxwW=mi08_2JMqPc7g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 00/11] bpf: add support for new btf kind BTF_KIND_TAG
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 14, 2021 at 3:30 PM Yonghong Song <yhs@fb.com> wrote:
>
> LLVM14 added support for a new C attribute ([1])
>   __attribute__((btf_tag("arbitrary_str")))
> This attribute will be emitted to dwarf ([2]) and pahole
> will convert it to BTF. Or for bpf target, this
> attribute will be emitted to BTF directly ([3], [4]).
> The attribute is intended to provide additional
> information for
>   - struct/union type or struct/union member
>   - static/global variables
>   - static/global function or function parameter.
>
> This new attribute can be used to add attributes
> to kernel codes, e.g., pre- or post- conditions,
> allow/deny info, or any other info in which only
> the kernel is interested. Such attributes will
> be processed by clang frontend and emitted to
> dwarf, converting to BTF by pahole. Ultimiately
> the verifier can use these information for
> verification purpose.
>
> The new attribute can also be used for bpf
> programs, e.g., tagging with __user attributes
> for function parameters, specifying global
> function preconditions, etc. Such information
> may help verifier to detect user program
> bugs.
>
> After this series, pahole dwarf->btf converter
> will be enhanced to support new llvm tag
> for btf_tag attribute. With pahole support,
> we will then try to add a few real use case,
> e.g., __user/__rcu tagging, allow/deny list,
> some kernel function precondition, etc,
> in the kernel.
>
> In the rest of the series, Patches 1-2 had
> kernel support. Patches 3-4 added
> libbpf support. Patch 5 added bpftool
> support. Patches 6-10 added various selftests.
> Patch 11 added documentation for the new kind.
>
>   [1] https://reviews.llvm.org/D106614
>   [2] https://reviews.llvm.org/D106621
>   [3] https://reviews.llvm.org/D106622
>   [4] https://reviews.llvm.org/D109560
>
> Changelog:
>   v2 -> v3:
>     - put NR_BTF_KINDS and BTF_KIND_MAX into enum as well
>     - check component_idx earlier (check_meta stage) in kernel
>     - add more tests
>     - fix misc nits
>   v1 -> v2:
>     - BTF ELF format changed in llvm ([4] above),
>       so cross-board change to use the new format.
>     - Clarified in commit message that BTF_KIND_TAG
>       is not emitted by bpftool btf dump format c.
>     - Fix various comments from Andrii.
>
> Yonghong Song (11):
>   btf: change BTF_KIND_* macros to enums
>   bpf: support for new btf kind BTF_KIND_TAG
>   libbpf: rename btf_{hash,equal}_int to btf_{hash,equal}_int_tag
>   libbpf: add support for BTF_KIND_TAG
>   bpftool: add support for BTF_KIND_TAG
>   selftests/bpf: test libbpf API function btf__add_tag()
>   selftests/bpf: change NAME_NTH/IS_NAME_NTH for BTF_KIND_TAG format
>   selftests/bpf: add BTF_KIND_TAG unit tests
>   selftests/bpf: test BTF_KIND_TAG for deduplication
>   selftests/bpf: add a test with a bpf program with btf_tag attributes
>   docs/bpf: add documentation for BTF_KIND_TAG
>
>  Documentation/bpf/btf.rst                     |  29 +-
>  include/uapi/linux/btf.h                      |  55 ++-
>  kernel/bpf/btf.c                              | 128 +++++
>  tools/bpf/bpftool/btf.c                       |  12 +
>  tools/include/uapi/linux/btf.h                |  55 ++-
>  tools/lib/bpf/btf.c                           |  84 +++-
>  tools/lib/bpf/btf.h                           |  15 +
>  tools/lib/bpf/btf_dump.c                      |   3 +
>  tools/lib/bpf/libbpf.c                        |  31 +-
>  tools/lib/bpf/libbpf.map                      |   2 +
>  tools/lib/bpf/libbpf_internal.h               |   2 +
>  tools/testing/selftests/bpf/btf_helpers.c     |   7 +-
>  tools/testing/selftests/bpf/prog_tests/btf.c  | 441 +++++++++++++++++-
>  .../selftests/bpf/prog_tests/btf_tag.c        |  14 +
>  .../selftests/bpf/prog_tests/btf_write.c      |  21 +
>  tools/testing/selftests/bpf/progs/tag.c       |  39 ++
>  tools/testing/selftests/bpf/test_btf.h        |   3 +
>  17 files changed, 869 insertions(+), 72 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_tag.c
>  create mode 100644 tools/testing/selftests/bpf/progs/tag.c
>
> --
> 2.30.2
>

I've acked every individual patch, but just to make it more clear, for
the series:

Acked-by: Andrii Nakryiko <andrii@kernel.org>
