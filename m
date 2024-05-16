Return-Path: <bpf+bounces-29831-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AAC8C7095
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 05:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 626B9B2288F
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 03:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB994C94;
	Thu, 16 May 2024 03:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="L5pc85aC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0071A2C33
	for <bpf@vger.kernel.org>; Thu, 16 May 2024 03:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715829358; cv=none; b=mxxcvsCPH5XjU03GRz77APIECM1aqEXFDmRUbZ1dfSi46EobnCxpGYOmkb1K/xY4fXeMl4OESS+tl5DifUzZlcMF2ZZAopV6HMT71IZF5NzJHWGw+XUzIrOcK5+rqQdp92pwgDr6Y1GOiHrq2y/iTxvInCynutRVhf8aO/ZxHjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715829358; c=relaxed/simple;
	bh=Ck2Nw3i0eBNHAfwrtTAecQi2+lDsbfEH+mb9QGsN5TI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fsFM5d47yCBl6vjT55t8OcjNQQWgu6K8kxmigd84kAE8eUheCJiLb2z7wqwkPC3lwD+ZJlSZ1+4rv/xRF745LAGTT94v9s0mY9ZhoZF5Au7ImR6OMJ/qcP11fZAq3xGpw5mX2DpLw5JJmWcmAMDZc1QaP5qh7uh22h3q1smExy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=L5pc85aC; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5b27e8ad4b6so3813022eaf.0
        for <bpf@vger.kernel.org>; Wed, 15 May 2024 20:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1715829354; x=1716434154; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mc6P0QBJk/o6Xns5zeCFfeIHIpvdDG/dknYVsSKeQ3I=;
        b=L5pc85aCFoCYUWOGmjg2PoT8v3cR3//lNLRfmu1r1YAB/R7QYkpW2HNChKGiddwKXK
         uv+K/3sRokLlpmdjfCJFrYB6Hc/JhqUD6a6PhUu10YU/GkpJhFOAY2HR0sD2e04SCGhX
         Zj/mZDxqKzTpmmytLRiSxPs4wXNn1R8AbTFw1GnXjMG1mEhqaplXwQSkeOkO7bcdq79A
         i4rHdARqmMaFNH1R0ARHVnSnaAnQ9mV3zHAKAORkqgz8k1mBzZ3o/8hT+lBXcJPjszG5
         in8TKjDy46Y7w+O23/CPwiAbhX3QHykFE+dcIJ3Kwj1RQYzLDr32ZiNHn7Ctt4XQx6kX
         w5Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715829354; x=1716434154;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mc6P0QBJk/o6Xns5zeCFfeIHIpvdDG/dknYVsSKeQ3I=;
        b=Je5bvp21BmppQsnPtrA/0TSWG43vb1dWTbAH4vJrlIKPSWrwvwHSm5DQIJlLiYv+4G
         RVE8GqwWQPKwdyBdyljzNG8/I6wn4FlpIi3VuQTkD0BFYLNabbl/Fgm6rRzh8tTV6GXm
         JYlyuAzxPoG5tE2Ans52kwqbzaEJsHVB8oImgAvcwZqV33id4CgX5p6F5akqMeRCX3Jq
         vseuvD67Mwx25x8fL2fguhoqtmi6cxgg6+FexUG0rJ1AHKHgJTN2a5vLtBdecfmQbnhz
         dB/ij1wMnfTGPE5XlrJcaFNvVboM/oDvKRIZWJdM7HWFDbhTKP5XvmlpXnQE4V58+ZY8
         GbLg==
X-Forwarded-Encrypted: i=1; AJvYcCUqm8Xo6Dr9Uf13ZbHcncWjUzyFfi6tggDSw/vIeNycPJamuiKdrhO9kxdhTKNMKIoUcshEGvCTOBA4SxL8saB1p1+V
X-Gm-Message-State: AOJu0YybrKnaE8hsvSVmOPrppk+0FuYAs/PvSX6bytI5J3V7e71Qg1cw
	+tBvHe+EzK+N8zCR8LF1Ime2HStolof5Y3lhpn17LJtitLiePaHKpgYuiK0xXbo=
X-Google-Smtp-Source: AGHT+IF7Xp+lktXA8GPkGnB7Vs0YYEJLSeV+njJLOz6ktfH2aQw+bMeP//pkZK/RozRmiuZtbeukjg==
X-Received: by 2002:a05:6870:d153:b0:244:ba40:8b29 with SMTP id 586e51a60fabf-244ba409c58mr16014187fac.43.1715829353960;
        Wed, 15 May 2024 20:15:53 -0700 (PDT)
