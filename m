Return-Path: <bpf+bounces-68797-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2F4B84F3C
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 16:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEF061C844AE
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 14:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CA830B535;
	Thu, 18 Sep 2025 14:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c66BuhDU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C993090D5
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 14:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758204165; cv=none; b=V3TiqvlnPNt93S8TESNgU0L5yDaacZNJkn9DmC0gjV2h51khFeI75eR9PgSSquu69P5EFOjfcBdJ9Vdb3FxaSUEwvIStr7NL8xbCEor2RXZWBw8fn+7/ta7GfFGM9PvclJa64+3RW3+kO2gIwvvehKhdXMFfv2KCM1WMvKpsrp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758204165; c=relaxed/simple;
	bh=7DxiVZomtHttdNtYwiCoYKvuHHIGERwqhwTSvLZkurI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B6XZAdtxm8JVneEw/5KseUPq3apwGMAUx0UvgHg/7LX6IT741AJe2uPseier7lDexSCkH46/AU0z1MP/N1Nb3u7SDuTBzcWzi04wt1nCmbeFTNhfSWYKF10RjuYlLv6UGtIHchVU6Bpv3spoXFqt+RoDqi9KgA+UzVGrl5jw3kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c66BuhDU; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45df7dc1b98so6407245e9.1
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 07:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758204162; x=1758808962; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rksf7AtwrCN8O553SwtijdEzlwIt06/Sc9MwW1CdYCM=;
        b=c66BuhDUsh8GdHxZ7uRYmjO+8zXRTE+de2u/S52/m2XFCB3CGOjNVKngr7d4MqvDuf
         LPpNJ7Jmspu0dzJOVJZwqrconin2Q+Wm5JQz30P8SqHza9XuVX2CuJpAYGwL/wEdWizb
         dgF9p6VXSGRNom+nMhrd95Wla0qfoA09pS5UlKFwGnSi7dLbH0ygT1icqXcE47CaBrRk
         ZV3kSsw2nH039IDrunNRLpBUzTqvvpJRfZF3+GSJ4zCpnM5d1OxxHjq8Wd+FhYh+RthJ
         XnRT7EWR1c98LX7QXMt3UD5bSsY3XRVGrkrnELTDQxpeCGxXjj1/p0rrXuJY5dMoOZZg
         7H/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758204162; x=1758808962;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rksf7AtwrCN8O553SwtijdEzlwIt06/Sc9MwW1CdYCM=;
        b=SlK+Fo0o49RH04xM+ZE8Jf8qjSQIirSBpoHjlQ/+hNB193EOQBpukr+qxWgtgsSHzN
         GJ79/vJeDYaIxqoW5oeWHKG2ZhwKBqSualJofurZbQTkrre7Bh+0N4vR5XF/HYHx5NbC
         fWfQRs4hTwOitU9Kj7zQiXGcZiiMScBorRI8Ma7B2tFXwIXcJA4gK6yzmYJZNY+zX9Wn
         SaNlcBWywKRKUBWWrCqX0vHQq7OLHxUw/zhmVW1v31w/Mg0hgyT9NiegwwO03/S/nWVb
         opz6iSM77ScMT2edhQuVnygy7hqc+M5NvddBN30dRsoqG1EoLKzpBmv4sSbdP7CnBdG/
         VZnQ==
X-Gm-Message-State: AOJu0YwsRVz9ckMuRgQXJQGoryA3KvRQDPLAVpYX9WAEC4BPasqgut9d
	czSTq9Hv0wQaRqG604VEUL8yJl3D+rdKPFmZI6LN+/sBgE01se+PsaMH
X-Gm-Gg: ASbGnct2bh7IzB9Vl1ayC0JvD67yM8XCrvYijdr7uhODLGrCwUkG8IMmF59p+/rkHwO
	LZoYhywAh2Ag2eMUgMb3kEhrlzBPiqIJW3ucM/3ATxHpzjQoJ6IBiDkhxWVDo6FmQCsuSjE/1PK
	M+hIuSksMTA72EVd5FunqkxoINwDkUZt7redU/IsAzImrEP3Q0llhoL3l3y8bhdcFhY9H96iaOP
	P13D4/F71fzNWL5bIJ65dXZlzCEz5GJJgtJgm0id/hJE44ZE0vWj55AoWZrwqQBz7caVqVUBgpH
	m/L2nAmk0vWa2VR2OVWPCo/h5qDyycVJGClWxGMZrtW1ET20adnI7jn+A+JDIOaRtWg0vBv+sNO
	cBK3bggGr3yrwKrPVOQikswsdx9A3TUV9KBOB0N/oxzsL0ZPfXWL7+GaVr2M7IQ==
