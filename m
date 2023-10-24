Return-Path: <bpf+bounces-13087-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EA87D4457
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 02:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 243101F21C13
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 00:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA05D187D;
	Tue, 24 Oct 2023 00:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="xAXKdsgm";
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="xAXKdsgm"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E977E
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 00:55:44 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CAD9B
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 17:55:39 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 9C8AAC17C50A
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 17:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1698108939; bh=LTCT3Eg84MIsi12TjxxVrm8AzBMTj/zf7CSNP8vEcRI=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=xAXKdsgm3s7RuBfez6RV5+vkA+bfMPi1cVNpJ5DSyCWXNpqwSWbCXEEXedTNEcDt+
	 QoyNRSc+VCk3NFedkjLKfIXOADTfNR/z8Sg3CH/9wwFR45bk3G9zKQ6i46NSolkYBB
	 8DwKa4ysYqQN2CMYYH7VGs4UGqPOxEzyq8DreSXg=
X-Mailbox-Line: From bpf-bounces@ietf.org  Mon Oct 23 17:55:39 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 66714C170616;
	Mon, 23 Oct 2023 17:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1698108939; bh=LTCT3Eg84MIsi12TjxxVrm8AzBMTj/zf7CSNP8vEcRI=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=xAXKdsgm3s7RuBfez6RV5+vkA+bfMPi1cVNpJ5DSyCWXNpqwSWbCXEEXedTNEcDt+
	 QoyNRSc+VCk3NFedkjLKfIXOADTfNR/z8Sg3CH/9wwFR45bk3G9zKQ6i46NSolkYBB
	 8DwKa4ysYqQN2CMYYH7VGs4UGqPOxEzyq8DreSXg=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 12194C170616
 for <bpf@ietfa.amsl.com>; Mon, 23 Oct 2023 17:55:38 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -0.404
X-Spam-Level: 
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bvdQdFoiXkyW for <bpf@ietfa.amsl.com>;
 Mon, 23 Oct 2023 17:55:33 -0700 (PDT)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com
 [209.85.160.170])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 0D7F9C170614
 for <bpf@ietf.org>; Mon, 23 Oct 2023 17:55:32 -0700 (PDT)
Received: by mail-qt1-f170.google.com with SMTP id
 d75a77b69052e-41cd4cc515fso26523761cf.1
 for <bpf@ietf.org>; Mon, 23 Oct 2023 17:55:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698108932; x=1698713732;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TzrAe1lRze6zeCK7Nd50x4uh2RABipNKfsyou+zKIyI=;
 b=M2Nm/hrv7ML7son797O5kVqBPms5iGYK0J0gZ61tH7QtooBGVeFUdfGE5Yz6LYm184
 5d05RJNF18xGtRZXVlLsoOfOYKUizdgSG9uHjM1fADWSDCTupyvaabta7Rof2GuP8cwT
 S1GUOt8r5JUgDMtTGmA2j5w3MIDkgJVGGJGx2q+5JIEGNG2SGUZDfDubPHnCgCARqRa+
 5a0H7STZXA9wE/8O60Oxd3bc7or2++bYlW8SiEFc8vtXr6qpiBTqozmiY6bVhcxwMbPD
 DRpgOWdaw6tOxdTjkFBBSbTTqTZVXYcC38DWUD9ztVW+wvyiNCWGApDMAY50TYaXlqtB
 AU6w==
X-Gm-Message-State: AOJu0Ywf8aR7iXF9YrI3qcvwTn6ljVKK6O37/DpYZdS+T7aknaunFirg
 PVZbEGVG3lN857HchwlAFD5h44ijW16z10bz
