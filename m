Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5890B4AE380
	for <lists+bpf@lfdr.de>; Tue,  8 Feb 2022 23:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386375AbiBHWW5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 17:22:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386785AbiBHVL3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 16:11:29 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8F6C0612B8
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 13:11:28 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id e28so636785pfj.5
        for <bpf@vger.kernel.org>; Tue, 08 Feb 2022 13:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7DfbRZgZsdz/DxBsQpcuhrCMQc1HtHknEbFAsG/47FQ=;
        b=Hsy4hQGOLIj8PYdGZOApNZlrgmvZnl4D4PFJ8iIR7e9TtEndo8D3puSk4cmDg7iCMv
         GdC1GycX1gcJefzNB18/RhvRUAJ4Bmy6Ae3Cm96HCdQb+CBkBrN9bKaMRS2kegZr+vP3
         gsjkMKsved8zDS77XOHkJjsoaMumLBdNjphzPz8t4C52sLKyTPaiy46sFqKqRcOaNhvJ
         2Yv/r9F5GskJ9e9kdhC4ImsXsrVI2AMel1ymWFCMqdroC23jpx3ujn5yCAkqpu/JSLFY
         xsXqSA9B/4RR65UoF4/+jHwbcNktLkhJd4Ix48jdDMp+B0wY5R44QwtTweIMOXYbvnDZ
         HdBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7DfbRZgZsdz/DxBsQpcuhrCMQc1HtHknEbFAsG/47FQ=;
        b=SWx17oDc1isvoVYNPWQzyaS4vBJ6LwVse8PHxr/bhDsFjm99OKeqZVBnL6T1k9/hHH
         KizGiN9I4gY8IEQhhy+DWTLInUmEEUPj21RWviJrnzgXJ0v0NMvW3daffirZ/Ah3SgOW
         OeYSYlfBEuYwdoj58YVcm6eRiof9MiXdicbYRbRiZXHo0irNgoGZwF4P1lFZHPN7FzHv
         2x5Rzgu0HHNWhrZ0JJ9+rHjbikB4RhwUmTrS/vaQfM/ifzSFU75WYWL8KjgPw9bu2h3k
         xOgPdLbCUKk4JcYYBumXRRBFzN1eEiIJMzfj8g170JWHssfNtoAH1NzgfR2aOvlmiyWb
         DuuA==
X-Gm-Message-State: AOAM532tVnXQfefxM3DY/ccFdjN+YvzSvQSx/JS3Tz2ag5SXi/tfNeyb
        8ojOWDe1hkQ2c0z6Sp2MF1mZVCA9PxCf+8EfBGA=
X-Google-Smtp-Source: ABdhPJwJYSXTH+76CDmjBCDBL7fntx+qO2MSW8Zcc11zg0F72vuWqOxZQSAYY6OR1KxYmVwOqtfk1eTYXRpkmRrnOKw=
X-Received: by 2002:a65:6e04:: with SMTP id bd4mr4922441pgb.375.1644354687960;
 Tue, 08 Feb 2022 13:11:27 -0800 (PST)
MIME-Version: 1.0
References: <20220208051635.2160304-1-iii@linux.ibm.com> <20220208051635.2160304-15-iii@linux.ibm.com>
 <20220208192522.risaxa7debgxx5kz@ast-mbp.dhcp.thefacebook.com> <bb17e7657ada2577664caa6d0b9fbfcabf2f1676.camel@linux.ibm.com>
In-Reply-To: <bb17e7657ada2577664caa6d0b9fbfcabf2f1676.camel@linux.ibm.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 8 Feb 2022 13:11:16 -0800
Message-ID: <CAADnVQLELpdhZba0GQdY6G-F6Ce4jnb_QnrJwc8F6yjMnLcEAw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 14/14] arm64: add a comment that warns that
 orig_x0 should not be moved
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
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

On Tue, Feb 8, 2022 at 11:46 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> On Tue, 2022-02-08 at 11:25 -0800, Alexei Starovoitov wrote:
> > On Tue, Feb 08, 2022 at 06:16:35AM +0100, Ilya Leoshkevich wrote:
> > > orig_x0's location is used by libbpf tracing macros, therefore it
> > > should not be moved.
> > >
> > > Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > > ---
> > >  arch/arm64/include/asm/ptrace.h | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/arch/arm64/include/asm/ptrace.h
> > > b/arch/arm64/include/asm/ptrace.h
> > > index 41b332c054ab..7e34c3737839 100644
> > > --- a/arch/arm64/include/asm/ptrace.h
> > > +++ b/arch/arm64/include/asm/ptrace.h
> > > @@ -185,6 +185,10 @@ struct pt_regs {
> > >                         u64 pstate;
> > >                 };
> > >         };
> > > +       /*
> > > +        * orig_x0 is not exposed via struct user_pt_regs, but its
> > > location is
> > > +        * assumed by libbpf's tracing macros, so it should not be
> > > moved.
> > > +        */
> >
> > In other words this comment is saying that the layout is ABI.
> > That's not the case. orig_x0 here and equivalent on s390 can be
> > moved.
> > It will break bpf progs written without CO-RE and that is expected.
> > Non CO-RE programs often do all kinds of bpf_probe_read_kernel and
> > will be breaking when kernel layout is changing.
> > I suggest to drop this patch and patch 12.
>
> Yeah, that was the intention here: to promote orig_x0 to ABI using a
> comment, since doing this by extending user_pt_regs turned out to be
> infeasible. I'm actually ok with not doing this, since programs
> compiled with kernel headers and using CO-RE macros will be fine.

The comment like this doesn't convert kernel internal struct into ABI.
The comment is just wrong. BPF progs access many kernel data structs.
s390's and arm64's struct pr_regs is not special in that sense.
It's an internal struct.

> As you say, we don't care about programs that don't use CO-RE too much
> here - if they break after an incompatible kernel change, fine.

Before CO-RE was introduced bpf progs included kernel headers
and were breaking when kernel changes. Nothing new here.
See the history of bcc tools. Some of them are littered
with ifdef VERSION ==.

> The question now is - how much do we care about programs that are

> compiled with userspace headers? Andrii suggested to use offsetofend to
> make syscall macros work there, however, this now requires this ABI
> promotion.

Today s390 and arm64 have user_pt_regs as a first field in pt_regs.
That is kernel internal behavior and that part can change if arch
maintainers have a need for that.
bpf progs without CO-RE would have to be adjusted when kernel changes.
Even with CO-RE it's ok to rename pt_regs->orig_gpr2 on s390.
The progs with CO-RE will break too. The authors of tracing bpf progs
have to expect that sooner or later their progs will break and they
would have to adjust them.
