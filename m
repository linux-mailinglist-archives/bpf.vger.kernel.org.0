Return-Path: <bpf+bounces-39839-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0049784A1
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 17:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60D33B270C0
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 15:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3829F82C60;
	Fri, 13 Sep 2024 15:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGoKlFqM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B428824A1;
	Fri, 13 Sep 2024 15:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726240470; cv=none; b=nP2CmZcMkBI9RDQmJV71Xf2jgrpeIjVeS9vo+Lx8B9nHdWtU6UEIvnhiaq1Z1Y7i/m16WfADOYs+TjNL94qR2JglI0HKXAylKNfDgcYGSgo3FyxuPWApCJ5zLcmxsa0FLiEqKjCyXPwqcAsqD8Px2zkiAhjqhdH/gtMjIUbo38c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726240470; c=relaxed/simple;
	bh=g4jBOHib7DDLDufNgs9as3beAZdFvYAq+LxQwq6bJIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u29dMzvkG5aLQdAq1+T5fj7bfi2VVkBYYnlTbyE7B1wBkyWNDRbXJjlYS0V5ha4SeLrA3LZ6ohHb/aBx9OE21PhnH+VD9VUhUQBMchONq1ugoqzCdXsHT71rJKD9WYoLfy8gzKpN3tWZulbrJBAkahoybIeBk0eUhmeIU3YqNJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGoKlFqM; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-206f9b872b2so23237955ad.3;
        Fri, 13 Sep 2024 08:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726240468; x=1726845268; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTqRxpnsELCRZthgAUNY/2NziO6J5/9jQZ2ah9jAKF0=;
        b=RGoKlFqMgeU9qHR9s+f5M0Dy1YqOaghWcHRRw8eFZnU9aiKFhUeiwbLvBBIlHEGtX/
         PCau5LU4P/4xQOTqR6WKuSJaT9cWZizVP3pOTvypu8HsM9hLmIO56VCQVaYzJzBuyFwa
         tbKGJ6rctsf56gLoyZWHSq0ph9tzc+TOe+Zk6CKVokQmHBVSZ0q0kg2bl6kmBbhAE5Zb
         bRtuCY93FY+KS2Xq954LiDJbwBYeDfN8UQ+m5gfGC0EyZxQPCJVsPgxAr1d4mIIJ2JUV
         69mDR8TaNfNZvlH9Q/sgCAJXtdiyF577PUAOhu5EWTiBh7l+WNd64UYEpPUbYXLvakat
         iqfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726240468; x=1726845268;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sTqRxpnsELCRZthgAUNY/2NziO6J5/9jQZ2ah9jAKF0=;
        b=jBjn3F8kTL3H76Mt86RORTLIHoSC8dWgziw9FU+2of/WB8MRHQgXBJp2hdTYY7BD78
         R7wQbNUgbg/dZ/uqzAwEKMY15lsm0FcTgj1wqevb1uGxq2NVWxnzKf2hMEtavpurOl4y
         ic4Lap7l0ZdEEW1wFm+OdtGmsDlK+9+qPl54skrfyY2jG2MW5eEq4rWubhdbDrgVPxNC
         GbCZWDcXOzWN1UVL0UIlWT4Dg2P7Orj6JDflWXr7UmQeeF66HJl9EbCT8OcZYx/3NboF
         1IM5ERCReZhg5vfXRpyxfoHJgLxZrl4zfjHmqfHzsVqIvcTJdY+TQqj5wvAhx7VE7Pnq
         AgIA==
X-Forwarded-Encrypted: i=1; AJvYcCUlCO++LV5w4qZzhv2dV3o1oVQIJCQLia7WLSZmNxP2IfCu5d5Pn62Zd/bfhAQQ59hxPHg=@vger.kernel.org, AJvYcCVyEmBgFkwdj2K9TUiFPyq57R9eGYp/43b10EAiolaP/pww8MUNKRHtgrEaT8o69GRW1v5Gbw1v1E1QI8Mp@vger.kernel.org
X-Gm-Message-State: AOJu0YxxF4yrdMh5XIrclgS1vAzevPMvkbU9DgZoUX28G4C6/ekBDJOG
	8Jx8b0Fp2lWl6nmosW/4EsY3tPpMrsaj3K82UcJmhJgX1E9Pf8iO
