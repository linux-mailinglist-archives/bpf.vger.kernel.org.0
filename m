Return-Path: <bpf+bounces-9857-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EDE79DF47
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 06:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91E181C20DCA
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 04:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BAF443A;
	Wed, 13 Sep 2023 04:57:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7135B2566
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 04:57:03 +0000 (UTC)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CA8173C
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 21:57:03 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-53fa455cd94so4614491a12.2
        for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 21:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694581022; x=1695185822; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jUuT6xhrpskEbCzNwuseee5gbPTwHN5TLgP+3rePu4A=;
        b=OYwhRxFuUjVxZfcHZ7wgGCoQdIUN6L4GmpZ/ndjFKwo6oml/cofDN4bl2DlhmPoM6Y
         djSigpzXOR9epFla3Mb7nFkmPU321XdAZWzp791ib1Or5Jg5XWb/rvOiFY/37L7cbrve
         BUyYLR8H7p5Dc+00fO/0rbAKHkjx4SNDj+qFjw6gPUEQUsxHJsHFRpYsHe0GKf4LiAlf
         wSafCTEf+bxf+2M6f/wK6INowxkMw6jwTvqBHQbeX4UO/lodcW1840bLjYuDsv4hRj5O
         WSMe2JtI/su14tL1M9AryR0zbf5qTI8zAHVq5t7K2U0qYroRVIIUKwQUDZLtalV8InWR
         PnAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694581022; x=1695185822;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jUuT6xhrpskEbCzNwuseee5gbPTwHN5TLgP+3rePu4A=;
        b=u98oUsoIqfK1C+nBvu1ASt/Fvftii+U70P1ku3hIhxK2jU1zfs2OPhs4ALBpmccjhI
         wojjaBS2Nggg8U9+tTwyZ0st+FGgtoqA0sATBTcFCo20BZ0Si0avqmWjKmVK7eGIsCJV
         /W+iuvGAvXSMcX1gKZJBAQfMV6v2/mcHDOT7x93dpq+ur5LFpGtYKJxBwvg9IUfVAvlo
         14iOi4htX3pCRiW4+VMUsXy4Bg40Ga6t4RnrcbAcZO7T1GUz9O56DQeIC4Yt7IUxCe+Q
         i1SrY/QSRy1SAgl1Xa7gImdOFcjMnnkThvKIz9v3STQkdWGzikIDFbwfyuwR2YUHEnmb
         vzGw==
X-Gm-Message-State: AOJu0YygZ+B7AohrkuhZRhkuUkZB7D2EF1YPmD/w7h2zBKsMTLJkE3+v
	gxJekL6f3EQMQiqhdcdPX3y3pw==
X-Google-Smtp-Source: AGHT+IEBec3QFxac/FCTbUrO0hwTGE1AiPM5bwc+ak1kXddh13Nhapx5BBORG5ZLIDtUcmXbPQmexA==
X-Received: by 2002:a17:90a:b297:b0:269:3cdb:4edf with SMTP id c23-20020a17090ab29700b002693cdb4edfmr1184930pjr.16.1694581022410;
        Tue, 12 Sep 2023 21:57:02 -0700 (PDT)
Received: from [10.84.145.144] ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id fv23-20020a17090b0e9700b0026d6ad176c6sm2182802pjb.0.2023.09.12.21.56.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 21:57:02 -0700 (PDT)
Message-ID: <88825625-283a-d521-3e7e-058784455577@bytedance.com>
Date: Wed, 13 Sep 2023 12:56:55 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH bpf-next v2 2/6] bpf: Introduce css_task open-coded
 iterator kfuncs
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org, tj@kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20230912070149.969939-1-zhouchuyi@bytedance.com>
 <20230912070149.969939-3-zhouchuyi@bytedance.com>
 <8b272d63-5dd7-13bd-7691-d061895fdbe1@linux.dev>
From: Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <8b272d63-5dd7-13bd-7691-d061895fdbe1@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Martin.

在 2023/9/13 03:57, Martin KaFai Lau 写道:
> On 9/12/23 12:01 AM, Chuyi Zhou wrote:
>> +__bpf_kfunc int bpf_iter_css_task_new(struct bpf_iter_css_task *it,
>> +        struct cgroup_subsys_state *css, unsigned int flags)
>> +{
>> +    struct bpf_iter_css_task_kern *kit = (void *)it;
>> +
>> +    BUILD_BUG_ON(sizeof(struct bpf_iter_css_task_kern) != 
>> sizeof(struct bpf_iter_css_task));
>> +    BUILD_BUG_ON(__alignof__(struct bpf_iter_css_task_kern) !=
>> +                    __alignof__(struct bpf_iter_css_task));
>> +
>> +    switch (flags) {
>> +    case CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED:
>> +    case CSS_TASK_ITER_PROCS:
>> +    case 0:
>> +        break;
>> +    default:
>> +        return -EINVAL;
>> +    }
>> +
>> +    kit->css_it = kzalloc(sizeof(struct css_task_iter), GFP_KERNEL);
>> +    if (!kit->css_it)
>> +        return -ENOMEM;
>> +    css_task_iter_start(css, flags, kit->css_it);
>> +    return 0;
>> +}
>> +
> 
>> +static bool check_css_task_iter_allowlist(struct bpf_verifier_env *env)
>> +{
>> +    enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
>> +
>> +    switch (prog_type) {
>> +    case BPF_PROG_TYPE_LSM:
> 
> This will allow the non-sleepable lsm prog to call 
> bpf_iter_css_task_new. The above kzalloc(GFP_KERNEL) in 
> bpf_iter_css_task_new should trigger a lockdep error in the lsm selftest 
> in patch 6.

Thanks for your test. I missed the dmesg error since I did not set 
CONFIG_LOCKDEP.

I think here we can use kzalloc(GFP_ATOMIC) to eliminate this error if 
we want to use this iter in non-sleepable lsm prog. I just tested, it 
works well.

> 
>> +        return true;
>> +    case BPF_TRACE_ITER:
>> +        return env->prog->aux->sleepable;
>> +    default:
>> +        return false;
>> +    }
>> +}
> 

