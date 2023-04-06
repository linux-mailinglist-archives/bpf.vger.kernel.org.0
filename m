Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D5B6D9FFC
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 20:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjDFSjP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 14:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238918AbjDFSjO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 14:39:14 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D0A6A6B
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 11:39:08 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-93071f06a9fso156022766b.2
        for <bpf@vger.kernel.org>; Thu, 06 Apr 2023 11:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680806347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QHiTp8DnIBGB/h72sM/MF4yy5jsb0805GAFrcL4yuvY=;
        b=S8EsrlRlTqcoDfRQJQzb5f6azcu+HtM27bkXacenQ66RraJzz7XMi8ZzUr29C+AwcV
         cppueIIu9N9ufareib0luGzmUi/Wb+j2TkpGcSOxs2+YN9J3LVkpDmj1Brc3Hh5uvg+x
         nH/GtzLPeL08zRRRlbKcDvnZR+BtjhCy1w9N3UddX4qvSIoE6qLNKar5MfWSzlyPkeih
         SVgcE1ZJzdMs81MuKAfYc3/yjeFmMhsd3kEiSGUjOfORWPPHO5thbbZXn5Q21lcfnlRn
         +JBWFAp84s6lEu8QUTjod4yZI3WCWTvhAqxhTD8M5V52eqvzwdBZj+M74PCP87xgf66y
         Q6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680806347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QHiTp8DnIBGB/h72sM/MF4yy5jsb0805GAFrcL4yuvY=;
        b=lR9qLrYryyxLjSmSvB4InAR6xa8FAxYHi5ygbj6GbVtLZH3YT3Dw4QR/HPdaJgf0b9
         W5cH61ihr8JXJeizWCfihiVllaHjNVjFUfLER8rKDQurvcpCCu/wn/R13OeIxVI1bGBD
         IM2r/YZkBz7EeEV4VS95t7qYTpMP+YgHK/GMQCEH95AnO9sYmBlit1QKPymhfadLqllQ
         qLQWRnRAZRN2KMCizY0HhH/zUzeicr0rsVV8ySeQb/PknVPi+4uruDlY19NXYpqESzWZ
         KD/SnYaMWASrMQYrMmJ6yw4lVucJhOF8WZzArcCIlra1tFHPaKs+qVwZMHQzBBeInS4h
         +0FA==
X-Gm-Message-State: AAQBX9e5CNJfcUW0E534aWCG+jaTTHatkCgZRsqdeKlf+rtc3qPogAkq
        UZVFy2432bIX7EdAntVRlDsFgt1Im/+JkDQL1Bk=
X-Google-Smtp-Source: AKy350ZRds2XVS3Io9PEvCL2TznXDX5BOo/nkAxBKweAplO++IXu957zGoGb8L5BhKXNzA4m01JArVN+1UQtzrrDQ6M=
X-Received: by 2002:a50:bb43:0:b0:4fc:f0b8:7da0 with SMTP id
 y61-20020a50bb43000000b004fcf0b87da0mr295778ede.1.1680806346742; Thu, 06 Apr
 2023 11:39:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230330055600.86870-1-yhs@fb.com> <CAEf4Bzayt_FUG6JyMzU060swqP_w=W9TFJOKD15ux6GNDm3qSg@mail.gmail.com>
 <b73075cb-67c4-2144-64f9-fc564eb00833@meta.com>
In-Reply-To: <b73075cb-67c4-2144-64f9-fc564eb00833@meta.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 6 Apr 2023 11:38:54 -0700
Message-ID: <CAEf4BzYOqGVac3QDMD3LGVBS9tj56PQaZjxh+1FzVSYrx1=TSA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/7] bpf: Improve verifier for cond_op and
 spilled loop index variables
To:     Yonghong Song <yhs@meta.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
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

On Thu, Apr 6, 2023 at 9:49=E2=80=AFAM Yonghong Song <yhs@meta.com> wrote:
>
>
>
> On 4/4/23 2:46 PM, Andrii Nakryiko wrote:
> > On Wed, Mar 29, 2023 at 10:56=E2=80=AFPM Yonghong Song <yhs@fb.com> wro=
te:
> >>
> >> LLVM commit [1] introduced hoistMinMax optimization like
> >>    (i < VIRTIO_MAX_SGS) && (i < out_sgs)
> >> to
> >>    upper =3D MIN(VIRTIO_MAX_SGS, out_sgs)
> >>    ... i < upper ...
> >> and caused the verification failure. Commit [2] workarounded the issue=
 by
