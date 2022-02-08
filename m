Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5AA4AE459
	for <lists+bpf@lfdr.de>; Tue,  8 Feb 2022 23:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386713AbiBHW1Z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 17:27:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387694AbiBHW0G (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 17:26:06 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC33CC03CA4E
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 14:23:12 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id z18so227281ilp.3
        for <bpf@vger.kernel.org>; Tue, 08 Feb 2022 14:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HUThtQLdZH/W9W4Do7W5skc1/Xbfv/t7POHx9bFGHRM=;
        b=D3WsGUHKbJH+t7OG8G5ISp3zMmMChb78YZ3wfKMGwl1nhaRQsD5IP+r773Ndm0Y4cB
         bOnBkBIDgON3fuoXbiASguXvMY6vUEkekYE64Olk68SHpPErm4p7infmGv3oBEcOAca3
         CxmG/nn9NmOth/Reo7eu1qonxn8xtVuzTapHiWRrdowO3l5GP15tI9OCWz/ZgIBPZCqS
         fEFrnjS/VSyEY4GC8c7mzGW00btQm/BCZqAaqDq49pcY7JrXPWFHd8FYOEOiPoQDhoz+
         TIR22OXoobiL2HcaMc5adkNsxfD01V062U9B8be9y6OW6/2vFAyMIWFG04ZLZwWSwNyh
         vGqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HUThtQLdZH/W9W4Do7W5skc1/Xbfv/t7POHx9bFGHRM=;
        b=OhvbfkR9NKAcWh1oS5s094gxZiJ0R63SbHMs2KvUERpjmW4guvk3TDKH1LJRuxg30E
         fsoIAaoqwypoBQwhDpM02SR7x+wuDDyrLwOHT1uUQxxwibIrTik0tnaO6KdXs9LRm8Pf
         5ykVy8xycAH2Ta6GrHE6EnrKZ43IGLLjixx0pNMFELLyIiz2Sj2fgolS/xlZoVfJfM60
         vU3NcUjYG8Q+OyfjVxNo3byJXx5GzDueFD8DH6AnCEQJTGTnv8ZbFezbgULGXZEu/ZI2
         eyPzC03ddLAMOexDi1bzMuqpXFacBW3sxxto+3G3Cs+ZsuVMfWhAHQbK/1HHsm2ghxxS
         28Vw==
X-Gm-Message-State: AOAM533yeiAzdg3s2C9HwKegx1s8aJjvfcasoXvUqcx21jR80XgSVYt3
        b4JNbcW7RpBVWwn6iKtEaTwAOASWVJkoWlt+WL8=
X-Google-Smtp-Source: ABdhPJyDtlz3d5YTvAjUIQw0eA9bzu+yF8x/wdrXZxiMaUPYK7Yz4kDNRs8Er9gAGEqlVQ2YHy1cPAsq4SvuthbBCtE=
X-Received: by 2002:a05:6e02:190e:: with SMTP id w14mr3172398ilu.71.1644358992289;
 Tue, 08 Feb 2022 14:23:12 -0800 (PST)
MIME-Version: 1.0
References: <20220208051635.2160304-1-iii@linux.ibm.com> <20220208051635.2160304-15-iii@linux.ibm.com>
 <20220208192522.risaxa7debgxx5kz@ast-mbp.dhcp.thefacebook.com>
 <bb17e7657ada2577664caa6d0b9fbfcabf2f1676.camel@linux.ibm.com>
 <CAADnVQLELpdhZba0GQdY6G-F6Ce4jnb_QnrJwc8F6yjMnLcEAw@mail.gmail.com> <ee69bf0200fa21f2bab34384d57c32f126993d93.camel@linux.ibm.com>
In-Reply-To: <ee69bf0200fa21f2bab34384d57c32f126993d93.camel@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 8 Feb 2022 14:23:01 -0800
Message-ID: <CAEf4Bzbh7pXOtXuWpukJMMR-enAON1-c0+kSTfeV_KiP7-zu1A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 14/14] arm64: add a comment that warns that
 orig_x0 should not be moved
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 8, 2022 at 1:46 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> On Tue, 2022-02-08 at 13:11 -0800, Alexei Starovoitov wrote:
> > On Tue, Feb 8, 2022 at 11:46 AM Ilya Leoshkevich <iii@linux.ibm.com>
> > wrote:
> > >
> > > On Tue, 2022-02-08 at 11:25 -0800, Alexei Starovoitov wrote:
> > > > On Tue, Feb 08, 2022 at 06:16:35AM +0100, Ilya Leoshkevich wrote:
> > > > > orig_x0's location is used by libbpf tracing macros, therefore
> > > > > it
> > > > > should not be moved.
> > > > >
> > > > > Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > > > > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > > > > ---
> > > > >  arch/arm64/include/asm/ptrace.h | 4 ++++
> > > > >  1 file changed, 4 insertions(+)
> > > > >
> > > > > diff --git a/arch/arm64/include/asm/ptrace.h
> > > > > b/arch/arm64/include/asm/ptrace.h
> > > > > index 41b332c054ab..7e34c3737839 100644
> > > > > --- a/arch/arm64/include/asm/ptrace.h
> > > > > +++ b/arch/arm64/include/asm/ptrace.h
> > > > > @@ -185,6 +185,10 @@ struct pt_regs {
> > > > >                         u64 pstate;
> > > > >                 };
> > > > >         };
> > > > > +       /*
> > > > > +        * orig_x0 is not exposed via struct user_pt_regs, but
> > > > > its
> > > > > location is
> > > > > +        * assumed by libbpf's tracing macros, so it should not
> > > > > be
> > > > > moved.
> > > > > +        */
> > > >
> > > > In other words this comment is saying that the layout is ABI.
> > > > That's not the case. orig_x0 here and equivalent on s390 can be
> > > > moved.
> > > > It will break bpf progs written without CO-RE and that is
> > > > expected.
> > > > Non CO-RE programs often do all kinds of bpf_probe_read_kernel
> > > > and
> > > > will be breaking when kernel layout is changing.
> > > > I suggest to drop this patch and patch 12.
> > >
> > > Yeah, that was the intention here: to promote orig_x0 to ABI using
> > > a
> > > comment, since doing this by extending user_pt_regs turned out to
> > > be
> > > infeasible. I'm actually ok with not doing this, since programs
> > > compiled with kernel headers and using CO-RE macros will be fine.
> >
> > The comment like this doesn't convert kernel internal struct into
> > ABI.
> > The comment is just wrong. BPF progs access many kernel data structs.
> > s390's and arm64's struct pr_regs is not special in that sense.
> > It's an internal struct.
> >
> > > As you say, we don't care about programs that don't use CO-RE too
> > > much
> > > here - if they break after an incompatible kernel change, fine.
> >
> > Before CO-RE was introduced bpf progs included kernel headers
> > and were breaking when kernel changes. Nothing new here.
> > See the history of bcc tools. Some of them are littered
> > with ifdef VERSION ==.
> >
> > > The question now is - how much do we care about programs that are
> >
> > > compiled with userspace headers? Andrii suggested to use
> > > offsetofend to
> > > make syscall macros work there, however, this now requires this ABI
> > > promotion.
> >
> > Today s390 and arm64 have user_pt_regs as a first field in pt_regs.
> > That is kernel internal behavior and that part can change if arch
> > maintainers have a need for that.
> > bpf progs without CO-RE would have to be adjusted when kernel
> > changes.
> > Even with CO-RE it's ok to rename pt_regs->orig_gpr2 on s390.
> > The progs with CO-RE will break too. The authors of tracing bpf progs
> > have to expect that sooner or later their progs will break and they
> > would have to adjust them.
>
> When it comes to authors of tracing bpf progs, I agree that eventually
> they will have to adjust their code, CO-RE or not. However, in patch 13
> I introduce the following libbpf macro:
>
> #if defined(__KERNEL__) || defined(__VMLINUX_H__)
> ...
> #else
> #define PT_REGS_PARM1_SYSCALL(x) \
>         (*(unsigned long *)(((char *)(x) + \
>                              offsetofend(struct user_pt_regs,
> pstate))))
>
> If we merge this series without freezing orig_x0's offset, in case of
> an incompatible kernel change the users of PT_REGS_PARMn_SYSCALL and
> BPF_KPROBE_SYSCALL, who build against userspace headers, will not
> simply have to update their code - they will have to upgrade libbpf.
> It's also not clear how PT_REGS_PARM1_SYSCALL in the upgraded libbpf
> will even look like, given that it would need to work on both old and
> new kernels.
>
> I've also briefly looked into MIPS' ptrace.h, and it looks as if their
> user_pt_regs has no relationship to kernel pt_regs. IIUC this means
> that it's not possible to correctly implement PT_REGS_PARMn_SYSCALL
> using MIPS userspace headers.
>
> So I wonder whether we should allow using PT_REGS_PARMn_SYSCALL and
> BPF_KPROBE_SYSCALL with userspace headers at all? Would it make sense
> to simply fail the compilation if PT_REGS_PARMn_SYSCALL is used without
> including kernel headers?

