Return-Path: <bpf+bounces-825-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4542707370
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 23:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AD991C20FF4
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 21:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B680D101FF;
	Wed, 17 May 2023 21:00:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7578633F6
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 21:00:42 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FCF421A
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 14:00:39 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 8F6FFC151B10
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 14:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1684357239; bh=yHsdLFtqjCeOsJ3UiN2iQM2u3rkNVZ/PaGnewtILPnM=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=qYJ3nWaXKucSVlJRtQtzO8naDPmTbi1MXXnqN59KS78U6fGL23Z++WxTgVnSDrnny
	 aaBJTW6Ddeao/PLbc8PRVQBgfTQfozyXsXaNyZ1yX37roou3pW8YiSxpg/NBllBua3
	 3W/zc6Ky1t2AsoVocUmZ4J+wrlu3FHdbi9khpmKw=
X-Mailbox-Line: From bpf-bounces@ietf.org  Wed May 17 14:00:39 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 3E9A2C151084;
	Wed, 17 May 2023 14:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1684357239; bh=yHsdLFtqjCeOsJ3UiN2iQM2u3rkNVZ/PaGnewtILPnM=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=qYJ3nWaXKucSVlJRtQtzO8naDPmTbi1MXXnqN59KS78U6fGL23Z++WxTgVnSDrnny
	 aaBJTW6Ddeao/PLbc8PRVQBgfTQfozyXsXaNyZ1yX37roou3pW8YiSxpg/NBllBua3
	 3W/zc6Ky1t2AsoVocUmZ4J+wrlu3FHdbi9khpmKw=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 98901C151084
 for <bpf@ietfa.amsl.com>; Wed, 17 May 2023 14:00:38 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -1.55
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aYWPwiDyvzlj for <bpf@ietfa.amsl.com>;
 Wed, 17 May 2023 14:00:34 -0700 (PDT)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com
 [209.85.222.182])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 4E9FAC14CE2C
 for <bpf@ietf.org>; Wed, 17 May 2023 14:00:34 -0700 (PDT)
Received: by mail-qk1-f182.google.com with SMTP id
 af79cd13be357-75774360e46so72756785a.2
 for <bpf@ietf.org>; Wed, 17 May 2023 14:00:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684357233; x=1686949233;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RjZCh3jOx6/vUU+IuShYs27mdSTdTlaUCtc19uXHsyE=;
 b=ZzgdBZecia8P5IhnFFO/KSzgBkgXJveqAWGUOeuzDZF4Lp4UiOMh1A6A7nC8vxqJy+
 Vzgn5AAh/8xYEumCipaz9Zm7XT+QKkUHrfZIWGg/2DNQWYlIcKlGXnsiUervJmxU++eW
 AyAJrwFUEgtn0AtUcDUuL0VvRz/7hX7mdALk0sPoBqDAtzXUYuzR4UzJQyfH4+g8vUR1
 WK9Jfdpy0CStUTfHGzcJBQAFN+yRqb0hEhJ5nb9pm//ypUCKnN316nYJtwzP8CuvwXCy
 4pKnbLam819QzYmI4ktoh4m+RZkV9oWGbnH8dX2FbV7+FG/TcCcpXl9YSB8YX6pPv24Q
 ESiA==
X-Gm-Message-State: AC+VfDwS3dfAD7A0Z4Q84J6Q1kfflqTka5BDSinY3WOez+d7s07PKXU3
 9xXvQj5uY5wUGUB4kRXJokrMHnzZuGfrxQ==
X-Google-Smtp-Source: ACHHUZ7wgIByK3036ylRbIh/8lpA2EVuIGG7JoP2J92QwSpyy2/Kh2EEK52yQNSHdOqTOPUV81Nb0w==
X-Received: by 2002:a05:6214:401d:b0:623:8ce1:6ccd with SMTP id
 kd29-20020a056214401d00b006238ce16ccdmr1647859qvb.14.1684357232413; 
 Wed, 17 May 2023 14:00:32 -0700 (PDT)
Received: from maniforge ([24.1.27.177]) by smtp.gmail.com with ESMTPSA id
 dp8-20020a05621409c800b005ef42af7eb7sm26461qvb.25.2023.05.17.14.00.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 14:00:31 -0700 (PDT)
