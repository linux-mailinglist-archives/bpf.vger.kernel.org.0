Return-Path: <bpf+bounces-42262-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A839A182D
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 03:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7DF11C2502B
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 01:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABAD25779;
	Thu, 17 Oct 2024 01:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Ta0ygZRJ"
X-Original-To: bpf@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8DD2B9B9;
	Thu, 17 Oct 2024 01:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729130250; cv=none; b=MdYNePjzHpJis0t71IR+f1K+01LzOr3wnjiH2eRNl4JpgOA1jZ7+bSwpEWNe2DI/AWfbqjoa0X0Rodon7AfVxvv8cgPC/i2mja5N3gZfc+apsObdbJXu3yQX1V+yqr+flSNX12J/TsdTV+mmTvbzWSaenfHXN89BOtKp2Y8jpq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729130250; c=relaxed/simple;
	bh=rPePP2hP+7r3ZK0pSXfMiV0bd83AdGeY33oRTt2EARU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pqZOk2+Eu8SQhmtL2WJObFwyvGHPLI87xHlC60/cpqAE4K3xwTnp+iLB358O/blXv3cNSqAsHirwEmfyFES/uuJw8qxkGz1QtIPt10FaWkQfta3vfL+ZlJQolKcgLebksAl2zIF+ylLLyP0m0SkGZcZzCWxq0UOqZQGhxnvNMw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Ta0ygZRJ; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729130239; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=VEM3vkzBrpwK0wRRd11aOga3hCBuxSzOEec1Rz7d7G8=;
	b=Ta0ygZRJqk4yw75pR9AyQLrliUqh7xKVtRoF+x9e3DbPa8HBSp//MnLKJG3kbWjf/BbcW9v7TYJr90fr/3Ejl0MKGdAhoPXSstkpKou8xZHrgXV0eIetMgi1hv18SBthXOFA7bXoW6TDqRU2F29Obf1cAZdC4MiU2EyH9YDnCj0=
Received: from 30.74.129.199(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0WHJ4AIY_1729130237 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 17 Oct 2024 09:57:18 +0800
Message-ID: <fa9600d8-2a6c-4c74-8e42-31d669c06b59@linux.alibaba.com>
Date: Thu, 17 Oct 2024 09:57:17 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched_ext: Use BTF_ID to resolve task_struct
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
 David Vernet <void@manifault.com>, Peter Zijlstra <peterz@infradead.org>,
 bpf <bpf@vger.kernel.org>
References: <20241016024100.7409-1-dtcccc@linux.alibaba.com>
 <CAADnVQ+gL48HGcs0JyLfq17D-qXyeZEoBJwGgGTO1JcJ3Ykqtw@mail.gmail.com>
From: Tianchen Ding <dtcccc@linux.alibaba.com>
In-Reply-To: <CAADnVQ+gL48HGcs0JyLfq17D-qXyeZEoBJwGgGTO1JcJ3Ykqtw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/10/17 00:57, Alexei Starovoitov wrote:
> On Tue, Oct 15, 2024 at 7:42 PM Tianchen Ding <dtcccc@linux.alibaba.com> wrote:
>>
>> Save the searching time during bpf_scx_init.
>>
>> Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
>> ---
>>   kernel/sched/ext.c | 12 +++---------
>>   1 file changed, 3 insertions(+), 9 deletions(-)
>>
>> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
>> index 609b9fb00d6f..1d11a96eefb8 100644
>> --- a/kernel/sched/ext.c
>> +++ b/kernel/sched/ext.c
>> @@ -5343,7 +5343,7 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
>>
>>   extern struct btf *btf_vmlinux;
>>   static const struct btf_type *task_struct_type;
>> -static u32 task_struct_type_id;
>> +BTF_ID_LIST_SINGLE(task_struct_btf_ids, struct, task_struct);
>>
>>   static bool set_arg_maybe_null(const char *op, int arg_n, int off, int size,
>>                                 enum bpf_access_type type,
>> @@ -5395,7 +5395,7 @@ static bool set_arg_maybe_null(const char *op, int arg_n, int off, int size,
>>                   */
>>                  info->reg_type = PTR_MAYBE_NULL | PTR_TO_BTF_ID | PTR_TRUSTED;
>>                  info->btf = btf_vmlinux;
>> -               info->btf_id = task_struct_type_id;
>> +               info->btf_id = task_struct_btf_ids[0];
>>
>>                  return true;
>>          }
>> @@ -5547,13 +5547,7 @@ static void bpf_scx_unreg(void *kdata, struct bpf_link *link)
>>
>>   static int bpf_scx_init(struct btf *btf)
>>   {
>> -       s32 type_id;
>> -
>> -       type_id = btf_find_by_name_kind(btf, "task_struct", BTF_KIND_STRUCT);
>> -       if (type_id < 0)
>> -               return -EINVAL;
>> -       task_struct_type = btf_type_by_id(btf, type_id);
>> -       task_struct_type_id = type_id;
>> +       task_struct_type = btf_type_by_id(btf, task_struct_btf_ids[0]);
> 
> Good optimization, but it's also unnecessary.
> 
> btf_id is already in btf_tracing_ids[BTF_TRACING_TYPE_TASK].

Get it. Thanks!

BTW, do you think we should add a zero check for 
btf_tracing_ids[BTF_TRACING_TYPE_TASK] here?
task_struct should always be valid. If something wrong, resolve_btfids will also 
throw a warning. I'm not sure whether to add a sanity check here.

