Return-Path: <bpf+bounces-14381-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8D97E3562
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 07:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2870B20BE9
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 06:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09445BE53;
	Tue,  7 Nov 2023 06:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Eo4erzeg"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E348F49
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 06:55:01 +0000 (UTC)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827A410F
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 22:55:00 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-da7ea62e76cso4012139276.3
        for <bpf@vger.kernel.org>; Mon, 06 Nov 2023 22:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1699340099; x=1699944899; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rfWRgBjyCkPUpho/T8X1ynhFMk7y7ttBa7Qsqqe04t4=;
        b=Eo4erzeg47p74vySIbES4g8q7QzSeoM6tl/BJ/9DcZNEtq25v5GgOcKUd5om1C4akf
         gv77xE1d0W3Smp7+KFF2xNN3zyBaJojHZNiCTOx2hNohMYAJURf1EWvsDl0owxcpCx0d
         LR9pk4P4tiHda1NRgCvfiwnahZg/G7322O6T4D8OIci59oWVooxLK2cSO+RfuYddq/eK
         NzSxC26vL5HT7AlUfD1H+YWP3TqUuCup+iNUOY4G+bjvpRv1cQBa4f9/a+XPOXiNdBRh
         lsXWIlq1o9qrLjf4zoxSdMlXw3Z9HxPdppgloIsuBVQlr24crRN3h3H2rDtdlYQfJoxB
         05fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699340099; x=1699944899;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rfWRgBjyCkPUpho/T8X1ynhFMk7y7ttBa7Qsqqe04t4=;
        b=StMREq8CCj1Welv3TpfUTCr0PeXjtorU6LyjmzShAY5HW0/Jod4iDhha9Hg/N3Lrh2
         DD0vcLHk4SacHZk+SWCKI409Z8raciSJKsfF2f6m2GbtUhcj261I6PnKk3gqoD7ERT9z
         I3WuZiint2THZBiPSqGzln+sr/EFBIwzFgcCyzo4qQ5OUPJ6m0zaFjqilkt2DjdaO39R
         lUi1XoeNjjSYU9uMhXmxHvwx4bM5BBCYLO1pckSAJxCS/IyojvgqFkdP32ZbSShDVYE8
         Ak0T+xqVpgItwXvYpsFZZDVS1razlbWRabMrIolbgPPw2OMQKNKhHc5EAYZIDw/LDksA
         CHPA==
X-Gm-Message-State: AOJu0YwdrZE60lcauef3mvG3COrGRQaEqKcyJ3eWaC2a7d/HdThMwfCP
	R+te6/Lu5UMXXKsiusvk5dCCWg==
X-Google-Smtp-Source: AGHT+IGlNfbwaIe7ciivEsQHvd455lXkKfW0HQwiWXVbcYAcrm72tFVUj0H6Cbd5ooRnxF7se6fZCA==
X-Received: by 2002:a25:f621:0:b0:d9a:e1bb:5468 with SMTP id t33-20020a25f621000000b00d9ae1bb5468mr30446581ybd.46.1699340099685;
        Mon, 06 Nov 2023 22:54:59 -0800 (PST)
Received: from [10.84.141.101] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id z12-20020aa785cc000000b006c337ce0f26sm6807960pfn.170.2023.11.06.22.54.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Nov 2023 22:54:59 -0800 (PST)
Message-ID: <67a5668a-59de-4905-8224-b94dd2bbf2a3@bytedance.com>
Date: Tue, 7 Nov 2023 14:54:54 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH bpf 1/2] bpf: Let verifier consider
 {task,cgroup} is trusted in bpf_iter_reg
To: Yonghong Song <yonghong.song@linux.dev>,
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org, bpf@vger.kernel.org
References: <20231105133458.1315620-1-zhouchuyi@bytedance.com>
 <20231105133458.1315620-2-zhouchuyi@bytedance.com>
 <f807c58c-526c-0647-fc1c-9b488d351b1d@linux.dev>
 <9f55ef44-646d-4120-b437-defff91d1af5@bytedance.com>
 <8a4d7471-76ac-448c-9496-12e028f7fe24@linux.dev>
From: Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <8a4d7471-76ac-448c-9496-12e028f7fe24@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2023/11/7 14:52, Yonghong Song 写道:
> 
> On 11/6/23 6:44 PM, Chuyi Zhou wrote:
>> Hello,
>>
>> 在 2023/11/7 02:29, Martin KaFai Lau 写道:
>>> On 11/5/23 5:34 AM, Chuyi Zhou wrote:
>>>> BTF_TYPE_SAFE_TRUSTED(struct bpf_iter__task) in verifier.c wanted to
>>>> teach BPF verifier that bpf_iter__task -> task is a trusted ptr. But it
>>>> doesn't work well.
>>>>
>>>> The reason is, bpf_iter__task -> task would go through btf_ctx_access()
>>>> which enforces the reg_type of 'task' is ctx_arg_info->reg_type, and in
>>>> task_iter.c, we actually explicitly declare that the
>>>> ctx_arg_info->reg_type is PTR_TO_BTF_ID_OR_NULL.
>>>>
>>>> This patch sets ctx_arg_info->reg_type is PTR_TO_BTF_ID_OR_NULL |
>>>> PTR_TRUSTED in task_reg_info.
>>>>
>>>> Similarly, bpf_cgroup_reg_info -> cgroup is also PTR_TRUSTED since 
>>>> we are
>>>> under the protection of cgroup_mutex and we would check 
>>>> cgroup_is_dead()
>>>> in __cgroup_iter_seq_show().
>>>>
>>>
>>> Make sense. I think the bpf_tcp_iter made similar change in 
>>> tcp_seq_info also. What may be the Fixes tag? Is it fixing the recent 
>>> kfunc of the css_task iter?
>>>
>>
>> Thanks for the review.
>>
>> I think it's not a fix for recent kfunc of css_task iter. We are 
>> working at SEC("iter/task") and SEC("iter/cgroup").
>>
>> I'm not sure whether it's a 'fix' for cgroup_iter/task_iter. If we 
>> need fix tags, do we need to split this patch into two separate 
>> patches? Or add two fix tags on commit log:
> 
> I think the patch itself is not a fix, rather an improvement. The 
> bpf_iter predates kfunc/PTR_TRUSTED stuff. The argument 'task'
> or 'cgroup' are already trusted so the bpf_iter program can print out 
> useful data.
> But recent kfunc things requires some parameters to be marked as 
> PTR_TRUSTED so that they can be passed to kfunc,
> so this patch enables this usage for kfunc in bpf_iter programs.
> 
> 

Thanks. I will send v2.


