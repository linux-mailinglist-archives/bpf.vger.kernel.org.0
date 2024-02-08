Return-Path: <bpf+bounces-21510-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FD984E46A
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 16:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 666061C2094F
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 15:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7FB7CF23;
	Thu,  8 Feb 2024 15:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WgG54PyL"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1E77CF15
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 15:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707407582; cv=none; b=ips+/UE3MRLHHLkM/BL2w4h8CDVKPnjrOlTF3gEcc7qxoStNVwVHGqsNzksIbDpoo44rsz1XjjaclLNQPKTPsJePlpG9PVHsnA4CfKmb2iF0fshpJl5R0MhCN08zA7jryloHwapbEvaQrZEJdRHPZMpR6/RtOqk1rxMgL7MEC5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707407582; c=relaxed/simple;
	bh=Dq882F4wS3XXNHwL601pFYQV9i7LpgyjnWLnSnvDhOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hphverens1cWWodiY7Ooxm3lDCbIgMpyIBQF6raZxdeAm5xDb5Fy2g2trJIC5cH0tbdo2cRotKZx/5k3DyVik9f8U4N51XyzzYA7OWoVV+FH9ygxupx+ht8JoK8JhtZFGpO6Zg8SRNlSvLWUZEZVMyG3XsRIsqvF87OI0/POyog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WgG54PyL; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c8877cc4-3d38-42ec-99bc-f968519e9f91@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707407578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2JrksO6KsrX7uC9e+zHrIF5TW4w8Y0U7C+EBDE/Ao70=;
	b=WgG54PyL+l/cdw9uoympSyLWCsYXsARpkz2zVnvXw7VTKmnuqqLU2gmE02QNc+sNqOZiBZ
	v5K7hBu9pp2MoipYXgMJwKq/x+NN2AF4m12+CQHTvs2eyFKcqCemSnFsINNDREBgtKtosK
	4lWN2bHjdpwiCpZNVIULuQQnuBAEN1c=
Date: Thu, 8 Feb 2024 07:52:51 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/3] bpf: Fix an issue due to uninitialized
 bpf_iter_task
Content-Language: en-GB
To: Chuyi Zhou <zhouchuyi@bytedance.com>, Yafang Shao <laoar.shao@gmail.com>,
 ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org
Cc: bpf@vger.kernel.org
References: <20240208090906.56337-1-laoar.shao@gmail.com>
 <20240208090906.56337-2-laoar.shao@gmail.com>
 <bbe097d6-b9be-46d1-bc66-630c23d0f9a8@bytedance.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <bbe097d6-b9be-46d1-bc66-630c23d0f9a8@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 2/8/24 1:41 AM, Chuyi Zhou wrote:
> Hello,
>
> 在 2024/2/8 17:09, Yafang Shao 写道:
>> Failure to initialize it->pos, coupled with the presence of an invalid
>> value in the flags variable, can lead to it->pos referencing an invalid
>> task, potentially resulting in a kernel panic. To mitigate this risk, 
>> it's
>> crucial to ensure proper initialization of it->pos to 0.
>>
>> Fixes: c68a78ffe2cb ("bpf: Introduce task open coded iterator kfuncs")
>> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
>> Cc: Chuyi Zhou <zhouchuyi@bytedance.com>
>> ---
>>   kernel/bpf/task_iter.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
>> index e5c3500443c6..ec4e97c61eef 100644
>> --- a/kernel/bpf/task_iter.c
>> +++ b/kernel/bpf/task_iter.c
>> @@ -978,6 +978,8 @@ __bpf_kfunc int bpf_iter_task_new(struct 
>> bpf_iter_task *it,
>>       BUILD_BUG_ON(__alignof__(struct bpf_iter_task_kern) !=
>>                       __alignof__(struct bpf_iter_task));
>>   +    kit->pos = NULL;
>> +
>>       switch (flags) {
>>       case BPF_TASK_ITER_ALL_THREADS:
>>       case BPF_TASK_ITER_ALL_PROCS:
>
> LGTM.
>
> Actually commit c68a78ffe2c ("bpf: Introduce task open coded iterator 
> kfuncs") initialize it->pos to NULL. But it seems the following commit
> ac8148d957f5043 ("bpf: bpf_iter_task_next: use next_task(kit->task) 
> rather than next_task(kit->pos)") drops this initialization.

Sorry, I missed this during reviewing commit ac8148d957f5043.
Your change LGTM.

Acked-by: Yonghong Song <yonghong.song@linux.dev>


