Return-Path: <bpf+bounces-37480-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BB4956296
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 06:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF24A28249F
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 04:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F03142903;
	Mon, 19 Aug 2024 04:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Q2jzsJRy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D7613D62B
	for <bpf@vger.kernel.org>; Mon, 19 Aug 2024 04:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724041563; cv=none; b=rAyx1D34PkVM5qG+/AC1suvDMj6r8DPa/Bqv1g8pZ58+MtLsDNF93SQGcOuXXbb5QvNmbOEBG9yHFz2496n9KrfFEdGY7Bc7tGdH7K/6V9Vfpu8xR7+HTqcxgtFIcLc0iWTYiS1Ds/r/NqJRd9PinOyXVTnZeYQaL9Xv6XesGy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724041563; c=relaxed/simple;
	bh=+v4g0UjEWkLd7ZS9HwEmXjiwF0M6kB/Ghn8LHxLtirQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LS782DfsxIQkwFy7plnJsxz175Rgrd1HdiEDSBWA+gZx7AcReUeT9x6zyoshrB1FSrt8dJxLSGwe993tolNmmQV21yTKBPnFI+Pk+kcm7oU6eoXtpQexO6TL7ivqZeTwHTywZOkTniXFAbICQTCwYwmAmFBd3jpg8aAIOl/RHBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Q2jzsJRy; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5da686531d3so2778005eaf.3
        for <bpf@vger.kernel.org>; Sun, 18 Aug 2024 21:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724041560; x=1724646360; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SmSr10lXHgh748HKWduE5k/LDglQBiHBeWV9WGZodNo=;
        b=Q2jzsJRybfuxCtA8rodmrn/oObXViFLTqbGZj46YOdewvEbZeh0MTzxn51PodYtNJW
         xqZw3kDJsxFrSWLRSWYSvtmIUaLEoUW1NqJszKE50tTjlyu7NysQ4KRmjc62nMMXfIr/
         RQ9HM+692ZqfSLVGh3p1LfL1RXUfpAdnwfIuCgxpn1+jzG5P7TX4cTyR2Yc2dWs+WOM/
         aCPuA7hzbakR1FgeOY5jwlFc+yuxEAM4iHfiQRbB4eDdariIWv6NDNWwdHz5/RBs0TwT
         ElNF0VBJi4NioRnlqF4xzcEHio5S7rBiHaGWxsY6i8bEE6ekhqWvTavMwfJFfnJwdk1U
         aKfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724041560; x=1724646360;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SmSr10lXHgh748HKWduE5k/LDglQBiHBeWV9WGZodNo=;
        b=B1XW9Zffn59KSSGBTJnwMovCd2aGCUSJqtpIFrgE00OCZFgyTIR24AXmE+b6NR5zBr
         kCZhb7VcbIvW+nkjNogLg2TEwNZO5PbDXqMK0xWEIhlTcso8RdPn2zRFWCUDUNBTlBN4
         MWFsfazNOvcx+gFS5fd/ofMaQNMBgKKt28ms1zOU+K901ZLRsT4QXTJS0aIx06bpF/pf
         oKm3Oik/FQfdhZzdzWwb6CxoPmI+k6q1+Qt49Hj73vHX4nqcATRIoJ052YpW8BsJ5ccW
         NBdEm/X3wfQhotje37CFEJbNDHSpxXzrcYWpyAr+YfgawNgtF6wVWKdi+1o6+AAX6FrA
         Q0yQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4trhm1SwsRJ3GRulFE0UUSMvaCVN+1Zfoz+a+1f7lwfJgDGM2V2r4xQfLbnRT7ZXBHT/7LUwNkWLWWjcOQ7fIxyG3
X-Gm-Message-State: AOJu0Ywa5xkFjw2A7bdn22i/DBBm8mB4HbNM8HOnUf271Yhx01YsY9XN
	djQiITkRJ5cOJNEmWQjO+17ip5qJRC4bwH2rFj98VHT/xQUOszX/yn5CA2tcCt4=
X-Google-Smtp-Source: AGHT+IFKtrY7/fANJZ2uglCj/MVefnIjjROeE8YWIB38zjN915wjQ7cn3peazdZfU+eY9yL35G2vCA==
X-Received: by 2002:a05:6358:478e:b0:1aa:c71e:2b2c with SMTP id e5c5f4694b2df-1b3931910edmr1475923955d.11.1724041560335;
        Sun, 18 Aug 2024 21:26:00 -0700 (PDT)
Received: from [10.68.122.106] ([203.208.167.148])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127ae08027sm5875279b3a.66.2024.08.18.21.25.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Aug 2024 21:25:59 -0700 (PDT)
Message-ID: <b8f8c4a4-b272-454c-b2c7-59417461713b@bytedance.com>
Date: Mon, 19 Aug 2024 12:25:51 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH] bpf: cg_skb add get classid helper
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: daniel@iogearbox.net, john.fastabend@gmail.com, ast@kernel.org,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20240814095038.64523-1-zhoufeng.zf@bytedance.com>
 <be4d3e00-de84-420b-9979-277ecc9df6ce@linux.dev>
From: Feng Zhou <zhoufeng.zf@bytedance.com>
In-Reply-To: <be4d3e00-de84-420b-9979-277ecc9df6ce@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2024/8/16 09:06, Martin KaFai Lau 写道:
> On 8/14/24 2:50 AM, Feng zhou wrote:
>> From: Feng Zhou <zhoufeng.zf@bytedance.com>
>>
>> At cg_skb hook point, can get classid for v1 or v2, allowing
>> users to do more functions such as acl.
>>
>> Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
>> ---
>>   net/core/filter.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/net/core/filter.c b/net/core/filter.c
>> index 78a6f746ea0b..d69ba589882f 100644
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
>> @@ -8111,6 +8111,12 @@ cg_skb_func_proto(enum bpf_func_id func_id, 
>> const struct bpf_prog *prog)
>>           return &bpf_get_listener_sock_proto;
>>       case BPF_FUNC_skb_ecn_set_ce:
>>           return &bpf_skb_ecn_set_ce_proto;
>> +    case BPF_FUNC_get_cgroup_classid:
>> +        return &bpf_get_cgroup_classid_proto;
>> +#endif
>> +#ifdef CONFIG_CGROUP_NET_CLASSID
>> +    case BPF_FUNC_skb_cgroup_classid:
>> +        return &bpf_skb_cgroup_classid_proto;
> 
> With this bpf_skb_cgroup_classid_proto, is the above 
> bpf_get_cgroup_classid_proto necessary?
> The cg_skb hook must have a skb->sk.

Yes, just add bpf_skb_cgroup_classid_proto.

> 
> Please add a selftest and tag the subject with bpf-next.
> 

Will do, thanks.

> pw-bot: cr
> 
>>   #endif
>>       default:
>>           return sk_filter_func_proto(func_id, prog);
> 


