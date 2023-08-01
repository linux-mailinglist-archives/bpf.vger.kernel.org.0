Return-Path: <bpf+bounces-6500-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B55476A5E5
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 03:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F3701C2094C
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 01:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53317641;
	Tue,  1 Aug 2023 01:01:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95EE7E
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 01:01:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 980A5C433C8;
	Tue,  1 Aug 2023 01:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690851712;
	bh=pGCIfwr9sOjYPkBp9wKHTITaKOvherqBluinEc4sFVM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tXXo8IWcLul0w2wEf3U5BzmUbsInIRH/MzZkSwddHV5nsuK4RbgMkX7avFqW7Vcem
	 3eSST5SeolPjY7MaD0Ei3/bH6boamhpax7Yzqhdsfat/qGIYOdYpHzBAL1DJ84MkSp
	 7k0wB7Gy2RoyfDqEJd3l+9+BEQUO6N5Cqcu4JF2/1+d886pIHnqO4WsdrCSBAX6XZf
	 tnUTg9I4k9VFRBjHG5wYX+fixVFDKbu38lb1YPI6/uMtzUgYa2XV8GUtGTJJpFtLyd
	 s8AB+NT/bL8oUE4RVvmhXDZx85cleKz+SDvaQmUStlvbgXiFC+qZTnGmYLBRDnmgAM
	 uWsKulML2P+aA==
Date: Tue, 1 Aug 2023 10:01:48 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Arnaldo Carvalho de Melo
 <acme@redhat.com>, Yonghong Song <yhs@fb.com>, dwarves@vger.kernel.org,
 bpf@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RESEND] BTF is not generated for gcc-built kernel with the
 latest pahole
Message-Id: <20230801100148.defdc4c41833054c56c53bf0@kernel.org>
In-Reply-To: <c5accb4d-21d1-d8d9-85a0-263177a06208@oracle.com>
References: <20230726102534.9ebc4678ad2c9395cc9be196@kernel.org>
	<ZMDvmLdZSLi2QqB+@krava>
	<20230726200716.609d8433a7292eead95e7330@kernel.org>
	<6f0da094-5b49-954b-21e9-93f8c8cecc3f@oracle.com>
	<20230727093814.23681b2b0ac73aa89f368ae8@kernel.org>
	<20230727105102.509161e1f57fd0b49e98b844@kernel.org>
	<c5accb4d-21d1-d8d9-85a0-263177a06208@oracle.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Jul 2023 16:45:24 +0100
Alan Maguire <alan.maguire@oracle.com> wrote:

> On 27/07/2023 02:51, Masami Hiramatsu (Google) wrote:
> > On Thu, 27 Jul 2023 09:38:14 +0900
> > Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> > 
> >>> Yep, BPF generation is more selective about what it emits in 1.25 to
> >>> avoid cases where a kernel function signature is ambiguous (multiple
> >>> functions of the same name with different signatures) or where it has
> >>> unexpected register use. You can observe this via pahole's --verbose
> >>> option (a lot of outut is emitted):
> >>>
> >>> In a built kernel directory (where unstripped vmlinux is present):
> >>> $ PAHOLE_FLAGS=$(./scripts/pahole_flags)
> >>> $ PAHOLE=/usr/local/bin/pahole
> >>> $ pahole --verbose -J $PAHOLE_FLAGS vmlinux > /tmp/pahole.out
> >>
> >> So this will generate BTF from vmlinux DWARF info.
> >>
> >>> If you want to investigate why a function has been left out, look for
> >>> "skipping" verbose output like this:
> >>>
> >>> skipping addition of 'access_error'(access_error) due to multiple
> >>> inconsistent function prototypes
> >>> skipping addition of
> >>> 'acpi_ex_convert_to_object_type_string'(acpi_ex_convert_to_object_type_string.isra.0)
> >>> due to unexpected register used for parameter
> >>
> >> Ah, that's nice. Let me try.
> > 
> > $ pahole --version 
> > v1.23
> > 
> 
> shouldn't this be v1.25? Is it possible pahole is picking up the wrong
> libdwarves? what does "ldd pahole" say?

