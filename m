Return-Path: <bpf+bounces-51129-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0036A308C9
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 11:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EB653A2EC2
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 10:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D09D1F63D6;
	Tue, 11 Feb 2025 10:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="PK2WIyYS"
X-Original-To: bpf@vger.kernel.org
Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com [203.205.221.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3BD1F4E25;
	Tue, 11 Feb 2025 10:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739270375; cv=none; b=Akc7BX0vUTm0SGznjB68Nq6KHWwJFvnGgEIo9TolhpeD/5GoPkNEh+gfUjWnFoSMwrQPOufk7KvPqHZGE7+eFJQZDMX18+7tPrGbDKLGlOEGkyfdig2Od6qSfW0M+qWt5zTeHnMgGqcjE7JHdv+CNt3UEy3tIydR8czpKgK3SSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739270375; c=relaxed/simple;
	bh=K2l7gaEVKXXaf+0S0QRve1hkeJDi8Zssq35IxcvevLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=um2oxeTeh8DbQnKS3tbqqm+c9kFVh4IUflHjpBLmb6P8MUKJfVYCqF8rCv/XHTdhXpOrAGf8BgnRvnvM/KGqS7XC2G8DKYutnirDkCqUy4PuKxDODIJaMtS+dAvjHAZgCdv+smHaaEGsxja2cB3PV5SMRBh9Vsxa3otMayPzQ24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=PK2WIyYS; arc=none smtp.client-ip=203.205.221.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1739270069;
	bh=7x7wcr3iaglunvqzItfa9xM6EfAD5tU2/52gb/XsUl4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=PK2WIyYSjRvqiZqsuFPfYSAXyWvifHyS9nHFttE/By/GuuuiFgPvqsVOnuaFLLk40
	 rQ57im6RRK/BUpAF6AEabmKSY4cJtNjBm9csYTA0cC0K9LYepgcRzcWQtMeZNtk3RX
	 ruorDZHd+NQesvyLKTWLUnBTjM/H8F8unp91eToA=
Received: from [10.56.52.9] ([39.156.73.10])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 898B7669; Tue, 11 Feb 2025 18:34:24 +0800
X-QQ-mid: xmsmtpt1739270064t9rke3kwq
Message-ID: <tencent_152195E35781D102C443834B219FACA04B07@qq.com>
X-QQ-XMAILINFO: NkHKfw09D6j8fi55IeO+BWc+hsD21Z7qh8hYP1AXm69ZPOS9OZxNp0e1H5gDiw
	 0sNCJA+airnOktaNeop3N+gbTiFxCjYvAn/i3tne6B8lrkzB6ih7SXv0lgM1POJ3yIj2dLYbC95T
	 EfAgP/F7dqcd3nXwdw8Jm2tpJvHio/qxoGsnKfccW7mWUBrIluAOokZdjauQHTUFrawf5vP7r6QX
	 yjJ4JoKZW1QhE5SbcHekkNqOxg7tMwxTkj//yTNfgmincP+zQHqo5DsmMcnxTwwnnC6byTgdM++n
	 KxJct2AtK1mHtj6QHRCx82rzRA91VpegUcqVvz+e5UNJZh1xmg3tKXBpnciSM2Ucs5eTBQOBUhyu
	 1bo+mpa+ARufhZ1PkMAoAmedPemBKdlhvAHrXlkWi4LL67KYyesDC/+9KLAFfA5mDKoRDkRnQUKp
	 6HMb3YPjMKK1WBCN49w+RLAZMVubJpYdY2viw0uK+jykAELTX5CAUnI73WY6YKU2xNoZlD2pi1Ky
	 Zo4egoLSkIv5t6KpQYaNEsVbi69QWJwY9cKz5Aa1Msk9C4+ag5XQk9/1zL8OiOlfClycPAWtS7Ik
	 BCFs+jrdrDtZcV4otOVCydB96EIZpG934XFPUJNkUtXjEHJsrK6VdsCI1wMI2b6SaziGaMwrrCFv
	 YSHDR2gNkTh84SaFHMBLTHn7v5md2mRNa7ltCQ8hp2KusN8xR5Vf+y2LeLsr1/PHtka4GA5Quuwr
	 6/vAHSCy50fV6EipFjx53IQe7ipm4sLdJVSPVBdExUfRcT9qjBuR0wwghJ6XlatUeJalkNhWEEkN
	 UrTuRt/NZ7gV7upp+LlkpQOh6FrvkM2NxInDGAw7N21t3fhgYAAYt1OwhoAN2D9dv8E4xaU4oEiW
	 rD8i2zEwzP2nPeig2mA0Qouaqh1Pix51mwJ/sNs3kUVqBR2LBXPqVBZIs5/TERGIxaqxL6tl8wxS
	 MO9DUFtFV7Xvkb8q829jkOJaHceZhj
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-OQ-MSGID: <7cc003ca-cc4f-4ff5-b908-825fcb3332de@foxmail.com>
Date: Tue, 11 Feb 2025 18:34:24 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpftool: Check map name length when map create
To: Quentin Monnet <qmo@kernel.org>, ast@kernel.org, daniel@iogearbox.net
Cc: rongtao@cestc.cn, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>,
 "open list:BPF [TOOLING] (bpftool)" <bpf@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <tencent_1C4444032C2188ACD04B4995B0D78F510607@qq.com>
 <3da61b9b-fa44-4a45-bccb-40a23ef997ce@kernel.org>
Content-Language: en-US
From: Rong Tao <rtoax@foxmail.com>
In-Reply-To: <3da61b9b-fa44-4a45-bccb-40a23ef997ce@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2/11/25 18:20, Quentin Monnet wrote:
> 2025-02-11 16:45 UTC+0800 ~ Rong Tao <rtoax@foxmail.com>
>> From: Rong Tao <rongtao@cestc.cn>
>>
>> The size of struct bpf_map::name is BPF_OBJ_NAME_LEN (16).
>>
>> bpf(2) {
>>    map_create() {
>>      bpf_obj_name_cpy(map->name, attr->map_name, sizeof(attr->map_name));
>>    }
>> }
>>
>> When specifying a map name using bpftool map create name, no error is
>> reported if the name length is greater than 15.
>>
>>      $ sudo bpftool map create /sys/fs/bpf/12345678901234567890 \
>>          type array key 4 value 4 entries 5 name 12345678901234567890
>>
>> Users will think that 12345678901234567890 is legal, but this name cannot
>> be used to index a map.
>>
>>      $ sudo bpftool map show name 12345678901234567890
>>      Error: can't parse name
>>
>>      $ sudo bpftool map show
>>      ...
>>      1249: array  name 123456789012345  flags 0x0
>>      	key 4B  value 4B  max_entries 5  memlock 304B
>>
>>      $ sudo bpftool map show name 123456789012345
>>      1249: array  name 123456789012345  flags 0x0
>>      	key 4B  value 4B  max_entries 5  memlock 304B
>>
>> The map name provided in the command line is truncated, but no error is
>> reported. This submission checks the length of the map name.
>>
>> Signed-off-by: Rong Tao <rongtao@cestc.cn>
>> ---
>>   tools/bpf/bpftool/map.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
>> index ed4a9bd82931..fa00f7865065 100644
>> --- a/tools/bpf/bpftool/map.c
>> +++ b/tools/bpf/bpftool/map.c
>> @@ -1330,6 +1330,12 @@ static int do_create(int argc, char **argv)
>>   		goto exit;
>>   	}
>>   
>> +	if (strlen(map_name) > BPF_OBJ_NAME_LEN - 1) {
>> +		p_err("The map name is too long, should be less than %d\n",
>
> Nit: I'd drop "The" (and the capital letter) for consistency with other
> messages in bpftool; and I'd replace "less than ..." with "no longer
> than %d characters\n" to make it explicit and avoid confusion between
> "strictly less" and "less or equal".

Thanks, i'll submit another patch.

Rong Tao.

>
>> +		      BPF_OBJ_NAME_LEN - 1);
>> +		goto exit;
>> +	}
>> +
>>   	set_max_rlimit();
>>   
>>   	fd = bpf_map_create(map_type, map_name, key_size, value_size, max_entries, &attr);
>
> There's no need to defer the check until after we've parsed all
> arguments. Can you move it to the location where we retrieve the name,
> please?:
>
> 		[...]
> 		} else if (is_prefix(*argv, "name")) {
> 			NEXT_ARG();
> 			map_name = GET_ARG();
> 		} else ...
>
> pw-bot: cr
>
> Apart from these, it's a good idea to fix it, thank you!
> Quentin


