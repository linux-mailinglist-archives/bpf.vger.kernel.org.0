Return-Path: <bpf+bounces-70338-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FEDBB7F76
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 21:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD321481A0E
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 19:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E4A217F29;
	Fri,  3 Oct 2025 19:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ApzJVCIx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5651F4165
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 19:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759519033; cv=none; b=OVKrMVRVbO1eLEPzIOrU3c0CYHLj3j6y/0urKMZHUrMoOOJ63LGUkGGKUkKVMIkVOzrdWmBs9om1b7nLnHm8JfBUfsx+1lVPn/KboVjKxBFaa8tO9ICRKHYSDk9GJ+dfIPllqQ7RUZQ7oqP17HAePn9FcNz156KKFrTcxeqX8HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759519033; c=relaxed/simple;
	bh=gdtWHeL4Ll9VQTBhjR6XWZeQhk3nZ9Mr5PYqDE/AMjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=chRTFFEPUKo1GovJSr9BNJwIzthUBMnYTLI1DOdWYgizXX6x0F8pjOR8og14QscrJHZqA1XCkE6KSn1qEeIskjQpvgYQkdaJiqrYix+pP7VC3oRYdcrSEAdfuj1Zap0tefb9nWDpoaGDAjdnBY/RIbhdrL6mtFMyRmdpUPPhxzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ApzJVCIx; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3ed20bdfdffso2394858f8f.2
        for <bpf@vger.kernel.org>; Fri, 03 Oct 2025 12:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759519030; x=1760123830; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ejVen+2WCs9uB0tmZkymi1DM7ul4TRBrWzfrX5QKQ1o=;
        b=ApzJVCIxAMCs+2t66KsfupmR9dXvFwFxtjynQbA6v4UMwECeAEYejIjtS1I35QjYaH
         FGIb7Lrbti5jIM/g07RiC0CgSHJ3vN2xE5xF+kn8o882OiBi+x7RzVoZahWWlJ7cNmwz
         52o9rWvHBb3ErLCZwrz8CXBwh6Hl7vXUSKBAft6G22mA6dmY9/mlQuJka7ZE3l87tMuQ
         ToWeQq9mU1Ne946vDOUCV6XG4iNyJzhsG5jC09AU5kv7lImRbg9P83Z5wiIHpR9BD8Zi
         mxcB8gMS7hVyKQyn7+avBqxSx8HbBdcsYNAQ/x+39YXlqT7gCsKaDzNtxAKxNPaDbDPN
         hCBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759519030; x=1760123830;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ejVen+2WCs9uB0tmZkymi1DM7ul4TRBrWzfrX5QKQ1o=;
        b=gDnvl4xAbdvv1GpaOcVYuwiU3305Qz7cTO0SJz27WDgQYF+N4Nt2xUHdUrljmI6+Wx
         xdIfSgvn/klezZSCbxVG+PbFx5qbt+XlxUq3G/jbXR3L91+CK/zSQ/H6JCju/CwdCYGv
         clJ8ujwUtJi8SToFIc4yYmILsffEoLz/AvHXdHh7eq3FeWTI1PKluwmHle7I2DhOBJEn
         v0v2UKXOqlvT5H4E18j7+7Bivrjwbu/DCbgnMVDtKZkBkmY3Zqa84MeAq0wM5xmWSwOT
         PLGT3FMeCwIKc40M7PHwcpUfq2hjZ/zk6t72PllRL3r2fa4Oc/EtGOVDH6DySH7gHBlm
         D57g==
X-Forwarded-Encrypted: i=1; AJvYcCXHsiw1byi6tSwO/PDE7BhPqkRCbwwvpxA5xuy2ArJE/2E8UDmVIAl/6+4VC8DhFv/sWxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+Lwr+1E0TzwXgQAnCthRE+gl+7EYWZ5PSd+XrdSea+cadLJ1n
	A/ZqJaUy0HLmoGlrIzyfdyVJG6mvUlAa/M1kvygREKGzGSX3eJt2vAKH
