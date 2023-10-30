Return-Path: <bpf+bounces-13613-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5CB7DBBE9
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 15:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA9DC28158C
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 14:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C6915487;
	Mon, 30 Oct 2023 14:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="enuR/OgH"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C00384
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 14:37:29 +0000 (UTC)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D430DC6
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 07:37:26 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-2802d218242so1620288a91.1
        for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 07:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698676646; x=1699281446; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ypY0pghZogtmayIgqRuKCUKSnV87++gK+UqRVqwgd5U=;
        b=enuR/OgHgUK+WYLILsOu/GEAvhdoT7/52Sh98EL6FH9+rUy98pHqJZSb5pCT9l3QHz
         PRm8O/pFfO6eIlr7RIHfLwG8HF0Bf/KIAAAIq6RYVpCoea+fdqaZ6tdljLa7QFQXjL0U
         Dt6v6rbPBvdEal3cz9+XKkyEHZUTEMoVScjWTT5bEJQ/74wPcvi7Cj99nepXgoRG+KkY
         y8pFyF95NWbYDKMGg/NV6l0ERBVcRmB39+cIQDWcSyN/tDY/kTFbWDiwn9nHMXNDZG+q
         xZJa+VWen0/evRaU9A4qISkenPtOPOt8lw0aZB1z+YcZdpHM3Ap18z2pOTvv1bEThsFG
         ZFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698676646; x=1699281446;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ypY0pghZogtmayIgqRuKCUKSnV87++gK+UqRVqwgd5U=;
        b=Oes4drtHz/9HjBDElQcTnkC7GStE8V+msjFT/dg9+ghqcteCWP2a8Ib3QFTubbP0+3
         0Q8p4PoRtOnJqNjHyvV3qVJLgf+VTNG62axe+D7Kduv1n7zSS4+l3zAfMUgLBp3Leh4n
         yz/A/mXi0cDDBFof3f4yRG6+Dq3ZKKoITSE9Dr2UWsKQwStvFAZh30kITxBdQPvZr7ZY
         Onguool4pQ+XiexFHOt8VBO9cYWdDllNwRoFTOVUUICcU8icZ8g2Sgzl+F4D0B3aMJna
         2EYMLBNVQTj8gkDy/+jtpAqrPDS25k2X+K4+OV5ql4GUzRqPKv4rHBwe0tDWHMkJy1fo
         xSsg==
X-Gm-Message-State: AOJu0YzCzlUmeWfyE1fYu37z2lR5X9bl9hThveeWSIrWQbir8vb65MfO
	8WqMl7mQ1kjJoS5dcLJqxhsC3A==
X-Google-Smtp-Source: AGHT+IGHGARLf+BUAoCxJj2W8EWMJWJIMUcxBBNedeIroT/bdERgu84dceGCIA7y0yqqSTFRze2eaw==
X-Received: by 2002:a17:90a:17c8:b0:279:2dac:80b3 with SMTP id q66-20020a17090a17c800b002792dac80b3mr8481640pja.44.1698676646311;
        Mon, 30 Oct 2023 07:37:26 -0700 (PDT)
Received: from [10.254.164.31] ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id d15-20020a17090a02cf00b0027722832498sm8226841pjd.52.2023.10.30.07.37.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 07:37:26 -0700 (PDT)
Message-ID: <350dd3e5-3a34-42ba-85b9-ddb1a217c95e@bytedance.com>
Date: Mon, 30 Oct 2023 22:37:20 +0800
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
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20231022154527.229117-1-zhouchuyi@bytedance.com>
 <20231022154527.229117-3-zhouchuyi@bytedance.com>
 <CAADnVQLGwn_x9CZmYX5K_6K5Y0SB7EjU5wfRUHRMdXhAvKEJVw@mail.gmail.com>
 <cfaf3363-51b9-40af-8993-9718d7edbaf7@bytedance.com>
 <CAADnVQLcw36TiEYXaoYDhEinygCQ86U5AKg-rJPsQj=KUu7Y2g@mail.gmail.com>
From: Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <CAADnVQLcw36TiEYXaoYDhEinygCQ86U5AKg-rJPsQj=KUu7Y2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

在 2023/10/24 01:14, Alexei Starovoitov 写道:
> On Mon, Oct 23, 2023 at 6:50 AM Chuyi Zhou <zhouchuyi@bytedance.com> wrote:
>>
>>
>> R1_w=ptr_task_struct(off=0,imm=0) R7_w=ptr_task_struct(off=0,imm=0)
>> 18: (85) call bpf_task_acquire#26990
>> R1 must be a rcu pointer
>>
>> I will try to figure out it.
> 
> Thanks. That would be great.
> So far it looks like a regression.
> I'm guessing __bpf_md_ptr wrapping is confusing the verifier.
> 
> Since it's more complicated than I thought, please respin
> the current set with fixes to patch 1 and leave the patch 2 as-is.
> That can be another follow up.

After adding this change:

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 15d71d2986d3..4565e5457754 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6071,6 +6071,8 @@ bool btf_ctx_access(int off, int size, enum 
bpf_access_type type,
                         info->reg_type = ctx_arg_info->reg_type;
                         info->btf = btf_vmlinux;
                         info->btf_id = ctx_arg_info->btf_id;
+                       if (prog_args_trusted(prog))
+                               info->reg_type |= PTR_TRUSTED;
                         return true;
                 }
         }

the task pointer would be recognized as 'trusted_ptr_or_null_task_struct'.

The VERIFIER LOG:
=============
reg type unsupported for arg#0 function dump_task#7
0: R1=ctx(off=0,imm=0) R10=fp0
; struct task_struct *task = ctx->task;
0: (79) r1 = *(u64 *)(r1 +8)          ; 
R1_w=trusted_ptr_or_null_task_struct(id=1,off=0,imm=0)

The following BPF Prog works well.

SEC("iter/task")
int dump_task(struct bpf_iter__task *ctx)
{
	struct task_struct *task = ctx->task;
	struct task_struct *acq;
	if (task == NULL)
		return 0;
	acq = bpf_task_acquire(task);
	if (!acq)
		return 0;
	bpf_task_release(acq);
	
	return 0;
}

Do you think this change is correct ?
Or do you have better ideas ?

Thanks.

