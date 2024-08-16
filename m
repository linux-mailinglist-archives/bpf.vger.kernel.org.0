Return-Path: <bpf+bounces-37352-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A2A9542A7
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 09:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2523D1C22402
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 07:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D97127E37;
	Fri, 16 Aug 2024 07:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7Ihmuu5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00914F9DF
	for <bpf@vger.kernel.org>; Fri, 16 Aug 2024 07:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723792999; cv=none; b=qMhRzDFuwOvIj12YDZlaeRupCYRGUt2N+im++crNuhe40NOaQHhQJW5OBKukdiZP3Mo9DNEJRdz20aSA30c2f4euTM44MAIuxilZuzFv6so57qJK1M2fl5HKIIvZtxZsGTtwScWqBD2EDfpYZM6LwKrQ5Mririf8G+mktR3FruI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723792999; c=relaxed/simple;
	bh=6fALldSFEf+henFxU9FOHk41UdC7K/1AwF+S2j82ZaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RqBjl4rUsSQP8W1KYmIdSnyDwRlR5MHvNV8AXtmaYSnWHDIjTj5MT4sPKIVl7dJ3G/qBTBUJ+tYcUE3YthRLbgPly7E8o4TRKGwuy6JYRPZ3gGsHAPgxJs8DjOZLkkXvZ/jkcSaFfRoKGjoqAVtBeegtOXjOW6p36GMbZeKVlBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7Ihmuu5; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6a4778dad26so17303327b3.1
        for <bpf@vger.kernel.org>; Fri, 16 Aug 2024 00:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723792997; x=1724397797; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QEUac+ZCDdD36A/qwEoioM9Bd7bdtGonTnsO6JeqA7g=;
        b=B7Ihmuu5I1V9He/8s7cZVXWF5hkxbilZyUL7qwpIJNbC8m+k+nTwYcmIrbLJ0aJQXU
         QQFQbJp3eZK6a1ID954EohWKC2jrbTlHWpfyKLF89CLk7YGwBeeYnUSC/Wa15uR2yQTa
         n9pWM6g0SVoU4YCAxuPsR1XaPC0MPPlv5c015X2M3gqOk8cZNq0PmNA0/UEb+SegM3Q6
         4At0s2GgorscVpzYXIsaUuJkH676p89th6ekTWXW3CEXempndvJrxE3KEKxjowrT1AP9
         8h0ktGfXgx6y/5ylRIzoMaZAiYlcSmLpHldxc569R9QlJim48uvZUISt84WueQB/SAL4
         ixeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723792997; x=1724397797;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QEUac+ZCDdD36A/qwEoioM9Bd7bdtGonTnsO6JeqA7g=;
        b=TR6n43h6saAu3DF5t1dtcWALCtlVZ4QGpkKx9eZqu8VbPJK1TH6nFEpz/9I9TkQ2Ln
         0XXKmqY8OORCltJL0oocW8bYRdyVhLbacbI4RBUKTqBOgW1sQBUGYN7mAExY0IYbmOh0
         BikAqbN8FZ+VtDniywi+ivnyQ5HXKGaQfZ/CUYMWpEkMQrFabDauVm7pDPGl8KGH1gwD
         iFEbSt2fXCs/S5HsO2c+Ih5yxHCibIuF1FSBJExwrBMoSyr3d8SX21FJldqx9lPUJI8j
         4ogxGXmmea7iJbgck9EVrlY2Y/eBEYgA1aSJcibfSAeuDdY6x1MSYTVARkczjaVrk5+Q
         zqUA==
X-Gm-Message-State: AOJu0YxSSIfd4dhDopA24KLemW0eAMhSh9kgldU6EIjWhVDrWGf7l6Zk
	/C5OFRuFhxhRu9UHF2W72/kjRoV7GNQK6nnqSlP/IeJmZUv3i+FP
X-Google-Smtp-Source: AGHT+IHPa+L471hCwoS1ESF2NeNNe9FWk5qNWgFnNXXCZlsm/BwxQuUcjH3VzIIcY5pQNqdTTtHX8A==
X-Received: by 2002:a05:690c:6a0e:b0:6b0:45d:bf7a with SMTP id 00721157ae682-6b1bb09cec1mr20505587b3.18.1723792996743;
        Fri, 16 Aug 2024 00:23:16 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:14c6:ac96:2979:70a5? ([2600:1700:6cf8:1240:14c6:ac96:2979:70a5])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6af9ce76a44sm5325317b3.98.2024.08.16.00.23.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 00:23:16 -0700 (PDT)
Message-ID: <6ddc8fda-3fcd-4e5f-8a0c-475323b08de9@gmail.com>
Date: Fri, 16 Aug 2024 00:23:14 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bpf-next v5 1/2] bpf: Add bpf_copy_from_user_str kfunc
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Jordan Rome <linux@jordanrome.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>
References: <20240815112733.4100387-1-linux@jordanrome.com>
 <CAEf4Bzb+W2PyvUuHixc+mTTt73zTCYBBpBwtoYmTtv++rxd4+g@mail.gmail.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAEf4Bzb+W2PyvUuHixc+mTTt73zTCYBBpBwtoYmTtv++rxd4+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/15/24 15:38, Andrii Nakryiko wrote:
