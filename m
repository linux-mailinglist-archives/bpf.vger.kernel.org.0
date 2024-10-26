Return-Path: <bpf+bounces-43225-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DE59B154D
	for <lists+bpf@lfdr.de>; Sat, 26 Oct 2024 08:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDDE41C20CD3
	for <lists+bpf@lfdr.de>; Sat, 26 Oct 2024 06:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F031667DA;
	Sat, 26 Oct 2024 06:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="dmjf7IyI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41C633EA
	for <bpf@vger.kernel.org>; Sat, 26 Oct 2024 06:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729923480; cv=none; b=GP5x99m3B92w6Uy3buBGrDgWNS94Bq50xo5a7FjwM5WEoj26C8rXs7vtcw520G9MpYB9eUpveYi0tnbs5u5egogjJH7B2tALXtJH+8xi1G3zveZxVxwxC0Zcm22b0TBfdBekNggbDNUmF43JtgLMhSqrxBwWyBzxHwgT+E1u+gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729923480; c=relaxed/simple;
	bh=EoK1f62gBtjBgjX4bwkFJdnLKp35Hw+Pmj7qBi2Fxhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QNcLbyKRv/A++/gf30UsYTwaQ7crjnwXmHwDHk2ZgTGXrcsDaYxTwwHn0CUozxns5zH+wbYCllLqAJxU2vFo/VQLrDySteKmsBVHrnVIeJKUqxLb5DnlutC0KK3KnLo0/JmEliVKCI8dQvJEygLTgSrHBq6xNxXpv7DPWPxCwEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=dmjf7IyI; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-460ab1bc2aeso16992301cf.3
        for <bpf@vger.kernel.org>; Fri, 25 Oct 2024 23:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729923476; x=1730528276; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Iyi6UBSi4zq3aYrNXVRS94xGiByYPLF4TL8b+3uBYtI=;
        b=dmjf7IyIz4ypOx3fiKztQ2qivGOa9jRR3mVGjfIAO1WCjLBOZJDZaQDE5xzSGdqEKq
         lKrWt++UdrhNKKQ5AVvhMvps8RT+JuD2+4m30jqP3s3qhrAGzYSDSxQGKdAsxydXc1qA
         fJOhwq7JtOCwwbPDnH39ju+jdrXp+rVdkkQ0xaMxnuTX9Bw6sziUUxIJqTxrE0t6NEdG
         QMxT5BGMOQOUDETL6czJv8+OCbLJVrn3ROuH4aUXWqIMuat/waWijL1bvqOMOd9nc3k3
         8JE+DGIExNnbMp+cIloNo0Jvguk2s9KshQJRHXxkquHZX/Qz8ihHaNye17wVtggG8jh3
         rQNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729923476; x=1730528276;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iyi6UBSi4zq3aYrNXVRS94xGiByYPLF4TL8b+3uBYtI=;
        b=AaIEYcVR4taKTXSsKMeXzPkOuJLywOTYm8iB9rItY4D9fML2WmP486Z9DNOiL8VnAX
         HH1WvLL4UbULQtznRPdlglCM0qSLB+1YVvg7EgCu+5EF1S2IahC8+U+wnPw6GvBtNkxU
         TS4Jt3tbDG9w+Wlrb7nzYjKC2zrGgHVG0p4cZPbPgUSXva5RK8IVP6rzhyDiryQpbX1C
         KAnZm1fir/3+S2c5CkJiXoK4NGy7/dDofS4pMOVt/DqJJClzxkdIpSlRtsyQ4cgv9YU+
         uOnbp6sfBuF4bdw3Nn+cXh/LNqe3FwVFuxU/fvv6rHX0UGku9uS/W6v4bx3hkekbJ7wS
         +HWg==
X-Forwarded-Encrypted: i=1; AJvYcCXMRYOoZJ7dsOuaZvnIiIt4ygTjQq5EXlM1h+OSniguIxPuyLGK2ofY2JEIJ1pcntzFJxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxACvPcFZbiHmuqFW1F1JS/qeUkaaaHo4QQTsTx+zdcNgJZzhMn
	wrJeroP2xNBHzrw7CULpIDuhoyOu4GlPeuhPuH5PDj/p/kdH2Fp9CXg1rm7+AmM=
X-Google-Smtp-Source: AGHT+IEjdox85D7n602OCNoFptUocR8kOJwjA+/ZXgL3c2T/Cl9Lj7AOCxSn92Gn7C2OCvPUJ0pl2w==
X-Received: by 2002:a05:622a:2c2:b0:460:961e:9994 with SMTP id d75a77b69052e-4613c197b23mr27472871cf.40.1729923476595;
        Fri, 25 Oct 2024 23:17:56 -0700 (PDT)
Received: from ?IPV6:2601:647:4200:9750:a9b4:6cd9:ab40:6522? ([2601:647:4200:9750:a9b4:6cd9:ab40:6522])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-461323a83a8sm13441551cf.87.2024.10.25.23.17.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 23:17:55 -0700 (PDT)
Message-ID: <0053166c-6971-431c-9d09-f4893b2b69bf@bytedance.com>
Date: Fri, 25 Oct 2024 23:17:50 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: RE: [PATCH bpf 8/8] bpf, sockmap: Fix sk_msg_reset_curr
To: John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org
Cc: martin.lau@linux.dev, daniel@iogearbox.net, ast@kernel.org,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mykolal@fb.com,
 shuah@kernel.org, jakub@cloudflare.com, liujian56@huawei.com,
 cong.wang@bytedance.com
