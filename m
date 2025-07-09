Return-Path: <bpf+bounces-62769-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0DEAFE2FC
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 10:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD5094E0DAD
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 08:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CBD27CCCD;
	Wed,  9 Jul 2025 08:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pc7+bpuF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A653C26B763;
	Wed,  9 Jul 2025 08:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752050601; cv=none; b=sbnQCNz1DSBen8jar2gsbKfVzvXXU4PrZtTY2Wo3i+3NYtKOQS8i8scosQLQmKCjF5aoEO5h49A2j4reHIjcT46VP38CeC4hz6s0+AgkuqKTyqwC21gzzGA0XMEGE1VA3Bmu+SY1hP29JoPXxMypVFWIlKbgD1V7RJc3iiFuXoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752050601; c=relaxed/simple;
	bh=Cs6JjLSPsTFLJj4H5Z6R6MrU1Qqzt2zZkRBKKWUvFLo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EjD2uTUWtoe661ZjUdqPaCiC6G9IHfFEEfwdN+tAHt/LKncrdnehT6XUABS0VMNDO98EoN9YVPy5hcTkmYT9iJMO8jrAZwCQAB8Y/g0YnDbFdFeCeDMEjyqvDl4q1tHbetkeLBdvBDBUONGw8I7E8sJRR5kcAl0/XSoKJaVtdTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pc7+bpuF; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-60c93c23b08so10426128a12.3;
        Wed, 09 Jul 2025 01:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752050597; x=1752655397; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9Xdlzo8mlFP5VJmSLNkxHKCX30v3KVlncbbCZk7gPQs=;
        b=Pc7+bpuFhD8krPW7IzKZqA5Z0x0EKdn9y80VN8HwY3fUsxbIbg1IocEMVux1XpfUdl
         5sQvuXAUjZnOdxmsOO7yoVg3HlacJcHnO+al8UmvJ8tlez92p0xCKy6Gr2o30MFveZIM
         ZUE0vS8nuLJql7TUscJYqrU3VONYi/7Ff+EZYuNCRaBqjRoSC95YKS3zl9Md3+JNVcBf
         WRCDy2JJp4K/etfEX6j7enVGDH2JELsY5ysK648/SDGXuVMAqo5qbcDsfZ4ZuylBmW/L
         QH+WrJwE1ZIkioQ1hs2IsJOrHeeMolMnSMQAP+h2xZFOOf+uXuVXYhN6wUIC5El1zKpW
         ocfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752050597; x=1752655397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Xdlzo8mlFP5VJmSLNkxHKCX30v3KVlncbbCZk7gPQs=;
        b=cpiammEnBXNSRGUf9AxvEG7kr7X1ZKpO8g9EnGOtiW564YlUz/FiHX85opv8CgAzq8
         I+y5fvqRMHgyDfvhV1PwLsUGvPqWs8cHzlwk0ve6dFw1v+XFo0dwpibh1kdSoVMUFgVP
         qFkX/BuQirJ61L4otqpfT63H9Ch7vfq4uualuH0lv0cbzZQ28GU8KwXdYY0zuyWACI1d
         9+xhmQHaQF6pnLgCEa2zQCxq5iQi7+6OQWT4GfRzj/Fi7WMNZFfHNft7wwTIu30cE45U
         iPrJWnNCrdIcYurTDqvwB2/kArqDbJ8XWI0LzEnYH/KXCFR0gIQ8qxPfNmhf60DwIbdO
         HeMw==
X-Forwarded-Encrypted: i=1; AJvYcCUHMyH08u2U1sD2xN4hgi39otxwBj9UShYfKzhzClt+2clNPjesWe0yD8IGpMd+uGhCPhI=@vger.kernel.org, AJvYcCWOzgOAKacEcJD8/C7DmUiRCIdSD2apHmmMwc+IRSWUajYm02cMMQdAreD9pKtVjAEI85srgPR+coFGHMfr@vger.kernel.org
X-Gm-Message-State: AOJu0YxODs+ROY5hpCQGzT9vL21hLEGs5exuKVzk/vN/bSIzxRI4Z8r1
	dkECwYmg3fTZPe2+D+2xZmCjm5LbT9byRBdMwQWpRVzDwtECdKx2XQT+
X-Gm-Gg: ASbGnctQrYUiYwM8DoHnGMQCNlDgozoQE9kl97u7hY6+QYbsd5nbcCj6tvWMtqiLJGS
	WV0nczSftLUxPQh5/SVu0GKvsJqLKVIEkRlMo/NW3yZ9C8oDgpHitDmNItehOV4fwc94wN5FxXh
	sx7g+S5xaAMbZsOZ7eWeZS81dkD7Kc88WeIwgMJsNl6t6ZOnr0HdaCgT8vymwuV2am1V9GctG8S
	VYRpLaGir+YZynIZhCUN66wzY+TTN+zcLGjBXuf6gkAzsY1P9sk0nopowQ5VL9rRA8S3MFpX1o/
	Hn4X7btOSFZ6s+z7iT0j/waiVzONeaWO9p3y9ox6AjpiKXdh
