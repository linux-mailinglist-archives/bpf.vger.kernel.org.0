Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12B66D6F3A
	for <lists+bpf@lfdr.de>; Tue,  4 Apr 2023 23:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236342AbjDDVrH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Apr 2023 17:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236450AbjDDVrG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Apr 2023 17:47:06 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A63710CA
        for <bpf@vger.kernel.org>; Tue,  4 Apr 2023 14:47:05 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id y4so136317163edo.2
        for <bpf@vger.kernel.org>; Tue, 04 Apr 2023 14:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680644823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oDz97oD/l+Yzo4p+FCVD5RcNYfUIsM7Fwvipfrywsj0=;
        b=bIt3yd6DAx6DrahQGpNUm6rlBXSHSe1jaWv9q7gXJfuHEXCIvetsALu+PwNYb26UAv
         +utPJaIRToNqPPAbLs3yKj4NdYfOfwe3rbXCx1hOE2ZQpK165T2unNJQlDb354dcQ2h5
         KByI1250p29e/vTE0iSF+hG938ipZwnMMZQuGtZDbiaDuGNxEKwhpDUomwEQDPrtr9yi
         1yQaJIkvsBjqNK1m6BDFyZFbX6hPD0WJVH9gzi6Zb2vaRz8jVsioAWlaG9DRuLwNEMQy
         LPTn0qgydj9wWW/uI/CFyXpmfMS2zBTEkxQGQF/zEODjNtoLjU48zHPyvOFj0DBYl6R0
         e+kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680644823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oDz97oD/l+Yzo4p+FCVD5RcNYfUIsM7Fwvipfrywsj0=;
        b=eLQy/l7/oO2hqCdF5fOniLMG0Dyz8uZmjyEDY2RRiTsytBlTnaU6XqA2Sl2x/j+jA/
         sNzCse8OdmhjM7GszxW2Yg++/uBQYOCe0k0xbX4+F+Lc9prMDJ4hmRh/6E47X4m5ldaX
         Bz7wbBuWarZiUwgr2jw6XXvEc6Fxp579PVQZg5uaHbN+6t6328+0kLSMEz8W1uj0Hn6M
         HopHiE1THZIa0BWCBVplCmn5d8Voncc24UxqwveGgKq/KzJNVBtqFSugUphMxJaYC39x
         LdOO62t8TA5u1eEr/Z5boE3Ey1ouc9TzMxok1HpBKHBqLaiTmJpH3k8gllcPRGK2D3+I
         xaKg==
X-Gm-Message-State: AAQBX9ft8RKmkS0GPYrQhDq72Pe5K0msjBH7DirTusYYkRLSFE9kC8Mb
        E/flvc4VwVcHWxF2VCM8yrJmFT6uLWN2MRCPf+M=
X-Google-Smtp-Source: AKy350YG6JJqqacfKTM6lMNwWcz44r3jv8YLZtGIoN1Xvzh3q1sinyeWDTwo95O6Oso52hhvMukqUyxOBQoHL9cY/QY=
X-Received: by 2002:a17:906:f850:b0:948:5b2a:7841 with SMTP id
 ks16-20020a170906f85000b009485b2a7841mr558720ejb.5.1680644823309; Tue, 04 Apr
 2023 14:47:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230330055600.86870-1-yhs@fb.com>
In-Reply-To: <20230330055600.86870-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 4 Apr 2023 14:46:51 -0700
Message-ID: <CAEf4Bzayt_FUG6JyMzU060swqP_w=W9TFJOKD15ux6GNDm3qSg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/7] bpf: Improve verifier for cond_op and
 spilled loop index variables
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 29, 2023 at 10:56=E2=80=AFPM Yonghong Song <yhs@fb.com> wrote:
>
> LLVM commit [1] introduced hoistMinMax optimization like
>   (i < VIRTIO_MAX_SGS) && (i < out_sgs)
> to
>   upper =3D MIN(VIRTIO_MAX_SGS, out_sgs)
>   ... i < upper ...
> and caused the verification failure. Commit [2] workarounded the issue by
> adding some bpf assembly code to prohibit the above optimization.
> This patch improved verifier such that verification can succeed without
> the above workaround.
>
> Without [2], the current verifier will hit the following failures:
>   ...
>   119: (15) if r1 =3D=3D 0x0 goto pc+1
>   The sequence of 8193 jumps is too complex.
>   verification time 525829 usec
>   stack depth 64
>   processed 156616 insns (limit 1000000) max_states_per_insn 8 total_stat=
es 1754 peak_states 1712 mark_read 12
>   -- END PROG LOAD LOG --
>   libbpf: prog 'trace_virtqueue_add_sgs': failed to load: -14
>   libbpf: failed to load object 'loop6.bpf.o'
>   ...
> The failure is due to verifier inadequately handling '<const> <cond_op> <=
non_const>' which will
> go through both pathes and generate the following verificaiton states:
>   ...
>   89: (07) r2 +=3D 1                      ; R2_w=3D5
>   90: (79) r8 =3D *(u64 *)(r10 -48)       ; R8_w=3Dscalar() R10=3Dfp0
>   91: (79) r1 =3D *(u64 *)(r10 -56)       ; R1_w=3Dscalar(umax=3D5,var_of=
f=3D(0x0; 0x7)) R10=3Dfp0
>   92: (ad) if r2 < r1 goto pc+41        ; R0_w=3Dscalar() R1_w=3Dscalar(u=
min=3D6,umax=3D5,var_off=3D(0x4; 0x3))

