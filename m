Return-Path: <bpf+bounces-6302-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BB5767A77
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 03:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5D1F282828
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 01:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6567800;
	Sat, 29 Jul 2023 01:08:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FD17C
	for <bpf@vger.kernel.org>; Sat, 29 Jul 2023 01:08:03 +0000 (UTC)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346A735A5
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 18:08:00 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-76c93abeb83so63997585a.0
        for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 18:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=obs-cr.20221208.gappssmtp.com; s=20221208; t=1690592879; x=1691197679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLJ80DF+5jN7vyuJ41+PNgOv/ijdA7DAi2QLpD5CcgQ=;
        b=BSCip9A/qBxMvH8qCng/C2WpZhu0tPayV3Ck82DRbmtYR7ckj9XTw6m3EBsaQ6ZjAW
         eb1hW50dAlGh4zwCSoqqBJT1ccYRuYUAVTMY96Hbg6i9NWHClR9FMlO+OC5FcXP4BziQ
         NsYcnWctecTG574Ef7HR+/jWLzZ5jvALlJqlBHNZPpVRYhgoLLx6P4pj+QfIXn1UjOE2
         YYGbPA5yMS0lVrm6m85f1eBmOnXDAaexPVzlLJRGi0BczhOqD2fHyexWwVfzq/Ve0HbY
         KP5o+HxnFAX5LXRW07eyhezmvjG2B9rclTT8HeZ1HA/3p2AoDdGSlLfaQO43kEKEZ52J
         fi/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690592879; x=1691197679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wLJ80DF+5jN7vyuJ41+PNgOv/ijdA7DAi2QLpD5CcgQ=;
        b=aqPYVUEsVQa6NZFsULNGn92rFXJSBEg30asq5OPGV519UabQ8QM8+BaJYtR5lTvNiH
         a/fjE6Qy+QQbOJxhAIf6ddRS733Yy8/zTms43uX9ODKKUQ3IChitUl/54JwEfKGJAgkL
         4BdRYpp45DH6ydSPpxSZ6RnSptFlNaN9SnmG6lR0Bp2ptZ1Stc/Eq1iRbHFgnYEVX+9x
         lwLd/KCZf4+hfhJPjrRfqCqld9ZtkxyqCgmNcEsET7jkXOnBtX23V4VAkqChJerXEMDO
         sy3FqgVjyDij1oAyNOhOjP3jVjbHZl6fhFdNlxWceydXEx44CIF08gtEvGpiaE9AgAt1
         BZIw==
X-Gm-Message-State: ABy/qLa8lEdDTCjaeuxwjbMtQjSAQPiYZimJwoe/TPH0iiGDhNrnG12l
	D2AcZVhGWeixSxC7J3BLRG7IxTaxYR7S5y2OwQGxYQ==
X-Google-Smtp-Source: APBJJlFB1Gw9S2W67wARAM9xDb6dhkFdfA6aZDreh0TIBeBwvI+SUoNo6LQKIeAMEl7f8WHqfJJiRoHDiPjVVgQGyBY=
X-Received: by 2002:a05:620a:d82:b0:75b:23a0:d9dc with SMTP id
 q2-20020a05620a0d8200b0075b23a0d9dcmr4249743qkl.50.1690592879338; Fri, 28 Jul
 2023 18:07:59 -0700 (PDT)
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
 <CADx9qWjYChRf2qBr=Pt5D-RLCb665YFKmjDYX8WOQfqMx1-bag@mail.gmail.com> <CAADnVQJDO9MgU2MQQ5NQAE3EwL6PuPp8aAxcV3apf0DHoq8TAw@mail.gmail.com>
