Return-Path: <bpf+bounces-49820-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0760A1C72D
	for <lists+bpf@lfdr.de>; Sun, 26 Jan 2025 10:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67B193A7551
	for <lists+bpf@lfdr.de>; Sun, 26 Jan 2025 09:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97A01CD3F;
	Sun, 26 Jan 2025 09:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="dvI5kMiU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D676ABA53
	for <bpf@vger.kernel.org>; Sun, 26 Jan 2025 09:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737883912; cv=none; b=BqsCWox5g7+ggCO1iE+mZDPWjo2fGqtLBwL+t1WNEut4L51vMxg2fSFuygPKlIG7cjnQ+cuSsNGciZBBvzjHdk41f+hq45ZukF4RT/vvYp9l8SU1dg28C3Cj3Vvc011yyLEIMZ/f09zAwmN8xw0YkFYUq7PWieWhTxERKKOwvfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737883912; c=relaxed/simple;
	bh=yZxcnzUY1jXYomlU7BkXfSXr+CYJdFNNQNZASGiReec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VXhmQuBH/X+Ij7je5oty+X2wFRCY1BCYsL4/kxjUVDEdovT0WdVcFXExzKeGynNHeCeM7PRE0nZdpvc1zg1YaFTgTjUix+CH3v0jhH2Xvf/rgaYdvcxZhD9eMN6yXnURIXKUsaQIwmwMgURsYaSo3UMYrIcK2jRy3rxAOe5xPaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=dvI5kMiU; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ee534d6800so832345a91.2
        for <bpf@vger.kernel.org>; Sun, 26 Jan 2025 01:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1737883910; x=1738488710; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Vdex0E1LkjVNFSeYRUT03kojru6ANe8E5l0RMXwH1A=;
        b=dvI5kMiU/so5ZAEecF8S2ZIGpABJVj099c+itWe3VfLtBMlb+A0tehkbvhWszGcnyA
         sbownQnNCHuvbfkgAOkHIMzamubOafn6pbp2Pleyfsw84VX0OecBYhotJZTmD6kLbq1C
         ahNwvrVtgwztra0cGQpqto8yxgJh4Rpq/7zhqqE+6slK72CjUL8z5DuonyOdxaRADby1
         nBS/LbC5ugZPelbsVQlBUq97rSpVr5ph3G+bp23QL+E10tLnL4FbFp7VV7rksjFXw53z
         pznIc/EqQgBQukMhqaeN9VtnoJm36bLQasZ5/jm+jnBZUT2J4xIkksBeDJqkuqJbcM3U
         wBrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737883910; x=1738488710;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Vdex0E1LkjVNFSeYRUT03kojru6ANe8E5l0RMXwH1A=;
        b=OD3QVlZYRD10XphEmVmMwrU00kMo8osGVV4H+P1h22AvFAKLWhDpuZPRnF+PmZABDz
         Tm1w+YxRskCym/hK0oILjBBiYl32zZ9g5se152ZwHwKC1WwKfZPCBq+vdrZNsRuXAuks
         tdSwqe78yKOA06wd7cOO7Z/sGXGJLNCz+/H7QetOxUYWwNyLs/hZxfCYMhlZ6pb3Jt3p
         JvOrKX0TCqjWjRROGHkOd+LorJ1HQeHNHfvfAOmD4IFQcLsliOcmKJHTr4MEWVxZsv3C
         TbL+oXqx1wLrTJdPJRtj16j8/KEr//e+HCjH3oaXeBFj/yM+pQIPvtNCLK1/drhxE1eB
         s7WA==
X-Forwarded-Encrypted: i=1; AJvYcCV1EJfV++ZSQlfKcTg46NMVCNSvEoM4pp8CrT2Hi0KpIdKFbw5wKZyULxQOyZI4LOZyt0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiQpWTXlvVCl2zNksIhMfVKVY3Su57C6y1JQLQ4ztNc+CAX6ea
	ELLm9vsJqts9Jymude1wFXCAphnetsDpNG/cJuXqC6fSurmfNCVAKlqCcgM1qfE=
X-Gm-Gg: ASbGncvdqXZfr3Ub/TWJRFMKiivkM25YNbG4+dYeCW+37DiCC+P41OwoIosbP92bGuc
	DDR7NQsM5fhXYea9rD38s94KwDUXs1iTjvQ+rSrWIt9fk7Y7udN2aVjFmwTFf+r9sfW1QaGWehT
	3AgBKc15CYp14uXhpd4JXwXBuGZwOODsUkLkHTW5DsMn/NZFCGlUIjeSsZqVhvMbyaV1ZQ6/1o7
	taY3k0d8XEAdX1wviNHRG62CtpytsqCnQCFWpEHGDsM1Vy4CQNj9R2l0/3ttrQ9Aow3HdN1mg3y
	lMLm+ZcaB2qQdpaiGvo3JYlTF0MJrA==
X-Google-Smtp-Source: AGHT+IHuxEdk7pwGH/y645vMAahlBZwqYxxxNurCYcS5fK+TLffGmhCa8PmSSGheu8baO5i+laT23Q==
X-Received: by 2002:a17:90b:2d45:b0:2ee:d397:1fef with SMTP id 98e67ed59e1d1-2f782d97805mr19724549a91.6.1737883909933;
        Sun, 26 Jan 2025 01:31:49 -0800 (PST)
