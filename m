Return-Path: <bpf+bounces-30405-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A19048CD898
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 18:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5527A1F215D8
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 16:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCADA18643;
	Thu, 23 May 2024 16:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j/j1L04R"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FF0381B0
	for <bpf@vger.kernel.org>; Thu, 23 May 2024 16:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716482573; cv=none; b=Z6wMZcajJUkn0zz16Kahu9ov/dl1vvT2ImRgT6Z/DXh9+eDr4Ku2MdNKgw6JRjhsp7R5Mazvee5OcPmwjq9/zZQRfhNub8Cqnl3cTvLM7LL1KIRZxGGanmMn7DxMefXalJWdNTWwpTn6zqKfsnN/UCogCC1WkC3vcP2KVpbgSDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716482573; c=relaxed/simple;
	bh=ViAsSM/Dd7JgZ/R/bdTlnz8bvBgRKV3y4AkDI4nyPvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ohYggIKjcbwLU+Q1c+nv6R3DCORK4zeJ6W0wjquKYimPaW/Jwi5OZrcdh1Ebzd69oYpknpE2j4FiWkRjyJeNcKIZUvF6jx3T/2Qe+m4Lm7PyrQ2WUt1MAsCcPRbYErHOh6sZSnqG+uVbdsTB+YXZxFrvamPBZahnfpxHRH0Pgcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j/j1L04R; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-241572c02efso3482308fac.3
        for <bpf@vger.kernel.org>; Thu, 23 May 2024 09:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716482571; x=1717087371; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LcLET6cJUDpHFxvGyQxztE4W0pAjqFPeS4EkRT6BfGA=;
        b=j/j1L04RlrmFPJYj3cOX8to6NWXRuWkgyipps92uJVe2wBYi1U/xrVt/RGb1uLaD48
         aTysW+FtS8AsLQ1Tde0NmdonvTIvOIf5Vo1I5lXbx/SO553nolPTWRTgiIHuySQMwUtz
         3lZFoSQjGkFc0Qnwx5q3U7dsE7X9YJLf738eBFQZFNtghWSjQ9daSdM7lvuaNEf0xtTM
         pIIgoyW7m2bpHibVX09SxR2RXj+TsheuhWOAsCdZL2iB+uVOzdGJ7e3gyf45x96gHjW0
         7dq03OWInvJ3KaKg2qeeOUmY2OocUT2eCosU78uLj2YqlU6Z6VR6aKDfi4eLBVaVbCQh
         sXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716482571; x=1717087371;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LcLET6cJUDpHFxvGyQxztE4W0pAjqFPeS4EkRT6BfGA=;
        b=GbtG2n0ctzVz2xV20sgDa/C+VwMgp/qPIYuXGMgL6t3Tr0cgX1+KJW8FRBvt5EyFii
         w8j9NX4qOaKO0164qcygafcUT8ZAVFjrcTyq8XnJ4lWQ4lNLLd7VQcj9RrgX9rraOLtd
         N1wM+t97kboaObkxjWKNp6SPebOUCFDr1bEeh3sQB5OB0ZdG88o/tFyC98iih2IgHf+C
         2Mo2O0mgs7tEMiUWktIUUvBJpOOpwdc+G7jYQMJlHcrxBgmgxUOGYteiEiWIfGEe08Rb
         CmVkIGKW0OxGMojKd8Rj7Vv2D8W+gOlDyazx0tr+DMv09Sz113OtT7t6g5tuoeHPZ4cW
         +Jxg==
X-Gm-Message-State: AOJu0Ywhxl8vJ2zu+mhQ/mEr16z4AfzM4rzzbx/4gYxIUq95UqeHDu1n
	Finmpu4F3HwrcawJ00JQ1lmk5fYJ3FKV0fc5d+lXTtevEkHXv6nl5YvFvU2RmQ==
X-Google-Smtp-Source: AGHT+IGRMU4wl6MpuCgO4dbcgvnTgBkfEna+qVu+iksHoaSZoAEqAe9X6BC55zfsq9z4SAtf+Lr5hA==
X-Received: by 2002:a05:6870:a991:b0:222:11f2:11d8 with SMTP id 586e51a60fabf-24c68bd263cmr6488454fac.26.1716482571009;
        Thu, 23 May 2024 09:42:51 -0700 (PDT)
Received: from [192.168.1.8] (c-73-238-17-243.hsd1.ma.comcast.net. [73.238.17.243])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43f9236393csm38695941cf.5.2024.05.23.09.42.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 09:42:50 -0700 (PDT)
Message-ID: <28aaad42-3859-43ea-8a45-dbe83bcfd5d0@google.com>
Date: Thu, 23 May 2024 12:42:48 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BPF timers in hard irq context?
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Dohyun Kim <dohyunkim@google.com>,
 Neel Natu <neelnatu@google.com>
References: <3faf9614-d61c-47a4-b8ba-6d97ae71fd44@google.com>
 <CAADnVQJw=mEX7ZEKffGMUm9my1Di9wFHwayhz+4vno_fypmnsQ@mail.gmail.com>
From: Barret Rhoden <brho@google.com>
Content-Language: en-US
In-Reply-To: <CAADnVQJw=mEX7ZEKffGMUm9my1Di9wFHwayhz+4vno_fypmnsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/22/24 16:03, Alexei Starovoitov wrote:
> On Tue, May 21, 2024 at 2:59 PM Barret Rhoden <brho@google.com> wrote:
>>
>> hi -
>>
>> we've noticed some variability in bpf timer expiration that goes away if
>> we change the timers to run in hardirq context.
> 
> What kind of variability are we talking about?

hmm - it's actually worse than just variability.  the issue is that 
we're using the timer to implement scheduling policy.  yet the timer 
sometimes gets handled by ksoftirqd.  and ksoftirqd relies on the 
scheduling policy to run.  we end up with a circular dependence.

e.g. say we want to let a very high priority thread run for 50us. 
ideally we'd just set a timer for 50us and force a context switch when 
it goes off.

but if timers might require ksoftirqd to run, we'll have to treat that 
ksoftirqd specially (always run ksoftirqd if it is runnable), and then 
we won't be able to let the high prio thread run ahead of other, less 
important softirqs.

>> i imagine the use of softirqs was to keep the potentially long-running
>> timer callback out of hardirq, but is there anything particularly
>> dangerous about making them run in hardirq?
> 
> exactly what you said. We don't have a good mechanism to
> keep bpf prog runtime tiny enough for hardirq.

i think stuff like the scheduler tick, and any bpf progs that run there 
are also run in hardirq.  let alone tracing progs.  so maybe if we've 
already opened the gates to hardirq progs, then maybe letting timers run 
there too would be ok?  perhaps with CAP_BPF.

barret