In-Reply-To: <CAADnVQJDO9MgU2MQQ5NQAE3EwL6PuPp8aAxcV3apf0DHoq8TAw@mail.gmail.com>
From: Will Hawkins <hawkinsw@obs.cr>
Date: Fri, 28 Jul 2023 21:07:48 -0400
Message-ID: <CADx9qWjOP4-2K3uKBTRmS4Q5V0gTJtoH65fwN-MhZvn6ukFpBg@mail.gmail.com>
Subject: Re: [Bpf] Review of draft-thaler-bpf-isa-01
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Watson Ladd <watsonbladd@gmail.com>, Dave Thaler <dthaler@microsoft.com>, 
	"bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 28, 2023 at 8:52=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Jul 28, 2023 at 5:46=E2=80=AFPM Will Hawkins <hawkinsw@obs.cr> wr=
ote:
> >
> > On Fri, Jul 28, 2023 at 8:35=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Fri, Jul 28, 2023 at 5:19=E2=80=AFPM Will Hawkins <hawkinsw@obs.cr=
> wrote:
> > > >
> > > > On Fri, Jul 28, 2023 at 8:05=E2=80=AFPM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Fri, Jul 28, 2023 at 4:32=E2=80=AFPM Will Hawkins <hawkinsw@ob=
s.cr> wrote:
> > > > > >
> > > > > > On Thu, Jul 27, 2023 at 9:05=E2=80=AFPM Alexei Starovoitov
> > > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > > >
> > > > > > > On Wed, Jul 26, 2023 at 12:16=E2=80=AFPM Will Hawkins <hawkin=
sw@obs.cr> wrote:
> > > > > > > >
> > > > > > > > On Tue, Jul 25, 2023 at 2:37=E2=80=AFPM Watson Ladd <watson=
bladd@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > On Tue, Jul 25, 2023 at 9:15=E2=80=AFAM Alexei Starovoito=
v
> > > > > > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Tue, Jul 25, 2023 at 7:03=E2=80=AFAM Dave Thaler <dt=
haler@microsoft.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > I am forwarding the email below (after converting HTM=
L to plain text)
> > > > > > > > > > > to the mailto:bpf@vger.kernel.org list so replies can=
 go to both lists.
> > > > > > > > > > >
> > > > > > > > > > > Please use this one for any replies.
> > > > > > > > > > >
> > > > > > > > > > > Thanks,
> > > > > > > > > > > Dave
> > > > > > > > > > >
> > > > > > > > > > > > From: Bpf <bpf-bounces@ietf.org> On Behalf Of Watso=
n Ladd
> > > > > > > > > > > > Sent: Monday, July 24, 2023 10:05 PM
> > > > > > > > > > > > To: bpf@ietf.org
> > > > > > > > > > > > Subject: [Bpf] Review of draft-thaler-bpf-isa-01
> > > > > > > > > > > >
> > > > > > > > > > > > Dear BPF wg,
> > > > > > > > > > > >
> > > > > > > > > > > > I took a look at the draft and think it has some is=
sues, unsurprisingly at this stage. One is
> > > > > > > > > > > > the specification seems to use an underspecified C =
pseudo code for operations vs
> > > > > > > > > > > > defining them mathematically.
> > > > > > > > > >
> > > > > > > > > > Hi Watson,
> > > > > > > > > >
> > > > > > > > > > This is not "underspecified C" pseudo code.
> > > > > > > > > > This is assembly syntax parsed and emitted by GCC, LLVM=
, gas, Linux Kernel, etc.
> > > > > > > > >
> > > > > > > > > I don't see a reference to any description of that in sec=
tion 4.1.
> > > > > > > > > It's possible I've overlooked this, and if people think t=
his style of
> > > > > > > > > definition is good enough that works for me. But I found =
table 4
> > > > > > > > > pretty scanty on what exactly happens.
> > > > > > > >
> > > > > > > > Hello! Based on Watson's post, I have done some research an=
d would
> > > > > > > > potentially like to offer a path forward. There are several=
 different
