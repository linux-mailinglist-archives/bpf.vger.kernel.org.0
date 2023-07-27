Return-Path: <bpf+bounces-6030-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E2D76438C
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 03:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48B581C214A9
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 01:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC66515B2;
	Thu, 27 Jul 2023 01:51:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCE37C
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 01:51:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E33C433C7;
	Thu, 27 Jul 2023 01:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690422667;
	bh=n318czXBvmsiuPQF5pqoA8pZBhMi3vK7TNvEem/rIbo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nLQFAVCymAeBc0wAfa5yMZG4XoFIhJpjTTsJampE8/k9JeW40e+aH+qLDjj0xIpvG
	 5ARxiMfCY23MlKQX7Oc+sCbxWltpAGC/twl/u8mMD+dHrcgVdw7lEA2j0seUup7lgl
	 wc7okrmGrSKP7VeNchMsaSvIkwwyovIXfVSMIUo5EQauETGbgEsmOo3VFBHV6q6wJU
	 K8NzqzXtzmnpEvTDN6BIt4hdk9uSpl29xybPlmDq0JImuvQTuNZ1WrKIS0gd1V8tQ7
	 7o2NeZ5VKfux1R1kug2BPmmIKx/ZbxoXJH19SIazqPGRN+jM1KtJdYEjc8pY2HeVg9
	 QuN18+HF+3fnA==
Date: Thu, 27 Jul 2023 10:51:02 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <olsajiri@gmail.com>,
 Arnaldo Carvalho de Melo <acme@redhat.com>, Yonghong Song <yhs@fb.com>,
 dwarves@vger.kernel.org, bpf@vger.kernel.org, Steven Rostedt
 <rostedt@goodmis.org>
Subject: Re: [RESEND] BTF is not generated for gcc-built kernel with the
 latest pahole
Message-Id: <20230727105102.509161e1f57fd0b49e98b844@kernel.org>
In-Reply-To: <20230727093814.23681b2b0ac73aa89f368ae8@kernel.org>
References: <20230726102534.9ebc4678ad2c9395cc9be196@kernel.org>
	<ZMDvmLdZSLi2QqB+@krava>
	<20230726200716.609d8433a7292eead95e7330@kernel.org>
	<6f0da094-5b49-954b-21e9-93f8c8cecc3f@oracle.com>
	<20230727093814.23681b2b0ac73aa89f368ae8@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Jul 2023 09:38:14 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > Yep, BPF generation is more selective about what it emits in 1.25 to
> > avoid cases where a kernel function signature is ambiguous (multiple
> > functions of the same name with different signatures) or where it has
> > unexpected register use. You can observe this via pahole's --verbose
> > option (a lot of outut is emitted):
> > 
> > In a built kernel directory (where unstripped vmlinux is present):
> > $ PAHOLE_FLAGS=$(./scripts/pahole_flags)
> > $ PAHOLE=/usr/local/bin/pahole
> > $ pahole --verbose -J $PAHOLE_FLAGS vmlinux > /tmp/pahole.out
> 
> So this will generate BTF from vmlinux DWARF info.
> 
> > If you want to investigate why a function has been left out, look for
> > "skipping" verbose output like this:
> > 
> > skipping addition of 'access_error'(access_error) due to multiple
> > inconsistent function prototypes
> > skipping addition of
> > 'acpi_ex_convert_to_object_type_string'(acpi_ex_convert_to_object_type_string.isra.0)
> > due to unexpected register used for parameter
> 
> Ah, that's nice. Let me try.

$ pahole --version 
v1.23

$ pahole --verbose -J $PAHOLE_FLAGS vmlinux > /tmp/pahole.out
die__process: DW_TAG_compile_unit, DW_TAG_type_unit, DW_TAG_partial_unit or DW_TAG_skeleton_unit expected got INVALID (0x0)!

OK, so something failed.

$ grep skipping /tmp/pahole.out  | wc -l
0

Nothing to be skipped.

$ grep -w kfree /tmp/pahole.out | wc -l
0
$ grep -w vfs_read /tmp/pahole.out | wc -l
0

But both kfree and vfs_read are not found.

$ perf probe -k ./vmlinux -V kfree
Available variables at kfree
        @<kfree+0>
                (unknown_type)  object
$ perf probe -k ./vmlinux -V vfs_read
Available variables at vfs_read
        @<vfs_read+0>
                char*   buf
                loff_t* pos
                size_t  count
                struct file*    file

However, perf probe can find both in the DWARF info.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

