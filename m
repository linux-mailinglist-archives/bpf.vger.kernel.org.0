Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB7B520392
	for <lists+bpf@lfdr.de>; Mon,  9 May 2022 19:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235658AbiEIRaX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 May 2022 13:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239670AbiEIRaV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 May 2022 13:30:21 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DF817D384
        for <bpf@vger.kernel.org>; Mon,  9 May 2022 10:26:26 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id e12so26199307ybc.11
        for <bpf@vger.kernel.org>; Mon, 09 May 2022 10:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kvgYce2t8GlY3f0UuJPtsmkblE8PxUd1GKPCVHhRATs=;
        b=TdaoIT7QHEsX8h54e5+EffHEsKSJIahri5roTZp2nfocAql3lgb38eoOifh7nkYt1U
         yMqvI56OifOxOpDzsfySgIkoeqsy01s9eGWtLN+j/qY1DJ9JD7mfPq6KucIOWQ4vlWr4
         ItX8I+MWvsYhgV7i1DTGMns3EmsfNISUEQa9ruaC/UX+gZbgVk4AxtP+onDzQojGGErW
         P4yhwVgoGPzT1cpd0gJDId+383bTqVlUsuMtGXxxIdS1zHFJwhWF0q5cvFtLGklOiDlm
         rO4CQV3BcvDdNIUVbMuKMJbh/45OI+PdvkQTXgMSBG4nJZ18CgUBvQl+mP9dzGaiBE+H
         99YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kvgYce2t8GlY3f0UuJPtsmkblE8PxUd1GKPCVHhRATs=;
        b=QU/x8RoxwNG0MPea8hHAhSeJvAG4bqHLZPEpkvIF6vayf+5G5zKxIhL77mh1c7cFZ3
         ayRfLMZy8ZwIWRzP3jI87Zonva+Tmlr6EiqksH341jauMw39yNX0RZ/CPLDFd2fMnPX/
         8DLMT4S0c32HZkDuSs9QX9i+490UsvsxGHnMX8EXVxd6S7QUojy2Pgt6lm4d7IWtIvUt
         +tnF3jIUz/YXIu5O5+nOJI7RMUfcd5wyLvXQ5S++aVAOlEISEfyZpTtZ7ivu66RaC02V
         R4OHEIL8Hl9JfO1KV5QErYEOBTu3F3p1SsuQ/U55vfsx4r3Tb3rwY0WYih3tJSLGFeXX
         Mpdg==
X-Gm-Message-State: AOAM530Ur5QN5fXTfVTh3ACnSSt5jrNMK2gu+Bae54tpD5KkGm0ip3lx
        YHvW/8WihOT9dshsaIynUXxelO27F6Nz2fl6zFA=
X-Google-Smtp-Source: ABdhPJycDnmIHIg/AWFdl8dW8Hg0o9CSegookQYTCr81arZcKF8whNj54zDKi91JIP2UiBvOlMf+cWKVLZp/JrvkiSI=
X-Received: by 2002:a25:b09c:0:b0:648:5eb6:86bb with SMTP id
 f28-20020a25b09c000000b006485eb686bbmr14383605ybj.530.1652117185900; Mon, 09
 May 2022 10:26:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220428211059.4065379-1-joannelkoong@gmail.com> <CAEf4BzZ_trN92VwrcqFuM0R0EgZd+R9i-qUOqTMHi0-YN-GdJw@mail.gmail.com>
In-Reply-To: <CAEf4BzZ_trN92VwrcqFuM0R0EgZd+R9i-qUOqTMHi0-YN-GdJw@mail.gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Mon, 9 May 2022 10:26:15 -0700
Message-ID: <CAJnrk1YA_XfxAypm7Ch7hLhPYLVW9fbVsSsajG7+uH7XH+kxGA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/6] Dynamic pointers
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
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

On Fri, May 6, 2022 at 3:35 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Apr 28, 2022 at 2:11 PM Joanne Koong <joannelkoong@gmail.com> wro=
te:
> >
> > This patchset implements the basics of dynamic pointers in bpf.
> >
> > A dynamic pointer (struct bpf_dynptr) is a pointer that stores extra me=
tadata
> > alongside the address it points to. This abstraction is useful in bpf, =
given
> > that every memory access in a bpf program must be safe. The verifier an=
d bpf
> > helper functions can use the metadata to enforce safety guarantees for =
things
> > such as dynamically sized strings and kernel heap allocations.
> >
> > From the program side, the bpf_dynptr is an opaque struct and the verif=
ier
> > will enforce that its contents are never written to by the program.
> > It can only be written to through specific bpf helper functions.
> >
> > There are several uses cases for dynamic pointers in bpf programs. A li=
st of
> > some are: dynamically sized ringbuf reservations without any extra memc=
pys,
> > dynamic string parsing and memory comparisons, dynamic memory allocatio=
ns that
> > can be persisted in a map, and dynamic parsing of sk_buff and xdp_md pa=
cket
> > data.
> >
> > At a high-level, the patches are as follows:
> > 1/6 - Adds MEM_UNINIT as a bpf_type_flag
> > 2/6 - Adds verifier support for dynptrs and implements malloc dynptrs
> > 3/6 - Adds dynptr support for ring buffers
> > 4/6 - Adds bpf_dynptr_read and bpf_dynptr_write
> > 5/6 - Adds dynptr data slices (ptr to underlying dynptr memory)
> > 6/6 - Tests to check that verifier rejects certain fail cases and passe=
s
> > certain success cases
> >
> > This is the first dynptr patchset in a larger series. The next series o=
f
> > patches will add persisting dynamic memory allocations in maps, parsing=
 packet