Ok, my bad for suggesting those comments, I didn't realize the
consequences of making anything into a stable ABI. Let's not add any
comments, we don't need that.

I think we should just come to terms that for some architectures this
syscall argument access won't work at least for some architectures
without CO-RE. For uniformity let's still have those
PT_REGS_PARM1_SYSCALL macro defined, but we should use
__bpf_unreachable or something like that to make sure it won't compile
if someone tries to use it.

But it's an entirely different story for CORE variants and there (as I
explained on one of the previous patches) we can fabricate our own
definitions of pt_regs (architecture specific, using CO-RE struct
flavors) without any unnecessary assumptions about which include
headers the user is going to use. Hengqi's BPF_KPROBE_SYSCALL() macro
is always going to use CORE variants and will "just work"(tm).

And because this asymmetry of CORE and non-CORE PT_REGS_PARM_SYSCALL
definitions, your changes in v4 are a regression from the ones in v3
which were absolutely fine (I still don't get why you changed all of
that, I've previously landed v3, which means it was 100% acceptable as
is...), because v4 establishes more rigid relation between CORE and
non-CORE variants.

Anyways, let's get back to v3, drop UAPI changes, add struct
pt_regs__s390x and whatever fields we need, use those with
BPF_CORE_READ() and it should be ok with no ABI changes whatsoever.