Received: from [10.84.154.38] ([203.208.167.149])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-658764fda40sm655658a12.5.2024.05.15.20.15.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 20:15:53 -0700 (PDT)
Message-ID: <1803b7c0-bc56-46d6-835f-f3802b8b7e00@bytedance.com>
Date: Thu, 16 May 2024 11:15:43 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH bpf-next] bpf: tcp: Improve bpf write tcp opt
 performance
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: edumazet@google.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 laoar.shao@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20240515081901.91058-1-zhoufeng.zf@bytedance.com>
 <87seyjwgme.fsf@cloudflare.com>
From: Feng Zhou <zhoufeng.zf@bytedance.com>
In-Reply-To: <87seyjwgme.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2024/5/15 17:48, Jakub Sitnicki 写道:
> On Wed, May 15, 2024 at 04:19 PM +08, Feng zhou wrote:
>> From: Feng Zhou <zhoufeng.zf@bytedance.com>
>>
>> Set the full package write tcp option, the test found that the loss
>> will be 20%. If a package wants to write tcp option, it will trigger
>> bpf prog three times, and call "tcp_send_mss" calculate mss_cache,
>> call "tcp_established_options" to reserve tcp opt len, call
>> "bpf_skops_write_hdr_opt" to write tcp opt, but "tcp_send_mss" before
>> TSO. Through bpftrace tracking, it was found that during the pressure
>> test, "tcp_send_mss" call frequency was 90w/s. Considering that opt
>> len does not change often, consider caching opt len for optimization.
> 
> You could also make your BPF sock_ops program cache the value and return
> the cached value when called for BPF_SOCK_OPS_HDR_OPT_LEN_CB.
> 
> If that is in your opinion prohibitevely expensive then it would be good
> to see a sample program and CPU cycle measurements (bpftool prog profile).
> 

I'm not referring to the overhead introduced by the time-consuming
operation of bpf prog. I have tested that bpf prog does nothing and
returns directly, and the loss is still 20%. During the pressure test
process, "tcp_send_mss" and "__tcp_transmit_skb" the call frequency per
second

@[
     bpf_skops_hdr_opt_len.isra.46+1
     tcp_established_options+730
     tcp_current_mss+81
     tcp_send_mss+23
     tcp_sendmsg_locked+285
     tcp_sendmsg+58
     sock_sendmsg+48
     sock_write_iter+151
     new_sync_write+296
     vfs_write+165
     ksys_write+89
     do_syscall_64+89
     entry_SYSCALL_64_after_hwframe+68
]: 3671671

@[
     bpf_skops_write_hdr_opt.isra.47+1
     __tcp_transmit_skb+761
     tcp_write_xmit+822
     __tcp_push_pending_frames+52
     tcp_close+813
     inet_release+60
     __sock_release+55
     sock_close+17
     __fput+179
     task_work_run+112
     exit_to_usermode_loop+245
     do_syscall_64+456
     entry_SYSCALL_64_after_hwframe+68
]: 36125

"tcp_send_mss" before TSO, without packet aggregation, and
"__tcp_transmit_skb" after TSO, the gap between the two is
100 times.

