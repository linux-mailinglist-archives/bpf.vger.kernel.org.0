Return-Path: <bpf+bounces-67114-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D8EB3E72A
	for <lists+bpf@lfdr.de>; Mon,  1 Sep 2025 16:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B9A03B4CFE
	for <lists+bpf@lfdr.de>; Mon,  1 Sep 2025 14:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB0D34165A;
	Mon,  1 Sep 2025 14:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BpWB5EC9"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE61340DB9
	for <bpf@vger.kernel.org>; Mon,  1 Sep 2025 14:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756736992; cv=none; b=ceGwdlHK2iUtnsmS3OMzSSkfDnM6a4ruLh2y4Zl8nsyp+ZCw2sm5akNVKiy5PRE1GQFdzhThoy6bk/0uqoiaOR5yoPy1Yhka2kHlmKW4RAoP1VKGoe4ZewBhDh44yoJjoB9TOEsIzGc9YGQeYWjlKpb3xiYJv8GhEGPvHFnf0k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756736992; c=relaxed/simple;
	bh=F/ICVVOMZOE2uGfoyoPpGlDrf+PF7qkjUZ+ApYZfhFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qEmcWiLhIKWGk3Ku60WqAoCWtkXtMa+KGBwTW+qVw+HenDOYHKm1ptKs33rEjv9L+CPcvTqqL7Jaq6Hwy/eEse2l0iupx3H7gr3ltVQ8IpxfGsqPZ3KD7nGhoVj4y5UbHTI4/WSGli+G4sHuz7bR/cWe2NVyc1GRJnSqafjtF10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BpWB5EC9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756736989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RMQsvqXERai7ADSHXhVpcHJWe1rXZbqsRy0bDPfOKgQ=;
	b=BpWB5EC93avtjaf+mP4TiEV6Q0KsHYtYzFZXbCVyMXCGyOwrcpkwJMyNyhu6YGWlldvpj0
	RcOkrIfxxL76lwxSrtarqpzm8CPVIdQ5k1OnfHcRzu370Xi6j6Wp5cXOFtCvUIMXzPNEhh
	Jx2sugFmX0TABhgbCs6QQXur6VDzgDY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-o1QChgmVMoiD5O_FDYN4lw-1; Mon,
 01 Sep 2025 10:29:46 -0400
X-MC-Unique: o1QChgmVMoiD5O_FDYN4lw-1
X-Mimecast-MFC-AGG-ID: o1QChgmVMoiD5O_FDYN4lw_1756736984
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1D8751956086;
	Mon,  1 Sep 2025 14:29:43 +0000 (UTC)
Received: from rotkaeppchen (unknown [10.45.224.104])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D69CD180047F;
	Mon,  1 Sep 2025 14:29:33 +0000 (UTC)
Date: Mon, 1 Sep 2025 16:29:29 +0200
From: Philipp Rudo <prudo@redhat.com>
To: Pingfan Liu <piliu@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong
 Song <yonghong.song@linux.dev>, Jeremy Linton <jeremy.linton@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Simon Horman <horms@kernel.org>, Gerd
 Hoffmann <kraxel@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Viktor Malik <vmalik@redhat.com>, Jan Hendrik Farr <kernel@jfarr.cc>,
 Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, Andrew Morton
 <akpm@linux-foundation.org>, kexec@lists.infradead.org,
 bpf@vger.kernel.org, systemd-devel@lists.freedesktop.org
Subject: Re: [PATCHv5 00/12] kexec: Use BPF lskel to enable kexec to load PE
 format boot image
Message-ID: <20250901162929.11af536d@rotkaeppchen>
In-Reply-To: <20250819012428.6217-1-piliu@redhat.com>
References: <20250819012428.6217-1-piliu@redhat.com>
Organization: Red Hat inc.
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hi Pingfan,

thanks for sharing the updated version of the series. There are a few
small nits you can find in my comments to the individual patches.

I also took an other look at the bigger picture. The way I see it the
series contains two major changes.

1. A generic mechanism to parse and run bpf programs during kexec.
2. A new loader for UEFI Applications building up on 1.

