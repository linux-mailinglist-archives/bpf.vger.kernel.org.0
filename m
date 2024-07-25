Return-Path: <bpf+bounces-35609-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 997A093BC53
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 08:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC5731C21A73
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 06:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFF615F407;
	Thu, 25 Jul 2024 06:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQ+rxohd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB9C2B9D3;
	Thu, 25 Jul 2024 06:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721887556; cv=none; b=CqyKZuJY3v7NOG27vYoKqHZ8rVZxeo0sx640Oc3ZbwTbMQr3bBIu0Sa4+qsP+Y/87nuODjIPuywvUEped3sL5gblLQnNo/zaC4Tch9Imdmw6/pvmlTk5QMuMbC++JoBt0zSzyFHES0149WOWO6OxVONcV9Vy5g54hD3mszd/CHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721887556; c=relaxed/simple;
	bh=UDVy++PBby52QidhT9ZHOSQgIpxScqSNtUx/ZPkog+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GSYG6/vsGQphHozzY4lw3+8LU7c51EvcTxDyQzqKz5Aidu8A/ch7cGSA0e0D/Os9nf/fK6+ZqB8aWWC6ZCYksl3HNBNqrMXRf+Ru14n8SP5ge7cumBCvQTjXs4Jm10mKhSu7tZuitY77Kj0EPA2PzjtR9TjfiKxzbLihc/EbHxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQ+rxohd; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fc692abba4so5145125ad.2;
        Wed, 24 Jul 2024 23:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721887554; x=1722492354; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BbRNwMN6oC17EcKdUViLPyp9SGiY23UfHQHR9lrz75o=;
        b=FQ+rxohdnbLV44u9Bd6eDAGGcbTEMoDzp3/GfKmI+6iTD3QcV+ZM4f2UEJC+CQKpb5
         W5bjDRFdgvJtQ8btbQoYIOC6PBR4VKVkepW07N//Du4aatmThXKR7uaTFobmIchS3Y33
         vHQHDfXZxQzdfZj/dQSdHu56hy0fRjV4eNCgWp+GzsZfSnwNMx4idpKIdbCCzck/75Ou
         gMaNCpbyM+8OWMhKIg8noNvTmXYXebm+508hk/t89opH16zbomfL1WIYsRwMTgAI8OuX
         pVZyXkFoIgI+oJZE47j7Vb83Vq1ZdTKCFajrzT5q3icCI7dawdqD67VM37Km8tLXTYct
         YjkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721887554; x=1722492354;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BbRNwMN6oC17EcKdUViLPyp9SGiY23UfHQHR9lrz75o=;
        b=rd6uXqKnJt3xl2c66UAlgW3+Sxj9dS+zRgXFTdz3OGM2GYa+B0ae5tJ3vxvOmoKs+a
         BYJ3hyJ3rDvnZrIl8qTn/OX130WuayrV0sREwOMgLtaHECEWQh4V4sQz8r1c6a/Jw3yC
         IRa3nW3gBOXA30y21MdrjV7iiv5LZke8s25sth9k3KshrEXHrvcPgXc1PZlbD0raJQqB
         8gnsUG8FF+UHOsjK3W6fGsyDHqgTKOCFjprqZ1aKNx5JhTI5UVxGUyjrax2NLZDIO30m
         c3hlUj2bisyLRPB2z0NO25xFjdoul2uDX+ffZYW+ZgjWNnNNpsRBeNC1TRuex9xeO2Sz
         QEmw==
X-Forwarded-Encrypted: i=1; AJvYcCXQOzq63v6HD7ENxT2V+kyWPQ4jC4i+h86wmQbtVFZ1JsneRyBiqwj/HoVbtefz/3qegNb0b9yhEutF4Q3GUrCZAK6M0uDSXFAZpY/o
X-Gm-Message-State: AOJu0YzxyTsAyD9ZcWsdyzW4OyRWi2jZuDUZqAX0vltHKqE/2/rrW7Uk
	B1s9td72dUj26qmddVBxmTqJYvndmH800GZosEgxgXbBz0CpMnfA
X-Google-Smtp-Source: AGHT+IEfChG/yEAlg0BTcAfnu7t1O+AC8GOOrHLMGAo3x+aKTifqtrXB241CQLbuaGD3yTOxVhWITA==
X-Received: by 2002:a17:902:e551:b0:1fb:59e6:b0e5 with SMTP id d9443c01a7336-1fed3860bf4mr19599975ad.19.1721887539569;
        Wed, 24 Jul 2024 23:05:39 -0700 (PDT)
Received: from [10.22.68.119] ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ee0185sm5673245ad.132.2024.07.24.23.05.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jul 2024 23:05:39 -0700 (PDT)
Message-ID: <c7952df9-5830-45d3-89bb-b45f2b030e24@gmail.com>
Date: Thu, 25 Jul 2024 14:05:34 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] bpf: Add bpf_check_attach_target_with_klog
 method to output failure logs to kernel
