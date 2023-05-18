Return-Path: <bpf+bounces-884-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BBB708705
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 19:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 821F61C2117B
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 17:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F9B27213;
	Thu, 18 May 2023 17:34:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18ED9182B8
	for <bpf@vger.kernel.org>; Thu, 18 May 2023 17:34:27 +0000 (UTC)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F3810F5
	for <bpf@vger.kernel.org>; Thu, 18 May 2023 10:34:06 -0700 (PDT)
Received: from fencepost.gnu.org ([2001:470:142:3::e])
	by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <jemarch@gnu.org>)
	id 1pzhVr-0005R2-Ma; Thu, 18 May 2023 13:34:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
	s=fencepost-gnu-org; h=MIME-Version:Date:References:In-Reply-To:Subject:To:
	From; bh=dsmDeFV9e//yAJc7sqUeuxxVSa10ea9R08z+fNh3wQY=; b=hX42UAmF+EOo1hVZjytG
	IctNkZmNGMZNEFL34AZO/iSdOU/8c2jmbENKP5uT+VfcS8DhK4hKVI96/ks0d7+WH7HpEFQoPa5+y
	Fl83w0LvGdGxxZKY36//qX9a/P3tZflFuh1l9ujTe8+xW4eYPQeFnWCurftLUxmSc6pavAPV135qH
	oknCSO1qe46XMIrv0Qobf0t4mCkzypx8Jf3HOpoSfcN+1qsGtfra3NTeSEvy9Tpi2QGBVimIE7UnI
	qkuS074WIw+P6TYty2cDVeRccdGOxSuqVvBoJoalGiulu4AbeAnm5lZBvzmRovQcyxgw5Rl+8U8Zd
	j8DMGrL6GqToeg==;
Received: from [141.143.193.68] (helo=termi)
	by fencepost.gnu.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <jemarch@gnu.org>)
	id 1pzhVj-0007tv-1f; Thu, 18 May 2023 13:34:03 -0400
From: "Jose E. Marchesi" <jemarch@gnu.org>
To: Dave Thaler <dthaler=40microsoft.com@dmarc.ietf.org>
Cc: "bpf@ietf.org" <bpf@ietf.org>,  bpf <bpf@vger.kernel.org>
Subject: Re: [Bpf] IETF BPF working group draft charter
In-Reply-To: <PH7PR21MB3878BCFA99C1585203982670A37E9@PH7PR21MB3878.namprd21.prod.outlook.com>
	(Dave Thaler's message of "Wed, 17 May 2023 18:19:42 +0000")
References: <PH7PR21MB38780769D482CC5F83768D3CA37E9@PH7PR21MB3878.namprd21.prod.outlook.com>
	<87v8grkn67.fsf@gnu.org>
	<PH7PR21MB3878BCFA99C1585203982670A37E9@PH7PR21MB3878.namprd21.prod.outlook.com>
Date: Thu, 18 May 2023 19:33:35 +0200
Message-ID: <87r0rdy26o.fsf@gnu.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


Hi Dave.

> Jose E. Marchesi wrote:
>> As I mentioned during your talk at LSF/MM/BPF, I think that two items may be
>> a bit confusing, and worth to clarify:
>>
>>   * the eBPF bindings for the ELF executable file format,
>>
>> What does "eBPF bindings" mean in this context?  I think there are at least two
>> possible interpretations:
>>
>> 1) The way BPF uses ELF, not impacting internal ELF structures.  For
>>    example the special section names that a conformant BPF loader
>>    expects and understands, such as ".probes", or rules on how to use
>>    the symbols visibility, or how notes are used (if they are used) etc
>>
>> 2) The ELF extensions that BPF introduces (and may introduce at some
>>    point) as an architecture, such as machine number, section types,
>>    special section indices, segment types, relocation types, symbol
>>    types, symbol bindings, additional section and segment flags, file
>>    flags, and perhaps structures of the contents of some special
>>    sections.
>
> See https://www.ietf.org/archive/id/draft-thaler-bpf-elf-00.html
> It includes the values used in the ELF header, section naming,
> use of the "license" and "version" sections, meaning of "maps" and
> ".maps" sections, etc.

Right, so it is 2).  You intend to actually standardize the ELF
extensions.

>> If the intended meaning of that point in the draft is 1), then I would suggest to
>> change the wording to something like:
>>
>> * the requirements and expectations that ELF files shall fulfill so they
>>   can be handled by conformant eBPF implementations.
>
> My own opinion is to leave the more detailed definition of what belongs
> in the ELF spec vs another document up to the WG to define rather than
> baking it into the charter.

Sure, that suggestion was provided in case your intention was 1), not 2)
:)

>> Otherwise, if the intended meaning in the draft charter is to cover 2), I would
>> like to note that, usually and conventionally ELF extensions introduced by
>> architectures (and operating systems in the ELF sense)
>> are:
>>
>> - Part of the psABI (chapter Object Files).
>>
>> - Not standards, in the sense that these are not handled by
>>   standardization bodies.
>>
>> - Maintained by corporations, associations, and/or community groups, and
>>   published in one form or another.  A few examples of both arch and os
>>   extensions:
>>
>>   + The x86_64 psABI, including the ELF bits, is maintained by Intel
>>     (mainly by HJ Lu, a toolchain hacker) and available in a git repo in
>>     gitlab [1].
>>
>>   + The risc-v psABI, including the ELF bits, is maintained by I believe
>>     RISC-V International and the community, and is available in a git
>>     repo in github [2].
>>
>>   + The GNU extensions to the gABI, including the ELF bits, is
>>     maintained by GNU hackers and available in a git repo in sourceware
>>     [3].
>>
>>   + The llvm extensions to ELF, which in this case take the form of an
>>     "os" in the ELF sense even if it is not an operating system, are
>>     maintained by the LLVM project and available in the
>>     docs/Extensions.rst file in the llvm source distribution.
>>
>>   Note that more often than not this is kept quite informally, without
>>   the need of much bureocratic overhead.  A git repo in github or the
>>   like, maintained by the eBPF foundation or similar, would be more than
>>   enough IMO.
>
> To ensure interoperability, I'd want a slightly more formal specification.

