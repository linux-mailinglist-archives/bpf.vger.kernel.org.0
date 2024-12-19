Return-Path: <bpf+bounces-47319-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF029F7B8C
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 13:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FE7E7A27FA
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 12:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF2122489F;
	Thu, 19 Dec 2024 12:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="f3BkziUi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9321223E69
	for <bpf@vger.kernel.org>; Thu, 19 Dec 2024 12:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734611909; cv=none; b=jXXlLDeOed8uRvhnh8eKWFawGdvap0QJdQ4OUdC7CdNoZkTe65fmTQyVQd8Jtzmoq37zcOd1JiFoe0JcJZDbzGq+CVbH0eLmzOzEx4o2X1On62YsYmSgS4Cbg8XyOb+B03AKfgHyfGEDTQZ76i/LN5c8umr1exiNyeCzJf0iV7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734611909; c=relaxed/simple;
	bh=hvpREhnndtKn0PGZAUg1Wo3wZUINQKyMdb4GmdwXQMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EHRKHPRkL29DaHyR2ht3LKVjaLScDzzzNfNiu0AlzLvfWLhT/lDDLD2v2Ujb2KnmEb+1o6RM/JVV5cMOzMZT3/XW/TNEvThCubBx4RU4mzx3Rzit4qz39mj7awcQXWxtSm/2tbhp1zv6IlYFbNDnr2FUiQm6eEkGDgZGLAM/rr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=f3BkziUi; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-725eff44ba5so122139b3a.2
        for <bpf@vger.kernel.org>; Thu, 19 Dec 2024 04:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734611906; x=1735216706; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nX4d6U04IS+uDWAKcyH5UUvph+TtZ/1Xd/ex/ccJT2I=;
        b=f3BkziUis1Vs2VqBN+hPTYbDOcfozS5AhEe1U4JGnlbchzYiDnXz7at5Fl0pUNVUo6
         7lt+VALbNAFslIQl1fbGZYrCfVh5s1i8rdjBavKtXh5jkUUe2WEgdsScMSpx2p+kV+pu
         8vX95nE6RMAdOhdEF9QAx9kVjMV00gchTwsoNBVdi8luSQAsYALn8sryTTiWl25RvZSh
         H0pkjJvSyn9Wb7CeHE8qV3JzOT7gVvlkLf0MBiotT4bsLUzVo1jefp/w1D7IjVVuI7pu
         0DC/5L2RcNxDl2exd3GZrrg3fZ2cCLUnejXocwW/VBuLcCH4EJSBm0dsi5RRMQGI6j/J
         youQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734611906; x=1735216706;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nX4d6U04IS+uDWAKcyH5UUvph+TtZ/1Xd/ex/ccJT2I=;
        b=dWe2vNzrfxhu/HsaqDDz/0QE/ipR5/BE7xOx30JVa2O8vQKVuSAQAlejPDwDf/B6Ht
         n2ALGNkp04OeFx80NNy/L7w8pMMB1rKxep2jXHJ7Aht3eyFZA/M44gwcCC2+ghKd+USm
         PkjfZkz37Lj2ecgGIi8SdSWL8wvSQLiazORyFG0aRulfRsKWMqlMZF75ow/bCYK5Q4gS
         UzsMt5qIFtvBwtKJYwON+55opt+b8KkyDYrG6gKNfhyTwynXD3mPx7qnm+vRpOTF9dIr
         YXnarLuZ/hFVba6UZmmpyZKzm4p7XOQBWicwFl1vf4/RjFWrmIs5WvDQNRsFLQ/TUAJW
         vg+A==
X-Gm-Message-State: AOJu0YxsRFsKU2aKBw7EGdCVK3+bQzFa7V/alYu4zSUwhXSIVoYIcvoq
	XqKhBbm5ObPHLrqYlW8BDCiNk/2G8/iNFHuOHYE00/ry3u28I8PJmzj+YZ+Lr2g=
