Return-Path: <bpf+bounces-29856-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 468FE8C797A
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 17:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B52181F21FF0
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 15:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D421A14E2F2;
	Thu, 16 May 2024 15:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/fYRdfe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C34314D42C
	for <bpf@vger.kernel.org>; Thu, 16 May 2024 15:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715873297; cv=none; b=TSL7qpq4nwk4k61zV+2LNGrrALBGdbA/yA4bBN9nQRitBZ1M3X6rwFYeeJEzQaprmtranRGS2go7bEgyvfeFMQWM4Z7yJSFQ2iOlGo2LZCq8440lr4dapz6Iy4gec0LgLZ3KTTed5kPfSN1ey7qzLgu+upIMJXS2G2gVGL7tWRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715873297; c=relaxed/simple;
	bh=F3alC8ZbWrupnt+x8shZklpjFo/1Y0W2CBsGwWqI6fk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sQSDD85MzUiD1GZgg7f3DTulXKpe0uvvFF9dejK5Gss4Y/ysbBgOjTTcSYGkh3oKTQyyRFu88KgGDcAIpy/uPWs6OrLluCQLOCzhxssEHiJVCoKt3aNWuz2+f3b2hqid2NFiJdSZaPNJZ4M96HS2fHMoIkEMbLRzoEEPYCpajNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/fYRdfe; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6f44d2b3130so330329b3a.2
        for <bpf@vger.kernel.org>; Thu, 16 May 2024 08:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715873294; x=1716478094; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tD2gZ3c2n7fgkgKPsxexLmJUyTtAlpCGrWfU9swgB4g=;
        b=X/fYRdfeu52nHeQPsp1cSJkAL85D1PnXxEs1Ny317Yml/qqzUXjQTvlG59a0AIlnAW
         A6QrRQnsyHKLdqYPJwoeGj1xHH6JnaY7Lgfjnpdd+AhNZZKljqUjAOk0ACrTVw+OLCDN
         Fz8YAYyV+JzmXSQaTX+vCV54AHN6Bul6nzjpYQ8MFMOlqEKpL7sqMYnxKPAg/iTZrU2l
         S0rwgffkHF+O1LTYiIE6T7qRj4dQ6k0RAgR8pgFHVClpMhRM/s3wRGJrnDJtodexLJbg
         clYrVWVyPc18AFgEljJ3RUWVnRcMk2jLuQjGLwc7eMzs7XbchX/XbPa87p8HBqUefqVj
         ivug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715873294; x=1716478094;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tD2gZ3c2n7fgkgKPsxexLmJUyTtAlpCGrWfU9swgB4g=;
        b=AmSbQIpn5lihlzlmttf/EgR7IFhhtdkkKKMBKYRpQjPHHs9Tm18DByWx/Kr0R1tQoW
         5v7/lXZOKAu4GObpJgv3eg7hu9TUT2T94G5cfrp3MtxRTAd148uu4qTdCJdFnbigCAlX
         NCciK43mUY28S7QiRjaCQ9giPNTYyfNS1EXpFWssEFt2G8fs1beOTxmAONn5rcdYlcUi
         fhsQmJAHgl/RMaf9UK/pP3Gfd7hTYtiCmwa+VwTtFG54bO2kHphzXJf3fiSICB9BtvlT
         lEHfk2c5/p/7OiOHTc13ea2IaO63+gqYdLuT4WipAerqwLzda17QzZp0gCnPrrb3Mg61
         1ljg==
X-Gm-Message-State: AOJu0Yyo58SwpSgyvnS8eJeo/NkvGjTAP2xEefsRbguXjL9nOb4WoO3i
	4G5qv8bNpYOc2VWkfXce+MtaTU8iIAvYkPDBh3M6Gn/MzldYRZkb8VzSYA==
X-Google-Smtp-Source: AGHT+IEgJ6Mqju8YmaJI4Rg1/ZNtXl6lf26vc7lx3zjk9WAEft2Fh1trvlCqpQKsLh8K9F4fqyzZ6g==
X-Received: by 2002:a05:6a20:734c:b0:1af:5d8e:c6c with SMTP id adf61e73a8af0-1afde0d5445mr21377080637.18.1715873294138;
        Thu, 16 May 2024 08:28:14 -0700 (PDT)