Here it is.
$ ldd pahole 
	linux-vdso.so.1 (0x00007ffd6b1e2000)
	libdwarves_reorganize.so.1 => /opt/local/pahole/libdwarves_reorganize.so.1 (0x00007f1ddaad9000)
	libdwarves.so.1 => /opt/local/pahole/libdwarves.so.1 (0x00007f1ddaa72000)
	libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f1dda82a000)
	libdw.so.1 => /usr/local/lib/x86_64-linux-gnu/libdw.so.1 (0x00007f1dda78c000)
	libelf.so.1 => /usr/local/lib/x86_64-linux-gnu/libelf.so.1 (0x00007f1dda771000)
	libz.so.1 => /lib/x86_64-linux-gnu/libz.so.1 (0x00007f1dda753000)
	/lib64/ld-linux-x86-64.so.2 (0x00007f1ddaaef000)
	libdl.so.2 => /lib/x86_64-linux-gnu/libdl.so.2 (0x00007f1dda74e000)
	liblzma.so.5 => /lib/x86_64-linux-gnu/liblzma.so.5 (0x00007f1dda723000)
	libpthread.so.0 => /lib/x86_64-linux-gnu/libpthread.so.0 (0x00007f1dda71e000)

Maybe libdwarvers is not related, I could build pahole v1.23 and v1.22 without
sync the submodule.

I also confirmed the same issue on Ubuntu 22.04's combination, which
update pahole from v1.22 to v1.25 recently. (but gcc is still v11.3)

            gcc-11.3 | clang-16.0
---------------------------+---------------- 
v1.22          OK         OK
(ubuntu)
v1.22          OK         OK
(local)
v1.23          NG         OK
(local)
v1.24          NG         -
(local)
v1.25          NG         -
(ubuntu)
v1.25          NG         OK
(local)

So, as far as I checked, there is something wrong between v1.22 and v1.23
which is also related to gcc-11.3.

> 
> > $ pahole --verbose -J $PAHOLE_FLAGS vmlinux > /tmp/pahole.out
> > die__process: DW_TAG_compile_unit, DW_TAG_type_unit, DW_TAG_partial_unit or DW_TAG_skeleton_unit expected got INVALID (0x0)!
> > 
> > OK, so something failed.
> > 
> > $ grep skipping /tmp/pahole.out  | wc -l
> > 0
> > 
> > Nothing to be skipped.
> > 
> > $ grep -w kfree /tmp/pahole.out | wc -l
> > 0
> > $ grep -w vfs_read /tmp/pahole.out | wc -l
> > 0
> > 
> > But both kfree and vfs_read are not found.
> >  
> > $ perf probe -k ./vmlinux -V kfree
> > Available variables at kfree
> >         @<kfree+0>
> >                 (unknown_type)  object
> > $ perf probe -k ./vmlinux -V vfs_read
> > Available variables at vfs_read
> >         @<vfs_read+0>
> >                 char*   buf
> >                 loff_t* pos
> >                 size_t  count
> >                 struct file*    file
> > 
> > However, perf probe can find both in the DWARF info.
> > 
> > Thank you,
> > 
> 
> Unfortunately (or fortunately?) I haven't been able to reproduce so far
> I'm afraid. I used your config and built gcc 13 from source; everything
> worked as expected, with no warnings or missing functions (aside from
> the ones skipped due to inconsistent prototypes etc).

Yeah, so I think gcc-11.3 is suspicious too (and it seems fixed in gcc-13).


> One other thing I can think of - is it possible libdw[arf]/libelf
> versions might be having an effect here? I'm using libdwarf.so.1.2,
> libdw-0.188, libelf-0.188. I can try and match yours. Thanks!

Both libdw/libelf are 0.181. I didn't install libdwarf.
Hmm, I should update the libdw (elfutils) too.

Thank you,

> 
> Alan


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

