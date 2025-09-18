Return-Path: <bpf+bounces-68731-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A57B82A63
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 04:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB7491B25A05
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 02:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BA6224AE8;
	Thu, 18 Sep 2025 02:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O82Wc8su"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B1A199934
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 02:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758162342; cv=none; b=bFScKokIi373VTBxu1EDN6WKxO1fy/xxZQAXcn+tP3R9kUIwm/YcrAPoXOm8uD57yJxMtq+BDteixIqOMDuqNhxim8fiscfe5IT1XFMUPmpbE8XOsLF5hYewK5UkPGDptQKktnsNLQ9SvOVH/yuRgwFcuoL7toqTwONNr89muJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758162342; c=relaxed/simple;
	bh=wlZTf3NJnH5mVdJnc5Nsv3XhqHq7lIfDW9F4W0DwgXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TvcrUmPfL9CyR2LruJnoXv3vZKbrhSCigSuFvR2G8WbL9zPSZiv/MA5Ns2iqASK8FQRyLb/y8YMVxSYYPP9cDk9/6hYqqaCIS3KsP9WhZX2ZkmRX/MSXVeODJcEJz0I2DR4OHC7R1x0SV5tWFFB83MIdFR+q8gJWFFawn2E5pPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O82Wc8su; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so473319b3a.0
        for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 19:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758162340; x=1758767140; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LoGnYSZgAtcI6RX+2p0NHTfZxcoF4uSXniUMX1MCOd8=;
        b=O82Wc8sucNuRvIBPLG0uH+JWyTh5Yw75jswXwOGbs8QSGAUiYzwNYXj1Ms1OqMSAf3
         4xgf+Wb0C6FefoMEFJdDhev1InzIuK2N4LHoLlxhIOJNdQ/8QcmRRph3cWSBRYjIFrau
         53MXkYYqQDFghSXHz4+eJCWr5zhqZXTTj3hmMxX0tqs1adh5tR6NBYVyvlaCw3dbmcTp
         kP4gkZmD5+M+AZ7ksaJyHgBmkZDAoJ/CyE/Ss7QdOPUpAWczNKWUD3yFr/Qa0gVQWN0t
         Yd1QOFRsyajwfbfTw2lVetD5gsq4yXQRf1Bz3prnXUq0N6DPNP0TeOGL3L4W1fWkMxOF
         b4bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758162340; x=1758767140;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LoGnYSZgAtcI6RX+2p0NHTfZxcoF4uSXniUMX1MCOd8=;
        b=H3JDYtU+ZpC/WLI1KcfLL5/kEWyspGOjdd6rMPu9/DRfL7MqD4CGotKswwWAzmRrBZ
         QTFL8ANZrvzEFycFzNN9Ki2M3DaLWc167y3nnFeKtXR+sqNjK1bsG6/LkVak1DwtqClV
         dP2Lr4zO8+5xohXu5VvA8DsiYdWbvOiCxICRby/kX/oV1RaZtLlma1Ae2byELK7Bxn+6
         //Y5Xb+MSVXNN6wC2GhIl/IKDFoPM021uZBupgDEZGx8sXlgcI1SDEIh9lUkbpM7Eege
         uDEOFvtIeXS8i8NJ/3SVqTL6rccD2bgs5oxro9Ni68oC8qt8TICCHJXOfuAnl758RKOE
         9QWA==
X-Forwarded-Encrypted: i=1; AJvYcCVzFSdavRIHetP8DHY5XgJtmyblmdT5XGSWt13pk2YtDcoNDE54Iip2Q9XItGSNktM78pY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrgdYsdyytKFXmIMC/jmw63zINSnGw7lZ855M2eVo7klXts5u0
	qo9gKtCYwUw1br1iKUGO6lohk/a5udFMA9iUSZtfSLAcY0LtKpWuzsPI
X-Gm-Gg: ASbGnctf9K2earQAsl2ym0AvemfOavpNTZGPbLeWQiDFFCg3Jimh65AFsPKzb8RNVPF
	T2OgUv3w+mT/hJ76RzgDWoMk5o+yi15IAAzfMP7T/PiXTDYc6lJYu+ApmG9If1MsumF24y/lFgQ
	WxNsegGYaNk5okTBLJHVORuL0GT72NxRgg+b8yXLahLEMNAS9x+62I2R2zIobmp7t1Y1cDceK8l
	mjG8X5mbgpTftOQ86KBQglg8Jd5+bP3D8dwMz6c/Ao5rt8bD2TRUz8byI7Y+6vKKsH/iy6h3Uaz
	HRG+xJs6mCEw+jqakRY+Jbz2LKLGcIEXiGyDQNjOFX+9qLSs+iMyBfwmNUxNgs/XqZEtHYFkFJ6
	rflTWL+AEwCeeyq8A4gWA31d7leL/hSpveHa6QrDG51O1mlPInvmAiqhS1TMz4+co
