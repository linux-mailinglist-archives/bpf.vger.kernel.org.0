Return-Path: <bpf+bounces-74499-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 02743C5C8E8
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 11:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F36B2351C8B
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 10:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726AD3101D4;
	Fri, 14 Nov 2025 10:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4zMtOvx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F3730FF08;
	Fri, 14 Nov 2025 10:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763115627; cv=none; b=VjD9iqVuVF26YNjxtYCcIqkULqBn+OecpMl6yCTMKQ1BIIz/1xkGcr3qlOYjGbegT2oXuA+3aJgCAEJO8X0vy0Qa2KnRpFX1q+xQYax96xqNONIuv1V3aGNUaQuN465W+S7eZDFCRNS+QXHPL9J7T7ZtXk6WtDiQtNrEXmSH8ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763115627; c=relaxed/simple;
	bh=TY0ymHuBdMqmebZHnM7FcU0Eo3KSRX3k/0/xn2IK1+Y=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=JMwdQyw9I1/Bncp1NcmhYyXs3hK02Nvybf8U1oJcCPNVKrcFAHWBHf3ZL5XG495vORXHfDUhAqLMWWXKYlLEmYxOGDlC4/ztOqBF8U2Fn+xt78+JiYehRH4gy6AJ/vJjPiPIUr61MwWiEerv4kOU9VDDMn+pHS6ROwBmIUi3AZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4zMtOvx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07DBEC113D0;
	Fri, 14 Nov 2025 10:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763115626;
	bh=TY0ymHuBdMqmebZHnM7FcU0Eo3KSRX3k/0/xn2IK1+Y=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=J4zMtOvxpH0ZRVCMDvGHUtyrT67HuRTg2O7Y+pzB0wsCnltoViC1PirzhF292SETp
	 U9OwTUce4p97/VTfRFEoXVqM4UIzLC7K7D5iVg1rSkNKVkQicmhGiPFSWqpK9mqf6M
	 ONd1919T+F7emP6NVnI4AHNq8qRvUP3BOAk0srOWY9gC/9NZIKbjJuLg507OeY0Zz3
	 bW42YSQwN3oCGID4SsFS/wRQkadThLl8An7FtaHo0Eos2QI9C7rDFBaACBZfZWeUby
	 KBBEDi7c7ks81kBan32RfDIkvxBbhoaZhwpXoTSP6BR1ApJD+OwMvqlEkkY46GFTYu
	 8OsZyz5EazNxA==
Content-Type: multipart/mixed; boundary="===============5882312184874533254=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <aa9a271384d9850c42f9331b03d736b2fd1dd7c00446460f0ecc19cb32e9f117@mail.kernel.org>
In-Reply-To: <20251114092450.172024-2-dongml2@chinatelecom.cn>
References: <20251114092450.172024-2-dongml2@chinatelecom.cn>
Subject: Re: [PATCH RFC bpf-next 1/7] ftrace: introduce FTRACE_OPS_FL_JMP
From: bot+bpf-ci@kernel.org
To: menglong8.dong@gmail.com,ast@kernel.org,rostedt@goodmis.org
Cc: daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,mhiramat@kernel.org,mark.rutland@arm.com,mathieu.desnoyers@efficios.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-trace-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 14 Nov 2025 10:20:26 +0000 (UTC)

--===============5882312184874533254==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index 7ded7df6e..14705dec1 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -351,6 +351,7 @@ enum {
>  	FTRACE_OPS_FL_DIRECT			= BIT(17),
>  	FTRACE_OPS_FL_SUBOP			= BIT(18),
>  	FTRACE_OPS_FL_GRAPH			= BIT(19),
> +	FTRACE_OPS_FL_JMP			= BIT(20),
>  };
>
>  #ifndef CONFIG_DYNAMIC_FTRACE_WITH_ARGS

[ ... ]

> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_JMP
> +static inline bool ftrace_is_jmp(unsigned long addr)
> +{
> +	return addr & 1;
> +}
> +
> +static inline unsigned long ftrace_jmp_set(unsigned long addr)
> +{
> +	return addr | 1UL;
> +}
> +
> +static inline unsigned long ftrace_jmp_get(unsigned long addr)
> +{
> +	return addr & ~1UL;
> +}

[ ... ]

> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 42bd2ba68..b143a79e6 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -5938,7 +5938,8 @@ static void remove_direct_functions_hash(struct ftrace_hash *hash, unsigned long
>  	for (i = 0; i < size; i++) {
>  		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
>  			del = __ftrace_lookup_ip(direct_functions, entry->ip);
> -			if (del && del->direct == addr) {
> +			if (del && ftrace_jmp_get(del->direct) ==
> +				   ftrace_jmp_get(addr)) {
>  				remove_hash_entry(direct_functions, del);
>  				kfree(del);
>  			}

[ ... ]

> @@ -5994,6 +5995,9 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
>
>  	mutex_lock(&direct_mutex);
>
> +	if (ops->flags & FTRACE_OPS_FL_JMP)
> +		addr = ftrace_jmp_set(addr);
> +

When FTRACE_OPS_FL_JMP is set, this encodes the flag into the last bit
of addr. The modified addr is then stored in entry->direct and
ops->direct_call. However, this flagged address later flows through
ftrace_find_rec_direct()->ftrace_get_addr_new()->ftrace_make_call()->
ftrace_call_replace() without being masked.

Can ftrace_call_replace() generate correct CALL instructions when addr
has the LSB set? On x86, ftrace_call_replace() calls text_gen_insn()
with the raw address to generate a relative CALL instruction. If addr
has bit 0 set to 1, this would generate a CALL to an odd address,
causing execution to skip the first instruction byte at the trampoline.

Similarly, at runtime call_direct_funcs() reads ops->direct_call and
passes it to arch_ftrace_set_direct_caller() without masking. The x86
assembly then does RET to this address, which would jump to addr+1 if
the LSB is set.

The commit message says "we can tell if we should use 'jmp' for the
callback in ftrace_call_replace()" but ftrace_call_replace() isn't
modified to check or mask the bit. Are there missing changes to handle
the encoded address in these paths?

>  	/* Make sure requested entries are not already registered.. */
>  	size = 1 << hash->size_bits;
>  	for (i = 0; i < size; i++) {

[ ... ]

> @@ -6117,6 +6121,9 @@ __modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
>
>  	lockdep_assert_held_once(&direct_mutex);
>
> +	if (ops->flags & FTRACE_OPS_FL_JMP)
> +		addr = ftrace_jmp_set(addr);
> +

Same issue here - the flagged addr is stored but downstream consumers
don't mask it before using as a jump target.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19360353328

--===============5882312184874533254==--

