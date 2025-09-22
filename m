Return-Path: <bpf+bounces-69180-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7161BB8F3FB
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 09:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67FFC4203EF
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 07:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAB72F0C7B;
	Mon, 22 Sep 2025 07:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iofdB136"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC0F2F0C6F
	for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 07:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758525232; cv=none; b=M8ZiHxko8jHUznWukc/sLoBia/duuHtjjkSYgnR6llNchTryw9kGMRUwmQRGKwht51KKakGrtopLuQ9MqVbN4QAbTSRJm273gng7ERGvPpymvNIdfiAzmkGymU6+Pw5bE9sSKGsMuGUuokgbEonMr5jzK3WKUBHCnXeWI6NQNXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758525232; c=relaxed/simple;
	bh=lByWE2yrIj/KaVHMm9tlp9i8EGd1lYaBrckS5Va/18Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ND5CoL7RIZVxskq1lwSLmywu6X4/EnFSPXrLVMDbqiPtQ7bBbB3NbflIXjBBFAHwVxBYwXknKD+LahR/1YZZCFikdKuSFaVaAqiUwJyiHWC8BhxkxrguIMxdpyOhRlf5+rvfGCznxbW518pS/rzIS2xDvF0S9lWSIC8EQo3wYPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iofdB136; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758525227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yfgv0EIskhtqw6KMs4nscyueRQky2Ah7ZOep6T6Ztks=;
	b=iofdB136N8yv4X+ZdUrNPwgOoOi9D47RVCpInrgdrUsiacyuLnrpQKBTgg8X43iHJfT/C/
	gwK6CPIHAF2mMJTfrv6E6h10V2KJuMs7bQzSK9sNK+Lp7eODqie4HswYZ+GZIm//i5cg86
	pMMVuEi36UJks3piec8prJg44Y9aSZM=
From: menglong.dong@linux.dev
To: Peter Zijlstra <peterz@infradead.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Jiri Olsa <jolsa@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <kees@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Mike Rapoport <rppt@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH] x86/ibt: make is_endbr() notrace
Date: Mon, 22 Sep 2025 15:13:38 +0800
Message-ID: <6196970.lOV4Wx5bFT@7940hx>
In-Reply-To: <20250922065248.GO3245006@noisy.programming.kicks-ass.net>
References:
 <20250918120939.1706585-1-dongml2@chinatelecom.cn>
 <CADxym3Z6Ed5xjDMvh4ChRvrw_aLidkGrkgbK+076Exfmp=m3SA@mail.gmail.com>
 <20250922065248.GO3245006@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/9/22 14:52 Peter Zijlstra <peterz@infradead.org> write:
> On Fri, Sep 19, 2025 at 09:13:15AM +0800, Menglong Dong wrote:
> 
> > Ok, let me describe the problem in deetail.
> > 
> > First of all, it has nothing to do with kprobe. The bpf program of type
> > kprobe-multi based on fprobe, and fprobe base on fgraph. So it's all
> > about the ftrace, which means __fentry__.
> 
> Well, that's not confusing at all. Something called kprobe-multi not
> being related to kprobes :-(
> 
> > Second, let me explain the recur detection of the kprobe-multi. Let's
> > take the is_endbr() for example. When it is hooked by the bpf program
> > of type kretprobe-multi, following calling chain will happen:
> > 
> >   is_endbr -> __ftrace_return_to_handler -> fprobe_return ->
> >   kprobe_multi_link_exit_handler -> ftrace_get_entry_ip ->
> >   arch_ftrace_get_symaddr -> is_endbr
> > 
> > Look, is_endbr() is called again during the ftrace handler, so it will
> > trigger the ftrace handler(__ftrace_return_to_handler) again, which
> > causes recurrence.
> 
> Right.
> 
> > Such recurrence can be detected. In kprobe_multi_link_prog_run(),
> > the percpu various "bpf_prog_active" will be increased by 1 before we
> > run the bpf progs, and decrease by 1 after the bpf progs finish. If the
> > kprobe_multi_link_prog_run() is triggered again during bpf progs run,
> > it will check if bpf_prog_active is zero, and return directly if it is not.
> > Therefore, recurrence can't happen within the "bpf_prog_active" protection.
> 
> As I think Masami already said, the problem is the layer. You're trying
> to fix an ftrace problem at the bpf layer.

Yeah, I see. And Masami has already posted a series for this
problem in:

https://lore.kernel.org/bpf/175852291163.307379.14414635977719513326.stgit@devnote2/

> 
> > However, the calling to is_endbr() is not within that scope, which makes
> > the recurrence happen.
> 
> Sorta, I'm still sketchy on the whole kprobe-multi thing.
> 
> Anyway, I don't mind making is_endbr() invisible to tracing, that might
> just have security benefits too. But I think first the ftrace folks need
> to figure out how to best kill that recursion, because I don't think
> is_endbr is particularly special here.

So, does this patch seem useful after all?

OK, I'll send a V2 base on your following suggestion.

Thanks!
Menglong Dong

> 
> It is just one more function that can emit a __fentry__ site.
> 
> Anyway, something like the below would do:
> 
> Note that without making __is_endbr() __always_inline, you run the risk
> of the compiler being retarded (they often are in the face of
> KASAN/UBSAN like) and deciding to out-of-line that function, resulting
> in yet another __fentry__ site.
> 
> An added advantage of noinstr is that it is validated by objtool to
> never call to !noinstr code. As such, you can be sure there is no
> instrumentation in it.
> 
> (the below hasn't been near a compiler)
> 
> ---
>  arch/x86/include/asm/ibt.h    | 2 +-
>  arch/x86/kernel/alternative.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/ibt.h b/arch/x86/include/asm/ibt.h
> index 5e45d6424722..54937a527042 100644
> --- a/arch/x86/include/asm/ibt.h
> +++ b/arch/x86/include/asm/ibt.h
> @@ -65,7 +65,7 @@ static __always_inline __attribute_const__ u32 gen_endbr_poison(void)
>  	return 0xd6401f0f; /* nopl -42(%rax) */
>  }
>  
> -static inline bool __is_endbr(u32 val)
> +static __always_inline bool __is_endbr(u32 val)
>  {
>  	if (val == gen_endbr_poison())
>  		return true;
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index 69fb818df2ee..f791e7abd466 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -1108,7 +1108,7 @@ void __init_or_module noinline apply_returns(s32 *start, s32 *end) { }
>  
>  #ifdef CONFIG_X86_KERNEL_IBT
>  
> -__noendbr bool is_endbr(u32 *val)
> +__noendbr noinstr bool is_endbr(u32 *val)
>  {
>  	u32 endbr;
>  
> 
> 





