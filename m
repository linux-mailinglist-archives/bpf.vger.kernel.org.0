Return-Path: <bpf+bounces-67934-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B97CB505C0
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 20:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2288C5E41C6
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 18:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743D53570DF;
	Tue,  9 Sep 2025 18:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDW9cz04"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045F735CEDB
	for <bpf@vger.kernel.org>; Tue,  9 Sep 2025 18:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757444358; cv=none; b=egd04Mfl4YtYOuZeZjCSY7MC1vJouMfdrNp2dCZXtNINTYUUFRis2oY5gwhLzMVOiuAnWvC88v6V7i8jjiY/35+DxtRcBQ8M+D9J8iqFeJ3GppbtmCQ5M/rqYyYh9gi0VtSdkLj7+aLlFB/x72bwuDdFv1AJrcWTZ77l1mKW+Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757444358; c=relaxed/simple;
	bh=eL0OwzZM2j4uzHo/+cUow0OvwunZD5L7/Jc67NKlzbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r/UiR66Qm5y/aVrTBLmhlgmFMW44M8CfF76223YAWnPWGmGEhwrxza2ERa5lBXiuyYMJTrAVJLTTuEkLsi8L7OrD44Ng8yeD4+adAVMlh05Tl3v94mLUNAavLx5Ikg+NNu3vCREfzfECNB3VojTvQAN9+qYucp3tCBa92+MPPIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nDW9cz04; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45deccb2c1eso11116045e9.1
        for <bpf@vger.kernel.org>; Tue, 09 Sep 2025 11:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757444352; x=1758049152; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CFSG715nnJg/HAlxZHxW0/scYOQ2bqAMQrWdc22Zb2U=;
        b=nDW9cz0412Jo/CIgMPyNPz42zLK1cR6xHiESG/SyZiJX2MysVEPvsUnkL64hWQUtDw
         onbDinzE3Pxwn3tReN8u+ZJZI0V2wvjT3k4raUF+xNRTL1Nx/nA9klfmQRTA3OneBM+/
         N9QN0d9IFBW17OU1lBX6zdAzznaxbDjKySwAc9Clv5CV7p4zDpOOhCEZnoD511H/eFYe
         /AwXbGcFzM6zxldBWBSX6yJExpQ/d1Q+rHgOCgDfhfH/9qzYI5IjaGfzgbxg9uKZ0uqx
         CoEE/znryLiR5uYBdr6dbGOtMXbYjIJ1ucS1/eDG7MG4Lu316I/DHE8f4iT2cAvzLq+M
         t2rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757444352; x=1758049152;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CFSG715nnJg/HAlxZHxW0/scYOQ2bqAMQrWdc22Zb2U=;
        b=tQ55WT11Djcg0TznmCpf4Vm0nIiWiV/nn6A50pL4QUWAiU5QoqqS5Z90QSgAyLS/Gb
         Bt3hqX01UDS8y0hOqQsqz8EhbBmzmEF7exWJVHl77HmN0KvIryMyIlnbWeUiNm+WeqCQ
         ekTe1E8dsnnjmbIskfzv7+uAy0GER1d2qgwU7x5B/dKpIHneZCxUcmoN6hLyzA0UKFlu
         ZgS+hRYhBJM0YXE0g579bj/xwhBtN+4wcxDD8eJu93vq+7ZudUubNyZFeydx4SlmG8rx
         mk1GmT6Xvc6TN3pZsmBYJ9S84Y9/IAGBYHwuO1ttM43j27TnGjgJUNmh605o7gtKbpqr
         FB9g==
X-Forwarded-Encrypted: i=1; AJvYcCW5XTkg5FP2URi/yxJP8NZyojhL90nKRSzLXUK4ZvIaBovpJ9b6q1eXNgBLECjdl/q1Xxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwJZpsp5B0N+mwB6x1u5h9ZKv1F50mSFJOHPTdCRTIsDaappb7
	A5MGeSjxJoWAfhy27wg9VkdzNs1DoW+aKRzuTYRkOJjdhMaZIxR3vMMA
X-Gm-Gg: ASbGncvWNgOkEM9T4pWun6C0p2LM5USk7mRKziZ/VdXV7WlytXpPiSCClpx2lKebCgA
	92zB/ezJUWupl7sZy1cdAGpd97uJRVIxMp2xTe46CyaPfOj6DccvEnmFSgBm9e53HmMsmoyQMe5
	mQ9z1089wox/4/TH8r0mW3lk6cECNbgP1V0s+21+7r3P41ymoqFVZkDDDerKYAajVmO9VaL3zX0
	yeiEU+onpJe6A0bM/UD1BBQPynuq7eUTq7qZHqKs7B4YVUGBNtqT50zwRJaKTtU2TN0K+bbnZ+V
	CD1FUrTo0DpOs/ekUofYBrtKTdsMTh/81ANtD/U/lcC0tAaTfD0B+GrXTBsJv8Xgro6wA1GwLUI
	zNlDvNAojhuVtAKxrj/q3EoPbPD5Ze6JIDm9ld+spnxu1RyqCRaeipFNrkHaKi1ztoGzMQSoeJq
	hQZoBj9g==
X-Google-Smtp-Source: AGHT+IFr5f9PGraYmQMjYCiRxa7MUAWtFctNdAotHsDdGaNpxqcKMOema0Lg4I/SjMXE2mz2hk9gjQ==
X-Received: by 2002:a05:6000:1789:b0:3d9:7021:fff0 with SMTP id ffacd0b85a97d-3e6440ef054mr8639828f8f.37.1757444352174;
        Tue, 09 Sep 2025 11:59:12 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7? ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45cb687fe4esm267337795e9.23.2025.09.09.11.59.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 11:59:11 -0700 (PDT)