Content-Language: en-US
To: Yonghong Song <yonghong.song@linux.dev>, Zheao Li <me@manjusaka.me>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240725051511.57112-1-me@manjusaka.me>
 <08e180da-e841-427d-bed6-3ba8d73e8519@linux.dev>
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <08e180da-e841-427d-bed6-3ba8d73e8519@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 25/7/24 13:54, Yonghong Song wrote:
> 
> On 7/24/24 10:15 PM, Zheao Li wrote:
>> This is a v2 patch, previous Link:
>> https://lore.kernel.org/bpf/20240724152521.20546-1-me@manjusaka.me/T/#u
>>
>> Compare with v1:
>>
>> 1. Format the code style and signed-off field
>> 2. Use a shorter name bpf_check_attach_target_with_klog instead of
>> original name bpf_check_attach_target_with_kernel_log
>>
>> When attaching a freplace hook, failures can occur,
>> but currently, no output is provided to help developers diagnose the
>> root cause.
>>
>> This commit adds a new method, bpf_check_attach_target_with_klog,
>> which outputs the verifier log to the kernel.
>> Developers can then use dmesg to obtain more detailed information
>> about the failure.
>>
>> For an example of eBPF code,
>> Link:
>> https://github.com/Asphaltt/learn-by-example/blob/main/ebpf/freplace/main.go
>>
>> Co-developed-by: Leon Hwang <hffilwlqm@gmail.com>
>> Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
>> Signed-off-by: Zheao Li <me@manjusaka.me>
>> ---
>>   include/linux/bpf_verifier.h |  5 +++++
>>   kernel/bpf/syscall.c         |  5 +++--
>>   kernel/bpf/trampoline.c      |  6 +++---
>>   kernel/bpf/verifier.c        | 19 +++++++++++++++++++
>>   4 files changed, 30 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index 5cea15c81b8a..8eddba62c194 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>> @@ -848,6 +848,11 @@ static inline void bpf_trampoline_unpack_key(u64
>> key, u32 *obj_id, u32 *btf_id)
>>           *btf_id = key & 0x7FFFFFFF;
>>   }
>>   +int bpf_check_attach_target_with_klog(const struct bpf_prog *prog,
>> +                        const struct bpf_prog *tgt_prog,
>> +                        u32 btf_id,
>> +                        struct bpf_attach_target_info *tgt_info);
> 
> format issue in the above. Same code alignment is needed for arguments
> in different lines.
> 
>> +
>>   int bpf_check_attach_target(struct bpf_verifier_log *log,
>>                   const struct bpf_prog *prog,
>>                   const struct bpf_prog *tgt_prog,
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index 869265852d51..bf826fcc8cf4 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -3464,8 +3464,9 @@ static int bpf_tracing_prog_attach(struct
>> bpf_prog *prog,
>>            */
>>           struct bpf_attach_target_info tgt_info = {};
>>   -        err = bpf_check_attach_target(NULL, prog, tgt_prog, btf_id,
>> -                          &tgt_info);
>> +        err = bpf_check_attach_target_with_klog(prog, NULL,
>> +                                  prog->aux->attach_btf_id,
>> +                                  &tgt_info);
> 
> code alignment issue here as well.
> Also, the argument should be 'prog, tgt_prog, btf_id, &tgt_info', right?
> 
>>           if (err)
>>               goto out_unlock;
>>   diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
>> index f8302a5ca400..8862adaa7302 100644
>> --- a/kernel/bpf/trampoline.c
>> +++ b/kernel/bpf/trampoline.c
>> @@ -699,9 +699,9 @@ int bpf_trampoline_link_cgroup_shim(struct
>> bpf_prog *prog,
>>       u64 key;
>>       int err;
>>   -    err = bpf_check_attach_target(NULL, prog, NULL,
>> -                      prog->aux->attach_btf_id,
>> -                      &tgt_info);
>> +    err = bpf_check_attach_target_with_klog(prog, NULL,
>> +                              prog->aux->attach_btf_id,
>> +                              &tgt_info);
> 
> code alignment issue here
> 
>>       if (err)
>>           return err;
>>   diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 1f5302fb0957..4873b72f5a9a 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -21643,6 +21643,25 @@ static int
>> check_non_sleepable_error_inject(u32 btf_id)
>>       return btf_id_set_contains(&btf_non_sleepable_error_inject,
>> btf_id);
>>   }
>>   +int bpf_check_attach_target_with_klog(const struct bpf_prog *prog,
>> +                        const struct bpf_prog *tgt_prog,
>> +                        u32 btf_id,
>> +                        struct bpf_attach_target_info *tgt_info);
> 
> code alignment issue here.
> 
>> +{
>> +    struct bpf_verifier_log *log;
>> +    int err;
>> +
>> +    log = kzalloc(sizeof(*log), GFP_KERNEL | __GFP_NOWARN);
> 
> __GFP_NOWARN is unnecessary here.
> 
>> +    if (!log) {
>> +        err = -ENOMEM;
>> +        return err;
>> +    }
>> +    log->level = BPF_LOG_KERNEL;
>> +    err = bpf_check_attach_target(log, prog, tgt_prog, btf_id,
>> tgt_info);
>> +    kfree(log);
>> +    return err;
>> +}
>> +
>>   int bpf_check_attach_target(struct bpf_verifier_log *log,
>>                   const struct bpf_prog *prog,
>>                   const struct bpf_prog *tgt_prog,
> 
> More importantly, Andrii has implemented retsnoop, which intends to locate
> precise location in the kernel where err happens. The link is
>   https://github.com/anakryiko/retsnoop
> 
> Maybe you want to take a look and see whether it can resolve your issue.
> We should really avoid putting more stuff in dmesg whenever possible.
> 

retsnoop is really cool.

However, when something wrong in bpf_check_attach_target(), retsnoop
only gets its return value -EINVAL, without any bpf_log() in it. It's
hard to figure out the reason why bpf_check_attach_target() returns -EINVAL.

How about adding a tracepoint in bpf_check_attach_target_with_klog()?
It's to avoid putting stuff in dmesg.

Thanks,
Leon