> On Thu, Aug 15, 2024 at 4:28 AM Jordan Rome <linux@jordanrome.com> wrote:
>>
>> This adds a kfunc wrapper around strncpy_from_user,
>> which can be called from sleepable BPF programs.
>>
>> This matches the non-sleepable 'bpf_probe_read_user_str'
>> helper except it includes an additional 'flags'
>> param, which allows consumers to clear the entire
>> destination buffer on success.
>>
>> Signed-off-by: Jordan Rome <linux@jordanrome.com>
>> ---
>>   include/uapi/linux/bpf.h       |  8 +++++++
>>   kernel/bpf/helpers.c           | 41 ++++++++++++++++++++++++++++++++++
>>   tools/include/uapi/linux/bpf.h |  8 +++++++
>>   3 files changed, 57 insertions(+)
>>
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index e05b39e39c3f..e207175981be 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -7513,4 +7513,12 @@ struct bpf_iter_num {
>>          __u64 __opaque[1];
>>   } __attribute__((aligned(8)));
>>
>> +/*
>> + * Flags to control bpf_copy_from_user_str() behaviour.
>> + *     - BPF_ZERO_BUFFER: Memset 0 the tail of the destination buffer on success
>> + */
>> +enum {
>> +       BPF_ZERO_BUFFER = (1ULL << 0)
> 
> We call all flags BPF_F_<something>, so let's stay consistent.
> 
> And just for a bit of bikeshedding, "zero buffer" isn't immediately
> clear and it would be nice to have a clearer verb in there. I don't
> have a perfect name, but something like BPF_F_PAD_ZEROS or something
> with "pad" maybe?
> 
> Also, should we keep behavior a bit more consistent and say that on
> failure this flag will also ensure that buffer is cleared?
> 
>> +};
>> +
>>   #endif /* _UAPI__LINUX_BPF_H__ */
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index d02ae323996b..fe4348679d38 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -2939,6 +2939,46 @@ __bpf_kfunc void bpf_iter_bits_destroy(struct bpf_iter_bits *it)
>>          bpf_mem_free(&bpf_global_ma, kit->bits);
>>   }
>>
>> +/**
>> + * bpf_copy_from_user_str() - Copy a string from an unsafe user address
>> + * @dst:             Destination address, in kernel space.  This buffer must be at
>> + *                   least @dst__szk bytes long.
>> + * @dst__szk:        Maximum number of bytes to copy, including the trailing NUL.
>> + * @unsafe_ptr__ign: Source address, in user space.
>> + * @flags:           The only supported flag is BPF_ZERO_BUFFER
>> + *
>> + * Copies a NUL-terminated string from userspace to BPF space. If user string is
>> + * too long this will still ensure zero termination in the dst buffer unless
>> + * buffer size is 0.
>> + *
>> + * If BPF_ZERO_BUFFER flag is set, memset the tail of @dst to 0 on success.
>> + */
>> +__bpf_kfunc int bpf_copy_from_user_str(void *dst, u32 dst__szk, const void __user *unsafe_ptr__ign, u64 flags)
>> +{
>> +       int ret;
>> +       int count;
>> +
> 
> validate that flags doesn't have any unknown flags
> 
> if (unlikely(flags & ~BPF_F_ZERO_BUFFER))
>      return -EINVAL;
> 
>> +       if (unlikely(!dst__szk))
>> +               return 0;
>> +
>> +       count = dst__szk - 1;
>> +       if (unlikely(!count)) {
>> +               ((char *)dst)[0] = '\0';
>> +               return 1;
>> +       }
> 
> Do we need to special-case this unlikely scenario? Especially that
> it's unlikely, why write code for it and pay a tiny price for an extra
> check?
> 
>> +
>> +       ret = strncpy_from_user(dst, unsafe_ptr__ign, count);
>> +       if (ret >= 0) {
>> +               if (flags & BPF_ZERO_BUFFER)
>> +                       memset((char *)dst + ret, 0, dst__szk - ret);
>> +               else
>> +                       ((char *)dst)[ret] = '\0';
>> +               ret++;
> 
> so if string is truncated, ret == count, no? And dst[ret] will go
> beyond the buffer?

Since count = dst__szk - 1, it is not going beyond the buffer.

> 
> we need more tests to validate all those various conditions
> 
> 
> I'd also rewrite this a bit, so it's more linear:
> 
> 
> ret = strncpy(...);
> if (ret < 0)
>      return ret;
> 
> ((char *)dst)[count - 1] = '\0';
> 
> if (flags & BPF_F_ZERO_BUF)
>        memset(...);
> 
> return ret < count ? ret + 1 : count;
> 
> 
> or something along those lines
> 
> 
> pw-bot: cr
> 
> 
>> +       }
>> +
>> +       return ret;
>> +}
>> +
>>   __bpf_kfunc_end_defs();
>>
>>   BTF_KFUNCS_START(generic_btf_ids)
>> @@ -3024,6 +3064,7 @@ BTF_ID_FLAGS(func, bpf_preempt_enable)
>>   BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_NEW)
>>   BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)
>>   BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
>> +BTF_ID_FLAGS(func, bpf_copy_from_user_str, KF_SLEEPABLE)
>>   BTF_KFUNCS_END(common_btf_ids)
>>
>>   static const struct btf_kfunc_id_set common_kfunc_set = {
>> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
>> index e05b39e39c3f..15c2c3431e0f 100644
>> --- a/tools/include/uapi/linux/bpf.h
>> +++ b/tools/include/uapi/linux/bpf.h
>> @@ -7513,4 +7513,12 @@ struct bpf_iter_num {
>>          __u64 __opaque[1];
>>   } __attribute__((aligned(8)));
>>
>> +/*
>> + * Flags to control bpf_copy_from_user_str() behaviour.
>> + *     - BPF_ZERO_BUFFER: Memset 0 the entire destination buffer on success
>> + */
>> +enum {
>> +       BPF_ZERO_BUFFER = (1ULL << 0)
>> +};
>> +
>>   #endif /* _UAPI__LINUX_BPF_H__ */
>> --
>> 2.43.5
>>

