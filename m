Return-Path: <bpf+bounces-6719-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6C876D010
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 16:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5DCE1C2138C
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 14:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B229847B;
	Wed,  2 Aug 2023 14:29:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F798821
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 14:29:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB308C433C7;
	Wed,  2 Aug 2023 14:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690986580;
	bh=KiALrlTTBGNNxJjAlkg0zUW9vHnN2Eiaz/7lLcW5vYs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GShPERietaHbHGT0Lx+YQV+5FgcFEHKF6ri4G31+WVlKc7VF25fAz3vobQrwXC5A9
	 zShL257h2czDCWas9+KkUzsW4aHRjjqX5MVdAnMrmCGTUC38HaR/iW73Wy8bvd+Cqz
	 q/44xwY8tj6F8JV7h+2Nc8Q6oNA6oUudfBgzMkNiXWg0IaxuvKPdleo5xixLi8Rqov
	 bplkx2Q3p/nWPMkQ5cZ7ymYeQn1+AJwx83z8gVMh8Dy+4UsYGQzUbOHF4InUq1O4Rg
	 Htg7YViB0PISDSfaq7Iython6xeogc6gJRHGV16BSlYN1SWxDMJtYvR2Wollt1NirH
	 N322bKQJq8e2w==
Date: Wed, 2 Aug 2023 23:29:35 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alan Maguire <alan.maguire@oracle.com>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, Jiri Olsa <olsajiri@gmail.com>, Arnaldo Carvalho de
 Melo <acme@redhat.com>, Yonghong Song <yhs@fb.com>,
 dwarves@vger.kernel.org, bpf@vger.kernel.org, Steven Rostedt
 <rostedt@goodmis.org>
Subject: Re: [RESEND] BTF is not generated for gcc-built kernel with the
 latest pahole
Message-Id: <20230802232935.58be8f5d778efabf2a90fd00@kernel.org>
In-Reply-To: <ZMl9DaOadsdMi36c@kernel.org>
References: <20230726102534.9ebc4678ad2c9395cc9be196@kernel.org>
	<ZMDvmLdZSLi2QqB+@krava>
	<20230726200716.609d8433a7292eead95e7330@kernel.org>
	<6f0da094-5b49-954b-21e9-93f8c8cecc3f@oracle.com>
	<20230727093814.23681b2b0ac73aa89f368ae8@kernel.org>
	<20230727105102.509161e1f57fd0b49e98b844@kernel.org>
	<c5accb4d-21d1-d8d9-85a0-263177a06208@oracle.com>
	<20230801100148.defdc4c41833054c56c53bf0@kernel.org>
	<bba3b423-8e38-ade3-7ce7-23b1be454d1f@oracle.com>
	<ZMl9DaOadsdMi36c@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 1 Aug 2023 18:45:49 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Em Tue, Aug 01, 2023 at 06:36:49PM +0100, Alan Maguire escreveu:
