Return-Path: <bpf+bounces-6299-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39193767A4A
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 02:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44CC91C218E0
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 00:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919137E0;
	Sat, 29 Jul 2023 00:53:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670FB7C
	for <bpf@vger.kernel.org>; Sat, 29 Jul 2023 00:53:47 +0000 (UTC)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2874EE6
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 17:53:21 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b72161c6e9so49347491fa.0
        for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 17:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690591946; x=1691196746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aM4BL6iGUN1LckaSEABpRw/rJR7OXts8NUN8kOvBUrc=;
        b=Qpe+BCUXXI6yc+TwzLxQOz2Gq8t2lWzuUXZo+bfK+34zxA7QWfQ1K7vpwDPF3Bo74+
         SF3UawbpqPRkRC/NjgLKOBWP+myoVORN/ZfSMTwSu9A0h6pOqGnHctd8RhgK87vDqLSO
         eelWVoGj38dEKEJ/1VbfitHi9A/IxqmjCMpCKPv1i5a75LqQ6R241ciW8BnljfmeCWUs
         32P39XEy55NYJMfTPdMt0lnIHj9/1O/rZptCbQd5KGb0Q8OYiwAXTprRdSB7Ai1adCDC
         F30G9nR6wVyYVfMl1Q2qVGepRqmK4qKxuUCxNtFTMNCZLvs7dboCiascrOy3H3Dygrxd
         bI1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690591946; x=1691196746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aM4BL6iGUN1LckaSEABpRw/rJR7OXts8NUN8kOvBUrc=;
        b=VVOp+WraJL9+0w3LsjboDceIZ6jV4R8yt6UcxTOU16k3LPSa/dgv9n1M12q64fkXp9
         eX19+fVHMApHkq1gNI0suKaN4x58bYAq+3xyCtcjBY/KkbROpomq8rCQ2lAhr0J8Kxqw
         WibkmxgtArnU6HMWyariC/dbQO38/x3wB6LskzwAaJ7+SfoxFhEXbbxT/liH76BMem2e
         wRyS9Kr8y07iTOJaI+0THTsZ9/XNe2JhsRV1iT/KOhpnFemwCA44l+Y6g87PZXr6X7YE
         kBoRTDJaGV/84AD7qeyKPy6IFZ45so7OennSqq6xCaCM9nbeaRUBYIbrhTf70gvr3Qle
         fi4w==
X-Gm-Message-State: ABy/qLZG0roGPELvVMLZczRn5xCNq7DWTaaNEujPbzSkHfRTanCSagZD
	J9x8QSQLsM+aUIJVuGYmhuH8aX/lAwZlg2GsvDc=
X-Google-Smtp-Source: APBJJlHc9+cLY9B666i/axrKpgjgN4X/7Xz2vnn5Jz4dIPMGQDLAXYvksl2KaoWn0zW9jwIm91vm+7Wf2IScLay5Nsc=
X-Received: by 2002:a2e:880f:0:b0:2b6:d03a:5d8d with SMTP id
 x15-20020a2e880f000000b002b6d03a5d8dmr1451744ljh.6.1690591945739; Fri, 28 Jul
 2023 17:52:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACsn0ckZO+b5bRgMZhOvx+Jn-sa0g8cBD+ug1CJEdtYxSm_hgA@mail.gmail.com>
 <PH7PR21MB3878D8DCEF24A5F8E52BA59DA303A@PH7PR21MB3878.namprd21.prod.outlook.com>
 <CAADnVQJ1fKXcsTXdCijwQzf0OVF0md-ATN5RbB3g10geyofNzA@mail.gmail.com>
 <CACsn0cmf22zEN9AduiRiFnQ7XhY1ABRL=SwAwmmFgxJvVZAOsg@mail.gmail.com>
 <CADx9qWi+VQ=do+_Bsd8W4Yc-S1LekVq7Hp4bfD3nz0YP47Sqgg@mail.gmail.com>
 <CAADnVQ+5d8ztfFLraWnZKszAX23Z-12=pHjJfufNbd3qzWVNsQ@mail.gmail.com>
 <CADx9qWhSqb6xAP=nz5N-vmd2N3+h4TBFtFOGdJUWNfX=LapEBw@mail.gmail.com>
 <CAADnVQJ4yzDc0qQExLUO1b23ndEiEjnYYPv5qC7JJYmLr4X3ew@mail.gmail.com>
 <CADx9qWh6ZUKvjkZow6=eB4gvEgP82mBqn+mMZvmDQynCYAfMWw@mail.gmail.com>
 <CAADnVQKOiwm1UB58=8QcowDyfPQct-wuMD19citS7w5PmadZ6g@mail.gmail.com> <CADx9qWjYChRf2qBr=Pt5D-RLCb665YFKmjDYX8WOQfqMx1-bag@mail.gmail.com>
