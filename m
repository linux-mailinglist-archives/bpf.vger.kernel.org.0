Return-Path: <bpf+bounces-76643-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A994CBFF34
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 22:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2CC1302629E
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 21:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEC43376AA;
	Mon, 15 Dec 2025 21:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tOwpuTQj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E54242D8E;
	Mon, 15 Dec 2025 21:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765834312; cv=none; b=Y71IbH5CKiceaZYhgiMbJLIPM//TrEtTj0zDoFmIgY6z8aYn4/gFyn5DGqf7NJFLaHknXxmyAg5D2hNtf2oNL4KzZ3cHDUx+93gwHvlv4crMc/gHwiZsLiDfuu4dhvmk+dlgDyp3/o7XVBGQJPJyN9gw+YnhfTd9+WOb4JikGl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765834312; c=relaxed/simple;
	bh=94yh35skFQRhjv5U7XWUf6dBriC1tan73BbLvp3rfis=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=IhRzAhtTqk4qpc1h/zyVYyse/eQ6JsFOd1QAFl+l7FWd2mLDclLmZcbc4ZhG0ViHHvJnho0mTIuyyr4pmxodpnGW670r19AC3co5VIXJ/m5g+ZVVNO7oN1JKsW2icKxwrAESsQDwEC1zDOxnhE+U5FiC3QrgBchmB2vmF74hW4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tOwpuTQj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ECE9C4CEF5;
	Mon, 15 Dec 2025 21:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765834311;
	bh=94yh35skFQRhjv5U7XWUf6dBriC1tan73BbLvp3rfis=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=tOwpuTQj02P4K7WTE9UmP4XWblTmcWF+wyJkkjCwTLgOkXCE9CzLXcpJ8bUWeth/n
	 nCEp5vlIR8qsS0w/vBhKII6NkYhjlTZnVNcdAfNFZDO6UkQ87cl+X9z0FFDcBj1rLR
	 ofZxrIWJQjk34mx8Ozh2mBD54m9iB7jBuCgxAOSQphMWbsWJ2Y5wPe/Td5K0ZuSp2A
	 SMg1w3zuV6bRMe0++QbtMIQfFgE1OZ37xjIzUcC3W8HGNQxgU6kCDPRbMeI5C3ldar
	 uDxC9Fxl96fg+DhWpElevoFPAnujIZIw+x+/j7CVZ2EZrbf9Ib9UhRQ/3jyON2/mpp
	 oQMY3lqAQG+aQ==
Content-Type: multipart/mixed; boundary="===============1830485644968437842=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <95c13c0b793604796037ca67c191e1bfce22770dd020107c7179a698c5d49b91@mail.kernel.org>
In-Reply-To: <20251215211402.353056-2-jolsa@kernel.org>
References: <20251215211402.353056-2-jolsa@kernel.org>
Subject: Re: [PATCHv5 bpf-next 1/9] ftrace,bpf: Remove FTRACE_OPS_FL_JMP ftrace_ops flag
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,rostedt@kernel.org,revest@google.com,mark.rutland@arm.com
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-trace-kernel@vger.kernel.org,linux-arm-kernel@lists.infradead.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,menglong8.dong@gmail.com,song@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 15 Dec 2025 21:31:51 +0000 (UTC)

--===============1830485644968437842==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index 015dd1049bea..505b7d3f5641 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h

[ ... ]

> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index 976d89011b15..b9a358d7a78f 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -214,10 +214,15 @@ static int modify_fentry(struct bpf_trampoline *tr, u32 orig_flags,
>  	int ret;
>
>  	if (tr->func.ftrace_managed) {
> +		unsigned long addr = (unsigned long) new_addr;
> +
> +		if (bpf_trampoline_use_jmp(tr->flags))
> +			addr = ftrace_jmp_set(addr);
> +
>  		if (lock_direct_mutex)
> -			ret = modify_ftrace_direct(tr->fops, (long)new_addr);
> +			ret = modify_ftrace_direct(tr->fops, addr);
>  		else
> -			ret = modify_ftrace_direct_nolock(tr->fops, (long)new_addr);
> +			ret = modify_ftrace_direct_nolock(tr->fops, addr);
>  	} else {
>  		ret = bpf_trampoline_update_fentry(tr, orig_flags, old_addr,
>  						   new_addr);
> @@ -240,10 +245,15 @@ static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
>  	}
>
>  	if (tr->func.ftrace_managed) {
> +		unsigned long addr = (unsigned long) new_addr;
> +
> +		if (bpf_trampoline_use_jmp(tr->flags))
> +			addr = ftrace_jmp_set(addr);
> +
>  		ret = ftrace_set_filter_ip(tr->fops, (unsigned long)ip, 0, 1);
>  		if (ret)
>  			return ret;
> -		ret = register_ftrace_direct(tr->fops, (long)new_addr);
> +		ret = register_ftrace_direct(tr->fops, addr);
>  	} else {
>  		ret = bpf_trampoline_update_fentry(tr, 0, NULL, new_addr);
>  	}

After this change, register_ftrace_direct() receives an address with
the LSB bit already set (via ftrace_jmp_set) and stores it as-is in
entry->direct. This address then flows through to ftrace_find_rec_direct()
which returns entry->direct unchanged.

In available_filter_functions_show():

    direct = ftrace_find_rec_direct(rec->ip);
    if (direct)
        seq_printf(m, "\n\tdirect-->%pS", (void *)direct);

Can the debug output show misleading symbol offsets? When the LSB is
set, %pS will resolve addresses like "function+0x1" instead of just
"function". This makes ftrace debug output harder to read for users
trying to understand direct call attachments.

The fix would be to strip the LSB bit before printing:
    seq_printf(m, "\n\tdirect-->%pS", (void *)ftrace_jmp_get(direct));

[ ... ]

> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index bbb37c0f8c6c..b0dc911411f1 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -6017,15 +6017,8 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
>  	if (ftrace_hash_empty(hash))
>  		return -EINVAL;
>
> -	/* This is a "raw" address, and this should never happen. */
> -	if (WARN_ON_ONCE(ftrace_is_jmp(addr)))
> -		return -EINVAL;
> -
>  	mutex_lock(&direct_mutex);
>
> -	if (ops->flags & FTRACE_OPS_FL_JMP)
> -		addr = ftrace_jmp_set(addr);
> -
>  	/* Make sure requested entries are not already registered.. */
>  	size = 1 << hash->size_bits;
>  	for (i = 0; i < size; i++) {

[ ... ]

> @@ -6146,13 +6139,6 @@ __modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
>
>  	lockdep_assert_held_once(&direct_mutex);
>
> -	/* This is a "raw" address, and this should never happen. */
> -	if (WARN_ON_ONCE(ftrace_is_jmp(addr)))
> -		return -EINVAL;
> -
> -	if (ops->flags & FTRACE_OPS_FL_JMP)
> -		addr = ftrace_jmp_set(addr);
> -
>  	/* Enable the tmp_ops to have the same functions as the direct ops */
>  	ftrace_ops_init(&tmp_ops);
>  	tmp_ops.func_hash = ops->func_hash;

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20247816064

--===============1830485644968437842==--