offtopic, but if this is a real output, then something is wrong with
scratching register logic for conditional, it should have emitted
states of R1 and R2, maybe you can take a look while working on this
patch set?

>       R2_w=3D5 R6_w=3Dscalar(id=3D385) R7_w=3D0 R8_w=3Dscalar() R9_w=3Dsc=
alar(umax=3D21474836475,var_off=3D(0x0; 0x7ffffffff))
>       R10=3Dfp0 fp-8=3Dmmmmmmmm fp-16=3Dmmmmmmmm fp-24=3Dmmmm???? fp-32=
=3D fp-40_w=3D4 fp-48=3Dmmmmmmmm fp-56=3D fp-64=3Dmmmmmmmm
>   ...
>   89: (07) r2 +=3D 1                      ; R2_w=3D6
>   90: (79) r8 =3D *(u64 *)(r10 -48)       ; R8_w=3Dscalar() R10=3Dfp0
>   91: (79) r1 =3D *(u64 *)(r10 -56)       ; R1_w=3Dscalar(umax=3D5,var_of=
f=3D(0x0; 0x7)) R10=3Dfp0
>   92: (ad) if r2 < r1 goto pc+41        ; R0_w=3Dscalar() R1_w=3Dscalar(u=
min=3D7,umax=3D5,var_off=3D(0x4; 0x3))
>       R2_w=3D6 R6=3Dscalar(id=3D388) R7=3D0 R8_w=3Dscalar() R9_w=3Dscalar=
(umax=3D25769803770,var_off=3D(0x0; 0x7ffffffff))
>       R10=3Dfp0 fp-8=3Dmmmmmmmm fp-16=3Dmmmmmmmm fp-24=3Dmmmm???? fp-32=
=3D fp-40=3D5 fp-48=3Dmmmmmmmm fp-56=3D fp-64=3Dmmmmmmmm
>     ...
>   89: (07) r2 +=3D 1                      ; R2_w=3D4088
>   90: (79) r8 =3D *(u64 *)(r10 -48)       ; R8_w=3Dscalar() R10=3Dfp0
>   91: (79) r1 =3D *(u64 *)(r10 -56)       ; R1_w=3Dscalar(umax=3D5,var_of=
f=3D(0x0; 0x7)) R10=3Dfp0
>   92: (ad) if r2 < r1 goto pc+41        ; R0=3Dscalar() R1=3Dscalar(umin=
=3D4089,umax=3D5,var_off=3D(0x0; 0x7))
>       R2=3D4088 R6=3Dscalar(id=3D12634) R7=3D0 R8=3Dscalar() R9=3Dscalar(=
umax=3D17557826301960,var_off=3D(0x0; 0xfffffffffff))
>       R10=3Dfp0 fp-8=3Dmmmmmmmm fp-16=3Dmmmmmmmm fp-24=3Dmmmm???? fp-32=
=3D fp-40=3D4087 fp-48=3Dmmmmmmmm fp-56=3D fp-64=3Dmmmmmmmm
>
> Patch 3 fixed the above issue by handling '<const> <cond_op> <non_const>'=
 properly.