In-Reply-To: <CADx9qWjYChRf2qBr=Pt5D-RLCb665YFKmjDYX8WOQfqMx1-bag@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 28 Jul 2023 17:52:14 -0700
Message-ID: <CAADnVQJDO9MgU2MQQ5NQAE3EwL6PuPp8aAxcV3apf0DHoq8TAw@mail.gmail.com>
Subject: Re: [Bpf] Review of draft-thaler-bpf-isa-01
To: Will Hawkins <hawkinsw@obs.cr>
Cc: Watson Ladd <watsonbladd@gmail.com>, Dave Thaler <dthaler@microsoft.com>, 
	"bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 28, 2023 at 5:46=E2=80=AFPM Will Hawkins <hawkinsw@obs.cr> wrot=
e:
>
> On Fri, Jul 28, 2023 at 8:35=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Jul 28, 2023 at 5:19=E2=80=AFPM Will Hawkins <hawkinsw@obs.cr> =
wrote:
> > >
> > > On Fri, Jul 28, 2023 at 8:05=E2=80=AFPM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Fri, Jul 28, 2023 at 4:32=E2=80=AFPM Will Hawkins <hawkinsw@obs.=
cr> wrote:
> > > > >
> > > > > On Thu, Jul 27, 2023 at 9:05=E2=80=AFPM Alexei Starovoitov
> > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > >
> > > > > > On Wed, Jul 26, 2023 at 12:16=E2=80=AFPM Will Hawkins <hawkinsw=
@obs.cr> wrote:
> > > > > > >
> > > > > > > On Tue, Jul 25, 2023 at 2:37=E2=80=AFPM Watson Ladd <watsonbl=
add@gmail.com> wrote:
> > > > > > > >
> > > > > > > > On Tue, Jul 25, 2023 at 9:15=E2=80=AFAM Alexei Starovoitov
> > > > > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > On Tue, Jul 25, 2023 at 7:03=E2=80=AFAM Dave Thaler <dtha=
ler@microsoft.com> wrote:
> > > > > > > > > >
> > > > > > > > > > I am forwarding the email below (after converting HTML =
to plain text)
> > > > > > > > > > to the mailto:bpf@vger.kernel.org list so replies can g=
o to both lists.
> > > > > > > > > >
> > > > > > > > > > Please use this one for any replies.
> > > > > > > > > >
> > > > > > > > > > Thanks,
> > > > > > > > > > Dave
> > > > > > > > > >
> > > > > > > > > > > From: Bpf <bpf-bounces@ietf.org> On Behalf Of Watson =
Ladd
> > > > > > > > > > > Sent: Monday, July 24, 2023 10:05 PM
> > > > > > > > > > > To: bpf@ietf.org
> > > > > > > > > > > Subject: [Bpf] Review of draft-thaler-bpf-isa-01
> > > > > > > > > > >
> > > > > > > > > > > Dear BPF wg,
> > > > > > > > > > >
> > > > > > > > > > > I took a look at the draft and think it has some issu=
es, unsurprisingly at this stage. One is
> > > > > > > > > > > the specification seems to use an underspecified C ps=
eudo code for operations vs
> > > > > > > > > > > defining them mathematically.
> > > > > > > > >
> > > > > > > > > Hi Watson,
> > > > > > > > >
> > > > > > > > > This is not "underspecified C" pseudo code.
> > > > > > > > > This is assembly syntax parsed and emitted by GCC, LLVM, =
gas, Linux Kernel, etc.
> > > > > > > >
> > > > > > > > I don't see a reference to any description of that in secti=
on 4.1.
> > > > > > > > It's possible I've overlooked this, and if people think thi=
s style of
> > > > > > > > definition is good enough that works for me. But I found ta=
ble 4
> > > > > > > > pretty scanty on what exactly happens.
> > > > > > >
> > > > > > > Hello! Based on Watson's post, I have done some research and =
would
> > > > > > > potentially like to offer a path forward. There are several d=
ifferent
> > > > > > > ways that ISAs specify the semantics of their operations:
> > > > > > >
> > > > > > > 1. Intel has a section in their manual that describes the pse=
udocode
> > > > > > > they use to specify their ISA: Section 3.1.1.9 of The Intel=
=C2=AE 64 and
> > > > > > > IA-32 Architectures Software Developer=E2=80=99s Manual at
> > > > > > > https://cdrdv2.intel.com/v1/dl/getContent/671199
> > > > > > > 2. ARM has an equivalent for their variety of pseudocode: Cha=
pter J1
> > > > > > > of Arm Architecture Reference Manual for A-profile architectu=
re at
> > > > > > > https://developer.arm.com/documentation/ddi0487/latest/
> > > > > > > 3. Sail "is a language for describing the instruction-set arc=
hitecture
> > > > > > > (ISA) semantics of processors."
> > > > > > > (https://www.cl.cam.ac.uk/~pes20/sail/)
> > > > > > >
> > > > > > > Given the commercial nature of (1) and (2), perhaps Sail is a=
 way to
> > > > > > > proceed. If people are interested, I would be happy to lead a=
n effort
> > > > > > > to encode the eBPF ISA semantics in Sail (or find someone who=
 already
> > > > > > > has) and incorporate them in the draft.
> > > > > >
> > > > > > imo Sail is too researchy to have practical use.
> > > > > > Looking at arm64 or x86 Sail description I really don't see how
> > > > > > it would map to an IETF standard.
> > > > > > It's done in a "sail" language that people need to learn first =
to be
> > > > > > able to read it.
> > > > > > Say we had bpf.sail somewhere on github. What value does it bri=
ng to
> > > > > > BPF ISA standard? I don't see an immediate benefit to standardi=
zation.
> > > > > > There could be other use cases, no doubt, but standardization i=
s our goal.
> > > > > >
> > > > > > As far as 1 and 2. Intel and Arm use their own pseudocode, so t=
hey had
> > > > > > to add a paragraph to describe it. We are using C to describe B=
PF ISA
> > > > >
> > > > >
> > > > > I cannot find a reference in the current version that specifies w=
hat
> > > > > we are using to describe the operations. I'd like to add that, bu=
t
> > > > > want to make sure that I clarify two statements that seem to be a=
t
> > > > > odds.
> > > > >
> > > > > Immediately above you say that we are using "C to describe the BP=
F
> > > > > ISA" and further above you say "This is assembly syntax parsed an=
d
> > > > > emitted by GCC, LLVM, gas, Linux Kernel, etc."
> > > > >
> > > > > My own reading is that it is the former, and not the latter. But,=
 I
> > > > > want to double check before adding the appropriate statements to =
the
> > > > > Convention section.
> > > >
> > > > It's both. I'm not sure where you see a contradiction.
> > > > It's a normal C syntax and it's emitted by the kernel verifier,
> > > > parsed by clang/gcc assemblers and emitted by compilers.
> > >
> > >
> > > Okay. I apologize. I am sincerely confused. For instance,
> > >
> > > if (u32)dst >=3D (u32)src goto +offset
> > >
> > > Looks like nothing that I have ever seen in "normal C syntax".
> >
> > I thought we're talking about table 4 and ALU ops.
> > Above is not a pure C, but it's obvious enough without explanation, no?
>
> To "us", yes. Although I am not an expert, it seems like being
> explicit is important when it comes to writing a spec. I suppose we
> should leave that to Dave and the chairs.
>
> > Also I don't see above anywhere in the doc.
>
> That is from the Appendix. It is currently in Dave's tree and gets
> amalgamated with other files to build the final draft.
>
> https://datatracker.ietf.org/doc/draft-thaler-bpf-isa/

This is a mirror and it's already outdated.
You should look at the source. Which is git kernel tree.