> > > > > > > > ways that ISAs specify the semantics of their operations:
> > > > > > > >
> > > > > > > > 1. Intel has a section in their manual that describes the p=
seudocode
> > > > > > > > they use to specify their ISA: Section 3.1.1.9 of The Intel=
=C2=AE 64 and
> > > > > > > > IA-32 Architectures Software Developer=E2=80=99s Manual at
> > > > > > > > https://cdrdv2.intel.com/v1/dl/getContent/671199
> > > > > > > > 2. ARM has an equivalent for their variety of pseudocode: C=
hapter J1
> > > > > > > > of Arm Architecture Reference Manual for A-profile architec=
ture at
> > > > > > > > https://developer.arm.com/documentation/ddi0487/latest/
> > > > > > > > 3. Sail "is a language for describing the instruction-set a=
rchitecture
> > > > > > > > (ISA) semantics of processors."
> > > > > > > > (https://www.cl.cam.ac.uk/~pes20/sail/)
> > > > > > > >
> > > > > > > > Given the commercial nature of (1) and (2), perhaps Sail is=
 a way to
> > > > > > > > proceed. If people are interested, I would be happy to lead=
 an effort
> > > > > > > > to encode the eBPF ISA semantics in Sail (or find someone w=
ho already
> > > > > > > > has) and incorporate them in the draft.
> > > > > > >
> > > > > > > imo Sail is too researchy to have practical use.
> > > > > > > Looking at arm64 or x86 Sail description I really don't see h=
ow
> > > > > > > it would map to an IETF standard.
> > > > > > > It's done in a "sail" language that people need to learn firs=
t to be
> > > > > > > able to read it.
> > > > > > > Say we had bpf.sail somewhere on github. What value does it b=
ring to
> > > > > > > BPF ISA standard? I don't see an immediate benefit to standar=
dization.
> > > > > > > There could be other use cases, no doubt, but standardization=
 is our goal.
> > > > > > >
> > > > > > > As far as 1 and 2. Intel and Arm use their own pseudocode, so=
 they had
> > > > > > > to add a paragraph to describe it. We are using C to describe=
 BPF ISA
> > > > > >
> > > > > >
> > > > > > I cannot find a reference in the current version that specifies=
 what
> > > > > > we are using to describe the operations. I'd like to add that, =
but
> > > > > > want to make sure that I clarify two statements that seem to be=
 at
> > > > > > odds.
> > > > > >
> > > > > > Immediately above you say that we are using "C to describe the =
BPF
> > > > > > ISA" and further above you say "This is assembly syntax parsed =
and
> > > > > > emitted by GCC, LLVM, gas, Linux Kernel, etc."
> > > > > >
> > > > > > My own reading is that it is the former, and not the latter. Bu=
t, I
> > > > > > want to double check before adding the appropriate statements t=
o the
> > > > > > Convention section.
> > > > >
> > > > > It's both. I'm not sure where you see a contradiction.
> > > > > It's a normal C syntax and it's emitted by the kernel verifier,
> > > > > parsed by clang/gcc assemblers and emitted by compilers.
> > > >
> > > >
> > > > Okay. I apologize. I am sincerely confused. For instance,
> > > >
> > > > if (u32)dst >=3D (u32)src goto +offset
> > > >
> > > > Looks like nothing that I have ever seen in "normal C syntax".
> > >
> > > I thought we're talking about table 4 and ALU ops.
> > > Above is not a pure C, but it's obvious enough without explanation, n=
o?
> >
> > To "us", yes. Although I am not an expert, it seems like being
> > explicit is important when it comes to writing a spec. I suppose we
> > should leave that to Dave and the chairs.
> >
> > > Also I don't see above anywhere in the doc.
> >
> > That is from the Appendix. It is currently in Dave's tree and gets
> > amalgamated with other files to build the final draft.
> >
> > https://datatracker.ietf.org/doc/draft-thaler-bpf-isa/
>
> This is a mirror and it's already outdated.
> You should look at the source. Which is git kernel tree.

As he discussed at the meeting, he has the github workflow that
produces a version of the draft RFC that he will submit to the WG:

https://github.com/ietf-wg-bpf/ebpf-docs/blob/update/.github/workflows/buil=
d.yml

That uses

https://github.com/ietf-wg-bpf/ebpf-docs/blob/main/rst/instruction-set-skel=
eton.rst

to build in the acknowledgements and subsequently brings in that
Appendix. If he plans to take that out, then that's great. I was just
trying to help. Sorry.

Will

