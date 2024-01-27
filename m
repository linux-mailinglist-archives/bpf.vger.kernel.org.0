Return-Path: <bpf+bounces-20461-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41AB183EB65
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 07:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D62D81F23B49
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 06:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4866A14A8E;
	Sat, 27 Jan 2024 06:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="syIO2uKW"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB03E33D5
	for <bpf@vger.kernel.org>; Sat, 27 Jan 2024 06:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706336061; cv=none; b=Ne0sx7xdOD73rBBHFj1hBosq4srJ50nBkTQifCh1FZlcgGGrNMaja5GOAoyvTg1dK+18gexF12zBUP/t533gL7GJAnVHuQde6HwXDMuL4M67xEJYheZ4o2xXLcGXZH2LA+7z0dX3DtA1DPCUGN0I3DG0TAmPzckIg4l4yYO+fm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706336061; c=relaxed/simple;
	bh=D3PBq8c6aqRMZd/+K+uQy7TBMk+ibwKJ7iL8o4vKxr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BvcPdbS2M9UuAb6BgabMDl+sGOVTP+HPjvVXjAIvj0yp6GMY1sURj9XjJG2T8HwT0sXHeX6t771s3JH/EsetF9STi2Cg664+IJYab0Jx3ty2LFoAL3LJeYK4zx6XlWwQKKvb4KxmU+Wps6zzZ9U+1oFc9HAD23qlRwbODZHMRv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=syIO2uKW; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b9216a64-0605-4386-963e-40555fdbf24b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706336056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+hbkZiwISKxYD+ny6VOcGAjHLpLyxnj2Zk7w//Q4GuM=;
	b=syIO2uKWvadhqvvMEULAXieRDjy+SMCEFr5T//sv5tGoRU9q4IOPHVoES05ptjWMIDF3CA
	1kM8HRfFPJZnerzaCF/UxWHGM3GyGJqEBVfFp2r1WzEG9P/pd/zfeMLjCb4ReJ8y9JYAxY
	LrlSSXKWkuXIa9cTjr7FJUVLElzvaeA=
Date: Fri, 26 Jan 2024 22:14:10 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] selftests/bpf: Remove "&>" usage in the
 selftests
Content-Language: en-US
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com,
 bpf@vger.kernel.org
References: <20240127025017.950825-1-martin.lau@linux.dev>
 <879d5e4f-f20d-460b-9fb3-e362c0324ca2@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <879d5e4f-f20d-460b-9fb3-e362c0324ca2@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/26/24 8:56 PM, Yonghong Song wrote:
> 
> On 1/26/24 6:50 PM, Martin KaFai Lau wrote:
>> From: Martin KaFai Lau <martin.lau@kernel.org>
>>
>> In s390, CI reported that the sock_iter_batch selftest
>> hits this error very often:
>>
>> 2024-01-26T16:56:49.3091804Z Bind /proc/self/ns/net -> 
>> /run/netns/sock_iter_batch_netns failed: No such file or directory
>> 2024-01-26T16:56:49.3149524Z Cannot remove namespace file 
>> "/run/netns/sock_iter_batch_netns": No such file or directory
>> 2024-01-26T16:56:49.3772213Z test_sock_iter_batch:FAIL:ip netns add 
>> sock_iter_batch_netns unexpected error: 256 (errno 0)
>>
>> It happens very often in s390 but Manu also noticed it happens very
>> sparsely in other arch also.
>>
>> It turns out the default dash shell does not recognize "&>"
> 
> Not sure whether it is feasible or not. But is it possible
> for all our test VMs we run '/bin/bash' before everyting else
> so we have a uniform bash environment so we do not need to
> worry about other shells?

It was my initial thought also. I think it makes sense to use the minimal shell 
feature such that it is more portable to different developer environments.

