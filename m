Return-Path: <bpf+bounces-29547-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8EE8C2C23
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 23:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74EAE1F232FD
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 21:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBAF13CFA3;
	Fri, 10 May 2024 21:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFIQWOgi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567EB13B5BB
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 21:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715378382; cv=none; b=CY/H/ucAmkJghsyIxInRXdLxAQrvfC5tkjsN92bXnFLRNy4MN9Eznx2qcoXBhQaZKhF6o4N72pVaf2OJzbaralu3CAhkCNpwpueyNOq9VAK7NLaiGpgyoSe+kf41/+w7DV/UDh+aTt0VRhQhZXOqkp66XYLk5ZXvYcVpTIZh5t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715378382; c=relaxed/simple;
	bh=hG4LsXpV9beyLhmo+zDYxp8SX3+jL0lfxULxKCf74eQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ciFJsQj+hJb27Fk0tbxZ2QyjJhUdYkBTeRTHQJR9OEIFTsMC6ttJjBmWBIvS8zq23mm/uov6qKzrEhCVNPASSqRS7QpWpTU/2I5E3z2A5vX1M5i1w8c1AffCfa25BRkoKwj2dCRW7YUQm3WN8KWcoai5RrykwpOAwUvpvzN3020=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFIQWOgi; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5aa1bf6cb40so1712720eaf.1
        for <bpf@vger.kernel.org>; Fri, 10 May 2024 14:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715378380; x=1715983180; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V/EkHOr+7tzYv0/5cIU8z1xhgVZBJLTxm0dsgrO3+IA=;
        b=KFIQWOgi9Il+aCW086lmioZZNTz7PnjBt1ecVahG0DKjO6slpU41Jwe9T9e4KdU5PW
         +/ozJXPkdebM2HLt2FJENkVn/WERIFBOoQJofhfdsMsTwIVBSTO2ZvjiOWZfEtmpK+sW
         omzdhgWlWYnVJzJrP6UG0frCzBl4571423w8viF73S0+GRmcNtTy2V61U2uKD8hf11R6
         lT7dNUBTanC+Dn3GZdbdJSumdhv34JhOvfAROn7x/1WNaFgrOxO/q6YuJULsR1/GuEC0
         S9DYXXL1DCZYfyIkIy58nioHhzOAVts27cfXsxT4QWVRET5ca2eDTpCxzwFBcksR8Bis
         LgMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715378380; x=1715983180;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V/EkHOr+7tzYv0/5cIU8z1xhgVZBJLTxm0dsgrO3+IA=;
        b=YaG30vF2Ox1zVolTzYm+LVzxrYBDD13+Nw7QRzZSWP6m8gyb2c/MlvwXjcnZLIDniO
         7YKoJiR8GZ9uJqaO04Tdb/tBIBZYQKP3YdjjrTFlN+CSsS4wwruCi/y/j7/Sxb/697zs
         p6I5Ju4E1EqZUplJ/Axk+cNk8lyQUucBUPH4cO3lFt5nIfemZ/DY++27B1te/6h3C+G1
         tXUlt1Z6au23cGEG3rSjmDVIpo1EZy90lLmLDS0jA5xO0vzLUHwdFru2vXpavxwtYLTC
         J3VfQJTjz75J5cThhsVNESNGOY0tQmXxFXCFozxHsAHLgu2SWXbztnQw8ACxN/5ZqSlj
         QA6w==
X-Forwarded-Encrypted: i=1; AJvYcCUMTL72hPCSD8FHzj23IJbeRwxQFvOwb46B+r+1iEnwlxtUH7JfplgVY+Rg6DKa4bXBypMWbpQLYXMe3uoQLlFhYKno
X-Gm-Message-State: AOJu0YwjW1BZWsChD+1fI53CBOd5BJXhUYFDdou58nQSITvuXUly4mMA
	g+SzqA/0HMeeOZ77mp9DuHgANwUgxDICAn9hcQtazrGpTNAwvhiE
X-Google-Smtp-Source: AGHT+IF/NZ9ETok1D5MYAHu5n6f4yBWnCS8GTRvrHBOacrEaGy1lZZ+KnX80O3s2jLoRtmBD52Ay+Q==
X-Received: by 2002:a4a:9c2:0:b0:5a9:cef4:fcea with SMTP id 006d021491bc7-5b281850062mr4121179eaf.1.1715378380466;
        Fri, 10 May 2024 14:59:40 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:20fd:6927:f7be:d222? ([2600:1700:6cf8:1240:20fd:6927:f7be:d222])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5b2915d3c65sm229899eaf.37.2024.05.10.14.59.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 14:59:40 -0700 (PDT)
