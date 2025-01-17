Return-Path: <bpf+bounces-49163-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 921B2A14AA0
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 09:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C66027A304B
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 08:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EA11F869D;
	Fri, 17 Jan 2025 08:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="alw3DPVp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFCC1F8670;
	Fri, 17 Jan 2025 08:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737100958; cv=none; b=RdGDE/zzMCGn1WpfJrhHeyAaIw1moho+/8Leyj7apMuW44SugS2isvyJ7QmzIQW0Bm9bXSR1tQqlEds9qWTBIUWZXbMGciKooGDuNiQ5WeVUqIyilSVJxXhZacm2bfw3EoqwDEbcoBAfFRJdSsBqHxDeO4Rybw7QsUpTIWgXjk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737100958; c=relaxed/simple;
	bh=aPT8laPvdO1MFb5MDe4rtjsTWRGWV6Y+cK6r0wH3r20=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=lQTd3IYB2cR/PBlaiF31raG//h7JnFXo3M8D61CZpAYdrOCDushato6U0N5uTLds3zjfwGYfGS3qaeRXOmQSC6StsEMfcqE2QTSIQQq2feof7GLDmFf36lkVC3hXOAnwwkj67lYp+EGjFnvSH+8Ps7zFLpoYLv73d+5qe3cdTrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=alw3DPVp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B8AC4CEDD;
	Fri, 17 Jan 2025 08:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737100957;
	bh=aPT8laPvdO1MFb5MDe4rtjsTWRGWV6Y+cK6r0wH3r20=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=alw3DPVpkmqKCLEXlKtnb4/zzX5jnDOON8U5Xba/hlhc9f/Uc/U2sxrZ+8hySDkn+
	 mC9keN0/rVlHz/o8xdLU/tq4nVpWBzN9JZzWr+wF5cch7m2ksxnw4wQ/oyjBOgz840
	 kryONvArc770EGxwgyIps+hPGVnwytTkJfFbvv+BYDKLq03c7Mfhor+qDSkUSCPkNE
	 akXH/Fletgzux0bwgPYs8BBvRPQQ0oQwF898TnDXyEziQtgOx1efQtk9Php4rtJ6Qq
	 9Im7KRI/ewyBPy8h2qxEKsX767+9xWnyl07hcfOMDRqQeBFW2fnOl+FYQCfGXJ25Vc
	 URDiJeGNgCy3w==
Date: Fri, 17 Jan 2025 17:02:29 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Eyal Birger <eyal.birger@gmail.com>, kees@kernel.org,
 luto@amacapital.net, wad@chromium.org, mhiramat@kernel.org,
 andrii@kernel.org, jolsa@kernel.org, alexei.starovoitov@gmail.com,
 olsajiri@gmail.com, cyphar@cyphar.com, songliubraving@fb.com, yhs@fb.com,
 john.fastabend@gmail.com, peterz@infradead.org, tglx@linutronix.de,
 bp@alien8.de, daniel@iogearbox.net, ast@kernel.org,
 andrii.nakryiko@gmail.com, rostedt@goodmis.org, rafi@rbk.io,
 shmulik.ladkani@gmail.com, bpf@vger.kernel.org, linux-api@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] seccomp: passthrough uretprobe systemcall without
 filtering
Message-Id: <20250117170229.f1e1a9f03a8547d31cd875db@kernel.org>
In-Reply-To: <20250117013927.GB2610@redhat.com>
References: <20250117005539.325887-1-eyal.birger@gmail.com>
	<20250117013927.GB2610@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Jan 2025 02:39:28 +0100
Oleg Nesterov <oleg@redhat.com> wrote:

> On 01/16, Eyal Birger wrote:
> >
> > Fixes: ff474a78cef5 ("uprobe: Add uretprobe syscall to speed up return probe")
> > Reported-by: Rafael Buchbinder <rafi@rbk.io>
> > Link: https://lore.kernel.org/lkml/CAHsH6Gs3Eh8DFU0wq58c_LF8A4_+o6z456J7BidmcVY2AqOnHQ@mail.gmail.com/
> > Cc: stable@vger.kernel.org
> ...
> > @@ -1359,6 +1359,11 @@ int __secure_computing(const struct seccomp_data *sd)
> >  	this_syscall = sd ? sd->nr :
> >  		syscall_get_nr(current, current_pt_regs());
> >
> > +#ifdef CONFIG_X86_64
> > +	if (unlikely(this_syscall == __NR_uretprobe) && !in_ia32_syscall())
> > +		return 0;
> > +#endif
> 
> Acked-by: Oleg Nesterov <oleg@redhat.com>
> 
> 
> A note for the seccomp maintainers...
> 
> I don't know what do you think, but I agree in advance that the very fact this
> patch adds "#ifdef CONFIG_X86_64" into __secure_computing() doesn't look nice.
> 

Indeed. in_ia32_syscall() depends arch/x86 too.
We can add an inline function like;

``` uprobes.h
static inline bool is_uprobe_syscall(int syscall)
{
	// arch_is_uprobe_syscall check can be replaced by Kconfig,
	// something like CONFIG_ARCH_URETPROBE_SYSCALL.
#ifdef arch_is_uprobe_syscall
	return arch_is_uprobe_syscall(syscall)
#else
	return false;
#endif
}
```
and 
``` arch/x86/include/asm/uprobes.h
#define arch_is_uprobe_syscall(syscall) \
	(IS_ENABLED(CONFIG_X86_64) && syscall == __NR_uretprobe && !in_ia32_syscall())
```

> The problem is that we need a simple patch for -stable which fixes the real
> problem. We can cleanup this logic later, I think.

Hmm, at least we should make it is_uprobe_syscall() in uprobes.h so that
do not pollute the seccomp subsystem with #ifdef.

Thank you,



> 
> Oleg.
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

