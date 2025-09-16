Return-Path: <bpf+bounces-68463-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C16B58B9D
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 04:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D74A2A572E
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 02:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7859C237707;
	Tue, 16 Sep 2025 02:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cPXbjNqF"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE542DC765
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 02:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757988056; cv=none; b=tfDlmStJjfU3KiU/K8xY7VFwvfG4sEFhIOhVGBUX7cYy5BZuG8i4bEcOxQmEJ9hFkMCQVoonpwygqxDyauUfjxv8OJo6TlVIZk0z4ed0l2X/VCr/lLnyNRat7pDhVGAHK+GHlBOp24vTYWEGQHkvwWUwSoqU5/g7+soeIO4fRpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757988056; c=relaxed/simple;
	bh=4fDcBBSwlBF7I1XG/e+3AQYq6uDGoN/T1C2M5cREfaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lWba/taWow/abWmpeHq6gTeWjokG7ARw3clTQu5x+IMwQwC2pEbHEml+UqlJrSHjSnOnxEHrUVl9G+a2sYQXGcd2QOFSP+vv2Qi5dmItHEV3LojquV+gEMAOCd6v2j7OBTyZv190Q5Dm+VxxxONNYFYQZIK0cA0HuGhAfPCEzuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cPXbjNqF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757988053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WwqbLInQdz0fKSQmRZaRxVV1ZbHPOkGiP0FD5KSvWWg=;
	b=cPXbjNqFt1j3Sq09vtpdCT9CZlZ+FcuftEAa2qnykMkLEa3MixjGpAgdMYh6/OybsXFd+9
	5MXCFgUBa24xWWQWWP5imWkkpKCIXCqzaxrdPRSlEpx60KrAf4ACC0bVSOgvQXSxoCjOZs
	giIHh6rYiC6ie98wZ29rglxIT9Jmj68=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-499-wIFjot3BNi-oDrNE6YorJA-1; Mon,
 15 Sep 2025 22:00:49 -0400
X-MC-Unique: wIFjot3BNi-oDrNE6YorJA-1
X-Mimecast-MFC-AGG-ID: wIFjot3BNi-oDrNE6YorJA_1757988047
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C6C961800576;
	Tue, 16 Sep 2025 02:00:46 +0000 (UTC)
Received: from localhost (unknown [10.72.112.143])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D74C11954126;
	Tue, 16 Sep 2025 02:00:43 +0000 (UTC)
Date: Tue, 16 Sep 2025 10:00:41 +0800
From: Pingfan Liu <piliu@redhat.com>
To: Philipp Rudo <prudo@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Simon Horman <horms@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Viktor Malik <vmalik@redhat.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>, Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	kexec@lists.infradead.org, bpf@vger.kernel.org,
	systemd-devel@lists.freedesktop.org
Subject: Re: [PATCHv5 00/12] kexec: Use BPF lskel to enable kexec to load PE
 format boot image
Message-ID: <aMjEyfrNSuA3IBR7@fedora>
References: <20250819012428.6217-1-piliu@redhat.com>
 <20250901162929.11af536d@rotkaeppchen>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901162929.11af536d@rotkaeppchen>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Mon, Sep 01, 2025 at 04:29:29PM +0200, Philipp Rudo wrote:
Hi Philipp,

Thank you for deep insight, please see the comments

> Hi Pingfan,
> 
> thanks for sharing the updated version of the series. There are a few
> small nits you can find in my comments to the individual patches.
> 
> I also took an other look at the bigger picture. The way I see it the
> series contains two major changes.
> 
> 1. A generic mechanism to parse and run bpf programs during kexec.

Thanks for your suggestion. This makes the whole design look more
natural. Without it, using the PE format parser as a frontend to the
image parser looks a bit awkward.

> 2. A new loader for UEFI Applications building up on 1.
> 
> Both those changes are currently smashed together as "PE image loader",
> which IMHO is quite confusing. It's correct that UEFI Apps are PE
> files. But the PE format is also used in many other ways and in the end
> we are only interested in this specific use case. Plus the generic
> mechanism to parse and run bpf programs during kexec can also be used
> with any other file format, not just PE.
> 
> In addition I noticed that hooking into kexec_file while loading the
> image is too late. The problem is that in
> kernel/kexec_file.c:kimage_file_prepare_segments the cmdline is
> measured for IMA before the image is loaded. But we allow the
> bpf_prog to change the cmdline. When that is done the IMA measurement
> no longer is correct. So we need a new hook to run the bpf programs
> after the initrd and cmdline were read but before the IMA measurement is
> done.
> 

