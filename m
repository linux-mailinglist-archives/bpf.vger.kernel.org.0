Return-Path: <bpf+bounces-6026-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E56A764304
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 02:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A619D1C214A5
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 00:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A062D136D;
	Thu, 27 Jul 2023 00:38:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E5A7C
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 00:38:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94487C433C8;
	Thu, 27 Jul 2023 00:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690418298;
	bh=LRGeETeUPNx91JrCWN7rH5t95ddjH/6FHmKY4pmTY1A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qDJc1C+myXCOVWMkLvsWXEZAPLV+h5CUpfMzS/FEwLflVjfvQPwuA2XBbOoTp/J5f
	 E7ZHiouKmTtpiytAaqkXpTYa87lPJcZt5eiL5K83nAnmTBW1PMe++b+Tk1RbHsIdr+
	 sJtFD+As8mv3ryX2whdCbTyUOh2TzeAGK9Kzc1+1bTOPhwkmEnO+/2NJkGrrBIqc7X
	 jFq4ciwNBKpIF/PikkvguDSr0u3elf9O4GIHK+NZrEv8niFYgFh7Qx5FZqapOg5KYo
	 8wZXXd/FRuFU+P6xAYrqgqtCeoiYdlEemOo9b1NrkEzYuabuF5BrextSntdTlSTqz4
	 RzLjF7iRx7Adw==
Date: Thu, 27 Jul 2023 09:38:14 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Arnaldo Carvalho de Melo
 <acme@redhat.com>, Yonghong Song <yhs@fb.com>, dwarves@vger.kernel.org,
 bpf@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RESEND] BTF is not generated for gcc-built kernel with the
 latest pahole
Message-Id: <20230727093814.23681b2b0ac73aa89f368ae8@kernel.org>
In-Reply-To: <6f0da094-5b49-954b-21e9-93f8c8cecc3f@oracle.com>
References: <20230726102534.9ebc4678ad2c9395cc9be196@kernel.org>
	<ZMDvmLdZSLi2QqB+@krava>
	<20230726200716.609d8433a7292eead95e7330@kernel.org>
	<6f0da094-5b49-954b-21e9-93f8c8cecc3f@oracle.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Jul 2023 15:46:03 +0100
Alan Maguire <alan.maguire@oracle.com> wrote:

> On 26/07/2023 12:07, Masami Hiramatsu (Google) wrote:
> > Hi Jiri,
> > 
> > On Wed, 26 Jul 2023 12:04:08 +0200
> > Jiri Olsa <olsajiri@gmail.com> wrote:
> > 
> >> On Wed, Jul 26, 2023 at 10:25:34AM +0900, Masami Hiramatsu wrote:
> >>> Hello,
> >>> (I resend this because kconfig was too big)
> >>>
> >>> I found that BTF is not generated for gcc-built kernel with that latest
> >>> pahole (v1.25).
> >>
> >> hi,
> >> I can't reproduce on my setup with your .config
> >>
> >> does 'bpftool btf dump file ./vmlinux' show any error?
> >>
> >> is there any error in the kernel build output?
> > 
> > Yes, here it is. I saw these 2 lines.
> > 
> > die__process: DW_TAG_compile_unit, DW_TAG_type_unit, DW_TAG_partial_unit or DW_TAG_skeleton_unit expected got INVALID (0x0)!
> > die__process: DW_TAG_compile_unit, DW_TAG_type_unit, DW_TAG_partial_unit or DW_TAG_skeleton_unit expected got INVALID (0x0)!
> 
> This is strange, looks like some CUs were encoded incorrectly or we are
> parsing incorrectly. The error originates in die__process() and happens
> if the dwarf_tag() associated with the DIE isn't an expected unit; it's
> not even a valid tag value (0) it looks like. I've not built with gcc 13
> yet so it's possible that's the reason you're seeing this, I'll try to
> reproduce it..

And this warning message is not good for debugging. It would better dump
the message with DIE index so that we can analyze the DWARF with other
tools.


> >>> When I'm using the distro origin pahole (v1.22) it works. (I also checked
> >>> v1.23 and v1.24, both partially generated BTF)
> >>>
> >>> e.g.
> >>>
> >>> # echo 'f kfree $arg*' >> /sys/kernel/tracing/dynamic_events
> >>> sh: write error: Invalid argument
> >>>
> >>> # cat /sys/kernel/tracing/error_log 
> >>> [   21.595724] trace_fprobe: error: BTF is not available or not supported
> >>>   Command: f kfree $arg*
> >>>                    ^
> >>> [   21.596032] trace_fprobe: error: Invalid $-valiable specified
> >>>   Command: f kfree $arg*
> >>>                    ^
> >>>
> >>> / # strings /sys/kernel/btf/vmlinux | grep kfree
> >>
> >> hm, if you have this file present, you have BTF in
> > 
> > Yes, it seems that the BTF itself is generated, but many entries seems
> > dropped compared with pahole v1.22. So, if a given symbol has BTF, (e.g. 
> > kfree_rcu_batch_init) it works.
> >
> 
> Yep, BPF generation is more selective about what it emits in 1.25 to
> avoid cases where a kernel function signature is ambiguous (multiple
> functions of the same name with different signatures) or where it has
> unexpected register use. You can observe this via pahole's --verbose
> option (a lot of outut is emitted):
> 
> In a built kernel directory (where unstripped vmlinux is present):
> $ PAHOLE_FLAGS=$(./scripts/pahole_flags)
> $ PAHOLE=/usr/local/bin/pahole
> $ pahole --verbose -J $PAHOLE_FLAGS vmlinux > /tmp/pahole.out

So this will generate BTF from vmlinux DWARF info.

> If you want to investigate why a function has been left out, look for
> "skipping" verbose output like this:
> 
> skipping addition of 'access_error'(access_error) due to multiple
> inconsistent function prototypes
> skipping addition of
> 'acpi_ex_convert_to_object_type_string'(acpi_ex_convert_to_object_type_string.isra.0)
> due to unexpected register used for parameter

Ah, that's nice. Let me try.

> 
> FWIW I see most of the below in my BTF output on bpf-next, though I am
> missing a few, possibly due to differing config options since they don't
> appear in kallsyms either. I don't see the DWARF tag label not handled
> messages so it's possible that's a symptom of something
> 
> I suspect however some form of corruption in the DWARF representation
> may be the reason a lot of these are missing. Would be worth trying
> to "objdump -g vmlinux >vmlinux.dwarf" (file will be huge tho) I suspect.

OK, let me dump the dwarf and check what information it has for "kfree".

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