Message-ID: <9a79c79a-8273-4cc7-a073-95046f95e14c@gmail.com>
Date: Tue, 9 Sep 2025 19:59:10 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 6/7] bpf: task work scheduling kfuncs
To: Chris Mason <clm@meta.com>, bpf@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, eddyz87@gmail.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20250905164508.1489482-1-mykyta.yatsenko5@gmail.com>
 <20250905164508.1489482-7-mykyta.yatsenko5@gmail.com>
 <5d6226f6-c3ae-4e68-a420-76f553a462ec@meta.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <5d6226f6-c3ae-4e68-a420-76f553a462ec@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/9/25 18:49, Chris Mason wrote:
> On 9/5/25 12:45 PM, Mykyta Yatsenko wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Implementation of the new bpf_task_work_schedule kfuncs, that let a BPF
>> program schedule task_work callbacks for a target task:
>>   * bpf_task_work_schedule_signal() → schedules with TWA_SIGNAL
>>   * bpf_task_work_schedule_resume() → schedules with TWA_RESUME
>>
>> Each map value should embed a struct bpf_task_work, which the kernel
>> side pairs with struct bpf_task_work_kern, containing a pointer to
>> struct bpf_task_work_ctx, that maintains metadata relevant for the
>> concrete callback scheduling.
>>
>> A small state machine and refcounting scheme ensures safe reuse and
>> teardown:
>>   STANDBY -> PENDING -> SCHEDULING -> SCHEDULED -> RUNNING -> STANDBY
>>
>> A FREED terminal state coordinates with map-value
>> deletion (bpf_task_work_cancel_and_free()).
>>
>> Scheduling itself is deferred via irq_work to keep the kfunc callable
>> from NMI context.
>>
>> Lifetime is guarded with refcount_t + RCU Tasks Trace.
>>
>> Main components:
>>   * struct bpf_task_work_context – Metadata and state management per task
>> work.
>>   * enum bpf_task_work_state – A state machine to serialize work
>>   scheduling and execution.
>>   * bpf_task_work_schedule() – The central helper that initiates
>> scheduling.
>>   * bpf_task_work_acquire_ctx() - Attempts to take ownership of the context,
>>   pointed by passed struct bpf_task_work, allocates new context if none
>>   exists yet.
>>   * bpf_task_work_callback() – Invoked when the actual task_work runs.
>>   * bpf_task_work_irq() – An intermediate step (runs in softirq context)
>> to enqueue task work.
>>   * bpf_task_work_cancel_and_free() – Cleanup for deleted BPF map entries.
>>
>> Flow of successful task work scheduling
>>   1) bpf_task_work_schedule_* is called from BPF code.
>>   2) Transition state from STANDBY to PENDING, marks context is owned by
>>   this task work scheduler
>>   3) irq_work_queue() schedules bpf_task_work_irq().
>>   4) Transition state from PENDING to SCHEDULING.
>>   4) bpf_task_work_irq() attempts task_work_add(). If successful, state
>>   transitions to SCHEDULED.
>>   5) Task work calls bpf_task_work_callback(), which transition state to
>>   RUNNING.
>>   6) BPF callback is executed
>>   7) Context is cleaned up, refcounts released, context state set back to
>>   STANDBY.
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
>>   kernel/bpf/helpers.c | 319 ++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 317 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index 109cb249e88c..418a0a211699 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
> [ ... ]
>
>> +static void bpf_task_work_irq(struct irq_work *irq_work)
>> +{
>> +	struct bpf_task_work_ctx *ctx = container_of(irq_work, struct bpf_task_work_ctx, irq_work);
>> +	enum bpf_task_work_state state;
>> +	int err;
>> +
>> +	guard(rcu_tasks_trace)();
>> +
>> +	if (cmpxchg(&ctx->state, BPF_TW_PENDING, BPF_TW_SCHEDULING) != BPF_TW_PENDING) {
>> +		bpf_task_work_ctx_put(ctx);
>> +		return;
>> +	}
>> +
>> +	err = task_work_add(ctx->task, &ctx->work, ctx->mode);
>> +	if (err) {
>> +		bpf_task_work_ctx_reset(ctx);
>> +		/*
>> +		 * try to switch back to STANDBY for another task_work reuse, but we might have
>> +		 * gone to FREED already, which is fine as we already cleaned up after ourselves
>> +		 */
>> +		(void)cmpxchg(&ctx->state, BPF_TW_SCHEDULING, BPF_TW_STANDBY);
>> +
>> +		/* we don't have RCU protection, so put after switching state */
>> +		bpf_task_work_ctx_put(ctx);
>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> Do we want to return here?  I didn't follow all of the references, but
> even if this isn't the last reference, it looks like the rest of the
> function isn't meant to work on the ctx after this point.
Thanks for taking a look! That's right, we should return there.
>
>> +	}
>> +
>> +	/*
>> +	 * It's technically possible for just scheduled task_work callback to
>> +	 * complete running by now, going SCHEDULING -> RUNNING and then
>> +	 * dropping its ctx refcount. Instead of capturing extra ref just to
>> +	 * protected below ctx->state access, we rely on RCU protection to
>> +	 * perform below SCHEDULING -> SCHEDULED attempt.
>> +	 */
>> +	state = cmpxchg(&ctx->state, BPF_TW_SCHEDULING, BPF_TW_SCHEDULED);
>> +	if (state == BPF_TW_FREED)
>> +		bpf_task_work_cancel(ctx); /* clean up if we switched into FREED state */
>> +}
> -chris


