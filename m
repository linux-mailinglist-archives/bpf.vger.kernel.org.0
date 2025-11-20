Return-Path: <bpf+bounces-75198-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F200C767DD
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 23:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A25DB35D66E
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 22:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E94311C3C;
	Thu, 20 Nov 2025 22:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lVZxlJWt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E572FE04D;
	Thu, 20 Nov 2025 22:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763677426; cv=none; b=Uqu4zNYJUug0YeFETWkvGGD7wpXl02DcbEVzx953sN87wri8fz0uBif87phJOQQyLAVuLNRK4bZAiIB5EZ17mPWbK0mg7u13xtmfUd81HsUdJ6ljbM1SPhBkagTmoLIvJWh3TZTJKGN2eRNlAUzS8uiVL5gYMc1QkqBi4OqLdck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763677426; c=relaxed/simple;
	bh=BWe/EKIPlDyqI2keprRPVJrB/dDGDqMzr0kO/3DVmkg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=FlFav5aDCfyh89IMm2sXC5fPzVNFMk/+onyiIsa00DyfFFLd+WD0l0byRIb1dnsaQQNOu33ATmOOeUhepVjvAdOVOlQTRUNjNkHEtZaKgp0jod8Z8fcEh70kqszU3oVFlQzmYip5CAhvqXm6sdj4g7K2Li8AY9MsGfJGtuGBuzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lVZxlJWt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69876C4CEF1;
	Thu, 20 Nov 2025 22:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763677426;
	bh=BWe/EKIPlDyqI2keprRPVJrB/dDGDqMzr0kO/3DVmkg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=lVZxlJWtBLPAMLktI807uP728v8/mw8YWLUTA2Wd0TjU61ltT5WclYfmord4Ejy+G
	 0BRWz8CYMVxTUyO2Drt7tOzNGuN5zeojnTsgUqHg8j3mpnOz24S9e8oH+DTNYDZUjo
	 qBW8xqY2Ly9gHTF4YG/BUBsFeu6CoyC1AHzs1qbTkvFnqYudoTrHQ3CgXjbzE9H9ki
	 ZFQp2UVAIZTMRMwtRTNSpGjfXP+y0aTrw86xoawsnIFM1phR9DFa8ZJmN2UF0RX100
	 wQMQpnpW1cqHrL+nl+W5HaqESwTZk5rFNDzjCkzhZ2ERLWQ38Mvht+nChSkEQav4TP
	 IOtzbiwblKezA==
Content-Type: multipart/mixed; boundary="===============3985177215565251835=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <35e436ca1a638c9e30456c2a3645c23a20b2483160e3bb34b7c73fe42776f4df@mail.kernel.org>
In-Reply-To: <20251120212402.466524-5-jolsa@kernel.org>
References: <20251120212402.466524-5-jolsa@kernel.org>
Subject: Re: [PATCHv3 bpf-next 4/8] ftrace: Add update_ftrace_direct_del function
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,rostedt@kernel.org,revest@google.com,mark.rutland@arm.com
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-trace-kernel@vger.kernel.org,linux-arm-kernel@lists.infradead.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,menglong8.dong@gmail.com,song@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 20 Nov 2025 22:23:46 +0000 (UTC)

--===============3985177215565251835==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index 9cf4cd56d..c571deeff 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -551,6 +551,7 @@ int modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr);
>  int modify_ftrace_direct_nolock(struct ftrace_ops *ops, unsigned long addr);
>
>  int update_ftrace_direct_add(struct ftrace_ops *ops, struct ftrace_hash *hash);
> +int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace_hash *hash);
>
>  void ftrace_stub_direct_tramp(void);
>
> @@ -583,6 +584,11 @@ static inline int update_ftrace_direct_add(struct ftrace_ops *ops, struct ftrace
>  	return -ENODEV;
>  }
>
> +static inline int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace_hash *hash)
> +{
> +	return -ENODEV;
> +}
> +

[ ... ]

> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 850ff55ff..cc730a8fd 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c

[ ... ]

> +/**
> + * hash_sub - substracts @b from @a and returns the result
> + * @a: struct ftrace_hash object
> + * @b: struct ftrace_hash object
> + *
> + * Returns struct ftrace_hash object on success, NULL on error.
> + */
> +static struct ftrace_hash *hash_sub(struct ftrace_hash *a, struct ftrace_hash *b)
> +{
> +	struct ftrace_func_entry *entry, *del;
> +	struct ftrace_hash *sub;
> +	int size, i;
> +
> +	sub = alloc_and_copy_ftrace_hash(a->size_bits, a);
                                           ^^^^^^^^^^^^

Can hash_sub() handle a NULL hash pointer in parameter a?  I notice the
parallel function hash_add() safely handles NULL via hash_count() and
alloc_and_copy_ftrace_hash() which checks ftrace_hash_empty().

However, hash_sub() directly dereferences a->size_bits before passing a
to alloc_and_copy_ftrace_hash().  This will crash if a is NULL.

This matters because update_ftrace_direct_del() calls hash_sub() with
old_filter_hash which can be NULL:

    old_filter_hash = ops->func_hash ? ops->func_hash->filter_hash : NULL;
    ...
    new_filter_hash = hash_sub(old_filter_hash, hash);

The existing update_ftrace_direct_add() has the same defensive check and
passes the potentially-NULL old_filter_hash to hash_add(), which handles
it correctly.

> +	if (!sub)
> +		goto error;
> +
> +	size = 1 << b->size_bits;
> +	for (i = 0; i < size; i++) {
> +		hlist_for_each_entry(entry, &b->buckets[i], hlist) {
> +			del = __ftrace_lookup_ip(sub, entry->ip);
> +			if (WARN_ON_ONCE(!del))
> +				goto error;
> +			remove_hash_entry(sub, del);
> +			kfree(del);
> +		}
> +	}
> +	return sub;
> +
> + error:
> +	free_ftrace_hash(sub);
> +	return NULL;
> +}
> +
> +int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace_hash *hash)
> +{

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19552032346

--===============3985177215565251835==--

