Return-Path: <bpf+bounces-14129-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 895B17E0AC2
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 22:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9B5E1C21084
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 21:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC06A2376D;
	Fri,  3 Nov 2023 21:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=obs-cr.20230601.gappssmtp.com header.i=@obs-cr.20230601.gappssmtp.com header.b="aY8LluSM"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F811D695
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 21:40:24 +0000 (UTC)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB87112
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 14:40:22 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-581de3e691dso1210301eaf.3
        for <bpf@vger.kernel.org>; Fri, 03 Nov 2023 14:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=obs-cr.20230601.gappssmtp.com; s=20230601; t=1699047621; x=1699652421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A61JUT+urqSzjrEktXkjM8CRRHn85dCWBA9P+ra1iTc=;
        b=aY8LluSMV6DEoYLp+8I2f4zAk9ASBKJGwWOBqm7psYh8nNuxJtGCGxLGrxTcAIYS77
         TwCLJrr54BWybus5U52mplH6runR7JXfSKiLnOMYqIcH/+QPaJ9ejKv6gpnb/GAzrOYX
         bM25+nkofW+XN8UJujuT5Gl4xfXKUy6mRwBc6DoiZYTukN8p3jvUKAGzH9KTbvM+ALRg
         tbf6227KYqpr//jYff33L2Uy3EX0bUGhGdX6Hg40OPRsxGitrWLhUCqBj4pAe8smZcLX
         spdvLyRksDlMa0C54oIIDatg/uwr5eut1URgqpxyDTTuo0kHFAbM85hf2uLMVeSLcpJw
         Z1TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699047621; x=1699652421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A61JUT+urqSzjrEktXkjM8CRRHn85dCWBA9P+ra1iTc=;
        b=ADndENRbD4L1uVAuIPTT4Z8p8U/oYyAqnuF4+UYH+6jq7OSN6wEedlSGpTDtjADOmL
         wXdEqrq/EAEmycT+80dMncpY0uzsBVwdsxlTPTHMj+2HSLg6xkBZCZB4B1w73JZ/+v0P
         +MqnMULn5jAQCnkyO13OfNkEoVfLmotjrH6IXfzimdi1apL2sBNmus6NtFgpzPv9jJmu
         q3XHH7DHrlY9XGWOl2xlsWklwW1HK3+tbLeBRC6X6eZDxaZWT7Vt29shE17Oq/MWwvxh
         4la986L0KvNnwdkquoQMLk2KCvYwMUTYYzBTv3TZ4a2Z+vt24kZyEvDJj/giO7tWAo7A
         xTzQ==
X-Gm-Message-State: AOJu0YxDGwPDjg5nzd38tA/nuH9+NzqXnSsf/rqln902+gy4RbcdKvzj
	m7/h8saQq1gfz0gBwPhoVK+7zno8bc1vnUxnBXgKrw==
X-Google-Smtp-Source: AGHT+IF8PpFJgymVCuPjZjM9SYlPcLGhctaRx/XALkEQUKr+Ln+62sEw6pagSKOh1yimf6sx0pX6kFQCgc/TnyJbb3c=
X-Received: by 2002:a25:cb05:0:b0:da0:6933:d8d with SMTP id
 b5-20020a25cb05000000b00da069330d8dmr23146108ybg.63.1699046086722; Fri, 03
 Nov 2023 14:14:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231002142001.3223261-1-hawkinsw@obs.cr> <20231003182650.GA5902@maniforge>
 <CADx9qWjcSoNb=aWpDVV5QxEoUGuDr2=wOOz3AWhjemh6+hzhwA@mail.gmail.com> <20231024005528.GA33696@maniforge>
