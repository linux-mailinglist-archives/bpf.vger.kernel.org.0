Return-Path: <bpf+bounces-65238-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 211E1B1DD56
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 21:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1A8218C70F1
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 19:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C74A2737EC;
	Thu,  7 Aug 2025 19:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="e0fnsrlv"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5B4223DEA
	for <bpf@vger.kernel.org>; Thu,  7 Aug 2025 19:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754593653; cv=none; b=JrrHhcrU8FFop7sob+AopD9Ya4FJms94jGDdj14BqfrUt+EthlduQQTOBYUCZKqSRJ2XMEtbyozp2OpNE8JOGqwn+U7wxhI8J1PdSLtXRIGxHDElmdqm/aSAytw360Bo2Q8dmh6nO4Qvs9jiC08rn7O0/SxeuPVLi13z2JLQGxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754593653; c=relaxed/simple;
	bh=vVzUNgVmW/PgwiL7/RYY6G5Nk9YDHupaJR8VLG3ZN3c=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ObGx4QaJ+lddhGY8+ARpse2EfJoW0dKI8ItajG1uiJoFQXsTsEE4IEQr4bV5spTNZSenZzAHwAxbkaNbvXAd3buNr+iXiS/llzL4y4rCK1wefrxA8CKZtn/1pgVSoivCuWcL1lVqBn74Yq5mMxMDazEjAzw2QYni+EGilj7SfJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e0fnsrlv; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1797f2fd-2b34-4c6b-bc61-043e01fde417@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754593648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IfOgLDJ9ixlszDcIQd7PgdDsuBPlh6W1bz0Tz9C3n3o=;
	b=e0fnsrlvAzRPA4ZuX4EyRpl4P7sdJi5hMXpwyMy6gNSVfE2+PccMwm6x/jkg5kJavEYJnS
	TMSMvFexguHw+4HFb9Pddxn41onOQ8095bqByg37j1R86ReY1k0lIn1LSZdCDSCcMh47eu
	j8zrMX1E0nruydCEImYnJrCq83WzJxE=
Date: Thu, 7 Aug 2025 12:07:15 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] bpf: refactor max_depth computation in
 bpf_get_stack()
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
To: Arnaud Lecomte <contact@arnaud-lcm.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me,
 song@kernel.org, syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
References: <6cc26e1f-6ad6-44cd-a049-c4e7af9a229a@linux.dev>
 <20250807175032.7381-1-contact@arnaud-lcm.com>
 <fbabac62-4bc1-4c11-9316-ed51ae9dbb0d@linux.dev>
In-Reply-To: <fbabac62-4bc1-4c11-9316-ed51ae9dbb0d@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 8/7/25 12:01 PM, Yonghong Song wrote:
>
>
> On 8/7/25 10:50 AM, Arnaud Lecomte wrote:
>> A new helper function stack_map_calculate_max_depth() that
>> computes the max depth for a stackmap.
>>
>> Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
>> ---
>>   kernel/bpf/stackmap.c | 38 ++++++++++++++++++++++++++++++--------
>>   1 file changed, 30 insertions(+), 8 deletions(-)
>>
>> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
>> index 3615c06b7dfa..14e034045310 100644
>> --- a/kernel/bpf/stackmap.c
>> +++ b/kernel/bpf/stackmap.c
>> @@ -42,6 +42,31 @@ static inline int stack_map_data_size(struct 
>> bpf_map *map)
>>           sizeof(struct bpf_stack_build_id) : sizeof(u64);
>>   }
>>   +/**
>> + * stack_map_calculate_max_depth - Calculate maximum allowed stack 
>> trace depth
>> + * @map_size:        Size of the buffer/map value in bytes
>> + * @elem_size:       Size of each stack trace element
>> + * @map_flags:       BPF stack trace flags (BPF_F_USER_STACK, 
>> BPF_F_USER_BUILD_ID, ...)

One more thing: map_flags -> flags, as 'flags is used in bpf_get_stackid/bpf_get_stack etc.

>> + *
>> + * Return: Maximum number of stack trace entries that can be safely 
>> stored,
>> + * or -EINVAL if size is not a multiple of elem_size
>
> -EINVAL is not needed here. See below.

[...]


