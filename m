Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5316DA205
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 21:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238562AbjDFTzH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 15:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238546AbjDFTzG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 15:55:06 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0F45253
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 12:55:05 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-4fa3c857b08so1364360a12.2
        for <bpf@vger.kernel.org>; Thu, 06 Apr 2023 12:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680810904; x=1683402904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sZZNsZ3DWMuiHlELXUK2J9R2t7D0fCcQShC9Jx+sysI=;
        b=bYwlQUxUk7yIH3ok9B7IB2RK3crwZ4aNGMXkLeHcr9sTYzncBZMVZHvXIbpjXBFDlg
         BqXyW3ETA3s2R0FNduPFMaflvlpiOTuopzqARqiq1jtAFN/XEGmOTs/aFo3z5GzYsglY
         BKes1mPcaar0GaKLiXirTmytwzXl3x7kjUfUwglwqEZGZmwb4ixxFoehBz5yD8YUYNyl
         6lFHv+rc9ZZWv4WCZnRLin65XkkgcDzIztw/WjAvbK5hNQzx1s6XAXOj5UcfSpk4IT8a
         lvfV0v4ChdhjVK44iCX3uvIg9fkANJZfVMuFm8XOa/+1T7vOOnFoxyHaSC4zP0yRnCZa
         Fz+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680810904; x=1683402904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sZZNsZ3DWMuiHlELXUK2J9R2t7D0fCcQShC9Jx+sysI=;
        b=bZ9p9Kw8J3Ggrcvsvk7q8w5argn5i1J9e3yYaBdOHDkywVz8Xynt9STnMSYVMBhMz9
         x+tJyHtc8QasblB51U4ApL8IIoXi8IAiRgiyXZ48vq4oQvEFWUacUQpiMOTQ01zGEa5G
         lT8eZTkyWTEM1JEIzX1d13PBiBYX6K2sTif9NvwpOuNmk0GK84hqs+NDxBBx84jxey08
         q3ydLFmcZZmBZN0A/+/LoDqeTIKZouT7fAAEkAntOjX99BC6UeB8wMmcPCnIHwi7A/7v
         slDfm0UPbLDv4+kFgukQhpVrc6n1gmsDdY5HkRapDmdcLLST6f/vU7Td0+ev+FK8Y/QB
         ZEog==
X-Gm-Message-State: AAQBX9c+h0u8jSwFwXw1U9FDkHdD7ROt4JVSUH/ARK8y7eMdM/FvMrgq
        4CRrOnqvUASr3qJt+YRboJW6ddI5I+or/7GEXUc=
X-Google-Smtp-Source: AKy350Y4YvZcs9vWepIoY5YVssak2mu/pb6clNRY7bDS4xvBSeva12YnBNuPc9+gXWQVE4yHHrNT3JwzHCQzppvy3H8=
X-Received: by 2002:a50:9b5b:0:b0:4fb:c8e3:1adb with SMTP id
 a27-20020a509b5b000000b004fbc8e31adbmr381318edj.3.1680810903521; Thu, 06 Apr
 2023 12:55:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230330055600.86870-1-yhs@fb.com> <CAEf4Bzayt_FUG6JyMzU060swqP_w=W9TFJOKD15ux6GNDm3qSg@mail.gmail.com>
 <b73075cb-67c4-2144-64f9-fc564eb00833@meta.com> <CAEf4BzYOqGVac3QDMD3LGVBS9tj56PQaZjxh+1FzVSYrx1=TSA@mail.gmail.com>
In-Reply-To: <CAEf4BzYOqGVac3QDMD3LGVBS9tj56PQaZjxh+1FzVSYrx1=TSA@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 6 Apr 2023 12:54:52 -0700
Message-ID: <CAADnVQ+dnqrNEchHyTCkzNs+v-0CrpWePBA012oG6MgHkw7KJw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/7] bpf: Improve verifier for cond_op and
 spilled loop index variables
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Yonghong Song <yhs@meta.com>, Yonghong Song <yhs@fb.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
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

