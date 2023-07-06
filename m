Return-Path: <bpf+bounces-4350-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB9B74A777
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 01:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 235BD2814B5
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 23:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3FA16434;
	Thu,  6 Jul 2023 23:14:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A9C63BA
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 23:14:20 +0000 (UTC)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953FE19BD
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 16:14:17 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b6f97c7115so18726491fa.2
        for <bpf@vger.kernel.org>; Thu, 06 Jul 2023 16:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688685256; x=1691277256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VxB9JuP2WVlEJH2kCW8mIXA6VO88USDyMaG1Y1/Q4t0=;
        b=ZTtCgYCNyojtR5MN7KzcFTTTRUw1P/qNmoRXNugD+XCeL1WTgCoaTrZ0R1X3CiTumy
         EXt2OpQIVARrMkkxVYicQO2ulKiRrXdJoyM4eYLjL+3+ZhS/TJij8EA8NCY2NS/5Y7+Q
         tc7yYF2F1hT+58gEt0EW5ZGe+R18tf+7qbD0MXkQ6AO4d6lK1I4o61sA8wLt7uEhOSa5
         oU3aHhUSHnYea5Nz5TV0HS0Wnd1TGhjSqaPOXb5ZrLU2+okyuC50JXHxhgg5FORuDJzl
         9bKbFdRSOeSmcqyh7dhc9SlBjr6SEhOanGpWRs4J+AO7dViO4UVh83tsyXx8ZiCB/DgZ
         rmTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688685256; x=1691277256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VxB9JuP2WVlEJH2kCW8mIXA6VO88USDyMaG1Y1/Q4t0=;
        b=PvA1HPQ1VrMyFMrSRlOoArYV3jCSi00KRQVGAQ2J7qcxsST3PSAaxjpsjA6Yws2Qcn
         0g8KnK8lNAFYLsELs7BJdhaepGr6BTEoe5Mc5qXtj6z2+xLbrI/eFlNlRfFnme2qjGF0
         cHkrEgGjnbZNZIrle9IcVJ1TqKqbT+qr4VWlAF7Kjm6/AkGn4R/OUl64ep0pw4iw8vHl
         SWk7ogcWCDte/XYO8uNpACOB1ap2LGYJBZLwmKOINdMdIeIeKAL3uS9BQ719PoMMIJU6
         BRWEoTJY6l4pu3KVb1XnsbZaX0kE8aK549mZMreHheXBq438/Z7oZDl1ymYy3xjRBLPK
         Y/aQ==
X-Gm-Message-State: ABy/qLZwO2Vgn7Daf26sO6EjyJ+fUaws2y9wOj9yq3GgZIwAg9CC+vHY
	NfbGI4grFmRy1pS/2RZEG+VMShg6cMw/ixUIrRTrKPmJJJ4=
X-Google-Smtp-Source: APBJJlHfcS/fXyytdaBG/ynEG/P+T19cxdqgrZHur5B4fd47ojEFQUBcT126qdjL0lxRPTW+R9bgTgILOb5ktXJV9gU=
X-Received: by 2002:a2e:9104:0:b0:2b6:cdfb:d06a with SMTP id
 m4-20020a2e9104000000b002b6cdfbd06amr2426704ljg.22.1688685255508; Thu, 06 Jul
 2023 16:14:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230706160537.1309-1-dthaler1968@googlemail.com>
 <20230706204159.7tzacql7wdk3yszc@macbook-pro-8.dhcp.thefacebook.com> <PH7PR21MB3878EA22602A94F1C308CF33A32CA@PH7PR21MB3878.namprd21.prod.outlook.com>
