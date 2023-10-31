Return-Path: <bpf+bounces-13703-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB4A7DCBF3
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 12:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D03CB20F54
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 11:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A7E1A73C;
	Tue, 31 Oct 2023 11:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="TIyszBdQ"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C58E1A72B
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 11:38:05 +0000 (UTC)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2144C97
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 04:38:04 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-5872c6529e1so280185eaf.0
        for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 04:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698752283; x=1699357083; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UrmnCRurc9pOzS45cFwToO916UcNT8LXzHTdag6sctA=;
        b=TIyszBdQIJdN3eAC4PawAhuLWKAY3PhCK3rayUbK3TmEaJjjT7jzBp2Grn5hC7Z+ta
         B/tMGGDBFFUGLGwBhFsAQGSLQQm+cBqeadOrH6gTM6nHPnCCSrQUl7tTil5FkBjuqsDv
         nExMrAJkmktoPuuNwg+m4U8y343bqGUmfrR8Xkt6n0m0GWc9Pj1vjMPTrOvWhpWYlr8c
         tRELeP+IpOxxEBT95h0IzAxI6bmxRnkMqKpTscEVJ5lyZegBCp7dMAFRpnJQIp91chM8
         IMyJnIWpyKOdCV1yNNt9/zakz2EibF7Lcbl3wHUJt1BL49ruHnYwcaWwGpcmSY901HrR
         kdhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698752283; x=1699357083;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UrmnCRurc9pOzS45cFwToO916UcNT8LXzHTdag6sctA=;
        b=OF2S98o5/ldGFq+O2WxWirIiBSSIE7GkumvdwUly9DftXuciQFHfeBmQFmu2aWI3Za
         UMuzs/Rnaa2viqtQSMa3STL6nzdWEGSYs4l6v2b9MwuQD1L9IyUIBMQELL175pnovrL7
         ndUZioRz53SunErXq4gzMOs5/iR8vcWCs2ejZFRyErjv9w6/omwug153f9w42EDSebU5
         NQ8x45fUqXx/SjhnzKQSnRt/xqNwGSXw6dslbXv5C/3FoP/9/Cm2tcuEua3o8J1zLkI6
         oDYbl1FtLaJ6YlVdQll/cLfDrIcSzSl/S0mHkt4uMZWk6LqhBc97H0+s6wgsq5CqY8VR
         dFtw==
X-Gm-Message-State: AOJu0YyP1dWAMonJPAZulvLC4ZeVmosBydhgP5+pKv+lQY53IMqB9DPe
	LvDr47JrTFQAqFm7wBiKmnda5ofdRcx/1P8vfYU=
X-Google-Smtp-Source: AGHT+IGBtixaCm0FIY16f5LpHRQdQHffCSOujH/FoRjS+SxKKnc1OQoVs8zqSRhneMMoqM7LVmtDYQ==
X-Received: by 2002:a05:6358:89e:b0:168:f5e2:b1e0 with SMTP id m30-20020a056358089e00b00168f5e2b1e0mr13923303rwj.31.1698752283338;
        Tue, 31 Oct 2023 04:38:03 -0700 (PDT)
Received: from [10.254.164.31] ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id t27-20020a63955b000000b0057412d84d25sm950868pgn.4.2023.10.31.04.38.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 04:38:03 -0700 (PDT)
Message-ID: <bcdce26b-b5cf-4eb7-bf04-7507f5e0ac85@bytedance.com>
Date: Tue, 31 Oct 2023 19:37:56 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add test for css_task iter
 combining with cgroup iter
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20231022154527.229117-1-zhouchuyi@bytedance.com>
 <20231022154527.229117-3-zhouchuyi@bytedance.com>
 <CAADnVQLGwn_x9CZmYX5K_6K5Y0SB7EjU5wfRUHRMdXhAvKEJVw@mail.gmail.com>
 <cfaf3363-51b9-40af-8993-9718d7edbaf7@bytedance.com>
 <CAADnVQLcw36TiEYXaoYDhEinygCQ86U5AKg-rJPsQj=KUu7Y2g@mail.gmail.com>
 <350dd3e5-3a34-42ba-85b9-ddb1a217c95e@bytedance.com>
