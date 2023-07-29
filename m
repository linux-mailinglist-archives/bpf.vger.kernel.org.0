Return-Path: <bpf+bounces-6292-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B99B7767966
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 02:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E94DF1C20F40
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 00:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE3737E;
	Sat, 29 Jul 2023 00:19:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B7D17E
	for <bpf@vger.kernel.org>; Sat, 29 Jul 2023 00:19:09 +0000 (UTC)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E383C33
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 17:19:07 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-63d4b5890a0so6068286d6.2
        for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 17:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=obs-cr.20221208.gappssmtp.com; s=20221208; t=1690589946; x=1691194746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wfLv10TFdsrSxqktK+LRaWW5VA/F7ry7098BNaSJwV0=;
        b=MWxFF+s7RWFcm7siS+3A0Tow/rA6WEYvZjlyJDCq/DZsAJ9uGX07G5RkITjsyUUuve
         ocqq9nFgnYi4Hn5AiFWGShoOB3n+0WJmBceGK9U+lDYormH7ofIgeKHDOeq1nCXc3asq
         2EhQCnullSqq3q975LRYJjmFvbVTBCwm54UgFZDLyAZhVwOzSQor4A2ciURR45p69Whg
         mU1qsaAa49I4jgjEgLEw0I0mFW8jgeCXxozhoGh334pLLVoIqIsb3HskmPaKBvcNeMxy
         g5n4abXmElDj9PprfFEGK+T+ujo0vz3IffRbigS7+Fi/kmSrp1ZTEdW+bme+8HcMnJu+
         yJcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690589946; x=1691194746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wfLv10TFdsrSxqktK+LRaWW5VA/F7ry7098BNaSJwV0=;
        b=l7Ar+j+QyM9RXGG6dAmxS08q7ntlGB6OQsHsCTllNQaU+O8kmTypONENFxXZZUATQA
         j0qG1xG+YknLjHERe8aSrQUTZBZfQVPvwqA03juQ0eMhSkJmvKV8ndOhSmrK7ciLbgzB
         JY4pxqVdG9Gdv5EU9QdBLTw30H249kMSSvE6r3hFkeMkACWyZ5XI3mtq+bWezgdph584
         jdwUoyaDMR8bViI22PXntxIU4/9OMXXxdEZoXfjajDt9M1sUjPQZpcMEtHYbbd7P72Vq
         9jZrLz+eU/boG4X7pEc8AErer9TpMfyLzvgDP6LFL3HUX7SkMaMC6DgiOFtqmLnvBwOn
         9cnw==
X-Gm-Message-State: ABy/qLZaBYNsvzCYe9zYfAo42iv3e+VultEXFy384kBQpz3hyA8YFFrm
	0WJeAEprdH/p+OCr8SEegQnYwqvsfBwUPSDhoU3tPw==
X-Google-Smtp-Source: APBJJlEja4qOnluP3YGgEue7c0G5m3ZOjjLi9B/a/FSUyH+u0+cCPKInXYAXJMy7Vim7kvtipq2ZI9oaA8OPYlfEl/g=
X-Received: by 2002:a0c:d692:0:b0:63d:37c1:c063 with SMTP id
 k18-20020a0cd692000000b0063d37c1c063mr3269101qvi.25.1690589946155; Fri, 28
 Jul 2023 17:19:06 -0700 (PDT)
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
 <CADx9qWhSqb6xAP=nz5N-vmd2N3+h4TBFtFOGdJUWNfX=LapEBw@mail.gmail.com> <CAADnVQJ4yzDc0qQExLUO1b23ndEiEjnYYPv5qC7JJYmLr4X3ew@mail.gmail.com>
In-Reply-To: <CAADnVQJ4yzDc0qQExLUO1b23ndEiEjnYYPv5qC7JJYmLr4X3ew@mail.gmail.com>
From: Will Hawkins <hawkinsw@obs.cr>
Date: Fri, 28 Jul 2023 20:18:55 -0400
Message-ID: <CADx9qWh6ZUKvjkZow6=eB4gvEgP82mBqn+mMZvmDQynCYAfMWw@mail.gmail.com>
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

