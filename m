Return-Path: <bpf+bounces-64080-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D7FB0E1FF
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 18:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2C5716D17D
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 16:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD65127AC32;
	Tue, 22 Jul 2025 16:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PTOhhcNa"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C521820CCDC
	for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 16:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753202177; cv=none; b=Kgc9CcX1VlaO2xlWjK7l8k+oXviYrQAoUHdFCPD53RHhsTaTvszwh+QwVJ8iKh05aekQmRaSb4tKSwdJF2EqfEzEL/3BomrK4eVHmqc5AD3aj+LyEP9md5KlWkulZLdjQqat9TgdCRtW5Vu0IzfbNNoRA89fdFJMtTWtW/wfYks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753202177; c=relaxed/simple;
	bh=jD3QayzdcggqoSc8UngUlmjoqdFLiHcnz8zfpitTb8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CZZRpxZqxgeHr//qWkAGzopNM9cLuFbJY/LzCUXnSmAtOYmt0gL0BpCHM+CXt2dTnMnnQSnLRxsDyTaWquwklm9SyG6s2ZQx3T+fB0WW6vtoQF6UIdWoqfDopUs9Dp4/esQ4jy64zteT4ge8D8Jdd4eJSZBWCHcwpMteblxaLqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PTOhhcNa; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5681662e-6038-433f-9da7-438b383621b7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753202163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=58pvaCs+xgE9yS/q0WEYLSExFzaY39BOzBBTwJRQn7k=;
	b=PTOhhcNa8/7hDCVVDLT3bn8pDi7Oz/w60ErTXpAs4vHeqmPxYtO/OFDd0CBFcrBzQbn/Ur
	z8mrjyE5BGWPIRW89NEfX8m4q+vogMx3qFUraCJ27MRxvALFoY3fS05EzJuKyGCWbIoMoD
	KIMHG19Lz6kVJymemjjDXtEE+QHetHs=
Date: Wed, 23 Jul 2025 00:35:48 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 3/3] bpftool: Add bash completion for token
 argument
To: Quentin Monnet <qmo@kernel.org>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20250722120912.1391604-1-chen.dylane@linux.dev>
 <20250722120912.1391604-3-chen.dylane@linux.dev>
 <ba84629f-5675-4793-9320-25d9029d2a35@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <ba84629f-5675-4793-9320-25d9029d2a35@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/7/22 23:02, Quentin Monnet 写道:
> 2025-07-22 20:09 UTC+0800 ~ Tao Chen <chen.dylane@linux.dev>
>> This commit updates the bash completion script with the new token
>> argument.
>> $ bpftool
>> batch       cgroup      gen         iter        map         perf        struct_ops
>> btf         feature     help        link        net         prog        token
> 
> 
> This is a terrible example, offering "token" as completion for just
> "bpftool [tab]" works without this patch :) The main commands are parsed
> from the output of "bpftool help" so it should work after your first
> patch. In this one, we add "list", "show" and "help" for completing
> "bpftool token [tab]".
> 

As you said, how about this one? I will change it in v3, thanks.
     $ bpftool token
     help  list  show

> 
>>
>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>> ---
>>   tools/bpf/bpftool/bash-completion/bpftool | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
>> index a759ba24471..527bb47ac46 100644
>> --- a/tools/bpf/bpftool/bash-completion/bpftool
>> +++ b/tools/bpf/bpftool/bash-completion/bpftool
>> @@ -1215,6 +1215,17 @@ _bpftool()
>>                       ;;
>>               esac
>>               ;;
>> +        token)
>> +            case $command in
>> +               show|list)
>> +                   return 0
>> +                   ;;
>> +               *)
>> +                   [[ $prev == $object ]] && \
>> +                       COMPREPLY=( $( compgen -W 'help show list' -- "$cur" ) )
>> +                   ;;
>> +            esac
>> +            ;;
>>       esac
>>   } &&
>>   complete -F _bpftool bpftool
> 
> 
> Other than the example in the description, this looks good.
> 
> Reviewed-by: Quentin Monnet <qmo@kernel.org>
> 
> Thanks


-- 
Best Regards
Tao Chen