Message-ID: <d2b9a943-ca26-404d-899a-c7651ce18a42@gmail.com>
Date: Fri, 10 May 2024 14:59:38 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 7/9] selftests/bpf: Test kptr arrays and kptrs
 in nested struct fields.
To: Eduard Zingerman <eddyz87@gmail.com>, Kui-Feng Lee
 <thinker.li@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
 martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org
Cc: kuifeng@meta.com
References: <20240510011312.1488046-1-thinker.li@gmail.com>
 <20240510011312.1488046-8-thinker.li@gmail.com>
 <d8f2fa21a9af5bfcb2acb1addecea435285c40e6.camel@gmail.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <d8f2fa21a9af5bfcb2acb1addecea435285c40e6.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/10/24 03:03, Eduard Zingerman wrote:
> On Thu, 2024-05-09 at 18:13 -0700, Kui-Feng Lee wrote:
>> Make sure that BPF programs can declare global kptr arrays and kptr fields
>> in struct types that is the type of a global variable or the type of a
>> nested descendant field in a global variable.
>>
>> An array with only one element is special case, that it treats the element
>> like a non-array kptr field. Nested arrays are also tested to ensure they
>> are handled properly.
>>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
>>   .../selftests/bpf/prog_tests/cpumask.c        |   5 +
>>   .../selftests/bpf/progs/cpumask_success.c     | 133 ++++++++++++++++++
>>   2 files changed, 138 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/cpumask.c b/tools/testing/selftests/bpf/prog_tests/cpumask.c
>> index ecf89df78109..2570bd4b0cb2 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/cpumask.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/cpumask.c
>> @@ -18,6 +18,11 @@ static const char * const cpumask_success_testcases[] = {
>>   	"test_insert_leave",
>>   	"test_insert_remove_release",
>>   	"test_global_mask_rcu",
>> +	"test_global_mask_array_one_rcu",
>> +	"test_global_mask_array_rcu",
>> +	"test_global_mask_array_l2_rcu",
>> +	"test_global_mask_nested_rcu",
>> +	"test_global_mask_nested_deep_rcu",
>>   	"test_cpumask_weight",
>>   };
>>   
>> diff --git a/tools/testing/selftests/bpf/progs/cpumask_success.c b/tools/testing/selftests/bpf/progs/cpumask_success.c
>> index 7a1e64c6c065..0b6383fa9958 100644
>> --- a/tools/testing/selftests/bpf/progs/cpumask_success.c
>> +++ b/tools/testing/selftests/bpf/progs/cpumask_success.c
>> @@ -12,6 +12,25 @@ char _license[] SEC("license") = "GPL";
>>   
>>   int pid, nr_cpus;
>>   
>> +struct kptr_nested {
>> +	struct bpf_cpumask __kptr * mask;
>> +};
>> +
>> +struct kptr_nested_mid {
>> +	int dummy;
>> +	struct kptr_nested m;
>> +};
>> +
>> +struct kptr_nested_deep {
>> +	struct kptr_nested_mid ptrs[2];
>> +};
> 
> For the sake of completeness, would it be possible to create a test
> case where there are several struct arrays following each other?
> E.g. as below:
> 
> struct foo {
>    ... __kptr *a;
>    ... __kptr *b;
> }
> 
> struct bar {
>    ... __kptr *c;
> }
> 
> struct {
>    struct foo foos[3];
>    struct bar bars[2];
> }
> 
> Just to check that offset is propagated correctly.

Sure!

> 
> Also, in the tests below you check that a pointer to some object could
> be put into an array at different indexes. Tbh, I find it not very
> interesting if we want to check that offsets are correct.
> Would it be possible to create an array of object kptrs,
> put specific references at specific indexes and somehow check which
> object ended up where? (not necessarily 'bpf_cpumask').

Do you mean checking index in the way like the following code?

  if (array[0] != ref0 || array[1] != ref1 || array[2] != ref2 ....)
    return err;