Date: Wed, 17 May 2023 16:00:29 -0500
From: David Vernet <void@manifault.com>
To: Dave Thaler <dthaler@microsoft.com>
Cc: "Jose E. Marchesi" <jemarch@gnu.org>,
 Dave Thaler <dthaler=40microsoft.com@dmarc.ietf.org>,
 "bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>
Message-ID: <20230517210029.GB123984@maniforge>
References: <PH7PR21MB38780769D482CC5F83768D3CA37E9@PH7PR21MB3878.namprd21.prod.outlook.com>
 <87v8grkn67.fsf@gnu.org>
 <PH7PR21MB3878BCFA99C1585203982670A37E9@PH7PR21MB3878.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <PH7PR21MB3878BCFA99C1585203982670A37E9@PH7PR21MB3878.namprd21.prod.outlook.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/nqMhhQ8ecYN_eA3y-qAul4NsMZs>
Subject: Re: [Bpf] IETF BPF working group draft charter
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
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, May 17, 2023 at 06:19:42PM +0000, Dave Thaler wrote:
> Jose E. Marchesi wrote:
> > As I mentioned during your talk at LSF/MM/BPF, I think that two items may be
> > a bit confusing, and worth to clarify:
> >
> >   * the eBPF bindings for the ELF executable file format,
> >
> > What does "eBPF bindings" mean in this context?  I think there are at least two
> > possible interpretations:
> >
> > 1) The way BPF uses ELF, not impacting internal ELF structures.  For
> >    example the special section names that a conformant BPF loader
> >    expects and understands, such as ".probes", or rules on how to use
> >    the symbols visibility, or how notes are used (if they are used) etc
> >
> > 2) The ELF extensions that BPF introduces (and may introduce at some
> >    point) as an architecture, such as machine number, section types,
> >    special section indices, segment types, relocation types, symbol
> >    types, symbol bindings, additional section and segment flags, file
> >    flags, and perhaps structures of the contents of some special
> >    sections.
> 
> See https://www.ietf.org/archive/id/draft-thaler-bpf-elf-00.html
> It includes the values used in the ELF header, section naming,
> use of the "license" and "version" sections, meaning of "maps" and
> ".maps" sections, etc.

I have what may be a silly question: The document you linked specifies,

"This specification is a [sic] extension to the ELF file format as
specified in Chapter 4 of the System V Application Binary Interface
[ELF]."

What does it mean exactly for an IETF-published BPF ELF extension to be
an extension of a specification from a totally separate standards body
(in this case, the System V release 4 ABI / Tool Interface Standard
(TIS))? In other words, is it normal for extensions to be specified in
external / separate standards bodies from where the original
specification is defined? It seems like that could potentially result in
a confusing outcome if the original standards body could itself
eventually choose to publish its own extension which conflicts with the
IETF. That won't happen for Sys V of course, but in general it seems odd
for us to publish an extension for a specification that was defined in
the System V ABI instead of the IETF, and it seems like a situation for
which following the existing contours for x86_64, ARM, etc might make
sense.

> > If the intended meaning of that point in the draft is 1), then I would suggest to
> > change the wording to something like:
> >
> > * the requirements and expectations that ELF files shall fulfill so they
> >   can be handled by conformant eBPF implementations.
> 
> My own opinion is to leave the more detailed definition of what belongs
> in the ELF spec vs another document up to the WG to define rather than
> baking it into the charter.

I tend to agree, but that seems to suggest that we should remove this
line from the charter, and instead leave it up to the WG to determine if
it should be included:

* the eBPF bindings for the ELF executable file format,

Or is your point rather that the line in the charter as it exists now is
really saying that discussing ELF *in general* is in scope for the
working group, but that we may or may not end up actually producing a
document for it depending on how discussions go in the WG, and that if
we did produce a document, the scope would be decided by the WG?

More broadly, would you mind please clarifying exactly what this section
will imply for the WG (see below for more details on my question):