> > data through dynptrs, convenience helpers for using dynptrs as iterator=
s, and
> > more helper functions for interacting with strings and memory dynamical=
ly.
> >
> > Changelog:
> > ----------
> > v3 -> v2:
> > v2: https://lore.kernel.org/bpf/20220416063429.3314021-1-joannelkoong@g=
mail.com/
> >
> > * Reorder patches (move ringbuffer patch to be right after the verifier=
 + malloc
> > dynptr patchset)
> > * Remove local type dynptrs (Andrii + Alexei)
> > * Mark stack slot as STACK_MISC after any writes into a dynptr instead =
of
> > * explicitly prohibiting writes (Alexei)
> > * Pass number of slots, not memory size to is_spi_bounds_valid (Kumar)
> > * Check reference leaks by adding dynptr id to state->refs instead of c=
hecking
> > stack slots (Alexei)
> >
>
> There seems to be test_progs-no_alu32 failure in CI ([0]), please take a =
look
>
>   [0] https://github.com/kernel-patches/bpf/runs/6223168213?check_suite_f=
ocus=3Dtrue#step:6:6430
>
I'll look into this and fix it for v4. thanks for taking the time to
review all these dynptr changes in all the versions, Andrii!
> > v1 -> v2:
> > v1: https://lore.kernel.org/bpf/20220402015826.3941317-1-joannekoong@fb=
.com/
> >
> > 1/7 -
> >     * Remove ARG_PTR_TO_MAP_VALUE_UNINIT alias and use
> >       ARG_PTR_TO_MAP_VALUE | MEM_UNINIT directly (Andrii)
> >     * Drop arg_type_is_mem_ptr() wrapper function (Andrii)
> > 2/7 -
> >     * Change name from MEM_RELEASE to OBJ_RELEASE (Andrii)
> >     * Use meta.release_ref instead of ref_obj_id !=3D 0 to determine wh=
ether
> >       to release reference (Kumar)
> >     * Drop type_is_release_mem() wrapper function (Andrii)
> > 3/7 -
> >     * Add checks for nested dynptrs edge-cases, which could lead to cor=
rupt
> >     * writes of the dynptr stack variable.
> >     * Add u64 flags to bpf_dynptr_from_mem() and bpf_dynptr_alloc() (An=
drii)
> >     * Rename from bpf_malloc/bpf_free to bpf_dynptr_alloc/bpf_dynptr_pu=
t
> >       (Alexei)
> >     * Support alloc flag __GFP_ZERO (Andrii)
> >     * Reserve upper 8 bits in dynptr size and offset fields instead of
> >       reserving just the upper 4 bits (Andrii)
> >     * Allow dynptr zero-slices (Andrii)
> >     * Use the highest bit for is_rdonly instead of the 28th bit (Andrii=
)
> >     * Rename check_* functions to is_* functions for better readability
> >       (Andrii)
> >     * Add comment for code that checks the spi bounds (Andrii)
> > 4/7 -
> >     * Fix doc description for bpf_dynpt_read (Toke)
> >     * Move bpf_dynptr_check_off_len() from function patch 1 to here (An=
drii)
> > 5/7 -
> >     * When finding the id for the dynptr to associate the data slice wi=
th,
> >       look for dynptr arg instead of assuming it is BPF_REG_1.
> > 6/7 -
> >     * Add __force when casting from unsigned long to void * (kernel tes=
t robot)
> >     * Expand on docs for ringbuf dynptr APIs (Andrii)
> > 7/7 -
> >     * Use table approach for defining test programs and error messages =
(Andrii)
> >     * Print out full log if there=E2=80=99s an error (Andrii)
> >     * Use bpf_object__find_program_by_name() instead of specifying
> >       program name as a string (Andrii)
> >     * Add 6 extra cases: invalid_nested_dynptrs1, invalid_nested_dynptr=
s2,
> >       invalid_ref_mem1, invalid_ref_mem2, zero_slice_access,
> >       and test_alloc_zero_bytes
> >     * Add checking for edge cases (eg allocing with invalid flags)
> >
> >
> > Joanne Koong (6):
> >   bpf: Add MEM_UNINIT as a bpf_type_flag
> >   bpf: Add verifier support for dynptrs and implement malloc dynptrs
> >   bpf: Dynptr support for ring buffers
> >   bpf: Add bpf_dynptr_read and bpf_dynptr_write
> >   bpf: Add dynptr data slices
> >   bpf: Dynptr tests
> >
> >  include/linux/bpf.h                           | 103 +++-
> >  include/linux/bpf_verifier.h                  |  21 +
> >  include/uapi/linux/bpf.h                      |  96 +++
> >  kernel/bpf/helpers.c                          | 169 +++++-
> >  kernel/bpf/ringbuf.c                          |  71 +++
> >  kernel/bpf/verifier.c                         | 329 +++++++++-
> >  scripts/bpf_doc.py                            |   2 +
> >  tools/include/uapi/linux/bpf.h                |  96 +++
> >  .../testing/selftests/bpf/prog_tests/dynptr.c | 132 ++++
> >  .../testing/selftests/bpf/progs/dynptr_fail.c | 574 ++++++++++++++++++
> >  .../selftests/bpf/progs/dynptr_success.c      | 218 +++++++
> >  11 files changed, 1774 insertions(+), 37 deletions(-)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/dynptr.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/dynptr_fail.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/dynptr_success.c
> >
> > --
> > 2.30.2
> >