In-Reply-To: <20231024005528.GA33696@maniforge>
From: Will Hawkins <hawkinsw@obs.cr>
Date: Fri, 3 Nov 2023 17:14:35 -0400
Message-ID: <CADx9qWgqfQdHSVn0RMMz7M2jp5pKP-bnnc7GAfFD4QbP4eFA4w@mail.gmail.com>
Subject: Re: [PATCH] bpf, docs: Add additional ABI working draft base text
To: David Vernet <void@manifault.com>
Cc: bpf@ietf.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 8:55=E2=80=AFPM David Vernet <void@manifault.com> w=
rote:
>
> On Sat, Oct 21, 2023 at 07:13:58PM -0400, Will Hawkins wrote:
>
> [...]
>
> [...]
> > I agree 100%. The "Note:" here was more an author's "note to self"
> > about where we could look for other existing language that we could
> > appropriate to include in this document. I have updated the Note: to
> > be an Author's Note (here and elsewhere) to make that more obvious. I
> > hope that is okay!
>
> Hmm, I think that could get confusing. Can we just add comments anywhere
> that we want to be able to record places for us to use as a reference
> for language later? Ideally anything going into the document should be
> text that we're intending to eventually publish, perhaps with the
> exception of things like XXX: Fill in later.

Thank you for the feedback! I took out all the Author's Note sections
and simply made them rst comments. I agree with your opinion that
comments are the best way to communicate this information to one
another as we work on drafting out all the language.

>
> > > > +Related Work
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > +eBPF programs are not unique for the way that they operate on a vi=
rtualized machine and processor.
> > > > +There are many programming languages that compile to an ISA that i=
s specific to a virtual machine.
> > > > +Like the specification presented herein, those languages and virtu=
al machines also have ABIs.
> > > > +
> > > > +For example, the Go programming language and the runtime included =
statically with each program compiled
> > > > +from Go source code have a defined ABI [GOABI]_. Java programs com=
piled to bytecode follow a well-defined
> > > > +ABI for interoperability with other compiled Java programs and lib=
raries [JAVAABI]_. Programs compiled to
> > > > +bytecode for execution as user applications on the Android operati=
ng system (OS) adhere to a bytecode
> > > > +specification that shares much in common with an ABI [DALVIKABI]_.=
 Finally, the Common Language Runtime (CLR)
