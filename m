Return-Path: <bpf+bounces-65926-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D77FB2B2F3
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 22:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16B3A3B3AEB
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 20:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2268D21885A;
	Mon, 18 Aug 2025 20:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lkOI4qsc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1AC1EDA1A;
	Mon, 18 Aug 2025 20:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755550381; cv=none; b=VnsnrUH3hMQjZSXI6/cZhSUv/m4MRYmknKLfzCzobi4wrLwVRfYB3+NpqLMpLFzLpkq7bp5mshZCw8s3YLI2h6+aPB+NQmwTnlvAdSMlGlMFTbTvzi/4QlqQ9LnE0X20XisYbPEUODNQBgbnXml53/jj8ig0ezsP4YySMotXl94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755550381; c=relaxed/simple;
	bh=SxVpYK3bMPh4spCeMQaC5oEmAf9qqTdGhd84IF1gD4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kgfS3MUE7st3TK9OCwDARjF372KZ5vHY9T4TpMKWpHR45mZS7TsrcLfjGUZglbDE8+6FAX6Jb3exP7drhzXswXGwpMzmKF3Mc2EMr5/2puW0Gn73iXP8SUtNgHcgEG1adwRU/AGrKlH+hXGb/T/VkxHVo6a0qPHKBlKR++M+Jd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lkOI4qsc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D03EEC4CEEB;
	Mon, 18 Aug 2025 20:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755550381;
	bh=SxVpYK3bMPh4spCeMQaC5oEmAf9qqTdGhd84IF1gD4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lkOI4qscuE7AhLqoNabUOE9W3E7gpSOntmqAymCeiVK33kQ1oEzBniIh1hs/vLkcs
	 AqumBQsmAT+2PnrsuYrIH1tJzYx1bLwx3kHPTq4yyeeqiOfC0ABrnPrZmX81gKxhSm
	 xg/y/HujVznpxL1iDN3W4e5F9rcRHXfFd+nF3YSCw5LqCtI6k8ZlVbL8HVct2MIsWv
	 KlU6Zh6boLwnxAmNA/oRqh4q8HDbVJfLxvXHjnIgyG0aO12aizpHH5NtytphC5Lpoq
	 BJf/1MNeL4V6EbFfBWYy7nn86ufMeiR0SXtGaTUTKzDXkWUuxJmnTecV9C3ELVxd3U
	 J/xfnKu87CUQA==
Date: Mon, 18 Aug 2025 17:52:57 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alan Maguire <alan.maguire@oracle.com>,
	Changqing Li <changqing.li@windriver.com>, dwarves@vger.kernel.org,
	Kernel Team <kernel-team@meta.com>, bpf <bpf@vger.kernel.org>
Subject: Re: "Segmentation fault" of pahole
Message-ID: <aKOSqWlQHZM0Icyj@x1>
References: <24bcc853-533c-42ab-bc37-0c13e0baa217@windriver.com>
 <37030a9d-28d8-4871-8acb-b26c59240710@linux.dev>
 <f1e2dc2b-a88b-4342-8e94-65481ae0cb4f@windriver.com>
 <ec72bbb8-b74d-49d1-bb42-5343feab8e5b@windriver.com>
 <7b071d63-71db-49d4-ab03-2dd7072a28aa@oracle.com>
 <979a1ac4-21d3-4384-8ce4-d10f41887088@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <979a1ac4-21d3-4384-8ce4-d10f41887088@linux.dev>