References: <20241020110345.1468595-1-zijianzhang@bytedance.com>
 <20241020110345.1468595-9-zijianzhang@bytedance.com>
 <671c788b7322c_656c20869@john.notmuch>
Content-Language: en-US
From: Zijian Zhang <zijianzhang@bytedance.com>
In-Reply-To: <671c788b7322c_656c20869@john.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/25/24 10:05 PM, John Fastabend wrote:
> zijianzhang@ wrote:
>> From: Zijian Zhang <zijianzhang@bytedance.com>
>>
>> Found in the test_txmsg_pull in test_sockmap,
>> ```
>> txmsg_cork = 512;
>> opt->iov_length = 3;
>> opt->iov_count = 1;
>> opt->rate = 512;
>> ```
>> The first sendmsg will send an sk_msg with size 3, and bpf_msg_pull_data
>> will be invoked the first time. sk_msg_reset_curr will reset the copybreak
>> from 3 to 0, then the second sendmsg will write into copybreak starting at
>> 0 which overwrites the first sendmsg. The same problem happens in push and
>> pop test. Thus, fix sk_msg_reset_curr to restore the correct copybreak.
>>
>> Fixes: bb9aefde5bba ("bpf: sockmap, updating the sg structure should also update curr")
>> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
> 
> Hi Zijian, question on below.
>  
> 
> I find push_data a bit easier to think through so allow me to walk
> through a push example.
> 
> If we setup so that curr=0 and copybreak=3 then call
> 
>   push_data(skmsg, 2, 2);
> 
> When we get to the sk_msg_reset_curr we should have a layout,
> 
>    msg->sg.data[0] = length(2) equal to original [0,2]
>    msg->sg.data[1] = length(2)
>    msg->sg.data[2] = legnth(1) equal to original [3]
> 
> The current before the reset curr will be,
> 
>   curr = 1
>   copybreak = 3
> 
>>   static void sk_msg_reset_curr(struct sk_msg *msg)
>>   {
>> -	u32 i = msg->sg.start;
>> -	u32 len = 0;
>> -
> 
> with above context i = 0
> 
>> -	do {
>> -		len += sk_msg_elem(msg, i)->length;
>> -		sk_msg_iter_var_next(i);
>> -		if (len >= msg->sg.size)
>> -			break;
>> -	} while (i != msg->sg.end);
> 
> When we exit loop,
> 
>    i = 3
>    len = 5
>    
>    msg->sg.curr = 3
>    msg->sg.copybreak = 0
> 
> So we zero the copy break and set curr = 3. The next send
> should happen over sg.curr=3? What did I miss?
> 

That's true, for common cases without corking, it should work well.
For this fix, we have to consider cork at the same time.

I still use pull here for simplicity, for example,
```
// user program
txmsg_cork = 8;
opt->iov_length = 3;
opt->iov_count = 1;
opt->rate = 3;

// eBPF program
pull_data(sk_msg, 0, 1);
```
In the first sendmsg,
pull_data will be invoked and reset msg->sg.copybreak from 3 to 0,
msg->sg.curr to 0, which is the same. However, because of the corking,
the data will not be sent out, and it is stored in the psock->cork.

In the second sendmsg,
since we are in the stage of corking, psock->cork will be reused in func
sk_msg_alloc. msg->sg.copybreak is 0 now, the second msg will overwrite
the first msg. As a result, we could not pass the data integrity test.

push + cork and pop + cork may have the same problem, with the same
reason that corking may have different sendmsgs reuse the same skmsg.

>> +	if (!msg->sg.size) {
>> +		msg->sg.curr = msg->sg.start;
>> +		msg->sg.copybreak = 0;
>> +	} else {
>> +		u32 i = msg->sg.end;
>>   
>> -	msg->sg.curr = i;
>> -	msg->sg.copybreak = 0;
>> +		sk_msg_iter_var_prev(i);
> 
> With this curr will always point to the end-1 but I'm not sure this can
> handle the case where we have done sk_msg_alloc() so we have start/end
> setup. And then on a copy fault for example we might have curr pointing
> somewhere in the middle of that. I think I will need to construct the
> example, but I believe this is originally why the 'i' is discovered
> by sg walk vs simpler end.
> 

Good point! I am not sure if corking + pull/push/pop are common cases.
I guess they are not? If we take these into account, then instead of
resetting, we may need to carefully maintain the curr and copybreak when
we shift the sgs?

>> +		msg->sg.curr = i;
>> +		msg->sg.copybreak = msg->sg.data[i].length;
> 
> This does seem more accurate then simply zero'ing out the copybreak
> which is a good thing.
> 
>> +	}
>>   }
>>   
>>   static const struct bpf_func_proto bpf_msg_cork_bytes_proto = {
>> -- 
>> 2.20.1
>>
> 
> 