> During developing selftests for Patch 3, I found some issues with bound d=
eduction with
> BPF_EQ/BPF_NE and fixed the issue in Patch 1.
>
> After the above issue is fixed, the second issue shows up.
>   ...
>   67: (07) r1 +=3D -16                    ; R1_w=3Dfp-16
>   ; bpf_probe_read_kernel(&sgp, sizeof(sgp), sgs + i);
>   68: (b4) w2 =3D 8                       ; R2_w=3D8
>   69: (85) call bpf_probe_read_kernel#113       ; R0_w=3Dscalar() fp-16=
=3Dmmmmmmmm
>   ; return sgp;
>   70: (79) r6 =3D *(u64 *)(r10 -16)       ; R6=3Dscalar() R10=3Dfp0
>   ; for (n =3D 0, sgp =3D get_sgp(sgs, i); sgp && (n < SG_MAX);
>   71: (15) if r6 =3D=3D 0x0 goto pc-49      ; R6=3Dscalar()
>   72: (b4) w1 =3D 0                       ; R1_w=3D0
>   73: (05) goto pc-46
>   ; for (i =3D 0; (i < VIRTIO_MAX_SGS) && (i < out_sgs); i++) {
>   28: (bc) w7 =3D w1                      ; R1_w=3D0 R7_w=3D0
>   ; bpf_probe_read_kernel(&len, sizeof(len), &sgp->length);
>   ...
>   23: (79) r3 =3D *(u64 *)(r10 -40)       ; R3_w=3D2 R10=3Dfp0
>   ; for (i =3D 0; (i < VIRTIO_MAX_SGS) && (i < out_sgs); i++) {
>   24: (07) r3 +=3D 1                      ; R3_w=3D3
>   ; for (i =3D 0; (i < VIRTIO_MAX_SGS) && (i < out_sgs); i++) {
>   25: (79) r1 =3D *(u64 *)(r10 -56)       ; R1_w=3Dscalar(umax=3D5,var_of=
f=3D(0x0; 0x7)) R10=3Dfp0
>   26: (ad) if r3 < r1 goto pc+34 61: R0=3Dscalar() R1_w=3Dscalar(umin=3D4=
,umax=3D5,var_off=3D(0x4; 0x1)) R3_w=3D3 R6=3Dscalar(id=3D1658)
>      R7=3D0 R8=3Dscalar(id=3D1653) R9=3Dscalar(umax=3D4294967295,var_off=
=3D(0x0; 0xffffffff)) R10=3Dfp0 fp-8=3Dmmmmmmmm fp-16=3Dmmmmmmmm
>      fp-24=3Dmmmm???? fp-32=3D fp-40=3D2 fp-56=3D fp-64=3Dmmmmmmmm
>   ; if (sg_is_chain(&sg))
>   61: (7b) *(u64 *)(r10 -40) =3D r3       ; R3_w=3D3 R10=3Dfp0 fp-40_w=3D=
3
>     ...
>   67: (07) r1 +=3D -16                    ; R1_w=3Dfp-16
>   ; bpf_probe_read_kernel(&sgp, sizeof(sgp), sgs + i);
>   68: (b4) w2 =3D 8                       ; R2_w=3D8
>   69: (85) call bpf_probe_read_kernel#113       ; R0_w=3Dscalar() fp-16=
=3Dmmmmmmmm
>   ; return sgp;
>   70: (79) r6 =3D *(u64 *)(r10 -16)
>   ; for (n =3D 0, sgp =3D get_sgp(sgs, i); sgp && (n < SG_MAX);
>   infinite loop detected at insn 71
>   verification time 90800 usec
>   stack depth 64
>   processed 25017 insns (limit 1000000) max_states_per_insn 20 total_stat=
es 491 peak_states 169 mark_read 12
>   -- END PROG LOAD LOG --
>   libbpf: prog 'trace_virtqueue_add_sgs': failed to load: -22
>
> Further analysis found the index variable 'i' is spilled but since it is =
not marked as precise, regsafe will ignore
> comparison since they are scalar values.
>
> Since it is hard for verifier to determine whether a particular scalar is=
 index variable or not, Patch 5 implemented
> a heuristic such that if both old and new reg states are constant, mark t=
he old one as precise to force scalar value
> comparison and this fixed the problem.
>
> The rest of patches are selftests related.
>
>   [1] https://reviews.llvm.org/D143726
>   [2] Commit 3c2611bac08a ("selftests/bpf: Fix trace_virtqueue_add_sgs te=
st issue with LLVM 17.")
>
> Yonghong Song (7):
>   bpf: Improve verifier JEQ/JNE insn branch taken checking
>   selftests/bpf: Add tests for non-constant cond_op NE/EQ bound
>     deduction
>   bpf: Improve handling of pattern '<const> <cond_op> <non_const>' in
>     verifier
>   selftests/bpf: Add verifier tests for code pattern '<const> <cond_op>
>     <non_const>'
>   bpf: Mark potential spilled loop index variable as precise
>   selftests/bpf: Remove previous workaround for test verif_scale_loop6
>   selftests/bpf: Add a new test based on loop6.c
>
>  kernel/bpf/verifier.c                         |  40 +-
>  .../bpf/prog_tests/bpf_verif_scale.c          |   5 +
>  .../selftests/bpf/prog_tests/verifier.c       |   2 +
>  tools/testing/selftests/bpf/progs/loop6.c     |   2 -
>  tools/testing/selftests/bpf/progs/loop7.c     | 102 ++++
>  .../verifier_bounds_deduction_non_const.c     | 553 ++++++++++++++++++
>  .../progs/verifier_bounds_mix_sign_unsign.c   |   2 +-
>  7 files changed, 701 insertions(+), 5 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/loop7.c
>  create mode 100644 tools/testing/selftests/bpf/progs/verifier_bounds_ded=
uction_non_const.c
>
> --
> 2.34.1
>