> 
>> +
>> +private(MASK) static struct bpf_cpumask __kptr * global_mask_array[2];
>> +private(MASK) static struct bpf_cpumask __kptr * global_mask_array_l2[2][1];
>> +private(MASK) static struct bpf_cpumask __kptr * global_mask_array_one[1];
>> +private(MASK) static struct kptr_nested global_mask_nested[2];
>> +private(MASK) static struct kptr_nested_deep global_mask_nested_deep;
>> +
>>   static bool is_test_task(void)
>>   {
>>   	int cur_pid = bpf_get_current_pid_tgid() >> 32;
>> @@ -460,6 +479,120 @@ int BPF_PROG(test_global_mask_rcu, struct task_struct *task, u64 clone_flags)
>>   	return 0;
>>   }
>>   
>> +SEC("tp_btf/task_newtask")
>> +int BPF_PROG(test_global_mask_array_one_rcu, struct task_struct *task, u64 clone_flags)
>> +{
>> +	struct bpf_cpumask *local, *prev;
>> +
>> +	if (!is_test_task())
>> +		return 0;
>> +
>> +	/* Kptr arrays with one element are special cased, being treated
>> +	 * just like a single pointer.
>> +	 */
>> +
>> +	local = create_cpumask();
>> +	if (!local)
>> +		return 0;
>> +
>> +	prev = bpf_kptr_xchg(&global_mask_array_one[0], local);
>> +	if (prev) {
>> +		bpf_cpumask_release(prev);
>> +		err = 3;
>> +		return 0;
>> +	}
>> +
>> +	bpf_rcu_read_lock();
>> +	local = global_mask_array_one[0];
>> +	if (!local) {
>> +		err = 4;
>> +		bpf_rcu_read_unlock();
>> +		return 0;
>> +	}
>> +
>> +	bpf_rcu_read_unlock();
>> +
>> +	return 0;
>> +}
>> +
>> +static int _global_mask_array_rcu(struct bpf_cpumask **mask0,
>> +				  struct bpf_cpumask **mask1)
>> +{
>> +	struct bpf_cpumask *local;
>> +
>> +	if (!is_test_task())
>> +		return 0;
>> +
>> +	/* Check if two kptrs in the array work and independently */
>> +
>> +	local = create_cpumask();
>> +	if (!local)
>> +		return 0;
>> +
>> +	bpf_rcu_read_lock();
>> +
>> +	local = bpf_kptr_xchg(mask0, local);
>> +	if (local) {
>> +		err = 1;
>> +		goto err_exit;
>> +	}
>> +
>> +	/* [<mask 0>, NULL] */
>> +	if (!*mask0 || *mask1) {
>> +		err = 2;
>> +		goto err_exit;
>> +	}
>> +
>> +	local = create_cpumask();
>> +	if (!local) {
>> +		err = 9;
>> +		goto err_exit;
>> +	}
>> +
>> +	local = bpf_kptr_xchg(mask1, local);
>> +	if (local) {
>> +		err = 10;
>> +		goto err_exit;
>> +	}
>> +
>> +	/* [<mask 0>, <mask 1>] */
>> +	if (!*mask0 || !*mask1 || *mask0 == *mask1) {
>> +		err = 11;
>> +		goto err_exit;
>> +	}
>> +
>> +err_exit:
>> +	if (local)
>> +		bpf_cpumask_release(local);
>> +	bpf_rcu_read_unlock();
>> +	return 0;
>> +}
>> +
>> +SEC("tp_btf/task_newtask")
>> +int BPF_PROG(test_global_mask_array_rcu, struct task_struct *task, u64 clone_flags)
>> +{
>> +	return _global_mask_array_rcu(&global_mask_array[0], &global_mask_array[1]);
>> +}
>> +
>> +SEC("tp_btf/task_newtask")
>> +int BPF_PROG(test_global_mask_array_l2_rcu, struct task_struct *task, u64 clone_flags)
>> +{
>> +	return _global_mask_array_rcu(&global_mask_array_l2[0][0], &global_mask_array_l2[1][0]);
>> +}
>> +
>> +SEC("tp_btf/task_newtask")
>> +int BPF_PROG(test_global_mask_nested_rcu, struct task_struct *task, u64 clone_flags)
>> +{
>> +	return _global_mask_array_rcu(&global_mask_nested[0].mask, &global_mask_nested[1].mask);
>> +}
>> +
>> +SEC("tp_btf/task_newtask")
>> +int BPF_PROG(test_global_mask_nested_deep_rcu, struct task_struct *task, u64 clone_flags)
>> +{
>> +	return _global_mask_array_rcu(&global_mask_nested_deep.ptrs[0].m.mask,
>> +				      &global_mask_nested_deep.ptrs[1].m.mask);
>> +}
>> +
>>   SEC("tp_btf/task_newtask")
>>   int BPF_PROG(test_cpumask_weight, struct task_struct *task, u64 clone_flags)
>>   {
> 

