Return-Path: <bpf+bounces-9331-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 651BF793CCF
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 14:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C386281565
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 12:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63DBDDCD;
	Wed,  6 Sep 2023 12:38:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EB410FC
	for <bpf@vger.kernel.org>; Wed,  6 Sep 2023 12:38:11 +0000 (UTC)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57295171D
	for <bpf@vger.kernel.org>; Wed,  6 Sep 2023 05:37:58 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-573fa7c19c7so290982a12.1
        for <bpf@vger.kernel.org>; Wed, 06 Sep 2023 05:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694003878; x=1694608678; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J0bKcsUZrDLfGK82pb7CdvyyKC8wqtZ9yLfdwnJHBSQ=;
        b=g425VIT627FohsNj8JM83LVELJktmAD9on4EdLGJNQAkiW26X64XaQT6Z8PnTAB/kz
         m21QV+r6gojdGfCirqVssDhWK5TNPluYEjSTWeL3MA23pKomJuy1RYx99xGo1CU/28Ue
         dpZe3iv4UHOFi77BZxariktLWOvZTx5vfo6hGUOB3tflEZU3/iDGFjUMCtmxnuQoMZFu
         N0bH380jJS7Qhv6eQIzJBYGR73oI1ib5QsCECemx0Ns4Ue/dCo3eu64kvEYjWpWnrAJt
         71QMzE0h1HJ2dpyfK7XaZAOE7M9GH0eRABfjvWpiED2APvSTCim/MOpWwzXQ95rZkIvx
         f0wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694003878; x=1694608678;
        h=content-transfer-encoding:in-reply-to:references:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J0bKcsUZrDLfGK82pb7CdvyyKC8wqtZ9yLfdwnJHBSQ=;
        b=PypFfiIWF1dCK+ljoYXQYMVHnCA2yyu3AU8FVYqrUfW7F5Bz9TWGF1+qcdEJApdNHo
         cUbrVDilJLt/8lJ9Z+2JWVFydm98mI4VXrtnykLnq5cupFAYvap8Y+gD6Rq4ZKcf/1dJ
         dVX3ZZ3x+1vTbWi4TBH6Z2BPWEukko7ATGLx/4gHyTqk7YI65zOeaG9tEiFZ0L0mvVM5
         XIo5ct2GSmV/I7OHK0b6lKPrFXR9b6UojUze1aEuHW8KQerxIorYuf66pOLBxFE6JLik
         1M0yVn6xTuvlrsgWKcVSBBFRQUo+Tb12XPHw1Ic8Wklu9ley4WLYAhiT9+uvpogWWTEE
         FEAQ==
X-Gm-Message-State: AOJu0YxtzSOz9SKD37xXijbKMG1aAovAjNR1iKYh5gFxvEwwjl4qpInX
	gKGmDTSLyZobmqlNo72J94Wbew==
X-Google-Smtp-Source: AGHT+IGhX8cSPoKUgMI/duSqg60zplBgTNG7dvqSfAfLagdbivIrDQm13gTTkN0SrQzIMcdMyWvosA==
X-Received: by 2002:a17:90b:4a83:b0:26b:4e40:7be6 with SMTP id lp3-20020a17090b4a8300b0026b4e407be6mr20992741pjb.20.1694003877481;
        Wed, 06 Sep 2023 05:37:57 -0700 (PDT)
Received: from [10.84.145.144] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id jj4-20020a170903048400b001b531e8a000sm10994282plb.157.2023.09.06.05.37.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 05:37:57 -0700 (PDT)
Message-ID: <e5e986a0-0bb9-6611-77f0-f8472346965e@bytedance.com>
Date: Wed, 6 Sep 2023 20:37:53 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
From: Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: Re: [RFC PATCH bpf-next 2/4] bpf: Introduce process open coded
 iterator kfuncs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20230827072057.1591929-1-zhouchuyi@bytedance.com>
 <20230827072057.1591929-3-zhouchuyi@bytedance.com>
 <CAADnVQLKytNcAF_LkMgMJ1sq9Tv8QMNc3En7Psuxg+=FXP+B-A@mail.gmail.com>
In-Reply-To: <CAADnVQLKytNcAF_LkMgMJ1sq9Tv8QMNc3En7Psuxg+=FXP+B-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello, Alexei.

