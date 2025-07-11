Return-Path: <bpf+bounces-62996-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8683B011B8
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 05:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A2EA3B36CD
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 03:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C456419D884;
	Fri, 11 Jul 2025 03:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Htx2lfgE"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3059B1474DA
	for <bpf@vger.kernel.org>; Fri, 11 Jul 2025 03:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752205602; cv=none; b=pZtI+DcbpcGPf9YWEG6oLfT736cjGk+4z95Rhu/f7H9VzJt5lyy7zvyFAJG37D2z1HpQChzDcBBrJkswCA+DAaLhQUIYFLwr9CxN0zNp3m1TRJjfhfHN+kLFXl5T9Al9ZubkT+ffOLfsisOB6Y5n4cIO+Whu0J0MgAsvk/SNhIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752205602; c=relaxed/simple;
	bh=dAK18Z/M1Hp5wkRCSWQwhqDaPFZfk6E0afJUIJTtq1E=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=mfGZshaFzrKWv+hyk27nbiYXtZFOoPzvcu+SyJuqjVtkAN+p4bML3pAd7asfuHTeCTjCW3luKbcb+Q4gcKcE3JLb25iRVmPUq03G7mNuGOUKJqpHAUWKQoA1NCYtnYQes6KowxVRj3LInqcj0cM5O8Jn1sqWj8GL15q4ARr1YGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Htx2lfgE; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ffcbe060-a15d-44d7-bf5e-090e74726c31@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752205586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LrXT55bORs0fsD8GQ1AosNWcbgIrC5NreNiYDhdXhZ0=;
	b=Htx2lfgEVRkDhvtiEdRx6w2YQ5BSlehVUMrC+ObYc+GNq+/KM4sltj1eR5+fyf4Iayv7/J
	o8exqS5+apdKrwaevDQDn6/JKm0nySuKlVbY6rILGqEBBUjiKxjG1zirZ3wXMByuk60Yd4
	2K83tvwJK9lA1fwTEw/kiIufyFE3T3c=
Date: Thu, 10 Jul 2025 20:46:18 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3] bpf: make the attach target more accurate
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net
Cc: john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, Menglong Dong <dongml2@chinatelecom.cn>
References: <20250710070835.260831-1-dongml2@chinatelecom.cn>
 <2f8c792e-9675-4385-b1cb-10266c72bd45@linux.dev>
In-Reply-To: <2f8c792e-9675-4385-b1cb-10266c72bd45@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 7/10/25 8:10 PM, Yonghong Song wrote:
>
>
> On 7/10/25 12:08 AM, Menglong Dong wrote:
>> For now, we lookup the address of the attach target in
>> bpf_check_attach_target() with find_kallsyms_symbol_value or
>> kallsyms_lookup_name, which is not accurate in some cases.
>>
>> For example, we want to attach to the target "t_next", but there are
>> multiple symbols with the name "t_next" exist in the kallsyms, which 
>> makes
>> the attach target ambiguous, and the attach should fail.
>>
>> Introduce the function bpf_lookup_attach_addr() to do the address 
>> lookup,
>> which will return -EADDRNOTAVAIL when the symbol is not unique.
>>
>> We can do the testing with following shell:
>>
>> for s in $(cat /proc/kallsyms | awk '{print $3}' | sort | uniq -d)
>> do
>>    if grep -q "^$s\$" 
>> /sys/kernel/debug/tracing/available_filter_functions
>>    then
>>      bpftrace -e "fentry:$s {printf(\"1\");}" -v
>>    fi
>> done
>>
>> The script will find all the duplicated symbols in /proc/kallsyms, which
>> is also in /sys/kernel/debug/tracing/available_filter_functions, and
>> attach them with bpftrace.
>>
>> After this patch, all the attaching fail with the error:
>>
>> The address of function xxx cannot be found
>> or
>> No BTF found for xxx
>>
>> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
>
> Maybe we should prevent vmlinux BTF generation for such symbols
> which are static and have more than one instances? This can
> be done in pahole and downstream libbpf/kernel do not
> need to do anything. This can avoid libbpf/kernel runtime overhead
> since bpf_lookup_attach_addr() could be expensive as it needs
> to go through ALL symbols, even for unique symbols.

There is a multi-link effort:
   https://lore.kernel.org/bpf/20250703121521.1874196-1-dongml2@chinatelecom.cn/
which tries to do similar thing for multi-kprobe. For example, for fentry,
multi-link may pass an array of btf_id's to the kernel. For such cases,
this patch may cause significant performance overhead.

