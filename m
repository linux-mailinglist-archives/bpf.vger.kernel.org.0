Return-Path: <bpf+bounces-12903-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE93F7D2069
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 01:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D8821C20A3A
	for <lists+bpf@lfdr.de>; Sat, 21 Oct 2023 23:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5C920B2A;
	Sat, 21 Oct 2023 23:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=obs-cr.20230601.gappssmtp.com header.i=@obs-cr.20230601.gappssmtp.com header.b="GuO2dGCm"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32195210EF
	for <bpf@vger.kernel.org>; Sat, 21 Oct 2023 23:14:39 +0000 (UTC)
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301F9D7B
	for <bpf@vger.kernel.org>; Sat, 21 Oct 2023 16:14:10 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-457bafdc467so855794137.2
        for <bpf@vger.kernel.org>; Sat, 21 Oct 2023 16:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=obs-cr.20230601.gappssmtp.com; s=20230601; t=1697930049; x=1698534849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N811fl5v73+skFSGwbfgZDYC5MgefWjDNjONgcW/5Pk=;
        b=GuO2dGCmKJo0NmoglKNYTJPh7cXLo8F8O+xuuY4PRuThQPAUKpNSzQcrP++Ojnaerl
         6CYjddhOE1UuJsUYsvdmr4+jZ6eS/xRQjrmeB0dPVyBBVy0Eo0n6Wheke78x5QMU52we
         1CNmUvdFDZghz5a+kWKYjlMs0jDb7qaK4QMovjhD4JITORIHdwWtPk25WRtwAxa4Iy7l
         AHmNjpTsc51eCBkVp/6sjd+Ep7aaRhPiirhc+fGctwf1RifXiF6l2UOm6Ck974MxPfC3
         ueq+wd/tngRy8YMbg2IT6MWb8wa4/BgtmmiPPUiI3rhJ/wUsT9iQKH00r38HoqiQgByV
         JfIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697930049; x=1698534849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N811fl5v73+skFSGwbfgZDYC5MgefWjDNjONgcW/5Pk=;
        b=WPCdibEwYcBYSfECEtbbnTXQd2124ZSNkQSwWPYuziaip18L4+h4LJ0/X26BkdxLo2
         zL9AjRQCMM6HZNGsCbixUTjobGRpjUULJ4y/HyeNLW91dSHDICPomSZ/dpJ3j40dIDDd
         Jv505qZZY3a0w+lLkeV7H3Vk+ok4Ld6POikBRnKR8+XPL/SNNuuGoK0tNFLHwqChW4Bf
         eN3XDFRiHQxi/8O3hpu1HOFpGkT/GJexxJxg6F60nCuNBug1Q6+3HgJ2F4Q5CTbjAnZ3
         81DqT7yt5D7276BCIOWrVyxubCHDrg8xJRTUhmwb4QAbxkjEgk+dmLouFH6+dmSiU//D
         ZsaA==
X-Gm-Message-State: AOJu0Yy1/16dnw0Nf08Yj7qY7DoTgFkbYb9n0qIf6LcPhtDxVw1cbPFE
	TonMG8s2vr975uTV7ymMEdKIaHBVuILQIz9IWXI3yA==
X-Google-Smtp-Source: AGHT+IE9GB4ObOFW7ZEzWrZnnRjmcbyhlku1qrnP2FtobbW+/4zaree4hSaU92ft2O7Al8/z/7+jeep6qyvTNOmAbQQ=
X-Received: by 2002:a67:cc01:0:b0:457:bdbf:8a34 with SMTP id
 q1-20020a67cc01000000b00457bdbf8a34mr5060934vsl.29.1697930048810; Sat, 21 Oct
 2023 16:14:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231002142001.3223261-1-hawkinsw@obs.cr> <20231003182650.GA5902@maniforge>
In-Reply-To: <20231003182650.GA5902@maniforge>
From: Will Hawkins <hawkinsw@obs.cr>
Date: Sat, 21 Oct 2023 19:13:58 -0400
Message-ID: <CADx9qWjcSoNb=aWpDVV5QxEoUGuDr2=wOOz3AWhjemh6+hzhwA@mail.gmail.com>
Subject: Re: [PATCH] bpf, docs: Add additional ABI working draft base text
To: David Vernet <void@manifault.com>
Cc: bpf@ietf.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you, David and Christoph, for the comments. I am sending a v2 of
the patch and will respond to open questions inline below.

