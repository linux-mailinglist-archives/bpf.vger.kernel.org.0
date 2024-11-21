Return-Path: <bpf+bounces-45364-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E66E9D4C2C
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 12:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03EB9282690
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 11:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1EB1D1740;
	Thu, 21 Nov 2024 11:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CyRhbrOS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E391D3562;
	Thu, 21 Nov 2024 11:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732189512; cv=none; b=OLnyf6r/ZBlN4br05Ogs7QDwKuoexOgh12xSW9ARJ9iRC64Ap5tCa46vxQoyFE7gL3IbzKI0T86rpN7aA+GbrfAo4ROE7vLsquAE1qUb5tgbhlscJNqPgE/uUqYWWEuQjYYN4pR4jr5Q8zA2OLWx5g5jZ2OspEXehQeEyHnIt7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732189512; c=relaxed/simple;
	bh=76QlNxxbh9ZM6XENGsooyiYCkvz+bTajOgnB97p1TMI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=RrdBbbXLyrjGTKF2N6ZyjLJ8E0ar15fUewQl3lNErmkJ7vBzX0yUcCqH+N5RYXOJbPFgOazcJAiAyWjhTMO6smlIIuQNdVOYjl5Xhgknbin6Dvle/gLJDz2rdxm4/2HNss3qQrhht97f1+YdS/zUkqQhsH9a4DOmEOi6TkdvN3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CyRhbrOS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87A5AC4CECC;
	Thu, 21 Nov 2024 11:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732189512;
	bh=76QlNxxbh9ZM6XENGsooyiYCkvz+bTajOgnB97p1TMI=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=CyRhbrOSSa+EO0ZOpb7bp0kaF8EbaUDC5iHyyBVJxpWrh6jIE8OlVS6iGjNbVWyY+
	 WQJ/Ir8XOil0n71l856JRSNql9QGbYXxvEzUx59lIRgR2kmGCR6EIKLpZzCYKGn0kr
	 atFjZINPBESRiyJVwLDnYsrd+nmvM2GXlEesMApjXahd5W40O2NHUsxnvi4IiWvl7R
	 2tIYhIRebLMoOpUlh7Z8CrbergZgnIIDkNt6d8gSrhZzgqPTZW/I/WvXByWEOkK38q
	 gEJgUKM1KHquTLoDPFh7+RK3TDxMG/vYeOLoP+YcZDs29ywyGE+oUWl/nyB8m0aFdB
	 TL35K5/GaSKNw==
Message-ID: <233974fc-f05c-4028-836e-581def599489@kernel.org>
Date: Thu, 21 Nov 2024 11:45:07 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpftool: Fix wrong format output
From: Quentin Monnet <qmo@kernel.org>
To: liujing <liujing@cmss.chinamobile.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, liujing <liujing_yewu@cmss.chinamobile.com>
References: <20241121084731.3570-1-liujing@cmss.chinamobile.com>
 <80690ecf-2d21-460c-b031-8133ca571e7c@kernel.org>
Content-Language: en-GB
In-Reply-To: <80690ecf-2d21-460c-b031-8133ca571e7c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2024-11-21 11:42 UTC+0000 ~ Quentin Monnet <qmo@kernel.org>
> 2024-11-21 16:47 UTC+0800 ~ liujing <liujing@cmss.chinamobile.com>
>> From: liujing <liujing_yewu@cmss.chinamobile.com>
>>
>> %d in format string requires 'int' but the argument type
>> of pf is 'unsigned int'.
>>
>> Signed-off-by: liujing <liujing@cmss.chinamobile.com>
>>
>> diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
>> index 5cd503b763d7..5bc442d93456 100644
>> --- a/tools/bpf/bpftool/link.c
>> +++ b/tools/bpf/bpftool/link.c
>> @@ -699,7 +699,7 @@ void netfilter_dump_plain(const struct bpf_link_info *info)
>>  	if (pfname)
>>  		printf("\n\t%s", pfname);
>>  	else
>> -		printf("\n\tpf: %d", pf);
>> +		printf("\n\tpf: %u", pf);
>>  
>>  	if (hookname)
>>  		printf(" %s", hookname);
> 
> 
> Thanks, but while at it can you also fix the format specifier for the
> other two prints of "lines" in the function (via "p_err()"), please?

Apologies, I got confused between your two patches when replying. Please
disregard the above for this patch, it looks good as it is.

Quentin