X-Google-Smtp-Source: AGHT+IGFq/0rv1vwYoGQX7UvSNUv5ADS3tZ4KcH4Vx/9RpCNFNRyGmzi3Nfhjk501JQx6nsrrkgebg==
X-Received: by 2002:a05:622a:304:b0:412:2ad4:da05 with SMTP id
 q4-20020a05622a030400b004122ad4da05mr13509058qtw.38.1698108931684; 
 Mon, 23 Oct 2023 17:55:31 -0700 (PDT)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
 by smtp.gmail.com with ESMTPSA id
 a18-20020ac87212000000b00419b5274381sm3093147qtp.94.2023.10.23.17.55.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 17:55:30 -0700 (PDT)
Date: Mon, 23 Oct 2023 19:55:28 -0500
From: David Vernet <void@manifault.com>
To: Will Hawkins <hawkinsw@obs.cr>
Cc: bpf@ietf.org, bpf@vger.kernel.org
Message-ID: <20231024005528.GA33696@maniforge>
References: <20231002142001.3223261-1-hawkinsw@obs.cr>
 <20231003182650.GA5902@maniforge>
 <CADx9qWjcSoNb=aWpDVV5QxEoUGuDr2=wOOz3AWhjemh6+hzhwA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CADx9qWjcSoNb=aWpDVV5QxEoUGuDr2=wOOz3AWhjemh6+hzhwA@mail.gmail.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/bykMYclRUoqp_idU23tQ2qrUyHA>
Subject: Re: [Bpf] [PATCH] bpf,
 docs: Add additional ABI working draft base text
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: Discussion of BPF/eBPF standardization efforts within the IETF
 <bpf.ietf.org>
List-Unsubscribe: <https://www.ietf.org/mailman/options/bpf>,
 <mailto:bpf-request@ietf.org?subject=unsubscribe>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Subscribe: <https://www.ietf.org/mailman/listinfo/bpf>,
 <mailto:bpf-request@ietf.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>

On Sat, Oct 21, 2023 at 07:13:58PM -0400, Will Hawkins wrote:

[...]

> > > +instantiations of eBPF machines. In addition, it defines the details that must be specified by each
> > > +processor-specific ABI.
> > > +
> > > +These psABIs are the second part of the ABI. Each instantiation of an eBPF machine must
> > > +describe the mechanism through which binary interface compatibility is maintained with
> > > +respect to the issues highlighted by this document. However, the details that must be
> > > +defined by a psABI are a minimum -- a psABI may specify additional requirements for binary
> > > +interface compatibility on a platform.
> > > +
> > > +.. contents::
> > > +.. sectnum::
> > > +
> > > +How To Use This ABI
> > > +===================
> > > +
> > > +Conformance
> > > +===========
> > > +
> > > +Note: Red Hat specifies different levels of conformance over time [RHELABI]_.
> >
> > I don't think we should specify conformance guidelines for a
> > distribution as part of the standardization document. RHEL, Debian,
> > future distros, Windows, etc, can all decide what guidelines they give
> > developers for backward compatibility, etc with their release cycles,
> > but that's entirely separate from a standardization document that's
> > enumerating generic or psABIs.
> 
> I agree 100%. The "Note:" here was more an author's "note to self"
> about where we could look for other existing language that we could
> appropriate to include in this document. I have updated the Note: to
> be an Author's Note (here and elsewhere) to make that more obvious. I
> hope that is okay!

Hmm, I think that could get confusing. Can we just add comments anywhere
that we want to be able to record places for us to use as a reference
for language later? Ideally anything going into the document should be
text that we're intending to eventually publish, perhaps with the
exception of things like XXX: Fill in later.

