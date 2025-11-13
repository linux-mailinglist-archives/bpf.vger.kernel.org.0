Return-Path: <bpf+bounces-74404-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC73C578BA
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 14:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FD723A706E
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 13:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC31D346A1F;
	Thu, 13 Nov 2025 13:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LiqKhseE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2616734EEE8;
	Thu, 13 Nov 2025 13:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763038938; cv=none; b=PNwOQshYWcpgtTUg8LNrdP4e3TGbWjgz+z1VQd/2tRrr6RMbdMWBAbLQiwE6ZgaqIbfpRukp1ytNDlLxn1OdFSb8c6Mfw3uudSF/IaDW8I51YHaF/kM88+fxyLxjKaGp3+5gMF47DHIcdSRwwMtnLftUf2C056CHNoaFNMgzRBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763038938; c=relaxed/simple;
	bh=bUt+qNmjwdJ7gVejc5aNxtgCj7fJkFVLsF+93X0SgNw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=V3pv2pwsq9mw+YzdmlEqOMYd4OjMj6XMV0Jf/St3cwFFUie5W/A6Z6Ej/62GlMmoSoSLDGJq/AyZ9UneUJb1Oen3DGe1OAaBJIdqlrQRA3jYnB97Fdhgv+3fpKYlaglpfKCHZdvMUsELeAL8RoNNt58KUBvc2J2QzTntERrP0ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LiqKhseE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57F68C16AAE;
	Thu, 13 Nov 2025 13:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763038937;
	bh=bUt+qNmjwdJ7gVejc5aNxtgCj7fJkFVLsF+93X0SgNw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=LiqKhseE0ZjpKS3SHSmWzPRqgP937v6AY4LeZnP+KIPvP+UZ2rOH1rws/j6FxkNkb
	 EtIprRU7GTxCbIvwhETrdRO0FXpwgmLXL5cbx5y1dJllSYEQKDK8Q7vt1Krud9Vn3E
	 EgXPVlWeOfRyP4x9DElh4/lUP26erBP0mqdpoSE1w6EH/TRjpTZ8ad5aWjyfdh+HM+
	 Z60F55ydiIe0KHPUq7Zzjl+u9TJqitqalySBBfykuNTEIa7X3UQLjpG8Wg7p2k6471
	 CmOEtx8T4t/IaV/ZlwElGm+NwprmW4PKcdcLoqopYXqgLL8Q5tpXdYMdsngkPUumbe
	 GR2SYNl2UBvoQ==
Content-Type: multipart/mixed; boundary="===============0521505570487395101=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c3260fe9e3d8ad79c75a6e8281f9fae5580beb3fcdd08e2015f417e11ec0a1b2@mail.kernel.org>
In-Reply-To: <20251113123750.2507435-6-jolsa@kernel.org>
References: <20251113123750.2507435-6-jolsa@kernel.org>
Subject: Re: [PATCHv2 bpf-next 5/8] ftrace: Add update_ftrace_direct_mod function
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,rostedt@kernel.org,revest@google.com,mark.rutland@arm.com
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-trace-kernel@vger.kernel.org,linux-arm-kernel@lists.infradead.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,menglong8.dong@gmail.com,song@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 13 Nov 2025 13:02:17 +0000 (UTC)

--===============0521505570487395101==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index 433c36c3a..bacb6d9ab 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -544,6 +544,7 @@ int modify_ftrace_direct_nolock(struct ftrace_ops *ops, unsigned long addr);
>
>  int update_ftrace_direct_add(struct ftrace_ops *ops, struct ftrace_hash *hash);
>  int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace_hash *hash);
> +int update_ftrace_direct_mod(struct ftrace_ops *ops, struct ftrace_hash *hash, bool do_direct_lock);
>
>  void ftrace_stub_direct_tramp(void);
>
> @@ -581,6 +582,11 @@ int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace_hash *hash)
>  	return -ENODEV;
>  }
>
> +int modify_ftrace_direct_hash(struct ftrace_ops *ops, struct ftrace_hash *hash, bool do_direct_lock)
                ^^^^^^^^^^^^^^^^^^^^^^^^^^
The stub function name doesn't match the declaration. Should this be
update_ftrace_direct_mod() instead of modify_ftrace_direct_hash()?

> +{
> +	return -ENODEV;
> +}
> +

[ ... ]

> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 345f3fdd2..627d05b57 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -6445,6 +6445,74 @@ int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace_hash *hash)
>  	return err;
>  }
>
> +int update_ftrace_direct_mod(struct ftrace_ops *ops, struct ftrace_hash *hash, bool do_direct_lock)
> +{
> +	struct ftrace_hash *orig_hash = ops->func_hash->filter_hash;
> +	struct ftrace_func_entry *entry, *tmp;
> +	static struct ftrace_ops tmp_ops = {
> +		.func		= ftrace_stub,
> +		.flags		= FTRACE_OPS_FL_STUB,
> +	};
> +	unsigned long size, i;
> +	int err;
> +
> +	if (!hash_count(hash))
> +		return 0;
> +	if (check_direct_multi(ops))
> +		return -EINVAL;
> +	if (!(ops->flags & FTRACE_OPS_FL_ENABLED))
> +		return -EINVAL;
> +	if (direct_functions == EMPTY_HASH)
> +		return -EINVAL;
> +
> +	if (do_direct_lock)
> +		mutex_lock(&direct_mutex);
> +
> +	/* Enable the tmp_ops to have the same functions as the direct ops */
> +	ftrace_ops_init(&tmp_ops);
> +	tmp_ops.func_hash = ops->func_hash;
> +
> +	err = register_ftrace_function_nolock(&tmp_ops);
> +	if (err)
> +		goto unlock;
> +
> +	/*
> +	 * Call __ftrace_hash_update_ipmodify() here, so that we can call
> +	 * ops->ops_func for the ops. This is needed because the above
> +	 * register_ftrace_function_nolock() worked on tmp_ops.
> +	 */
> +	err = __ftrace_hash_update_ipmodify(ops, orig_hash, orig_hash, true);
                                                                        ^^^^
Does __ftrace_hash_update_ipmodify() accept a fourth argument? The
function signature shows it only takes three parameters (ops, old_hash,
new_hash). This looks like a compilation error.

> +	if (err)
> +		goto out;

[ ... ]

> +
> +out:
> +	/* Removing the tmp_ops will add the updated direct callers to the functions */
> +	unregister_ftrace_function(&tmp_ops);
         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Can this deadlock when do_direct_lock is true? Looking at the code:

  update_ftrace_direct_mod() with do_direct_lock=true
    -> mutex_lock(&direct_mutex)
    -> register_ftrace_function_nolock(&tmp_ops) succeeds
    -> __ftrace_hash_update_ipmodify() fails
    -> goto out (still holding direct_mutex)
    -> unregister_ftrace_function(&tmp_ops)
       -> cleanup_direct_functions_after_ipmodify()
          -> mutex_lock(&direct_mutex) /* deadlock */

The unregister path tries to reacquire direct_mutex that we're already
holding.

> +
> +unlock:
> +	if (do_direct_lock)
> +		mutex_unlock(&direct_mutex);
> +	return err;
> +}
> +
>  #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19332026793

--===============0521505570487395101==--

