Return-Path: <bpf+bounces-55811-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5956CA86B40
	for <lists+bpf@lfdr.de>; Sat, 12 Apr 2025 08:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CE121B685A0
	for <lists+bpf@lfdr.de>; Sat, 12 Apr 2025 06:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C72C18D625;
	Sat, 12 Apr 2025 06:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XD3+sZ7c"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8121C7FD;
	Sat, 12 Apr 2025 06:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744439071; cv=none; b=P7sojAolIMGRoPWha34oFCWUXRZEKAuqJJSNjIu/iqFbF+S2u4kXEX9zFAgjuQp9asANIyqy5+YILoHoaTMEa9LqQYcrg+ybDZY19hNFRwLEQTQ62coamzjbk1mQrcctEimkrKd3W3mkwhUa6ykt4p0Tqah05twAlUxmA8IkYiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744439071; c=relaxed/simple;
	bh=cASD74BDVecXPscxZX54wCavoipGk0tOYQ7XNeflobo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVY7C/LRNWTACuOfYhCupl1RGZcFArLg45CKrvoLZdSwHhLR8zfjCGYohTkc5g/UHbJ919MUQcFSCqru2j4lqQu/KQ+6hCLInIrOcU94vk8uvhonQnAON6CiwHWMCiJiR6iVNhF5HVwIT8wSL7+UTGt9b53y4CEEvMaEI7mjWek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XD3+sZ7c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29FF1C4CEE3;
	Sat, 12 Apr 2025 06:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744439070;
	bh=cASD74BDVecXPscxZX54wCavoipGk0tOYQ7XNeflobo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XD3+sZ7c7EsbLbLRCui43vraC6vo6YNdf2XlAHBFk1OGKAwPVluQI2vMB/w0DI7DV
	 iqGeOJCaoEYxpGSXekdJxZZ0jW+8DFwXxF/KhQr70mdnc3V3N9FNV8jP4eUFxgnYxy
	 pAE1G+5txJj+Q3LgDTSt/1m0Uw8Yb5QI+kiBES3o=
Date: Sat, 12 Apr 2025 08:24:27 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Viktor Malik <vmalik@redhat.com>, bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	lmarch2 <2524158037@qq.com>, stable@vger.kernel.org,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: Re: [PATCH bpf v2] libbpf: Fix buffer overflow in
 bpf_object__init_prog
Message-ID: <2025041242-ignore-python-f4ef@gregkh>
References: <20250410095517.141271-1-vmalik@redhat.com>
 <CAEf4Bzb2S+1TonOp9UH86r0e6aGG2LEA4kwbQhJWr=9Xju=NEw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzb2S+1TonOp9UH86r0e6aGG2LEA4kwbQhJWr=9Xju=NEw@mail.gmail.com>