X-Google-Smtp-Source: AGHT+IGiszi5u/D2JmGS2Ec+IKq8GqyWeaf3SUz5xBSUd1WMfC8UDHQC75fRy58VHrpkoUvgUKelHA==
X-Received: by 2002:a17:903:986:b0:1fb:6294:2e35 with SMTP id d9443c01a7336-2076e4854f3mr94126525ad.50.1726240467968;
        Fri, 13 Sep 2024 08:14:27 -0700 (PDT)
Received: from [192.168.50.122] ([117.147.91.189])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076af25683sm29343895ad.17.2024.09.13.08.14.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 08:14:27 -0700 (PDT)
Message-ID: <0e26d4c9-3e14-4bf9-85d3-86131e6a07f8@gmail.com>
Date: Fri, 13 Sep 2024 23:14:17 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] libbpf: Fix expected_attach_type set when kernel
 not support
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240913121627.153898-1-chen.dylane@gmail.com>
 <ZuRCO3_075wY2zbG@krava>
From: Tao Chen <chen.dylane@gmail.com>
In-Reply-To: <ZuRCO3_075wY2zbG@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2024/9/13 21:48, Jiri Olsa 写道:
> On Fri, Sep 13, 2024 at 08:16:27PM +0800, Tao Chen wrote:
>> The commit "5902da6d8a52" set expected_attach_type again with
>> filed of bpf_program after libpf_prepare_prog_load, which makes
>> expected_attach_type = 0 no sense when kenrel not support the
>> attach_type feature, so fix it.
>>
>> Fixes: 5902da6d8a52 ("libbpf: Add uprobe multi link support to bpf_program__attach_usdt")
>> Signed-off-by: Tao Chen <chen.dylane@gmail.com>
>> ---
>>   tools/lib/bpf/libbpf.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 219facd0e66e..9035edf763a3 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -7343,7 +7343,7 @@ static int libbpf_prepare_prog_load(struct bpf_program *prog,
>>   
>>   	/* old kernels might not support specifying expected_attach_type */
>>   	if ((def & SEC_EXP_ATTACH_OPT) && !kernel_supports(prog->obj, FEAT_EXP_ATTACH_TYPE))
>> -		opts->expected_attach_type = 0;
>> +		prog->expected_attach_type = 0;
>>   
>>   	if (def & SEC_SLEEPABLE)
>>   		opts->prog_flags |= BPF_F_SLEEPABLE;
>> -- 
>> 2.25.1
>>
> 
> good catch! thanks
> 
> I can't remember why it was needed, perhaps we should go back to where it
> was before?
> 
> I'm guessing prog->expected_attach_type might not get updated properly and
> that might cause issues, not sure
> 
> thanks,
> jirka
> 
> 
> ---
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 219facd0e66e..df2244397ba1 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -7353,7 +7353,7 @@ static int libbpf_prepare_prog_load(struct bpf_program *prog,
>   
>   	/* special check for usdt to use uprobe_multi link */
>   	if ((def & SEC_USDT) && kernel_supports(prog->obj, FEAT_UPROBE_MULTI_LINK))
> -		prog->expected_attach_type = BPF_TRACE_UPROBE_MULTI;
> +		opts->expected_attach_type = BPF_TRACE_UPROBE_MULTI;
>   
>   	if ((def & SEC_ATTACH_BTF) && !prog->attach_btf_id) {
>   		int btf_obj_fd = 0, btf_type_id = 0, err;
> @@ -7443,6 +7443,7 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
>   	load_attr.attach_btf_id = prog->attach_btf_id;
>   	load_attr.kern_version = kern_version;
>   	load_attr.prog_ifindex = prog->prog_ifindex;
> +	load_attr.expected_attach_type = prog->expected_attach_type;
>   
>   	/* specify func_info/line_info only if kernel supports them */
>   	if (obj->btf && btf__fd(obj->btf) >= 0 && kernel_supports(obj, FEAT_BTF_FUNC)) {
> @@ -7474,9 +7475,6 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
>   		insns_cnt = prog->insns_cnt;
>   	}
>   
> -	/* allow prog_prepare_load_fn to change expected_attach_type */
> -	load_attr.expected_attach_type = prog->expected_attach_type;
> -
>   	if (obj->gen_loader) {
>   		bpf_gen__prog_load(obj->gen_loader, prog->type, prog->name,
>   				   license, insns, insns_cnt, &load_attr,


Hi, Jiri, thank you for your reply.
It looks better your way, i will send it in v2.

-- 
Best Regards
Dylane Chen

