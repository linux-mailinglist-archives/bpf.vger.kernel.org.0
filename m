Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B288151E1E8
	for <lists+bpf@lfdr.de>; Sat,  7 May 2022 01:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236265AbiEFWjM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 May 2022 18:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444836AbiEFWjL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 May 2022 18:39:11 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFD32BCD
        for <bpf@vger.kernel.org>; Fri,  6 May 2022 15:35:24 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id r17so5665076iln.9
        for <bpf@vger.kernel.org>; Fri, 06 May 2022 15:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3jJTkdVDvrdW9CKUalgtGPKsUCdwQfgBV3+gSHDgUDY=;
        b=Vw80u0cUZ4S/rQ30HqfuFGR6j1xfzmwNyOEg3beqISL4JVXL2oppPFjwtLmumgMAOx
         6/GdM7jyhXxcXt7DELqbWaIYh/T6Y/nQB16a3E82/lqreSOsfVANSq5Mnh56KwYLixOv
         qEYNeCD6VrKOwKQtxMXWMurLu+zn6YTzBfAYQCkbSa8RBqUybhAwSg6qd8W90zLHwrzm
         BWjdVdMv7rIcewhB2IoAh8G86hk7ty/aPUs40G5kxcyWy45GD+YRt9oLldi36uWiTQWI
         btYMCIkVbZf8FMBm09aQegodRrRB1L6kU4C4wbjxvGyN2MDh/q5CFqXg+WhFcj7qNobt
         E2Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3jJTkdVDvrdW9CKUalgtGPKsUCdwQfgBV3+gSHDgUDY=;
        b=zUV/TQrVJuha5sqaLlcuj0pqKzZZsGlfLvDyMU9dHrZyM4/XCypL3oE4H+3XyOlQH1
         5VhyorCjbF2Do8lu5AI9APHVSL1raE/qD1T8uacg5ZGuLMrmWqIM1bBCWNv22ukjOqxl
         vqGR9jg5AsvaY8cXfMCNvUMhd5sg1n7JG4Vr77IKFZRx007uTwf6x//ylA6X+7e/Iv/q
         SN7lQZ1j1n97IWoFrZrkkT+ikQN+lcTuUUky6Ax+DjzTx70Tbot7ejED1pjnOTgED3CB
         C2DkpA5YCsMhzvXpw6e3laGpvlVt5dgf8dt8UpIXCpq7wcu3dCukoEKjVFNoHntSoPL/
         S1nQ==
X-Gm-Message-State: AOAM530XOE/LJeZe/I9lsGRQ7oYikzw1/w8P2o1p06Rf4HNKjOz+DCqo
        MqfEOdqqPT2ZH/P/FmJpuO5ZtyV5RVz2XZRD2pY=
X-Google-Smtp-Source: ABdhPJw1v0Thi275rTFc/bJdGn2tY3PA6TgsgObDKWQvefc5IFl3G0GG81YmOGxTYHdhnzdVMfonJw8nyPzJypHS7z8=
X-Received: by 2002:a05:6e02:1b82:b0:2cf:199f:3b4b with SMTP id
 h2-20020a056e021b8200b002cf199f3b4bmr2144381ili.71.1651876523863; Fri, 06 May
 2022 15:35:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220428211059.4065379-1-joannelkoong@gmail.com>
In-Reply-To: <20220428211059.4065379-1-joannelkoong@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 6 May 2022 15:35:13 -0700
Message-ID: <CAEf4BzZ_trN92VwrcqFuM0R0EgZd+R9i-qUOqTMHi0-YN-GdJw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/6] Dynamic pointers
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 28, 2022 at 2:11 PM Joanne Koong <joannelkoong@gmail.com> wrote=
:
>
> This patchset implements the basics of dynamic pointers in bpf.
>
> A dynamic pointer (struct bpf_dynptr) is a pointer that stores extra meta=
data
> alongside the address it points to. This abstraction is useful in bpf, gi=
ven
> that every memory access in a bpf program must be safe. The verifier and =
bpf
> helper functions can use the metadata to enforce safety guarantees for th=
ings
> such as dynamically sized strings and kernel heap allocations.
>
> From the program side, the bpf_dynptr is an opaque struct and the verifie=
r
> will enforce that its contents are never written to by the program.
> It can only be written to through specific bpf helper functions.
>
> There are several uses cases for dynamic pointers in bpf programs. A list=
 of
> some are: dynamically sized ringbuf reservations without any extra memcpy=
s,
> dynamic string parsing and memory comparisons, dynamic memory allocations=
 that
> can be persisted in a map, and dynamic parsing of sk_buff and xdp_md pack=
et
> data.
>
> At a high-level, the patches are as follows:
> 1/6 - Adds MEM_UNINIT as a bpf_type_flag
> 2/6 - Adds verifier support for dynptrs and implements malloc dynptrs
> 3/6 - Adds dynptr support for ring buffers
> 4/6 - Adds bpf_dynptr_read and bpf_dynptr_write
> 5/6 - Adds dynptr data slices (ptr to underlying dynptr memory)
> 6/6 - Tests to check that verifier rejects certain fail cases and passes
> certain success cases
>
> This is the first dynptr patchset in a larger series. The next series of
> patches will add persisting dynamic memory allocations in maps, parsing p=
acket
> data through dynptrs, convenience helpers for using dynptrs as iterators,=
 and
