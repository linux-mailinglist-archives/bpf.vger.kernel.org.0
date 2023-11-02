Return-Path: <bpf+bounces-13929-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 318E77DEEBD
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 10:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C58601F22385
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 09:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB74111BD;
	Thu,  2 Nov 2023 09:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="axjaOFoF"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E7F10977
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 09:21:47 +0000 (UTC)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584E212E
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 02:21:43 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cc2f17ab26so5695155ad.0
        for <bpf@vger.kernel.org>; Thu, 02 Nov 2023 02:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698916903; x=1699521703; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DvDScROd/f0qL6Ff7IAjIzHXEOQ6NNEhPaDQIp+e5cA=;
        b=axjaOFoFf4A7HZilg04MLUjqrzRvGTosqz//7GptjEHlOfQhmOYfeW9Am5WU4AW0GV
         3gBTUqP1jJsF1sJ/xGLLfYQdd3etz2uUXjo58hlOdMUd9h+b4Y69LdVRlG8S+lKUfaeK
         xDP058fM6DT2dXACB33vXOrIBsdEmTnn/OVc0kkhmHGoBWSxD1pd1QOjjXK4WLabsq27
         f2/xDM+I/NhxwrxfFyRJZhNNtQhZ4etsvoPLhClsTYcOZ5Ay/OxIYE/KHqG62/RYQaDe
         RkFtmSGk33Apfw+NiAqJDEp0lDsVCuBIyclGuefQ+4M4SIcAIDo6BjbquTXHc8U6WnIU
         8kEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698916903; x=1699521703;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DvDScROd/f0qL6Ff7IAjIzHXEOQ6NNEhPaDQIp+e5cA=;
        b=XW9yeDo83jgVZKS7lPFzJEdD1lFTdpDfVJkLieDoeBVDiR4ZESUXYMsy9u3wa4hjzo
         Kz/lORm9uRHLkTJ7Xmd8818JtnPZwhPnpfIY/x+WjqwnCtz0CWQzWxr6/j0eFa1CcI36
         1DdgeIyBPuLte6ik4hVt4E1G4JXr5QTafqVoKd79Dk6EKWB8R5xjjpG8BKN5KtyzkM8z
         olf6loSc132X3wtbU/iVddMUmlAC1xcpsfrLDdREWt+sQtoz16p8iBTy7HYXnqU/1KEQ
         sej1WPV4ArRLoTUXfDIB39tkwZB5WK61JgnbHaZJ1x4ZOaTbSgIwmdxrSsKx2oycnVfH
         AilQ==
X-Gm-Message-State: AOJu0Yyb09blElv2QrGv4VZ9lmaIyXTwSTvG6xD9ppj7cFIoEN6NMYlr
	6fzb3LWJSTtDu1ivUmr6DOo4ZFeYirC3d6CE46I=
X-Google-Smtp-Source: AGHT+IHKsoOFZvEpxBrZdCBPr9r47fZu32Kc6mYkJ59zqTU0L+XG7kGXrsUHYBN06ztY1Bt8egmidA==
X-Received: by 2002:a17:903:244d:b0:1cc:4fd6:71c9 with SMTP id l13-20020a170903244d00b001cc4fd671c9mr11702905pls.19.1698916902696;
        Thu, 02 Nov 2023 02:21:42 -0700 (PDT)
Received: from [10.84.141.101] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id t6-20020a1709027fc600b001cc56354cc8sm2723130plb.62.2023.11.02.02.21.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 02:21:42 -0700 (PDT)
Message-ID: <89226e27-6770-4b99-a123-47067240a67e@bytedance.com>
Date: Thu, 2 Nov 2023 17:21:37 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add test for css_task iter
 combining with cgroup iter
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>
References: <20231022154527.229117-1-zhouchuyi@bytedance.com>
 <20231022154527.229117-3-zhouchuyi@bytedance.com>
 <CAADnVQLGwn_x9CZmYX5K_6K5Y0SB7EjU5wfRUHRMdXhAvKEJVw@mail.gmail.com>
 <cfaf3363-51b9-40af-8993-9718d7edbaf7@bytedance.com>
 <CAADnVQLcw36TiEYXaoYDhEinygCQ86U5AKg-rJPsQj=KUu7Y2g@mail.gmail.com>
 <350dd3e5-3a34-42ba-85b9-ddb1a217c95e@bytedance.com>
 <bcdce26b-b5cf-4eb7-bf04-7507f5e0ac85@bytedance.com>
 <CAADnVQ+xaNK5vbGwrB25VvVTQhfQcCNHxqXCxBodrwpOvdkFWQ@mail.gmail.com>
 <e8e2ca00-dbfc-4a46-b154-692dcefbbee2@bytedance.com>
 <CAADnVQLZ4HJZdYOO5EH7o80qB7TfRbv08WwaVVu_cO_ME9i3OQ@mail.gmail.com>
From: Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <CAADnVQLZ4HJZdYOO5EH7o80qB7TfRbv08WwaVVu_cO_ME9i3OQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2023/11/2 14:07, Alexei Starovoitov 写道:
> On Tue, Oct 31, 2023 at 7:41 PM Chuyi Zhou <zhouchuyi@bytedance.com> wrote:
>>
>> Hello,
>>
>> 在 2023/11/1 06:06, Alexei Starovoitov 写道:
>>> On Tue, Oct 31, 2023 at 4:38 AM Chuyi Zhou <zhouchuyi@bytedance.com> wrote:
>>>>
>>>>

[cut]

>>> Yep. That looks good.
>>> bpf_cgroup_reg_info -> cgroup is probably PTR_TRUSTED too.
>>> Not sure... why did you go with MEM_RCU there ?
>>
>> hmm...
>>
>> That is because in our previous discussion, you suggested we'd better
>> add BTF_TYPE_SAFE_RCU_OR_NULL(struct bpf_iter__cgroup) {...}
> 
> I mentioned that because we don't have
> BTF_TYPE_SAFE_TRUSTED_OR_NULL.
> 
> and cgroup pointer can be NULL, but since you found a cleaner way
> we can do PTR_TO_BTF_ID_OR_NULL | PTR_TRUSTED.
> 
>> I didn't think too much about it. But I noticed that we only use
>> cgroup_mutex to protect the iteration in cgroup_iter.c.
>>
>> Looking at cgroup_kn_lock_live() in kernel/cgroup/cgroup.c, it would use
>> cgroup_tryget()/cgroup_is_dead() to check whether the cgrp is 'dead'.
>> cgroup_tryget() seems is equal to bpf_cgroup_acquire(). So, maybe let's
>> return a 'rcu' cgrp pointer. If BPF Prog want stronger guarantee of
>> cgrp, just use bpf_cgroup_acquire().
> 
> and that would be misleading.
> MEM_RCU means that the pointer is valid, but it could have refcnt == 0,
> while PTR_TRUSTED means that it's good to use as-is.
> 
> Here cgroup pointer is trusted. It's not a dead cgroup.
> See kernel/bpf/cgroup_iter.c __cgroup_iter_seq_show().
> bpf prog doesn't need to call bpf_cgroup_acquire.

Thanks for the detailed explanation.

I will send a follow up.



