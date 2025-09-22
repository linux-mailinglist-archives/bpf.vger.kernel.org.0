Return-Path: <bpf+bounces-69179-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F3BB8F327
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 08:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B892C172BF1
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 06:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C873298CD5;
	Mon, 22 Sep 2025 06:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="laqNe9yZ"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1675C24167A;
	Mon, 22 Sep 2025 06:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758523988; cv=none; b=gV54gZIQimfW6Zk4dv4lflPMkFhTeCdSz2KqIIMWKAcdBWO1twA/lF2pG+WN7BMiGNA1D3k7bxEPeEfMujbh6rMnB3qVxHTLTafMGze5UHiaOumj1JAyvViNgdfYttKzkAHu7Yc0ilv06CDkyOEyCk8MFwWnmcsR0ldbdaH3YyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758523988; c=relaxed/simple;
	bh=Z9SzlnSaNkil4Uciv97Oc+wza+qYCN+LUYBG6Se0PYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=atyvg0Xo2LtWjR1qGQhlXXLUXf39omJws06rX8P2VAwJ2N+8N3f6Fh3Q7B53ii8sESVZ0nnS+fPLwGGb3HAdMVXt2EnkwXc0cdnKwHnUNornVbQlj6akAODZP9CfdInHYEm7keO1W6+k0c+Mq1Z+Sw2/ipU+YnUaj5Wg05N+xpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=laqNe9yZ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nt5V0m/6qItzzOB7/4FsyRK1vmNf2/WoHA2kRpeeqMg=; b=laqNe9yZRchL9LbZ2kHPC3oCZO
	Y6LEAyDsEITEftd8JqCRe0zBPpRSE4Ly1u2pldD4D+/O9ufvdLJLoAekWGft97ydlnjmWYhzBm4h3
	E8mrvRrW7SVah7y3TtzpE28D/9epGuaO0yZsXVSLmqhVzUxr8E8E30lxekc8ttgC6WZC055zhdGq1
	KdtKwShmbyGlA6rtuJWtxpPYm87oMVHw+1rUt4nLAhNjSsMSKkZEyJwoKr5t29u42iKkRyh6KGnq6
	82OL18ehLYWIxqbWGrA5S+KQqMrt+beMgsOxwedqNmCMWPT90Or1YXNjRu5jdX01/DvLIUux1LwKI
	ARo1oAkQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0aPp-00000008FNC-1Jtv;
	Mon, 22 Sep 2025 06:52:51 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 45E07300230; Mon, 22 Sep 2025 08:52:48 +0200 (CEST)
Date: Mon, 22 Sep 2025 08:52:48 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Kees Cook <kees@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Mike Rapoport <rppt@kernel.org>, Andy Lutomirski <luto@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH] x86/ibt: make is_endbr() notrace
Message-ID: <20250922065248.GO3245006@noisy.programming.kicks-ass.net>
References: <20250918120939.1706585-1-dongml2@chinatelecom.cn>
 <20250918130543.GM3245006@noisy.programming.kicks-ass.net>
 <CADxym3ae8NGRt70rVO8ZyHa3BvWhczUkRs=dVn=rTRMVzrU9tA@mail.gmail.com>
 <CAADnVQ+hOdOpCR6s_GyO_7xxehCPBHSttidia38P5xFie6yjnw@mail.gmail.com>
 <20250918165935.GB3409427@noisy.programming.kicks-ass.net>
 <CAADnVQLP6-s_dtGpEcnFaVJfDW12rTOS2qk5k0Fyvn=4Gn7gBw@mail.gmail.com>
 <CADxym3Z6Ed5xjDMvh4ChRvrw_aLidkGrkgbK+076Exfmp=m3SA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADxym3Z6Ed5xjDMvh4ChRvrw_aLidkGrkgbK+076Exfmp=m3SA@mail.gmail.com>

On Fri, Sep 19, 2025 at 09:13:15AM +0800, Menglong Dong wrote:

> Ok, let me describe the problem in deetail.
> 
> First of all, it has nothing to do with kprobe. The bpf program of type
> kprobe-multi based on fprobe, and fprobe base on fgraph. So it's all
> about the ftrace, which means __fentry__.

Well, that's not confusing at all. Something called kprobe-multi not
being related to kprobes :-(

> Second, let me explain the recur detection of the kprobe-multi. Let's
> take the is_endbr() for example. When it is hooked by the bpf program
> of type kretprobe-multi, following calling chain will happen:
> 
>   is_endbr -> __ftrace_return_to_handler -> fprobe_return ->
>   kprobe_multi_link_exit_handler -> ftrace_get_entry_ip ->
>   arch_ftrace_get_symaddr -> is_endbr
> 
> Look, is_endbr() is called again during the ftrace handler, so it will
> trigger the ftrace handler(__ftrace_return_to_handler) again, which
> causes recurrence.

Right.

> Such recurrence can be detected. In kprobe_multi_link_prog_run(),
> the percpu various "bpf_prog_active" will be increased by 1 before we
> run the bpf progs, and decrease by 1 after the bpf progs finish. If the
> kprobe_multi_link_prog_run() is triggered again during bpf progs run,
> it will check if bpf_prog_active is zero, and return directly if it is not.
> Therefore, recurrence can't happen within the "bpf_prog_active" protection.

As I think Masami already said, the problem is the layer. You're trying
to fix an ftrace problem at the bpf layer.

> However, the calling to is_endbr() is not within that scope, which makes
> the recurrence happen.

Sorta, I'm still sketchy on the whole kprobe-multi thing.

Anyway, I don't mind making is_endbr() invisible to tracing, that might
just have security benefits too. But I think first the ftrace folks need
to figure out how to best kill that recursion, because I don't think
is_endbr is particularly special here.

It is just one more function that can emit a __fentry__ site.

Anyway, something like the below would do:

Note that without making __is_endbr() __always_inline, you run the risk
of the compiler being retarded (they often are in the face of
KASAN/UBSAN like) and deciding to out-of-line that function, resulting
in yet another __fentry__ site.

An added advantage of noinstr is that it is validated by objtool to
never call to !noinstr code. As such, you can be sure there is no
instrumentation in it.

(the below hasn't been near a compiler)

---
 arch/x86/include/asm/ibt.h    | 2 +-
 arch/x86/kernel/alternative.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/ibt.h b/arch/x86/include/asm/ibt.h
index 5e45d6424722..54937a527042 100644
--- a/arch/x86/include/asm/ibt.h
+++ b/arch/x86/include/asm/ibt.h
@@ -65,7 +65,7 @@ static __always_inline __attribute_const__ u32 gen_endbr_poison(void)
 	return 0xd6401f0f; /* nopl -42(%rax) */
 }
 
-static inline bool __is_endbr(u32 val)
+static __always_inline bool __is_endbr(u32 val)
 {
 	if (val == gen_endbr_poison())
 		return true;
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 69fb818df2ee..f791e7abd466 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1108,7 +1108,7 @@ void __init_or_module noinline apply_returns(s32 *start, s32 *end) { }
 
 #ifdef CONFIG_X86_KERNEL_IBT
 
-__noendbr bool is_endbr(u32 *val)
+__noendbr noinstr bool is_endbr(u32 *val)
 {
 	u32 endbr;
 

