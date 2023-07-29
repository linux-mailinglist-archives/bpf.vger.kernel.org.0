Return-Path: <bpf+bounces-6304-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0562F767B86
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 04:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 336EE1C21950
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 02:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B491C65D;
	Sat, 29 Jul 2023 02:32:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B56198
	for <bpf@vger.kernel.org>; Sat, 29 Jul 2023 02:32:17 +0000 (UTC)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0570046B3
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 19:32:13 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fe04882c66so4703737e87.3
        for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 19:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690597931; x=1691202731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rAGoyjZZQXgD4RaI24L+ENGc18HhRgrS3EKHUcupmOY=;
        b=b2R8xH0UsgfSmpXCR0LisYwkN44xnlQgBH6YYj7RrB+zoyzmfeqv/CtGROYIN5nH7p
         KuvSmzUJBjjeyTGLVES308CqcT2trV6XrJd9vEBjCpR1qHd224BYKWS7nX10KlUbrIZh
         cDSlzCjDOlUDq4YRMUN2ETDqOg+4wrfJcsnf0s4mUnzD3S3sjuXyLtZYMsGIIS6JH1ZU
         TTdMxV6iEsC1J9oUg6P2rQooZ/+oF4ze2SWB7Tny5nI3p2Q2khwMzsTX1DWLzqaqImRX
         RqNk5qLKOy5N5qnGEXKqNq0LRwngfsI2sa+ah9lFYSGsTl7vUzWlsz9dklzPnfAflYk9
         w7bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690597931; x=1691202731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rAGoyjZZQXgD4RaI24L+ENGc18HhRgrS3EKHUcupmOY=;
        b=RW9HvMQ7fREo5hRNwYxblHijJq0veSWd9OKoUCbZxFqZ8dYLdAHRo10J9rdeaV5PEM
         3SqAfRg3045uV/B/qKpK5+un2uYdKnG+Hvs20ulbhnX1YR1q8AwL3AzVJ7o3YQ0lNroj
         HbBuX2Bi7UY1E7eW182qFvTwQTElxTxOpErzFhKEW3XuFjrFG/9ivMI3qcEeH87t92Li
         riu8KngDd2Uhcio6vXNuahe/v1TGebTTjZFWLgTtAcvOUHCxCMKpxuhWtFGt5gtD5+/6
         q/grbLVgfavrnJNUTCG4q2UX5mvO2jpwNs3AbbO/ZrXx5QmW1EBiG+I846+pivb66fXq
         a1+g==
X-Gm-Message-State: ABy/qLacQA+vpd2YJLkkUE0jnu449gt8jjiY6NkMEIfJINBDLqPD+Szp
	0vrQfmqpqcOxMvCf2L0pKQ+56k3lMRd1y9qlYPQ=
X-Google-Smtp-Source: APBJJlGbakjhlMHw0rA1XkUC3Q4C5K/aUrL7svCSadVImsvyJrnFJMUipEi66l0hrf5m7VLlvmjHLEGWK4q0OqInGwg=
X-Received: by 2002:a05:6512:465:b0:4fb:9129:705b with SMTP id
 x5-20020a056512046500b004fb9129705bmr2611341lfd.6.1690597930830; Fri, 28 Jul
 2023 19:32:10 -0700 (PDT)
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
 <CAADnVQJDO9MgU2MQQ5NQAE3EwL6PuPp8aAxcV3apf0DHoq8TAw@mail.gmail.com> <CADx9qWjOP4-2K3uKBTRmS4Q5V0gTJtoH65fwN-MhZvn6ukFpBg@mail.gmail.com>
In-Reply-To: <CADx9qWjOP4-2K3uKBTRmS4Q5V0gTJtoH65fwN-MhZvn6ukFpBg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 28 Jul 2023 19:31:59 -0700
Message-ID: <CAADnVQKbpoeMWdnXzYbBaHoDiNsLDbC0JvDUnVGEQbCigjd1Xg@mail.gmail.com>
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