在 2023/9/6 04:09, Alexei Starovoitov 写道:
> On Sun, Aug 27, 2023 at 12:21 AM Chuyi Zhou <zhouchuyi@bytedance.com> wrote:
>>
>> This patch adds kfuncs bpf_iter_process_{new,next,destroy} which allow
>> creation and manipulation of struct bpf_iter_process in open-coded iterator
>> style. BPF programs can use these kfuncs or through bpf_for_each macro to
>> iterate all processes in the system.
>>
>> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
>> ---
>>   include/uapi/linux/bpf.h       |  4 ++++
>>   kernel/bpf/helpers.c           |  3 +++
>>   kernel/bpf/task_iter.c         | 31 +++++++++++++++++++++++++++++++
>>   tools/include/uapi/linux/bpf.h |  4 ++++
>>   tools/lib/bpf/bpf_helpers.h    |  5 +++++
>>   5 files changed, 47 insertions(+)
>>
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 2a6e9b99564b..cfbd527e3733 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -7199,4 +7199,8 @@ struct bpf_iter_css_task {
>>          __u64 __opaque[1];
>>   } __attribute__((aligned(8)));
>>
>> +struct bpf_iter_process {
>> +       __u64 __opaque[1];
>> +} __attribute__((aligned(8)));
>> +
>>   #endif /* _UAPI__LINUX_BPF_H__ */
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index cf113ad24837..81a2005edc26 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -2458,6 +2458,9 @@ BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_DESTROY)
>>   BTF_ID_FLAGS(func, bpf_iter_css_task_new, KF_ITER_NEW)
>>   BTF_ID_FLAGS(func, bpf_iter_css_task_next, KF_ITER_NEXT | KF_RET_NULL)
>>   BTF_ID_FLAGS(func, bpf_iter_css_task_destroy, KF_ITER_DESTROY)
>> +BTF_ID_FLAGS(func, bpf_iter_process_new, KF_ITER_NEW)
>> +BTF_ID_FLAGS(func, bpf_iter_process_next, KF_ITER_NEXT | KF_RET_NULL)
>> +BTF_ID_FLAGS(func, bpf_iter_process_destroy, KF_ITER_DESTROY)
>>   BTF_ID_FLAGS(func, bpf_dynptr_adjust)
>>   BTF_ID_FLAGS(func, bpf_dynptr_is_null)
>>   BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
>> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
>> index b1bdba40b684..a6717a76c1e0 100644
>> --- a/kernel/bpf/task_iter.c
>> +++ b/kernel/bpf/task_iter.c
>> @@ -862,6 +862,37 @@ __bpf_kfunc void bpf_iter_css_task_destroy(struct bpf_iter_css_task *it)
>>          kfree(kit->css_it);
>>   }
>>
>> +struct bpf_iter_process_kern {
>> +       struct task_struct *tsk;
>> +} __attribute__((aligned(8)));
>> +
>> +__bpf_kfunc int bpf_iter_process_new(struct bpf_iter_process *it)
>> +{
>> +       struct bpf_iter_process_kern *kit = (void *)it;
>> +
>> +       BUILD_BUG_ON(sizeof(struct bpf_iter_process_kern) != sizeof(struct bpf_iter_process));
>> +       BUILD_BUG_ON(__alignof__(struct bpf_iter_process_kern) !=
>> +                                       __alignof__(struct bpf_iter_process));
>> +
>> +       rcu_read_lock();
>> +       kit->tsk = &init_task;
>> +       return 0;
>> +}
>> +
>> +__bpf_kfunc struct task_struct *bpf_iter_process_next(struct bpf_iter_process *it)
>> +{
>> +       struct bpf_iter_process_kern *kit = (void *)it;
>> +
>> +       kit->tsk = next_task(kit->tsk);
>> +
>> +       return kit->tsk == &init_task ? NULL : kit->tsk;
>> +}
>> +
>> +__bpf_kfunc void bpf_iter_process_destroy(struct bpf_iter_process *it)
>> +{
>> +       rcu_read_unlock();
>> +}
> 
> This iter can be used in all ctx-s which is nice, but let's
> make the verifier enforce rcu_read_lock/unlock done by bpf prog
> instead of doing in the ctor/dtor of iter, since
> in sleepable progs the verifier won't recognize that body is RCU CS.
> We'd need to teach the verifier to allow bpf_iter_process_new()
> inside in_rcu_cs() and make sure there is no rcu_read_unlock
> while BPF_ITER_STATE_ACTIVE.
> bpf_iter_process_destroy() would become a nop.

Thanks for your review!

I think bpf_iter_process_{new, next, destroy} should be protected by 
bpf_rcu_read_lock/unlock explicitly whether the prog is sleepable or 
not, right? I'm not very familiar with the BPF verifier, but I believe 
there is still a risk in directly calling these kfuns even if 
in_rcu_cs() is true.

Maby what we actually need here is to enforce BPF verifier to check 
env->cur_state->active_rcu_lock is true when we want to call these kfuncs.

Thanks.



