Return-Path: <bpf+bounces-12836-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 506317D11C7
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 16:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBB10282510
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 14:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B66519BAC;
	Fri, 20 Oct 2023 14:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Q8mGK1wt"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407B115EBB
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 14:46:55 +0000 (UTC)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D78106
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 07:46:54 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c9e95aa02dso7285105ad.0
        for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 07:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697813214; x=1698418014; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GyYLg6uaau03lsfr7xxhq7bt6KmMpCzPGGZ4WDyQ87k=;
        b=Q8mGK1wtnWCx8tCK0NSPDaVqaCzFeXzsltsRaV8Rz31choCxKMtvjvLJE6qAKDDw86
         t43QQ0a2/vvYrBPuWw6ZFgp2vsg2Wx+bqs8b2oGZ1zAGGl95EXfK2VMcm8jwNi70ISLz
         028G0Nzv1bAAlVdgnqizFq51hzE9srTofdatzN3UAWT4ly0iBhH7hb4+OCgkI7iHRJuF
         VgRDO6Vp1Mv9ITrySYs94NH4uJ9VrjVbopVlY004ctN+h3NQtNzKvLHj412U5gTVycpK
         qdUQpgmxTmdsWf+JC2i942VBOoFEhBg7VKOWA1Biwecas7UremsTVSe6nxq2kdIac4G5
         cG6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697813214; x=1698418014;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GyYLg6uaau03lsfr7xxhq7bt6KmMpCzPGGZ4WDyQ87k=;
        b=oCA62B++s8KrdtdFbPtN1dD1AWYD04UZGCduH7QdQa9JMjsAa9G+qybaWvAVnDqaG1
         BpXPhKlGwR6kDHnJ2nJLwml/UY7zO42rPYiZs6d7mp36TxSCUemLE4GOlSprVzMj9nxQ
         BaUIZNS3cPbgircn8oUbnLBSUNf+nJntL6opyRdELiVMGlvJEr4SCezYxMVgYp88sbl5
         HtXmtpuCfD2JOMCYBBAqpJED/TiTLMdVeXTyeWJtTkHNzPR/A47+owt5jynAvRK/7pec
         vq0AHpQaF8zyq8YM8uTxHREYavyU78gdNBMBlke71oQeD5i73W2AY+Xa7ukLtmvtdiAA
         D6hw==
X-Gm-Message-State: AOJu0YwaAW3d3GEqyvfrn4Fjlxi3Tz6r4ACYl8WJWL5U8oClUDj9C3zl
	HAquFNNPNdRRzlDg9iqOom0z2e005wMQ7JaCLmk=
X-Google-Smtp-Source: AGHT+IFu+j4QSKAUz1a05aMPKqTUoCm8eGTO3kbV6RYKEUUYJskXkYI3Cp6EYCSsU8WnzgahVH+KsQ==
X-Received: by 2002:a17:902:d2c2:b0:1c7:49dd:2ff with SMTP id n2-20020a170902d2c200b001c749dd02ffmr2718988plc.27.1697813214265;
        Fri, 20 Oct 2023 07:46:54 -0700 (PDT)
Received: from [10.254.107.145] ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id f12-20020a17090274cc00b001c72f4334afsm1619250plt.20.2023.10.20.07.46.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 07:46:53 -0700 (PDT)
Message-ID: <272de0e9-539c-4d89-9b9c-0652b0826cdd@bytedance.com>
Date: Fri, 20 Oct 2023 22:46:48 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH bpf-next v6 8/8] selftests/bpf: Add tests for
 open-coded task and css iter
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>, Tejun Heo <tj@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <20231018061746.111364-1-zhouchuyi@bytedance.com>
 <20231018061746.111364-9-zhouchuyi@bytedance.com>
 <CAADnVQKafk_junRyE=-FVAik4hjTRDtThymYGEL8hGTuYoOGpA@mail.gmail.com>
From: Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <CAADnVQKafk_junRyE=-FVAik4hjTRDtThymYGEL8hGTuYoOGpA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2023/10/20 08:03, Alexei Starovoitov 写道:
> On Tue, Oct 17, 2023 at 11:18 PM Chuyi Zhou <zhouchuyi@bytedance.com> wrote:
>>
>> +
>> +SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
>> +__failure __msg("css_task_iter is only allowed in bpf_lsm and bpf iter-s")
>> +int BPF_PROG(iter_css_task_for_each)
>> +{
>> +       u64 cg_id = bpf_get_current_cgroup_id();
>> +       struct cgroup *cgrp = bpf_cgroup_from_id(cg_id);
>> +       struct cgroup_subsys_state *css;
>> +       struct task_struct *task;
>> +
>> +       if (cgrp == NULL)
>> +               return 0;
>> +       css = &cgrp->self;
>> +
>> +       bpf_for_each(css_task, task, css, CSS_TASK_ITER_PROCS) {
>> +
>> +       }
>> +       bpf_cgroup_release(cgrp);
>> +       return 0;
>> +}
> 
> I think we should relax allowlist in patch 2 further.
> Any sleepable is safe.
> Allowlist is needed to avoid dead locking on css_set_lock.
> Any lsm and any iter (even non-sleepable) and any sleepable
> seems to be safe.

Yes, I just try to read the corresponding code. IIUC, the key point here 
is we should not hold the css_set_lock before we invoking a BPF Prog 
which may use css_task iters.

1. For lsm hooks and task_iters, it would be clearly know from the code 
that we would not try to hold that lock.

2. For cgroup_iters, we will hold the cgroup_muetx before we enter the 
Prog and it's OK.(see __cgroup_procs_write())

3. For any sleepable progs, bpf_check_attach_target() would only allow 
them to attach some sepecifc hooks, currently, these hooks are OK.


Thanks for the suggestion again! I would do it.