> > > +Related Work
> > > +============
> > > +eBPF programs are not unique for the way that they operate on a virtualized machine and processor.
> > > +There are many programming languages that compile to an ISA that is specific to a virtual machine.
> > > +Like the specification presented herein, those languages and virtual machines also have ABIs.
> > > +
> > > +For example, the Go programming language and the runtime included statically with each program compiled
> > > +from Go source code have a defined ABI [GOABI]_. Java programs compiled to bytecode follow a well-defined
> > > +ABI for interoperability with other compiled Java programs and libraries [JAVAABI]_. Programs compiled to
> > > +bytecode for execution as user applications on the Android operating system (OS) adhere to a bytecode
> > > +specification that shares much in common with an ABI [DALVIKABI]_. Finally, the Common Language Runtime (CLR)
> > > +designed to execute programs compiled to the Microsoft Intermediate Language (MSIL) has a fully specified
> > > +ABI [CLRABI]_.
> >
> > While this section is certainly useful background for the reader, I'm
> > also not sure it's necessary or appropriate to include. These ABIs are
> > independent of this one, and could change at any time. It's probably
> > best if we avoid referencing external documents that aren't actual
> > dependencies of this document. Feel free to disagree.
> 
> You make an excellent point. Although v2 does not make this change, do
> you think that a reasonable adjustment would be to simply move this
> section to the end of the document?

