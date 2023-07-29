Return-Path: <bpf+bounces-6306-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7A4767BD5
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 05:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DBED1C20B0A
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 03:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC904136A;
	Sat, 29 Jul 2023 03:14:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13C1ECA
	for <bpf@vger.kernel.org>; Sat, 29 Jul 2023 03:14:06 +0000 (UTC)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DBB423B
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 20:14:03 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-63c70dc7ed2so17557246d6.0
        for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 20:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=obs-cr.20221208.gappssmtp.com; s=20221208; t=1690600442; x=1691205242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EynXy1IlHaEgCD2qI++rDAMuUns1Tp8rqlj3v2t27yc=;
        b=ai+Q4F/tEM6xu+fNAtyGfMAQ3zqdftRUxzcrj6muyskibXAivN1fQxA7BXoOX3ZZ8f
         UvVu9akdR+2FhMJm3vcV3ZRccSEt+TbCOAtXGVoHXdZpnDFDZlAOA5fP2U4YSGHPBWCv
         6ZAVEJ0vtr5MD/fvsT/J2fPPuT7QpmNynNJUjKK2zen4fDpeAwmkIwdAdlN0AgA9xe2c
         rq0TOXgDnFiZ8tF/D7YFCQZCx+2pTrIzqVyHTB+PD+g/mb/MeBZrTZ8cC1Ya4oCKnRoR
         yzghVgnqMp5A1eXMEvnPzcI/QbSrODgALL1DbSohmkDW3b425XhsrVUspEFiesVE3Jud
         UuaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690600442; x=1691205242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EynXy1IlHaEgCD2qI++rDAMuUns1Tp8rqlj3v2t27yc=;
        b=dn4O7L39xQTN03qyob18u05UR7b6qU1Ynyb6T4+r5CUH3tBW/UnMwNeKQxgHjLxuEe
         UrTRKH59MCwpYWqw4Hjo3ehWnKG5iIJZc3FHtpeF9oHQ/HjB/hY9mbDcD7rSxvoqcHor
         Dn4QmfV2eFO7A4c4unfdSXJEQqEKFI95j0BbmQ0pvHOamgFkvMHKMDOWE67QdKFsApWs
         WDu+HkvlGbsvb/e/DDQkX+XQfsW8rQsxlWx1dLX9mkI1GqwVDhKrtWtMexTWacBkInt3
         qkdf0qWtEW/84ywO9FVRpLBPbvA8piom4tlpnaERYMW0I4nO1UHs5+Cf5J+M+fHdLtaR
         rV5g==
X-Gm-Message-State: ABy/qLZHZhMsIXnD1zyK0r3NvehWPYv5Lh+nXfZy8nvGQxKXJqNV/XEi
	LaUPcIRIIDaV/rgWKRwY+xeNWYaOVfLPM1UAhgWokA==
X-Google-Smtp-Source: APBJJlEKGrHg6PRopzi7buqaWBWihtX851+fIKxgr93RhG9Up0UcmtA+1QjMUyGQezJA6Cq0v7gVDAnjsjTkA4wy4rY=
X-Received: by 2002:a0c:efc6:0:b0:637:85e3:2a28 with SMTP id
 a6-20020a0cefc6000000b0063785e32a28mr4060330qvt.48.1690600442728; Fri, 28 Jul
 2023 20:14:02 -0700 (PDT)
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
 <CAADnVQKOiwm1UB58=8QcowDyfPQct-wuMD19citS7w5PmadZ6g@mail.gmail.com>
 <CADx9qWjYChRf2qBr=Pt5D-RLCb665YFKmjDYX8WOQfqMx1-bag@mail.gmail.com>
 <CAADnVQJDO9MgU2MQQ5NQAE3EwL6PuPp8aAxcV3apf0DHoq8TAw@mail.gmail.com>
 <CADx9qWjOP4-2K3uKBTRmS4Q5V0gTJtoH65fwN-MhZvn6ukFpBg@mail.gmail.com> <CAADnVQKbpoeMWdnXzYbBaHoDiNsLDbC0JvDUnVGEQbCigjd1Xg@mail.gmail.com>
In-Reply-To: <CAADnVQKbpoeMWdnXzYbBaHoDiNsLDbC0JvDUnVGEQbCigjd1Xg@mail.gmail.com>
From: Will Hawkins <hawkinsw@obs.cr>
Date: Fri, 28 Jul 2023 23:13:51 -0400
Message-ID: <CADx9qWj4xuYoyz83FphVWU0ZVxy_7Y+SvTWjvChvkMdV290giA@mail.gmail.com>
Subject: Re: [Bpf] Review of draft-thaler-bpf-isa-01
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Watson Ladd <watsonbladd@gmail.com>, Dave Thaler <dthaler@microsoft.com>, 
	"bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 28, 2023 at 10:32=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Jul 28, 2023 at 6:07=E2=80=AFPM Will Hawkins <hawkinsw@obs.cr> wr=