> more helper functions for interacting with strings and memory dynamically=
.
>
> Changelog:
> ----------
> v3 -> v2:
> v2: https://lore.kernel.org/bpf/20220416063429.3314021-1-joannelkoong@gma=
il.com/
>
> * Reorder patches (move ringbuffer patch to be right after the verifier +=
 malloc
> dynptr patchset)
> * Remove local type dynptrs (Andrii + Alexei)
> * Mark stack slot as STACK_MISC after any writes into a dynptr instead of
> * explicitly prohibiting writes (Alexei)
> * Pass number of slots, not memory size to is_spi_bounds_valid (Kumar)
> * Check reference leaks by adding dynptr id to state->refs instead of che=
cking
> stack slots (Alexei)
>

There seems to be test_progs-no_alu32 failure in CI ([0]), please take a lo=
ok

  [0] https://github.com/kernel-patches/bpf/runs/6223168213?check_suite_foc=
us=3Dtrue#step:6:6430

> v1 -> v2:
> v1: https://lore.kernel.org/bpf/20220402015826.3941317-1-joannekoong@fb.c=
om/
>
> 1/7 -
>     * Remove ARG_PTR_TO_MAP_VALUE_UNINIT alias and use
>       ARG_PTR_TO_MAP_VALUE | MEM_UNINIT directly (Andrii)
>     * Drop arg_type_is_mem_ptr() wrapper function (Andrii)
> 2/7 -
>     * Change name from MEM_RELEASE to OBJ_RELEASE (Andrii)
>     * Use meta.release_ref instead of ref_obj_id !=3D 0 to determine whet=
her
>       to release reference (Kumar)
>     * Drop type_is_release_mem() wrapper function (Andrii)
> 3/7 -
>     * Add checks for nested dynptrs edge-cases, which could lead to corru=
pt
>     * writes of the dynptr stack variable.
>     * Add u64 flags to bpf_dynptr_from_mem() and bpf_dynptr_alloc() (Andr=
ii)
>     * Rename from bpf_malloc/bpf_free to bpf_dynptr_alloc/bpf_dynptr_put
>       (Alexei)
>     * Support alloc flag __GFP_ZERO (Andrii)
>     * Reserve upper 8 bits in dynptr size and offset fields instead of
>       reserving just the upper 4 bits (Andrii)
>     * Allow dynptr zero-slices (Andrii)
>     * Use the highest bit for is_rdonly instead of the 28th bit (Andrii)
>     * Rename check_* functions to is_* functions for better readability
>       (Andrii)
>     * Add comment for code that checks the spi bounds (Andrii)
> 4/7 -
>     * Fix doc description for bpf_dynpt_read (Toke)
>     * Move bpf_dynptr_check_off_len() from function patch 1 to here (Andr=
ii)
> 5/7 -
>     * When finding the id for the dynptr to associate the data slice with=
,
>       look for dynptr arg instead of assuming it is BPF_REG_1.
> 6/7 -
>     * Add __force when casting from unsigned long to void * (kernel test =
robot)
>     * Expand on docs for ringbuf dynptr APIs (Andrii)
> 7/7 -
>     * Use table approach for defining test programs and error messages (A=
ndrii)
>     * Print out full log if there=E2=80=99s an error (Andrii)
>     * Use bpf_object__find_program_by_name() instead of specifying
>       program name as a string (Andrii)
>     * Add 6 extra cases: invalid_nested_dynptrs1, invalid_nested_dynptrs2=
,
>       invalid_ref_mem1, invalid_ref_mem2, zero_slice_access,
>       and test_alloc_zero_bytes
>     * Add checking for edge cases (eg allocing with invalid flags)
>
>
> Joanne Koong (6):
>   bpf: Add MEM_UNINIT as a bpf_type_flag
>   bpf: Add verifier support for dynptrs and implement malloc dynptrs
>   bpf: Dynptr support for ring buffers
>   bpf: Add bpf_dynptr_read and bpf_dynptr_write
>   bpf: Add dynptr data slices
>   bpf: Dynptr tests
>
>  include/linux/bpf.h                           | 103 +++-
>  include/linux/bpf_verifier.h                  |  21 +
>  include/uapi/linux/bpf.h                      |  96 +++
>  kernel/bpf/helpers.c                          | 169 +++++-
>  kernel/bpf/ringbuf.c                          |  71 +++
>  kernel/bpf/verifier.c                         | 329 +++++++++-
>  scripts/bpf_doc.py                            |   2 +
>  tools/include/uapi/linux/bpf.h                |  96 +++
>  .../testing/selftests/bpf/prog_tests/dynptr.c | 132 ++++
>  .../testing/selftests/bpf/progs/dynptr_fail.c | 574 ++++++++++++++++++
>  .../selftests/bpf/progs/dynptr_success.c      | 218 +++++++
>  11 files changed, 1774 insertions(+), 37 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/dynptr.c
>  create mode 100644 tools/testing/selftests/bpf/progs/dynptr_fail.c
>  create mode 100644 tools/testing/selftests/bpf/progs/dynptr_success.c
>
> --
> 2.30.2
>
