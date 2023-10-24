Return-Path: <bpf+bounces-13108-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D917D4716
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 07:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A5BF2817C9
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 05:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CCD79FE;
	Tue, 24 Oct 2023 05:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="dJnPzPPO"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AB720F7
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 05:52:07 +0000 (UTC)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30829120
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 22:52:06 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6bb4abb8100so3338497b3a.2
        for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 22:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698126725; x=1698731525; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SyryjqXpN478fOjvT62oYdSfJogP5n4XKEFnz2fZUiY=;
        b=dJnPzPPOWqW6QdfOA2DUbf3/DAWb66Ts1NYRlSG1Rn6xqxKmoaxF5N5BxmsblyPBRd
         z5K+90ghhNr9mL+egaLUaZlJemZggjkT+gn3gK/YCM1gM4E1PzYqqkSEwXYRY4+lkfyK
         pmDM8SqztuX3AXDmpmcPTXg1WEh7b6nz+IXor8BJ7qEXPb9iXJj/sKG4kWT2MITnw8dG
         KoUT3ppV/F9uqYHws4a+ETcuI1mlCn46qYr19LIzyYI76kw8f39BndHOcwiucVr42WF3
         n0bt4mku8xJbdYFhC7nifJLcC/KUikwgNb9X/K4x34cYIvT/Ucpk+d0Rsf1G/glFc3l2
         QMAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698126725; x=1698731525;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SyryjqXpN478fOjvT62oYdSfJogP5n4XKEFnz2fZUiY=;
        b=XZBWO8T2RAaq1hK4nxPP3wBOzTYTdN8hmazF3fo0W+L4Qix2QMIXdUPE892uaUACzc
         ffQ3u7K3VRcQA7TErF2t2+JAV5duajUuZtKLme8kC86GYKQ7m0ZPkJYc+gUjjPw0ic1X
         7mTTO31NxVjBPHCu7Zgz6/duwz2C3J4/hu/fflgsbHz8t3MZ62Bck0SgPUxBCNRPE8v9
         n7art9/UEXJNRDO6CNeePoH/TPdYWN6YylMXiqedcL0fJoDm855UeBWqwJ31hnYXBZdl
         BPm6bce3yWSovp/yHpELCPyd2ENjr5PZUTXCuqZyA5HVeIdTjhMwKu6QYjJMzLDzmsKw
         mpjQ==
X-Gm-Message-State: AOJu0Yx4CXoDUJWaHoSdCwx74jR28idwTDvl0N1BWzPusZrBubDIugmM
	Z3iIbHTUqR6P9FLgQwnW2hm4AA==
X-Google-Smtp-Source: AGHT+IFwMMEMc+wX45K5A7cG/4y4d3KlI5y8ge0vKoO5KteEvlbGgyR71a9iyZcToXewZ0hPfHjmXA==
X-Received: by 2002:a05:6a20:3d8b:b0:161:3120:e872 with SMTP id s11-20020a056a203d8b00b001613120e872mr1940005pzi.20.1698126725611;
        Mon, 23 Oct 2023 22:52:05 -0700 (PDT)
Received: from [10.84.141.101] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id 7-20020a17090a034700b0027fccaa6a29sm244867pjf.15.2023.10.23.22.52.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 22:52:05 -0700 (PDT)
Message-ID: <1f4f9308-26b4-4cc5-99eb-88851fe2f3f9@bytedance.com>
Date: Tue, 24 Oct 2023 13:52:00 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Relax allowlist for css_task iter
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20231024024240.42790-1-zhouchuyi@bytedance.com>
 <20231024024240.42790-2-zhouchuyi@bytedance.com>
 <CAADnVQJRhyn4Xpd5f0_iJp7F2iZrs_qp+E0DZPNc3aKc0SGzCQ@mail.gmail.com>
From: Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <CAADnVQJRhyn4Xpd5f0_iJp7F2iZrs_qp+E0DZPNc3aKc0SGzCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

在 2023/10/24 12:57, Alexei Starovoitov 写道:
> On Mon, Oct 23, 2023 at 7:42 PM Chuyi Zhou <zhouchuyi@bytedance.com> wrote:
>>
>> The newly added open-coded css_task iter would try to hold the global
>> css_set_lock in bpf_iter_css_task_new, so the bpf side has to be careful in
>> where it allows to use this iter. The mainly concern is dead locking on
>> css_set_lock. check_css_task_iter_allowlist() in verifier enforced css_task
>> can only be used in bpf_lsm hooks and sleepable bpf_iter.
>>
>> This patch relax the allowlist for css_task iter. Any lsm and any iter
>> (even non-sleepable) and any sleepable are safe since they would not hold
>> the css_set_lock before entering BPF progs context.
>>
>> This patch also fixes the misused BPF_TRACE_ITER in
>> check_css_task_iter_allowlist which compared bpf_prog_type with
>> bpf_attach_type.
>>
>> Fixes: 9c66dc94b62ae ("bpf: Introduce css_task open-coded iterator kfuncs")
>> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
>> ---
>>   kernel/bpf/verifier.c                         | 21 ++++++++++++-------
>>   .../selftests/bpf/progs/iters_task_failure.c  |  4 ++--
>>   2 files changed, 15 insertions(+), 10 deletions(-)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index e9bc5d4a25a1..9f209adc4ccb 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -11088,18 +11088,23 @@ static int process_kf_arg_ptr_to_rbtree_node(struct bpf_verifier_env *env,
>>                                                    &meta->arg_rbtree_root.field);
>>   }
>>
>> +/*
>> + * css_task iter allowlist is needed to avoid dead locking on css_set_lock.
>> + * LSM hooks and iters (both sleepable and non-sleepable) are safe.
>> + * Any sleepable progs are also safe since bpf_check_attach_target() enforce
>> + * them can only be attached to some specific hook points.
>> + */
>>   static bool check_css_task_iter_allowlist(struct bpf_verifier_env *env)
>>   {
>>          enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
>>
>> -       switch (prog_type) {
>> -       case BPF_PROG_TYPE_LSM:
>> +       if (prog_type == BPF_PROG_TYPE_LSM)
>>                  return true;
>> -       case BPF_TRACE_ITER:
>> -               return env->prog->aux->sleepable;
>> -       default:
>> -               return false;
>> -       }
>> +
>> +       if (env->prog->expected_attach_type == BPF_TRACE_ITER)
>> +               return true;
> 
> I think the switch by prog_type has to stay.
> Checking attach_type == BPF_TRACE_ITER without considering prog_type
> is fragile. It likely works, but we don't do it anywhere else.
> Let's stick to what is known to work.
> 

IIUC, do you mean:

static bool check_css_task_iter_allowlist(struct bpf_verifier_env *env)
{
	enum bpf_prog_type prog_type = resolve_prog_type(env->prog);

  	switch (prog_type) {
  	case BPF_PROG_TYPE_LSM:
  		return true;
	case BPF_PROG_TYPE_TRACING:
		if (env->prog->expected_attach_type == BPF_TRACE_ITER)
			return true;
		return env->prog->aux->sleepable;
  	default:
		return env->prog->aux->sleepable;
  	}
}

>> -SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
>> -__failure __msg("css_task_iter is only allowed in bpf_lsm and bpf iter-s")
>> +SEC("?fentry/" SYS_PREFIX "sys_getpgid")
>> +__failure __msg("css_task_iter is only allowed in bpf_lsm, bpf_iter and sleepable progs")
> 
> Please add both. fentry that is rejected and fentry.s that is accepted.

Sure.