On Fri, Jul 28, 2023 at 8:05=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Jul 28, 2023 at 4:32=E2=80=AFPM Will Hawkins <hawkinsw@obs.cr> wr=
ote:
> >
> > On Thu, Jul 27, 2023 at 9:05=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Wed, Jul 26, 2023 at 12:16=E2=80=AFPM Will Hawkins <hawkinsw@obs.c=
r> wrote:
> > > >
> > > > On Tue, Jul 25, 2023 at 2:37=E2=80=AFPM Watson Ladd <watsonbladd@gm=
ail.com> wrote:
> > > > >
> > > > > On Tue, Jul 25, 2023 at 9:15=E2=80=AFAM Alexei Starovoitov
> > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > >
> > > > > > On Tue, Jul 25, 2023 at 7:03=E2=80=AFAM Dave Thaler <dthaler@mi=
crosoft.com> wrote:
> > > > > > >
> > > > > > > I am forwarding the email below (after converting HTML to pla=
in text)
> > > > > > > to the mailto:bpf@vger.kernel.org list so replies can go to b=
oth lists.
> > > > > > >
> > > > > > > Please use this one for any replies.
> > > > > > >
> > > > > > > Thanks,
> > > > > > > Dave
> > > > > > >
> > > > > > > > From: Bpf <bpf-bounces@ietf.org> On Behalf Of Watson Ladd
> > > > > > > > Sent: Monday, July 24, 2023 10:05 PM
> > > > > > > > To: bpf@ietf.org
> > > > > > > > Subject: [Bpf] Review of draft-thaler-bpf-isa-01
> > > > > > > >
> > > > > > > > Dear BPF wg,
> > > > > > > >
> > > > > > > > I took a look at the draft and think it has some issues, un=
surprisingly at this stage. One is
> > > > > > > > the specification seems to use an underspecified C pseudo c=
ode for operations vs
> > > > > > > > defining them mathematically.
> > > > > >
> > > > > > Hi Watson,
> > > > > >
> > > > > > This is not "underspecified C" pseudo code.
> > > > > > This is assembly syntax parsed and emitted by GCC, LLVM, gas, L=
inux Kernel, etc.
> > > > >
> > > > > I don't see a reference to any description of that in section 4.1=
.
> > > > > It's possible I've overlooked this, and if people think this styl=
e of
> > > > > definition is good enough that works for me. But I found table 4
> > > > > pretty scanty on what exactly happens.
> > > >
> > > > Hello! Based on Watson's post, I have done some research and would
> > > > potentially like to offer a path forward. There are several differe=
nt
> > > > ways that ISAs specify the semantics of their operations:
> > > >
> > > > 1. Intel has a section in their manual that describes the pseudocod=
e
> > > > they use to specify their ISA: Section 3.1.1.9 of The Intel=C2=AE 6=
4 and
> > > > IA-32 Architectures Software Developer=E2=80=99s Manual at
> > > > https://cdrdv2.intel.com/v1/dl/getContent/671199
> > > > 2. ARM has an equivalent for their variety of pseudocode: Chapter J=
1
> > > > of Arm Architecture Reference Manual for A-profile architecture at
> > > > https://developer.arm.com/documentation/ddi0487/latest/
> > > > 3. Sail "is a language for describing the instruction-set architect=
ure
> > > > (ISA) semantics of processors."
> > > > (https://www.cl.cam.ac.uk/~pes20/sail/)
> > > >
> > > > Given the commercial nature of (1) and (2), perhaps Sail is a way t=
o
> > > > proceed. If people are interested, I would be happy to lead an effo=
rt
> > > > to encode the eBPF ISA semantics in Sail (or find someone who alrea=
dy
> > > > has) and incorporate them in the draft.
> > >
> > > imo Sail is too researchy to have practical use.
> > > Looking at arm64 or x86 Sail description I really don't see how
> > > it would map to an IETF standard.
> > > It's done in a "sail" language that people need to learn first to be
> > > able to read it.
> > > Say we had bpf.sail somewhere on github. What value does it bring to
> > > BPF ISA standard? I don't see an immediate benefit to standardization=
.
> > > There could be other use cases, no doubt, but standardization is our =
goal.
> > >
> > > As far as 1 and 2. Intel and Arm use their own pseudocode, so they ha=
d
> > > to add a paragraph to describe it. We are using C to describe BPF ISA
> >
> >
> > I cannot find a reference in the current version that specifies what
> > we are using to describe the operations. I'd like to add that, but
> > want to make sure that I clarify two statements that seem to be at
> > odds.
> >
> > Immediately above you say that we are using "C to describe the BPF
> > ISA" and further above you say "This is assembly syntax parsed and
> > emitted by GCC, LLVM, gas, Linux Kernel, etc."
> >
> > My own reading is that it is the former, and not the latter. But, I
> > want to double check before adding the appropriate statements to the
> > Convention section.
>
> It's both. I'm not sure where you see a contradiction.
> It's a normal C syntax and it's emitted by the kernel verifier,
> parsed by clang/gcc assemblers and emitted by compilers.


Okay. I apologize. I am sincerely confused. For instance,

if (u32)dst >=3D (u32)src goto +offset

Looks like nothing that I have ever seen in "normal C syntax".

There also appear to be a few other places where things might be a bit wonk=
y:

1. Address arithmetic in the description of the load/store
instructions will depend on the type of the target: E.g.,

*(u64 *)(dst + offset) =3D imm

The address to which the store is done will be offset*sizeof(X) bytes
from dst where X is the type of the target of dst. If we are assuming
that dst (or its equivalent in similar instructions) is being treated
simply as an unsigned integer, I believe that we will have to say that
explicitly, especially given that we describe offset as "signed
integer offset used with pointer arithmetic" in the Instruction
encoding section.

2. hto[bl]eN functions are not specified by standard C and, while
"obvious" what they do, are not defined in the document anywhere.

Again, I am really sorry to be causing so much confusion. I hope that
at least some of this discussion is helpful.

Will