In-Reply-To: <PH7PR21MB3878EA22602A94F1C308CF33A32CA@PH7PR21MB3878.namprd21.prod.outlook.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 6 Jul 2023 16:14:04 -0700
Message-ID: <CAADnVQ+gLnsOVj9s4zpAP6+U6nFHYm6GVZ1FteRac=ZaJvpfDg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf, docs: Improve English readability
To: Dave Thaler <dthaler@microsoft.com>, "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: Dave Thaler <dthaler1968@googlemail.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"bpf@ietf.org" <bpf@ietf.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 6, 2023 at 3:04=E2=80=AFPM Dave Thaler <dthaler@microsoft.com> =
wrote:
>
> > -----Original Message-----
> > From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> > Sent: Thursday, July 6, 2023 1:42 PM
> > To: Dave Thaler <dthaler1968@googlemail.com>
> > Cc: bpf@vger.kernel.org; bpf@ietf.org; Dave Thaler
> > <dthaler@microsoft.com>
> > Subject: Re: [PATCH bpf-next v2] bpf, docs: Improve English readability
> >
> > On Thu, Jul 06, 2023 at 04:05:37PM +0000, Dave Thaler wrote:
> > > From: Dave Thaler <dthaler@microsoft.com>
> > >
> > > Signed-off-by: Dave Thaler <dthaler@microsoft.com>
> > > --
> > > V1 -> V2: addressed comments from Alexei
> > > ---
> > >  Documentation/bpf/instruction-set.rst | 59 ++++++++++++++++++++-----=
--
> > >  Documentation/bpf/linux-notes.rst     |  5 +++
> > >  2 files changed, 50 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/Documentation/bpf/instruction-set.rst
> > > b/Documentation/bpf/instruction-set.rst
> > > index 751e657973f..740989f4c1e 100644
> > > --- a/Documentation/bpf/instruction-set.rst
> > > +++ b/Documentation/bpf/instruction-set.rst
> > > @@ -7,6 +7,9 @@ eBPF Instruction Set Specification, v1.0
> > >
> > >  This document specifies version 1.0 of the eBPF instruction set.
> > >
> > > +The eBPF instruction set consists of eleven 64 bit registers, a
> > > +program counter, and an implementation-specific amount (e.g., 512 by=
tes)
> > of stack space.
> > > +
> > >  Documentation conventions
> > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > >
> > > @@ -27,12 +30,24 @@ The eBPF calling convention is defined as:
> > >  * R6 - R9: callee saved registers that function calls will preserve
> > >  * R10: read-only frame pointer to access stack
> > >
> > > -R0 - R5 are scratch registers and eBPF programs needs to spill/fill
> > > them if -necessary across calls.
> > > +Registers R0 - R5 are caller-saved registers, meaning the BPF progra=
m
> > > +needs to either spill them to the BPF stack or move them to callee
> > > +saved registers if these arguments are to be reused across multiple
> > > +function calls. Spilling means that the value in the register is
> > > +moved to the BPF stack. The reverse operation of moving the variable
> > from the BPF stack to the register is called filling.
> > > +The reason for spilling/filling is due to the limited number of regi=
sters.
> >
> > imo this extended explanation goes too far.
> > It's also not entirely correct. We could have an ISA with limited numbe=
r of
> > registers where every register is callee saved. A bit absurd, but possi=
ble.
> > Or went with SPARC style register windows.
>
> At https://lore.kernel.org/bpf/20220930221624.mqjrzmdxc6etkadm@macbook-pr=
o-4.dhcp.thefacebook.com/ you said about the above
> "I like above clarification though."

That was on "30 Sep 2022".
I like to change my mind often enough to confuse everyone :)

> I think it's important for interoperability to define which registers are=
 caller-saved
> and which are not, so a compiler (or even verifier) can be used for multi=
ple runtimes.

but it really doesn't belong in the ISA doc.
We've discussed it at length.
We need the psABI doc.
ISA doc is a description of instructions and _not_ how they shape
into functions and programs.
More below.

>
> > > +
> > > +Upon entering execution of an eBPF program, registers R1 - R5
> > > +initially can contain the input arguments for the program (similar t=
o the
> > argc/argv pair for a typical C program).
> >
> > argc/argv is only for main(). We don't have main() concept in BPF ISA.
> > argc/argv is also not a property of ISA.
>
> That's why it's "similar to".  I think the analogy helps understanding fo=
r new readers.