X-Gm-Gg: ASbGncugsKpGe4HOn3FhjJZXc+oxczNPaxqwa7VFMDmQSmkKSlhfADKBy5uzo4SxTPz
	8FLaVjKkaYPLOeVpZ7tCqpY1+JEP/d5qx838S+iPJyrNXo5ay52tsnW7vydxoD9/Er0RZGnwPrI
	O0SnLTfbBmgSrNsYtfa0Gap9axE15X1H5ZtQZXH5ab4567TezJ0a3G3LSZp/0TujvO/itqiELlI
	eSeoB1EYrJmIHvIHz15DbBJqlpH5mUMG29KCjAcmvfw6XSsZful//1sD9YXEyvGhYb64ZjTNlrF
	k7dI
X-Google-Smtp-Source: AGHT+IEo/T5cihZyoxZAozVi4UUPQtCv/8PL2PZp2jkYYPjYApTiko4G8nz3nBGNl42nZXeaWuVuPA==
X-Received: by 2002:a05:6a21:7882:b0:1e1:ac3c:195 with SMTP id adf61e73a8af0-1e5b48a4592mr4251812637.10.1734611905895;
        Thu, 19 Dec 2024 04:38:25 -0800 (PST)
Received: from [10.68.122.179] ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842dc7ed96bsm1075752a12.61.2024.12.19.04.38.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 04:38:25 -0800 (PST)
Message-ID: <9c53734d-9185-46b7-b07d-bf24ac06e688@bytedance.com>
Date: Thu, 19 Dec 2024 20:38:16 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH bpf] bpf: Fix deadlock when freeing cgroup storage
Content-Language: en-US
To: Yonghong Song <yonghong.song@linux.dev>,
 Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 David Vernet <void@manifault.com>
Cc: "open list:BPF [STORAGE & CGROUPS]" <bpf@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20241218092149.42339-1-wuyun.abel@bytedance.com>
 <eb9d4609-970e-4760-af94-8e48cca7ec23@linux.dev>
From: Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <eb9d4609-970e-4760-af94-8e48cca7ec23@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Yonghong,

On 12/19/24 10:45 AM, Yonghong Song Wrote:
> 
> 
> 
> On 12/18/24 1:21 AM, Abel Wu wrote:
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
>>     _raw_spin_lock_irqsave+0x3d/0x50
>>     bpf_local_storage_update+0xd1/0x460
>>     bpf_cgrp_storage_get+0x109/0x130
>>     bpf_prog_72026450ec387477_cgrp_ptr+0x38/0x5e
>>     bpf_trace_run1+0x84/0x100
>>     cgroup_storage_ptr+0x4c/0x60
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
>>     [ Since the verifier treats 'void *' as scalar which
>>       prevents me from getting a pointer to 'struct cgroup *',
>>       I added a raw tracepoint in cgroup_storage_ptr() to
>>       help reproducing this issue. ]
>>
>> Although it is tricky to reproduce, the risk of deadlock exists and
>> worthy of a fix, by passing its busy counter to the free procedure so
>> it can be properly incremented before storage/smap locking.
> 
> The above stack trace and explanation does not show that we will have
> a potential dead lock here. You mentioned that it is tricky to reproduce,
> does it mean that you have done some analysis or coding to reproduce it?
> Could you share the details on why you think we may have deadlock here?

The stack is A-A deadlocked: cgroup_storage_ptr() is called with
storage->lock held, while the bpf_prog attaching on this function
also tries to acquire the same lock by calling bpf_cgrp_storage_get()
thus leading to a AA deadlock.

The tricky part is, instead of attaching on cgroup_storage_ptr()
directly, I added a tracepoint inside it to hook:

------
diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
index 20f05de92e9c..679209d4f88f 100644
--- a/kernel/bpf/bpf_cgrp_storage.c
+++ b/kernel/bpf/bpf_cgrp_storage.c
@@ -40,6 +40,8 @@ static struct bpf_local_storage __rcu **cgroup_storage_ptr(void *owner)
  {
         struct cgroup *cg = owner;

+       trace_cgroup_ptr(cg);
+
         return &cg->bpf_cgrp_storage;
  }

------

The reason doing so is that typecasting from 'void *owner' to
'struct cgroup *' will be rejected by the verifier. But there
could be other ways to obtain a pointer to the @owner cgroup
too, making the deadlock possible.

Thanks,
	Abel

> 
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


