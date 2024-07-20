Return-Path: <bpf+bounces-35163-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A1E938092
	for <lists+bpf@lfdr.de>; Sat, 20 Jul 2024 11:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00F381F21898
	for <lists+bpf@lfdr.de>; Sat, 20 Jul 2024 09:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4372C7E574;
	Sat, 20 Jul 2024 09:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XL+CgaGm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A7115AE0;
	Sat, 20 Jul 2024 09:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721469458; cv=none; b=cwnEiuk14Z8i7ubMNdxowQD7dw3q6ITqtnXRBLRZ7Kj2ltZaLtyyq4/TAmwl+CvIC9076VkEf5pe7MEOUGT33h+PbsEM7gEufMnSIWJuMcuzf9XVW3EPyYE9AlB3+0R7iXJxKQzLh8eTjnwX5DuxzQDBg/y4mvcxOPKs1hheXyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721469458; c=relaxed/simple;
	bh=pI6+/cl5fHcJLsP8KNLz1goMLsqIFDPKFvV/bnQaXEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IC5zat6f6AHklYpLuBiWQ9h2bdcZ1gp9fqR2cPPF72L86rvluWO464K0T6BDejo8LeTglgsbM4deJir7A5/VTDN7t57oo40GTmLe1iYRtKLeDRP89isCBmD6KSVyuILB1vihJiW626W3sb9Z+s+YSJ2pf17IF+5HavLjYob4WdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XL+CgaGm; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70afe18837cso1108957b3a.3;
        Sat, 20 Jul 2024 02:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721469456; x=1722074256; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gUbbx1Otrdel4AFReaWE4AeMjSeZObzKo500myWjxeM=;
        b=XL+CgaGmSG1BE7vHeYwCPt4tuu0EUnCIQWqEl5+bMmtqw2ac1GstLLAKEhuwjvlNYM
         3VLjxXpU5LFLJA33muP9tt3S7Ow/9UM92BQMeTNFo1nobYCPy4+cPhEOR7L2z/vM4+uU
         z6dyaCIsTx14gu3Py2PyykMs4LhIxKzdSe98UZ5vZ01bDCBovctDWihwVtd11EIV7epl
         chUxXAQS+ytNieSu1OuyhZ+ic/krGscsyzqEsrMBtwN64YPvIb+03Ox036OxIH+8PDvb
         6VEQUtSLMV03YwiSqtzxKuIu1HkGpClM3tTm82tBR6X/joiCRwaqEkXcGI0yBcyYIf7F
         zYKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721469456; x=1722074256;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gUbbx1Otrdel4AFReaWE4AeMjSeZObzKo500myWjxeM=;
        b=ob1IVx3bF2bLW99M3LKp0/WhlIMY0G0YAkekeuUr9td5r24O6GLoWv73XtY7+2XaC/
         ZFBl/YHwE8cj/bwYbzJAjiuEMWeEKapEAvdmZzYVZ95BcTHknFDe9HKJEQIzf5pYh5+6
         69NzWs0D/IZlWuKVlZpCO3ttnZgma0v1GsdEstlpafmWKS6xxmz6qb0+Q+VvL94EfAQP
         M9yU02aytZaMFX6d8c87HAJB+ipfSigB699ZW0SHyQjeMtQ9LPJtuvbBlHHso46DS7D+
         m+FOtM+cspUZ9/kdOScZ/bRgVJ60SSN0/1dwS+YnnZPIOh8OPEuNmHQA22Dfs8JlGHAv
         eScg==
X-Forwarded-Encrypted: i=1; AJvYcCV4klQBrKvhHDGau7pZZz/s5zmdWAWMThe+crIIkxjTsylmyg24dvIihMWmLIybjGFf093x5Ih44NlRhEDMzthidXBgGa0+2MyVqQNnM0m7VCFPmQjKxO20IE31AkFSXS4v
X-Gm-Message-State: AOJu0Yz3ZNDdT03Sz+k47UZkBqn0uzOuCwY+iDVfD7pNR7w9n0eUKOh7
	aK2xjhrGBG4WRgmU+sz8BqczcYxULkvf7WeGFS4155fwUmyPEXmZy43qAA==