Both those changes are currently smashed together as "PE image loader",
which IMHO is quite confusing. It's correct that UEFI Apps are PE
files. But the PE format is also used in many other ways and in the end
we are only interested in this specific use case. Plus the generic
mechanism to parse and run bpf programs during kexec can also be used
with any other file format, not just PE.

In addition I noticed that hooking into kexec_file while loading the
image is too late. The problem is that in
kernel/kexec_file.c:kimage_file_prepare_segments the cmdline is
measured for IMA before the image is loaded. But we allow the
bpf_prog to change the cmdline. When that is done the IMA measurement
no longer is correct. So we need a new hook to run the bpf programs
after the initrd and cmdline were read but before the IMA measurement is
done.

So my suggestions are:

1. Extend the kexec_file_ops by a new 'get_bpf_prog' hook.
2. Move the mechanism to run bpf progs from kexec_pe_image.c to
   kexec_file.c (with the new hook in the file_ops there shouldn't be
   any problems).
3. Rename CONFIG_KEXEC_PE_IMAGE to CONFIG_KEXEC_BPF
4. Rename kexec_pe_image.c (and the functions within) to
   kexec_uefi_app.c 

Thanks
Philipp

On Tue, 19 Aug 2025 09:24:16 +0800
Pingfan Liu <piliu@redhat.com> wrote:

