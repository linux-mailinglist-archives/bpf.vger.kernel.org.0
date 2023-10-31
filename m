Return-Path: <bpf+bounces-13653-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F70C7DC469
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 03:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E0E01C20BEF
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 02:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94966469F;
	Tue, 31 Oct 2023 02:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="X00x0lAv"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59572ED3
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 02:28:18 +0000 (UTC)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E568FE6
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 19:28:16 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1cc5b6d6228so9497035ad.2
        for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 19:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698719296; x=1699324096; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gsSU3nf3CwyBe16APP7mb6wThVF+fgrIgWcl848naoU=;
        b=X00x0lAvYhqV/R1N3HX6Dyzz8t0pewHQWcKkvCpBxT0e7jhNIXfCXkJmx8Xhx39M0N
         5Uu63N16iqKgniEUDdP/xykpj3DlUEl+ZAH19uACnNI5n4W32vFn9EjHUZv/1fF3gvJk
         +j0t7+Gp2sll6Wz2UUt2oCN5rEBhZanL3dCwaEUjOKJGAksoUEynY5aq3k4bT/lhdrnE
         skfj40G29qyMUnXJIdil23kH5rzC/7JBPKNAJEyGEAZxPXXUGQyf69dZ5mqeCCljQ4r8
         Rxfe6HGV9zzIVHsRiWVk/Z3SN9BIsdSkvhckyiIWUaWKr4EjW2Lksq9AF/YReFQDr3Xp
         o8/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698719296; x=1699324096;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gsSU3nf3CwyBe16APP7mb6wThVF+fgrIgWcl848naoU=;
        b=VIFViki0X53y/1U9N4zjI/pfZYDN+7DSAke8TJWe+qJxoZm14rhTkB2bsdm2frGcb9
         5DGmBCTuOvk5eCiTLJvOb3TNrP42XTy/uXSJ8rre4B58kHcr2Wc4fnUrww8iif6X4DBY
         ivJ3GYqJCyUgklV7MHJK8pWc01muRKapT3o1sJJGAX+wG884l4uU6CWSDXQgFOtRmAkO
         Fm10aTdwHvMnGtywWkKD6KnW7eNXIKp8rXE9d63fLk/sI/zFwXIfWlyr71ZlWcsnOmBi
         99b9QToe1Lmh1kfTV3RHJXgZgBVK75KdXn/nemg6441oPMs3Ii8tuegumIhAiVKcAqW5
         Dx5A==
X-Gm-Message-State: AOJu0YyWZIxQKjSeBKPUB9mALW/U9zLP6Bk7Kmp45riEg3RWooyYvdId
	pN5jB+s/XE0luIA46zZPFnbEMA==
X-Google-Smtp-Source: AGHT+IH6GTqzd7TAQGRDVepZfUKN/mGy2SAqdZM0GyClRs0jLAJoSYu1Pge5RrXBIeQkhveXa5SBnQ==
X-Received: by 2002:a17:902:db0f:b0:1cc:5ef7:e3dd with SMTP id m15-20020a170902db0f00b001cc5ef7e3ddmr2439200plx.47.1698719296268;
        Mon, 30 Oct 2023 19:28:16 -0700 (PDT)
Received: from [10.254.164.31] ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id h5-20020a170902f7c500b001c3f7fd1ef7sm183128plw.12.2023.10.30.19.28.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 19:28:15 -0700 (PDT)
Message-ID: <80aa5e7c-13ad-49c1-9350-4982353cfe78@bytedance.com>
Date: Tue, 31 Oct 2023 10:28:10 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 3/3] selftests/bpf: Add test for using
 css_task iter in sleepable progs
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org
References: <20231025075914.30979-1-zhouchuyi@bytedance.com>
 <20231025075914.30979-4-zhouchuyi@bytedance.com>
 <c361ad7b-9c82-4ec2-ad39-86bdcdf9bd60@linux.dev>
From: Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <c361ad7b-9c82-4ec2-ad39-86bdcdf9bd60@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

在 2023/10/31 08:20, Yonghong Song 写道:
> 
> On 10/25/23 12:59 AM, Chuyi Zhou wrote:
>> This Patch add a test to prove css_task iter can be used in normal
>> sleepable progs.
>>
>> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
>> ---
>>   .../selftests/bpf/progs/iters_task_failure.c  | 19 +++++++++++++++++++
>>   1 file changed, 19 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/progs/iters_task_failure.c 
>> b/tools/testing/selftests/bpf/progs/iters_task_failure.c
>> index 6b1588d70652..fe0b19e545d0 100644
>> --- a/tools/testing/selftests/bpf/progs/iters_task_failure.c
>> +++ b/tools/testing/selftests/bpf/progs/iters_task_failure.c
>> @@ -103,3 +103,22 @@ int BPF_PROG(iter_css_task_for_each)
>>       bpf_cgroup_release(cgrp);
>>       return 0;
>>   }
>> +
>> +SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
>> +int BPF_PROG(iter_css_task_for_each_sleep)
>> +{
>> +    u64 cg_id = bpf_get_current_cgroup_id();
>> +    struct cgroup *cgrp = bpf_cgroup_from_id(cg_id);
>> +    struct cgroup_subsys_state *css;
>> +    struct task_struct *task;
>> +
>> +    if (cgrp == NULL)
>> +        return 0;
>> +    css = &cgrp->self;
>> +
>> +    bpf_for_each(css_task, task, css, CSS_TASK_ITER_PROCS) {
>> +
>> +    }
>> +    bpf_cgroup_release(cgrp);
>> +    return 0;
>> +}
> 
> Could you move this prog toiters_css_task.c and add a subtest in 
> cgroup_iter.c? The file iters_task_failure.c intends for negative tests. 
> This prog succeeds with loading.
> 

Thanks for the review. I will change in next version.

But do we need a extra subtest like subtest_css_task_iters() in iters.c 
or just use RUN_TESTS(iters_css_task) to prove it can be loaded?

If we do need a extra subtest, maybe we can reuse 
subtest_css_task_iters() in iters.c? cgroup_iter.c is used to test 
SEC("iter/cgroup") and iters.c is used to test open-coded iters.

We can let this prog outo-loaded, and use 'syscall(SYS_getpgid)' after 
'stack_mprotect()' to trigger the prog.

static void subtest_css_task_iters(void)
{
	...
	err = stack_mprotect();
	syscall(SYS_getpgid);
	if (!ASSERT_EQ(err, -1, "stack_mprotect") ||
	    !ASSERT_EQ(errno, EPERM, "stack_mprotect"))
		goto cleanup;
	iters_css_task__detach(skel);
	ASSERT_EQ(skel->bss->css_task_cnt_in_lsm, 1, "css_task_cnt_in_lsm");
	ASSERT_EQ(skel->bss->css_task_cnt_in_sleep, 1, "css_task_cnt_in_sleep");
	...
}

What do you think?

Thanks.