X-Google-Smtp-Source: AGHT+IH23/QNjkr0XnhixJWtwUO4UB9d4Bf0pTas5dB4eHXbG2y1CVq0dg2PWctitOEwl7D5dcIDHQ==
X-Received: by 2002:a05:6a20:7d9b:b0:243:fedf:b413 with SMTP id adf61e73a8af0-27aa1c7a8e8mr5592385637.33.1758162340322;
        Wed, 17 Sep 2025 19:25:40 -0700 (PDT)
Received: from [10.22.65.172] ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cff229940sm720528b3a.99.2025.09.17.19.25.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 19:25:39 -0700 (PDT)
Message-ID: <2866fd41-96aa-4528-800b-f8c110f43401@gmail.com>
Date: Thu, 18 Sep 2025 10:25:36 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpf: support nested rcu critical sections
Content-Language: en-US
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: kkd@meta.com, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, kernel-team@fb.com
References: <20250916113622.19540-1-puranjay@kernel.org>
 <c6e2c3c6-2ce5-4b52-8429-bcda39e452ab@gmail.com>
 <mb61pa52tqiq8.fsf@kernel.org>
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <mb61pa52tqiq8.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 17/9/25 22:03, Puranjay Mohan wrote:
> Leon Hwang <hffilwlqm@gmail.com> writes:
>
>> On 16/9/25 19:36, Puranjay Mohan wrote:
>>> Currently, nested rcu critical sections are rejected by the verifier and
>>> rcu_lock state is managed by a boolean variable. Add support for nested
>>> rcu critical sections by make active_rcu_locks a counter similar to
>>> active_preempt_locks. bpf_rcu_read_lock() increments this counter and
>>> bpf_rcu_read_unlock() decrements it, MEM_RCU -> PTR_UNTRUSTED transition
>>> happens when active_rcu_locks drops to 0.
>>>
>>> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
>>> ---
>>
>> [...]
>>
>>> @@ -13863,7 +13863,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>>  	preempt_disable = is_kfunc_bpf_preempt_disable(&meta);
>>>  	preempt_enable = is_kfunc_bpf_preempt_enable(&meta);
>>>
>>> -	if (env->cur_state->active_rcu_lock) {
>>> +	if (env->cur_state->active_rcu_locks) {
>>>  		struct bpf_func_state *state;
>>>  		struct bpf_reg_state *reg;
>>>  		u32 clear_mask = (1 << STACK_SPILL) | (1 << STACK_ITER);
>>> @@ -13874,22 +13874,22 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>>  		}
>>>
>>>  		if (rcu_lock) {
>>> -			verbose(env, "nested rcu read lock (kernel function %s)\n", func_name);
>>> -			return -EINVAL;
>>> +			env->cur_state->active_rcu_locks++;
>>
>> Could we add a check for the maximum of 'active_rcu_locks'?
>>
>> From a cracker's perspective, this could potentially be abused to
>> stall the kernel or trigger a deadlock. Underneath 'rcu_read_lock()',
>> there are several RCU functions that tracing programs are able to
>> attach to. If those functions are traced, a deadlock can be triggered.
>>
>
> IIUC what you are saying is that if I attach a BPF tracing program to
> something under rcu_read_lock() and then call bpf_rcu_read_lock() in the
> BPF program then there could recursion? Wouldn't that be triggered even
> with a single call to bpf_rcu_read_lock() ?
>

The recursion can happen, yes. But BPF tracing programs won't run
recursively.

However, the deadlock I ran into wasn’t caused directly by recursive BPF
programs, and I haven’t yet tracked down the exact root cause.

That said, even a single call to bpf_rcu_read_lock() can potentially
trigger a deadlock.

So I think it would be better to add bpf_rcu_read_lock() and
bpf_rcu_read_unlock() to the btf_id_deny list, similar to
__rcu_read_lock() and __rcu_read_unlock().

Thanks,
Leon

