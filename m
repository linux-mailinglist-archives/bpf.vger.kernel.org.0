Return-Path: <bpf+bounces-68772-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5429BB8451B
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 13:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B894A1C03B49
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 11:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2247B27F16A;
	Thu, 18 Sep 2025 11:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tW+tHfab"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF93F2940B
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 11:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758194283; cv=none; b=Bk1r5mTamuwbE29mKhahr2dJlq+WpDPsI9DIgVlLsEwIpND7p/F0u3NidiecWv9WlMzGwcWxCosenqE0jMo/F9oBTP16kx39KEMv8uDjBmsoP3KMSqTVeEObTofrbZKHHPForEMUKJsEASOsVN6WWiXVgFjD7lVgBR2W36NZUkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758194283; c=relaxed/simple;
	bh=LCcC386iayVF7Lf5/meg6Ya5puUCR8PvXWTPl4T7+JI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BGHZ8RZtOvYbK2q4mMQMmiu28hJk0VQPOA6cP7W3C2myj0M3E86DDY3HlTz9EpOq41s/Yqe5U2I3TQ3vT4oJAVYjVnMpEmtklV1aqZhXYwjK5hBOzSRAWotpzrbcCa86ppHqS4oYUjt2pWGMovOal6P6fgT7DBuFHfwskM8R6Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tW+tHfab; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <63eae916-a404-4fae-b870-203b7e376363@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758194269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y4OFedFFNeXU0WU9ck/G/uCK0A/60b5qhANqkwW6ZQg=;
	b=tW+tHfabVK0YQcY995tTi9c0umnMIcH/Yq2xOC4Mh4V3I5s6g7RYl6zkqZqEDbzhoFYwvt
	okrlwfw7h0Tg1or5/Kdt87ZEvbwTIKx2kQnHXXzjBR7A62pM2CjMZymbQH3jfj3YAvPygd
	uxXQHgHk1DBkLr+0i23xoVjGSvDEI98=
Date: Thu, 18 Sep 2025 19:17:32 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/2] bpftool: Fix UAF in get_delegate_value
To: Quentin Monnet <qmo@kernel.org>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250917034732.1185429-1-chen.dylane@linux.dev>
 <20250917034732.1185429-2-chen.dylane@linux.dev>
 <523d8d6c-de99-435f-a01b-1bac72810d53@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <523d8d6c-de99-435f-a01b-1bac72810d53@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/9/18 00:30, Quentin Monnet 写道:
> 2025-09-17 11:47 UTC+0800 ~ Tao Chen <chen.dylane@linux.dev>
>> The return value ret pointer is pointing opts_copy, but opts_copy
>> gets freed in get_delegate_value before return, fix this by free
>> the mntent->mnt_opts strdup memory after show delegate value.
>>
>> Fixes: 2d812311c2b2 ("bpftool: Add bpf_token show")
>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>> ---
>>   tools/bpf/bpftool/token.c | 75 +++++++++++++++++----------------------
>>   1 file changed, 33 insertions(+), 42 deletions(-)
>>
>> diff --git a/tools/bpf/bpftool/token.c b/tools/bpf/bpftool/token.c
>> index 82b829e44c8..05bc76c7276 100644
>> --- a/tools/bpf/bpftool/token.c
>> +++ b/tools/bpf/bpftool/token.c
>> @@ -28,15 +28,14 @@ static bool has_delegate_options(const char *mnt_ops)
>>   	       strstr(mnt_ops, "delegate_attachs");
>>   }
>>   
>> -static char *get_delegate_value(const char *opts, const char *key)
>> +static char *get_delegate_value(char *opts, const char *key)
>>   {
>>   	char *token, *rest, *ret = NULL;
>> -	char *opts_copy = strdup(opts);
>>   
>> -	if (!opts_copy)
>> +	if (!opts)
>>   		return NULL;
>>   
>> -	for (token = strtok_r(opts_copy, ",", &rest); token;
>> +	for (token = strtok_r(opts, ",", &rest); token;
>>   			token = strtok_r(NULL, ",", &rest)) {
>>   		if (strncmp(token, key, strlen(key)) == 0 &&
>>   		    token[strlen(key)] == '=') {
>> @@ -44,24 +43,19 @@ static char *get_delegate_value(const char *opts, const char *key)
>>   			break;
>>   		}
>>   	}
>> -	free(opts_copy);
>>   
>>   	return ret;
>>   }
>>   
>> -static void print_items_per_line(const char *input, int items_per_line)
>> +static void print_items_per_line(char *input, int items_per_line)
>>   {
>> -	char *str, *rest, *strs;
>> +	char *str, *rest;
>>   	int cnt = 0;
>>   
>>   	if (!input)
>>   		return;
>>   
>> -	strs = strdup(input);
>> -	if (!strs)
>> -		return;
>> -
>> -	for (str = strtok_r(strs, ":", &rest); str;
>> +	for (str = strtok_r(input, ":", &rest); str;
>>   			str = strtok_r(NULL, ":", &rest)) {
>>   		if (cnt % items_per_line == 0)
>>   			printf("\n\t  ");
>> @@ -69,38 +63,39 @@ static void print_items_per_line(const char *input, int items_per_line)
>>   		printf("%-20s", str);
>>   		cnt++;
>>   	}
>> -
>> -	free(strs);
>>   }
>>   
>> +#define PRINT_DELEGATE_OPT(opt_name) do {		\
>> +	char *opts, *value;				\
>> +	opts = strdup(mntent->mnt_opts);		\
>> +	value = get_delegate_value(opts, opt_name);	\
>> +	print_items_per_line(value, ITEMS_PER_LINE);	\
>> +	free(opts);					\
>> +} while (0)
> 
> 
> Thanks! The fix looks OK to me, but why do you need to have
> PRINT_DELEGATE_OPT*() as macros? Can't you just use functions instead?
> 
> Quentin

Well, actually, there is no special purpose about using macros, i will
use functions as you and Andrri suggested, thanks.

-- 
Best Regards
Tao Chen

