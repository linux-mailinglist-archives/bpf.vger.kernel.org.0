Return-Path: <bpf+bounces-67515-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3557B449E3
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 00:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91DB156303D
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 22:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6FC2EB874;
	Thu,  4 Sep 2025 22:45:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242A43A8F7;
	Thu,  4 Sep 2025 22:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757025934; cv=none; b=Io0x2h66Bycy1v1zeP97xW9hkJBGiNTaeJ3EKnnUfh/BUWhu9KXtMDMIPLVImQA/hfi13DrvwFqJgtGW8XJtojTVMlWreupUfmGbMyGZNbDzAnn2xUvVOobb6VXOf4bl7WWSd8oWa0KrHYVCGbIwWgKOVQYJbEJERzzqq6KuxZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757025934; c=relaxed/simple;
	bh=6vMk0pyJwGRJMP7832lAAOOK3ghmH4Yxz7rsEzOOuO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ekO91c1JquPFIEwcP3XpAjEy8VPs8Wd3pKGH0jNpXUlPaHPz8RlmHS117IuIiWMskdaeiDgvJ3+Db67r5D+JYZEuuLYmQ1m/vEjDqgQPkt9EVAfImelHL+LJk78ztHjTZsPHB3U0Q36AAnlBEsdLK3f3skV4iVzToruFLLmlTJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7728815e639so1004813b3a.1;
        Thu, 04 Sep 2025 15:45:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757025932; x=1757630732;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VUVn5o8RU+VFuWBR3njBdFcUgIW1PLQuaep15gf147A=;
        b=AzmahD09Jm9HZ8qXVBYGwV1j7TL9Z4o/dPOEidq4EnFxOv6x+WdUH9VQjpXSW2DeXT
         R20I6xiisCTuffyyodwnvsHcWPjWDj0op/pYQMWTQajDTh9ooOhUc6j63QLoZHDvrGvN
         yoiaeEduOSf7TkcW8iJnRRXXsMXZ5fNRURkMmL2t221t0Ut1b3Tvo9J/i+3tgvybdYcl
         XIohcBykBDCIUdYw7B0xWyqa4HBa4DcEQo49pI2SiY0YmaAjbw7xiQx4LKica2wadsc5
         h7EFbl1yZDfyHRMhFzMFCOinEIIgBF2acTS27j2MGdcEwLQY447eVwZe/RWqJJUo9n9m
         Yb5g==
X-Forwarded-Encrypted: i=1; AJvYcCVVLX9Tnc0c763f6rVzi/yDP/Iqdqy7CNqaeyUXgesTVN2kU0L/QhywBYSMVyQ1X1c9kEFcvp7GFGOUPOe5@vger.kernel.org, AJvYcCWcP8buEh7TbbAfyVStpZBBHfhuKsiSpt18iZQinwZiC2mktqtfGmD9tlskkqPtTWcpLz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOdU+hS4wlQnJZ3hOM6ggRep2Y9L68J75v3bLRBtRTkrsJNCZG
	2gzWM445a1n3DCDRYneeelcuy7Xsz3CiGpvwHCvJBIPqICvdHhCdE1wv
X-Gm-Gg: ASbGnct7d3NSNFggxkjjOMI6l7C/a5FAMTJ4Nj9uiVAUsvBl60Ddu2OlH0jppCBFmcu
	00AHC0ejvW+/ZkC7pO6GPwxH7R7vt9NXYemTwiOQwMXAHFPbiSrqEax7Yuip9JtFFtGbm+VQCE1
	cJ5kTETk/j74z7xI7ZOK0iCTJnh2aQdXSWePqm3NMnAKZUxkU57u8NnVKJeD1WyveOPOD4vM5HL
	gZjC/Wi7g5HacuN6GMHSUN2vWgbXRrqEqMCqy3sQpbjLb7idjeO15doijSsFYl1rd0i1bI12Jot
	eJwSQW3pbIssEc/F2VhxnBqjRI+O4e57CSjaDS8zUHdrNgtvN+OTYQJa2Oq41JHi9xeah6nXj5/
	oqM6tPkhW6oTD4a8M/0FtTvGnDzga/VUTNq0g/G9y1nSn/CdHYRXD/MHuGiVcCMqrhg==