>>
>> Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
>> ---
>>   include/linux/tcp.h            |  3 +++
>>   include/uapi/linux/bpf.h       |  8 +++++++-
>>   net/ipv4/tcp_output.c          | 12 +++++++++++-
>>   tools/include/uapi/linux/bpf.h |  8 +++++++-
>>   4 files changed, 28 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
>> index 6a5e08b937b3..74437fcf94a2 100644
>> --- a/include/linux/tcp.h
>> +++ b/include/linux/tcp.h
>> @@ -455,6 +455,9 @@ struct tcp_sock {
>>   					  * to recur itself by calling
>>   					  * bpf_setsockopt(TCP_CONGESTION, "itself").
>>   					  */
>> +	u8	bpf_opt_len;		/* save tcp opt len implementation
>> +					 * BPF_SOCK_OPS_HDR_OPT_LEN_CB fast path
>> +					 */
>>   #define BPF_SOCK_OPS_TEST_FLAG(TP, ARG) (TP->bpf_sock_ops_cb_flags & ARG)
>>   #else
>>   #define BPF_SOCK_OPS_TEST_FLAG(TP, ARG) 0
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 90706a47f6ff..f2092de1f432 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -6892,8 +6892,14 @@ enum {
>>   	 * options first before the BPF program does.
>>   	 */
>>   	BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG = (1<<6),
>> +	/* Fast path to reserve space in a skb under
>> +	 * sock_ops->op == BPF_SOCK_OPS_HDR_OPT_LEN_CB.
>> +	 * opt length doesn't change often, so it can save in the tcp_sock. And
>> +	 * set BPF_SOCK_OPS_HDR_OPT_LEN_CACHE_CB_FLAG to no bpf call.
>> +	 */
>> +	BPF_SOCK_OPS_HDR_OPT_LEN_CACHE_CB_FLAG = (1<<7),
>>   /* Mask of all currently supported cb flags */
>> -	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0x7F,
>> +	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0xFF,
>>   };
>>   
>>   /* List of known BPF sock_ops operators.
>> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
>> index ea7ad7d99245..0e7480a58012 100644
>> --- a/net/ipv4/tcp_output.c
>> +++ b/net/ipv4/tcp_output.c
>> @@ -488,12 +488,21 @@ static void bpf_skops_hdr_opt_len(struct sock *sk, struct sk_buff *skb,
>>   {
>>   	struct bpf_sock_ops_kern sock_ops;
>>   	int err;
>> +	struct tcp_sock *th = (struct tcp_sock *)sk;
>>   
>> -	if (likely(!BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk),
>> +	if (likely(!BPF_SOCK_OPS_TEST_FLAG(th,
>>   					   BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG)) ||
>>   	    !*remaining)
>>   		return;
>>   
>> +	if (likely(BPF_SOCK_OPS_TEST_FLAG(th,
>> +					  BPF_SOCK_OPS_HDR_OPT_LEN_CACHE_CB_FLAG)) &&
>> +	    th->bpf_opt_len) {
>> +		*remaining -= th->bpf_opt_len;
> 
> What if *remaining value shrinks from one call to the next?
> 
> BPF sock_ops program can't react to change. Feels like there should be a
> safety check to prevent an underflow.
> 

Thanks for the reminder, I'll add a judgment.

>> +		opts->bpf_opt_len = th->bpf_opt_len;
>> +		return;
>> +	}
>> +
>>   	/* *remaining has already been aligned to 4 bytes, so *remaining >= 4 */
>>   
>>   	/* init sock_ops */
>> @@ -538,6 +547,7 @@ static void bpf_skops_hdr_opt_len(struct sock *sk, struct sk_buff *skb,
>>   	opts->bpf_opt_len = *remaining - sock_ops.remaining_opt_len;
>>   	/* round up to 4 bytes */
>>   	opts->bpf_opt_len = (opts->bpf_opt_len + 3) & ~3;
>> +	th->bpf_opt_len = opts->bpf_opt_len;
>>   
>>   	*remaining -= opts->bpf_opt_len;
>>   }
>> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
>> index 90706a47f6ff..f2092de1f432 100644
>> --- a/tools/include/uapi/linux/bpf.h
>> +++ b/tools/include/uapi/linux/bpf.h
>> @@ -6892,8 +6892,14 @@ enum {
>>   	 * options first before the BPF program does.
>>   	 */
>>   	BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG = (1<<6),
>> +	/* Fast path to reserve space in a skb under
>> +	 * sock_ops->op == BPF_SOCK_OPS_HDR_OPT_LEN_CB.
>> +	 * opt length doesn't change often, so it can save in the tcp_sock. And
>> +	 * set BPF_SOCK_OPS_HDR_OPT_LEN_CACHE_CB_FLAG to no bpf call.
>> +	 */
>> +	BPF_SOCK_OPS_HDR_OPT_LEN_CACHE_CB_FLAG = (1<<7),
> 
> Have you considered a bpf_reserve_hdr_opt() flag instead?
> 
> An example or test coverage would to show this API extension in action
> would help.
> 

bpf_reserve_hdr_opt () flag can't finish this. I want to optimize
that bpf prog will not be triggered frequently before TSO. Provide
a way for users to not trigger bpf prog when opt len is unchanged.
Then when writing opt, if len changes, clear the flag, and then
change opt len in the next package.

In the next version, I will add test cases.

>>   /* Mask of all currently supported cb flags */
>> -	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0x7F,
>> +	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0xFF,
>>   };
>>   
>>   /* List of known BPF sock_ops operators.