Received: from [10.254.144.106] ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffa77043sm5416210a91.35.2025.01.26.01.31.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jan 2025 01:31:49 -0800 (PST)
Message-ID: <7139ed64-55be-4b70-a03f-8b2414fc93d3@bytedance.com>
Date: Sun, 26 Jan 2025 17:31:40 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH bpf v2] bpf: Fix deadlock when freeing cgroup storage
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, David Vernet <void@manifault.com>,
 "open list:BPF [STORAGE & CGROUPS]" <bpf@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20241221061018.37717-1-wuyun.abel@bytedance.com>
 <02c69185-1477-485c-af4f-a46f7aadadab@linux.dev>
From: Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <02c69185-1477-485c-af4f-a46f7aadadab@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/25/25 4:20 AM, Martin KaFai Lau Wrote:
> On 12/20/24 10:10 PM, Abel Wu wrote:
>> The following commit
>> bc235cdb423a ("bpf: Prevent deadlock from recursive bpf_task_storage_[get|delete]")
>> first introduced deadlock prevention for fentry/fexit programs attaching
>> on bpf_task_storage helpers. That commit also employed the logic in map
>> free path in its v6 version.
>>
>> Later bpf_cgrp_storage was first introduced in
>> c4bcfb38a95e ("bpf: Implement cgroup storage available to non-cgroup-attached bpf progs")
>> which faces the same issue as bpf_task_storage, instead of its busy
>> counter, NULL was passed to bpf_local_storage_map_free() which opened
>> a window to cause deadlock:
>>
>>     <TASK>
>>         (acquiring local_storage->lock)
>>     _raw_spin_lock_irqsave+0x3d/0x50
>>     bpf_local_storage_update+0xd1/0x460
>>     bpf_cgrp_storage_get+0x109/0x130
>>     bpf_prog_a4d4a370ba857314_cgrp_ptr+0x139/0x170
>>     ? __bpf_prog_enter_recur+0x16/0x80
>>     bpf_trampoline_6442485186+0x43/0xa4
>>     cgroup_storage_ptr+0x9/0x20
>>         (holding local_storage->lock)
>>     bpf_selem_unlink_storage_nolock.constprop.0+0x135/0x160
>>     bpf_selem_unlink_storage+0x6f/0x110
>>     bpf_local_storage_map_free+0xa2/0x110
>>     bpf_map_free_deferred+0x5b/0x90
>>     process_one_work+0x17c/0x390
>>     worker_thread+0x251/0x360
>>     kthread+0xd2/0x100
>>     ret_from_fork+0x34/0x50
>>     ret_from_fork_asm+0x1a/0x30
>>     </TASK>
>>
>> Progs:
>>   - A: SEC("fentry/cgroup_storage_ptr")
> 
> The v1 thread has suggested using notrace in a few functions. I didn't see any counterarguments that wouldn't be sufficient.
> 
> imo, that should be a better option instead of having more unnecessary failures in all other normal use cases which will not be interested in tracing cgroup_storage_ptr().

Hi Martin, thank you very much reminding me this. I found my reply to
that message hadn't been sent out for unknown reasons.. I have re-send
just now, please refer to:

https://lore.kernel.org/bpf/46947563-c2e8-4346-84ca-c0774fa0ce39@bytedance.com/

Best Regards,
	Abel

> 
> pw-bot: cr
> 
>>     - cgid (BPF_MAP_TYPE_HASH)
>>     Record the id of the cgroup the current task belonging
>>     to in this hash map, using the address of the cgroup
>>     as the map key.
>>     - cgrpa (BPF_MAP_TYPE_CGRP_STORAGE)
>>     If current task is a kworker, lookup the above hash
>>     map using function parameter @owner as the key to get
>>     its corresponding cgroup id which is then used to get
>>     a trusted pointer to the cgroup through
>>     bpf_cgroup_from_id(). This trusted pointer can then
>>     be passed to bpf_cgrp_storage_get() to finally trigger
>>     the deadlock issue.
>>   - B: SEC("tp_btf/sys_enter")
>>     - cgrpb (BPF_MAP_TYPE_CGRP_STORAGE)
>>     The only purpose of this prog is to fill Prog A's
>>     hash map by calling bpf_cgrp_storage_get() for as
>>     many userspace tasks as possible.
>>
>> Steps to reproduce:
>>   - Run A;
>>   - while (true) { Run B; Destroy B; }
>>
>> Fix this issue by passing its busy counter to the free procedure so
>> it can be properly incremented before storage/smap locking.
>>
>> Fixes: c4bcfb38a95e ("bpf: Implement cgroup storage available to non-cgroup-attached bpf progs")
>> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
>> ---
>>   kernel/bpf/bpf_cgrp_storage.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
>> index 20f05de92e9c..7996fcea3755 100644
>> --- a/kernel/bpf/bpf_cgrp_storage.c
>> +++ b/kernel/bpf/bpf_cgrp_storage.c
>> @@ -154,7 +154,7 @@ static struct bpf_map *cgroup_storage_map_alloc(union bpf_attr *attr)
>>   static void cgroup_storage_map_free(struct bpf_map *map)
>>   {
>> -    bpf_local_storage_map_free(map, &cgroup_cache, NULL);
>> +    bpf_local_storage_map_free(map, &cgroup_cache, &bpf_cgrp_storage_busy);
>>   }
>>   /* *gfp_flags* is a hidden argument provided by the verifier */
> 