> > > > +designed to execute programs compiled to the Microsoft Intermediat=
e Language (MSIL) has a fully specified
> > > > +ABI [CLRABI]_.
> > >
> > > While this section is certainly useful background for the reader, I'm
> > > also not sure it's necessary or appropriate to include. These ABIs ar=
e
> > > independent of this one, and could change at any time. It's probably
> > > best if we avoid referencing external documents that aren't actual
> > > dependencies of this document. Feel free to disagree.
> >
> > You make an excellent point. Although v2 does not make this change, do
> > you think that a reasonable adjustment would be to simply move this
> > section to the end of the document?
>
> My initial expectation is that it's not a great idea to reference
> external documents that could change, no longer be valid links, etc, but
> I'd like to hear what others think. Dave -- is this typical for an IETF
> informational document? It seems like if we did this we'd basically be
> taking implicit dependencies on documents we can't actually control
> (because they're not IETF), but I have no idea if this is normal or not.
>
> > >
> > > > +Vocabulary
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > +
> > > > +#. Program: An eBPF Program is a self-contained set of eBPF instru=
ctions that execute
> > > > +   on an eBPF processor.
> > >
> > > I wonder if we want to be a bit more concrete here. "Self-contained",
> > > for example, is arguably a bit ambiguous in terms of what it means. W=
hat
> > > do you think about this?
> > >
> > > "Program: A BPF Program is an ordered set of BPF instructions, with
> > > exactly one entry instruction where the program begins, and one or mo=
re
> > > BPF_EXIT instructions where program execution can end."
> >
> > This suggestion is fantastic and I have used it verbatim!
> >
> > >
> > > > +#. Program Type: Every eBPF program has an associated type. The pr=
ogram type defines, among other things,
> > > > +   a program's possible attach types.
> > > > +#. Attach Type: An attach type defines the set of BPF hook points =
to which an eBPF
> > > > +   program can attach.
> > > > +#. BPF Hook Points: Places in a BPF-enabled component (e.g., the L=
inux Kernel, the Windows kernel) where
> > > > +   an eBPF program may be attached.
> > >
> > > Hmm, I'm not sure if having this vocabulary section at the beginning =
of
> > > the document is optimal. Consider that the above 3 definitions are qu=
ite
> > > sparse, and essentially do nothing other than reference each other, a=
nd
> > > they're also leaving out a lot of detail that will be explored more
> > > substantively later in the document (or in the framework / architectu=
re
> > > informational document described in [0]).
> > >
> > > [0]: https://datatracker.ietf.org/wg/bpf/about/
> > >
> > > It seems like it might make more sense to follow the approach taken b=
y
> > > the JVM specification [1], SysV ABI [2], and RISC-V psABI [3] (though
> > > they do have a section that defines appreviations and a couple of
> > > terms), and instead just have each chapter explain all of these conce=
pts
> > > in more detail without any kind of introduction. What do you think?
> >
> > I could go either way. Personally, when I read documents, I like
> > having a vocabulary section to give me some bearing. That way, as I
> > read the document, I know where to turn to see whether words with
> > which I am unfamiliar are things that I "should know" (and therefore
> > just Google) or are new terminology from this document. Again, I could
> >
> > absolutely go either way and certainly appreciate your references to
> > other documents that work differently. When I wrote this section I
> > envisioned it like the vocabulary section from the C++ standard where
> > new terms of art are given basic definitions that are later expanded
> > throughout the document.
> >
> > What if we did both -- we could keep the vocabulary section and
> > include pointers to the places later in the specification where the
> > terms are explained in additional detail?
>
> If we did this, then the vocabulary section would become a combination
> of a table of contents, and an index of sorts. I personally find that in
> documents such as the C and C++ standard, that the terms section ends up
> being arbitrarily chosen, and insufficiently defined (see all the Notes
> sections peppered throughout these terms).
>
> I'd again appreciate hearing other folks' thoughts here. I'm inclined to
> say that the document would be better served by having a clear table of
> contents where these terms are specified and defined in one place, but I
> don't have a super strong opinion.
>

At the end of this email I will suggest a list of ABI-related topics
for the upcoming IETF meeting -- I believe that this discussion would
be worthwhile!



> > > [1]: https://docs.oracle.com/javase/specs/jvms/se21/html/index.html
> > > [2]: https://refspecs.linuxfoundation.org/elf/x86_64-abi-0.95.pdf
> > > [3]: https://github.com/riscv-non-isa/riscv-elf-psabi-doc/releases/do=
wnload/draft-20230929-e5c800e661a53efe3c2678d71a306323b60eb13b/riscv-abi.pd=
f
> > >
> > > > +#. eBPF Machine Instantiation:
> > > > +#. ABI-conforming system: A computer system that provides the bina=
ry sys- tem interface for application
> > > > +   programs described in the System V ABI [SYSVABI]_.
> > > > +#. ABI-conforming program: A program written to include only the s=
ystem routines, commands, and other
> > > > +   resources included in the ABI, and a program compiled into an e=
xecutable file that has the formats
> > > > +   and characteristics specified for such files in the ABI, and a =
program whose behavior complies with
> > > > +   the rules given in the ABI [SYSVABI]_.
> > > > +#. ABI-nonconforming program: A program which has been written to =
include system routines, commands, or
> > > > +   other resources not included in the ABI, or a program which has=
 been compiled into a format different
> > > > +   from those specified in the ABI, or a program which does not be=
have as specified in the ABI [SYSVABI]_.
> > > > +#. Undefined Behavior: Behavior that may vary from instance to ins=
tance or may change at some time in the future.
> > > > +   Some undesirable programming practices are marked in the ABI as=
 yielding undefined behavior [SYSVABI]_.
