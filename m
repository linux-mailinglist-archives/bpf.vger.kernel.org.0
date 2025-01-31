Return-Path: <bpf+bounces-50216-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C81A24235
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 18:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9C0A168625
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 17:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2998D1F12E5;
	Fri, 31 Jan 2025 17:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IjL0CuCB"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6BA1EEA4A
	for <bpf@vger.kernel.org>; Fri, 31 Jan 2025 17:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738345601; cv=none; b=jEzRQVdfeGZIkNB75vfazmJ56jt5a2DOBjrSPm9WUMaXonjuPLP2BG9/65QAJJ7+a0QuZKDdmvRHQPBnKBJy6r+KoVsA4pFQO4VmrQi6bsJ+RZe2Z3cWiBgJ1qZDhQkyJ733U+9/QT8+VikW9o9M8ntBlaHVqhlnk1kyOPeQ8V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738345601; c=relaxed/simple;
	bh=uVX1qYc3pTOpA5AUW+0Tw/ZYUvK/5maqFRThIhkoJMw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=axwWHwCb3RrvScVzW2Gpupt+lOjVGqsc1x/HUmQyYIijT4jBlT9HGz+cbKG9B5kyqHp/NLQ5o6hfMaW/Fxd5SoAigX5Trh/beFKV1LFRQisKeaN5gXxbg6i0Lmoct4c3dERkDB2ZMoHXVoHYGRjhsHmyeQ6ICAxsxWdHzJtTfco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IjL0CuCB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738345598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LFrU3th6IUtyQ/sQRH1zmOSBvZWWYZbZ1MyGUI3jt0A=;
	b=IjL0CuCBBC++pkvt54zVRgwV9N5eAbKWdhT8OgLnRiwqKa8hQt8jSbRuZhJNJJPgc65FsW
	iU59pj4ixbyrnamKV6ci+jxa1IuKYXsRtn3HhZGqoj60nVNbdb42glNaTC4OWUzzT/i+tD
	IVDhUiI9nHTG8hmyfEhNy+GDIiz+XpA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-fh0nGX6EMGKv_bEWlKedRA-1; Fri,
 31 Jan 2025 12:46:34 -0500
X-MC-Unique: fh0nGX6EMGKv_bEWlKedRA-1
X-Mimecast-MFC-AGG-ID: fh0nGX6EMGKv_bEWlKedRA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 230DC1800269;
	Fri, 31 Jan 2025 17:46:32 +0000 (UTC)
Received: from rotkaeppchen (unknown [10.45.226.50])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2490519560A3;
	Fri, 31 Jan 2025 17:46:24 +0000 (UTC)
Date: Fri, 31 Jan 2025 18:46:21 +0100
From: Philipp Rudo <prudo@redhat.com>
To: Pingfan Liu <piliu@redhat.com>
Cc: kexec@lists.infradead.org, bpf@vger.kernel.org, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Jeremy Linton <jeremy.linton@arm.com>, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Simon Horman <horms@kernel.org>, Gerd
 Hoffmann <kraxel@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Jan
 Hendrik Farr <kernel@jfarr.cc>, Baoquan He <bhe@redhat.com>, Dave Young
 <dyoung@redhat.com>, Eric Biederman <ebiederm@xmission.com>
Subject: Re: [RFC] kexec: Use bpf to allow kexec to load PE format boot
 image
Message-ID: <20250131184621.12e8e94d@rotkaeppchen>
In-Reply-To: <20250114012831.4883-1-piliu@redhat.com>
References: <20250114012831.4883-1-piliu@redhat.com>
Organization: Red Hat inc.
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hi Pingfan,

thanks for sharing your thoughts. Please see my comments below.

On Tue, 14 Jan 2025 09:28:25 +0800
Pingfan Liu <piliu@redhat.com> wrote:

> Nowadays UEFI PE bootable image is more and more popular on the distribution.
> But it is still an open issue to load that kind of image by kexec with IMA enabled
> 
> *** A brief review of the history ***
> There are two categatories methods to handle this issue.
>   -1. UEFI service emulator for UEFI stub
>   -2. PE format parser
> 
> For the first one, I have tried a purgatory-style emulator [1]. But it
> confronts the hardware scaling trouble.  For the second one, there are two
> choices, one is to implement it inside the kernel, the other is inside the user
> space.  Both zboot-format [2] and UKI-format [3] parsers are rejected due to
> the concern that the variant format parsers will inflate the kernel code.  And
> finally, we have these kinds of parsers in the user space 'kexec-tools'.
> 
> 
> From the beginning, it has been perceived that the user space parser can not
> satisfy the requirement of security-boot without an extra embeded signature.
> This issue was suspended at that time. 
> 
> But now, more and more users expect the security feature and want the
> kexec_file_load to guarantee it by IMA.  I tried to fix that issue by the extra
> embeded signature method. But it is also disliked.
> 
> Enlighted by Philipp suggestion about implementing systemd-stub in bpf opcode in the discussion to [1],
> I turn to the bpf and hope that parsers in bpf-program can resolve this issue. 
> 
> [1]: https://lore.kernel.org/lkml/20240819145417.23367-1-piliu@redhat.com/T/
> [2]: https://lore.kernel.org/kexec/20230306030305.15595-1-kernelfans@gmail.com/
> [3]: https://lore.kernel.org/lkml/20230911052535.335770-1-kernel@jfarr.cc/
> [4]: https://lore.kernel.org/linux-arm-kernel/20230921133703.39042-2-kernelfans@gmail.com/T/
> 
> 
> 
> 
> *** Reflect the problem and a new proposal ***
> 
> The UEFI emulator is anchored at the UEFI spec. That will incur lots of work
> due to various hardware support.  For example, to support TPM, the emulator
> should implement PCI/I2C bus protocol.
> 
> But if the problem is confined to the original linux kernel boot protocol, it will be simple.
> Only three things should be considered: the kernel image, the initrd and the command line.
> If we can get them in a security way, we can tackle the problem.
> 
> The integrity of the file is ensured under the protection of the signature
> envelope.  If the kexeced files are parsed in the user space, the envelopes are
> opened and invalid.  So they should sink into the kernel space, be verified and
> be manipulated there.  And to manipulate the various format file, we need
> bpf-program, which know their format.
> 
> There are three parties in this solution
> -1. The kexec-tools itself is protected by IMA, and it creates a bpf-map and
> update UKI addon file names into the map. Later, the bpf-program will call
> bpf-helper to pad these files into initrd
> 
> -2. The bpf-program is contained in a dedicated '.bpf' section in PE file. When
> kexec_file_load a PE image, it extract the '.bpf' section and reflect it to the
> user space through procfs. And kexec-tools starts the program.  By this way,
> the bpf-program itself is free from tampering. 
> 
> The bpf-program completes two things:
> 	-1.parse the image format
> 	-2.call bpf kexec helpers to manipulate signed files
> 
> -3. The bpf helpers. There will be three helpers introduced.
> The first one for the data exchange between the bpf-program and the kernel.
> The second one for the decompressor.
> The third one for the manipulation of the cpio

I find this design very complicated. Especially I don't like that the
bpf program is exported back to user space to be loaded separately.
This does not only requires us to protect kexec-tools by IMA but also
all the tools and libraries that are involved in running kexec-tools
(libc, ld, etc.). But even that will probably not be enough when you
look at all the different ways user space programs can interact with
each other and change each others behavior (see the xz-backdoor for
example). So when we would probably need to protect all of user space
if we want to use this design in a secure boot environment, which is
out of scope for the feature.

Alternatively, we would need to verify in the kernel that the bpf
program loaded by the kexec-tools is identical to the one included in
the kernel image. But then what's the point in exporting it in the
first place? Especially as already today there is the
kernel/bpf/syscall.c:kern_sys_bpf function that allows to run the
bpf syscall from within the kernel (with some limitations, but it
allows to load a program).

All in all I think it is better to keep the current design, i.e.
kexec-tools only makes one systemcall and the rest is done in the
kernel.

In addition, while I agree that ideally we include the new feature
into kexec_file_load, I think it's better to define a new system call
for images containing bpf in the beginning. With that we have a blank
slate we can mess with without the need to take care of keeping the old
code working. Plus, it leaves us a fallback to load a dump kernel when
we mess up. Once we have a working prototype and a better understanding
on what is needed we can still merge it back into kexec_file_load.