My initial expectation is that it's not a great idea to reference
external documents that could change, no longer be valid links, etc, but
I'd like to hear what others think. Dave -- is this typical for an IETF
informational document? It seems like if we did this we'd basically be
taking implicit dependencies on documents we can't actually control
(because they're not IETF), but I have no idea if this is normal or not.

> >
> > > +Vocabulary
> > > +==========
> > > +
> > > +#. Program: An eBPF Program is a self-contained set of eBPF instructions that execute
> > > +   on an eBPF processor.
> >
> > I wonder if we want to be a bit more concrete here. "Self-contained",
> > for example, is arguably a bit ambiguous in terms of what it means. What
> > do you think about this?
> >
> > "Program: A BPF Program is an ordered set of BPF instructions, with
> > exactly one entry instruction where the program begins, and one or more
> > BPF_EXIT instructions where program execution can end."
> 
> This suggestion is fantastic and I have used it verbatim!
> 
> >
> > > +#. Program Type: Every eBPF program has an associated type. The program type defines, among other things,
> > > +   a program's possible attach types.
> > > +#. Attach Type: An attach type defines the set of BPF hook points to which an eBPF
> > > +   program can attach.
> > > +#. BPF Hook Points: Places in a BPF-enabled component (e.g., the Linux Kernel, the Windows kernel) where
> > > +   an eBPF program may be attached.
> >
> > Hmm, I'm not sure if having this vocabulary section at the beginning of
> > the document is optimal. Consider that the above 3 definitions are quite
> > sparse, and essentially do nothing other than reference each other, and
> > they're also leaving out a lot of detail that will be explored more
> > substantively later in the document (or in the framework / architecture
> > informational document described in [0]).
> >
> > [0]: https://datatracker.ietf.org/wg/bpf/about/
> >
> > It seems like it might make more sense to follow the approach taken by
> > the JVM specification [1], SysV ABI [2], and RISC-V psABI [3] (though
> > they do have a section that defines appreviations and a couple of
> > terms), and instead just have each chapter explain all of these concepts
> > in more detail without any kind of introduction. What do you think?
> 
> I could go either way. Personally, when I read documents, I like
> having a vocabulary section to give me some bearing. That way, as I
> read the document, I know where to turn to see whether words with
> which I am unfamiliar are things that I "should know" (and therefore
> just Google) or are new terminology from this document. Again, I could
>
> absolutely go either way and certainly appreciate your references to
> other documents that work differently. When I wrote this section I
> envisioned it like the vocabulary section from the C++ standard where
> new terms of art are given basic definitions that are later expanded
> throughout the document.
> 
> What if we did both -- we could keep the vocabulary section and
> include pointers to the places later in the specification where the
> terms are explained in additional detail?

If we did this, then the vocabulary section would become a combination
of a table of contents, and an index of sorts. I personally find that in
documents such as the C and C++ standard, that the terms section ends up
being arbitrarily chosen, and insufficiently defined (see all the Notes
sections peppered throughout these terms).

I'd again appreciate hearing other folks' thoughts here. I'm inclined to
say that the document would be better served by having a clear table of
contents where these terms are specified and defined in one place, but I
don't have a super strong opinion.

> > [1]: https://docs.oracle.com/javase/specs/jvms/se21/html/index.html
> > [2]: https://refspecs.linuxfoundation.org/elf/x86_64-abi-0.95.pdf
> > [3]: https://github.com/riscv-non-isa/riscv-elf-psabi-doc/releases/download/draft-20230929-e5c800e661a53efe3c2678d71a306323b60eb13b/riscv-abi.pdf
> >
> > > +#. eBPF Machine Instantiation:
> > > +#. ABI-conforming system: A computer system that provides the binary sys- tem interface for application
> > > +   programs described in the System V ABI [SYSVABI]_.
> > > +#. ABI-conforming program: A program written to include only the system routines, commands, and other
> > > +   resources included in the ABI, and a program compiled into an executable file that has the formats
> > > +   and characteristics specified for such files in the ABI, and a program whose behavior complies with
> > > +   the rules given in the ABI [SYSVABI]_.
> > > +#. ABI-nonconforming program: A program which has been written to include system routines, commands, or
> > > +   other resources not included in the ABI, or a program which has been compiled into a format different
> > > +   from those specified in the ABI, or a program which does not behave as specified in the ABI [SYSVABI]_.
> > > +#. Undefined Behavior: Behavior that may vary from instance to instance or may change at some time in the future.
> > > +   Some undesirable programming practices are marked in the ABI as yielding undefined behavior [SYSVABI]_.
> > > +#. Unspecified Property: A property of an entity that is not explicitly included or referenced in this specification,
> > > +   and may change at some time in the future. In general, it is not good practice to make a program depend
> > > +   on an unspecified property [SYSVABI]_.
> > > +
> > > +Program Execution Environment
> > > +=============================
> > > +
> > > +A loaded eBPF program is executed on an eBPF machine. That machine, physical or virtual, runs in a freestanding
> > > +or hosted environment [#]_.
> > > +
> > > +eBPF Machine Freestanding Environment
> > > +-------------------------------------
> > > +
> > > +
> > > +eBPF Machine Hosted Environment
> > > +-------------------------------
> > > +
> > > +A loaded eBPF program can be attached to a BPF hook point in a BPF-enabled application
> > > +compatible with the attach type of its program type. When the BPF-enabled application's
> > > +execution reaches a BPF hook point to which an eBPF program is attached, that program
> > > +begins execution on the eBPF machine at its first instruction. The contents of eBPF machine's
> > > +registers and memory at the time it starts execution are defined by the eBPF program's
> > > +type and attach point.
> > > +
> > > +Processor Architecture
> > > +======================
> > > +
> > > +This section describes the processor architecture available
> > > +to programs. It also defines the reference language data types, giving the
> > > +foundation for system interface specifications [SYSVABI]_
> >
> > Why are we linking to the SYSVABI doc here?
> 
> A great question -- in most places where I have referenced that
> document it is akin to an academic reference -- I am attempting to
> give the user the idea that the language used is not my own completely
> original thought. I am attempting to tell the reader that this concept
> or language has precedent in another document. I am very new to the
> standards-writing process and realize that utilization of citations
> may not be "how it works". Please let me know how to proceed!

I'm not sure how it works either, so folks who have more IETF experience
-- please weigh in. In similar fashion to above, this feels like we're
implicitly taking these other documents as dependencies. We certainly
don't want to plagiarize anything, but tagging a reference here to
function similar to a citation seems confusing as well.

> >
> > > +
> > > +Registers
> > > +---------
> > > +
> > > +General Purpose Registers
> > > +^^^^^^^^^^^^^^^^^^^^^^^^^
> > > +eBPF has 11 64-bit wide registers, `r0` - `r10`. The contents of the registers
> > > +at the beginning of an eBPF program's execution depend on the program's type.
> >
> > We should probably also mention the 32 bit subregisters (they can only
> > be accessed through special ALU operations), and that they zero-extend
> > into 64 bit on writes.
> 
> I added a note on the subregisters. I decided to leave out the
> information about how they zero extend on writes. I thought that was
> something that should remain entirely within the scope of the ISA.
> Please let me know if I am wrong!

Sounds good

[...]

> > > +C Programming Language Support
> > > +==============================
> > > +
> > > +**NOTE** This section could be included in order to define the contents
> > > +of standardized processor-specific header files that would make it easier
> > > +for programmers to write programs.
> > > +
> > > +Notes
> > > +=====
> > > +.. [#] The eBPF machine does not need to be a physical instantiation of a processor. In fact, many instantiations of eBPF machines are virtual.
> > > +.. [#] See the [CSTD]_ for the inspiration for this distinction.
> > > +
> > > +References
> > > +==========
> > > +
> > > +.. [SYSVABI] System V Application Binary Interface - Edition 4.1. SCO Developer Specs. The Santa Cruz Operation. 1997. https://www.sco.com/developers/devspecs/gabi41.pdf
> > > +.. [POWERPCABI] Developing PowerPC Embedded Application Binary Interface (EABI) Compliant Programs. PowerPC Embedded Processors Application Note. IBM. 1998. http://class.ece.iastate.edu/arun/Cpre381_Sp06/lab/labw12a/eabi_app.pdf
> > > +.. [GOABI] Go internal ABI specification. Go Source Code. No authors. 2023. https://go.googlesource.com/go/+/refs/heads/master/src/cmd/compile/abi-internal.md
> > > +.. [JAVAABI] The Java (r) Language Specification - Java SE 7 Edition. Gosling, James et. al. Oracle. 2013. https://docs.oracle.com/javase/specs/jls/se7/html/index.html
> >
> > If we do share a link, it should probably be to the Java Virtual Machine
> > specification rather than the language specification. I believe the most
> > recent edition is 21.
> 
> I checked and the binary compatibility piece of the specification is
> actually in the language spec. That said, it might make sense to just
> link to both? I am willing to do whatever you suggest!

Ah, fair enough. Let's still link the latest version though rather than
version 7.

> > > +.. [DALVIKABI] Dalvik Bytecode. Android Core Runtime Documentation. No authors. Google. 2022. https://source.android.com/docs/core/runtime/dalvik-bytecode
> > > +.. [CLRABI] CLR ABI. The Book of the Runtime. No authors. Microsoft. 2023. https://github.com/dotnet/coreclr/blob/master/Documentation/botr/clr-abi.md.
> > > +.. [CSTD] International Standard: Programming Languages - C. ISO/IEC. 2018. https://www.open-std.org/jtc1/sc22/wg14/www/docs/n2310.pdf.
> > > +.. [RHELABI] Red Hat Enterprise Linux 8: Application Compatibility Guide. Red Hat. 2023. https://access.redhat.com/articles/rhel8-abi-compatibility
> > > +
> >
> > Everything else looks fine for now. Something I think we should figure
> > out though is what we want to put each of the following docs from the
> > charter:
> 
> I reflowed the entire document to make sure that the text is at most 80 columns.
> 
> 
> 
> >
> > - [I] one or more documents that recommend conventions and guidelines
> >   for producing portable BPF program binaries,
> >
> > - [I] an architecture and framework document.
> >
> > It seems like some of what's going into this document (e.g. formally
> > defining a "Program", data types, etc) could arguably belong in an
> > architecture and framework document. Honestly, I think it would probably
> > be easier and make more sense to just have a single monolithic BPF
> > Machine informational document, though I'm not sure if that's viable at
> > this point given that we specified different documents in the charter.
> 
> You make (as usual) an excellent point. I think that this question is
> something that would be good to discuss as a group? Because you are
> the chair, David, I will defer to you!

Discussing as a group is a great idea. Maybe this would be something to
discuss at IETF 118?

Thanks,
David

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

