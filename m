Return-Path: <bpf+bounces-74018-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C984C44659
	for <lists+bpf@lfdr.de>; Sun, 09 Nov 2025 20:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D67494E3540
	for <lists+bpf@lfdr.de>; Sun,  9 Nov 2025 19:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B83253B58;
	Sun,  9 Nov 2025 19:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bfnr7Ypx"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D5B246BC6
	for <bpf@vger.kernel.org>; Sun,  9 Nov 2025 19:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762717507; cv=none; b=k+suuII5uCd+93u1Flcf06eQYHY/l1124zA1nBjbhoEYbHvbzrEEHWyzls2B95PjhrX7wTupmVqNbWT+Y6aMHstN3vKLOskOpvqjTUo2RAA3o58PD4w/JyaUpK/fF4Gc36ugZL3/hYr8gSscjZqAhMlV6cPbdqhlFQjpydSJv3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762717507; c=relaxed/simple;
	bh=vOa8SiUB9bMVWdOM0009Oq0N9NDD8I/oS9vepvTt0Wo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nm0D2CNloJ53WTxS2wZSZY4lpkKKTUVSdgkvzjMZmPxXTAUT4dN85SzGarMaBzBHEO36kVLu/YWu9+BaZC0GaXnoFkgbEezXq+hTcP8DScj/871P/DOcQotP8xDZyVx9Msil1vjMqrvNPhBzo8JhB5NHrx+CVN7XFon0s9rRvjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bfnr7Ypx; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2ed9877e-77e4-4f18-84fd-dc8b1ffe810f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762717502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p8uLNZex+X7rVU7r/Pv+hw/87MXQKP0yAJqx/CR99dg=;
	b=bfnr7YpxXEvB3luL6g1E/jsnvfAGxe/YvR3Bde5K3URHtnjngMWYsxrG7fFNIa4ysx8JGt
	VyPFnDz3YyTrncyO7yoTK8VxBRSPHBAlGgWfr8pRKRzvJttbVbRx87NHy+lbSURrVxX8dB
	cO48uVTP5uDcjbq68PW5KfWJbI+aOjI=
Date: Sun, 9 Nov 2025 11:44:48 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: use preempt_disable/enable() to protect
 bpf_bprintf_buffers nesting
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, chandna.sahil@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 bigeasy@linutronix.de, bpf@vger.kernel.org
Cc: syzbot+b0cff308140f79a9c4cb@syzkaller.appspotmail.comi,
 martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
References: <20251109173648.401996-1-chandna.sahil@gmail.com>
 <588e208637619b6c256f2a70dc35faeafda1a843b6410def9fa53ef8876a46e8@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <588e208637619b6c256f2a70dc35faeafda1a843b6410def9fa53ef8876a46e8@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 11/9/25 10:07 AM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index 865b0dae3..99780b654 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -774,9 +774,11 @@ int bpf_try_get_buffers(struct bpf_bprintf_buffers **bufs)
>>   {
>>   	int nest_level;
>>
>> +	preempt_disable();
>>   	nest_level = this_cpu_inc_return(bpf_bprintf_nest_level);
>>   	if (WARN_ON_ONCE(nest_level > MAX_BPRINTF_NEST_LEVEL)) {
>>   		this_cpu_dec(bpf_bprintf_nest_level);
>> +		preempt_enable();
>>   		return -EBUSY;
>>   	}
>>   	*bufs = this_cpu_ptr(&bpf_bprintf_bufs[nest_level - 1]);
>> @@ -786,9 +788,12 @@ int bpf_try_get_buffers(struct bpf_bprintf_buffers **bufs)
>>
>>   void bpf_put_buffers(void)
>>   {
>> -	if (WARN_ON_ONCE(this_cpu_read(bpf_bprintf_nest_level) == 0))
>> +	if (WARN_ON_ONCE(this_cpu_read(bpf_bprintf_nest_level) == 0)) {
>> +		preempt_enable();
>                   ^^^^^^^^^^^^^^
>
> Can this cause a preempt count underflow? The WARN_ON_ONCE checks for
> nest_level==0, which means bpf_try_get_buffers() was never successfully
> called. In that case, preempt_disable() was never called either, so calling
> preempt_enable() here would underflow the preempt count.
>
> In the normal calling pattern, bpf_try_get_buffers() either succeeds
> (disabling preemption) or fails before reaching bpf_put_buffers(). But this
> WARN exists to catch programming bugs where the get/put contract is violated.
> If such a bug occurs, adding preempt_enable() here makes it worse by
> introducing a preempt count imbalance on top of the original error.

Sorry, Sahil. I made a wrong suggestion earlier and the above AI analysis is correct.
We should not have preempt_enable() in the above. Please make the
change and submit v2.

>
>> +		return;
>> +	}
>>   	this_cpu_dec(bpf_bprintf_nest_level);
>> +	preempt_enable();
>>   }
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19212189476


