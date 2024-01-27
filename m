Return-Path: <bpf+bounces-20462-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B2183EB6D
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 07:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9C762856A3
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 06:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D034E241F3;
	Sat, 27 Jan 2024 06:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SNdPVS1s"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3546F11CB0
	for <bpf@vger.kernel.org>; Sat, 27 Jan 2024 06:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706336836; cv=none; b=k8CAHNwgUY2M0y/KrpcKvtljaTXrEJ+4eYrGwY8Rd02k3ysSTaB9QbCmpaVYx57RawsjDpbWIsIYTtqmbNRD6W0Ing549CYhmIsZo+m5HnvyhYq2uk/rguYfgbS2Z96R3mjqeBF6f18jvNZ1T3xumPYOr3FRnMfraWg8hV/IiFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706336836; c=relaxed/simple;
	bh=+7KVpuWJ2Szs5dzRnepKgVomTxbOWBJSoMMORlZv/q4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KKT1ZBHneJDj0+5pA2aiQdD2KMMmuC0DY7upNIGINAnEbg90Ar+DCv0ZHTPDmLZuQ/MllWhJ5f2HSbriGp22PR7aGMVdyQ95VIZDIEiLY4BCktULQX9P8DAk0zT+4vCSEC91PxYsB404kxekd0hAAQtsSNW34bfYN/z0N9ozWqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SNdPVS1s; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ee7d44ba-2e9a-4876-9331-7d54557735e4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706336832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LjHXFCJ+xU1eLJ8wlM/VHRLKKYN9fQPjGTYS9+o4o6Q=;
	b=SNdPVS1sFr3UtTHI24ep2W9UAUfmWIvpAieW0/DujCuTGaBBJGFdWa481xifpQaYegnlrs
	T6rllYrPr3UJNjblJj2lOQzJjiZMiu4A21u11JN5lo/1sguK7R76l0oBxjMiwtTpf4lsoc
	OO3aL1BDJJrigHlRHVNFgQSBMe3D4uA=
Date: Fri, 26 Jan 2024 22:27:07 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] selftests/bpf: Remove "&>" usage in the
 selftests
Content-Language: en-GB
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com,
 bpf@vger.kernel.org
References: <20240127025017.950825-1-martin.lau@linux.dev>
 <879d5e4f-f20d-460b-9fb3-e362c0324ca2@linux.dev>
 <b9216a64-0605-4386-963e-40555fdbf24b@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <b9216a64-0605-4386-963e-40555fdbf24b@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 1/26/24 10:14 PM, Martin KaFai Lau wrote:
> On 1/26/24 8:56 PM, Yonghong Song wrote:
>>
>> On 1/26/24 6:50 PM, Martin KaFai Lau wrote:
>>> From: Martin KaFai Lau <martin.lau@kernel.org>
>>>
>>> In s390, CI reported that the sock_iter_batch selftest
>>> hits this error very often:
>>>
>>> 2024-01-26T16:56:49.3091804Z Bind /proc/self/ns/net -> 
>>> /run/netns/sock_iter_batch_netns failed: No such file or directory
>>> 2024-01-26T16:56:49.3149524Z Cannot remove namespace file 
>>> "/run/netns/sock_iter_batch_netns": No such file or directory
>>> 2024-01-26T16:56:49.3772213Z test_sock_iter_batch:FAIL:ip netns add 
>>> sock_iter_batch_netns unexpected error: 256 (errno 0)
>>>
>>> It happens very often in s390 but Manu also noticed it happens very
>>> sparsely in other arch also.
>>>
>>> It turns out the default dash shell does not recognize "&>"
>>
>> Not sure whether it is feasible or not. But is it possible
>> for all our test VMs we run '/bin/bash' before everyting else
>> so we have a uniform bash environment so we do not need to
>> worry about other shells?
>
> It was my initial thought also. I think it makes sense to use the 
> minimal shell feature such that it is more portable to different 
> developer environments.

I just proposed an alternate solution. Since you have throught about this, I am certainly okay with the current patch.


