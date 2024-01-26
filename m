Return-Path: <bpf+bounces-20360-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD32583D1C0
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 01:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF2E21C224FF
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 00:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CF3EBE;
	Fri, 26 Jan 2024 00:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hFT0WZy0"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81AE385
	for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 00:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706230511; cv=none; b=W3ravkEzmJcLiFxDgY6EBOp+eUmrh1TQIW+1g9ENVyaJfkSqohSOW5Qp9nCcSbvg1TeatJnYuZwb9ZBsDfjcUvOhDxjw9bi1oHbNpm42vMMNg82Z89lcRh7j2O6Czh/6tN+JAsFrySRBywGWgVBMTjItKAYlv4Dj7Vepx/sr7Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706230511; c=relaxed/simple;
	bh=L3kbZxYL6uoNKBv/L8MC0yG1Eez42LINDtBISRmPAIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eeAx/B+GEdjfPM90eHC3lLxM2uW4iVGMInB7fs9iOekLSju+NL0InSe1gHKjpJFB4Di6xgv6AxINvLdY8J93eqB/jT2q/a1P4CLpvL7ybN2TclDc0UVKcJBzGVAbC/C29Y4b4eOHD79OcgrQEd9hezuIt7N/Z8PTZKW1aZV6mMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hFT0WZy0; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ea787f03-7dea-42f0-b467-a4d25943d6e7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706230504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uw+drMhnNzI4fEiJecnZo0HN3qbTUc//VsKFYm0tdC8=;
	b=hFT0WZy0jleX/waqCTAXSoN9YbxjQJjPqZx5oOzeV29GhembFy0IBA4SMsXzlXABhSEGRi
	AQCtWIJpOH6jiEFThQenjT/UEVjaboh/4vYXjCbYikM6uC5oZlYhAOYXso1T7l9iVvfl5M
	28UO0akg+mnlsCAT9SKeHolABaSEz/Y=
Date: Thu, 25 Jan 2024 16:54:55 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: Fix error checks against
 bpf_get_btf_vmlinux().
Content-Language: en-US
To: thinker.li@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com,
 syzbot+88f0aafe5f950d7489d7@syzkaller.appspotmail.com, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org
References: <20240125233105.1096036-1-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240125233105.1096036-1-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/25/24 3:31 PM, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> Check whether the returned pointer is NULL. Previously, it was assumed that
> an error code would be returned if BTF is not available or fails to
> parse. However, it actually returns NULL if BTF is disabled.
> 
> In the function check_struct_ops_btf_id(), we have stopped using
> btf_vmlinux as a backup because attach_btf is never null when attach_btf_id
> is set. However, the function test_libbpf_probe_prog_types() in
> libbpf_probes.c does not set both attach_btf_obj_fd and attach_btf_id,
> resulting in attach_btf being null, and it expects ENOTSUPP as a
> result. So, if attach_btf_id is not set, it will return ENOTSUPP.
> 
> Reported-by: syzbot+88f0aafe5f950d7489d7@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/bpf/00000000000040d68a060fc8db8c@google.com/

There were two different syzbot report. Both should be tagged here as Reported-by.

> Fixes: fcc2c1fb0651 ("bpf: pass attached BTF to the bpf_struct_ops subsystem")
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>   kernel/bpf/bpf_struct_ops.c | 2 ++
>   kernel/bpf/verifier.c       | 8 +++++++-
>   2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index defc052e4622..0decd862dfe0 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -669,6 +669,8 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>   		btf = bpf_get_btf_vmlinux();
>   		if (IS_ERR(btf))
>   			return ERR_CAST(btf);
> +		if (!btf)
> +			return ERR_PTR(-ENOTSUPP);
>   	}
>   
>   	st_ops_desc = bpf_struct_ops_find_value(btf, attr->btf_vmlinux_value_type_id);
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index fe833e831cb6..64a927784c54 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -20298,7 +20298,13 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
>   		return -EINVAL;
>   	}
>   
> -	btf = prog->aux->attach_btf ?: bpf_get_btf_vmlinux();
> +	if (!prog->aux->attach_btf_id)
> +		return -ENOTSUPP;
> +
> +	btf = prog->aux->attach_btf;
> +	if (!btf)

The commit message mentioned "attach_btf is never null when attach_btf_id is 
set". Then why this test is still needed when the above has just tested the 
attach_btf_id. attach_btf must be valid here as long as attach_btf_id is set. 
This should have been guaranteed by syscall.c, no?

> +		return -ENOTSUPP;
> +
>   	if (btf_is_module(btf)) {
>   		/* Make sure st_ops is valid through the lifetime of env */
>   		env->attach_btf_mod = btf_try_get_module(btf);