On Mon, Aug 18, 2025 at 10:56:36AM -0700, Ihor Solodrai wrote:
> On 8/18/25 6:56 AM, Alan Maguire wrote:
> > On 14/08/2025 10:42, Changqing Li wrote:
> > > 
> > > On 8/14/25 17:20, Changqing Li wrote:
> > > > 
> > > > On 8/14/25 07:45, Ihor Solodrai wrote:
> > > > > CAUTION: This email comes from a non Wind River email account!
> > > > > Do not click links or open attachments unless you recognize the
> > > > > sender and know the content is safe.
> > > > > 
> > > > > On 8/10/25 6:18 PM, Changqing Li wrote:
> > > > > > Hi,  Dear maintainers
> > > > > > 
> > > > > > I met a "Segmentation fault" error of pahole.   It happened when I
> > > > > > passed an ELF file without .symtab section.
> > > > > > Maybe I passed an  unsupport file, but I think it should not segfault,
> > > > > > maybe  a warnning or error message is better.
> > > > > > 
> > > > > > 
> > > > > > Here is the detailed info:
> > > > > > Pahole version:
> > > > > > # pahole --version
> > > > > > v1.29
> > > > > > 
> > > > > > Reproduce Command:
> > > > > > root@intel-x86-64:/~# pahole --btf_features=default -J /boot/
> > > > > > vmlinux-6.12.40-yocto-standard
> > > > > > pahole[599]: segfault at 8 ip 00007f7c92d819e2 sp 00007f7c799febe0
> > > > > > error
> > > > > > 6 in libdwarves.so.1.0.0[189e2,7f7c92d72000+1c000] likely on CPU 0
> > > > > > (core
> > > > > > 0, socket 0)
> > > > > > Code: 74 19 ff ff 48 39 dd 75 ef 4c 89 ef e8 67 19 ff ff 49 8b 7c 24 18
> > > > > > e8 8d 13 ff ff 49 8b 14 24 49 8b 44 24 08 4c 89 e7 45 31 e4 <48> 89 42
> > > > > > 08 48 89 10 e8 42 19 ff ff e9 30 ff ff ff e8 58 0a ff ff
> > > > > > Segmentation fault (core dumped)
> > > > > > 
> > > > > > root@intel-x86-64:~# file /boot/vmlinux-6.12.40-yocto-standard
> > > > > > /boot/vmlinux-6.12.40-yocto-standard: ELF 64-bit LSB executable,
> > > > > > x86-64,
> > > > > > version 1 (SYSV), statically linked,
> > > > > > BuildID[sha1]=1e73fe48101f07b9d991dc045ab9f9672a0feac0, stripped
> > > > > > 
> > > > > > root@intel-x86-64:/usr/bin# readelf -S /boot/vmlinux-6.12.40-yocto-
> > > > > > standard | grep .symtab
> > > > > >     [ 4] __ksymtab         PROGBITS         ffffffff82c11e00 01e11e00
> > > > > >     [ 5] __ksymtab_gpl     PROGBITS         ffffffff82c24730 01e24730
> > > > > >     [ 6] __ksymtab_strings PROGBITS         ffffffff82c397f0 01e397f0
> > > > > > 
> > > > > > 
> > > > > > (gdb) bt
> > > > > > #0  elf_functions__new (elf=<optimized out>) at /usr/src/debug/
> > > > > > pahole/1.29/btf_encoder.c:196
> > > > > > #1  0x00007ffff7f92a7d in btf_encoder__elf_functions
> > > > > > (encoder=encoder@entry=0x7fffd8008dc0) at /usr/src/debug/pahole/1.29/
> > > > > > btf_encoder.c:1374
> > > > > > #2  0x00007ffff7f94489 in btf_encoder__new (cu=cu@entry=0x7fffd8001e50,
> > > > > > detached_filename=<optimized out>, warning: could not convert 'btf'
> > > > > > from
> > > > > > the host encoding (ANSI_X3.4-1968) to UTF-32.
> > > > > > This normally should not happen, please file a bug report.
> > > > > > base_btf=0x0,
> > > > > >       verbose=<optimized out>, conf_load=conf_load@entry=0x555555565280
> > > > > > <conf_load>) at /usr/src/debug/pahole/1.29/btf_encoder.c:2431
> > > > > > #3  0x000055555555db49 in pahole_stealer__btf_encode
> > > > > > (cu=0x7fffd8001e50,
> > > > > > conf_load=0x555555565280 <conf_load>)
> > > > > >       at /usr/src/debug/pahole/1.29/pahole.c:3126
> > > > > > #4  pahole_stealer (cu=0x7fffd8001e50, conf_load=0x555555565280
> > > > > > <conf_load>) at /usr/src/debug/pahole/1.29/pahole.c:3187
> > > > > > #5  0x00007ffff7f9d023 in cus__steal_now (cus=<optimized out>,
> > > > > > cu=<optimized out>, conf=<optimized out>)
> > > > > >       at /usr/src/debug/pahole/1.29/dwarf_loader.c:3266
> > > > > > #6  dwarf_loader__worker_thread (arg=0x7fffffffe700) at /usr/src/debug/
> > > > > > pahole/1.29/dwarf_loader.c:3672
> > > > > > #7  0x00007ffff7dbe722 in start_thread (arg=<optimized out>) at
> > > > > > pthread_create.c:448
> > > > > > #8  0x00007ffff7e314fc in __GI___clone3 () at ../sysdeps/unix/sysv/
> > > > > > linux/x86_64/clone3.S:78
> > > > > > (gdb)
> 
> Hi everyone.
> 
> I was able to reproduce the error by feeding pahole a vmlinux with a
> debuglink [1], created with:
> 
>     vmlinux=$(realpath ~/kernels/bpf-next/.tmp_vmlinux1)
>     objcopy --only-keep-debug $vmlinux vmlinux.debug
>     objcopy --strip-all --add-gnu-debuglink=vmlinux.debug $vmlinux
> vmlinux.stripped
> 
> With that, I got the following valgrind output:
> 
>     $ valgrind ./build/pahole --btf_features=default -J
> ./mbox/vmlinux.stripped
>     ==40680== Memcheck, a memory error detector
>     ==40680== Copyright (C) 2002-2024, and GNU GPL'd, by Julian Seward et
> al.
>     ==40680== Using Valgrind-3.25.1 and LibVEX; rerun with -h for copyright
> info
>     ==40680== Command: ./build/pahole --btf_features=default -J
> ./mbox/vmlinux.stripped
>     ==40680==
>     ==40680== Warning: set address range perms: large range [0x7c20000,
> 0x32e2d000) (defined)
>     ==40680== Thread 2:
>     ==40680== Invalid write of size 8
>     ==40680==    at 0x487D34D: __list_del (list.h:106)
>     ==40680==    by 0x487D384: list_del (list.h:118)
>     ==40680==    by 0x487D6DB: elf_functions__delete (btf_encoder.c:170)
>     ==40680==    by 0x487D77C: elf_functions__new (btf_encoder.c:201)
>     ==40680==    by 0x4880E2A: btf_encoder__elf_functions
> (btf_encoder.c:1485)
>     ==40680==    by 0x4883558: btf_encoder__new (btf_encoder.c:2450)
>     ==40680==    by 0x4078DD: pahole_stealer__btf_encode (pahole.c:3160)
>     ==40680==    by 0x407B0D: pahole_stealer (pahole.c:3221)
>     ==40680==    by 0x488D2F5: cus__steal_now (dwarf_loader.c:3266)
>     ==40680==    by 0x488DF74: dwarf_loader__worker_thread
> (dwarf_loader.c:3678)
>     ==40680==    by 0x4A8F723: start_thread (pthread_create.c:448)
>     ==40680==    by 0x4B13613: clone (clone.S:100)
>     ==40680==  Address 0x8 is not stack'd, malloc'd or (recently) free'd
> 
> As far as I understand, in principle pahole could support search for a
> file linked via .gnu_debuglink, but that's a separate issue.

