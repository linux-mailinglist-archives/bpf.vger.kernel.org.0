Return-Path: <bpf+bounces-66499-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 399FAB3520A
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 05:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AE0F1A82EA9
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 03:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10B429DB6C;
	Tue, 26 Aug 2025 03:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vM5aflp6"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D25F163
	for <bpf@vger.kernel.org>; Tue, 26 Aug 2025 03:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756177530; cv=none; b=D2HPSlRb7u9sikZlrZj+st+5nH4sy65h5Y87Pn4MIL/0AcBPbL0oZ9+4tq1UuAKydRsHt54XgZxl8NyhlP79zsrfpFQpwgaHCi5xlaQ0BhxgRJc0k4zPoK5I6Bd/5KLjFgZ6fpgcmAR+Fde/JRe3EXmw4pqIgRf7JvLp7dfhi+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756177530; c=relaxed/simple;
	bh=e/WdOUdxIchsQWRFxui/BH5icg3mkdz+Lc6gf9MDykk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iRvsnQxxpNSuuafklLxcoMqAl7XJnMlzycvKP93MHom+SHGVzndTJT90KZkBHUYEbXm14YiDg7MA4aVEWq/16NBLTcCHsaHLYkYx+6fhZ61sThntUeMh3yKdmi9oRyMigmrfBLaNtrCX+vfFhxMw6omluDitOx30qQcOuKeMaEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vM5aflp6; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <312530ee-3f80-4f07-a533-7341bc1d09a8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756177526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CcmfzfjR7vsvbBXm4SSTlo06/LWvjFroTKIO669729I=;
	b=vM5aflp6zVyEE5DOh4CtNW21SeLqC+wlJJiCeZmDzWNzMhfVm6dY/u/oMmBJGIHK3+lyTo
	cjG7pbZ6FsUHMHkQ9vcjR/o/SFEFRiW8TbNck8SoCXjD4K5OoEoWpNnOPI9/vImMrmrVnp
	Tw3S02OSvFQN57wLvu//4NL0UMXOlaY=
Date: Tue, 26 Aug 2025 11:05:20 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Add case to test
 bpf_in_interrupt kfunc
Content-Language: en-US
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 kernel-patches-bot@fb.com
References: <20250825131502.54269-1-leon.hwang@linux.dev>
 <20250825131502.54269-3-leon.hwang@linux.dev>
 <c37eb846e94c11b74301a699b64037e9d247ba9e.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <c37eb846e94c11b74301a699b64037e9d247ba9e.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 26/8/25 01:26, Eduard Zingerman wrote:
> On Mon, 2025-08-25 at 21:15 +0800, Leon Hwang wrote:
>>  cd tools/testing/selftests/bpf
>>  ./test_progs -t irq
>>  #143/29  irq/in_interrupt:OK
>>  #143     irq:OK
>>  Summary: 1/34 PASSED, 0 SKIPPED, 0 FAILED
>>
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
>>  tools/testing/selftests/bpf/progs/irq.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/progs/irq.c b/tools/testing/selftests/bpf/progs/irq.c
>> index 74d912b22de90..65a796fd1d615 100644
>> --- a/tools/testing/selftests/bpf/progs/irq.c
>> +++ b/tools/testing/selftests/bpf/progs/irq.c
>> @@ -563,4 +563,11 @@ int irq_wrong_kfunc_class_2(struct __sk_buff *ctx)
>>  	return 0;
>>  }
>>  
>> +SEC("?tc")
>> +__success
> 
> Could you please extend this test to verify generated x86 assembly
> code? (see __arch_x86_64 and __jited macro usage in verifier_tailcall_jit.c).

I’ll try to extend it, depending on the specific x86 implementation.

> Also, is it necessary to extend this test to actually verify returned
> value?

Not necessary — let’s just return 0 here.

Thanks,
Leon

> 
>> +int in_interrupt(struct __sk_buff *ctx)
>> +{
>> +	return bpf_in_interrupt();
>> +}
>> +
>>  char _license[] SEC("license") = "GPL";