X-Gm-Gg: ASbGncsCYQ2a/z0I9+DdOD3PM3SYWoYECsmilGBKwCCqe7hiURrg86feX80kk+br8eD
	1lSFK6blc8z+Momg2z4ZZOXxRkrNg5oz23KKISCWUR3rf0uloWpvi6SZljcuoLC0suh+SVMfABk
	gBzdo3y57hZv4jBWQVDJMX/HwvTfbO4EVUl69pvQFBugW+N8ibrA7yoxElrBy2jfAHwQl0ZlyyN
	13TeF7SNsIUtqzYjPVhzQlQTpl2dHbXjp0+MEDtCYtXIfr9XCkVhlARSX1FwCpDBaXbfD8PFeOv
	nXqyG7ByDUg7hi4H12N8fakJsKi5sf//+3Xepu8qTiIYdSfBo3UEjC4RL6TbC5k6lrsSER40t85
	oyjLs79QLwBi4NMDgjoSq2lijvjdYKgjV9ECRoZmbGrIPZ46r5KAciWJUhY37QyYV85KTmlY=
X-Google-Smtp-Source: AGHT+IFuFwVXD6WMJua1/MC0xspFi4ENxE0RkGnlzBRWnDHL9ObljuH7pSZQBwS3yG0/91CUzT92lA==
X-Received: by 2002:a05:6000:4285:b0:3da:d015:bf84 with SMTP id ffacd0b85a97d-42567153299mr3048274f8f.25.1759519029815;
        Fri, 03 Oct 2025 12:17:09 -0700 (PDT)
Received: from ?IPV6:2620:10d:c0c3:1130::123d? ([2620:10d:c092:400::5:5b97])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f0170sm9182210f8f.49.2025.10.03.12.17.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 12:17:09 -0700 (PDT)
Message-ID: <f3fd1043-6696-454d-bafd-9d1a84a937c5@gmail.com>
Date: Fri, 3 Oct 2025 20:17:08 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 1/2] bpf: verifier: refactor bpf_wq handling
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20251001132252.385398-1-mykyta.yatsenko5@gmail.com>
 <6b2b44ddbec88ae4690b4eae33b712642b73db4c.camel@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <6b2b44ddbec88ae4690b4eae33b712642b73db4c.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/1/25 19:50, Eduard Zingerman wrote:
> On Wed, 2025-10-01 at 14:22 +0100, Mykyta Yatsenko wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Move bpf_wq map-field validation into the common helper by adding a
>> BPF_WORKQUEUE case that maps to record->wq_off, and switch
>> process_wq_func() to use it instead of doing its own offset math.
>>
>> This de-duplicates logic with other internal structs (task_work, timer),
>> keeps error reporting consistent, and makes future changes to the layout
>> handling centralized.
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
> Note to reviewers: technically, this makes the check stricter,
> but no new correct BPF programs would be rejected.
> The cases that are checked by check_map_field_pointer,
> but which were not checked before this patch:
> - reg value is a constant
> - corresponding map has BTF
> - map record has BPF_WORKQUEUE field
>
> Not sure if ignoring one of these checks could lead to invalid memory
> access at runtime. I'd add fixes tag (and maybe a test), so that this
> commit could be grabbed for backporing:
>
> Fixes: d940c9b94d7e ("bpf: add support for KF_ARG_PTR_TO_WORKQUEUE")
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> [...]
I tried to trigger some of these error conditions:
- map record has no bpf_wq: this errors out earlier: arg#%d doesn't 
point to a map value
- corresponding map has no BTF: I think to create a map without BTF
I need an older libbpf version, not 100% sure how to do this
- reg value is not constant - this one I don't know how to trigger.
Given all this, let's keep this simple and not add fixes tag, it does 
not look like we are
actually fixing anything.