I would think that the way the x86_64, aarch64, risc-v, sparc, mips,
powerpc architectures, along with their variants, handle their ELF
extensions and psABI, ensures interoperability good enough for the
problem at hand, but ok.  I'm definitely not an expert in these matters.

>> - Open to suggestions and contributions from the community, vendors,
>>   implementors, etc.  This usually involves having a mailing list where
>>   such suggestions can be sent an discussed.  Almost always very little
>>   discussion is required, if any, because the proposed extension has
>>   already been agreed and worked on by the involved parties: toolchains,
>>   consumers, etc.
>>
>> - Continuously evolving.
>>
>> So, would the IETF working group be able to accomodate something like the
>> above?  For example, once a document is officially published by the working
>> group, how easy is it to modify it and make a new version to incorporate
>> something new, like a new relocation type for example?
>> (Apologies for my total ignorance of IETF business :/)
>
> There's 3 ways:
> 1) The IETF can publish an extension spec with additional optional
> features.

I don't think adding new relocation type, as an example of the kind of
changes that ABIs regularly are subjected to, qualify as "additional
optional features".

> 2) The IETF can publish a replacement to the original (not usually
> desirable)

You _will_ need to update that particular document, and probably quite
often.

  jemarch@termi:~/gnu/src/x86-64-ABI$ git log --oneline --since="May 18 2022"
  b96eaf2 (HEAD -> master, origin/master, origin/HEAD) Remove MPX support
  ab1bd26 _BitInt: Update alignment of _BitInt(N) for N > 64
  43453ea Clarify R_X86_64_REX_GOTPCRELX transformation
  e2387f1 Add link to download latest PDF
  b5443bf Fix typo in footnote stating incorrect register range for AVX512
  8195730 Add optional __bf16 support
  6c2ac6c ABI: Fix typos
  8ca4539 Add _BitInt(N) from ISO/IEC WG14 N2763

That is for a very well consolidated and stable architecture such as
x86_64.  Now imagine what will happen with something like BPF that is
still in the process of figuring out its own ABI and the way it gets
compiled.

Being very optimistic, would it be OK for IETF and the WG to release,
say ten new versions of the "original" per year?

> 3) The IETF can define a process for other organizations or vendors to
> create their own extensions, and some mechanism for ensuring that two
> such extensions don't collide using the same codepoint.  This is what
> the charter implies the WG should do.

What is the precise license under which the document describing the ELF
extensions and the ABI will be distributed?

In particular, does it allow distributing modified versions?
Thanks for the info!

> Dave
>
>> Likewise, of the following item:
>>
>>   * the platform support ABI, including calling convention, linker
>>     requirements, and relocations,
>>
>> The calling convention and relocations are part of the psABI and usually
>> handled like described above.
>>
>> PS: BPF is obviously not a SysV system, but when it comes to document
>>     the ABI, including the ELF bits, I think it would be a good idea to
>>     use the same document structure conventionally used by psABI, as
>>     Alexei already suggested some time ago.  This would be most familiar
>>     to people.
>>
>> [1]
>> https://gitlab/.
>> com%2Fx86-psABIs%2Fx86-64-
>> ABI&data=05%7C01%7Cdthaler%40microsoft.com%7Cd4f2ef78d9e0475f514d
>> 08db56e91312%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C6381
>> 99331900533629%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiL
>> CJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000%7C%7C%7C&sd
>> ata=SaprU2J9WsyJ5qhcxIGKO2F06YtO%2Bm1Gpjb2SIOApLA%3D&reserved=0
>> [2]
>> https://github/
>> .com%2Friscv-non-isa%2Friscv-elf-psabi-
>> doc%2Freleases%2Fdownload%2Fv1.0%2Friscv-
>> abi.pdf&data=05%7C01%7Cdthaler%40microsoft.com%7Cd4f2ef78d9e0475f5
>> 14d08db56e91312%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C6
>> 38199331900533629%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD
>> AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000%7C%7C%7C
>> &sdata=uKqnU93kcu8rZ9Y0gzWdmuHnK9ySPM847%2FDMm6vJNwQ%3D&res
>> erved=0
>> [3] git://sourceware.org/git/gnu-gabi.git
>>
>> --
>> Bpf mailing list
>> Bpf@ietf.org
>> https://www.i/
>> etf.org%2Fmailman%2Flistinfo%2Fbpf&data=05%7C01%7Cdthaler%40microso
>> ft.com%7Cd4f2ef78d9e0475f514d08db56e91312%7C72f988bf86f141af91ab2
>> d7cd011db47%7C1%7C0%7C638199331900533629%7CUnknown%7CTWFpb
>> GZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6
>> Mn0%3D%7C2000%7C%7C%7C&sdata=W9FXcUwb181VQ6ksF2guASQ5FGtTE
>> KZuE0Yb8cHR9vI%3D&reserved=0

