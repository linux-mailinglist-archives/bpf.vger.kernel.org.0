Return-Path: <bpf+bounces-6294-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C217679A4
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 02:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A27471C21983
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 00:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6596039B;
	Sat, 29 Jul 2023 00:35:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2077C
	for <bpf@vger.kernel.org>; Sat, 29 Jul 2023 00:35:22 +0000 (UTC)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5E930F9
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 17:35:18 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b93fba1f62so40582291fa.1
        for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 17:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690590917; x=1691195717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2J5OLKk0rp35/fM5esXxHanqOsIxvOdR7Hjz0ZxQrCM=;
        b=bE15akDoUT0teKFoP1IGeCnx2MtUXjgIhzLN0FmxoISz4qkkVswIivSXthBAi9c//A
         CLwKEd49k9633zeuUZQ8weLOpN6o4dz2Set2uX7WXycgpzrW+94UhPDqj0YW+hZM2JnK
         fNv22ZWrS0R/fxGn+FOoefa9FVmMriVO5IR4GaUmrQ5P0hXRkqwE0xAua9fR85MygK5M
         LEaWqzomcHI8u0epofokhPkQOrr/3FlDAw7J0b8pwm03F+aVECaY8Nuw+4J5lMF/I6ay
         hl24dFb4hv6PscURpc86eislKXRPcV6n6PQqCx06jJi/fRJ5TGSnzrQxRZfINWUycBBO
         9meg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690590917; x=1691195717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2J5OLKk0rp35/fM5esXxHanqOsIxvOdR7Hjz0ZxQrCM=;
        b=WRwpc3OddCBVjhV+5F4mAYCN+PH/T686vgdR5G0FzvRqr/SWVQ+nlEv95x5iR7hRUy
         TPoOjtxWHrOHl9/FrJ8YeM3Rm8fXo+O3TL2fmrD9m1CQ/rFDZ8ipZNSrr5ZN69lBmMLQ
         2THqEfeesnCL8CsnBrDrnlFf17yWKfIzqsifv3eHPvOcmyg06n9my8S1GZ7eOyOu9zwf
         qn94Gtmbnx5B/WA14mah4eBfK6ThZyVA2BE0p1bsQdaLLtG2Uv8oewQp+OblnsPMYzTf
         2prB7FeMTeoqS1DZJEHv6wuf+ZsYGFU2rRW1QW9KzA/3R7Rj+Hind7tmkze6yqyRl4LU
         G0GA==
X-Gm-Message-State: ABy/qLb8FfeSUc0zsn29IRDqjqeltHq0SNaL5Lw41unZVgyCN4gRA2b8
	RvyPh3qOIa3fR62FjLzPPPAJ4yqTeH0E1Zfv5lo=
X-Google-Smtp-Source: APBJJlFX+eC0JecotlgRhQKPzJGxNjQ7a6KY6BB3JEguPEtrLw/M7GNDAJi4gqPtY+ECernyWSngzuhD0hg+tEwxKY4=
X-Received: by 2002:a05:651c:c3:b0:2b4:75f0:b9e9 with SMTP id
 3-20020a05651c00c300b002b475f0b9e9mr3047009ljr.10.1690590916713; Fri, 28 Jul
 2023 17:35:16 -0700 (PDT)
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
 <CAADnVQJ4yzDc0qQExLUO1b23ndEiEjnYYPv5qC7JJYmLr4X3ew@mail.gmail.com> <CADx9qWh6ZUKvjkZow6=eB4gvEgP82mBqn+mMZvmDQynCYAfMWw@mail.gmail.com>
In-Reply-To: <CADx9qWh6ZUKvjkZow6=eB4gvEgP82mBqn+mMZvmDQynCYAfMWw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 28 Jul 2023 17:35:05 -0700
Message-ID: <CAADnVQKOiwm1UB58=8QcowDyfPQct-wuMD19citS7w5PmadZ6g@mail.gmail.com>
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

On Fri, Jul 28, 2023 at 5:19=E2=80=AFPM Will Hawkins <hawkinsw@obs.cr> wrot=
e:
>
> On Fri, Jul 28, 2023 at 8:05=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Jul 28, 2023 at 4:32=E2=80=AFPM Will Hawkins <hawkinsw@obs.cr> =
wrote:
> > >
> > > On Thu, Jul 27, 2023 at 9:05=E2=80=AFPM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Wed, Jul 26, 2023 at 12:16=E2=80=AFPM Will Hawkins <hawkinsw@obs=
.cr> wrote:
> > > > >
> > > > > On Tue, Jul 25, 2023 at 2:37=E2=80=AFPM Watson Ladd <watsonbladd@=
gmail.com> wrote:
> > > > > >
> > > > > > On Tue, Jul 25, 2023 at 9:15=E2=80=AFAM Alexei Starovoitov
> > > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > > >
> > > > > > > On Tue, Jul 25, 2023 at 7:03=E2=80=AFAM Dave Thaler <dthaler@=
microsoft.com> wrote:
> > > > > > > >
> > > > > > > > I am forwarding the email below (after converting HTML to p=
lain text)
> > > > > > > > to the mailto:bpf@vger.kernel.org list so replies can go to=
 both lists.
