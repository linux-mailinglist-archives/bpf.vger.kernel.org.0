Return-Path: <bpf+bounces-21747-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D690A851AEF
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 18:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DED4285E5F
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 17:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A04405DB;
	Mon, 12 Feb 2024 17:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqGa+NoP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31402405CE
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 17:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707757794; cv=none; b=Q4NoLdbXwRl3MCs095dsjnx4JdbE7mTzJDvdp/eyQKZh6Kk+duKC8porlo6LZMX+ksOEY1QVqo/QtzZgKWJSZXe7UJymTgmZa3a4M6xyX5ZRwr+ghrYSviLzPxIXYzRLCqQbAzYLAb2nuQTRlIOM/WHhwHtey0/O/uqh0ZV4Mrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707757794; c=relaxed/simple;
	bh=A53yt9O5KJxv7hjO1yE3dLtNYHh9R0KSQYfRjNCsda8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j1xRDSy4WBa9GLClp8ls7Rudpz/he26r4CAYbT0HulcKlkyXOStaYS3Dy+nQLCO7QeQ9mzroWqw2MUvIRNPEdHUpFtGKdiej/j856AQlD9veGDwy8zuW4J327u7zq0eIwKKtmNelDva38EWxiFN4Mqijc5YvmVGRXNSfPjjVBhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FqGa+NoP; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-60777552d72so4299807b3.1
        for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 09:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707757791; x=1708362591; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ilmQMIj8p0XBwyDkuR1DTCiBDqYh8w9smrxNGZp3lEk=;
        b=FqGa+NoPUnxmkYSTa5bJvn6I0Awoxc7lSVBnnU7wcU3O+e/qUANSYq97nJmgFonxrI
         RJ1e0aEo3ucd0TCF6V/3rzs54M2LEIBEbAWJ0n1kiF+Tr6vq9IFZVkwgZs6ukrwG9wsg
         EhgMpyqyrFCtkuGXMTUF81w207DR3u5IYVLFyy2C788eN9/xdLvC2zN3wCDb6dlb4Up1
         eISvo8egpodjsBPBZOaDlW+2sjkDk3gkRfeZ4ejIZSc6xNwaur/jq6UspKNIKQdpnMbQ
         balyQD3kQsi0PuHri+Z8X+pjnsOR51G2nIBEa6dl7jh84A2zQrnOkvvAzQf/twqftigi
         97oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707757791; x=1708362591;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ilmQMIj8p0XBwyDkuR1DTCiBDqYh8w9smrxNGZp3lEk=;
        b=bcNkPJX7p6FaMsappdi/1/ONSNE1cFYEIoNDK5/LUyX1ua3EUJUTKQPcwCQK7KW09d
         BwYjR5LhKa6N6hNZVdyZUfoACx0h7kCiSVt8/SIT8orBWLDY5hWVYZAuxE+h6mX4zAPr
         hnZalYeiuKY1IPhN9fjGSnUCZRMAkJWr5GTLLp51jms+V5JpugyxukOSFfbYmb+32DMT
         5dl0eCslDSndvTrRFGTT2nlrll0RCJNWTiGdmdljZMeP0h3SDwqSvtliA2nCUw9uT09n
         bvizPH6e8rpEMNs5gyhtRs3Y2/m1bG5IaTiHcOjnxLZBmO+3GW9UKFhOn6VPe0xhisMn
         zPWA==
X-Gm-Message-State: AOJu0Yw9QNLMMoo2lyKst71wVfEg/2v69xkw2vrgn4xray2N96cYTfRw
	UVMrde0JffBYPCFFtoulvOr3UxNkM2LqwcOmGvUeYB0KD3QDdiTb