On Fri, Jul 28, 2023 at 6:07=E2=80=AFPM Will Hawkins <hawkinsw@obs.cr> wrot=
e:
>
> On Fri, Jul 28, 2023 at 8:52=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Jul 28, 2023 at 5:46=E2=80=AFPM Will Hawkins <hawkinsw@obs.cr> =
wrote:
> > >
> > > On Fri, Jul 28, 2023 at 8:35=E2=80=AFPM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Fri, Jul 28, 2023 at 5:19=E2=80=AFPM Will Hawkins <hawkinsw@obs.=
cr> wrote:
> > > > >
> > > > > On Fri, Jul 28, 2023 at 8:05=E2=80=AFPM Alexei Starovoitov
> > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > >
> > > > > > On Fri, Jul 28, 2023 at 4:32=E2=80=AFPM Will Hawkins <hawkinsw@=
obs.cr> wrote:
> > > > > > >
> > > > > > > On Thu, Jul 27, 2023 at 9:05=E2=80=AFPM Alexei Starovoitov
> > > > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > > > >
> > > > > > > > On Wed, Jul 26, 2023 at 12:16=E2=80=AFPM Will Hawkins <hawk=
insw@obs.cr> wrote:
> > > > > > > > >
> > > > > > > > > On Tue, Jul 25, 2023 at 2:37=E2=80=AFPM Watson Ladd <wats=
onbladd@gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Tue, Jul 25, 2023 at 9:15=E2=80=AFAM Alexei Starovoi=
tov
> > > > > > > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Tue, Jul 25, 2023 at 7:03=E2=80=AFAM Dave Thaler <=
dthaler@microsoft.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > I am forwarding the email below (after converting H=
TML to plain text)
> > > > > > > > > > > > to the mailto:bpf@vger.kernel.org list so replies c=
an go to both lists.
> > > > > > > > > > > >
> > > > > > > > > > > > Please use this one for any replies.
> > > > > > > > > > > >
> > > > > > > > > > > > Thanks,
> > > > > > > > > > > > Dave
> > > > > > > > > > > >
> > > > > > > > > > > > > From: Bpf <bpf-bounces@ietf.org> On Behalf Of Wat=
son Ladd
> > > > > > > > > > > > > Sent: Monday, July 24, 2023 10:05 PM
> > > > > > > > > > > > > To: bpf@ietf.org
> > > > > > > > > > > > > Subject: [Bpf] Review of draft-thaler-bpf-isa-01
> > > > > > > > > > > > >
> > > > > > > > > > > > > Dear BPF wg,
> > > > > > > > > > > > >
> > > > > > > > > > > > > I took a look at the draft and think it has some =
issues, unsurprisingly at this stage. One is
> > > > > > > > > > > > > the specification seems to use an underspecified =
C pseudo code for operations vs
> > > > > > > > > > > > > defining them mathematically.
> > > > > > > > > > >
> > > > > > > > > > > Hi Watson,
> > > > > > > > > > >
> > > > > > > > > > > This is not "underspecified C" pseudo code.
> > > > > > > > > > > This is assembly syntax parsed and emitted by GCC, LL=
VM, gas, Linux Kernel, etc.
> > > > > > > > > >
> > > > > > > > > > I don't see a reference to any description of that in s=
ection 4.1.
> > > > > > > > > > It's possible I've overlooked this, and if people think=
 this style of
> > > > > > > > > > definition is good enough that works for me. But I foun=
d table 4
> > > > > > > > > > pretty scanty on what exactly happens.
> > > > > > > > >
> > > > > > > > > Hello! Based on Watson's post, I have done some research =
and would
> > > > > > > > > potentially like to offer a path forward. There are sever=
al different
> > > > > > > > > ways that ISAs specify the semantics of their operations:
> > > > > > > > >
> > > > > > > > > 1. Intel has a section in their manual that describes the=
 pseudocode
> > > > > > > > > they use to specify their ISA: Section 3.1.1.9 of The Int=
el=C2=AE 64 and
> > > > > > > > > IA-32 Architectures Software Developer=E2=80=99s Manual a=
t
> > > > > > > > > https://cdrdv2.intel.com/v1/dl/getContent/671199
> > > > > > > > > 2. ARM has an equivalent for their variety of pseudocode:=
 Chapter J1
> > > > > > > > > of Arm Architecture Reference Manual for A-profile archit=
ecture at
> > > > > > > > > https://developer.arm.com/documentation/ddi0487/latest/
> > > > > > > > > 3. Sail "is a language for describing the instruction-set=
 architecture