ote:
> >
> > On Fri, Jul 28, 2023 at 8:52=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Fri, Jul 28, 2023 at 5:46=E2=80=AFPM Will Hawkins <hawkinsw@obs.cr=
> wrote:
> > > >
> > > > On Fri, Jul 28, 2023 at 8:35=E2=80=AFPM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Fri, Jul 28, 2023 at 5:19=E2=80=AFPM Will Hawkins <hawkinsw@ob=
s.cr> wrote:
> > > > > >
> > > > > > On Fri, Jul 28, 2023 at 8:05=E2=80=AFPM Alexei Starovoitov
> > > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > > >
> > > > > > > On Fri, Jul 28, 2023 at 4:32=E2=80=AFPM Will Hawkins <hawkins=
w@obs.cr> wrote:
> > > > > > > >
> > > > > > > > On Thu, Jul 27, 2023 at 9:05=E2=80=AFPM Alexei Starovoitov
> > > > > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > On Wed, Jul 26, 2023 at 12:16=E2=80=AFPM Will Hawkins <ha=
wkinsw@obs.cr> wrote:
> > > > > > > > > >
> > > > > > > > > > On Tue, Jul 25, 2023 at 2:37=E2=80=AFPM Watson Ladd <wa=
tsonbladd@gmail.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Tue, Jul 25, 2023 at 9:15=E2=80=AFAM Alexei Starov=
oitov
> > > > > > > > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Tue, Jul 25, 2023 at 7:03=E2=80=AFAM Dave Thaler=
 <dthaler@microsoft.com> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > I am forwarding the email below (after converting=
 HTML to plain text)
> > > > > > > > > > > > > to the mailto:bpf@vger.kernel.org list so replies=
 can go to both lists.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Please use this one for any replies.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Thanks,
> > > > > > > > > > > > > Dave
> > > > > > > > > > > > >
> > > > > > > > > > > > > > From: Bpf <bpf-bounces@ietf.org> On Behalf Of W=
atson Ladd
> > > > > > > > > > > > > > Sent: Monday, July 24, 2023 10:05 PM
> > > > > > > > > > > > > > To: bpf@ietf.org
> > > > > > > > > > > > > > Subject: [Bpf] Review of draft-thaler-bpf-isa-0=
1
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Dear BPF wg,
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > I took a look at the draft and think it has som=
e issues, unsurprisingly at this stage. One is
> > > > > > > > > > > > > > the specification seems to use an underspecifie=
d C pseudo code for operations vs
> > > > > > > > > > > > > > defining them mathematically.
> > > > > > > > > > > >
> > > > > > > > > > > > Hi Watson,
> > > > > > > > > > > >
> > > > > > > > > > > > This is not "underspecified C" pseudo code.
> > > > > > > > > > > > This is assembly syntax parsed and emitted by GCC, =
LLVM, gas, Linux Kernel, etc.
> > > > > > > > > > >
> > > > > > > > > > > I don't see a reference to any description of that in=
 section 4.1.
> > > > > > > > > > > It's possible I've overlooked this, and if people thi=
nk this style of
> > > > > > > > > > > definition is good enough that works for me. But I fo=
und table 4
> > > > > > > > > > > pretty scanty on what exactly happens.
> > > > > > > > > >
> > > > > > > > > > Hello! Based on Watson's post, I have done some researc=
h and would
> > > > > > > > > > potentially like to offer a path forward. There are sev=
eral different
> > > > > > > > > > ways that ISAs specify the semantics of their operation=
s:
> > > > > > > > > >
> > > > > > > > > > 1. Intel has a section in their manual that describes t=
he pseudocode
> > > > > > > > > > they use to specify their ISA: Section 3.1.1.9 of The I=
ntel=C2=AE 64 and
> > > > > > > > > > IA-32 Architectures Software Developer=E2=80=99s Manual=
 at
