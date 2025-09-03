Return-Path: <bpf+bounces-67251-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E4DB4144D
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 07:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 869073BAB1E
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 05:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB43F2D47E2;
	Wed,  3 Sep 2025 05:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BLDb/9ss"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DA22D24A4
	for <bpf@vger.kernel.org>; Wed,  3 Sep 2025 05:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756876958; cv=none; b=vD/XbcxxbTyKk/2jGrjEWRJPgjLviKOLQ6JSPL7QguofQgC9fqIdvG54dnbJTVm4UPyGfonbY9+v0txo8HjDa+8qBHM00LboeKOA/fwp88YbJ0DejypeHonf1qrVWsZakLmTwo/tF76xMp3mhPIfLKtqVN/48ud40SSctSz3vKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756876958; c=relaxed/simple;
	bh=bM9eZe8MiH7DB0Bqw4CKgZ7LOn2x1LGmO6v2Cj7VMKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g0tw42HzbxkTce/hIALBOaVdiwo4ZgTKJWPlzz8Q84M8gujNm1m8UYUrvtxFtJ5zIH1RWa21CiWMkf21LurBbm4ehfpdOfNJ+/hzv8HDvBTJtMttw5yfyELM21+kRM+wg6LyNWWaJVJYWwBjd87t7d44xobN1gNKZ63r1zGCEqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BLDb/9ss; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e612ad80-2cfc-4531-99dc-958ffe7c407e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756876950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n9fPx0ZxGfBtPb0Uzo+RHaEmvZ+Ec7vJeXf35AH5i/U=;
	b=BLDb/9ssJnbr422qw8VRz2KIMRHTj1r2gP7kUXc+YYjV04eNdm+YnD6/8hVD8XcT/Ep9PK
	MqoKEEvGv+XkwDPeEiTSm4208WnFVtLLhJVR2jalxg+h5t/0qJpaITnx0Mh9FMdRZe6v2r
	+SxuKzGwjKZIBsQKHF/IJyHpvUSuF/c=
Date: Wed, 3 Sep 2025 13:22:17 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Introduce bpf_in_interrupt kfunc
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 kernel-patches-bot@fb.com
References: <20250825131502.54269-1-leon.hwang@linux.dev>
 <20250825131502.54269-2-leon.hwang@linux.dev>
 <CAADnVQLdmjApwAbrGca2VLQ-SK-3EdQTyd0prEy0BQGrW4Fr6A@mail.gmail.com>
 <d7ca66b9-c8a5-47c4-9feb-d7814efcce0a@linux.dev>
 <CAADnVQKkEk=uZ6LBW2yXSAB2huYwpeOdDggaUAzd74_bs_6dcQ@mail.gmail.com>
 <DCHK6T0A6T94.9CMWYIYTG79@linux.dev>
 <CAADnVQ+FxdMBKb-sv3Mu04eCpsKwS7pieNSpUUvNRCDxVCr6KA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAADnVQ+FxdMBKb-sv3Mu04eCpsKwS7pieNSpUUvNRCDxVCr6KA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2/9/25 10:29, Alexei Starovoitov wrote:
> On Mon, Sep 1, 2025 at 8:12 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>>
>> I do a PoC of adding bpf_in_interrupt() to bpf_experimental.h.
> 
> lgtm
> 
>> It works:
>>
>> extern bool CONFIG_PREEMPT_RT __kconfig __weak;
>> #ifdef bpf_target_x86
> 
> what is bpf_target_x86 ?
> 

bpf_target_x86 is a macro defined in bpf_tracing.h:

#if defined(__TARGET_ARCH_x86)
        #define bpf_target_x86
...
#if defined(__x86_64__)
        #define bpf_target_x86
...

>> extern const int __preempt_count __ksym;
>> #endif
>>
>> struct task_struct__preempt_rt {
>>         int softirq_disable_cnt;
>> } __attribute__((preserve_access_index));
>>
>> /* Description
>>  *      Report whether it is in interrupt context. Only works on x86.
> 
> arm64 shouldn't be hard to support either.
> 

No problem.

I'll add support for arm64.

>>  */
>> static inline int bpf_in_interrupt(void)
>> {
>> #ifdef bpf_target_x86
>>         int pcnt;
>>
>>         pcnt = *(int *) bpf_this_cpu_ptr(&__preempt_count);
>>         if (!CONFIG_PREEMPT_RT) {
>>                 return pcnt & (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_MASK);
>>         } else {
>>                 struct task_struct__preempt_rt *tsk;
>>
>>                 tsk = (void *) bpf_get_current_task_btf();
>>                 return (pcnt & (NMI_MASK | HARDIRQ_MASK)) |
>>                        (tsk->softirq_disable_cnt | SOFTIRQ_MASK);
>>         }
>> #else
>>         return 0;
>> #endif
>> }
>>
>> However, I only test it for !PREEMPT_RT on x86.
>>
>> I'd like to respin the patchset by moving bpf_in_interrupt() to
>> bpf_experimental.h.
> 
> I think the approach should work for PREEMPT_RT too.
> Test it and send it.

Yes, it works for PREEMPT_RT too.

It is able to get retval of bpf_in_interrupt() by running a simple demo.

However, it's really difficult to add selftest case for PREEMPT_RT, as
I'm not familiar with PREEMPT_RT.

Thanks,
Leon

[...]