argc is a K&R C thing. Not even a calling convention.
That sentence is a combination of analogies from different areas.
argc could be interpreted that the first argument is a count
and a second argument is an array.
See the confusion it might cause?

>
> > > +The actual number of registers used, and their meaning, is defined b=
y
> > > +the program type; for example, a networking program might have an
> > > +argument that includes network packet data and/or metadata.
> >
> > that makes things even more confusing.
> >
> > tbh none of the above changes make the doc easier to read.
>
> The program type defines the number and meaning of any arguments passed
> to the program.  In the ISA that means the number of registered used to
> pass inputs, and their contents.

Not at all. ISA is an instruction set only and this doc is for ISA.
What different program types should accept belongs in a different doc.
And it's not a psABI doc.
More below.

>
> > >  Instruction encoding
> > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > +An eBPF program is a sequence of instructions.
> >
> > Kinda true, but it opens the door for plenty of bike shedding.
> > Is it contiguous sequence? what about subprograms?
> > Is BPF program a one function or multiple functions?
>
> The term "subprogram" is not currently part of the
> instruction-set.rst doc.   "Program-local functions"
> are, and the text says they're part of the same BPF program.
> Hence the doc already says a BPF program can have multiple
> functions.

Yes. It's a mess, but we must not make it worse.
instruction-set.rst is for instructions.
Definition of BPF program belongs to a different doc.

> > etc.
> > Just not worth it.
> > This is ISA doc.
> >
> > > +
> > >  eBPF has two instruction encodings:
> > >
> > >  * the basic instruction encoding, which uses 64 bits to encode an
> > > instruction @@ -74,7 +89,7 @@ For example::
> > >    07     1       0        00 00  11 22 33 44  r1 +=3D 0x11223344 // =
big
> > >
> > >  Note that most instructions do not use all of the fields.
> > > -Unused fields shall be cleared to zero.
> > > +Unused fields must be set to zero.
> >
> > How is this better?
>
> It uses the language common in RFCs.
>
> > >  As discussed below in `64-bit immediate instructions`_, a 64-bit
> > > immediate  instruction uses a 64-bit immediate value that is construc=
ted as
> > follows.
> > > @@ -103,7 +118,9 @@ instruction are reserved and shall be cleared to
> > zero.
> > >  Instruction classes
> > >  -------------------
> > >
> > > -The three LSB bits of the 'opcode' field store the instruction class=
:
> > > +The encoding of the 'opcode' field varies and can be determined from
> > > +the three least significant bits (LSB) of the 'opcode' field which
> > > +holds the "instruction class", as follows:
> >
> > same question. Don't see an improvement in wording.
>
> 1. The acronym LSB was not defined and does not have an asterisk by it in
> the https://www.rfc-editor.org/materials/abbrev.expansion.txt list.
>
> 2. "LSB bits" is redundant.
>
> 3. Putting "instruction class" in quotes is common when defining by use
> the first time.

ok. fair enough.

>
> linux-notes.rst is not in the ISA doc.   The ISA doc says the value is im=
plementation
> defined.  linux-notes.rst says what Linux does for things the ISA doc lea=
ves up
> to the implementation.

I see no value in "Linux currently supports 512 bytes of stack space" sente=
nce.
It's too ambiguous to be useful.

instruction-set.rst is a description of ISA. We should remove things
from it that don't belong instead of doubling down on the current mess.

we need the psABI doc that will not be standardized as Jose recommended.
That doc will describe recommended calling convention, argument
promotion, stack usage, relocation, function/subprogram definition, etc
psABI probably should include BTF.ext description, but I'm open to alternat=
ives.

BPF program types supported by the kernel is a 3rd document.
There we can explain that XDP prog takes a single ctx argument and it's
a pointer to ...
Such info is linux specific. Based on ISA and psABI one can come up
with different program/map types and semantics of their arguments
while being fully compliant with ISA and psABI docs.
Such doc can start its journey in linux-notes.rst and then split, if necess=
ary.