On Fri, Apr 11, 2025 at 09:22:37AM -0700, Andrii Nakryiko wrote:
> On Thu, Apr 10, 2025 at 2:55 AM Viktor Malik <vmalik@redhat.com> wrote:
> >
> > As reported by CVE-2025-29481 [1], it is possible to corrupt a BPF ELF
> > file such that arbitrary BPF instructions are loaded by libbpf. This can
> > be done by setting a symbol (BPF program) section offset to a large
> > (unsigned) number such that <section start + symbol offset> overflows
> > and points before the section data in the memory.
> >
> > Consider the situation below where:
> > - prog_start = sec_start + symbol_offset    <-- size_t overflow here
> > - prog_end   = prog_start + prog_size
> >
> >     prog_start        sec_start        prog_end        sec_end
> >         |                |                 |              |
> >         v                v                 v              v
> >     .....................|################################|............
> >
> > The CVE report in [1] also provides a corrupted BPF ELF which can be
> > used as a reproducer:
> >
> >     $ readelf -S crash
> >     Section Headers:
> >       [Nr] Name              Type             Address           Offset
> >            Size              EntSize          Flags  Link  Info  Align
> >     ...
> >       [ 2] uretprobe.mu[...] PROGBITS         0000000000000000  00000040
> >            0000000000000068  0000000000000000  AX       0     0     8
> >
> >     $ readelf -s crash
> >     Symbol table '.symtab' contains 8 entries:
> >        Num:    Value          Size Type    Bind   Vis      Ndx Name
> >     ...
> >          6: ffffffffffffffb8   104 FUNC    GLOBAL DEFAULT    2 handle_tp
> >
> > Here, the handle_tp prog has section offset ffffffffffffffb8, i.e. will
> > point before the actual memory where section 2 is allocated.
> >
> > This is also reported by AddressSanitizer:
> >
> >     =================================================================
> >     ==1232==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x7c7302fe0000 at pc 0x7fc3046e4b77 bp 0x7ffe64677cd0 sp 0x7ffe64677490
> >     READ of size 104 at 0x7c7302fe0000 thread T0
> >         #0 0x7fc3046e4b76 in memcpy (/lib64/libasan.so.8+0xe4b76)
> >         #1 0x00000040df3e in bpf_object__init_prog /src/libbpf/src/libbpf.c:856
> >         #2 0x00000040df3e in bpf_object__add_programs /src/libbpf/src/libbpf.c:928
> >         #3 0x00000040df3e in bpf_object__elf_collect /src/libbpf/src/libbpf.c:3930
> >         #4 0x00000040df3e in bpf_object_open /src/libbpf/src/libbpf.c:8067
> >         #5 0x00000040f176 in bpf_object__open_file /src/libbpf/src/libbpf.c:8090
> >         #6 0x000000400c16 in main /poc/poc.c:8
> >         #7 0x7fc3043d25b4 in __libc_start_call_main (/lib64/libc.so.6+0x35b4)
> >         #8 0x7fc3043d2667 in __libc_start_main@@GLIBC_2.34 (/lib64/libc.so.6+0x3667)
> >         #9 0x000000400b34 in _start (/poc/poc+0x400b34)
> >
> >     0x7c7302fe0000 is located 64 bytes before 104-byte region [0x7c7302fe0040,0x7c7302fe00a8)
> >     allocated by thread T0 here:
> >         #0 0x7fc3046e716b in malloc (/lib64/libasan.so.8+0xe716b)
> >         #1 0x7fc3045ee600 in __libelf_set_rawdata_wrlock (/lib64/libelf.so.1+0xb600)
> >         #2 0x7fc3045ef018 in __elf_getdata_rdlock (/lib64/libelf.so.1+0xc018)
> >         #3 0x00000040642f in elf_sec_data /src/libbpf/src/libbpf.c:3740
> >
> > The problem here is that currently, libbpf only checks that the program
> > end is within the section bounds. There used to be a check
> > `while (sec_off < sec_sz)` in bpf_object__add_programs, however, it was
> > removed by commit 6245947c1b3c ("libbpf: Allow gaps in BPF program
> > sections to support overriden weak functions").
> >
> > Put the above condition back to bpf_object__init_prog to make sure that
> > the program start is also within the bounds of the section to avoid the
> > potential buffer overflow.
> >
> > [1] https://github.com/lmarch2/poc/blob/main/libbpf/libbpf.md
> >
> > Reported-by: lmarch2 <2524158037@qq.com>
> > Cc: stable@vger.kernel.org
> 
> Libbpf is packaged and consumed from Github mirror, which is produced
> from latest bpf-next and bpf trees, so there is no point in
> backporting fixes like this to stable kernel branches. Please drop the
> CC: stable in the next revision.
> 
> > Fixes: 6245947c1b3c ("libbpf: Allow gaps in BPF program sections to support overriden weak functions")
> > Link: https://github.com/lmarch2/poc/blob/main/libbpf/libbpf.md
> > Link: https://www.cve.org/CVERecord?id=CVE-2025-29481
> 
> libbpf is meant to load BPF programs under root. It's a
> highly-privileged operation, and libbpf is not meant, designed, and
> actually explicitly discouraged from loading untrusted ELF files. As
> such, this is just a normal bug fix, like lots of others. So let's
> drop the CVE link as well.
> 
> Again, no one in their sane mind should be passing untrusted ELF files
> into libbpf while running under root. Period.
> 
> All production use cases load ELF that they generated and control
> (usually embedded into their memory through BPF skeleton header). And
> if that ELF file is corrupted, you have problems somewhere else,
> libbpf is not a culprit.

Should that context-less CVE be revoked as well?  Who asked for it to be
issued?

thanks,

greg k-h