X-Google-Smtp-Source: AGHT+IFl1+1FOYlrpDcn9VUhVaoJ43veqLZ6vLPtd0eGG2eIlWocyufPSPJVqBo5GtjMTwGE10wG1A==
X-Received: by 2002:a17:907:268d:b0:ae6:d968:4aff with SMTP id a640c23a62f3a-ae6d96854dfmr45055666b.47.1752050596717;
        Wed, 09 Jul 2025 01:43:16 -0700 (PDT)
Received: from krava ([173.38.220.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60fca78fd37sm8426099a12.23.2025.07.09.01.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 01:43:16 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 9 Jul 2025 10:43:14 +0200
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
	sdf@fomichev.me, haoluo@google.com, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>
Subject: Re: [PATCH bpf-next v2] bpf: make the attach target more accurate
Message-ID: <aG4roiqyzNFOvu2R@krava>
References: <20250708072140.945296-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708072140.945296-1-dongml2@chinatelecom.cn>

On Tue, Jul 08, 2025 at 03:21:40PM +0800, Menglong Dong wrote:
> For now, we lookup the address of the attach target in
> bpf_check_attach_target() with find_kallsyms_symbol_value or
> kallsyms_lookup_name, which is not accurate in some cases.
> 
> For example, we want to attach to the target "t_next", but there are
> multiple symbols with the name "t_next" exist in the kallsyms. The one
> that kallsyms_lookup_name() returned may have no ftrace record, which
> makes the attach target not available. So we want the one that has ftrace
> record to be returned.
> 
> Meanwhile, there may be multiple symbols with the name "t_next" in ftrace
> record. In this case, the attach target is ambiguous, so the attach should
> fail.

could you reproduce this somehow (bpftrace/selftest) for some symbol?
I'd think pahole now filters all such symbols out of BTF and you need
BTF func record to load the program in the first place

jirka


> 
> Introduce the function bpf_lookup_attach_addr() to do the address lookup,
> which is able to solve this problem.
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
> v2:
> - Lookup both vmlinux and modules symbols when mod is NULL, just like
>   kallsyms_lookup_name().
> 
>   If the btf is not a modules, shouldn't we lookup on the vmlinux only?
>   I'm not sure if we should keep the same logic with
>   kallsyms_lookup_name().
> 
> - Return the kernel symbol that don't have ftrace location if the symbols
>   with ftrace location are not available
> ---
>  kernel/bpf/verifier.c | 77 ++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 72 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 53007182b46b..4bacd0abf207 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -23476,6 +23476,73 @@ static int check_non_sleepable_error_inject(u32 btf_id)
>  	return btf_id_set_contains(&btf_non_sleepable_error_inject, btf_id);
>  }
>  
> +struct symbol_lookup_ctx {
> +	const char *name;
> +	unsigned long addr;
> +	bool ftrace_addr;
> +};
> +
> +static int symbol_callback(void *data, unsigned long addr)
> +{
> +	struct symbol_lookup_ctx *ctx = data;
> +
> +	ctx->addr = addr;
> +	if (!ftrace_location(addr))
> +		return 0;
> +
> +	if (ctx->ftrace_addr)
> +		return -EADDRNOTAVAIL;
> +	ctx->ftrace_addr = true;
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
> + * @sym exist, the one that has ftrace location is preferred. If more
> + * than 1 has ftrace location, -EADDRNOTAVAIL will be returned.
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
>  int bpf_check_attach_target(struct bpf_verifier_log *log,
>  			    const struct bpf_prog *prog,
>  			    const struct bpf_prog *tgt_prog,
> @@ -23729,18 +23796,18 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>  			if (btf_is_module(btf)) {
>  				mod = btf_try_get_module(btf);
>  				if (mod)
> -					addr = find_kallsyms_symbol_value(mod, tname);
> +					ret = bpf_lookup_attach_addr(mod, tname, &addr);
>  				else
> -					addr = 0;
> +					ret = -ENOENT;
>  			} else {
> -				addr = kallsyms_lookup_name(tname);
> +				ret = bpf_lookup_attach_addr(NULL, tname, &addr);
>  			}
> -			if (!addr) {
> +			if (ret) {
>  				module_put(mod);
>  				bpf_log(log,
>  					"The address of function %s cannot be found\n",
>  					tname);
> -				return -ENOENT;
> +				return ret;
>  			}
>  		}
>  
> -- 
> 2.39.5
> 