On Tue, Oct 3, 2023 at 2:26=E2=80=AFPM David Vernet <void@manifault.com> wr=
ote:
>
> On Mon, Oct 02, 2023 at 10:19:55AM -0400, Will Hawkins wrote:
>
> Hi Will,
>
> Thanks for working on this. This is really great work and (obviously) a
> big improvement over my tiny little ABI doc. I left some comments below,
> as is to be expected given that it's only the first draft.
>
> > Per David's description of the IETF standardization process, this
> > document will form the basis for an informational eBPF ABI. The
> > work in this commit is a slightly more complete skeleton for the work
> > that we will do. Everything in this document (from formatting to topics
> > to details) is open for change and feedback.
> > ---
> >  Documentation/bpf/standardization/abi.rst | 237 ++++++++++++++++++++--
> >  1 file changed, 225 insertions(+), 12 deletions(-)
> >
> > diff --git a/Documentation/bpf/standardization/abi.rst b/Documentation/=
bpf/standardization/abi.rst
> > index 0c2e10eeb89a..cadbd1b4d6b3 100644
> > --- a/Documentation/bpf/standardization/abi.rst
> > +++ b/Documentation/bpf/standardization/abi.rst
> > @@ -1,25 +1,238 @@
> > -.. contents::
> > -.. sectnum::
> > -
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> >  BPF ABI Recommended Conventions and Guidelines v1.0
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> >
> > -This is version 1.0 of an informational document containing recommende=
d
> > -conventions and guidelines for producing portable BPF program binaries=
.
> > +An application binary interface (ABI) defines the requirements that on=
e or more binary software
> > +objects must meet in order to guarantee that they can interoperate and=
/or use the resources provided
> > +by operating systems/hardware combinations.  (For alternate definition=
s of ABI, see
> > +[SYSVABI]_, [POWERPCABI]_)
> > +
> > +The purpose of this document is to define an ABI which will define the=
 extent to which compiled
> > +eBPF programs are compatible with each other and the eBPF machine/proc=
essor [#]_ on which they
>
> s/eBPF/BPF throughout the doc

All done!

>
> > +are executing.
> > +
> > +The ABI is specified in two parts: a generic part and a processor-spec=
ific part.
> > +A pairing of of generic ABI with the processor-specific ABI for a cert=
ain instantiation
>
> s/of of/of

Good eyes, thank you!

>
> > +of an eBPF machine represents a complete binary interface for eBPF pro=
grams executing
> > +on that machine.
> > +
> > +This document is a generic ABI and specifies the parameters and behavi=
or common to all
>
> Should this say, "This document is the generic ABI..." to reflect the
> fact that it's the first of the two ABI parts mentioned in the prior
> paragraph?

Absolutely. Great suggestion.

>
> > +instantiations of eBPF machines. In addition, it defines the details t=
hat must be specified by each
> > +processor-specific ABI.
> > +
> > +These psABIs are the second part of the ABI. Each instantiation of an =
eBPF machine must
> > +describe the mechanism through which binary interface compatibility is=
 maintained with
> > +respect to the issues highlighted by this document. However, the detai=
ls that must be
> > +defined by a psABI are a minimum -- a psABI may specify additional req=
uirements for binary
> > +interface compatibility on a platform.
> > +
> > +.. contents::
> > +.. sectnum::
> > +
> > +How To Use This ABI
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Conformance
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Note: Red Hat specifies different levels of conformance over time [RHE=
LABI]_.
>
> I don't think we should specify conformance guidelines for a
> distribution as part of the standardization document. RHEL, Debian,
> future distros, Windows, etc, can all decide what guidelines they give
> developers for backward compatibility, etc with their release cycles,
> but that's entirely separate from a standardization document that's
> enumerating generic or psABIs.

I agree 100%. The "Note:" here was more an author's "note to self"
about where we could look for other existing language that we could
appropriate to include in this document. I have updated the Note: to
be an Author's Note (here and elsewhere) to make that more obvious. I
hope that is okay!

>
> > +
> > +Related Work
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +eBPF programs are not unique for the way that they operate on a virtua=
lized machine and processor.
> > +There are many programming languages that compile to an ISA that is sp=
ecific to a virtual machine.
> > +Like the specification presented herein, those languages and virtual m=
achines also have ABIs.
> > +
> > +For example, the Go programming language and the runtime included stat=
ically with each program compiled
> > +from Go source code have a defined ABI [GOABI]_. Java programs compile=
d to bytecode follow a well-defined
> > +ABI for interoperability with other compiled Java programs and librari=
es [JAVAABI]_. Programs compiled to
> > +bytecode for execution as user applications on the Android operating s=
ystem (OS) adhere to a bytecode
> > +specification that shares much in common with an ABI [DALVIKABI]_. Fin=
ally, the Common Language Runtime (CLR)
> > +designed to execute programs compiled to the Microsoft Intermediate La=
nguage (MSIL) has a fully specified
> > +ABI [CLRABI]_.
>
> While this section is certainly useful background for the reader, I'm
> also not sure it's necessary or appropriate to include. These ABIs are
> independent of this one, and could change at any time. It's probably
> best if we avoid referencing external documents that aren't actual
> dependencies of this document. Feel free to disagree.

You make an excellent point. Although v2 does not make this change, do
you think that a reasonable adjustment would be to simply move this
section to the end of the document?

>
> > +Vocabulary
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +#. Program: An eBPF Program is a self-contained set of eBPF instructio=
ns that execute
> > +   on an eBPF processor.
>
> I wonder if we want to be a bit more concrete here. "Self-contained",
> for example, is arguably a bit ambiguous in terms of what it means. What
> do you think about this?
>
> "Program: A BPF Program is an ordered set of BPF instructions, with
> exactly one entry instruction where the program begins, and one or more
> BPF_EXIT instructions where program execution can end."

This suggestion is fantastic and I have used it verbatim!

>
> > +#. Program Type: Every eBPF program has an associated type. The progra=
m type defines, among other things,
> > +   a program's possible attach types.
> > +#. Attach Type: An attach type defines the set of BPF hook points to w=
hich an eBPF
> > +   program can attach.
> > +#. BPF Hook Points: Places in a BPF-enabled component (e.g., the Linux=
 Kernel, the Windows kernel) where
