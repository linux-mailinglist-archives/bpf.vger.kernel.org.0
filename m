Return-Path: <bpf+bounces-51206-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC46CA31DFF
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 06:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 878BF7A321E
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 05:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F351F470E;
	Wed, 12 Feb 2025 05:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dexJAmPc"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED42B67E
	for <bpf@vger.kernel.org>; Wed, 12 Feb 2025 05:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739338554; cv=none; b=STZy+KHzEGDHchkHhKMJUboTiw2D8JHZ0ZrHdtVcCen74b/cQtznjCtXRbBuZzQoE7pjcexrcfUki5Y+bZ6dtbkFI+FXvEqcdmRkcD48Vtz+W5iEu+BL94z5AOBMxKAGCMr93/TeIBzThZnJXSlOblCSUf+blSvOKwzc9EwqMD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739338554; c=relaxed/simple;
	bh=7E+7Z3NsHGX6cghxmofGKJOzGrsUllPpziXjt9wybiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=izzu3yT3qciqbCxfRIef8dSf3hhfkxRmQpTpBMd4HQSvWBk2OELhmXus4S1XMZBAN69QfnjXcZ1Bx1r56PwNZKkhQ81BRJZAY4Iz1wK5DpVMQ8fM+jruU8iwMhv8kKfiyiWE+SWictN+wApH8Qrgt75u1WGj7y/5BvOY2GSM84w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dexJAmPc; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e5b049d9-630d-44cf-bb7b-180faf5080f8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739338549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KDcNXpwqtHt70y6qnvtr2z2oLnLuYPSTSkl0LmcHIZI=;
	b=dexJAmPc6D+wzx0aPybn7sbOFe6JSpkQOkTFBydLJ+D61lQrNF0GSnNHJvkzcMEMtj+40E
	iHwPhmcHHx0hObU2DLgMNAglEL+8LiZbHi7M7AucO7fSXz2HM9hUpIeFZUnTwS5WAaQJoz
	SHi5zJG15jPf3xQqqbTNio+B/PQlmw8=
Date: Tue, 11 Feb 2025 21:35:33 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] bpf: Allow top down cgroup prog ordering
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20250206225956.3740809-1-yonghong.song@linux.dev>
 <CAEf4BzY2F33FT2pDO8Zy1_zuQJVbwSS4OoMbBsEcyBVDTaKSeg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4BzY2F33FT2pDO8Zy1_zuQJVbwSS4OoMbBsEcyBVDTaKSeg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2/11/25 2:57 PM, Andrii Nakryiko wrote:
> On Thu, Feb 6, 2025 at 3:00 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>> Currently for bpf progs in a cgroup hierarchy, the effective prog array
>> is computed from bottom cgroup to upper cgroups. For example, the following
>> cgroup hierarchy
>>      root cgroup: p1, p2
>>          subcgroup: p3, p4
>> have BPF_F_ALLOW_MULTI for both cgroup levels.
>> The effective cgroup array ordering looks like
>>      p3 p4 p1 p2
>> and at run time, the progs will execute based on that order.
>>
>> But in some cases, it is desirable to have root prog executes earlier than
>> children progs. For example,
>>    - prog p1 intends to collect original pkt dest addresses.
>>    - prog p3 will modify original pkt dest addresses to a proxy address for
>>      security reason.
>> The end result is that prog p1 gets proxy address which is not what it
>> wants. Also, putting p1 to every child cgroup is not desirable either as it
>> will duplicate itself in many child cgroups. And this is exactly a use case
>> we are encountering in Meta.
>>
>> To fix this issue, let us introduce a flag BPF_F_PRIO_TOPDOWN. If the flag
>> is specified at attachment time, the prog has higher priority and the
>> ordering with that flag will be from top to bottom. For example, in the
>> above example,
>>      root cgroup: p1, p2
>>          subcgroup: p3, p4
>> Let us say p1, p2 and p4 are marked with BPF_F_PRIO_TOPDOWN. The final
> I'm not a big fan of PRIO_TOPDOWN naming, and this example just
> provides further argument for why. Between p3 and p4 programs in
> subcgroup, there is no notion of TOPDOWN, they are at the same level
> of the hierarchy.
>
> In graphs, for DFS, PRIO_TOPDOWN semantics corresponds to pre-order vs
> (current and default) post-order. So why not something like
> BPF_F_PREORDER or some variation on that?

