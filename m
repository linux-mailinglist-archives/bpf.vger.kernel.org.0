Return-Path: <bpf+bounces-78347-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEA5D0BD15
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 19:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6CD230184DF
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 18:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D340C364E95;
	Fri,  9 Jan 2026 18:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVtB2Xck"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CFB20C490
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 18:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767982978; cv=none; b=rHdfU9E3ppqUYdaqoVZbArl65bZWOrCBrMW/X1Try4BTmIDUu9p+jviVJDhhuPKcYz9DJgAjnrkprlx91BuxXDz3r2xlIT7QDk7sbdCM2MuRZt5oVF50Q780A70VbJGUVrCzi1Wymi2CSsUqWVH3cIwKM4wtvLnfGLtcD/K0AWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767982978; c=relaxed/simple;
	bh=KB1PCnH76BephKPhrr33cUYFfjPudJo4imskyXlNIoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UP8xNX7F32J+oMJ2Op8MnYV6ZSbC4oRAPsMKBYO2RPuMOxQiZwLPJEgZODWslM0aRSsKaD5truV2Alg99cjQ3zVnlWadx1sJOEzEPNjUcW9F4GY8jSgFfSkrqWuLdlwe5xIhWLjKeVN9UJAa5XNZ1cJPRBeyiEI7WA1IpfoOlvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jVtB2Xck; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-477a2ab455fso41797415e9.3
        for <bpf@vger.kernel.org>; Fri, 09 Jan 2026 10:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767982975; x=1768587775; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QUmViYDLjtUImMxM9FQPLVuIi76/dClIXcCVHBwiLVk=;
        b=jVtB2XckfgXWBqQR50Vd46D1XYUzvYpJr0t9yZZ1KouQr2YNix1f53GMz7tlWF2VXv
         Z9R7ageOmtqRFHwLc7QqSrGagLTiAsFQgj07O7IVZpmi5dhI3X95cTdbFo75LLqu4Fmd
         E6Rp9Y0W/ke0D2xpQqOn+cphJQ/HiZgR9hYw8gK+O+UwpYu3nWfIgcGuSAD50bhVozMK
         A/Y2hei5NPsjBcxx2G8dhRl7IWsMs54M8VG44f5EKVgErUSsnjoM6tde2ikQ8W7ojHyl
         rsCSCghTSvp1iiB8e54vAUSwkt27qWorJY5BmmReZy8eXbezNEL+MZ3i0GaR1le+A8Gg
         pwMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767982975; x=1768587775;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QUmViYDLjtUImMxM9FQPLVuIi76/dClIXcCVHBwiLVk=;
        b=nc7H6EJlG/RVXVl6dUKiD2PbsjwG+1EL48SzJ+faEfnyW9doSzOlC/cb+w6XBaiAWH
         MQNZueMdqp5b+gKqzo9C7+V+1RByGyauo0PU8AsyuLPdZlWNK5juNqg4BWQkhyqtwDKL
         jJy05NXhm1FZbYHOmT1utwwP7RaxCW8epvGa8NSneI3bWzymVO/AUN6QL3hPhTIbVZaF
         A9f8iTmtel9x/sq93evKkvKqM33KYwpXKaM23YbVKLSHB5mKWTz8lomlFAvPBs7yvzCc
         gy9ZPPBliyQHCSVsy8Ip43NttDIibEV+a0FJjo61KmsD3bPZ6CG7KrjTZe6AFO4P88Hl
         uz/A==
X-Forwarded-Encrypted: i=1; AJvYcCVR6rNATJTrKnhkunG1GsflXsGWeqqXKtPUTWFUMHMG6WOrPLO8hMMwhqYZgpVuUdoqPUw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc8GP7jyHfAQWG2VWQnJQ6mbBo0id+8L0dhsgAB3Uv8S2Mp1c7
	LDi3vXP+1Mfen/pSNU0fdZGfy2F0463RY2ffBz1o/mteCNybd8HEb1Tc
X-Gm-Gg: AY/fxX6hrNARTb0yfnNM3Yzirp8i9WX1SbCbjcGZFGRuB/Z/zIv1rIkk75qi5IpZSRQ
	Kr7Nqa8R5tqTnZ3ZqyphOM8igZjkzKYXpwVAKhnPzDV9nKaCHQU6KITrqtHzRqKMTvQ7YOJYokJ
	i0QVBLcJ731LagaMFHMQfvlb7wjS3TzJ1i49fxp5m8rH9gBEMc2xqmlfOps1i+7DXHzP9tj8QpR
	wbq5ibbnLQu/L5IfNrB67ZvgHFXsQOwyHru9p2/lWeX4KeXsEo4WyfVrtPS37yupheSTkebXsdC
	ch8a9J2VxGJOpc1VwPzpuA9EDqzMgEzuVFWU6zlNsCmFtEmTD8I1cmkAzTbcJciJuaOWtaiFZnE
	boiMf+M45Fs/j92qXwYwifiaaxIBnu/dq7pd64FEFkJfCdqspcVlKGWXlsnQvlIr8s3y5SmG2qs
	rRVAs7g81IRRlVKsH67M+QeI0NnX89wrU=