On Thu, Apr 6, 2023 at 11:39=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Apr 6, 2023 at 9:49=E2=80=AFAM Yonghong Song <yhs@meta.com> wrote=
:
> >
> >
> >
> > On 4/4/23 2:46 PM, Andrii Nakryiko wrote:
> > > On Wed, Mar 29, 2023 at 10:56=E2=80=AFPM Yonghong Song <yhs@fb.com> w=
rote:
> > >>
> > >> LLVM commit [1] introduced hoistMinMax optimization like
> > >>    (i < VIRTIO_MAX_SGS) && (i < out_sgs)
> > >> to
> > >>    upper =3D MIN(VIRTIO_MAX_SGS, out_sgs)
> > >>    ... i < upper ...
> > >> and caused the verification failure. Commit [2] workarounded the iss=
ue by
> > >> adding some bpf assembly code to prohibit the above optimization.
> > >> This patch improved verifier such that verification can succeed with=
out
> > >> the above workaround.
> > >>
> > >> Without [2], the current verifier will hit the following failures:
> > >>    ...
> > >>    119: (15) if r1 =3D=3D 0x0 goto pc+1
> > >>    The sequence of 8193 jumps is too complex.
> > >>    verification time 525829 usec
> > >>    stack depth 64
> > >>    processed 156616 insns (limit 1000000) max_states_per_insn 8 tota=
l_states 1754 peak_states 1712 mark_read 12
> > >>    -- END PROG LOAD LOG --
> > >>    libbpf: prog 'trace_virtqueue_add_sgs': failed to load: -14
> > >>    libbpf: failed to load object 'loop6.bpf.o'
> > >>    ...
> > >> The failure is due to verifier inadequately handling '<const> <cond_=
op> <non_const>' which will
> > >> go through both pathes and generate the following verificaiton state=
s:
> > >>    ...
> > >>    89: (07) r2 +=3D 1                      ; R2_w=3D5
> > >>    90: (79) r8 =3D *(u64 *)(r10 -48)       ; R8_w=3Dscalar() R10=3Df=
p0
> > >>    91: (79) r1 =3D *(u64 *)(r10 -56)       ; R1_w=3Dscalar(umax=3D5,=
var_off=3D(0x0; 0x7)) R10=3Dfp0
> > >>    92: (ad) if r2 < r1 goto pc+41        ; R0_w=3Dscalar() R1_w=3Dsc=
alar(umin=3D6,umax=3D5,var_off=3D(0x4; 0x3))
> > >
> > > offtopic, but if this is a real output, then something is wrong with
> > > scratching register logic for conditional, it should have emitted
> > > states of R1 and R2, maybe you can take a look while working on this
> > > patch set?
> >
> > Yes, this is the real output. Yes, the above R1_w should be an
> > impossible state. This is what this patch tries to fix.
> > I am not what verifier should do if this state indeed happens,
> > return an -EFAULT or something?
>
> no-no, that's not what I'm talking about. Look at the instruction, it
> compares R1 and R2, yet we print the state of R0 and R1, as if that
> instruction worked with R0 and R1 instead. That's confusing and wrong.
> There is some off-by-one error in mark_register_scratched() call, or
> something like that.

I suspect Yonghong just trimmed the output.
Line 92 has both R1 and R2 below.
Why R0, R6, R7, R8 are also there... is indeed wrong.
I've looked at scratch marking logic and don't an obvious bug.
Something to investigate.

> >
> > >
> > >>        R2_w=3D5 R6_w=3Dscalar(id=3D385) R7_w=3D0 R8_w=3Dscalar() R9_=
w=3Dscalar(umax=3D21474836475,var_off=3D(0x0; 0x7ffffffff))
> > >>        R10=3Dfp0 fp-8=3Dmmmmmmmm fp-16=3Dmmmmmmmm fp-24=3Dmmmm???? f=
p-32=3D fp-40_w=3D4 fp-48=3Dmmmmmmmm fp-56=3D fp-64=3Dmmmmmmmm
> > >>    ...
> > >>    89: (07) r2 +=3D 1                      ; R2_w=3D6
> > >>    90: (79) r8 =3D *(u64 *)(r10 -48)       ; R8_w=3Dscalar() R10=3Df=
p0
> > >>    91: (79) r1 =3D *(u64 *)(r10 -56)       ; R1_w=3Dscalar(umax=3D5,=
var_off=3D(0x0; 0x7)) R10=3Dfp0
> > >>    92: (ad) if r2 < r1 goto pc+41        ; R0_w=3Dscalar() R1_w=3Dsc=
alar(umin=3D7,umax=3D5,var_off=3D(0x4; 0x3))
> > >>        R2_w=3D6 R6=3Dscalar(id=3D388) R7=3D0 R8_w=3Dscalar() R9_w=3D=
scalar(umax=3D25769803770,var_off=3D(0x0; 0x7ffffffff))
> > >>        R10=3Dfp0 fp-8=3Dmmmmmmmm fp-16=3Dmmmmmmmm fp-24=3Dmmmm???? f=
p-32=3D fp-40=3D5 fp-48=3Dmmmmmmmm fp-56=3D fp-64=3Dmmmmmmmm
> > >>      ...
> > >>    89: (07) r2 +=3D 1                      ; R2_w=3D4088
> > >>    90: (79) r8 =3D *(u64 *)(r10 -48)       ; R8_w=3Dscalar() R10=3Df=
p0
> > >>    91: (79) r1 =3D *(u64 *)(r10 -56)       ; R1_w=3Dscalar(umax=3D5,=
var_off=3D(0x0; 0x7)) R10=3Dfp0
> > >>    92: (ad) if r2 < r1 goto pc+41        ; R0=3Dscalar() R1=3Dscalar=
(umin=3D4089,umax=3D5,var_off=3D(0x0; 0x7))
> > >>        R2=3D4088 R6=3Dscalar(id=3D12634) R7=3D0 R8=3Dscalar() R9=3Ds=
calar(umax=3D17557826301960,var_off=3D(0x0; 0xfffffffffff))
> > >>        R10=3Dfp0 fp-8=3Dmmmmmmmm fp-16=3Dmmmmmmmm fp-24=3Dmmmm???? f=
p-32=3D fp-40=3D4087 fp-48=3Dmmmmmmmm fp-56=3D fp-64=3Dmmmmmmmm
> > >>
> > >> Patch 3 fixed the above issue by handling '<const> <cond_op> <non_co=
nst>' properly.
> > >> During developing selftests for Patch 3, I found some issues with bo=
und deduction with
> > >> BPF_EQ/BPF_NE and fixed the issue in Patch 1.
> > [...]