> > > > > > > >
> > > > > > > > Please use this one for any replies.
> > > > > > > >
> > > > > > > > Thanks,
> > > > > > > > Dave
> > > > > > > >
> > > > > > > > > From: Bpf <bpf-bounces@ietf.org> On Behalf Of Watson Ladd
> > > > > > > > > Sent: Monday, July 24, 2023 10:05 PM
> > > > > > > > > To: bpf@ietf.org
> > > > > > > > > Subject: [Bpf] Review of draft-thaler-bpf-isa-01
> > > > > > > > >
> > > > > > > > > Dear BPF wg,
> > > > > > > > >
> > > > > > > > > I took a look at the draft and think it has some issues, =
unsurprisingly at this stage. One is
> > > > > > > > > the specification seems to use an underspecified C pseudo=
 code for operations vs
> > > > > > > > > defining them mathematically.
> > > > > > >
> > > > > > > Hi Watson,
> > > > > > >
> > > > > > > This is not "underspecified C" pseudo code.
> > > > > > > This is assembly syntax parsed and emitted by GCC, LLVM, gas,=
 Linux Kernel, etc.
> > > > > >
> > > > > > I don't see a reference to any description of that in section 4=
.1.
> > > > > > It's possible I've overlooked this, and if people think this st=
yle of
> > > > > > definition is good enough that works for me. But I found table =
4
> > > > > > pretty scanty on what exactly happens.
> > > > >
> > > > > Hello! Based on Watson's post, I have done some research and woul=
d
> > > > > potentially like to offer a path forward. There are several diffe=
rent
> > > > > ways that ISAs specify the semantics of their operations:
> > > > >
> > > > > 1. Intel has a section in their manual that describes the pseudoc=
ode
> > > > > they use to specify their ISA: Section 3.1.1.9 of The Intel=C2=AE=
 64 and
> > > > > IA-32 Architectures Software Developer=E2=80=99s Manual at
> > > > > https://cdrdv2.intel.com/v1/dl/getContent/671199
> > > > > 2. ARM has an equivalent for their variety of pseudocode: Chapter=
 J1
> > > > > of Arm Architecture Reference Manual for A-profile architecture a=
t
> > > > > https://developer.arm.com/documentation/ddi0487/latest/
> > > > > 3. Sail "is a language for describing the instruction-set archite=
cture
> > > > > (ISA) semantics of processors."
> > > > > (https://www.cl.cam.ac.uk/~pes20/sail/)
> > > > >
> > > > > Given the commercial nature of (1) and (2), perhaps Sail is a way=
 to
> > > > > proceed. If people are interested, I would be happy to lead an ef=
fort
> > > > > to encode the eBPF ISA semantics in Sail (or find someone who alr=
eady
> > > > > has) and incorporate them in the draft.
> > > >
> > > > imo Sail is too researchy to have practical use.
> > > > Looking at arm64 or x86 Sail description I really don't see how
> > > > it would map to an IETF standard.
> > > > It's done in a "sail" language that people need to learn first to b=
e
> > > > able to read it.
> > > > Say we had bpf.sail somewhere on github. What value does it bring t=
o
> > > > BPF ISA standard? I don't see an immediate benefit to standardizati=
on.
> > > > There could be other use cases, no doubt, but standardization is ou=
r goal.
> > > >
> > > > As far as 1 and 2. Intel and Arm use their own pseudocode, so they =
had
> > > > to add a paragraph to describe it. We are using C to describe BPF I=
SA
> > >
> > >
> > > I cannot find a reference in the current version that specifies what
> > > we are using to describe the operations. I'd like to add that, but
> > > want to make sure that I clarify two statements that seem to be at
> > > odds.
> > >
> > > Immediately above you say that we are using "C to describe the BPF
> > > ISA" and further above you say "This is assembly syntax parsed and
> > > emitted by GCC, LLVM, gas, Linux Kernel, etc."
> > >
> > > My own reading is that it is the former, and not the latter. But, I
> > > want to double check before adding the appropriate statements to the
> > > Convention section.
> >
> > It's both. I'm not sure where you see a contradiction.
> > It's a normal C syntax and it's emitted by the kernel verifier,
> > parsed by clang/gcc assemblers and emitted by compilers.
>
>
> Okay. I apologize. I am sincerely confused. For instance,
>
> if (u32)dst >=3D (u32)src goto +offset
>
> Looks like nothing that I have ever seen in "normal C syntax".

I thought we're talking about table 4 and ALU ops.
Above is not a pure C, but it's obvious enough without explanation, no?
Also I don't see above anywhere in the doc.
We describe conditionals like:
BPF_JGE   0x3    any  PC +=3D offset if dst >=3D src

> There also appear to be a few other places where things might be a bit wo=
nky:
>
> 1. Address arithmetic in the description of the load/store
> instructions will depend on the type of the target: E.g.,
>
> *(u64 *)(dst + offset) =3D imm
>
> The address to which the store is done will be offset*sizeof(X) bytes
> from dst where X is the type of the target of dst. If we are assuming
> that dst (or its equivalent in similar instructions) is being treated
> simply as an unsigned integer, I believe that we will have to say that
> explicitly, especially given that we describe offset as "signed
> integer offset used with pointer arithmetic" in the Instruction
> encoding section.

It's not:
*((u64 *)(dst) + offset) =3D imm

The doc doesn't say that 'dst' is a pointer 'u64 *dst' type.
Instead it says:
--
The 'code' field encodes the operation as below, where 'src' and 'dst' refe=
r
to the values of the source and destination registers, respectively.
--

so dst + offset is a plain addition of two values and then type cast.

>
> 2. hto[bl]eN functions are not specified by standard C and, while
> "obvious" what they do, are not defined in the document anywhere.

yeah. we can add a short sentence about htoln.

