Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6BC31CA36
	for <lists+bpf@lfdr.de>; Tue, 16 Feb 2021 12:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhBPLzM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Feb 2021 06:55:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:44690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230303AbhBPLyQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Feb 2021 06:54:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7706664DF0
        for <bpf@vger.kernel.org>; Tue, 16 Feb 2021 11:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613476414;
        bh=QBdv2AZM4dEPOnAW6YSYjiTKYKmtPPa7dKBf2XRt0nA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IYkUHhVuhRPHauu24jHqJVDtpIdJ0vnPXxsq3dQpaSf0otgopSIE3URA47OKe1EFd
         FXCfsgOKyQXcDZepCaXB+BhGN7C9e7g/L99hi2V0wj+T4xFomRlGBsHB6GdZ9XRZ+r
         SvEWRttUFVcfa+j9BwnMRABG4JoXkp+/L1u5vK6gFr/KsrQjrbunZaitxdm6vsw3Zz
         vAjIrd0F+255IpU+SBHseGL+R+CTt65eKdPXifJzyoMWRluz2EDmuMmP6vvtsANEXd
         6UnIIxqCwJ+RG2aU/IQGO32oJFacQJDItK3g53PhFx+APiYIgBqGA2H3n2F83HgbZq
         lE41VrFRXMf6Q==
Received: by mail-lf1-f50.google.com with SMTP id v5so15211853lft.13
        for <bpf@vger.kernel.org>; Tue, 16 Feb 2021 03:53:34 -0800 (PST)
X-Gm-Message-State: AOAM531d3gOecRtF6cpw+glERBe9KzdlcSiKaEHBVADNfcZLagfmoEnC
        6DSF1EjV//LgIfaeQczl/+HZKDjEHvUKW7ipSgzZAQ==
X-Google-Smtp-Source: ABdhPJyulgfRuw9lGnOWBa7z0yFaIyaHkIREogWXsyQZkKdIhyNFxNyx4O8/WIBcSR19KJDoI/umLZk6sL0jox5Sin8=
X-Received: by 2002:a05:6512:3607:: with SMTP id f7mr12109706lfs.550.1613476412601;
 Tue, 16 Feb 2021 03:53:32 -0800 (PST)
MIME-Version: 1.0
References: <20210215160044.1108652-1-jackmanb@google.com> <CACYkzJ6fwJNv6r3CvY7uO5xjZsXDVuuFrkMieLzOKsqQZ_0Jzw@mail.gmail.com>
 <CA+i-1C3guH-jDbSiF03frBsopKhn2RphTsv3zPpXW4tmXmZPdw@mail.gmail.com>
In-Reply-To: <CA+i-1C3guH-jDbSiF03frBsopKhn2RphTsv3zPpXW4tmXmZPdw@mail.gmail.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Tue, 16 Feb 2021 12:53:21 +0100
X-Gmail-Original-Message-ID: <CACYkzJ5Z7oKS-rdMrG=9tM_ZiEzaxBjC2an_nJ4fy-i7E7LCAw@mail.gmail.com>
Message-ID: <CACYkzJ5Z7oKS-rdMrG=9tM_ZiEzaxBjC2an_nJ4fy-i7E7LCAw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: x86: Fix BPF_FETCH atomic and/or/xor with
 r0 as src
To:     Brendan Jackman <jackmanb@google.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Florent Revest <revest@chromium.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 16, 2021 at 11:33 AM Brendan Jackman <jackmanb@google.com> wrote:
>
> On Mon, 15 Feb 2021 at 22:09, KP Singh <kpsingh@kernel.org> wrote:
> >
> > On Mon, Feb 15, 2021 at 5:00 PM Brendan Jackman <jackmanb@google.com> wrote:
> > >
> > > This code generates a CMPXCHG loop in order to implement atomic_fetch
> > > bitwise operations. Because CMPXCHG is hard-coded to use rax (which
> > > holds the BPF r0 value), it saves the _real_ r0 value into the
> > > internal "ax" temporary register and restores it once the loop is
> > > complete.
> > >
> > > In the middle of the loop, the actual bitwise operation is performed
> > > using src_reg. The bug occurs when src_reg is r0: as described above,
> > > r0 has been clobbered and the real r0 value is in the ax register.
> > >
> > > Therefore, perform this operation on the ax register instead, when
> > > src_reg is r0.
> > >
> > > Fixes: 981f94c3e921 ("bpf: Add bitwise atomic instructions")
> > > Signed-off-by: Brendan Jackman <jackmanb@google.com>
> > > ---
> > >  arch/x86/net/bpf_jit_comp.c                   |  7 +++---
> > >  .../selftests/bpf/verifier/atomic_and.c       | 23 +++++++++++++++++++
> > >  2 files changed, 27 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > > index 79e7a0ec1da5..0c9edfe42340 100644
> > > --- a/arch/x86/net/bpf_jit_comp.c
> > > +++ b/arch/x86/net/bpf_jit_comp.c
> > > @@ -1349,6 +1349,7 @@ st:                       if (is_imm8(insn->off))
> > >                             insn->imm == (BPF_XOR | BPF_FETCH)) {
> > >                                 u8 *branch_target;
> > >                                 bool is64 = BPF_SIZE(insn->code) == BPF_DW;
> > > +                               u32 real_src_reg = src_reg == BPF_REG_0 ? BPF_REG_AX : src_reg;
> >
> > I think it would be more readable as:
> >
> >  u32 real_src_reg =  src_reg;
> >
> > /* Add a comment here why this is needed */
> > if (src_reg == BPF_REG_0)
> >   real_src_reg = BPF_REG_AX;
>
> Yes good idea - actually if I put it next to the relevant mov:
>
>   /* Will need RAX as a CMPXCHG operand so save R0 */
>   emit_mov_reg(&prog, true, BPF_REG_AX, BPF_REG_0)
>   if (src_reg == BPF_REG_0)
>         real_src_reg = BPF_REG_AX;
>
> I don't think it even needs a comment - what do you think?

Yeah moving it there makes sense and you already have a comment there.