> > > > +#. Unspecified Property: A property of an entity that is not expli=
citly included or referenced in this specification,
> > > > +   and may change at some time in the future. In general, it is no=
t good practice to make a program depend
> > > > +   on an unspecified property [SYSVABI]_.
> > > > +
> > > > +Program Execution Environment
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > > > +
> > > > +A loaded eBPF program is executed on an eBPF machine. That machine=
, physical or virtual, runs in a freestanding
> > > > +or hosted environment [#]_.
> > > > +
> > > > +eBPF Machine Freestanding Environment
> > > > +-------------------------------------
> > > > +
> > > > +
> > > > +eBPF Machine Hosted Environment
> > > > +-------------------------------
> > > > +
> > > > +A loaded eBPF program can be attached to a BPF hook point in a BPF=
-enabled application
> > > > +compatible with the attach type of its program type. When the BPF-=
enabled application's
> > > > +execution reaches a BPF hook point to which an eBPF program is att=
ached, that program
> > > > +begins execution on the eBPF machine at its first instruction. The=
 contents of eBPF machine's
> > > > +registers and memory at the time it starts execution are defined b=
y the eBPF program's
> > > > +type and attach point.
> > > > +
> > > > +Processor Architecture
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > +
> > > > +This section describes the processor architecture available
> > > > +to programs. It also defines the reference language data types, gi=
ving the
> > > > +foundation for system interface specifications [SYSVABI]_
> > >
> > > Why are we linking to the SYSVABI doc here?
> >
> > A great question -- in most places where I have referenced that
> > document it is akin to an academic reference -- I am attempting to
> > give the user the idea that the language used is not my own completely
> > original thought. I am attempting to tell the reader that this concept
> > or language has precedent in another document. I am very new to the
> > standards-writing process and realize that utilization of citations
> > may not be "how it works". Please let me know how to proceed!
>
> I'm not sure how it works either, so folks who have more IETF experience
> -- please weigh in. In similar fashion to above, this feels like we're
> implicitly taking these other documents as dependencies. We certainly
> don't want to plagiarize anything, but tagging a reference here to
> function similar to a citation seems confusing as well.

Adding to IETF the topic list (see below).


>
> > >
> > > > +
> > > > +Registers
> > > > +---------
> > > > +
> > > > +General Purpose Registers
> > > > +^^^^^^^^^^^^^^^^^^^^^^^^^
> > > > +eBPF has 11 64-bit wide registers, `r0` - `r10`. The contents of t=
he registers
> > > > +at the beginning of an eBPF program's execution depend on the prog=
ram's type.
> > >
> > > We should probably also mention the 32 bit subregisters (they can onl=
y
> > > be accessed through special ALU operations), and that they zero-exten=
d
> > > into 64 bit on writes.
> >
> > I added a note on the subregisters. I decided to leave out the
> > information about how they zero extend on writes. I thought that was
> > something that should remain entirely within the scope of the ISA.
> > Please let me know if I am wrong!
>
> Sounds good
>
> [...]
>
> > > > +C Programming Language Support
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> > > > +
> > > > +**NOTE** This section could be included in order to define the con=
tents
> > > > +of standardized processor-specific header files that would make it=
 easier
> > > > +for programmers to write programs.
> > > > +
> > > > +Notes
> > > > +=3D=3D=3D=3D=3D
> > > > +.. [#] The eBPF machine does not need to be a physical instantiati=
on of a processor. In fact, many instantiations of eBPF machines are virtua=
l.
> > > > +.. [#] See the [CSTD]_ for the inspiration for this distinction.
> > > > +
> > > > +References
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > +
> > > > +.. [SYSVABI] System V Application Binary Interface - Edition 4.1. =
SCO Developer Specs. The Santa Cruz Operation. 1997. https://www.sco.com/de=
velopers/devspecs/gabi41.pdf
> > > > +.. [POWERPCABI] Developing PowerPC Embedded Application Binary Int=
erface (EABI) Compliant Programs. PowerPC Embedded Processors Application N=
ote. IBM. 1998. http://class.ece.iastate.edu/arun/Cpre381_Sp06/lab/labw12a/=
eabi_app.pdf
> > > > +.. [GOABI] Go internal ABI specification. Go Source Code. No autho=
rs. 2023. https://go.googlesource.com/go/+/refs/heads/master/src/cmd/compil=
e/abi-internal.md
> > > > +.. [JAVAABI] The Java (r) Language Specification - Java SE 7 Editi=
on. Gosling, James et. al. Oracle. 2013. https://docs.oracle.com/javase/spe=
cs/jls/se7/html/index.html
> > >
> > > If we do share a link, it should probably be to the Java Virtual Mach=
ine
> > > specification rather than the language specification. I believe the m=
ost
> > > recent edition is 21.
> >
> > I checked and the binary compatibility piece of the specification is
> > actually in the language spec. That said, it might make sense to just
> > link to both? I am willing to do whatever you suggest!
>
> Ah, fair enough. Let's still link the latest version though rather than
> version 7.

This change is made in v3 of the patch -- thank you!


>
> > > > +.. [DALVIKABI] Dalvik Bytecode. Android Core Runtime Documentation=
. No authors. Google. 2022. https://source.android.com/docs/core/runtime/da=
lvik-bytecode
> > > > +.. [CLRABI] CLR ABI. The Book of the Runtime. No authors. Microsof=
t. 2023. https://github.com/dotnet/coreclr/blob/master/Documentation/botr/c=
lr-abi.md.
> > > > +.. [CSTD] International Standard: Programming Languages - C. ISO/I=
EC. 2018. https://www.open-std.org/jtc1/sc22/wg14/www/docs/n2310.pdf.
> > > > +.. [RHELABI] Red Hat Enterprise Linux 8: Application Compatibility=
 Guide. Red Hat. 2023. https://access.redhat.com/articles/rhel8-abi-compati=
bility
> > > > +
> > >
> > > Everything else looks fine for now. Something I think we should figur=
e
> > > out though is what we want to put each of the following docs from the
> > > charter:
> >
> > I reflowed the entire document to make sure that the text is at most 80=
 columns.
> >
> >
> >
> > >
> > > - [I] one or more documents that recommend conventions and guidelines
> > >   for producing portable BPF program binaries,
> > >
> > > - [I] an architecture and framework document.
> > >
> > > It seems like some of what's going into this document (e.g. formally
> > > defining a "Program", data types, etc) could arguably belong in an
> > > architecture and framework document. Honestly, I think it would proba=
bly
> > > be easier and make more sense to just have a single monolithic BPF
> > > Machine informational document, though I'm not sure if that's viable =
at
> > > this point given that we specified different documents in the charter=
.
> >
> > You make (as usual) an excellent point. I think that this question is
> > something that would be good to discuss as a group? Because you are
> > the chair, David, I will defer to you!
>
> Discussing as a group is a great idea. Maybe this would be something to
> discuss at IETF 118?


I believe that we can have a great discussion at 118 on the following
ABI-related topics:

1. Can references in IETF standards documents be used like citations
in an academic article?
When I drafted the original version of the text, I added references to
other (ABI or general) documents because they were the source for
certain language or ideas. That is what an author would do in the
world of academic publishing to make sure that they did not give the
reader the impression that certain words or ideas were their original
writing or thought. I am not sure how IETF handles this situation but
I want to make sure that I am doing the right thing -- I don't want
anyone to get the idea that I am smarter than I am!

2. Related to 1: If we do need/want to make references to external,
non-IETF documents, what is the process for that?

3. Does the vocabulary section
- Stay roughly as it is now?
Basically a set of topic-specific words with introductory/brief definitions=
.
- Get replaced with a simple TOC?
That way the terms can be defined completely and fully in a single place.
- Turn into a combination of the prior two options?
The vocabulary definitions would be brief summaries of the more
complete definition and the text would include a reference to the
section of the document where the term is completely defined.

I unfortunately will not be able to be 118 in person but I do plan on
being present virtually! I am looking forward to talking to everyone!
Please have a great weekend!
Will



>
> Thanks,
> David

