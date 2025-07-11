Return-Path: <bpf+bounces-62995-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 844B2B01187
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 05:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD4C816D98F
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 03:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853531990D8;
	Fri, 11 Jul 2025 03:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B0/4L3o0"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA4870814
	for <bpf@vger.kernel.org>; Fri, 11 Jul 2025 03:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752203441; cv=none; b=AF8zCSCd9iP/6z74qthAKjUYc0k3KloVZ3tDLNvscMw0hicDkuzDZE8IMLnzZiY9sSEETkOAIpZ2kvK0B6+AzDzUwVuHSkQi9PTRbB8Wv5MJ7SPAGNOHoorNVxkndTgOL8/ANpIYEdtSRLir7ciGpMJ8xdi/hdnV6iXFf8fCqMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752203441; c=relaxed/simple;
	bh=/m17edC0OXP7hMTmCRLK1oCb0lUyP4ccJ96sraTED0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QHxovLyM9451qGfKkwypZHyZGLMYnd3kjwKxmeM75IXMIE6V+mawE37Wft3MzYWK1+w6sREH5pKy7R9WhEsbgVKd9QeD6Bgtj61P7LnBA07YW0jmf148uL7Rn/B4IJZ0JlsGwjjIHOIJYOnc7UmUZFpN8i2vGqPssRbFqmgUvQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B0/4L3o0; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2f8c792e-9675-4385-b1cb-10266c72bd45@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752203437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x715/q+udRUTDW1yuo6mapYClglFmqiiqnYPKulS+Uk=;
	b=B0/4L3o0Y6gI127BGVHuDHtJFgF+AxSK2e2eboTSclO75hweb+vut+vpNNJR0+esORmOPb
	iEzHQKXsRD4WUJxU4FoQIvmtDPHMlD0rDq/RBXuITDuBKj14rkWE+7GqABcvUk9dgiFL3j
	zgN0h/yLXpvQgYFr0YdjzuOlCZMA2PI=
Date: Thu, 10 Jul 2025 20:10:29 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3] bpf: make the attach target more accurate
Content-Language: en-GB
To: Menglong Dong <menglong8.dong@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net
Cc: john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, Menglong Dong <dongml2@chinatelecom.cn>
References: <20250710070835.260831-1-dongml2@chinatelecom.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250710070835.260831-1-dongml2@chinatelecom.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 7/10/25 12:08 AM, Menglong Dong wrote:
> For now, we lookup the address of the attach target in
> bpf_check_attach_target() with find_kallsyms_symbol_value or
> kallsyms_lookup_name, which is not accurate in some cases.
>
> For example, we want to attach to the target "t_next", but there are
> multiple symbols with the name "t_next" exist in the kallsyms, which makes
> the attach target ambiguous, and the attach should fail.
>
> Introduce the function bpf_lookup_attach_addr() to do the address lookup,
> which will return -EADDRNOTAVAIL when the symbol is not unique.
>
> We can do the testing with following shell:
>
> for s in $(cat /proc/kallsyms | awk '{print $3}' | sort | uniq -d)
> do
>    if grep -q "^$s\$" /sys/kernel/debug/tracing/available_filter_functions
>    then
>      bpftrace -e "fentry:$s {printf(\"1\");}" -v
>    fi
> done
>
> The script will find all the duplicated symbols in /proc/kallsyms, which
> is also in /sys/kernel/debug/tracing/available_filter_functions, and
> attach them with bpftrace.
>
> After this patch, all the attaching fail with the error:
>
> The address of function xxx cannot be found
> or
> No BTF found for xxx
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>

Maybe we should prevent vmlinux BTF generation for such symbols
which are static and have more than one instances? This can
be done in pahole and downstream libbpf/kernel do not
need to do anything. This can avoid libbpf/kernel runtime overhead
since bpf_lookup_attach_addr() could be expensive as it needs
to go through ALL symbols, even for unique symbols.


> ---
> v3:
> - reject all the duplicated symbols
> v2:
> - Lookup both vmlinux and modules symbols when mod is NULL, just like
>    kallsyms_lookup_name().
>
>    If the btf is not a modules, shouldn't we lookup on the vmlinux only?
>    I'm not sure if we should keep the same logic with
>    kallsyms_lookup_name().
>
> - Return the kernel symbol that don't have ftrace location if the symbols
>    with ftrace location are not available
> ---
>   kernel/bpf/verifier.c | 71 ++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 66 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 53007182b46b..bf4951154605 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -23476,6 +23476,67 @@ static int check_non_sleepable_error_inject(u32 btf_id)
>   	return btf_id_set_contains(&btf_non_sleepable_error_inject, btf_id);
>   }
>   
> +struct symbol_lookup_ctx {
> +	const char *name;
> +	unsigned long addr;
> +};
> +
> +static int symbol_callback(void *data, unsigned long addr)
> +{
> +	struct symbol_lookup_ctx *ctx = data;
> +
> +	if (ctx->addr)
> +		return -EADDRNOTAVAIL;
> +	ctx->addr = addr;
> +
> +	return 0;
> +}
> +
> +static int symbol_mod_callback(void *data, const char *name, unsigned long addr)
> +{
> +	if (strcmp(((struct symbol_lookup_ctx *)data)->name, name) != 0)
> +		return 0;
> +
> +	return symbol_callback(data, addr);
> +}
> +
> +/**
> + * bpf_lookup_attach_addr: Lookup address for a symbol
> + *
> + * @mod: kernel module to lookup the symbol, NULL means to lookup both vmlinux
> + * and modules symbols
> + * @sym: the symbol to resolve
> + * @addr: pointer to store the result
> + *
> + * Lookup the address of the symbol @sym. If multiple symbols with the name
> + * @sym exist, -EADDRNOTAVAIL will be returned.
> + *
> + * Returns: 0 on success, -errno otherwise.
> + */
> +static int bpf_lookup_attach_addr(const struct module *mod, const char *sym,
> +				  unsigned long *addr)
> +{
> +	struct symbol_lookup_ctx ctx = { .addr = 0, .name = sym };
> +	const char *mod_name = NULL;
> +	int err = 0;
> +
> +#ifdef CONFIG_MODULES
> +	mod_name = mod ? mod->name : NULL;
> +#endif
> +	if (!mod_name)
> +		err = kallsyms_on_each_match_symbol(symbol_callback, sym, &ctx);
> +
> +	if (!err && !ctx.addr)
> +		err = module_kallsyms_on_each_symbol(mod_name, symbol_mod_callback,
> +						     &ctx);
> +
> +	if (!ctx.addr)
> +		err = -ENOENT;
> +	*addr = err ? 0 : ctx.addr;
> +
> +	return err;
> +}
> +
>   int bpf_check_attach_target(struct bpf_verifier_log *log,
>   			    const struct bpf_prog *prog,
>   			    const struct bpf_prog *tgt_prog,
> @@ -23729,18 +23790,18 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>   			if (btf_is_module(btf)) {
>   				mod = btf_try_get_module(btf);
>   				if (mod)
> -					addr = find_kallsyms_symbol_value(mod, tname);
> +					ret = bpf_lookup_attach_addr(mod, tname, &addr);
>   				else
> -					addr = 0;
> +					ret = -ENOENT;
>   			} else {
> -				addr = kallsyms_lookup_name(tname);
> +				ret = bpf_lookup_attach_addr(NULL, tname, &addr);
>   			}
> -			if (!addr) {
> +			if (ret) {
>   				module_put(mod);
>   				bpf_log(log,
>   					"The address of function %s cannot be found\n",
>   					tname);
> -				return -ENOENT;
> +				return ret;
>   			}
>   		}
>   