Received: from [192.168.1.76] (bb116-14-181-187.singnet.com.sg. [116.14.181.187])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a827fdsm13220895b3a.60.2024.05.16.08.28.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 May 2024 08:28:13 -0700 (PDT)
Message-ID: <a6b60575-6342-4ce7-9652-2a7438a3e1f4@gmail.com>
Date: Thu, 16 May 2024 23:28:09 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 3/5] bpf, x64: Fix tailcall hierarchy
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 maciej.fijalkowski@intel.com, jakub@cloudflare.com, pulehui@huawei.com,
 kernel-patches-bot@fb.com
References: <20240509150541.81799-1-hffilwlqm@gmail.com>
 <20240509150541.81799-4-hffilwlqm@gmail.com>
Content-Language: en-US
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <20240509150541.81799-4-hffilwlqm@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024/5/9 23:05, Leon Hwang wrote:
> This patch fixes a tailcall issue caused by abusing the tailcall in
> bpf2bpf feature.
> 
> As we know, tail_call_cnt propagates by rax from caller to callee when
> to call subprog in tailcall context. But, like the following example,
> MAX_TAIL_CALL_CNT won't work because of missing tail_call_cnt
> back-propagation from callee to caller.
> 
> \#include <linux/bpf.h>
> \#include <bpf/bpf_helpers.h>
> \#include "bpf_legacy.h"
> 
> struct {
> 	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
> 	__uint(max_entries, 1);
> 	__uint(key_size, sizeof(__u32));
> 	__uint(value_size, sizeof(__u32));
> } jmp_table SEC(".maps");
> 
> int count = 0;
> 
> static __noinline
> int subprog_tail1(struct __sk_buff *skb)
> {
> 	bpf_tail_call_static(skb, &jmp_table, 0);
> 	return 0;
> }
> 
> static __noinline
> int subprog_tail2(struct __sk_buff *skb)
> {
> 	bpf_tail_call_static(skb, &jmp_table, 0);
> 	return 0;
> }
> 
> SEC("tc")
> int entry(struct __sk_buff *skb)
> {
> 	volatile int ret = 1;
> 
> 	count++;
> 	subprog_tail1(skb);
> 	subprog_tail2(skb);
> 
> 	return ret;
> }
> 
> char __license[] SEC("license") = "GPL";
> 
> At run time, the tail_call_cnt in entry() will be propagated to
> subprog_tail1() and subprog_tail2(). But, when the tail_call_cnt in
> subprog_tail1() updates when bpf_tail_call_static(), the tail_call_cnt
> in entry() won't be updated at the same time. As a result, in entry(),
> when tail_call_cnt in entry() is less than MAX_TAIL_CALL_CNT and
> subprog_tail1() returns because of MAX_TAIL_CALL_CNT limit,
> bpf_tail_call_static() in suprog_tail2() is able to run because the
> tail_call_cnt in subprog_tail2() propagated from entry() is less than
> MAX_TAIL_CALL_CNT.
> 
> So, how many tailcalls are there for this case if no error happens?
> 
> From top-down view, does it look like hierarchy layer and layer?
> 
> With view, there will be 2+4+8+...+2^33 = 2^34 - 2 = 17,179,869,182
> tailcalls for this case.
> 
> How about there are N subprog_tail() in entry()? There will be almost
> N^34 tailcalls.
> 
> Then, in this patch, it resolves this case on x86_64.
> 
> In stead of propagating tail_call_cnt from caller to callee, it
> propagate its pointer, tail_call_cnt_ptr, tcc_ptr for short.
> 
> However, where does it store tail_call_cnt?
> 
> It stores tail_call_cnt on the stack of bpf prog's caller by the way in
> previous patch "bpf: Introduce bpf_jit_supports_tail_call_cnt_ptr()".
> Then, in bpf prog's prologue, it loads tcc_ptr from bpf_tail_call_run_ctx,
> and restores the original ctx from bpf_tail_call_run_ctx meanwhile.
> 
> Then, when a tailcall runs, it compares tail_call_cnt accessed by
> tcc_ptr with MAX_TAIL_CALL_CNT and then increments tail_call_cnt at
> tcc_ptr.
> 
> Furthermore, when trampoline is the caller of bpf prog, it is required
> to prepare tail_call_cnt and tail call run ctx on the stack of the
> trampoline.
> 

Oh, I missed a case here.

This patch set is unable to provide tcc_ptr for freplace programs that
use tail calls in bpf2bpf.

How can this approach provide tcc_ptr for freplace programs?

Achieving this is not straightforward. However, it is simpler to disable
the use of tail calls in bpf2bpf for freplace programs, even though this
is a desired feature for my project.

Therefore, I will disable it in the v5 patch set.

Thanks,
Leon

