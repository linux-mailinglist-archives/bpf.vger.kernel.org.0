Return-Path: <bpf+bounces-32205-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD7B909329
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 22:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E4E11C229C5
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 20:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9AE71A3BB2;
	Fri, 14 Jun 2024 20:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZhA5TST"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B11383;
	Fri, 14 Jun 2024 20:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718395653; cv=none; b=CkQ9fJkbB0cfZI3hIyMTwUEsT+43SN+bWni3jHCp3YV9TTSGSoLH0VyhfcDXsoXX/QfTar8/98mxnGkgE3PMyADRtEjM+rmwVgqeG8CEuWDqsMeZC2weR0OMIGRVNhsDKezcQJTDWM1FC5Q7/DbVRbb9U9bm3FB4+HdC9U9D3L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718395653; c=relaxed/simple;
	bh=TLgK8xBlI7oOA+HqaXRUGCcZgq0Lk85TpQM6TQ5u5vE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gH2zv9FnV2CS9yEHimQSpjZCi4QouJkRkEFf14VOucO/3xDEwah7pZrH+d7xmoPoPTQm+P0Ya2r0dyOAJflLXEEufJIrVbQb050NxtKUTYmVWOULVtrf7mg87b+ZhQCvNlM6HIc7ROMY/6ohQZUXe9lzF/isD77tOG6znSROO4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZhA5TST; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 286B3C2BD10;
	Fri, 14 Jun 2024 20:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718395652;
	bh=TLgK8xBlI7oOA+HqaXRUGCcZgq0Lk85TpQM6TQ5u5vE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UZhA5TSTgrFRJ9dD/QT1sJgzGt5IJQ3Hcb3774r5mwGZYvh/ncQlMr12G/49O+ype
	 woKnX70Axer069t3Z9L5exZ4HcTk/JxiG0Eb8RGIOGIsEtlmcW2eAMaHh4fjyMSkWb
	 q6wBuNUF0k8Z/k+R0lQaFNhZ+37igEYeTZJcUR6xOC8Bdl2VqDl3GM+ptzECnNRb0I
	 iKLXF6C9qJQDnwCgpsAGlTHRyfsP5gK2JP5rtTGYiq2raFrsq2vMMWWOJcMVxnE2wD
	 dgQW2njMxCFVpGMA8A/dXKzSja2vd0kgSJTTX+4fmQimKe1AdetaN2pC8zpqLDuVev
	 +f/LKzF10mpgw==
Date: Fri, 14 Jun 2024 13:07:29 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	linux-man@vger.kernel.org, x86@kernel.org, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev
Subject: Re: [PATCHv8 bpf-next 3/9] uprobe: Add uretprobe syscall to speed up
 return probe
Message-ID: <20240614200729.GA1585004@thelio-3990X>
References: <20240611112158.40795-1-jolsa@kernel.org>
 <20240611112158.40795-4-jolsa@kernel.org>
 <20240614174822.GA1185149@thelio-3990X>
 <ZmyZgzqsowkGyqmH@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmyZgzqsowkGyqmH@krava>

On Fri, Jun 14, 2024 at 09:26:59PM +0200, Jiri Olsa wrote:
> On Fri, Jun 14, 2024 at 10:48:22AM -0700, Nathan Chancellor wrote:
> > Hi Jiri,
> > 
> > On Tue, Jun 11, 2024 at 01:21:52PM +0200, Jiri Olsa wrote:
> > > Adding uretprobe syscall instead of trap to speed up return probe.
> > ...
> > > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > > index 2c83ba776fc7..2816e65729ac 100644
> > > --- a/kernel/events/uprobes.c
> > > +++ b/kernel/events/uprobes.c
> > > @@ -1474,11 +1474,20 @@ static int xol_add_vma(struct mm_struct *mm, struct xol_area *area)
> > >  	return ret;
> > >  }
> > >  
> > > +void * __weak arch_uprobe_trampoline(unsigned long *psize)
> > > +{
> > > +	static uprobe_opcode_t insn = UPROBE_SWBP_INSN;
> > 
> > This change as commit ff474a78cef5 ("uprobe: Add uretprobe syscall to
> > speed up return probe") in -next causes the following build error for
> > ARCH=loongarch allmodconfig:
> > 
> >   In file included from include/linux/uprobes.h:49,
> >                    from include/linux/mm_types.h:16,
> >                    from include/linux/mmzone.h:22,
> >                    from include/linux/gfp.h:7,
> >                    from include/linux/xarray.h:16,
> >                    from include/linux/list_lru.h:14,
> >                    from include/linux/fs.h:13,
> >                    from include/linux/highmem.h:5,
> >                    from kernel/events/uprobes.c:13:
> >   kernel/events/uprobes.c: In function 'arch_uprobe_trampoline':
> >   arch/loongarch/include/asm/uprobes.h:12:33: error: initializer element is not constant
> >      12 | #define UPROBE_SWBP_INSN        larch_insn_gen_break(BRK_UPROBE_BP)
> >         |                                 ^~~~~~~~~~~~~~~~~~~~
> >   kernel/events/uprobes.c:1479:39: note: in expansion of macro 'UPROBE_SWBP_INSN'
> >    1479 |         static uprobe_opcode_t insn = UPROBE_SWBP_INSN;
> 
> reproduced, could you please try the change below

Yeah, that fixes the issue for me.

Tested-by: Nathan Chancellor <nathan@kernel.org> # build

> ---
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 2816e65729ac..6986bd993702 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1476,8 +1476,9 @@ static int xol_add_vma(struct mm_struct *mm, struct xol_area *area)
>  
>  void * __weak arch_uprobe_trampoline(unsigned long *psize)
>  {
> -	static uprobe_opcode_t insn = UPROBE_SWBP_INSN;
> +	static uprobe_opcode_t insn;
>  
> +	insn = insn ?: UPROBE_SWBP_INSN;
>  	*psize = UPROBE_SWBP_INSN_SIZE;
>  	return &insn;
>  }