> > > > > > > > > > https://cdrdv2.intel.com/v1/dl/getContent/671199
> > > > > > > > > > 2. ARM has an equivalent for their variety of pseudocod=
e: Chapter J1
> > > > > > > > > > of Arm Architecture Reference Manual for A-profile arch=
itecture at
> > > > > > > > > > https://developer.arm.com/documentation/ddi0487/latest/
> > > > > > > > > > 3. Sail "is a language for describing the instruction-s=
et architecture
> > > > > > > > > > (ISA) semantics of processors."
> > > > > > > > > > (https://www.cl.cam.ac.uk/~pes20/sail/)
> > > > > > > > > >
> > > > > > > > > > Given the commercial nature of (1) and (2), perhaps Sai=
l is a way to
> > > > > > > > > > proceed. If people are interested, I would be happy to =
lead an effort
> > > > > > > > > > to encode the eBPF ISA semantics in Sail (or find someo=
ne who already
> > > > > > > > > > has) and incorporate them in the draft.
> > > > > > > > >
> > > > > > > > > imo Sail is too researchy to have practical use.
> > > > > > > > > Looking at arm64 or x86 Sail description I really don't s=
ee how
> > > > > > > > > it would map to an IETF standard.
> > > > > > > > > It's done in a "sail" language that people need to learn =
first to be
> > > > > > > > > able to read it.
> > > > > > > > > Say we had bpf.sail somewhere on github. What value does =
it bring to
> > > > > > > > > BPF ISA standard? I don't see an immediate benefit to sta=
ndardization.
> > > > > > > > > There could be other use cases, no doubt, but standardiza=
tion is our goal.
> > > > > > > > >
> > > > > > > > > As far as 1 and 2. Intel and Arm use their own pseudocode=
, so they had
> > > > > > > > > to add a paragraph to describe it. We are using C to desc=
ribe BPF ISA
> > > > > > > >
> > > > > > > >
> > > > > > > > I cannot find a reference in the current version that speci=
fies what
> > > > > > > > we are using to describe the operations. I'd like to add th=
at, but
> > > > > > > > want to make sure that I clarify two statements that seem t=
o be at
> > > > > > > > odds.
> > > > > > > >
> > > > > > > > Immediately above you say that we are using "C to describe =
the BPF
> > > > > > > > ISA" and further above you say "This is assembly syntax par=
sed and
> > > > > > > > emitted by GCC, LLVM, gas, Linux Kernel, etc."
> > > > > > > >
> > > > > > > > My own reading is that it is the former, and not the latter=
. But, I
> > > > > > > > want to double check before adding the appropriate statemen=
ts to the
> > > > > > > > Convention section.
> > > > > > >
> > > > > > > It's both. I'm not sure where you see a contradiction.
> > > > > > > It's a normal C syntax and it's emitted by the kernel verifie=
r,
> > > > > > > parsed by clang/gcc assemblers and emitted by compilers.
> > > > > >
> > > > > >
> > > > > > Okay. I apologize. I am sincerely confused. For instance,
> > > > > >
> > > > > > if (u32)dst >=3D (u32)src goto +offset
> > > > > >
> > > > > > Looks like nothing that I have ever seen in "normal C syntax".
> > > > >
> > > > > I thought we're talking about table 4 and ALU ops.
> > > > > Above is not a pure C, but it's obvious enough without explanatio=
n, no?
> > > >
> > > > To "us", yes. Although I am not an expert, it seems like being
> > > > explicit is important when it comes to writing a spec. I suppose we
> > > > should leave that to Dave and the chairs.
> > > >
> > > > > Also I don't see above anywhere in the doc.
> > > >
> > > > That is from the Appendix. It is currently in Dave's tree and gets
> > > > amalgamated with other files to build the final draft.
> > > >
> > > > https://datatracker.ietf.org/doc/draft-thaler-bpf-isa/
> > >
> > > This is a mirror and it's already outdated.
> > > You should look at the source. Which is git kernel tree.
> >
> > As he discussed at the meeting, he has the github workflow that
> > produces a version of the draft RFC that he will submit to the WG:
> >
> > https://github.com/ietf-wg-bpf/ebpf-docs/blob/update/.github/workflows/=
build.yml
> >
> > That uses
> >
> > https://github.com/ietf-wg-bpf/ebpf-docs/blob/main/rst/instruction-set-=
skeleton.rst
>
> correct.
>
> > to build in the acknowledgements and subsequently brings in that
> > Appendix.
>
> correct.
>
> > If he plans to take that out, then that's great. I was just
> > trying to help. Sorry.
>
> No. That workflow will stay.
> The future changes to RFC will be in the form of patches to
> instruction-set-skeleton.rst. Once they land the RFC will be
> regenerated.
> We can regenerate RFC as often as we like.
>
> All I'm saying is that RFC has bugs that were already fixed in
> instruction-set-skeleton.rst. Hence it's outdated.

The Appendix (the opcode table) is not in the kernel repo now and
still has the issues that I outlined above. Will that make it in to
the kernel?

https://github.com/ietf-wg-bpf/ebpf-docs/blob/main/rst/instruction-set-opco=
des.rst

Will

