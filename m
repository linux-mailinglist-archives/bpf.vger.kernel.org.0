Return-Path: <bpf+bounces-44132-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1459BF1F6
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 16:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF1EE1F23797
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 15:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A642036F7;
	Wed,  6 Nov 2024 15:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rO2Hmn/s"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA7C18FDD0
	for <bpf@vger.kernel.org>; Wed,  6 Nov 2024 15:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730907889; cv=none; b=b2UFAhv83HRj0yRF350eVJ9zGhbtjcDGc1UqR+Qo5Gm+AU46gWgdC6tarC9h/uQUZoaGLqAylKiarnfRBkBNJoAdVG8jcftJkdYgm6Yc6pYFJYpDYiswwvUd+axsrHCyVYs5+lNEeZ3m9HvxRWFEhEYVuQ2vJai5A9On4tQx/TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730907889; c=relaxed/simple;
	bh=bDx1pp499gD/S0SpfF8Zki5Ep7HKyhZlh4E6BZbwLgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m2n3Xl1DM8ZgRPo1wGVRKq0xHaXD/5FNw9rO6cfLT+3BXHl3+Uaqaqm5u18U6nQeX7mLXuXSTxJ+pEQ+qzjoqGPq6Db+E3sRtvtNb9Kp6qUOkyS0TmsYOSKgCCz3ZQsgJqd+0kANgzsG62qPtzO3A+ThRdhA2UN9wqf24gXHyi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rO2Hmn/s; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ed672521-ced2-473d-868c-21f927aa4c15@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730907884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TPm6BTzQsTgqqcw/eRtXiWul18ActW/ivUSsrMYHG38=;
	b=rO2Hmn/sXrtoOthJxX6AXy+h/C1dU/oK5a79BkCbHHUQX75f3fbTwpxG+q7tWXNpX03ZTd
	lACeSvHS7T9Wy1SfUPo5GYEk06yJMgrFNvX42DuqyQ2yPKFVrtvkztJuakaPkNEGH7OnZB
	vlfXouygkOyuPrbBbSFDEUTvRtOkjrI=
Date: Wed, 6 Nov 2024 07:44:37 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v9 04/10] bpf: Check potential private stack
 recursion for progs with async callback
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>,
 Tejun Heo <tj@kernel.org>
References: <20241104193455.3241859-1-yonghong.song@linux.dev>
 <20241104193515.3243315-1-yonghong.song@linux.dev>
 <CAADnVQL3MkDgZykq1H3NhJio8gZDnf3+kXXw7AQ36uT8yw5UfQ@mail.gmail.com>
 <a34f5be8-8cf9-4659-badd-32c387cefe29@linux.dev>
 <CAADnVQJzV_eRaNMzYP5Fj-FsSNx7-1-f0yXjtXSpeOqr9tBVAg@mail.gmail.com>
 <c00685dc-c51b-4058-8373-93b01443143d@linux.dev>
 <CAADnVQ+PsQpo-aFhUJhUaOSJSPX7A9ffmTVFtc96xLLCrtSBsg@mail.gmail.com>
 <a95f0953-1901-471f-8313-dac03efef9e2@linux.dev>
 <CAADnVQ+ohxtXEc8WufQoJQByRFMSD9427X_dsKWQFBv9dGzveA@mail.gmail.com>
 <97aa51b0-5c12-4f5b-bd35-5abfcee9a715@linux.dev>
 <CAADnVQJN7O_EGAArH_DpcLgGzZZOe21_MKVOFCi_OaBHbt8r4g@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQJN7O_EGAArH_DpcLgGzZZOe21_MKVOFCi_OaBHbt8r4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT




On 11/6/24 7:26 AM, Alexei Starovoitov wrote:
> On Tue, Nov 5, 2024 at 10:55 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>>
>>
>> On 11/5/24 5:07 PM, Alexei Starovoitov wrote:
>>> On Tue, Nov 5, 2024 at 4:19 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>>>
>>>>
>>>> On 11/5/24 1:52 PM, Alexei Starovoitov wrote:
>>>>> On Tue, Nov 5, 2024 at 1:26 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>>>>>> I see. I think it works, but feels complicated.
>>>>>>> It feels it should be possible to do without extra flags. Like
>>>>>>> check_max_stack_depth_subprog() will know whether it was called
>>>>>>> to verify async_cb or not.
>>>>>>> So it's just a matter of adding single 'if' to it:
>>>>>>> if (subprog[idx].use_priv_stack && checking_async_cb)
>>>>>>>        /* reset to false due to potential recursion */
>>>>>>>        subprog[idx].use_priv_stack = false;
>>>>>>>
>>>>>>> check_max_stack_depth() starts with i==0,
>>>>>>> so reachable and eligible subprogs will be marked with use_priv_stack.
>>>>>>> Then check_max_stack_depth_subprog() will be called again
>>>>>>> to verify async. If it sees the mark it's a bad case.
>>>>>>> what am I missing?
>>>>>> First I think we still want to mark some subprogs in async tree
>>>>>> to use private stack, right? If this is the case, then let us see
>>>>>> the following examle:
>>>>>>
>>>>>> main_prog:
>>>>>>        sub1: use_priv_stack = true
>>>>>>        sub2" use_priv_stack = true
>>>>>>
>>>>>> async: /* calling sub1 twice */
>>>>>>        sub1
>>>>>>          <=== we do
>>>>>>                 if (subprog[idx].use_priv_stack && checking_async_cb)
>>>>>>                     subprog[idx].use_priv_stack = false;
>>>>>>        sub1
>>>>>>          <=== here we have subprog[idx].use_priv_stack = false;
>>>>>>               we could mark use_priv_stack = true again here
>>>>>>               since logic didn't keep track of sub1 has been
>>>>>>               visited before.
>>>>> This case needs a sticky state to solve.
>>>>> Instead of bool use_priv_stack it can be tri-state:
>>>>> no_priv_stack
>>>>> priv_stack_unknown <- start state
>>>>> priv_stack_maybe
>>>>>
>>>>> main_prog pass will set it to priv_stack_maybe
>>>>> while async pass will clear it to no_priv_stack
>>>>> and it cannot be bumped up.
>>>> The tri-state may not work. For example,
>>>>
>>>> main_prog:
>>>>       call sub1
>>>>       call sub2
>>>>       call sub1
>>> sub1 cannot be called nested like this.
>>> I think we discussed it already.
>>>
>>>>       call sub3
>>>>
>>>> async:
>>>>       call sub4 ==> UNKNOWN -> MAYBE
>>>>       call sub3
>>>>       call sub4 ==> MAYBE -> NO_PRIV_STACK?
>>>>
>>>> For sub4 in async which is called twice, for the second sub4 call,
>>>> it is not clear whether UNKNOWN->MAYBE transition happens in
>>>> main_prog or async. So based on transition prototol,
>>>> second sub4 call will transition to NO_PRIV_STACK which is not
>>>> what we want.
>>> I see. Good point.
>>>
>>>> So I think we still need a separate bit in bpf_subprog_info to
>>>> accumulate information for main_prog tree or any async tree.
>>> This is getting quite convoluted. To support priv stack
>>> in multiple async cb-s we may need to remember async cb id or something.
>>> I say let's force all subprogs in async cb to use normal stack.
>> I did a quick prototype. Among others, tri-state (UNKNOWN, NO, ADAPTIVE)
>> and reverse traversing subprogs like below diff --git
>> a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c index
>> cb82254484ff..1084432dbe83 100644 --- a/kernel/bpf/verifier.c +++
>> b/kernel/bpf/verifier.c @@ -6192,7 +6192,7 @@ static int
>> check_max_stack_depth(struct bpf_verifier_env *env) struct
>> bpf_subprog_info *si = env->subprog_info; int ret; - for (int i = 0; i <
>> env->subprog_cnt; i++) { + for (int i = env->subprog_cnt - 1; i >= 0;
>> i--) { if (i && !si[i].is_async_cb) continue; works correctly.
>> Basically, all async_cb touched subprogs are marked as 'NO'. Finally for
>> main prog tree, UNKNOWN subprog will convert to ADAPTIVE if >= stack
>> size threshold. Stack size checking can also be done properly for
>> async_cb tree and main prog tree.
> Your emailer still spits out garbage :(

Somehow recently, my thunderbird mailer may change text/width setting
depending on the original format. Unless I explicitly set the format
again. Sometimes it will use a 'Variable width' which will glue everything in
one paragraph. I am trying to find a solution now to fix the mailer.

> but I think I got the idea. Will wait for respin.

Will do.