> >> adding some bpf assembly code to prohibit the above optimization.
> >> This patch improved verifier such that verification can succeed withou=
t
> >> the above workaround.
> >>
> >> Without [2], the current verifier will hit the following failures:
> >>    ...
> >>    119: (15) if r1 =3D=3D 0x0 goto pc+1
> >>    The sequence of 8193 jumps is too complex.
> >>    verification time 525829 usec
> >>    stack depth 64
> >>    processed 156616 insns (limit 1000000) max_states_per_insn 8 total_=
states 1754 peak_states 1712 mark_read 12
> >>    -- END PROG LOAD LOG --
> >>    libbpf: prog 'trace_virtqueue_add_sgs': failed to load: -14
> >>    libbpf: failed to load object 'loop6.bpf.o'
> >>    ...
> >> The failure is due to verifier inadequately handling '<const> <cond_op=
> <non_const>' which will
> >> go through both pathes and generate the following verificaiton states:
> >>    ...
> >>    89: (07) r2 +=3D 1                      ; R2_w=3D5
> >>    90: (79) r8 =3D *(u64 *)(r10 -48)       ; R8_w=3Dscalar() R10=3Dfp0
> >>    91: (79) r1 =3D *(u64 *)(r10 -56)       ; R1_w=3Dscalar(umax=3D5,va=
r_off=3D(0x0; 0x7)) R10=3Dfp0
> >>    92: (ad) if r2 < r1 goto pc+41        ; R0_w=3Dscalar() R1_w=3Dscal=
ar(umin=3D6,umax=3D5,var_off=3D(0x4; 0x3))
> >
> > offtopic, but if this is a real output, then something is wrong with
> > scratching register logic for conditional, it should have emitted
> > states of R1 and R2, maybe you can take a look while working on this
> > patch set?
>
> Yes, this is the real output. Yes, the above R1_w should be an
> impossible state. This is what this patch tries to fix.
> I am not what verifier should do if this state indeed happens,
> return an -EFAULT or something?

no-no, that's not what I'm talking about. Look at the instruction, it
compares R1 and R2, yet we print the state of R0 and R1, as if that
instruction worked with R0 and R1 instead. That's confusing and wrong.
There is some off-by-one error in mark_register_scratched() call, or
something like that.

>
> >
> >>        R2_w=3D5 R6_w=3Dscalar(id=3D385) R7_w=3D0 R8_w=3Dscalar() R9_w=
=3Dscalar(umax=3D21474836475,var_off=3D(0x0; 0x7ffffffff))
> >>        R10=3Dfp0 fp-8=3Dmmmmmmmm fp-16=3Dmmmmmmmm fp-24=3Dmmmm???? fp-=
32=3D fp-40_w=3D4 fp-48=3Dmmmmmmmm fp-56=3D fp-64=3Dmmmmmmmm
> >>    ...
> >>    89: (07) r2 +=3D 1                      ; R2_w=3D6
> >>    90: (79) r8 =3D *(u64 *)(r10 -48)       ; R8_w=3Dscalar() R10=3Dfp0
> >>    91: (79) r1 =3D *(u64 *)(r10 -56)       ; R1_w=3Dscalar(umax=3D5,va=
r_off=3D(0x0; 0x7)) R10=3Dfp0
> >>    92: (ad) if r2 < r1 goto pc+41        ; R0_w=3Dscalar() R1_w=3Dscal=
ar(umin=3D7,umax=3D5,var_off=3D(0x4; 0x3))
> >>        R2_w=3D6 R6=3Dscalar(id=3D388) R7=3D0 R8_w=3Dscalar() R9_w=3Dsc=
alar(umax=3D25769803770,var_off=3D(0x0; 0x7ffffffff))
> >>        R10=3Dfp0 fp-8=3Dmmmmmmmm fp-16=3Dmmmmmmmm fp-24=3Dmmmm???? fp-=
32=3D fp-40=3D5 fp-48=3Dmmmmmmmm fp-56=3D fp-64=3Dmmmmmmmm
> >>      ...
> >>    89: (07) r2 +=3D 1                      ; R2_w=3D4088
> >>    90: (79) r8 =3D *(u64 *)(r10 -48)       ; R8_w=3Dscalar() R10=3Dfp0
> >>    91: (79) r1 =3D *(u64 *)(r10 -56)       ; R1_w=3Dscalar(umax=3D5,va=
r_off=3D(0x0; 0x7)) R10=3Dfp0
> >>    92: (ad) if r2 < r1 goto pc+41        ; R0=3Dscalar() R1=3Dscalar(u=
min=3D4089,umax=3D5,var_off=3D(0x0; 0x7))
> >>        R2=3D4088 R6=3Dscalar(id=3D12634) R7=3D0 R8=3Dscalar() R9=3Dsca=
lar(umax=3D17557826301960,var_off=3D(0x0; 0xfffffffffff))
> >>        R10=3Dfp0 fp-8=3Dmmmmmmmm fp-16=3Dmmmmmmmm fp-24=3Dmmmm???? fp-=
32=3D fp-40=3D4087 fp-48=3Dmmmmmmmm fp-56=3D fp-64=3Dmmmmmmmm
> >>
> >> Patch 3 fixed the above issue by handling '<const> <cond_op> <non_cons=
t>' properly.
> >> During developing selftests for Patch 3, I found some issues with boun=
d deduction with
> >> BPF_EQ/BPF_NE and fixed the issue in Patch 1.
> [...]