In-Reply-To: <350dd3e5-3a34-42ba-85b9-ddb1a217c95e@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2023/10/30 22:37, Chuyi Zhou 写道:
> Hello,
> 
> 在 2023/10/24 01:14, Alexei Starovoitov 写道:
>> On Mon, Oct 23, 2023 at 6:50 AM Chuyi Zhou <zhouchuyi@bytedance.com> 
>> wrote:
>>>
>>>
>>> R1_w=ptr_task_struct(off=0,imm=0) R7_w=ptr_task_struct(off=0,imm=0)
>>> 18: (85) call bpf_task_acquire#26990
>>> R1 must be a rcu pointer
>>>
>>> I will try to figure out it.
>>
>> Thanks. That would be great.
>> So far it looks like a regression.
>> I'm guessing __bpf_md_ptr wrapping is confusing the verifier.
>>
>> Since it's more complicated than I thought, please respin
>> the current set with fixes to patch 1 and leave the patch 2 as-is.
>> That can be another follow up.
> 
> After adding this change:
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 15d71d2986d3..4565e5457754 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -6071,6 +6071,8 @@ bool btf_ctx_access(int off, int size, enum 
> bpf_access_type type,
>                          info->reg_type = ctx_arg_info->reg_type;
>                          info->btf = btf_vmlinux;
>                          info->btf_id = ctx_arg_info->btf_id;
> +                       if (prog_args_trusted(prog))
> +                               info->reg_type |= PTR_TRUSTED;
>                          return true;
>                  }
>          }
> 
> the task pointer would be recognized as 'trusted_ptr_or_null_task_struct'.
> 
> The VERIFIER LOG:
> =============
> reg type unsupported for arg#0 function dump_task#7
> 0: R1=ctx(off=0,imm=0) R10=fp0
> ; struct task_struct *task = ctx->task;
> 0: (79) r1 = *(u64 *)(r1 +8)          ; 
> R1_w=trusted_ptr_or_null_task_struct(id=1,off=0,imm=0)
> 
> The following BPF Prog works well.
> 
> SEC("iter/task")
> int dump_task(struct bpf_iter__task *ctx)
> {
>      struct task_struct *task = ctx->task;
>      struct task_struct *acq;
>      if (task == NULL)
>          return 0;
>      acq = bpf_task_acquire(task);
>      if (!acq)
>          return 0;
>      bpf_task_release(acq);
> 
>      return 0;
> }
> 

bpf_iter__task->meta would be recognized as a trusted ptr.
In btf_ctx_access(), we would add PTR_TRUSTED flag if 
prog_args_trusted(prog) return true.

It seems for BPF_TRACE_ITER, ctx access is always 'trusted'.

But I noticed that in task_iter.c, we actually explicitly declare that 
the type of bpf_iter__task->task is PTR_TO_BTF_ID_OR_NULL.

static struct bpf_iter_reg task_reg_info = {
	.target			= "task",
	.attach_target		= bpf_iter_attach_task,
	.feature		= BPF_ITER_RESCHED,
	.ctx_arg_info_size	= 1,
	.ctx_arg_info		= {
		{ offsetof(struct bpf_iter__task, task),
		  PTR_TO_BTF_ID_OR_NULL },
	},
	.seq_info		= &task_seq_info,
	.fill_link_info		= bpf_iter_fill_link_info,
	.show_fdinfo		= bpf_iter_task_show_fdinfo,
};

btf_ctx_access() would enforce the reg_type is 
ctx_arg_info->reg_type(PTR_TO_BTF_ID_OR_NULL) for bpf_iter__task->task:

bool btf_ctx_access()
	....
	/* this is a pointer to another type */
	for (i = 0; i < prog->aux->ctx_arg_info_size; i++) {
		const struct bpf_ctx_arg_aux *ctx_arg_info = &prog->aux->ctx_arg_info[i];

		if (ctx_arg_info->offset == off) {
			...
			info->reg_type = ctx_arg_info->reg_type;
			info->btf = btf_vmlinux;
			info->btf_id = ctx_arg_info->btf_id;
			return true;
		}
	}


So, maybe another possible solution is:

diff --git a/kernel/bpf/cgroup_iter.c b/kernel/bpf/cgroup_iter.c
index 209e5135f9fb..72a6778e3fba 100644
--- a/kernel/bpf/cgroup_iter.c
+++ b/kernel/bpf/cgroup_iter.c
@@ -282,7 +282,7 @@ static struct bpf_iter_reg bpf_cgroup_reg_info = {
         .ctx_arg_info_size      = 1,
         .ctx_arg_info           = {
                 { offsetof(struct bpf_iter__cgroup, cgroup),
-                 PTR_TO_BTF_ID_OR_NULL },
+                 PTR_TO_BTF_ID_OR_NULL | MEM_RCU },
         },
         .seq_info               = &cgroup_iter_seq_info,
  };
diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 59e747938bdb..4fd3f734dffd 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -706,7 +706,7 @@ static struct bpf_iter_reg task_reg_info = {
         .ctx_arg_info_size      = 1,
         .ctx_arg_info           = {
                 { offsetof(struct bpf_iter__task, task),
-                 PTR_TO_BTF_ID_OR_NULL },
+                 PTR_TO_BTF_ID_OR_NULL | PTR_TRUSTED },
         },
         .seq_info               = &task_seq_info,
         .fill_link_info         = bpf_iter_fill_link_info,


Just some thoughts.

Thanks.