X-Google-Smtp-Source: AGHT+IH3rJ2IKM0BnO0+Ts5FnFDNgqwyGDhKTsb4h2rdN++3Ef5YZkCx2+xS5xcHzx2bU/p3NW6jJA==
X-Received: by 2002:a81:6c16:0:b0:604:a0bb:5a50 with SMTP id h22-20020a816c16000000b00604a0bb5a50mr6192164ywc.5.1707757790965;
        Mon, 12 Feb 2024 09:09:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXpRdYvphrdMQ06kAWUx+6sqj0YzeAwoUp4tmNRtwQaHVQ9d65rttv0+0sxiJmyS/8rpWnqa++tpBB80/zy2V0eamWxKLLvbd5RnlznPUlo9VGWdgZSqil392E938TR1/BJjYsnb5ToUXcLMnKNRT/pc5ni1w8KGpaQpxtD4vh2aqpHSV01U9SOfF68xSKbv+Mg0aku458Qj0SIxT66bOn+nnCKHeDIW7pQ5RCYZ2pFDFcWyJm+6Uk/VbFy14Uue0HYslXnocn6Mp8Aka9Z4Q==
Received: from ?IPV6:2600:1700:6cf8:1240:e85e:3ff0:f75c:4129? ([2600:1700:6cf8:1240:e85e:3ff0:f75c:4129])
        by smtp.gmail.com with ESMTPSA id j131-20020a816e89000000b006041aaf23fcsm1246869ywc.64.2024.02.12.09.09.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 09:09:50 -0800 (PST)
Message-ID: <47ef712a-45fd-45d1-b494-7e435a7d0f8d@gmail.com>
Date: Mon, 12 Feb 2024 09:09:47 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v8 3/4] bpf: Create argument information for
 nullable arguments.
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, davemarchevsky@meta.com,
 dvernet@meta.com
References: <20240209023750.1153905-1-thinker.li@gmail.com>
 <20240209023750.1153905-4-thinker.li@gmail.com>
 <9404a412-90ca-4a45-92f2-a034f99c66f9@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <9404a412-90ca-4a45-92f2-a034f99c66f9@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/11/24 11:49, Martin KaFai Lau wrote:
> On 2/8/24 6:37 PM, thinker.li@gmail.com wrote:
>> +/* Prepare argument info for every nullable argument of a member of a
>> + * struct_ops type.
>> + *
>> + * Initialize a struct bpf_struct_ops_arg_info according to type info of
>> + * the arguments of a stub function. (Check kCFI for more information 
>> about
>> + * stub functions.)
>> + *
>> + * Each member in the struct_ops type has a struct 
>> bpf_struct_ops_arg_info
>> + * to provide an array of struct bpf_ctx_arg_aux, which in turn provides
>> + * the information that used by the verifier to check the arguments 
>> of the
>> + * BPF struct_ops program assigned to the member. Here, we only care 
>> about
>> + * the arguments that are marked as __nullable.
>> + *
>> + * The array of struct bpf_ctx_arg_aux is eventually assigned to
>> + * prog->aux->ctx_arg_info of BPF struct_ops programs and passed to the
>> + * verifier. (See check_struct_ops_btf_id())
>> + *
>> + * arg_info->info will be the list of struct bpf_ctx_arg_aux if 
>> success. If
>> + * fails, it will be kept untouched.
>> + */
>> +static int prepare_arg_info(struct btf *btf,
>> +                const char *st_ops_name,
>> +                const char *member_name,
>> +                const struct btf_type *func_proto,
>> +                struct bpf_struct_ops_arg_info *arg_info)
>> +{
>> +    const struct btf_type *stub_func_proto, *pointed_type;
>> +    const struct btf_param *stub_args, *args;
>> +    struct bpf_ctx_arg_aux *info, *info_buf;
>> +    u32 nargs, arg_no, info_cnt = 0;
>> +    s32 arg_btf_id;
>> +    int offset;
>> +
>> +    stub_func_proto = find_stub_func_proto(btf, st_ops_name, 
>> member_name);
>> +    if (!stub_func_proto)
>> +        return 0;
>> +
>> +    /* Check if the number of arguments of the stub function is the same
>> +     * as the number of arguments of the function pointer.
>> +     */
>> +    nargs = btf_type_vlen(func_proto);
>> +    if (nargs != btf_type_vlen(stub_func_proto)) {
>> +        pr_warn("the number of arguments of the stub function %s__%s 
>> does not match the number of arguments of the member %s of struct %s\n",
>> +            st_ops_name, member_name, member_name, st_ops_name);
>> +        return -EINVAL;
>> +    }
>> +
>> +    args = btf_params(func_proto);
>> +    stub_args = btf_params(stub_func_proto);
>> +
>> +    info_buf = kcalloc(nargs, sizeof(*info_buf), GFP_KERNEL);
>> +    if (!info_buf)
>> +        return -ENOMEM;
>> +
>> +    /* Prepare info for every nullable argument */
>> +    info = info_buf;
>> +    for (arg_no = 0; arg_no < nargs; arg_no++) {
>> +        /* Skip arguments that is not suffixed with
>> +         * "__nullable".
>> +         */
>> +        if (!btf_param_match_suffix(btf, &stub_args[arg_no],
>> +                        MAYBE_NULL_SUFFIX))
>> +            continue;
>> +
>> +        /* Should be a pointer to struct */
>> +        pointed_type = btf_type_resolve_ptr(btf,
>> +                            args[arg_no].type,
>> +                            &arg_btf_id);
>> +        if (!pointed_type ||
>> +            !btf_type_is_struct(pointed_type)) {
>> +            pr_warn("stub function %s__%s has %s tagging to an 
>> unsupported type\n",
>> +                st_ops_name, member_name, MAYBE_NULL_SUFFIX);
>> +            goto err_out;
>> +        }
> 
> We briefly talked about this and compiler can probably catch any arg
> type inconsistency between the stub func_proto and the original func_proto.
> 
> I still think it is better to be strict at the
> beginning and ensure the "stub_args" type is the same as the original 
> "args"
> type. It is to bar any type inconsistency going forward on the __nullable
> tagged argument (e.g. changing the original func_proto but forgot to
> change the stub func_proto).
> 
> We can revisit in the future if the following type comparison does not 
> work well.
> 
>                  if (args[arg_no].type != stub_args[arg_no].type) {
>              pr_warn("arg#%u type in stub func_proto %s__%s does not 
> match with its original func_proto\n",
>                  arg_no, st_ops_name, member_name);
>              goto err_out;
>                  }


Agree!

> 
>> +
>> +        offset = btf_ctx_arg_offset(btf, func_proto, arg_no);
>> +        if (offset < 0) {
>> +            pr_warn("stub function %s__%s has an invalid trampoline 
>> ctx offset for arg#%u\n",
>> +                st_ops_name, member_name, arg_no);
>> +            goto err_out;
>> +        }
>> +
>> +        /* Fill the information of the new argument */
>> +        info->reg_type =
>> +            PTR_TRUSTED | PTR_TO_BTF_ID | PTR_MAYBE_NULL;
>> +        info->btf_id = arg_btf_id;
>> +        info->btf = btf;
>> +        info->offset = offset;
>> +
>> +        info++;
>> +        info_cnt++;
>> +    }
>> +
>> +    if (info_cnt) {
>> +        arg_info->info = info_buf;
>> +        arg_info->cnt = info_cnt;
>> +    } else {
>> +        kfree(info_buf);
>> +    }
>> +
>> +    return 0;
>> +
>> +err_out:
>> +    kfree(info_buf);
>> +
>> +    return -EINVAL;
>> +}
>> +
>> +/* Clean up the arg_info in a struct bpf_struct_ops_desc. */
>> +void bpf_struct_ops_desc_release(struct bpf_struct_ops_desc 
>> *st_ops_desc)
>> +{
>> +    struct bpf_struct_ops_arg_info *arg_info;
>> +    int i;
>> +
>> +    arg_info = st_ops_desc->arg_info;
>> +    if (!arg_info)
> 
> nit. I think this check is unnecessary ?
> 
> If the above two comments make sense to you, I can make the adjustment. 
> No need to resend.


Agree!

> 
> Patch 4 lgtm.
> 
>> +        return;
>> +
>> +    for (i = 0; i < btf_type_vlen(st_ops_desc->type); i++)
>> +        kfree(arg_info[i].info);
>> +
>> +    kfree(arg_info);
>> +}
>> +
> 