> The working group will produce one or more documents on the following
> work item topics:
>
> * The eBPF instruction set architecture (ISA) that defines the
>   instructions and low-level virtual machine for eBPF programs,
>
> * Verifier expectations and building blocks for allowing safe execution
>   of untrusted eBPF programs,
>
> * the BPF Type Format (BTF) that defines debug information and
>   introspection capabilities for eBPF programs,
>
> * the eBPF bindings for the ELF executable file format,
>
> * the platform support ABI, including calling convention, linker
>   requirements, and relocations,
>
> * Cross-platform map types allowing native data structure access from
>   eBPF programs,
>
> * Cross-platform helper functions, such as for manipulation of maps,
>
> * Cross-platform eBPF program types that define the higher level
>   execution environment for eBPF programs,
>
> * and an architecture and framework informational document.

As far as I understand, if a topic is missing from this section, it
doesn't automatically mean that it's out of scope for the WG to produce
a document for it. If that's the case, and part of the job of the WG
will be to specify what is actually in scope regardless of what's
enumerated here, I'm not quite following why this section is necessary
beyond providing the reader with some informal context on what BPF is in
general.

Thanks in advance for explaining these concepts to an IETF noobie.

> > Otherwise, if the intended meaning in the draft charter is to cover 2), I would
> > like to note that, usually and conventionally ELF extensions introduced by
> > architectures (and operating systems in the ELF sense)
> > are:
> >
> > - Part of the psABI (chapter Object Files).
> >
> > - Not standards, in the sense that these are not handled by
> >   standardization bodies.
> >
> > - Maintained by corporations, associations, and/or community groups, and
> >   published in one form or another.  A few examples of both arch and os
> >   extensions:
> >
> >   + The x86_64 psABI, including the ELF bits, is maintained by Intel
> >     (mainly by HJ Lu, a toolchain hacker) and available in a git repo in
> >     gitlab [1].
> >
> >   + The risc-v psABI, including the ELF bits, is maintained by I believe
> >     RISC-V International and the community, and is available in a git
> >     repo in github [2].
> >
> >   + The GNU extensions to the gABI, including the ELF bits, is
> >     maintained by GNU hackers and available in a git repo in sourceware
> >     [3].
> >
> >   + The llvm extensions to ELF, which in this case take the form of an
> >     "os" in the ELF sense even if it is not an operating system, are
> >     maintained by the LLVM project and available in the
> >     docs/Extensions.rst file in the llvm source distribution.
> >
> >   Note that more often than not this is kept quite informally, without
> >   the need of much bureocratic overhead.  A git repo in github or the
> >   like, maintained by the eBPF foundation or similar, would be more than
> >   enough IMO.
> 
> To ensure interoperability, I'd want a slightly more formal specification.

I understand the desire and need for ensuring interoperability, but if
specifying a BPF ELF extension would be the exception to the rule for
the entirety of the rest of the industry when it comes to ELF, I think
we should consider also being explicit about what's different for BPF.

> > - Open to suggestions and contributions from the community, vendors,
> >   implementors, etc.  This usually involves having a mailing list where
> >   such suggestions can be sent an discussed.  Almost always very little
> >   discussion is required, if any, because the proposed extension has
> >   already been agreed and worked on by the involved parties: toolchains,
> >   consumers, etc.
> >
> > - Continuously evolving.
> >
> > So, would the IETF working group be able to accomodate something like the
> > above?  For example, once a document is officially published by the working
> > group, how easy is it to modify it and make a new version to incorporate
> > something new, like a new relocation type for example?
> > (Apologies for my total ignorance of IETF business :/)
> 
> There's 3 ways:
> 1) The IETF can publish an extension spec with additional optional features.
> 2) The IETF can publish a replacement to the original (not usually desirable)
> 3) The IETF can define a process for other organizations or vendors to create
> their own extensions, and some mechanism for ensuring that two such
> extensions don't collide using the same codepoint.  This is what the charter
> implies the WG should do.

This certainly seems useful, but it also feels like ELF is kind of a
special case here given that it was originally published as part of Sys
V, and there are no formally specified extensions for other much larger
architectures. I may be missing a lot of context here, so thanks in
advance again for filling in any gaps.

- David

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

