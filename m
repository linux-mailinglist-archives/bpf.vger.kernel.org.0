Return-Path: <bpf+bounces-13776-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B35BD7DDB17
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 03:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3319B21014
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 02:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379CEA51;
	Wed,  1 Nov 2023 02:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="UTfj+viJ"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF50A32
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 02:42:01 +0000 (UTC)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D17EF4
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 19:41:57 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1cc330e8f58so26653675ad.3
        for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 19:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698806517; x=1699411317; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s9k8CzKt9aDAvaiCJv5FVkawaHteXvlT4rcuIAleTUo=;
        b=UTfj+viJuHfT5cb5XKA50HvuTkAtKM9eOsB0S4NSPlubz56hFCEYPoKi9+g/Hs5M17
         9jZuSY+6/z4VTngq0H9EPU71E0YXYnTQOaKpTEYCiVZeZmplo6cqf9+ejZMvBUUwebGM
         1TlAnlpeBmIXztCoSkDNO3BbWnK/bjKXdz3bIQoOPo2ZWrmbgABpnhewaOXFgWLeE4U1
         Xc3pzLGwjvrodffPVY0wUbh5DfNk/86neui6hRKrFQxpAKpACBU0YhogkN7oPHvUdDM4
         mi0f36CYcYO2JZe33zH7YAIJlF6IDOcxUsjixi9EVnEUeOJiOAOoW7qijDsjGSKVREie
         ha1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698806517; x=1699411317;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s9k8CzKt9aDAvaiCJv5FVkawaHteXvlT4rcuIAleTUo=;
        b=vm4bg9EmsFJoINsCxWMJd33nxFUezmQ6ESdCtoR7/N64+LH/TlpuoAI3X9GZjgihf3
         1Q6B03oYii/gbV6ybnII+RLXlZtLLHEdnRWuDu+o+63gsMkgdadY008gjpz2Z0i1o1yV
         aIzb80Nm07rDWfNeEkgtP5MTsONQL2DxZYBohBhC3OVYUJ65VuNfYMbvHLszHW4dpAnV
         ihrIV13WppGaXwpsRpgHsbyZiU/tceBTQ2lpt2Idy0H2WteLQNESR9NXxWUayOTaHXCW
         0XIHbH6b9dTJBotixUd5iG4DnddqPa+rN2uIcvkWKBeOhsI5lYzQvBb41PwAvbow8COM
         rM6w==
X-Gm-Message-State: AOJu0Yxbu8JlCGzVTTmSp8p9y0BmePKFD3BNUwkCZCruVmTUvndbpINx
	FFacsPTFeXabnjVIF6hUA05+oQ==
X-Google-Smtp-Source: AGHT+IEmQfdrFLREk/f+IlayYmliy0Y56FYYzATe0jBRRqyKRyaMumZ8spS+FM22zWeGUNaxP0WM2A==
X-Received: by 2002:a17:903:32cc:b0:1cc:4985:fc04 with SMTP id i12-20020a17090332cc00b001cc4985fc04mr8117120plr.66.1698806516880;
        Tue, 31 Oct 2023 19:41:56 -0700 (PDT)
Received: from [10.84.141.101] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id x8-20020a170902820800b001c9bc811d4dsm228681pln.295.2023.10.31.19.41.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 19:41:56 -0700 (PDT)
Message-ID: <e8e2ca00-dbfc-4a46-b154-692dcefbbee2@bytedance.com>
Date: Wed, 1 Nov 2023 10:41:52 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add test for css_task iter
 combining with cgroup iter
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20231022154527.229117-1-zhouchuyi@bytedance.com>
 <20231022154527.229117-3-zhouchuyi@bytedance.com>
 <CAADnVQLGwn_x9CZmYX5K_6K5Y0SB7EjU5wfRUHRMdXhAvKEJVw@mail.gmail.com>
 <cfaf3363-51b9-40af-8993-9718d7edbaf7@bytedance.com>
 <CAADnVQLcw36TiEYXaoYDhEinygCQ86U5AKg-rJPsQj=KUu7Y2g@mail.gmail.com>
 <350dd3e5-3a34-42ba-85b9-ddb1a217c95e@bytedance.com>
 <bcdce26b-b5cf-4eb7-bf04-7507f5e0ac85@bytedance.com>
 <CAADnVQ+xaNK5vbGwrB25VvVTQhfQcCNHxqXCxBodrwpOvdkFWQ@mail.gmail.com>
From: Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <CAADnVQ+xaNK5vbGwrB25VvVTQhfQcCNHxqXCxBodrwpOvdkFWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

在 2023/11/1 06:06, Alexei Starovoitov 写道:
> On Tue, Oct 31, 2023 at 4:38 AM Chuyi Zhou <zhouchuyi@bytedance.com> wrote:
>>
>>
>> So, maybe another possible solution is:
>>
>> diff --git a/kernel/bpf/cgroup_iter.c b/kernel/bpf/cgroup_iter.c
>> index 209e5135f9fb..72a6778e3fba 100644
>> --- a/kernel/bpf/cgroup_iter.c
>> +++ b/kernel/bpf/cgroup_iter.c
>> @@ -282,7 +282,7 @@ static struct bpf_iter_reg bpf_cgroup_reg_info = {
>>           .ctx_arg_info_size      = 1,
>>           .ctx_arg_info           = {
>>                   { offsetof(struct bpf_iter__cgroup, cgroup),
>> -                 PTR_TO_BTF_ID_OR_NULL },
>> +                 PTR_TO_BTF_ID_OR_NULL | MEM_RCU },
>>           },
>>           .seq_info               = &cgroup_iter_seq_info,
>>    };
>> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
>> index 59e747938bdb..4fd3f734dffd 100644
>> --- a/kernel/bpf/task_iter.c
>> +++ b/kernel/bpf/task_iter.c
>> @@ -706,7 +706,7 @@ static struct bpf_iter_reg task_reg_info = {
>>           .ctx_arg_info_size      = 1,
>>           .ctx_arg_info           = {
>>                   { offsetof(struct bpf_iter__task, task),
>> -                 PTR_TO_BTF_ID_OR_NULL },
>> +                 PTR_TO_BTF_ID_OR_NULL | PTR_TRUSTED },
> 
> Yep. That looks good.
> bpf_cgroup_reg_info -> cgroup is probably PTR_TRUSTED too.
> Not sure... why did you go with MEM_RCU there ?

hmm...

That is because in our previous discussion, you suggested we'd better 
add BTF_TYPE_SAFE_RCU_OR_NULL(struct bpf_iter__cgroup) {...}

I didn't think too much about it. But I noticed that we only use 
cgroup_mutex to protect the iteration in cgroup_iter.c.

Looking at cgroup_kn_lock_live() in kernel/cgroup/cgroup.c, it would use 
cgroup_tryget()/cgroup_is_dead() to check whether the cgrp is 'dead'. 
cgroup_tryget() seems is equal to bpf_cgroup_acquire(). So, maybe let's 
return a 'rcu' cgrp pointer. If BPF Prog want stronger guarantee of 
cgrp, just use bpf_cgroup_acquire().

Just some thoughts. Thanks.