X-Google-Smtp-Source: AGHT+IGN94q2Ld2UFuSGU1HjP5jJfzPbfkpJcaTqaoXXgE2LF+n/clgwidAquFl/T+E9+vqSWQ4wCw==
X-Received: by 2002:a05:6a20:9188:b0:246:17b:3576 with SMTP id adf61e73a8af0-246017b3754mr16664667637.46.1757025932259;
        Thu, 04 Sep 2025 15:45:32 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:499:89f8:cf94:6e72? ([2620:10d:c090:500::4:2ac])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a501a94sm20285853b3a.93.2025.09.04.15.45.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 15:45:31 -0700 (PDT)
Message-ID: <f6e9710a-a5bf-4af9-8c0d-d81d28c3040c@kernel.org>
Date: Thu, 4 Sep 2025 15:45:30 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v7 3/3] bpf: fix stackmap overflow check in
 __bpf_get_stackid()
To: Arnaud Lecomte <contact@arnaud-lcm.com>, alexei.starovoitov@gmail.com,
 yonghong.song@linux.dev
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me,
 syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
References: <20250903234052.29678-1-contact@arnaud-lcm.com>
 <20250903234325.30212-1-contact@arnaud-lcm.com>
Content-Language: en-US
From: Song Liu <song@kernel.org>
In-Reply-To: <20250903234325.30212-1-contact@arnaud-lcm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/3/25 4:43 PM, Arnaud Lecomte wrote:
> Syzkaller reported a KASAN slab-out-of-bounds write in __bpf_get_stackid()
> when copying stack trace data. The issue occurs when the perf trace
>   contains more stack entries than the stack map bucket can hold,
>   leading to an out-of-bounds write in the bucket's data array.
>
> Changes in v2:
>   - Fixed max_depth names across get stack id
>
> Changes in v4:
>   - Removed unnecessary empty line in __bpf_get_stackid
>
> Changs in v6:
>   - Added back trace_len computation in __bpf_get_stackid
>
> Link to v6: https://lore.kernel.org/all/20250903135348.97884-1-contact@arnaud-lcm.com/
>
> Reported-by: syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=c9b724fbb41cf2538b7b
> Fixes: ee2a098851bf ("bpf: Adjust BPF stack helper functions to accommodate skip > 0")
> Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>

For future patches, please keep the "Changes in vX.." at the end of

your commit log and after a "---". IOW, something like


Acked-by: Yonghong Song <yonghong.song@linux.dev>

---

changes in v2:

...

---

kernel/bpf/stackmap.c | 8 ++++++++


In this way, the "changes in vXX" part will be removed by git-am.

> ---
>   kernel/bpf/stackmap.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 9f3ae426ddc3..29e05c9ff1bd 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -369,6 +369,7 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
>   {
>   	struct perf_event *event = ctx->event;
>   	struct perf_callchain_entry *trace;
> +	u32 elem_size, max_depth;
>   	bool kernel, user;
>   	__u64 nr_kernel;
>   	int ret;
> @@ -390,11 +391,15 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
>   		return -EFAULT;
>   
>   	nr_kernel = count_kernel_ip(trace);
> +	elem_size = stack_map_data_size(map);
>   
>   	if (kernel) {
>   		__u64 nr = trace->nr;
>   
>   		trace->nr = nr_kernel;

this trace->nr = is useless.

> +		max_depth =
> +			stack_map_calculate_max_depth(map->value_size, elem_size, flags);
> +		trace->nr = min_t(u32, nr_kernel, max_depth);
>   		ret = __bpf_get_stackid(map, trace, flags);
>   
>   		/* restore nr */
> @@ -407,6 +412,9 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
>   			return -EFAULT;
>   
>   		flags = (flags & ~BPF_F_SKIP_FIELD_MASK) | skip;
> +		max_depth =
> +			stack_map_calculate_max_depth(map->value_size, elem_size, flags);
> +		trace->nr = min_t(u32, trace->nr, max_depth);
>   		ret = __bpf_get_stackid(map, trace, flags);

I missed this part earlier. Here we need to restore trace->nr, just like 
we did

in the "if (kernel)" branch.

Thanks,

Song

>   	}
>   	return ret;