>
>
>> ---
>> v3:
>> - reject all the duplicated symbols
>> v2:
>> - Lookup both vmlinux and modules symbols when mod is NULL, just like
>>    kallsyms_lookup_name().
>>
>>    If the btf is not a modules, shouldn't we lookup on the vmlinux only?
>>    I'm not sure if we should keep the same logic with
>>    kallsyms_lookup_name().
>>
>> - Return the kernel symbol that don't have ftrace location if the 
>> symbols
>>    with ftrace location are not available
>> ---
>>   kernel/bpf/verifier.c | 71 ++++++++++++++++++++++++++++++++++++++++---
>>   1 file changed, 66 insertions(+), 5 deletions(-)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 53007182b46b..bf4951154605 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -23476,6 +23476,67 @@ static int 
>> check_non_sleepable_error_inject(u32 btf_id)
>>       return btf_id_set_contains(&btf_non_sleepable_error_inject, 
>> btf_id);
>>   }
>>   +struct symbol_lookup_ctx {
>> +    const char *name;
>> +    unsigned long addr;
>> +};
>> +
>> +static int symbol_callback(void *data, unsigned long addr)
>> +{
>> +    struct symbol_lookup_ctx *ctx = data;
>> +
>> +    if (ctx->addr)
>> +        return -EADDRNOTAVAIL;
>> +    ctx->addr = addr;
>> +
>> +    return 0;
>> +}
>> +
>> +static int symbol_mod_callback(void *data, const char *name, 
>> unsigned long addr)
>> +{
>> +    if (strcmp(((struct symbol_lookup_ctx *)data)->name, name) != 0)
>> +        return 0;
>> +
>> +    return symbol_callback(data, addr);
>> +}
>> +
>> +/**
>> + * bpf_lookup_attach_addr: Lookup address for a symbol
>> + *
>> + * @mod: kernel module to lookup the symbol, NULL means to lookup 
>> both vmlinux
>> + * and modules symbols
>> + * @sym: the symbol to resolve
>> + * @addr: pointer to store the result
>> + *
>> + * Lookup the address of the symbol @sym. If multiple symbols with 
>> the name
>> + * @sym exist, -EADDRNOTAVAIL will be returned.
>> + *
>> + * Returns: 0 on success, -errno otherwise.
>> + */
>> +static int bpf_lookup_attach_addr(const struct module *mod, const 
>> char *sym,
>> +                  unsigned long *addr)
>> +{
>> +    struct symbol_lookup_ctx ctx = { .addr = 0, .name = sym };
>> +    const char *mod_name = NULL;
>> +    int err = 0;
>> +
>> +#ifdef CONFIG_MODULES
>> +    mod_name = mod ? mod->name : NULL;
>> +#endif
>> +    if (!mod_name)
>> +        err = kallsyms_on_each_match_symbol(symbol_callback, sym, 
>> &ctx);
>> +
>> +    if (!err && !ctx.addr)
>> +        err = module_kallsyms_on_each_symbol(mod_name, 
>> symbol_mod_callback,
>> +                             &ctx);
>> +
>> +    if (!ctx.addr)
>> +        err = -ENOENT;
>> +    *addr = err ? 0 : ctx.addr;
>> +
>> +    return err;
>> +}
>> +
>>   int bpf_check_attach_target(struct bpf_verifier_log *log,
>>                   const struct bpf_prog *prog,
>>                   const struct bpf_prog *tgt_prog,
>> @@ -23729,18 +23790,18 @@ int bpf_check_attach_target(struct 
>> bpf_verifier_log *log,
>>               if (btf_is_module(btf)) {
>>                   mod = btf_try_get_module(btf);
>>                   if (mod)
>> -                    addr = find_kallsyms_symbol_value(mod, tname);
>> +                    ret = bpf_lookup_attach_addr(mod, tname, &addr);
>>                   else
>> -                    addr = 0;
>> +                    ret = -ENOENT;
>>               } else {
>> -                addr = kallsyms_lookup_name(tname);
>> +                ret = bpf_lookup_attach_addr(NULL, tname, &addr);
>>               }
>> -            if (!addr) {
>> +            if (ret) {
>>                   module_put(mod);
>>                   bpf_log(log,
>>                       "The address of function %s cannot be found\n",
>>                       tname);
>> -                return -ENOENT;
>> +                return ret;
>>               }
>>           }
>
>