BPF_F_PREORDER sounds good to me.

>
> Also, for your example if would be nicer if p1 and p3 were the default
> post-order attachment, while p2 and p4 were pre-order. Then you'd have
> p2, p4, p3, p1, where everything is swapped relative to original
> ordering ;)

Yes, will adjust the test for such scenario!

>
>> effective array ordering will be
>>      p1 p2 p4 p3
>>
>> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   include/linux/bpf-cgroup.h     |  1 +
>>   include/uapi/linux/bpf.h       |  1 +
>>   kernel/bpf/cgroup.c            | 37 +++++++++++++++++++++++++++++++---
>>   kernel/bpf/syscall.c           |  3 ++-
>>   tools/include/uapi/linux/bpf.h |  1 +
>>   5 files changed, 39 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
>> index 7fc69083e745..3d4f221df9ef 100644
>> --- a/include/linux/bpf-cgroup.h
>> +++ b/include/linux/bpf-cgroup.h
>> @@ -111,6 +111,7 @@ struct bpf_prog_list {
>>          struct bpf_prog *prog;
>>          struct bpf_cgroup_link *link;
>>          struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE];
>> +       bool is_prio_topdown;
> let's go with `int flags`, we increase the size of struct
> bpf_prog_list by 8 bytes anyways, so let's make this a bit more
> generic?

Ack.

>
>>   };
>>
>>   int cgroup_bpf_inherit(struct cgroup *cgrp);
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index fff6cdb8d11a..7ae8e8751e78 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -1207,6 +1207,7 @@ enum bpf_perf_event_type {
>>   #define BPF_F_BEFORE           (1U << 3)
>>   #define BPF_F_AFTER            (1U << 4)
>>   #define BPF_F_ID               (1U << 5)
>> +#define BPF_F_PRIO_TOPDOWN     (1U << 6)
>>   #define BPF_F_LINK             BPF_F_LINK /* 1 << 13 */
>>
>>   /* If BPF_F_STRICT_ALIGNMENT is used in BPF_PROG_LOAD command, the
>> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
>> index 46e5db65dbc8..f31250c6025b 100644
>> --- a/kernel/bpf/cgroup.c
>> +++ b/kernel/bpf/cgroup.c
>> @@ -382,6 +382,21 @@ static u32 prog_list_length(struct hlist_head *head)
>>          return cnt;
>>   }
>>
>> +static u32 prog_list_length_with_topdown_cnt(struct hlist_head *head, int *topdown_cnt)
> instead of duplicating prog_list_length(), let's add this `int
> *topdown_cnt` counter as an optional argument, which prog_list_length
> will fill out only if it's provided, i.e., you'll just have:
>
> if (topdown_cnt && pl->is_prio_topdown)
>     (*topdown_cnt) += 1;
>
> as one extra condition inside the loop?

I thought about this as well. I tried to create a new function since
prog_list_length() is used in several different places. This
is not critical path, so yes, I can just add one addititional parameter
for prog_list_length() as you suggested.

>
>> +{
>> +       struct bpf_prog_list *pl;
>> +       u32 cnt = 0;
>> +
>> +       hlist_for_each_entry(pl, head, node) {
>> +               if (!prog_list_prog(pl))
>> +                       continue;
>> +               cnt++;
>> +               if (pl->is_prio_topdown)
>> +                       (*topdown_cnt) += 1;
>> +       }
>> +       return cnt;
>> +}
>> +


