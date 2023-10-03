Return-Path: <bpf+bounces-11295-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA037B70C7
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 20:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 452252813D4
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 18:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081033C69D;
	Tue,  3 Oct 2023 18:27:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C228D2EB
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 18:26:57 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B1983
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 11:26:54 -0700 (PDT)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-694f3444f94so977218b3a.2
        for <bpf@vger.kernel.org>; Tue, 03 Oct 2023 11:26:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696357614; x=1696962414;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X1UUq1ErSjgqYaU/Hf1+EggrjHRNcxf46ITk7awz++4=;
        b=AIixabwlOZJgZs+99/nWdLrNTesmXAshBGXcLseb4mfQT1Mf/62eTQ9DX2IRx/sYWp
         sIjRnA69WMm51JTtEb9mmNPkZ98caloLkvIqeHqgLX5Hsr5fYP4TJfSIqrCPyt43aIAj
         Zlfi12gnuA4b8sSPnXzbB+1tsM+HXOqPKb8UKS4Tc8gOmInzFPuYJv3n7vuu/YdpdkJ+
         pBQOoP5OGMAqJbcO/jgYHDn+d6ZiOY7vijcdZN53TxfUjFtFncMsyiGQ43wK0IWM6Rbg
         BRHVaNpqUngzpZrJYPWO1FEj4SBxL9jcxmXuGJYZS4SvRB3r1pHTtHH55DZZg/UoixPR
         2xIQ==
X-Gm-Message-State: AOJu0YxYL/oWqsdP7FCPoa1thgpnjvq6TFP8c1sBhZQ2R5cAmRU1Tfgz
	BVLVTewY4EBAp7ssM1CcW2M=
X-Google-Smtp-Source: AGHT+IFV6bNIxRHHkvoJOTsoVjfKYjqCgywYE9kJmJIZ8n/u1Fee2btlg9fFOWG+CQAIxbHnKT3Ygw==
X-Received: by 2002:a05:6a21:197:b0:149:122b:6330 with SMTP id le23-20020a056a21019700b00149122b6330mr333734pzb.10.1696357613621;
        Tue, 03 Oct 2023 11:26:53 -0700 (PDT)
Received: from maniforge ([2620:10d:c090:400::4:d6ec])
        by smtp.gmail.com with ESMTPSA id i8-20020aa79088000000b00690c9fda0fesm1671792pfa.169.2023.10.03.11.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 11:26:52 -0700 (PDT)
Date: Tue, 3 Oct 2023 13:26:50 -0500
From: David Vernet <void@manifault.com>
To: Will Hawkins <hawkinsw@obs.cr>
Cc: bpf@ietf.org, bpf@vger.kernel.org
Subject: Re: [PATCH] bpf, docs: Add additional ABI working draft base text
Message-ID: <20231003182650.GA5902@maniforge>
References: <20231002142001.3223261-1-hawkinsw@obs.cr>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002142001.3223261-1-hawkinsw@obs.cr>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,URI_DOTEDU autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 02, 2023 at 10:19:55AM -0400, Will Hawkins wrote:

Hi Will,

Thanks for working on this. This is really great work and (obviously) a
big improvement over my tiny little ABI doc. I left some comments below,
as is to be expected given that it's only the first draft.