> ***  Overview of the design in Pseudocode ***
> 
> 
> ThreadA: kexec thread which invokes kexec_file_load
> ThreadB: the dedicated thread in kexec-tools to load bpf-prog
> ------
> Diag 1. the interaction between bpf-prog loader and its executer
> 
> 
> ThreadA						ThreadB
> 
> 						wait on eventfd_A
> 
> 
> expose bpf-prog through procfs
> & signal eventfd_A
> & wait on eventfd_B
> 
> 						read the bpf-prog from procfs
> 						& initialize the bpf and install it to the fentry
> 						& signal eventfd_B
> 						& wait on eventfd_A again
> 						
> fentry executes bpf-prog to parse image
> & generate output for the next stop
> 
> 
> -------------------
> Diag 2. bpf-prog
> 
> SEC("fentry/kexec_pe_parser_hook")
> int BPF_PROG(pe_parser, struct kimage *image, ...)
> {
> 
> 	buf = bpf_ringbuf_reserve(rb, size);
> 	buf_result = bpf_ringbuf_reserve(rb, res_sz);
> 	/* Ask kernel to copy the resource content to here */
> 	bpf_helper_carrier(resource_name, buf, size, in);
> 	
> 	/* Parse the format laying on buf */
> 	...
> 	/* call extra bpf-helpers */
> 	...
> 	
> 	/* Ask kernel to copy the resource content from here */
> 	bpf_helper_carrier(resource_name, buf_result, res_sz, out);
> 
> }
> 
> At present, bpf map functions provides the mechanism to exchange the data between the user space and bpf-prog.
> But for bpf-prog and the kernel, there is no good choice. So I introduce a bpf helper function
> 	bpf_helper_carrier(resource_name, buf, size, in)
> 
> The above code implements the data exchange between the kernel and bpf-prog.
> By this way, the data parsing process is not exposed to the user space any longer.
> 
> 
> 
> extra bpf-helpers:
> 
> 	/* Decompress the compressed kernel image */
> 	bpf_helper_decompress(src, src_size, dst, dst_sz)
> 	
> 	/* 
> 	 * Verify the signature of @addon_filename, padding it to initrd's dir @dst_dir
> 	 */
> 	bpf_helper_supplement_initrd(dst_dir, addon_filename)

UKI addons can also append entries to the kernel command line. IMHO it
will be easiest when we maintain the initrd and command line in the
kernel, i.e. the syscall "prepopulates" the initrd and cmdline either
from the UKI or what kexec-tools provides. The bpf program then only
updates them. That's not ideal but it keeps the bpf program simple in
the beginning so we (hopefully) don't run into the limitations bpf
programs have. Once we have a working prototype we can still move
functionality over to the bpf program.

The way I see it this should work with three helper functions.
One to read+verify a file and one each to append data to the initrd or
command line.

> 	Note: Due to the UEFI environment (such as edk2) only providing basic
>         file operations for FAT filesystems, any UEFI-stub PE image (like systemd-stub)
>         is restricted to these basic operation services.  As a result, the
>         functionality of such bpf-kexec helpers is inherently limited.

Is this limitation really necessary? The way I see it this is a
limitation to keep the UEFI environment simple. But when we run kexec
the kernel is fully booted. So we can make use of all the file systems
included in the kernel.

Thanks
Philipp

> *** Thoughts about the basic operation *** 
> 
> The basic operations have influence on the stability of bpf-kexec-helpers.
> 
> The kexec_file_load faces three kinds of elements: linux-kernel, initrd and cmdline.
> 
> For the kernel, on arm64 or riscv, in order to get the bootable image from the compressed data,
> there should be a bpf-helper function as a wrapper of __decompress()
> 
> For initrd, systemd-sysext may require padding extra file into initrd
> 
> For cmdline, it may require some string trim or conjoin.
> 
> Overall, these user requirements are foreseeable and straightforward,
> suggesting that bpf-kexec-helpers will likely remain stable without significant
> changes.
> 
> 
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Jeremy Linton <jeremy.linton@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: Philipp Rudo <prudo@redhat.com>
> Cc: Jan Hendrik Farr <kernel@jfarr.cc>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Pingfan Liu <piliu@redhat.com>
> To: kexec@lists.infradead.org
> To: bpf@vger.kernel.org
> 