X-Google-Smtp-Source: AGHT+IGHEM4BexdBDb4oMRo4XK/8QGcmcow0F8qwi5uUNLn3Q0o/UOCr4ZpiZNkkuBfZob4sq0GFfw==
X-Received: by 2002:a05:600c:46c4:b0:47d:403e:4eaf with SMTP id 5b1f17b1804b1-47d84b18ef7mr136241335e9.10.1767982974941;
        Fri, 09 Jan 2026 10:22:54 -0800 (PST)
Received: from ?IPV6:2620:10d:c0c3:1130::1235? ([2620:10d:c092:400::5:4113])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f410c6csm232701595e9.1.2026.01.09.10.22.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jan 2026 10:22:54 -0800 (PST)
Message-ID: <c5269858-7285-4e44-a5ef-72e69e9c00a2@gmail.com>
Date: Fri, 9 Jan 2026 18:22:53 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 04/10] bpf: Add lock-free cell for NMI-safe async
 operations
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, eddyz87@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
References: <20260107-timer_nolock-v3-0-740d3ec3e5f9@meta.com>
 <20260107-timer_nolock-v3-4-740d3ec3e5f9@meta.com>
 <CAP01T77h5caT6EprhREYMNmjTkbBZ9-OT7HkxdnJUNNME2evQQ@mail.gmail.com>
 <e4eee776-e9c7-4186-b239-733f81a9ae4a@gmail.com>
 <CAEf4BzYY0s6yF8JACTENANzJXd6abZctiB1iP+jYARq_xPDm0A@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAEf4BzYY0s6yF8JACTENANzJXd6abZctiB1iP+jYARq_xPDm0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/9/26 01:18, Andrii Nakryiko wrote:
> On Wed, Jan 7, 2026 at 11:05 AM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>> On 1/7/26 18:30, Kumar Kartikeya Dwivedi wrote:
>>> On Wed, 7 Jan 2026 at 18:49, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com> wrote:
>>>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>>>
>>>> Introduce mpmc_cell, a lock-free cell primitive designed to support
>>>> concurrent writes to struct in NMI context (only one writer advances),
>>>> allowing readers to consume consistent snapshot.
>>>>
>>>> Implementation details:
>>>>    Double buffering allows writers run concurrently with readers (read
>>>>    from one cell, write to another)
>>>>
>>>>    The implementation uses a sequence-number-based protocol to enable
>>>>    exclusive writes.
>>>>     * Bit 0 of seq indicates an active writer
>>>>     * Bits 1+ form a generation counter
>>>>     * (seq & 2) >> 1 selects the read cell, write cell is opposite
>>>>     * Writers atomically set bit 0, write to the inactive cell, then
>>>>       increment seq to publish
>>>>     * Readers snapshot seq, read from the active cell, then validate
>>>>       that seq hasn't changed
>>>>
>>>> mpmc_cell expects users to pre-allocate double buffers.
>>>>
>>>> Key properties:
>>>>    * Writers never block (fail if lost the race to another writer)
>>>>    * Readers never block writers (double buffering), but may require
>>>>    retries if write updates the snapshot concurrently.
>>>>
>>>> This will be used by BPF timer and workqueue helpers to defer NMI-unsafe
>>>> operations (like hrtimer_start()) to irq_work effectively allowing BPF
>>>> programs to initiate timers and workqueues from NMI context.
>>>>
>>>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>>>> ---
>>> We already have a dual-versioned concurrency control primitive in the
>>> kernel (seqcount_latch_t). I would just use that instead of
>>> reinventing it here. I don't see much of a difference except writer
>>> serialization, which can be done on top of it. If it was already
>>> considered and discarded for some reason, please add that reason to
>>> the commit message.
>> yes, multiple concurrent  writers support would is the main difference
>> between seqcount_latch_t and my implementation. I'll switch to
>> seqcount_latch_t and external synchronization for writers.
> One advantage of custom primitive is that we don't need a second
> atomic counter for writers. Here we combine the reader latch counter
> (it's just scaled 2x for custom implementation) and "writer is active"
> bit (even/odd counter).
>
> With potentially millions of timer activations per second for some
> extreme cases, would performance be enough reason to have custom
> "seqlock latch"? (I'm not sure myself, trying to get opinions)
>
Actually seqcount_latch_t variant may be faster (correct me if I'm wrong),
because mpmc_cell requires 2 lock prefixed instructions to enter the write
critical section and seqcount_latch_t just 1.

mpmc_cell:

if (1&atomic_fetch_or_acquire(1, &ctl->seq)) // first lock prefixed insn
return;
...
       atomic_fetch_add_release(1, &ctl->seq);     // second lock 
prefixed insn

seqcount_latch_t based:

     if (atomic_cmpxchg(&ctl->lock, 0, 1))        // first lock prefixed 
insn
         return;
write_seqcount_latch_begin(&ctl->seq);       // inc with barriers
     ...
     write_seqcount_latch(&ctl->seq);            // inc with barriers
     atomic_set(&ctl->lock, 0);            // plain mov on x86_64

Does it look right?
>>>>    [...]
>>>>