> > On 01/08/2023 02:01, Masami Hiramatsu (Google) wrote:
> > > On Mon, 31 Jul 2023 16:45:24 +0100
> > > Alan Maguire <alan.maguire@oracle.com> wrote:
> > > 
> > >> On 27/07/2023 02:51, Masami Hiramatsu (Google) wrote:
> > >>> On Thu, 27 Jul 2023 09:38:14 +0900
> > >>> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> > >>>
> > >>>>> Yep, BPF generation is more selective about what it emits in 1.25 to
> > >>>>> avoid cases where a kernel function signature is ambiguous (multiple
> > >>>>> functions of the same name with different signatures) or where it has
> > >>>>> unexpected register use. You can observe this via pahole's --verbose
> > >>>>> option (a lot of outut is emitted):
> > >>>>>
> > >>>>> In a built kernel directory (where unstripped vmlinux is present):
> > >>>>> $ PAHOLE_FLAGS=$(./scripts/pahole_flags)
> > >>>>> $ PAHOLE=/usr/local/bin/pahole
> > >>>>> $ pahole --verbose -J $PAHOLE_FLAGS vmlinux > /tmp/pahole.out
> > >>>>
> > >>>> So this will generate BTF from vmlinux DWARF info.
> > >>>>
> > >>>>> If you want to investigate why a function has been left out, look for
> > >>>>> "skipping" verbose output like this:
> > >>>>>
> > >>>>> skipping addition of 'access_error'(access_error) due to multiple
> > >>>>> inconsistent function prototypes
> > >>>>> skipping addition of
> > >>>>> 'acpi_ex_convert_to_object_type_string'(acpi_ex_convert_to_object_type_string.isra.0)
> > >>>>> due to unexpected register used for parameter
> > >>>>
> > >>>> Ah, that's nice. Let me try.
> > >>>
> > >>> $ pahole --version 
> > >>> v1.23
> > >>>
> > >>
> > >> shouldn't this be v1.25? Is it possible pahole is picking up the wrong
> > >> libdwarves? what does "ldd pahole" say?
> > > 
> > > Here it is.
> > > $ ldd pahole 
> > > 	linux-vdso.so.1 (0x00007ffd6b1e2000)
> > > 	libdwarves_reorganize.so.1 => /opt/local/pahole/libdwarves_reorganize.so.1 (0x00007f1ddaad9000)
> > > 	libdwarves.so.1 => /opt/local/pahole/libdwarves.so.1 (0x00007f1ddaa72000)
> > > 	libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f1dda82a000)
> > > 	libdw.so.1 => /usr/local/lib/x86_64-linux-gnu/libdw.so.1 (0x00007f1dda78c000)
> > > 	libelf.so.1 => /usr/local/lib/x86_64-linux-gnu/libelf.so.1 (0x00007f1dda771000)
> > > 	libz.so.1 => /lib/x86_64-linux-gnu/libz.so.1 (0x00007f1dda753000)
> > > 	/lib64/ld-linux-x86-64.so.2 (0x00007f1ddaaef000)
> > > 	libdl.so.2 => /lib/x86_64-linux-gnu/libdl.so.2 (0x00007f1dda74e000)
> > > 	liblzma.so.5 => /lib/x86_64-linux-gnu/liblzma.so.5 (0x00007f1dda723000)
> > > 	libpthread.so.0 => /lib/x86_64-linux-gnu/libpthread.so.0 (0x00007f1dda71e000)
> > > 
> > > Maybe libdwarvers is not related, I could build pahole v1.23 and v1.22 without
> > > sync the submodule.
> > > 
> > > I also confirmed the same issue on Ubuntu 22.04's combination, which
> > > update pahole from v1.22 to v1.25 recently. (but gcc is still v11.3)
> > > 
> > >             gcc-11.3 | clang-16.0
> > > ---------------------------+---------------- 
> > > v1.22          OK         OK
> > > (ubuntu)
> > > v1.22          OK         OK
> > > (local)
> > > v1.23          NG         OK
> > > (local)
> > > v1.24          NG         -
> > > (local)
> > > v1.25          NG         -
> > > (ubuntu)
> > > v1.25          NG         OK
> > > (local)
> > > 
> > > So, as far as I checked, there is something wrong between v1.22 and v1.23
> > > which is also related to gcc-11.3.
> > > 
> > 
> > One thing that is notable about gcc 11 is that I believe it's the first
> > gcc release to emit DWARF5 by default. I wonder if it's possible that
> > the kernel emitted DWARF5, but pahole was built with libraries that
> > didn't support it yet? Not sure how that fits with the fact that
> 
> To check that please tweak:
> 
> ⬢[acme@toolbox perf-tools-next]$ grep DWARF ../build/v6.2-rc5+/.config
> CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
> # CONFIG_DEBUG_INFO_DWARF4 is not set
> # CONFIG_DEBUG_INFO_DWARF5 is not set
> ⬢[acme@toolbox perf-tools-next]$
> 
> i.e. disable CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT and enable
> CONFIG_DEBUG_INFO_DWARF4.

Hm, with CONFIG_DEBUG_INFO_DWARF4, no warning were shown.

  LD      .tmp_vmlinux.btf
  BTF     .btf.vmlinux.bin.o
  LD      .tmp_vmlinux.kallsyms1

And

/ # strings /sys/kernel/btf/vmlinux | wc -l
89921
/ # strings /sys/kernel/btf/vmlinux | grep -w kfree
kfree

It seems the BTF is correctly generated. (with DWARF5, the number of symbols
are about 30000.)
Maybe we should check the pahole version and choose the DWARF4 if BTF is selected.

Thank you!

> 
> - Arnaldo
> 
> > pahole v1.22 works though. If you have a chance, it might be worth
> > experimenting with your kernel .config to specify DWARF4 to see if
> > that makes a difference.
> > 
> > You can check DWARF version associated with CUs with
> > 
> > readelf --debug-dump=info vmlinux |grep -A 2 'Compilation Unit'


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