> Cc systemd-devel@lists.freedesktop.org so any UKI expert can comment
> 
> *** Review the history ***
> 
> Nowadays UEFI PE bootable image is more and more popular on the distribution.
> But it is still an open issue to load that kind of image by kexec with IMA enabled
> 
> There are several approaches to reslove this issue, but none of them are
> accepted in upstream till now.
> 
> The summary of those approaches:
>   -1. UEFI service emulator for UEFI stub
>   -2. PE format parser in kernel
> 
> For the first one, I have tried a purgatory-style emulator [1]. But it
> confronts the hardware scaling trouble.  For the second one, there are two
> choices, one is to implement it inside the kernel, the other is inside the user
> space.  Both zboot-format [2] and UKI-format [3] parsers are rejected due to
> the concern that the variant format parsers will inflate the kernel code.  And
> finally, we have these kinds of parsers in the user space 'kexec-tools'.
> 
> 
> *** The approach in this series ***
> 
> This approach allows the various PE boot image to be parsed in the bpf-prog,
> as a result, the kexec kernel code to remain relatively stable.
> 
> Benefits
> And it abstracts architecture independent part and 
> the API is limitted 
> 
> To protect against malicious attacks on the BPF loader in user space, it
> employs BPF lskel to load and execute BPF programs from within the
> kernel.
> 
> Each type of PE image contains a dedicated section '.bpf', which stores
> the bpf-prog designed to parse the format.  This ensures that the PE's
> signature also protects the integrity of the '.bpf' section.
> 
> 
> The parsing process operates as a pipeline. The current BPF program
> parser attaches to bpf_handle_pefile() and detaches at the end of the
> current stage via disarm_bpf_prog(). The results parsed by the current
> BPF program are buffered in the kernel through prepare_nested_pe() and
> then delivered to the next stage. For each stage of the pipeline, the
> BPF bytecode is stored in the '.bpf' section of the PE file. That means
> a vmlinuz.efi embeded in UKI format can be handled.
> 
> 
> Special thanks to Philipp Rudo, who spent significant time evaluating
> the practicality of my solution, and to Viktor Malik, who guided me
> toward using BPF light skeleton to prevent malicious attacks from user
> space.
> 
> *** Test result ***
> Configured with RHEL kernel debug file, which turns on most of locking,
> memory debug option, I have not seen any warning or bug for 1000 times.
> 
> Test approach:
> -1. compile kernel
> -2. get the zboot image with bpf-prog by 'make -C tools/kexec zboot'
> -3. compile kexec-tools from https://github.com/pfliu/kexec-tools/pull/new/pe_bpf
> 
> The rest process is the common convention to use kexec.
> 
> 
> [1]: https://lore.kernel.org/lkml/20240819145417.23367-1-piliu@redhat.com/T/
> [2]: https://lore.kernel.org/kexec/20230306030305.15595-1-kernelfans@gmail.com/
> [3]: https://lore.kernel.org/lkml/20230911052535.335770-1-kernel@jfarr.cc/
> [4]: https://lore.kernel.org/linux-arm-kernel/20230921133703.39042-2-kernelfans@gmail.com/T/
> 
> v4 -> v5
>   - rebased onto Linux 6.17-rc2
>   - [1/12], use a separate CONFIG_KEEP_COMPRESSOR to decide the section
>     of decompressor method
>   - [10/12], add Catalin's acked-by (Thanks Catalin!)
> 
> v3 -> v4
>   - Use dynamic allocator in decompression ([4/12])
>   - Fix issue caused by Identical Code Folding ([5/12])
>   - Integrate the image generator tool in the kernel tree ([11,12/12])
>   - Address the issue according to Philipp's comments in v3 reviewing.
>     Thanks Philipp!
> 
> RFCv2 -> v3
>   - move the introduced bpf kfuncs to kernel/bpf/* and mark them sleepable
>   - use listener and publisher model to implement bpf_copy_to_kernel()
>   - keep each introduced kfunc under the control of memcg
> 
> RFCv1 -> RFCv2
>   - Use bpf kfunc instead of helper
>   - Use C source code to generate the light skeleton file
> 
> 
> *** BLURB HERE ***
> 
> Pingfan Liu (12):
>   kexec_file: Make kexec_image_load_default global visible
>   lib/decompress: Keep decompressor when CONFIG_KEEP_COMPRESSOR
>   bpf: Introduce bpf_copy_to_kernel() to buffer the content from bpf-prog
>   bpf: Introduce decompressor kfunc
>   kexec: Introduce kexec_pe_image to parse and load PE file
>   kexec: Integrate with the introduced bpf kfuncs
>   kexec: Introduce a bpf-prog lskel to parse PE file
>   kexec: Factor out routine to find a symbol in ELF
>   kexec: Integrate bpf light skeleton to load zboot image
>   arm64/kexec: Add PE image format support
>   tools/kexec: Introduce a bpf-prog to parse zboot image format
>   tools/kexec: Add a zboot image building tool
> 
>  arch/arm64/Kconfig                           |   1 +
>  arch/arm64/include/asm/kexec.h               |   1 +
>  arch/arm64/kernel/machine_kexec_file.c       |   3 +
>  include/linux/bpf.h                          |  42 ++
>  include/linux/decompress/mm.h                |   7 +
>  include/linux/kexec.h                        |  10 +
>  kernel/Kconfig.kexec                         |   9 +
>  kernel/Makefile                              |   2 +
>  kernel/bpf/Makefile                          |   3 +
>  kernel/bpf/helpers.c                         | 230 +++++++++
>  kernel/bpf/helpers_carrier.c                 | 215 +++++++++
>  kernel/kexec_bpf/Makefile                    |  71 +++
>  kernel/kexec_bpf/kexec_pe_parser_bpf.c       |  67 +++
>  kernel/kexec_bpf/kexec_pe_parser_bpf.lskel.h | 147 ++++++
>  kernel/kexec_file.c                          |  88 ++--
>  kernel/kexec_pe_image.c                      | 463 +++++++++++++++++++
>  lib/Kconfig                                  |   3 +
>  lib/decompress.c                             |   6 +-
>  tools/kexec/Makefile                         |  90 ++++
>  tools/kexec/pe.h                             | 177 +++++++
>  tools/kexec/zboot_image_builder.c            | 280 +++++++++++
>  tools/kexec/zboot_parser_bpf.c               | 158 +++++++
>  22 files changed, 2029 insertions(+), 44 deletions(-)
>  create mode 100644 kernel/bpf/helpers_carrier.c
>  create mode 100644 kernel/kexec_bpf/Makefile
>  create mode 100644 kernel/kexec_bpf/kexec_pe_parser_bpf.c
>  create mode 100644 kernel/kexec_bpf/kexec_pe_parser_bpf.lskel.h
>  create mode 100644 kernel/kexec_pe_image.c
>  create mode 100644 tools/kexec/Makefile
>  create mode 100644 tools/kexec/pe.h
>  create mode 100644 tools/kexec/zboot_image_builder.c
>  create mode 100644 tools/kexec/zboot_parser_bpf.c
> 
> 
> base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9