This should be a issue when turning on IMA measurement on cmdline. And it
can be perfectly addressed with your suggestion.

> So my suggestions are:
> 
> 1. Extend the kexec_file_ops by a new 'get_bpf_prog' hook.

I'm not sure I agree with you on this.  We both agree that the generic
mechanism to parse and run BPF programs should be independent of the
image parser and belong in kexec_file.c. However, kexec_file_ops is
still a concept that belongs to the image parser layer. So I think that
moving the logic to kexec_file.c is good enough.


> 2. Move the mechanism to run bpf progs from kexec_pe_image.c to
>    kexec_file.c (with the new hook in the file_ops there shouldn't be
>    any problems).

Yes, the logic of loading and runing bpf progs should be placed in
kexec_file.c.

> 3. Rename CONFIG_KEXEC_PE_IMAGE to CONFIG_KEXEC_BPF

OK.

> 4. Rename kexec_pe_image.c (and the functions within) to
>    kexec_uefi_app.c 
> 

OK.

Thanks for your careful review and good suggestion.


Best Regards,

Pingfan

> Thanks
> Philipp
> 
> On Tue, 19 Aug 2025 09:24:16 +0800
> Pingfan Liu <piliu@redhat.com> wrote:
> 
> > Cc systemd-devel@lists.freedesktop.org so any UKI expert can comment
> > 
> > *** Review the history ***
> > 
> > Nowadays UEFI PE bootable image is more and more popular on the distribution.
> > But it is still an open issue to load that kind of image by kexec with IMA enabled
> > 
> > There are several approaches to reslove this issue, but none of them are
> > accepted in upstream till now.
> > 
> > The summary of those approaches:
> >   -1. UEFI service emulator for UEFI stub
> >   -2. PE format parser in kernel
> > 
> > For the first one, I have tried a purgatory-style emulator [1]. But it
> > confronts the hardware scaling trouble.  For the second one, there are two
> > choices, one is to implement it inside the kernel, the other is inside the user
> > space.  Both zboot-format [2] and UKI-format [3] parsers are rejected due to
> > the concern that the variant format parsers will inflate the kernel code.  And
> > finally, we have these kinds of parsers in the user space 'kexec-tools'.
> > 
> > 
> > *** The approach in this series ***
> > 
> > This approach allows the various PE boot image to be parsed in the bpf-prog,
> > as a result, the kexec kernel code to remain relatively stable.
> > 
> > Benefits
> > And it abstracts architecture independent part and 
> > the API is limitted 
> > 
> > To protect against malicious attacks on the BPF loader in user space, it
> > employs BPF lskel to load and execute BPF programs from within the
> > kernel.
> > 
> > Each type of PE image contains a dedicated section '.bpf', which stores
> > the bpf-prog designed to parse the format.  This ensures that the PE's
> > signature also protects the integrity of the '.bpf' section.
> > 
> > 
> > The parsing process operates as a pipeline. The current BPF program
> > parser attaches to bpf_handle_pefile() and detaches at the end of the
> > current stage via disarm_bpf_prog(). The results parsed by the current
> > BPF program are buffered in the kernel through prepare_nested_pe() and
> > then delivered to the next stage. For each stage of the pipeline, the
> > BPF bytecode is stored in the '.bpf' section of the PE file. That means
> > a vmlinuz.efi embeded in UKI format can be handled.
> > 
> > 
> > Special thanks to Philipp Rudo, who spent significant time evaluating
> > the practicality of my solution, and to Viktor Malik, who guided me
> > toward using BPF light skeleton to prevent malicious attacks from user
> > space.
> > 
> > *** Test result ***
> > Configured with RHEL kernel debug file, which turns on most of locking,
> > memory debug option, I have not seen any warning or bug for 1000 times.
> > 
> > Test approach:
> > -1. compile kernel
> > -2. get the zboot image with bpf-prog by 'make -C tools/kexec zboot'
> > -3. compile kexec-tools from https://github.com/pfliu/kexec-tools/pull/new/pe_bpf
> > 
> > The rest process is the common convention to use kexec.
> > 
> > 
> > [1]: https://lore.kernel.org/lkml/20240819145417.23367-1-piliu@redhat.com/T/
> > [2]: https://lore.kernel.org/kexec/20230306030305.15595-1-kernelfans@gmail.com/
> > [3]: https://lore.kernel.org/lkml/20230911052535.335770-1-kernel@jfarr.cc/
> > [4]: https://lore.kernel.org/linux-arm-kernel/20230921133703.39042-2-kernelfans@gmail.com/T/
> > 
> > v4 -> v5
> >   - rebased onto Linux 6.17-rc2
> >   - [1/12], use a separate CONFIG_KEEP_COMPRESSOR to decide the section
> >     of decompressor method
> >   - [10/12], add Catalin's acked-by (Thanks Catalin!)
> > 
> > v3 -> v4
> >   - Use dynamic allocator in decompression ([4/12])
> >   - Fix issue caused by Identical Code Folding ([5/12])
> >   - Integrate the image generator tool in the kernel tree ([11,12/12])
> >   - Address the issue according to Philipp's comments in v3 reviewing.
> >     Thanks Philipp!
> > 
> > RFCv2 -> v3
> >   - move the introduced bpf kfuncs to kernel/bpf/* and mark them sleepable
> >   - use listener and publisher model to implement bpf_copy_to_kernel()
> >   - keep each introduced kfunc under the control of memcg
> > 
> > RFCv1 -> RFCv2
> >   - Use bpf kfunc instead of helper
> >   - Use C source code to generate the light skeleton file
> > 
> > 
> > *** BLURB HERE ***
> > 
> > Pingfan Liu (12):
> >   kexec_file: Make kexec_image_load_default global visible
> >   lib/decompress: Keep decompressor when CONFIG_KEEP_COMPRESSOR
> >   bpf: Introduce bpf_copy_to_kernel() to buffer the content from bpf-prog
> >   bpf: Introduce decompressor kfunc
> >   kexec: Introduce kexec_pe_image to parse and load PE file
> >   kexec: Integrate with the introduced bpf kfuncs
> >   kexec: Introduce a bpf-prog lskel to parse PE file
> >   kexec: Factor out routine to find a symbol in ELF
> >   kexec: Integrate bpf light skeleton to load zboot image
> >   arm64/kexec: Add PE image format support
> >   tools/kexec: Introduce a bpf-prog to parse zboot image format
> >   tools/kexec: Add a zboot image building tool
> > 
> >  arch/arm64/Kconfig                           |   1 +
> >  arch/arm64/include/asm/kexec.h               |   1 +
> >  arch/arm64/kernel/machine_kexec_file.c       |   3 +
> >  include/linux/bpf.h                          |  42 ++
> >  include/linux/decompress/mm.h                |   7 +
> >  include/linux/kexec.h                        |  10 +
> >  kernel/Kconfig.kexec                         |   9 +
> >  kernel/Makefile                              |   2 +
> >  kernel/bpf/Makefile                          |   3 +
> >  kernel/bpf/helpers.c                         | 230 +++++++++
> >  kernel/bpf/helpers_carrier.c                 | 215 +++++++++
> >  kernel/kexec_bpf/Makefile                    |  71 +++
> >  kernel/kexec_bpf/kexec_pe_parser_bpf.c       |  67 +++
> >  kernel/kexec_bpf/kexec_pe_parser_bpf.lskel.h | 147 ++++++
> >  kernel/kexec_file.c                          |  88 ++--
> >  kernel/kexec_pe_image.c                      | 463 +++++++++++++++++++
> >  lib/Kconfig                                  |   3 +
> >  lib/decompress.c                             |   6 +-
> >  tools/kexec/Makefile                         |  90 ++++
> >  tools/kexec/pe.h                             | 177 +++++++
> >  tools/kexec/zboot_image_builder.c            | 280 +++++++++++
> >  tools/kexec/zboot_parser_bpf.c               | 158 +++++++
> >  22 files changed, 2029 insertions(+), 44 deletions(-)
> >  create mode 100644 kernel/bpf/helpers_carrier.c
> >  create mode 100644 kernel/kexec_bpf/Makefile
> >  create mode 100644 kernel/kexec_bpf/kexec_pe_parser_bpf.c
> >  create mode 100644 kernel/kexec_bpf/kexec_pe_parser_bpf.lskel.h
> >  create mode 100644 kernel/kexec_pe_image.c
> >  create mode 100644 tools/kexec/Makefile
> >  create mode 100644 tools/kexec/pe.h
> >  create mode 100644 tools/kexec/zboot_image_builder.c
> >  create mode 100644 tools/kexec/zboot_parser_bpf.c
> > 
> > 
> > base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
> 


