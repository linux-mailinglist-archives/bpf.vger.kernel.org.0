Return-Path: <bpf+bounces-62495-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC499AFB3EE
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 15:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B9D6188F50E
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 13:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F0A29B792;
	Mon,  7 Jul 2025 13:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="leCL277o"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A53F1FFC48;
	Mon,  7 Jul 2025 13:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751893757; cv=none; b=afFiJnJ37nRn5sr3WEMBGeV64fRVt5WT0rrf/mRGXJtPko1BMmbsE4zerG8ujgUef9Zw7GbuFmzOFYktKQ9ILC99/a620R2xJ5WUjuRk/dRkUy/D9clpyio6LJ02f6diXw2SCKQTg44qw7p4hgyMlKNpzUwIS0/TvPiSJ2YxLeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751893757; c=relaxed/simple;
	bh=YeMOVCglBU8p164rswsGlI71AdJFCu0J+zIZHooKAUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=STEP0OQFbAVxyF0gvIBWluyz/TWgP3B3zU0PlqdMXic16XChoNhFBTAoSEToR1uNu2Kr0lsNvOtJ0EVEopx31TG76hNMtCJ9k1AjSW5+epLqcmDJtNeiZeC9r7VaUc0meR2MWWgJy0LPjkQyc5A78lccat66vdYz+aRLd2Lx6JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=leCL277o; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=aYWQg/UvnmCmXtVe8KM5L6hltd/YwWA4VEQIY1VMyHI=; b=leCL277oy7Tss29U5TzSSnKppN
	nMVoBAqlEy2uBPr4koxnqDWHqANIaLmxz4hfr45k6RCxRsuZCrGh8b8vynOyJhIQaFHUoLvu3CIao
	fElvV8XElTMiLSze01B/QuWxEVb6d655KEh2soKuT/FAm8jHXTQPb4QPs1gPhze6TAIE2oylfaVmb
	40meVabdff3yP1t48ObR0RJ22XQwj4PhB6toW42jvJRxKQXn8I9UedrxT8UowYitPdAg98ImL3j6t
	Pp7iEZ4CWdCxE3jR57ddF7hM6Zmq7sI9R1g5vagShwUch2MpCvvONfbitv5sZJP/qImqqhLsGF+5H
	nJxd1W8A==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1uYlai-000Iwg-0k;
	Mon, 07 Jul 2025 15:09:04 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1uYlah-0008Pz-0R;
	Mon, 07 Jul 2025 15:09:03 +0200
Message-ID: <dd816dfa-bb67-4544-b9fc-8de16af03fac@iogearbox.net>
Date: Mon, 7 Jul 2025 15:09:02 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpf: make the attach target more accurate
To: Menglong Dong <menglong8.dong@gmail.com>, ast@kernel.org
Cc: john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 Menglong Dong <dongml2@chinatelecom.cn>, alan.maguire@oracle.com
References: <20250707113528.378303-1-dongml2@chinatelecom.cn>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <20250707113528.378303-1-dongml2@chinatelecom.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.0.7/27692/Mon Jul  7 10:35:53 2025)

On 7/7/25 1:35 PM, Menglong Dong wrote:
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
> 
> Introduce the function bpf_lookup_attach_addr() to do the address lookup,
> which is able to solve this problem.
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>

Breaks CI, see also:

First test_progs failure (test_progs-aarch64-gcc-14):
#467/1 tracing_failure/bpf_spin_lock
test_bpf_spin_lock:PASS:tracing_failure__open 0 nsec
libbpf: prog 'test_spin_lock': BPF program load failed: -ENOENT
libbpf: prog 'test_spin_lock': -- BEGIN PROG LOAD LOG --
The address of function bpf_spin_lock cannot be found
processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
-- END PROG LOAD LOG --
libbpf: prog 'test_spin_lock': failed to load: -ENOENT
libbpf: failed to load object 'tracing_failure'
libbpf: failed to load BPF skeleton 'tracing_failure': -ENOENT
test_bpf_spin_lock:FAIL:tracing_failure__load unexpected error: -2 (errno 2)
#467/2 tracing_failure/bpf_spin_unlock
test_bpf_spin_lock:PASS:tracing_failure__open 0 nsec
libbpf: prog 'test_spin_unlock': BPF program load failed: -ENOENT
libbpf: prog 'test_spin_unlock': -- BEGIN PROG LOAD LOG --
The address of function bpf_spin_unlock cannot be found
processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
-- END PROG LOAD LOG --
libbpf: prog 'test_spin_unlock': failed to load: -ENOENT
libbpf: failed to load object 'tracing_failure'
libbpf: failed to load BPF skeleton 'tracing_failure': -ENOENT
test_bpf_spin_lock:FAIL:tracing_failure__load unexpected error: -2 (errno 2)

>   kernel/bpf/verifier.c | 76 ++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 71 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 0f6cc2275695..9a7128da6d13 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -23436,6 +23436,72 @@ static int check_non_sleepable_error_inject(u32 btf_id)
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
> +	if (!ftrace_location(addr))
> +		return 0;
> +
> +	if (ctx->addr)
> +		return -EADDRNOTAVAIL;
> +
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
> + * @mod: kernel module to lookup the symbol, NULL means to lookup the kernel
> + * symbols
> + * @sym: the symbol to resolve
> + * @addr: pointer to store the result
> + *
> + * Lookup the address of the symbol @sym, and the address should has
> + * corresponding ftrace location. If multiple symbols with the name @sym
> + * exist, the one that has ftrace location will be returned. If more than
> + * 1 has ftrace location, -EADDRNOTAVAIL will be returned.
> + *
> + * Returns: 0 on success, -errno otherwise.
> + */
> +static int bpf_lookup_attach_addr(const struct module *mod, const char *sym,
> +				  unsigned long *addr)
> +{
> +	struct symbol_lookup_ctx ctx = { .addr = 0, .name = sym };
> +	int err;
> +
> +	if (!mod)
> +		err = kallsyms_on_each_match_symbol(symbol_callback, sym, &ctx);

This is also not really equivalent to kallsyms_lookup_name(). kallsyms_on_each_match_symbol()
only iterates over all symbols in vmlinux whereas kallsyms_lookup_name() looks up both vmlinux
and modules.

> +	else
> +		err = module_kallsyms_on_each_symbol(mod->name, symbol_mod_callback,
> +						     &ctx);
> +
> +	if (!ctx.addr)
> +		return -ENOENT;
> +
> +	if (err)
> +		return err;
> +
> +	*addr = ctx.addr;
> +
> +	return 0;
> +}
> +
>   int bpf_check_attach_target(struct bpf_verifier_log *log,
>   			    const struct bpf_prog *prog,
>   			    const struct bpf_prog *tgt_prog,
> @@ -23689,18 +23755,18 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
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


