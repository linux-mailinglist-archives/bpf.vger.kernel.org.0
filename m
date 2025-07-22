Return-Path: <bpf+bounces-64055-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3339B0DEC8
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 16:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09D696C1F0E
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 14:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC122DF3CF;
	Tue, 22 Jul 2025 14:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u4IfZNq3"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB64C17548
	for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 14:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753194572; cv=none; b=px3cuPfpH+eyEp7gQXkHv2Qr3MF6I0hEF1bSs8RqIs/2ht+3Gt9lqD7tGAy4GREgapMEQtk5hms8H3lkDM6nV+/wLhFRNCgUOhyo2hpa+qQNAbcRN+segH2LKGdj++fMDSkF07z2oeZmbq+5CzEPO5e3pMmNGvdLkkAh95z0ZiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753194572; c=relaxed/simple;
	bh=FxkOTXFx9upCkSgC+p080XeHjFwC+HNTU/qqtKBxMdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ESa0EkmmbfjXPb4aGZ7MeRsdqku6o/mbUawyhkyqkWYqYyoNa0RTuxlCx9A2UYWa6qzb5EZsJVCpZREJur3JeIEW8CUWXtubow/vKd23gNOiA69Ab45H7K3ea9kQRP6kA3TO2fScYl/fdLTcRSkQQPRqiUOGG+9RHrlsWLRGsPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u4IfZNq3; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d7185c14-3fd4-4316-a920-17db547c8b3a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753194567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=caUBKoTMakPlfWZ2ydKJ8m4dtnxZEXMe2q8G417gYHc=;
	b=u4IfZNq3Zduamf7qk4/hwGEB1WRmZCrvrTDr1CD8FODTmOqhv3QayOWhQ8g8T2B+bJ8++O
	Wp80bTk1TZRYvBHNunf6IQmHCkagBIcNbA8aZKAiMNpS7Z6o1ZK0DsnxIPgOPCTxeyjVs8
	DA6uGJfAudgVyn0OVwug/dh7wobzl7s=
Date: Tue, 22 Jul 2025 22:29:18 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/3] bpf: Introduce BPF_F_CPU flag for
 percpu_array map
To: Eduard Zingerman <eddyz87@gmail.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, yonghong.song@linux.dev, song@kernel.org,
 dxu@dxuuu.xyz, deso@posteo.net, kernel-patches-bot@fb.com
References: <20250717193756.37153-1-leon.hwang@linux.dev>
 <20250717193756.37153-2-leon.hwang@linux.dev>
 <CAEf4BzY74tbyzD-4iF1Em9EmKX=2fAN4dTp_k8o+MuN2T3CVqQ@mail.gmail.com>
 <d8d4cd89-2953-45d1-9f81-ab633aa3e4cd@linux.dev>
 <c55df650fe8a491d5ae6640f5e08707bab9c30dc.camel@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <c55df650fe8a491d5ae6640f5e08707bab9c30dc.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/7/22 01:11, Eduard Zingerman wrote:
> On Tue, 2025-07-22 at 01:08 +0800, Leon Hwang wrote:
> 
> [...]
> 
>>>> @@ -1941,19 +1945,25 @@ int generic_map_update_batch(struct bpf_map *map, struct file *map_file,
>>>>  {
>>>>         void __user *values = u64_to_user_ptr(attr->batch.values);
>>>>         void __user *keys = u64_to_user_ptr(attr->batch.keys);
>>>> -       u32 value_size, cp, max_count;
>>>> +       u32 value_size, cp, max_count, cpu = attr->batch.cpu;
>>>> +       u64 elem_flags = attr->batch.elem_flags;
>>>>         void *key, *value;
>>>>         int err = 0;
>>>>
>>>> -       if (attr->batch.elem_flags & ~BPF_F_LOCK)
>>>> +       if (elem_flags & ~(BPF_F_LOCK | BPF_F_CPU))
>>>>                 return -EINVAL;
>>>>
>>>> -       if ((attr->batch.elem_flags & BPF_F_LOCK) &&
>>>> +       if ((elem_flags & BPF_F_LOCK) &&
>>>>             !btf_record_has_field(map->record, BPF_SPIN_LOCK)) {
>>>>                 return -EINVAL;
>>>>         }
>>>>
>>>> -       value_size = bpf_map_value_size(map);
>>>> +       if ((elem_flags & BPF_F_CPU) &&
>>>> +               map->map_type != BPF_MAP_TYPE_PERCPU_ARRAY)
>>>
>>> nit: keep on the single line
>>>
>>
>> Ack.
>>
>> Btw, how many chars of one line do we allow? 100 chars?
> 
> Yes, 100 chars per line (Andrii is on PTO).

Hi Eduard,

Thank you for your reply.

I’ll keep that in mind for the future.

Thanks,
Leon


