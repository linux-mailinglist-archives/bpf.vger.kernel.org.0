Return-Path: <bpf+bounces-14345-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D5B7E3329
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 03:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EBA41C20A0A
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 02:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5117917E3;
	Tue,  7 Nov 2023 02:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="EnIle/KW"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E91AA49
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 02:44:59 +0000 (UTC)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA5791
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 18:44:58 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1cc938f9612so29762705ad.1
        for <bpf@vger.kernel.org>; Mon, 06 Nov 2023 18:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1699325097; x=1699929897; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p/4gWjTxgjPosuhkTCl5jZSXFMzBNGaVtyrC8MzrkZw=;
        b=EnIle/KW4DEQkGROC9E+dbSEydYv4CPfGoYHIJNHuj7GpJfAbx5VgtKS1oBP0j+7R/
         fCrE2aH/5QPl8NVewOI5dOPZvT2L+3nC/g1HgrS14eyoRbwXMY6hF5BJFDbmPg25+n3n
         dRtfn+H4qS1FUlAstso2kGL1XcPJA8J6sq/QYc+PmcuzZzzkXDK222LnsqTV6IP/X2I4
         KYm4PC0jX5XVC/LapRcJzf3M8IHmdV0GmC081jlPHPxohRnmVH22vA9cVbgB3a29lat7
         IkweqknJhaFyyJ8rGCcRCwHO2dbnLQ/obBQxMZ+a+ig1oLY1huHJQqJ0cuX1vqxMmJXK
         xZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699325097; x=1699929897;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p/4gWjTxgjPosuhkTCl5jZSXFMzBNGaVtyrC8MzrkZw=;
        b=MUDUMZhFFJvWDuww8k12yYv2sVVqQvhhUhz3lfRBG3r1wBGAghstvES3/KCFcKs/qw
         pxVDrq3HcH7uwgd3Qb8Uu6wMgS+U1ROcLYJUQKrH7wVyuVpMLM+d46ATt/JNwXhTGrLy
         381s0LkavKbG7KpsDF/uiYPZTuEJm5jcREkZqQpPHr3qF2wUS7kcvk4yFNQ9shGWMBFP
         znnz/1a4dgPhp5EbhADi3dJuB4cPeCwtVezFKLIPla7RfbFrW31e+R+PtXr7dbPqWUZV
         pieh6zKRXzTHCz25fEVSjFfCpJR3Dn0P02JMRlcs9VKPE6Bk2CDt5axkeFedDc5oKsM7
         b/mg==
X-Gm-Message-State: AOJu0YwNBHOO1FMi92R7uyd0KzUAqxHWukzE7S2iPDLSERi4MZtPxIwh
	krVKtvt5jreIz/g2QqiQgbkpiYDV6tZuNIynauc=
X-Google-Smtp-Source: AGHT+IGRnjGqDtS+YZ8/Q/jfBQFy8cv8YeV615Ij+ExnPV6eXPMz3RZMta+Tn3bonTaYjYG7I8Jq8Q==
X-Received: by 2002:a17:902:e2d5:b0:1cc:d05:eb61 with SMTP id l21-20020a170902e2d500b001cc0d05eb61mr26012831plc.23.1699325097532;
        Mon, 06 Nov 2023 18:44:57 -0800 (PST)
Received: from [10.84.141.101] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id c10-20020a170902d48a00b001c88f77a156sm6515437plg.153.2023.11.06.18.44.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Nov 2023 18:44:57 -0800 (PST)
Message-ID: <9f55ef44-646d-4120-b437-defff91d1af5@bytedance.com>
Date: Tue, 7 Nov 2023 10:44:52 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf 1/2] bpf: Let verifier consider {task,cgroup} is
 trusted in bpf_iter_reg
To: Martin KaFai Lau <martin.lau@linux.dev>,
 Yonghong Song <yonghong.song@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org, bpf@vger.kernel.org
References: <20231105133458.1315620-1-zhouchuyi@bytedance.com>
 <20231105133458.1315620-2-zhouchuyi@bytedance.com>
 <f807c58c-526c-0647-fc1c-9b488d351b1d@linux.dev>
From: Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <f807c58c-526c-0647-fc1c-9b488d351b1d@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

在 2023/11/7 02:29, Martin KaFai Lau 写道:
> On 11/5/23 5:34 AM, Chuyi Zhou wrote:
>> BTF_TYPE_SAFE_TRUSTED(struct bpf_iter__task) in verifier.c wanted to
>> teach BPF verifier that bpf_iter__task -> task is a trusted ptr. But it
>> doesn't work well.
>>
>> The reason is, bpf_iter__task -> task would go through btf_ctx_access()
>> which enforces the reg_type of 'task' is ctx_arg_info->reg_type, and in
>> task_iter.c, we actually explicitly declare that the
>> ctx_arg_info->reg_type is PTR_TO_BTF_ID_OR_NULL.
>>
>> This patch sets ctx_arg_info->reg_type is PTR_TO_BTF_ID_OR_NULL |
>> PTR_TRUSTED in task_reg_info.
>>
>> Similarly, bpf_cgroup_reg_info -> cgroup is also PTR_TRUSTED since we are
>> under the protection of cgroup_mutex and we would check cgroup_is_dead()
>> in __cgroup_iter_seq_show().
>>
> 
> Make sense. I think the bpf_tcp_iter made similar change in tcp_seq_info 
> also. What may be the Fixes tag? Is it fixing the recent kfunc of the 
> css_task iter?
> 

Thanks for the review.

I think it's not a fix for recent kfunc of css_task iter. We are working 
at SEC("iter/task") and SEC("iter/cgroup").

I'm not sure whether it's a 'fix' for cgroup_iter/task_iter. If we need 
fix tags, do we need to split this patch into two separate patches? Or 
add two fix tags on commit log:

Fixes: d4ccaf58a84721 ("bpf: Introduce cgroup iter")
Fixes: 3c32cc1bceba8a17 ("bpf: Enable bpf_iter targets registering ctx 
argument types")

Thanks.