Agreed.
 
> Please see a bugfix patch below.
> 
> [1]
> https://manpages.debian.org/unstable/binutils-common/objcopy.1.en.html#add~3
> 
> 
> From 6104783080709dad0726740615149951109f839e Mon Sep 17 00:00:00 2001
> From: Ihor Solodrai <ihor.solodrai@linux.dev>
> Date: Mon, 18 Aug 2025 10:30:16 -0700
> Subject: [PATCH] btf_encoder: fix elf_functions cleanup on error
> 
> When elf_functions__new() errors out and jumps to
> elf_functions__delete(), pahole segfaults on attempt to list_del the
> elf_functions instance from a list, to which it was never added.
> 
> Fix this by changing elf_functions__delete() to
> elf_functions__clear(), moving list_del and free calls out of it. Then
> clear and free on error, and remove from the list on normal cleanup in
> elf_functions_list__clear().

I think we should still call it __delete() to have a counterpart to
__new() and just remove that removal from the list from the __delete().

Apart from that, it looks to address a bug, so with the above changed:

Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo
 
> Closes: https://lore.kernel.org/dwarves/24bcc853-533c-42ab-bc37-0c13e0baa217@windriver.com/
> Reported-by: Changqing Li <changqing.li@windriver.com>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> 
> ---
>  btf_encoder.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 0bc2334..631c0b5 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -161,14 +161,12 @@ struct btf_kfunc_set_range {
>  	uint64_t end;
>  };
> 
> -static inline void elf_functions__delete(struct elf_functions *funcs)
> +static inline void elf_functions__clear(struct elf_functions *funcs)
>  {
>  	for (int i = 0; i < funcs->cnt; i++)
>  		free(funcs->entries[i].alias);
>  	free(funcs->entries);
>  	elf_symtab__delete(funcs->symtab);
> -	list_del(&funcs->node);
> -	free(funcs);
>  }
> 
>  static int elf_functions__collect(struct elf_functions *functions);
> @@ -198,7 +196,8 @@ struct elf_functions *elf_functions__new(Elf *elf)
>  	return funcs;
> 
>  out_delete:
> -	elf_functions__delete(funcs);
> +	elf_functions__clear(funcs);
> +	free(funcs);
>  	return NULL;
>  }
> 
> @@ -209,7 +208,9 @@ static inline void elf_functions_list__clear(struct
> list_head *elf_functions_lis
> 
>  	list_for_each_safe(pos, tmp, elf_functions_list) {
>  		funcs = list_entry(pos, struct elf_functions, node);
> -		elf_functions__delete(funcs);
> +		elf_functions__clear(funcs);
> +		list_del(&funcs->node);
> +		free(funcs);
>  	}
>  }
> 
> -- 
> 2.50.1
> 
> 
> 
> 
> > > > > > 
> > > > > > 
> > > > > > Command  "pahole --btf_features=default -J /boot/.debug/
> > > > > > vmlinux-6.12.40-
> > > > > > yocto-standard " works well since /boot/.debug/vmlinux-6.12.40-yocto-
> > > > > > standard has  .symtab section.
> > > > > > root@intel-x86-64:/usr/bin# file /boot/.debug/vmlinux-6.12.40-yocto-
> > > > > > standard
> > > > > > /boot/.debug/vmlinux-6.12.40-yocto-standard: ELF 64-bit LSB executable,
> > > > > > x86-64, version 1 (SYSV), statically linked,
> > > > > > BuildID[sha1]=1e73fe48101f07b9d991dc045ab9f9672a0feac0, with
> > > > > > debug_info,
> > > > > > not stripped
> > > > > > 
> > > > > > root@intel-x86-64:/usr/bin# readelf -S /boot/.debug/vmlinux-6.12.40-
> > > > > > yocto-standard | grep .symtab
> > > > > >     [ 4] __ksymtab         NOBITS           ffffffff82c11e00 00001000
> > > > > >     [ 5] __ksymtab_gpl     NOBITS           ffffffff82c24730 00001000
> > > > > >     [ 6] __ksymtab_strings NOBITS           ffffffff82c397f0 00001000
> > > > > >     [49] .symtab           SYMTAB           0000000000000000 154cf200
> > > > > > 
> > > > > 
> > > > > Hi Changqing Li, thanks for the bug report.
> > > > > 
> > > > > I couldn't reproduce this error with a stripped vmlinux:
> > > > > 
> > > > > $ objcopy --strip-all ~/kernels/bpf-next/.tmp_vmlinux1 vmlinux-strip-all
> > > > > 
> > > > > v1.29 fails with:
> > > > > $ ./build/pahole --btf_features=default -J $(realpath vmlinux-strip-all)
> > > > > Error creating BTF encoder.
> > > > > 
> > > > > v1.30 fails with:
> > > > > $ ./build/pahole --btf_features=default -J $(realpath vmlinux-strip-all)
> > > > > pahole: /home/isolodrai/pahole/vmlinux-strip-all: Invalid argument
> > > > > 
> > > > > Different errors are not nice, but at least no segfault.
> > > > > 
> > > > > Could you please share the vmlinux binary that causes the error?
> > > > > And also check if you get a segfault on v1.30 too?
> > > > > 
> > > > > Thanks.
> > > > > 
> > > > Hi, Ihor
> > > > Thanks for checking this. Here is my retest result:
> > > > On version 1.29:
> > > > root@intel-x86-64:~# pahole --btf_features=default -J /boot/
> > > > vmlinux-6.12.40-yocto-standard
> > > > pahole[333]: segfault at 8 ip 00007fd5025179e2 sp 00007fd4e73febe0
> > > > error 6 in libdwarves.so.1.0.0[189e2,7fd502508000+1c000] likely on CPU
> > > > 0 (core 0, socket 0)
> > > > Code: 74 19 ff ff 48 39 dd 75 ef 4c 89 ef e8 67 19 ff ff 49 8b 7c 24
> > > > 18 e8 8d 13 ff ff 49 8b 14 24 49 8b 44 24 08 4c 89 e7 45 31 e4 <48> 89
> > > > 42 08 48 89 10 e8 42 19 ff ff e9 30 ff ff ff e8 58 0a ff ff
> > > > Segmentation fault (core dumped)
> > > > root@intel-x86-64:~# cp /boot/vmlinux-6.12.40-yocto-standard /root/
> > > > root@intel-x86-64:~# pahole --btf_features=default -J /root/
> > > > vmlinux-6.12.40-yocto-standard
> > > > Error creating BTF encoder.
> > > > 
> > > > We can see that the same vmlinux-6.12.40-yocto-standard have different
> > > > result. After do some debugging,  I found that
> > > > /boot/vmlinux-6.12.40-yocto-standard segfault since it has debuginfo
> > > > file /boot/.debug/vmlinux-6.12.40-yocto-standard.
> > > > after I move .debug to .xxx, it will not segfault.
> > > > root@intel-x86-64:/boot# mv .debug/ .xxx
> > > > root@intel-x86-64:/boot# pahole --btf_features=default -J /boot/
> > > > vmlinux-6.12.40-yocto-standard
> > > > Error creating BTF encoder.
> > > > 
> > > > dwfl_module_getdwarf in cus__process_dwflmod return different when
> > > > with or without debug,  without .debug, dw=NULL,
> > > > with .debug, dw will have a value, then causes the different process.
> > > > 
> > > > On version 1.30
> > > > root@intel-x86-64:~# pahole --version
> > > > v1.30
> > > > root@intel-x86-64:~# pahole --btf_features=default -J /boot/
> > > > vmlinux-6.12.40-yocto-standard
> > > > pahole[314]: segfault at 8 ip 00007f2b0b6b2bf3 sp 00007f2af05feb20
> > > > error 6 in libdwarves.so.1.0.0[18bf3,7f2b0b6a3000+1c000] likely on CPU
> > > > 0 (core 0, socket 0)
> > > > Code: 33 17 ff ff 48 39 dd 75 ee 4c 89 ef e8 26 17 ff ff 49 8b 7c 24
> > > > 18 e8 5c 11 ff ff 49 8b 14 24 49 8b 44 24 08 4c 89 e7 45 31 e4 <48> 89
> > > > 42 08 48 89 10 e8 01 17 ff ff e9 2d ff ff ff e8 37 08 ff ff
> > > > Segmentation fault (core dumped)
> > > > root@intel-x86-64:~# cp /boot/vmlinux-6.12.40-yocto-standard /root/
> > > > root@intel-x86-64:~#  pahole --btf_features=default -J /root/
> > > > vmlinux-6.12.40-yocto-standard
> > > > pahole: /root/vmlinux-6.12.40-yocto-standard: Invalid argument
> > > > root@intel-x86-64:~# cd /root
> > > > root@intel-x86-64:~# mkdir .debug
> > > > root@intel-x86-64:~# cp /boot/.debug/vmlinux-6.12.40-yocto-
> > > > standard .debug/
> > > > root@intel-x86-64:~# pahole --btf_features=default -J /root/
> > > > vmlinux-6.12.40-yocto-standard
> > > > pahole[441]: segfault at 8 ip 00007f64a9032bf3 sp 00007f648dffeb20
> > > > error 6 in libdwarves.so.1.0.0[18bf3,7f64a9023000+1c000] likely on CPU
> > > > 0 (core 0, socket 0)
> > > > Code: 33 17 ff ff 48 39 dd 75 ee 4c 89 ef e8 26 17 ff ff 49 8b 7c 24
> > > > 18 e8 5c 11 ff ff 49 8b 14 24 49 8b 44 24 08 4c 89 e7 45 31 e4 <48> 89
> > > > 42 08 48 89 10 e8 01 17 ff ff e9 2d ff ff ff e8 37 08 ff ff
> > > > 
> > > > Segmentation fault (core dumped)
> > > 
> > > I think this " Invalid argument " change  is caused by this commit:
> > > 
> > > https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?
> > > id=b4a071d99bb9e7c0d3c6ea7a6835389a4d350ed4
> > > 
> > > encode BTF with DWARF less files is not support for v1.30, so, since  /
> > > boot/vmlinux-6.12.40-yocto-standard without debuginfo, it taken as in
> > > invalid argument,
> > > 
> > > I think it is  ok,  but maybe more clear reason is better.
> > > 
> > 
> > Thanks for the report!
> > 
> > With latest pahole (next branch of
> > https://git.kernel.org/pub/scm/devel/pahole/pahole.git/ ) including
> > Arnaldo's change
> > 
> > commit 97bf0a0b0572ec023761da9226b068b59b471de0
> > Author: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Date:   Tue Jul 22 11:22:27 2025 -0300
> > 
> >      pahole: Don't fail when encoding BTF on an object with no DWARF info
> > 
> > 
> > I see the following pahole results against a stripped vmlinux:
> > 
> > $ pahole --btf_features=default -J vmlinux.stripped
> > $ echo $?
> > 0
> > 
> > Can you reproduce the segmentation fault with the above pahole? If you
> > can provide a way to get a stripped pahole like the above for me to test
> > with, or provide the kernel .config used to build it, that would be
> > great. Thanks!
> > 
> > Alan

