Return-Path: <bpf+bounces-30182-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8062E8CB6C2
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 02:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AFA028433F
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 00:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E848A23CB;
	Wed, 22 May 2024 00:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ri/9V2JG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04EB1865
	for <bpf@vger.kernel.org>; Wed, 22 May 2024 00:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716337877; cv=none; b=d+dfaYdKFvTqRt6rpmGQPCn0/qp577Eyuow4eFutfpP8aVuD79t504X4ZOlU1n4nj4l7TbHrBmrUHbukEteKbDyWelzb4tloV+434wtWNzeNltLS7Em5p2/ivx3y5aUq4t6fugOrDn1Gr70yhTG67muKv/DZmf9WjtksKAKFEc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716337877; c=relaxed/simple;
	bh=EfkIEPItPSzRwVj9H3pZ+l86Tv5tNrlMU7YPt3ktJwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aT5IgcWhaJRiw7RZwLlfRSq0kLQJncjUF79VkzBvThX/X1tmV6gDGmkMe8SbH6OjT9tezwodfGFVe1MAxRVnloKgNiuPHsM8QJH6pZ630LmF6CoybRg2RgsF+/FS0ZcNNd9+a3TMOzzRPAWc+fjhjKl5c4dVHJsz1jmFg8KcLXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ri/9V2JG; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-df4ada85a82so3197264276.2
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 17:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716337875; x=1716942675; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ryYYAPa2pw5DSEA6bKabjewmnEwdR/um6nOF3WArx30=;
        b=Ri/9V2JGTE50YXQUjmG1tOwzZ9EUYQBscwC/2tGZtBHlD/jWTByq+TEujR6QRhS7aP
         ULekAwYMbuSZM9vlM5fbVvz4zocxaCpuS3NqGv1oJIE5bvWdbh+HYPaVj4k3SgQmDThm
         C+WOOr8ya2h+rjpCvKPwfPCKakkup7+E1MJsApLtAD5SlZ7xk4PLeh1MAVXFQB5uY+TW
         a43BVcrVITOon09pseVFmHN8B9emWuT6y29U5mgAMSMyv9s10JJjlKrL/6HgISa7DD86
         SO4lxPR4BtAymZWFjtmnfriW1ODbrZf6cfvouMLdRxKJ+Ue28XS/MUYscmcVtAI4XspC
         enzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716337875; x=1716942675;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ryYYAPa2pw5DSEA6bKabjewmnEwdR/um6nOF3WArx30=;
        b=MhC3fZd3LK5v5VXYaNxIMGAaN1mqr35ABgFj/5Xlc2srchhtBc6fEwo7Cz19THcr3N
         CDqDZgnEWYtEBj9syrEuL2x1+Z1IFifawxwAt86XTDLzaDPC6mK3ZGjdmKHnzyY8mGD6
         Xs6bOQF8BaNGlZg/8DGNoJebja1+uGjHuKQ7XGBRlOMztqU58KVNDnqKrSb9Ilu80IX8
         ib3pUslM+Q4rUg97vhr0QKJdVLpnkpEQ5C010RL7p4YXtEuRMPi9MUSPB10JuJp+khDk
         +0GRXqeBGsSjKrCWjOizREvcLjNh4KCKOYI6tJw1QUF7zHShy0QA0kCBK1zVON0fN6We
         Wy9Q==
X-Gm-Message-State: AOJu0YwdI2tWT2UMrhvA/OXjOA8xg31sGwGziycPcotoInDQRsuw57N8
	E0dIgt14B7ux+RMHHVHM+gX46iSQnVD9BPijsd3JjLWxBLUtnyXg
X-Google-Smtp-Source: AGHT+IFZgSBhLXi6vLn9Um6oQn67zqrX1nOYv27AYijRuNTHL7csKn8YMZWXa/+5FoNZwSZwGcv2rw==
X-Received: by 2002:a25:1c4:0:b0:deb:3c96:cc73 with SMTP id 3f1490d57ef6-df4e0e362b9mr914824276.42.1716337874972;
        Tue, 21 May 2024 17:31:14 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:1437:59a6:29be:9221? ([2600:1700:6cf8:1240:1437:59a6:29be:9221])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-debd3713845sm5771873276.3.2024.05.21.17.31.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 17:31:14 -0700 (PDT)