> > > > > > > > > (ISA) semantics of processors."
> > > > > > > > > (https://www.cl.cam.ac.uk/~pes20/sail/)
> > > > > > > > >
> > > > > > > > > Given the commercial nature of (1) and (2), perhaps Sail =
is a way to
> > > > > > > > > proceed. If people are interested, I would be happy to le=
ad an effort
> > > > > > > > > to encode the eBPF ISA semantics in Sail (or find someone=
 who already
> > > > > > > > > has) and incorporate them in the draft.
> > > > > > > >
> > > > > > > > imo Sail is too researchy to have practical use.
> > > > > > > > Looking at arm64 or x86 Sail description I really don't see=
 how
> > > > > > > > it would map to an IETF standard.
> > > > > > > > It's done in a "sail" language that people need to learn fi=
rst to be
> > > > > > > > able to read it.
> > > > > > > > Say we had bpf.sail somewhere on github. What value does it=
 bring to
> > > > > > > > BPF ISA standard? I don't see an immediate benefit to stand=
ardization.
> > > > > > > > There could be other use cases, no doubt, but standardizati=
on is our goal.
> > > > > > > >
> > > > > > > > As far as 1 and 2. Intel and Arm use their own pseudocode, =
so they had
> > > > > > > > to add a paragraph to describe it. We are using C to descri=
be BPF ISA
> > > > > > >
> > > > > > >
> > > > > > > I cannot find a reference in the current version that specifi=
es what
> > > > > > > we are using to describe the operations. I'd like to add that=
, but
> > > > > > > want to make sure that I clarify two statements that seem to =
be at
> > > > > > > odds.
> > > > > > >
> > > > > > > Immediately above you say that we are using "C to describe th=
e BPF
> > > > > > > ISA" and further above you say "This is assembly syntax parse=
d and
> > > > > > > emitted by GCC, LLVM, gas, Linux Kernel, etc."
> > > > > > >
> > > > > > > My own reading is that it is the former, and not the latter. =
But, I
> > > > > > > want to double check before adding the appropriate statements=
 to the
> > > > > > > Convention section.
> > > > > >
> > > > > > It's both. I'm not sure where you see a contradiction.
> > > > > > It's a normal C syntax and it's emitted by the kernel verifier,
> > > > > > parsed by clang/gcc assemblers and emitted by compilers.
> > > > >
> > > > >
> > > > > Okay. I apologize. I am sincerely confused. For instance,
> > > > >
> > > > > if (u32)dst >=3D (u32)src goto +offset
> > > > >
> > > > > Looks like nothing that I have ever seen in "normal C syntax".
> > > >
> > > > I thought we're talking about table 4 and ALU ops.
> > > > Above is not a pure C, but it's obvious enough without explanation,=
 no?
> > >
> > > To "us", yes. Although I am not an expert, it seems like being
> > > explicit is important when it comes to writing a spec. I suppose we
> > > should leave that to Dave and the chairs.
> > >
> > > > Also I don't see above anywhere in the doc.
> > >
> > > That is from the Appendix. It is currently in Dave's tree and gets
> > > amalgamated with other files to build the final draft.
> > >
> > > https://datatracker.ietf.org/doc/draft-thaler-bpf-isa/
> >
> > This is a mirror and it's already outdated.
> > You should look at the source. Which is git kernel tree.
>
> As he discussed at the meeting, he has the github workflow that
> produces a version of the draft RFC that he will submit to the WG:
>
> https://github.com/ietf-wg-bpf/ebpf-docs/blob/update/.github/workflows/bu=
ild.yml
>
> That uses
>
> https://github.com/ietf-wg-bpf/ebpf-docs/blob/main/rst/instruction-set-sk=
eleton.rst

correct.

> to build in the acknowledgements and subsequently brings in that
> Appendix.

correct.

> If he plans to take that out, then that's great. I was just
> trying to help. Sorry.

No. That workflow will stay.
The future changes to RFC will be in the form of patches to
instruction-set-skeleton.rst. Once they land the RFC will be
regenerated.
We can regenerate RFC as often as we like.

All I'm saying is that RFC has bugs that were already fixed in
instruction-set-skeleton.rst. Hence it's outdated.