X-Google-Smtp-Source: AGHT+IHwuKyIZuqe2cs9ZUKLBw9kMNkGN6o03avjpI8gBP5oBi4u2l4hzG9xH2Vjdz9aHsTfOUouOw==
X-Received: by 2002:a05:600c:c87:b0:45d:d5c6:482 with SMTP id 5b1f17b1804b1-46205cc836cmr63774875e9.18.1758204162248;
        Thu, 18 Sep 2025 07:02:42 -0700 (PDT)
Received: from ?IPV6:2620:10d:c0c3:1131::10de? ([2620:10d:c092:400::5:ce66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f4f9f41csm48878195e9.15.2025.09.18.07.02.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 07:02:41 -0700 (PDT)
Message-ID: <d19a97a8-be96-4ce4-a56e-bfb22546dfc0@gmail.com>
Date: Thu, 18 Sep 2025 15:02:40 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 7/8] bpf: task work scheduling kfuncs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin Lau <kafai@meta.com>, Kernel Team <kernel-team@meta.com>,
 Eduard <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Mykyta Yatsenko <yatsenko@meta.com>
References: <20250916233651.258458-1-mykyta.yatsenko5@gmail.com>
 <20250916233651.258458-8-mykyta.yatsenko5@gmail.com>
 <CAADnVQLFZrpBzhYaufdbxCo-QJqNqAH88YcZqvnFpNU44MA3ZA@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAADnVQLFZrpBzhYaufdbxCo-QJqNqAH88YcZqvnFpNU44MA3ZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/18/25 02:53, Alexei Starovoitov wrote:
> On Tue, Sep 16, 2025 at 4:37 PM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
> I haven't groked the state transitions yet, so commenting on
> only one part...
>
>> +
>> +static void bpf_task_work_ctx_free_rcu_gp(struct rcu_head *rcu)
>> +{
>> +       struct bpf_task_work_ctx *ctx = container_of(rcu, struct bpf_task_work_ctx, rcu);
>> +
>> +       /* bpf_mem_free expects migration to be disabled */
>> +       migrate_disable();
>> +       bpf_mem_free(&bpf_global_ma, ctx);
>> +       migrate_enable();
>> +}
>> +
>> +static void bpf_task_work_ctx_free_mult_rcu_gp(struct rcu_head *rcu)
>> +{
>> +       if (rcu_trace_implies_rcu_gp())
>> +               bpf_task_work_ctx_free_rcu_gp(rcu);
>> +       else
>> +               call_rcu(rcu, bpf_task_work_ctx_free_rcu_gp);
>> +}
>> +
> ...
>
>> +static void bpf_task_work_ctx_put(struct bpf_task_work_ctx *ctx)
>> +{
>> +       if (!refcount_dec_and_test(&ctx->refcnt))
>> +               return;
>> +
>> +       bpf_task_work_ctx_reset(ctx);
>> +       call_rcu_tasks_trace(&ctx->rcu, bpf_task_work_ctx_free_mult_rcu_gp);
>> +}
> This is overkill.
> bpf_mem_free() always waits for rcu_tasks_trace before
> freeing into the global slab.
> Also there is bpf_mem_free_rcu() that waits for both RCUs.
> Just use it and delete these 3 funcs.
I think we still need to keep bpf_task_work_ctx_put() because of refcnt, 
which is needed to maintain the context struct in memory when 
cancel_and_free() races with scheduling, as scheduling codepath may 
defer (irq_work and task_work) so RCU can be called while we are waiting 
on, for example, irq_work callback. I'll remove 
bpf_task_work_ctx_free_mult_rcu_gp() and 
bpf_task_work_ctx_free_rcu_gp()in v7.