Message-ID: <033f0d5a-5e3d-4e53-9301-5075b6d74480@gmail.com>
Date: Tue, 21 May 2024 17:31:12 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 6/7] selftests/bpf: detach a struct_ops link
 from the subsystem managing it.
To: Amery Hung <ameryhung@gmail.com>, Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 song@kernel.org, kernel-team@meta.com, andrii@kernel.org, kuifeng@meta.com
References: <20240510002942.1253354-1-thinker.li@gmail.com>
 <20240510002942.1253354-7-thinker.li@gmail.com>
 <20240521225252.GA3845630@bytedance>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <20240521225252.GA3845630@bytedance>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/21/24 15:56, Amery Hung wrote:
> On Thu, May 09, 2024 at 05:29:41PM -0700, Kui-Feng Lee wrote:
>> Not only a user space program can detach a struct_ops link, the subsystem
>> managing a link can also detach the link. This patch adds a kfunc to
>> simulate detaching a link by the subsystem managing it and makes sure user
>> space programs get notified through epoll.
>>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
>>   .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 42 ++++++++++++
>>   .../bpf/bpf_testmod/bpf_testmod_kfunc.h       |  1 +
>>   .../bpf/prog_tests/test_struct_ops_module.c   | 67 +++++++++++++++++++
>>   .../selftests/bpf/progs/struct_ops_detach.c   |  7 ++
>>   4 files changed, 117 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
>> index 1150e758e630..1f347eed6c18 100644
>> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
>> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
>> @@ -741,6 +741,38 @@ __bpf_kfunc int bpf_kfunc_call_kernel_getpeername(struct addr_args *args)
>>   	return err;
>>   }
>>   
>> +static DEFINE_SPINLOCK(detach_lock);
>> +static struct bpf_link *link_to_detach;
>> +
>> +__bpf_kfunc int bpf_dummy_do_link_detach(void)
>> +{
>> +	struct bpf_link *link;
>> +	int ret = -ENOENT;
>> +
>> +	/* A subsystem must ensure that a link is valid when detaching the
>> +	 * link. In order to achieve that, the subsystem may need to obtain
>> +	 * a lock to safeguard a table that holds the pointer to the link
>> +	 * being detached. However, the subsystem cannot invoke
>> +	 * link->ops->detach() while holding the lock because other tasks
>> +	 * may be in the process of unregistering, which could lead to
>> +	 * acquiring the same lock and causing a deadlock. This is why
>> +	 * bpf_link_inc_not_zero() is used to maintain the link's validity.
>> +	 */
>> +	spin_lock(&detach_lock);
>> +	link = link_to_detach;
>> +	/* Make sure the link is still valid by increasing its refcnt */
>> +	if (link && IS_ERR(bpf_link_inc_not_zero(link)))
>> +		link = NULL;
>> +	spin_unlock(&detach_lock);
>> +
> 
> I know it probably doesn't matter in this example, but where would you set
> link_to_detach to NULL if reg and unreg can be called multiple times?

For the same link if there is, reg() can be called only once
except if unreg() has been called for the previous reg() call on the
same link. Unreg() can only be called for once after a reg() call on the
same link.

For struct_ops map with link, unreg() is called by
bpf_struct_ops_map_link_dealloc() and bpf_struct_ops_map_link_detach().
The former one is called for a link only if the refcnt of the link has
dropped to zero. The later one is called for a link only if the refcnt
is not zero, and it holds update_mutex. Once unreg() has been called,
link->map will be cleared as well. So, unreg() should not be called
twice on the same link except it is registered again.

Does that answer your question?

> 
>> +	if (link) {
>> +		ret = link->ops->detach(link);
>> +		bpf_link_put(link);
>> +	}
>> +
>> +	return ret;
>> +}
> 
> [...]