> Per David's description of the IETF standardization process, this
> document will form the basis for an informational eBPF ABI. The
> work in this commit is a slightly more complete skeleton for the work
> that we will do. Everything in this document (from formatting to topics
> to details) is open for change and feedback.
> ---
>  Documentation/bpf/standardization/abi.rst | 237 ++++++++++++++++++++--
>  1 file changed, 225 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/bpf/standardization/abi.rst b/Documentation/bpf/standardization/abi.rst
> index 0c2e10eeb89a..cadbd1b4d6b3 100644
> --- a/Documentation/bpf/standardization/abi.rst
> +++ b/Documentation/bpf/standardization/abi.rst
> @@ -1,25 +1,238 @@
> -.. contents::
> -.. sectnum::
> -
>  ===================================================
>  BPF ABI Recommended Conventions and Guidelines v1.0
>  ===================================================
>  
> -This is version 1.0 of an informational document containing recommended
> -conventions and guidelines for producing portable BPF program binaries.
> +An application binary interface (ABI) defines the requirements that one or more binary software
> +objects must meet in order to guarantee that they can interoperate and/or use the resources provided
> +by operating systems/hardware combinations.  (For alternate definitions of ABI, see
> +[SYSVABI]_, [POWERPCABI]_)
> +
> +The purpose of this document is to define an ABI which will define the extent to which compiled
> +eBPF programs are compatible with each other and the eBPF machine/processor [#]_ on which they

s/eBPF/BPF throughout the doc

> +are executing.
> +
> +The ABI is specified in two parts: a generic part and a processor-specific part.
> +A pairing of of generic ABI with the processor-specific ABI for a certain instantiation

s/of of/of

> +of an eBPF machine represents a complete binary interface for eBPF programs executing
> +on that machine.
> +
> +This document is a generic ABI and specifies the parameters and behavior common to all

Should this say, "This document is the generic ABI..." to reflect the
fact that it's the first of the two ABI parts mentioned in the prior
paragraph?

> +instantiations of eBPF machines. In addition, it defines the details that must be specified by each
> +processor-specific ABI. 
> +
> +These psABIs are the second part of the ABI. Each instantiation of an eBPF machine must
> +describe the mechanism through which binary interface compatibility is maintained with
> +respect to the issues highlighted by this document. However, the details that must be
> +defined by a psABI are a minimum -- a psABI may specify additional requirements for binary
> +interface compatibility on a platform.
> +
> +.. contents::
> +.. sectnum::
> +
> +How To Use This ABI
> +===================
> +
> +Conformance
> +===========
> +
> +Note: Red Hat specifies different levels of conformance over time [RHELABI]_.

I don't think we should specify conformance guidelines for a
distribution as part of the standardization document. RHEL, Debian,
future distros, Windows, etc, can all decide what guidelines they give
developers for backward compatibility, etc with their release cycles,
but that's entirely separate from a standardization document that's
enumerating generic or psABIs.

> +
> +Related Work
> +============
> +eBPF programs are not unique for the way that they operate on a virtualized machine and processor.
> +There are many programming languages that compile to an ISA that is specific to a virtual machine.
> +Like the specification presented herein, those languages and virtual machines also have ABIs.
> +
> +For example, the Go programming language and the runtime included statically with each program compiled
> +from Go source code have a defined ABI [GOABI]_. Java programs compiled to bytecode follow a well-defined
> +ABI for interoperability with other compiled Java programs and libraries [JAVAABI]_. Programs compiled to
> +bytecode for execution as user applications on the Android operating system (OS) adhere to a bytecode
> +specification that shares much in common with an ABI [DALVIKABI]_. Finally, the Common Language Runtime (CLR)
> +designed to execute programs compiled to the Microsoft Intermediate Language (MSIL) has a fully specified
> +ABI [CLRABI]_.

While this section is certainly useful background for the reader, I'm
also not sure it's necessary or appropriate to include. These ABIs are
independent of this one, and could change at any time. It's probably
best if we avoid referencing external documents that aren't actual
dependencies of this document. Feel free to disagree.

> +Vocabulary
> +==========
> +
> +#. Program: An eBPF Program is a self-contained set of eBPF instructions that execute
> +   on an eBPF processor.

I wonder if we want to be a bit more concrete here. "Self-contained",
for example, is arguably a bit ambiguous in terms of what it means. What
do you think about this?

"Program: A BPF Program is an ordered set of BPF instructions, with
exactly one entry instruction where the program begins, and one or more
BPF_EXIT instructions where program execution can end."

> +#. Program Type: Every eBPF program has an associated type. The program type defines, among other things,
> +   a program's possible attach types.
> +#. Attach Type: An attach type defines the set of BPF hook points to which an eBPF
> +   program can attach.
> +#. BPF Hook Points: Places in a BPF-enabled component (e.g., the Linux Kernel, the Windows kernel) where
> +   an eBPF program may be attached.

Hmm, I'm not sure if having this vocabulary section at the beginning of
the document is optimal. Consider that the above 3 definitions are quite
sparse, and essentially do nothing other than reference each other, and
they're also leaving out a lot of detail that will be explored more
substantively later in the document (or in the framework / architecture
informational document described in [0]).

[0]: https://datatracker.ietf.org/wg/bpf/about/

It seems like it might make more sense to follow the approach taken by
the JVM specification [1], SysV ABI [2], and RISC-V psABI [3] (though
they do have a section that defines appreviations and a couple of
terms), and instead just have each chapter explain all of these concepts
in more detail without any kind of introduction. What do you think?

[1]: https://docs.oracle.com/javase/specs/jvms/se21/html/index.html
[2]: https://refspecs.linuxfoundation.org/elf/x86_64-abi-0.95.pdf
[3]: https://github.com/riscv-non-isa/riscv-elf-psabi-doc/releases/download/draft-20230929-e5c800e661a53efe3c2678d71a306323b60eb13b/riscv-abi.pdf

> +#. eBPF Machine Instantiation: 
> +#. ABI-conforming system: A computer system that provides the binary sys- tem interface for application
> +   programs described in the System V ABI [SYSVABI]_.
> +#. ABI-conforming program: A program written to include only the system routines, commands, and other
> +   resources included in the ABI, and a program compiled into an executable file that has the formats
> +   and characteristics specified for such files in the ABI, and a program whose behavior complies with
> +   the rules given in the ABI [SYSVABI]_.
> +#. ABI-nonconforming program: A program which has been written to include system routines, commands, or
> +   other resources not included in the ABI, or a program which has been compiled into a format different
> +   from those specified in the ABI, or a program which does not behave as specified in the ABI [SYSVABI]_.
> +#. Undefined Behavior: Behavior that may vary from instance to instance or may change at some time in the future.
> +   Some undesirable programming practices are marked in the ABI as yielding undefined behavior [SYSVABI]_. 
> +#. Unspecified Property: A property of an entity that is not explicitly included or referenced in this specification,
> +   and may change at some time in the future. In general, it is not good practice to make a program depend
> +   on an unspecified property [SYSVABI]_.
> +
> +Program Execution Environment
> +=============================
> +
> +A loaded eBPF program is executed on an eBPF machine. That machine, physical or virtual, runs in a freestanding
> +or hosted environment [#]_.
> +
> +eBPF Machine Freestanding Environment
> +-------------------------------------
> +
> +
> +eBPF Machine Hosted Environment
> +-------------------------------
> +
> +A loaded eBPF program can be attached to a BPF hook point in a BPF-enabled application
> +compatible with the attach type of its program type. When the BPF-enabled application's
> +execution reaches a BPF hook point to which an eBPF program is attached, that program
> +begins execution on the eBPF machine at its first instruction. The contents of eBPF machine's
> +registers and memory at the time it starts execution are defined by the eBPF program's
> +type and attach point.
> +
> +Processor Architecture
> +======================
> +
> +This section describes the processor architecture available
> +to programs. It also defines the reference language data types, giving the
> +foundation for system interface specifications [SYSVABI]_

Why are we linking to the SYSVABI doc here?

> +
> +Registers
> +---------
> +
> +General Purpose Registers
> +^^^^^^^^^^^^^^^^^^^^^^^^^
> +eBPF has 11 64-bit wide registers, `r0` - `r10`. The contents of the registers
> +at the beginning of an eBPF program's execution depend on the program's type.

We should probably also mention the 32 bit subregisters (they can only
be accessed through special ALU operations), and that they zero-extend
into 64 bit on writes.

> +
> +Frame Pointer Register
> +^^^^^^^^^^^^^^^^^^^^^^
> +The use of a frame pointer by programs is not required. If, however, an eBPF program
> +does use a frame pointer, it must be stored in register `r10`.

Should we also specify that it should be read only?

> +
> +Data Types
> +----------
>  
> -Registers and calling convention
> -================================
> +Numeric Types
> +^^^^^^^^^^^^^
>  
> -BPF has 10 general purpose registers and a read-only frame pointer register,
> -all of which are 64-bits wide.
> +The eBPF machine supports 32- and 64-bit signed and unsigned integers. It does 
> +not support floating-point data types. All signed integers are represented in
> +twos-complement format where the sign bit is stored in the most-significant
> +bit.
>  
> -The BPF calling convention is defined as:
> +Pointers
> +^^^^^^^^
>  
> -* R0: return value from function calls, and exit value for BPF programs
> +Function Calling Sequence
> +=========================
> +This section defines the standard function calling sequence in a way that
> +accommodates exceptions, stack management, register (non)volatility, and access
> +to capabilities of the hosting environment (where applicable).
> +
> +Functions in eBPF may define between 0 and 5 parameters. Each of the arguments in
> +a function call are passed in registers.
> +
> +The eBPF calling convention is defined as:
> +
> +* R0: return value from function calls, and exit value for eBPF programs
>  * R1 - R5: arguments for function calls
>  * R6 - R9: callee saved registers that function calls will preserve
>  * R10: read-only frame pointer to access stack
>  
> -R0 - R5 are scratch registers and BPF programs needs to spill/fill them if
> +R0 - R5 are scratch registers and eBPF programs needs to spill/fill them if
>  necessary across calls.
> +
> +Every function invocation proceeds as if it has exclusive access to an
> +implementation-defined amount of stack space. R10 is a pointer to the byte of
> +memory with the highest address in that stack space. The contents
> +of a function invocation's stack space do not persist between invocations.
> +
> +**TODO** Discuss manufactured prologue and epilogue. Take language from the design FAQ.
> +
> +Execution Environment Interface
> +===============================
> +
> +When an eBPF program executes in a hosted environment, the hosted environment may make
> +available to eBPF programs certain capabilities. This section describes those capabilities
> +and the mechanism for accessing them.
> +
> +
> +Program Execution
> +=================
> +
> +Program Return Values
> +---------------------
> +
> +**NOTE** libbpf currently defines the return value of an ebpf program as a 32-bit unsigned integer.
> +
> +Program Loading and Dynamic Linking
> +-----------------------------------
> +This section describes the object file information and system actions that create
> +running programs. Some information here applies to all systems; information specific
> +to one processor resides in sections marked accordingly [SYSVABI]_.
> +
> +eBPF programs saved in ELF files must be loaded from storage and properly configured before
> +they can be executed on an eBPF machine. 
> +
> +Program Loading (Processor-Specific)
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +Dynamic Linking
> +^^^^^^^^^^^^^^^
> +
> +Global Offset Table (Processor-Specific)
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Procedure Linkage Table (Processor-Specific)
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Exception Handling
> +==================
> +
> +eBPF Program Types
> +==================
> +**NOTE** This information may end up as a subsection somewhere else.
> +
> +eBPF Maps
> +=========
> +**NOTE** This information may end up as a subsection somewhere else.
> +
> +System Calls
> +============
> +
> +**TODO**
> +
> +C Programming Language Support
> +==============================
> +
> +**NOTE** This section could be included in order to define the contents
> +of standardized processor-specific header files that would make it easier
> +for programmers to write programs.
> +
> +Notes
> +=====
> +.. [#] The eBPF machine does not need to be a physical instantiation of a processor. In fact, many instantiations of eBPF machines are virtual.
> +.. [#] See the [CSTD]_ for the inspiration for this distinction.
> +
> +References
> +==========
> +
> +.. [SYSVABI] System V Application Binary Interface - Edition 4.1. SCO Developer Specs. The Santa Cruz Operation. 1997. https://www.sco.com/developers/devspecs/gabi41.pdf
> +.. [POWERPCABI] Developing PowerPC Embedded Application Binary Interface (EABI) Compliant Programs. PowerPC Embedded Processors Application Note. IBM. 1998. http://class.ece.iastate.edu/arun/Cpre381_Sp06/lab/labw12a/eabi_app.pdf
> +.. [GOABI] Go internal ABI specification. Go Source Code. No authors. 2023. https://go.googlesource.com/go/+/refs/heads/master/src/cmd/compile/abi-internal.md
> +.. [JAVAABI] The Java (r) Language Specification - Java SE 7 Edition. Gosling, James et. al. Oracle. 2013. https://docs.oracle.com/javase/specs/jls/se7/html/index.html

If we do share a link, it should probably be to the Java Virtual Machine
specification rather than the language specification. I believe the most
recent edition is 21.

> +.. [DALVIKABI] Dalvik Bytecode. Android Core Runtime Documentation. No authors. Google. 2022. https://source.android.com/docs/core/runtime/dalvik-bytecode
> +.. [CLRABI] CLR ABI. The Book of the Runtime. No authors. Microsoft. 2023. https://github.com/dotnet/coreclr/blob/master/Documentation/botr/clr-abi.md. 
> +.. [CSTD] International Standard: Programming Languages - C. ISO/IEC. 2018. https://www.open-std.org/jtc1/sc22/wg14/www/docs/n2310.pdf.
> +.. [RHELABI] Red Hat Enterprise Linux 8: Application Compatibility Guide. Red Hat. 2023. https://access.redhat.com/articles/rhel8-abi-compatibility 
> +

Everything else looks fine for now. Something I think we should figure
out though is what we want to put each of the following docs from the
charter:

- [I] one or more documents that recommend conventions and guidelines
  for producing portable BPF program binaries,

- [I] an architecture and framework document.

It seems like some of what's going into this document (e.g. formally
defining a "Program", data types, etc) could arguably belong in an
architecture and framework document. Honestly, I think it would probably
be easier and make more sense to just have a single monolithic BPF
Machine informational document, though I'm not sure if that's viable at
this point given that we specified different documents in the charter.

Thanks,
David