X-Google-Smtp-Source: AGHT+IEdhbg6wqyjAGlvF/AYnW2mOCfWz4H+my6SOl3ig8NMDj16E4ZDLQ/Xf4mNSmqLm1vZ/khZ2Q==
X-Received: by 2002:a05:6a00:c8f:b0:706:74b7:9d78 with SMTP id d2e1a72fcca58-70d0ee19627mr568476b3a.0.1721469456016;
        Sat, 20 Jul 2024 02:57:36 -0700 (PDT)
Received: from [192.168.0.121] ([39.172.10.229])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d140c024esm424902b3a.12.2024.07.20.02.57.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jul 2024 02:57:35 -0700 (PDT)
Message-ID: <77ddcb0e-a7fa-468d-b8bd-c74e9bb1f8c2@gmail.com>
Date: Sat, 20 Jul 2024 17:57:29 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 PATCH bpf-next 2/4] bpftool: add net attach/detach command to
 tcx prog
To: Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240717174749.1511366-1-chen.dylane@gmail.com>
 <fa9bb6d5-7a72-4d77-8862-d8489a759506@kernel.org>
From: Tao Chen <chen.dylane@gmail.com>
In-Reply-To: <fa9bb6d5-7a72-4d77-8862-d8489a759506@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2024/7/20 00:17, Quentin Monnet 写道:
> On 17/07/2024 18:47, Tao Chen wrote:
>> Now, attach/detach tcx prog supported in libbpf, so we can add new
>> command 'bpftool attach/detach tcx' to attach tcx prog with bpftool
>> for user.
>>
>>   # bpftool prog load tc_prog.bpf.o /sys/fs/bpf/tc_prog
>>   # bpftool prog show
>> 	...
>> 	192: sched_cls  name tc_prog  tag 187aeb611ad00cfc  gpl
>> 	loaded_at 2024-07-11T15:58:16+0800  uid 0
>> 	xlated 152B  jited 97B  memlock 4096B  map_ids 100,99,97
>> 	btf_id 260
>>   # bpftool net attach tcx_ingress name tc_prog dev lo
>>   # bpftool net
>> 	...
>> 	tc:
>> 	lo(1) tcx/ingress tc_prog prog_id 29
>>
>>   # bpftool net detach tcx_ingress dev lo
>>   # bpftool net
>> 	...
>> 	tc:
>>   # bpftool net attach tcx_ingress name tc_prog dev lo
>>   # bpftool net
>> 	tc:
>> 	lo(1) tcx/ingress tc_prog prog_id 29
>>
>> Test environment: ubuntu_22_04, 6.7.0-060700-generic
>>
>> Signed-off-by: Tao Chen <chen.dylane@gmail.com>
>> ---
>>   tools/bpf/bpftool/net.c | 43 ++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 42 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/bpf/bpftool/net.c b/tools/bpf/bpftool/net.c
>> index 1b9f4225b394..60b0af40109a 100644
>> --- a/tools/bpf/bpftool/net.c
>> +++ b/tools/bpf/bpftool/net.c
>> @@ -67,6 +67,8 @@ enum net_attach_type {
>>   	NET_ATTACH_TYPE_XDP_GENERIC,
>>   	NET_ATTACH_TYPE_XDP_DRIVER,
>>   	NET_ATTACH_TYPE_XDP_OFFLOAD,
>> +	NET_ATTACH_TYPE_TCX_INGRESS,
>> +	NET_ATTACH_TYPE_TCX_EGRESS,
>>   };
>>   
>>   static const char * const attach_type_strings[] = {
>> @@ -74,6 +76,8 @@ static const char * const attach_type_strings[] = {
>>   	[NET_ATTACH_TYPE_XDP_GENERIC]	= "xdpgeneric",
>>   	[NET_ATTACH_TYPE_XDP_DRIVER]	= "xdpdrv",
>>   	[NET_ATTACH_TYPE_XDP_OFFLOAD]	= "xdpoffload",
>> +	[NET_ATTACH_TYPE_TCX_INGRESS]	= "tcx_ingress",
>> +	[NET_ATTACH_TYPE_TCX_EGRESS]	= "tcx_egress",
>>   };
>>   
>>   static const char * const attach_loc_strings[] = {
>> @@ -647,6 +651,32 @@ static int do_attach_detach_xdp(int progfd, enum net_attach_type attach_type,
>>   	return bpf_xdp_attach(ifindex, progfd, flags, NULL);
>>   }
>>   
>> +static int get_tcx_type(enum net_attach_type attach_type)
>> +{
>> +	switch (attach_type) {
>> +	case NET_ATTACH_TYPE_TCX_INGRESS:
>> +		return BPF_TCX_INGRESS;
>> +	case NET_ATTACH_TYPE_TCX_EGRESS:
>> +		return BPF_TCX_EGRESS;
>> +	default:
>> +		return __MAX_BPF_ATTACH_TYPE;
> 
> 
> Can we return -1 here instead, please? In the current code, we validate
> the attach_type before entering this function and the "default" case is
> never reached, it's only here to discard compiler's warning. But if we
> ever reuse this function elsewhere, this could cause bugs: if the header
> file used for compiling the bpftool binary is not in sync with the
> header corresponding to the running kernel, __MAX_BPF_ATTACH_TYPE could
> correspond to a newly introduced type, and bpftool/libbpf would try to
> use that to attach the program, instead of detecting an error.
> 
> 

Hi, Quentin, i didn’t take the use case you mentioned into account. As 
you said, -1 looks more reasonable. I will fix it in the next revisions.

>> +	}
>> +}
>> +
>> +static int do_attach_tcx(int progfd, enum net_attach_type attach_type, int ifindex)
>> +{
>> +	int type = get_tcx_type(attach_type);
>> +
>> +	return bpf_prog_attach(progfd, ifindex, type, 0);
>> +}
>> +
>> +static int do_detach_tcx(int targetfd, enum net_attach_type attach_type)
>> +{
>> +	int type = get_tcx_type(attach_type);
>> +
>> +	return bpf_prog_detach(targetfd, type);
>> +}
>> +
>>   static int do_attach(int argc, char **argv)
>>   {
>>   	enum net_attach_type attach_type;
>> @@ -692,6 +722,11 @@ static int do_attach(int argc, char **argv)
>>   	case NET_ATTACH_TYPE_XDP_OFFLOAD:
>>   		err = do_attach_detach_xdp(progfd, attach_type, ifindex, overwrite);
>>   		break;
>> +	/* attach tcx prog */
>> +	case NET_ATTACH_TYPE_TCX_INGRESS:
>> +	case NET_ATTACH_TYPE_TCX_EGRESS:
>> +		err = do_attach_tcx(progfd, attach_type, ifindex);
>> +		break;
>>   	default:
>>   		break;
>>   	}
>> @@ -738,6 +773,11 @@ static int do_detach(int argc, char **argv)
>>   		progfd = -1;
>>   		err = do_attach_detach_xdp(progfd, attach_type, ifindex, NULL);
>>   		break;
>> +	/* detach tcx prog */
>> +	case NET_ATTACH_TYPE_TCX_INGRESS:
>> +	case NET_ATTACH_TYPE_TCX_EGRESS:
>> +		err = do_detach_tcx(ifindex, attach_type);
>> +		break;
>>   	default:
>>   		break;
>>   	}
>> @@ -944,7 +984,8 @@ static int do_help(int argc, char **argv)
>>   		"       %1$s %2$s help\n"
>>   		"\n"
>>   		"       " HELP_SPEC_PROGRAM "\n"
>> -		"       ATTACH_TYPE := { xdp | xdpgeneric | xdpdrv | xdpoffload }\n"
>> +		"       ATTACH_TYPE := { xdp | xdpgeneric | xdpdrv | xdpoffload | tcx_ingress\n"
>> +		"			 | tcx_egress }\n"
> 
>                   ^^^^^^^^^^^^^^^^^^^^^^^
> This indent space between the quote and the pipe needs to be spaces
> instead of three tabs, please.

My editor problem, i will fix it in the next revisions.

> 
> The rest of the patches looks good, thank you!
Thank you for reviewing all the patches. I appreciate your feedback.

> 
> Quentin
>
-- 
Best Regards
Dylane Chen