> > +   an eBPF program may be attached.
>
> Hmm, I'm not sure if having this vocabulary section at the beginning of
> the document is optimal. Consider that the above 3 definitions are quite
> sparse, and essentially do nothing other than reference each other, and
> they're also leaving out a lot of detail that will be explored more
> substantively later in the document (or in the framework / architecture
> informational document described in [0]).
>
> [0]: https://datatracker.ietf.org/wg/bpf/about/
>
> It seems like it might make more sense to follow the approach taken by
> the JVM specification [1], SysV ABI [2], and RISC-V psABI [3] (though
> they do have a section that defines appreviations and a couple of
> terms), and instead just have each chapter explain all of these concepts
> in more detail without any kind of introduction. What do you think?

I could go either way. Personally, when I read documents, I like
having a vocabulary section to give me some bearing. That way, as I
read the document, I know where to turn to see whether words with
which I am unfamiliar are things that I "should know" (and therefore
just Google) or are new terminology from this document. Again, I could
absolutely go either way and certainly appreciate your references to
other documents that work differently. When I wrote this section I
envisioned it like the vocabulary section from the C++ standard where
new terms of art are given basic definitions that are later expanded
throughout the document.

What if we did both -- we could keep the vocabulary section and
include pointers to the places later in the specification where the
terms are explained in additional detail?

>
> [1]: https://docs.oracle.com/javase/specs/jvms/se21/html/index.html
> [2]: https://refspecs.linuxfoundation.org/elf/x86_64-abi-0.95.pdf
> [3]: https://github.com/riscv-non-isa/riscv-elf-psabi-doc/releases/downlo=
ad/draft-20230929-e5c800e661a53efe3c2678d71a306323b60eb13b/riscv-abi.pdf
>
> > +#. eBPF Machine Instantiation:
> > +#. ABI-conforming system: A computer system that provides the binary s=
ys- tem interface for application
> > +   programs described in the System V ABI [SYSVABI]_.
> > +#. ABI-conforming program: A program written to include only the syste=
m routines, commands, and other
> > +   resources included in the ABI, and a program compiled into an execu=
table file that has the formats
> > +   and characteristics specified for such files in the ABI, and a prog=
ram whose behavior complies with
> > +   the rules given in the ABI [SYSVABI]_.
> > +#. ABI-nonconforming program: A program which has been written to incl=
ude system routines, commands, or
> > +   other resources not included in the ABI, or a program which has bee=
n compiled into a format different
> > +   from those specified in the ABI, or a program which does not behave=
 as specified in the ABI [SYSVABI]_.
