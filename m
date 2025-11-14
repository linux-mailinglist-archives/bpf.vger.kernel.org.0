Return-Path: <bpf+bounces-74503-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B840AC5CC25
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 12:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D570B4ED4C8
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 10:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B35C311973;
	Fri, 14 Nov 2025 10:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fPJZIzVS"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3554431326D
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 10:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763117885; cv=none; b=jTYvBdOJ3K69Tz0VxO5BZT1S7oCUeN2HwPJcx0fFaLQ38ub0Hb5mluYJ2IFlZPPweoycq/CFU7xxrISNnJ3PJUNvf/fx4LM12QVkZMJ3m+aB+r0L/bF/pverR8wGNypbZfZnHZN3/BEOpDyqE4PQcCCLJNIZIXdH+ifjZRTH5so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763117885; c=relaxed/simple;
	bh=RStJmHuPeKnwSf6qoYdAdwLaQyI68rQLlSFSnWyWriE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cre2MMH8wtkYf4GLaK9UerYWi6DKd2n9Xnb/GNYXETTQ05//XPYqFf7wwZeWqfvJSNfh15T0hBO/egG3v5wkjXQu7u7dYdlp8s86mdJ2ka5VhqcEMhJzRqcOFNk5wKCJCL0/f8zy+GdbHNq9sKVf0iLD8HewLwIN0A0401qCjek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fPJZIzVS; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763117878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X+lmYwQfG04D3EvuE1U4vVsaclhafeMzmv/psDlOmVs=;
	b=fPJZIzVS5MDVtAmbfnnHH3nqT0GDTJgSdU879m0hLLlopE1xMkE+mp5SRPDOvEZaW/qYKE
	hXDzGxQiQYRGIGYzW2qbGM4uzwRRECW/KPJH1OflDJEX4NIQLowO7KLblo8yk255n8eIbv
	sApHAqsWznVNZus/KHK5NkAHQW2HN7U=
From: Menglong Dong <menglong.dong@linux.dev>
To: menglong8.dong@gmail.com, ast@kernel.org, rostedt@goodmis.org,
 bot+bpf-ci@kernel.org
Cc: daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, mhiramat@kernel.org,
 mark.rutland@arm.com, mathieu.desnoyers@efficios.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev,
 clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH RFC bpf-next 1/7] ftrace: introduce FTRACE_OPS_FL_JMP
Date: Fri, 14 Nov 2025 18:57:39 +0800
Message-ID: <1946607.CQOukoFCf9@7950hx>
In-Reply-To:
 <aa9a271384d9850c42f9331b03d736b2fd1dd7c00446460f0ecc19cb32e9f117@mail.kernel.org>
References:
 <20251114092450.172024-2-dongml2@chinatelecom.cn>
 <aa9a271384d9850c42f9331b03d736b2fd1dd7c00446460f0ecc19cb32e9f117@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/11/14 18:20, bot+bpf-ci@kernel.org wrote:
> > diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> > index 7ded7df6e..14705dec1 100644
> > --- a/include/linux/ftrace.h
> > +++ b/include/linux/ftrace.h
> > @@ -351,6 +351,7 @@ enum {
> >  	FTRACE_OPS_FL_DIRECT			= BIT(17),
> >  	FTRACE_OPS_FL_SUBOP			= BIT(18),
> >  	FTRACE_OPS_FL_GRAPH			= BIT(19),
> > +	FTRACE_OPS_FL_JMP			= BIT(20),
> >  };
> >
> >  #ifndef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
> 
> [ ... ]
> 
> > +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_JMP
> > +static inline bool ftrace_is_jmp(unsigned long addr)
> > +{
> > +	return addr & 1;
> > +}
> > +
> > +static inline unsigned long ftrace_jmp_set(unsigned long addr)
> > +{
> > +	return addr | 1UL;
> > +}
> > +
> > +static inline unsigned long ftrace_jmp_get(unsigned long addr)
> > +{
> > +	return addr & ~1UL;
> > +}
> 
> [ ... ]
> 
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index 42bd2ba68..b143a79e6 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> > @@ -5938,7 +5938,8 @@ static void remove_direct_functions_hash(struct ftrace_hash *hash, unsigned long
> >  	for (i = 0; i < size; i++) {
> >  		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
> >  			del = __ftrace_lookup_ip(direct_functions, entry->ip);
> > -			if (del && del->direct == addr) {
> > +			if (del && ftrace_jmp_get(del->direct) ==
> > +				   ftrace_jmp_get(addr)) {
> >  				remove_hash_entry(direct_functions, del);
> >  				kfree(del);
> >  			}
> 
> [ ... ]
> 
> > @@ -5994,6 +5995,9 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
> >
> >  	mutex_lock(&direct_mutex);
> >
> > +	if (ops->flags & FTRACE_OPS_FL_JMP)
> > +		addr = ftrace_jmp_set(addr);
> > +
> 
> When FTRACE_OPS_FL_JMP is set, this encodes the flag into the last bit
> of addr. The modified addr is then stored in entry->direct and
> ops->direct_call. However, this flagged address later flows through
> ftrace_find_rec_direct()->ftrace_get_addr_new()->ftrace_make_call()->
> ftrace_call_replace() without being masked.
> 
> Can ftrace_call_replace() generate correct CALL instructions when addr
> has the LSB set? On x86, ftrace_call_replace() calls text_gen_insn()
> with the raw address to generate a relative CALL instruction. If addr
> has bit 0 set to 1, this would generate a CALL to an odd address,
> causing execution to skip the first instruction byte at the trampoline.

If DYNAMIC_FTRACE_WITH_JMP is not enabled, ftrace_jmp_set() will
return the addr directly, so it's OK on this case. When
DYNAMIC_FTRACE_WITH_JMP is enabled, take x86_64 for example
in the next patch, it will get the real address in ftrace_call_replace()
with ftrace_jmp_get().

The arch-specification things is split to the next patch.

> 
> Similarly, at runtime call_direct_funcs() reads ops->direct_call and
> passes it to arch_ftrace_set_direct_caller() without masking. The x86
> assembly then does RET to this address, which would jump to addr+1 if
> the LSB is set.
> 
> The commit message says "we can tell if we should use 'jmp' for the
> callback in ftrace_call_replace()" but ftrace_call_replace() isn't
> modified to check or mask the bit. Are there missing changes to handle
> the encoded address in these paths?

It is modified in the next patch. And in order to reduce the risk, we
can wrap the code here with CONFIG_DYNAMIC_FTRACE_WITH_JMP.

> 
> >  	/* Make sure requested entries are not already registered.. */
> >  	size = 1 << hash->size_bits;
> >  	for (i = 0; i < size; i++) {
> 
> [ ... ]
> 
> > @@ -6117,6 +6121,9 @@ __modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
> >
> >  	lockdep_assert_held_once(&direct_mutex);
> >
> > +	if (ops->flags & FTRACE_OPS_FL_JMP)
> > +		addr = ftrace_jmp_set(addr);
> > +
> 
> Same issue here - the flagged addr is stored but downstream consumers
> don't mask it before using as a jump target.
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19360353328
> 





