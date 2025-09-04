Return-Path: <bpf+bounces-67512-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0440B449D8
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 00:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACC935A2DEF
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 22:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12782EBDFB;
	Thu,  4 Sep 2025 22:40:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A4A2749C4;
	Thu,  4 Sep 2025 22:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757025650; cv=none; b=cF8iv8oIBORvC1FINsVKwpHmj58iqfnL7vWkbz+IQCyJkrq4UFx0I3c/RiLTi0WWAk7iwckK8//NqWr4Mj9SK22yjJaMmLByMD0ip7Q1CrnZ+364j4RmwfdSFYXw8XoT2fDRiTOcn3tXa6i7CHaRnmQ0Iu9oYmBobd6asYPeMVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757025650; c=relaxed/simple;
	bh=qTVF5sL19zmszjcdOcaIjk6qURyzvokgiNft2ILmfUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NrIVe05GJhukcagpDIhWxQv90znwicrW0zOLgpJj4XNZJHZ2RBjATHkDMwpzqG8Jt2E7RCp4WAPOauhtPCbfrbSVZ1Sk0KL3jPjvsMa5d5zeqEIRUHJvRCp4hIf9Iedxd3zH6XqxPo24ySKU+xNSmhcFG73zQFCWO7kKo3hjcWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-248df8d82e2so16446615ad.3;
        Thu, 04 Sep 2025 15:40:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757025648; x=1757630448;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U9kLjbbW0v3g5jIz1pOHvQ6wI7RCfXH9XFGjzeB8QiM=;
        b=eb0MSwqEC4xqgrhULeLBS6EWASNwwKzxCK67EnQxURsvPYuN4yPcZvOg1v0bFB/ihJ
         ebV605uwn9z784hzutp9m0GZm8H4wuUaXTGrWcg37k+gan9QJUCQXKUI9105q5xOnX2M
         SKpt9kBdOofYyWCCRWjQhc0Z5KoXWl9v7Jfye7MZPr+23cDlkZJrctv/SrDd1/s+seE0
         CiqpVb0WHzzVaAJt831eIfcXbUM0U3xybfpISjj+0vOuGMmyqXCHHn27KA3lS30bUeDr
         ZY1DzMojalQWv552kYRo24f1wMns7hVLwiBEUUdLTtDCc3fFIDlxRhEdWlykjezD2fUl
         N2og==
X-Forwarded-Encrypted: i=1; AJvYcCUfOChSc22vqxadHF5CAt0K0RKWdreS9LBO7tct/VpO70i9+derXexlbySWwU9v0jkvOic=@vger.kernel.org, AJvYcCWbFrtpCl+cPODKQ2wAUabMRJpzTdE2XOJTZ1Qypg2yrMdRsH3F+iUgWUOqjZq163Ebn0cXEGnPEsDfnq1u@vger.kernel.org
X-Gm-Message-State: AOJu0YyZKmGPzAzvsLK0KqhpYDq8bvzl9ww86jPOJaAITT/Ifyp2T5Sx
	0aKO6Wp4SM8GPoBO4L3yNcTif2yjFSy1zzlbFHXlPVeRH8oD60u3y7Xq
X-Gm-Gg: ASbGncvRw4pcpVPxKpf6FuvvrEDcl7XJIyGAeSjIIiu7tkuQm88CYIidpOf6HnTF1rQ
	yCJQnjZ3NEw4jcULWgAwNYOcK8ZYYMV7RrWmsZalbmWfD0Ti70smQt4QyNwHmkvzK6M1GHkk5Mp
	SRjGHEyEVs1ve0RTO2a3ADbUSSwSlNzn/PJT5DbV5HCaULGX6imOyO9HeKIV3IH4Q3QRfLr3xf3
	XX0nOIdcsDNZsFbh4M5+ZRKMn8qFfFZtAxbOfPJnYLUrrz5gTSWZLJZSkdmLWMogdpuY0N2gjMQ
	9chQuk2yuefR5UoHpwaUtpZApFdCiFmjF54RkG+7KQHh56qjrSAj5sI392MdSTcdBWV/LsMyVsA
	mFLEJJsa/tT53WcI+ZHbKk1VDpDJB4t9cZIqRngUArBjyJPRx/XGF35tkqivTsaAymQ==
X-Google-Smtp-Source: AGHT+IEg0EBJsgJD54RpVq77SBgOPP8QfZWbRdHeWbFnCFhn3Dtyc2saKsHgJj5EGnJS6W7ggBQrKw==
X-Received: by 2002:a17:902:f64a:b0:24a:9105:d020 with SMTP id d9443c01a7336-24a9105d719mr186110155ad.51.1757025648083;
        Thu, 04 Sep 2025 15:40:48 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:499:89f8:cf94:6e72? ([2620:10d:c090:500::4:2ac])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24905da2896sm198006415ad.81.2025.09.04.15.40.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 15:40:44 -0700 (PDT)
Message-ID: <05b2c226-9a09-4541-a18c-8a21898846d0@kernel.org>
Date: Thu, 4 Sep 2025 15:40:43 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v7 2/3] bpf: clean-up bounds checking in
 __bpf_get_stack
To: Arnaud Lecomte <contact@arnaud-lcm.com>, alexei.starovoitov@gmail.com,
 yonghong.song@linux.dev
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me,
 syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
References: <20250903233910.29431-1-contact@arnaud-lcm.com>
 <20250903234052.29678-1-contact@arnaud-lcm.com>
Content-Language: en-US
From: Song Liu <song@kernel.org>
In-Reply-To: <20250903234052.29678-1-contact@arnaud-lcm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/3/25 4:40 PM, Arnaud Lecomte wrote:
> Clean-up bounds checking for trace->nr in
> __bpf_get_stack by limiting it only to
> max_depth.
>
> Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
> Cc: Song Lui <song@kernel.org>

Typo in my name, which is "Song Liu".

This looks right.

Acked-by: Song Liu <song@kernel.org>

> ---
>   kernel/bpf/stackmap.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index ed707bc07173..9f3ae426ddc3 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -462,13 +462,15 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
>   	if (may_fault)
>   		rcu_read_lock(); /* need RCU for perf's callchain below */
>   
> -	if (trace_in)
> +	if (trace_in) {
>   		trace = trace_in;
> -	else if (kernel && task)
> +		trace->nr = min_t(u32, trace->nr, max_depth);
> +	} else if (kernel && task) {
>   		trace = get_callchain_entry_for_task(task, max_depth);
> -	else
> +	} else {
>   		trace = get_perf_callchain(regs, 0, kernel, user, max_depth,
>   					   crosstask, false);
> +	}
>   
>   	if (unlikely(!trace) || trace->nr < skip) {
>   		if (may_fault)
> @@ -477,7 +479,6 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
>   	}
>   
>   	trace_nr = trace->nr - skip;
> -	trace_nr = (trace_nr <= num_elem) ? trace_nr : num_elem;
>   	copy_len = trace_nr * elem_size;
>   
>   	ips = trace->ip + skip;

