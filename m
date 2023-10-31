Return-Path: <bpf+bounces-13657-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B927DC497
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 03:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E116C1C20BD5
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 02:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E16615CF;
	Tue, 31 Oct 2023 02:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ar12/ZyI"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BE5EC6
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 02:41:26 +0000 (UTC)
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21059F
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 19:41:23 -0700 (PDT)
Message-ID: <36a54be9-a1c8-462c-9a83-41d848944a41@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1698720082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HtwCQTCfwzQiSAcXl1bFsRgcx+MmhOeywrgtb0p/8eE=;
	b=ar12/ZyICYRJwjgXH/xHbki5R7rOb1h9uNhY3lDWvSzq+hVjMc4bvH1kbUu7nB8ojTCsU1
	2Z7U3afF0l7VMDAOT+ac/bgfbqG8xXBv5lWbL5+PfPAAH1AHpILtrWcAFltKfHzxZaEC9z
	dWjQr2XtFQdj21sHlfuMpzLASNRhC/I=
Date: Mon, 30 Oct 2023 19:41:15 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 3/3] selftests/bpf: Add test for using
 css_task iter in sleepable progs
Content-Language: en-GB
To: Chuyi Zhou <zhouchuyi@bytedance.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org
References: <20231025075914.30979-1-zhouchuyi@bytedance.com>
 <20231025075914.30979-4-zhouchuyi@bytedance.com>
 <c361ad7b-9c82-4ec2-ad39-86bdcdf9bd60@linux.dev>
 <80aa5e7c-13ad-49c1-9350-4982353cfe78@bytedance.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <80aa5e7c-13ad-49c1-9350-4982353cfe78@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 10/30/23 7:28 PM, Chuyi Zhou wrote:
> Hello,
>
> 在 2023/10/31 08:20, Yonghong Song 写道:
>>
>> On 10/25/23 12:59 AM, Chuyi Zhou wrote:
>>> This Patch add a test to prove css_task iter can be used in normal
>>> sleepable progs.
>>>
>>> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
>>> ---
>>>   .../selftests/bpf/progs/iters_task_failure.c  | 19 
>>> +++++++++++++++++++
>>>   1 file changed, 19 insertions(+)
>>>
>>> diff --git a/tools/testing/selftests/bpf/progs/iters_task_failure.c 
>>> b/tools/testing/selftests/bpf/progs/iters_task_failure.c
>>> index 6b1588d70652..fe0b19e545d0 100644
>>> --- a/tools/testing/selftests/bpf/progs/iters_task_failure.c
>>> +++ b/tools/testing/selftests/bpf/progs/iters_task_failure.c
>>> @@ -103,3 +103,22 @@ int BPF_PROG(iter_css_task_for_each)
>>>       bpf_cgroup_release(cgrp);
>>>       return 0;
>>>   }
>>> +
>>> +SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
>>> +int BPF_PROG(iter_css_task_for_each_sleep)
>>> +{
>>> +    u64 cg_id = bpf_get_current_cgroup_id();
>>> +    struct cgroup *cgrp = bpf_cgroup_from_id(cg_id);
>>> +    struct cgroup_subsys_state *css;
>>> +    struct task_struct *task;
>>> +
>>> +    if (cgrp == NULL)
>>> +        return 0;
>>> +    css = &cgrp->self;
>>> +
>>> +    bpf_for_each(css_task, task, css, CSS_TASK_ITER_PROCS) {
>>> +
>>> +    }
>>> +    bpf_cgroup_release(cgrp);
>>> +    return 0;
>>> +}
>>
>> Could you move this prog toiters_css_task.c and add a subtest in 
>> cgroup_iter.c? The file iters_task_failure.c intends for negative 
>> tests. This prog succeeds with loading.
>>
>
> Thanks for the review. I will change in next version.
>
> But do we need a extra subtest like subtest_css_task_iters() in 
> iters.c or just use RUN_TESTS(iters_css_task) to prove it can be loaded?

Yes, you can do RUN_TESTS. We only need to confirm verification success.


>
> If we do need a extra subtest, maybe we can reuse 
> subtest_css_task_iters() in iters.c? cgroup_iter.c is used to test 
> SEC("iter/cgroup") and iters.c is used to test open-coded iters.
>
> We can let this prog outo-loaded, and use 'syscall(SYS_getpgid)' after 
> 'stack_mprotect()' to trigger the prog.
>
> static void subtest_css_task_iters(void)
> {
>     ...
>     err = stack_mprotect();
>     syscall(SYS_getpgid);
>     if (!ASSERT_EQ(err, -1, "stack_mprotect") ||
>         !ASSERT_EQ(errno, EPERM, "stack_mprotect"))
>         goto cleanup;
>     iters_css_task__detach(skel);
>     ASSERT_EQ(skel->bss->css_task_cnt_in_lsm, 1, "css_task_cnt_in_lsm");
>     ASSERT_EQ(skel->bss->css_task_cnt_in_sleep, 1, 
> "css_task_cnt_in_sleep");
>     ...
> }
>
> What do you think?
>
> Thanks.
>
>
>