> > +#. Undefined Behavior: Behavior that may vary from instance to instanc=
e or may change at some time in the future.
> > +   Some undesirable programming practices are marked in the ABI as yie=
lding undefined behavior [SYSVABI]_.
> > +#. Unspecified Property: A property of an entity that is not explicitl=
y included or referenced in this specification,
> > +   and may change at some time in the future. In general, it is not go=
od practice to make a program depend
> > +   on an unspecified property [SYSVABI]_.
> > +
> > +Program Execution Environment
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > +
> > +A loaded eBPF program is executed on an eBPF machine. That machine, ph=
ysical or virtual, runs in a freestanding
> > +or hosted environment [#]_.
> > +
> > +eBPF Machine Freestanding Environment
> > +-------------------------------------
> > +
> > +
> > +eBPF Machine Hosted Environment
> > +-------------------------------
> > +
> > +A loaded eBPF program can be attached to a BPF hook point in a BPF-ena=
bled application
> > +compatible with the attach type of its program type. When the BPF-enab=
led application's
> > +execution reaches a BPF hook point to which an eBPF program is attache=
d, that program
> > +begins execution on the eBPF machine at its first instruction. The con=
tents of eBPF machine's
> > +registers and memory at the time it starts execution are defined by th=
e eBPF program's
> > +type and attach point.
> > +
> > +Processor Architecture
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +This section describes the processor architecture available
> > +to programs. It also defines the reference language data types, giving=
 the
> > +foundation for system interface specifications [SYSVABI]_
>
> Why are we linking to the SYSVABI doc here?

A great question -- in most places where I have referenced that
document it is akin to an academic reference -- I am attempting to
give the user the idea that the language used is not my own completely
original thought. I am attempting to tell the reader that this concept
or language has precedent in another document. I am very new to the
standards-writing process and realize that utilization of citations
may not be "how it works". Please let me know how to proceed!

>
> > +
> > +Registers
> > +---------
> > +
> > +General Purpose Registers
> > +^^^^^^^^^^^^^^^^^^^^^^^^^
> > +eBPF has 11 64-bit wide registers, `r0` - `r10`. The contents of the r=
egisters
> > +at the beginning of an eBPF program's execution depend on the program'=
s type.
>
> We should probably also mention the 32 bit subregisters (they can only
> be accessed through special ALU operations), and that they zero-extend
> into 64 bit on writes.

I added a note on the subregisters. I decided to leave out the
information about how they zero extend on writes. I thought that was
something that should remain entirely within the scope of the ISA.
Please let me know if I am wrong!

>
> > +
> > +Frame Pointer Register
> > +^^^^^^^^^^^^^^^^^^^^^^
> > +The use of a frame pointer by programs is not required. If, however, a=
n eBPF program
> > +does use a frame pointer, it must be stored in register `r10`.
>
> Should we also specify that it should be read only?

Agreed and done!


>
> > +
> > +Data Types
> > +----------
> >
> > -Registers and calling convention
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Numeric Types
> > +^^^^^^^^^^^^^
> >
> > -BPF has 10 general purpose registers and a read-only frame pointer reg=
ister,
> > -all of which are 64-bits wide.
> > +The eBPF machine supports 32- and 64-bit signed and unsigned integers.=
 It does
> > +not support floating-point data types. All signed integers are represe=
nted in
> > +twos-complement format where the sign bit is stored in the most-signif=
icant
> > +bit.
> >
> > -The BPF calling convention is defined as:
> > +Pointers
> > +^^^^^^^^
> >
> > -* R0: return value from function calls, and exit value for BPF program=
s
> > +Function Calling Sequence
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > +This section defines the standard function calling sequence in a way t=
hat
> > +accommodates exceptions, stack management, register (non)volatility, a=
nd access
> > +to capabilities of the hosting environment (where applicable).
> > +
> > +Functions in eBPF may define between 0 and 5 parameters. Each of the a=
rguments in
> > +a function call are passed in registers.
> > +
> > +The eBPF calling convention is defined as:
> > +
> > +* R0: return value from function calls, and exit value for eBPF progra=
ms
> >  * R1 - R5: arguments for function calls
> >  * R6 - R9: callee saved registers that function calls will preserve
> >  * R10: read-only frame pointer to access stack
> >
> > -R0 - R5 are scratch registers and BPF programs needs to spill/fill the=
m if
> > +R0 - R5 are scratch registers and eBPF programs needs to spill/fill th=
em if
> >  necessary across calls.
> > +
> > +Every function invocation proceeds as if it has exclusive access to an
> > +implementation-defined amount of stack space. R10 is a pointer to the =
byte of
> > +memory with the highest address in that stack space. The contents
> > +of a function invocation's stack space do not persist between invocati=
ons.
> > +
> > +**TODO** Discuss manufactured prologue and epilogue. Take language fro=
m the design FAQ.
> > +
> > +Execution Environment Interface
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +When an eBPF program executes in a hosted environment, the hosted envi=
ronment may make
> > +available to eBPF programs certain capabilities. This section describe=
s those capabilities
> > +and the mechanism for accessing them.
> > +
> > +
> > +Program Execution
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Program Return Values
> > +---------------------
> > +
> > +**NOTE** libbpf currently defines the return value of an ebpf program =
as a 32-bit unsigned integer.
> > +
> > +Program Loading and Dynamic Linking
> > +-----------------------------------
> > +This section describes the object file information and system actions =
that create
> > +running programs. Some information here applies to all systems; inform=
ation specific
> > +to one processor resides in sections marked accordingly [SYSVABI]_.
> > +
> > +eBPF programs saved in ELF files must be loaded from storage and prope=
rly configured before
> > +they can be executed on an eBPF machine.
> > +
> > +Program Loading (Processor-Specific)
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > +Dynamic Linking
> > +^^^^^^^^^^^^^^^
> > +
> > +Global Offset Table (Processor-Specific)
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +Procedure Linkage Table (Processor-Specific)
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +Exception Handling
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +eBPF Program Types
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +**NOTE** This information may end up as a subsection somewhere else.
> > +
> > +eBPF Maps
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +**NOTE** This information may end up as a subsection somewhere else.
> > +
> > +System Calls
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +**TODO**
> > +
> > +C Programming Language Support
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > +
> > +**NOTE** This section could be included in order to define the content=
s
> > +of standardized processor-specific header files that would make it eas=
ier
> > +for programmers to write programs.
> > +
> > +Notes
> > +=3D=3D=3D=3D=3D
> > +.. [#] The eBPF machine does not need to be a physical instantiation o=
f a processor. In fact, many instantiations of eBPF machines are virtual.
> > +.. [#] See the [CSTD]_ for the inspiration for this distinction.
> > +
> > +References
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +.. [SYSVABI] System V Application Binary Interface - Edition 4.1. SCO =
Developer Specs. The Santa Cruz Operation. 1997. https://www.sco.com/develo=
pers/devspecs/gabi41.pdf
> > +.. [POWERPCABI] Developing PowerPC Embedded Application Binary Interfa=
ce (EABI) Compliant Programs. PowerPC Embedded Processors Application Note.=
 IBM. 1998. http://class.ece.iastate.edu/arun/Cpre381_Sp06/lab/labw12a/eabi=
_app.pdf
> > +.. [GOABI] Go internal ABI specification. Go Source Code. No authors. =
2023. https://go.googlesource.com/go/+/refs/heads/master/src/cmd/compile/ab=
i-internal.md
> > +.. [JAVAABI] The Java (r) Language Specification - Java SE 7 Edition. =
Gosling, James et. al. Oracle. 2013. https://docs.oracle.com/javase/specs/j=
ls/se7/html/index.html
>
> If we do share a link, it should probably be to the Java Virtual Machine
> specification rather than the language specification. I believe the most
> recent edition is 21.

I checked and the binary compatibility piece of the specification is
actually in the language spec. That said, it might make sense to just
link to both? I am willing to do whatever you suggest!

>
> > +.. [DALVIKABI] Dalvik Bytecode. Android Core Runtime Documentation. No=
 authors. Google. 2022. https://source.android.com/docs/core/runtime/dalvik=
-bytecode
> > +.. [CLRABI] CLR ABI. The Book of the Runtime. No authors. Microsoft. 2=
023. https://github.com/dotnet/coreclr/blob/master/Documentation/botr/clr-a=
bi.md.
> > +.. [CSTD] International Standard: Programming Languages - C. ISO/IEC. =
2018. https://www.open-std.org/jtc1/sc22/wg14/www/docs/n2310.pdf.
> > +.. [RHELABI] Red Hat Enterprise Linux 8: Application Compatibility Gui=
de. Red Hat. 2023. https://access.redhat.com/articles/rhel8-abi-compatibili=
ty
> > +
>
> Everything else looks fine for now. Something I think we should figure
> out though is what we want to put each of the following docs from the
> charter:

I reflowed the entire document to make sure that the text is at most 80 col=
umns.



>
> - [I] one or more documents that recommend conventions and guidelines
>   for producing portable BPF program binaries,
>
> - [I] an architecture and framework document.
>
> It seems like some of what's going into this document (e.g. formally
> defining a "Program", data types, etc) could arguably belong in an
> architecture and framework document. Honestly, I think it would probably
> be easier and make more sense to just have a single monolithic BPF
> Machine informational document, though I'm not sure if that's viable at
> this point given that we specified different documents in the charter.

You make (as usual) an excellent point. I think that this question is
something that would be good to discuss as a group? Because you are
the chair, David, I will defer to you!

Thank you again David and Christoph for your comments!

Will

>
> Thanks,
> David

