Return-Path: <bpf+bounces-8718-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 034697891F9
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 00:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0E042818AE
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 22:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE7518B1B;
	Fri, 25 Aug 2023 22:52:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4D01C02
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 22:52:13 +0000 (UTC)
Received: from out-253.mta1.migadu.com (out-253.mta1.migadu.com [95.215.58.253])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FD3268F
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 15:52:11 -0700 (PDT)
Message-ID: <e254a6db-66eb-8bfc-561f-464327a1005a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1693003930; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oDACEyhLY5VaJttMj8jtwadbBBMJBdF6mgbDTPYbnVE=;
	b=Cc8qJ4a2yv5pEZsrTAph9YdjObWppAt3B3k9vkL0Wky5f6/4kTZAz272ec4JbxDnOs/WRE
	IV9OLPNTpFasGPYSt0wMj1gZ/waNj+C+t8verTtFliV1eNqKLRqmXhldZD25LO5Afl8Bvd
	9wR8S2/YkEFKc9+G4ZpOwNi52JXt/lQ=
Date: Fri, 25 Aug 2023 15:52:02 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH 3/6] bpf: task_group_seq_get_next: fix the
 skip_if_dup_files check
Content-Language: en-US
To: Oleg Nesterov <oleg@redhat.com>, Andrew Morton
 <akpm@linux-foundation.org>, Yonghong Song <yhs@fb.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Kui-Feng Lee <kuifeng@fb.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230825161842.GA16750@redhat.com>
 <20230825161947.GA16871@redhat.com> <20230825170406.GA16800@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230825170406.GA16800@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/25/23 10:04 AM, Oleg Nesterov wrote:
> Forgot to mention in the changelog...
> 
> In any case this doesn't look right. ->group_leader can exit before other
> threads, call exit_files(), and in this case task_group_seq_get_next() will
> check task->files == NULL.

It is okay. This won't be affecting correctness. We will end with
calling bpf program for 'next_task'.

> 
> On 08/25, Oleg Nesterov wrote:
>>
>> Unless I am notally confused it is wrong. We are going to return or
>> skip next_task so we need to check next_task-files, not task->files.
>>
>> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
>> ---
>>   kernel/bpf/task_iter.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
>> index 1589ec3faded..2264870ae3fc 100644
>> --- a/kernel/bpf/task_iter.c
>> +++ b/kernel/bpf/task_iter.c
>> @@ -82,7 +82,7 @@ static struct task_struct *task_group_seq_get_next(struct bpf_iter_seq_task_comm
>>
>>   	common->pid_visiting = *tid;
>>
>> -	if (skip_if_dup_files && task->files == task->group_leader->files) {
>> +	if (skip_if_dup_files && next_task->files == next_task->group_leader->files) {
>>   		task = next_task;
>>   		goto retry;
>>   	}
>> --
>> 2.25.1.362.g51ebf55
> 
> 

