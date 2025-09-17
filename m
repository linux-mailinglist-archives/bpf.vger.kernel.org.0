Return-Path: <bpf+bounces-68624-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F123B804E4
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 16:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C432F7B68A9
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 04:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF4725F995;
	Wed, 17 Sep 2025 04:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j86jvfpd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1606423D7EB
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 04:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758084708; cv=none; b=Ji3JeawvJGxy8/7/129bNUcwBGCWRwp/82z8urfuLhFEE2G7sd7n2S01L6u2iXj1jaCZ/3XKnWljl3KfeYHr4FXNt1VIxMX8N28quUgcLPDoiY4nsyR6CgUgD0bL2ilf62uoeueLBtxSn7zAGB+oG9pHK6hZEiduvweDNVXL8FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758084708; c=relaxed/simple;
	bh=r0BM1z3v+ETdgaEO3IBUJs2XmPYvA5caqeW53JycuWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WU06r24zjOKgSQtbI1+szVZBybGXgQmp+5dH+1zTH2GicAYrNG0+Ba9i2mopcRN06SuY8C362jWuW2gjy6kDNm8+G13mGY1fabtDGr6qoMn8iB8D6zMvGBNsX3TOo6Vs1neMxgThALOtHQjhAXA7M1EnyxZOQnE8KvXr1U9LZH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j86jvfpd; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-24c8ef94e5dso4779255ad.1
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 21:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758084706; x=1758689506; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PomNopRC9hhdTDziVEXzXCCqU+neR5Nm4xVGY2tZiAc=;
        b=j86jvfpdRYn4K1To19AewgdiKe76HsrUqFhZUvCq9TxYGtdfgsWlVN5xi8aRgC9pUp
         rP21ZHRqWS3C7v5bBsv2H/iuq4ddHcq0Xi+JgyyEOovVfBm6omg22tKYhSzMLikL8XLI
         AbhKfCO7SG3onjvMZA8w4uVIXODXPpDBPY46P5PJhM7o0aIT9cCbDbmh5x+PLyyzwU/r
         uuNavuvNnDYEHFyFQI2vWXEOqaoki/1GdBg3ujrpNApe6J086+2p1JpKqJ3NySag/omr
         /IPI1OSUd8fOvgQU14o0HwFovtYHImHhT+s70IF1gxTAu0vVMs/He6bxzbqSgiHfk41V
         ZaXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758084706; x=1758689506;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PomNopRC9hhdTDziVEXzXCCqU+neR5Nm4xVGY2tZiAc=;
        b=jUuPSM4R8O4G9Ww6tcOCi9HPzIcf3aNPPKwfsOc86Wk/hdH58YaR1bhptzbx4qGg9Z
         0U2aLLFB9d9Yez1u7LThdElVR0n5V3lgjmWH/Z+bzbZ6NaGBBMAt8BaLa3o7E0upN1Ff
         1sYqrGTqyx7zxp2QenuNblp1+SR4xINcLzft9A3+jYOXhnLb8garXGIeYRRFmlMjSXYo
         QxqOjbrpz6rNgAirrqx84UnT+IwyeJD/7iDwh2RQZ9bhWpOn3EfNghxbIC448vGyc2br
         JWCBrSqk6cjFkCzp4SbXRti12T0dcZYpQmfQkRW4r1tSaC7hjNuho9lfHb8fJRMEOHeS
         OVoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHF8FI2mk6jgpR2Vam2X63vwkuXA3AknxE1Oz73G2TwOWa+spTCqVA8QFF7xNyGj36OF4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3KoOl9FgToXX9szGE9XH51wBmtvscIjAPTZbOrEA78/koStsb
	Vo3OeJ4Rirylu1TUy6GB6u59b41PBQpp+fAs6phYA8fXOU1VS7QA9aHD
X-Gm-Gg: ASbGncvCJmp532Tb1rnSs/IhXhltTbVQecjE6Y9Lq7IjhMqdPm3CZfhIy2J0EoR1O/H
	/RfxfcT99cXH4huxlX4HAieF2C10a90YnLas0H7EuEty9yd+PgegpGnlESE9k4z50Tfxmru2wrZ
	hwU6rqzEht/e809yjll3yHUJi9iWJ2hKWGsSDJ5bDWT3lVzXl12LAm/dG2jG7rPZwnzUd+QKEAR
	ZHsBEnXKdKH3qmJuz8uQcuA35bcfbPSSnlCYl5/LHl5ouLW/DDZpFoQMxvA8GNJjPsU0uDI6+ZJ
	jrj2taqlSHQuo0cvJM+/UfFqbEndPVtg+cWmkzu7l0XdHeWqYCn6iOy3IS5dqhdF8fiHLgVF5g/
	md9cctC4NyVx4yAekiVZaPl2CMF96TBkf/os=
X-Google-Smtp-Source: AGHT+IHqwB+BlY3rWgk8rhcN0LrntVQe58H9HcE3/7TgHxNyREQzuV1avYFWrpZpSdOu/6j6IpZ+rQ==
X-Received: by 2002:a17:902:d48b:b0:24c:e9de:ee11 with SMTP id d9443c01a7336-26810a02830mr10613185ad.17.1758084706253;
        Tue, 16 Sep 2025 21:51:46 -0700 (PDT)
Received: from [10.22.65.172] ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c36dbb159sm175668425ad.13.2025.09.16.21.51.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 21:51:45 -0700 (PDT)
Message-ID: <c6e2c3c6-2ce5-4b52-8429-bcda39e452ab@gmail.com>
Date: Wed, 17 Sep 2025 12:51:41 +0800
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
 Eduard Zingerman <eddyz87@gmail.com>, Puranjay Mohan <puranjay12@gmail.com>,
 kernel-team@fb.com
References: <20250916113622.19540-1-puranjay@kernel.org>
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <20250916113622.19540-1-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 16/9/25 19:36, Puranjay Mohan wrote:
> Currently, nested rcu critical sections are rejected by the verifier and
> rcu_lock state is managed by a boolean variable. Add support for nested
> rcu critical sections by make active_rcu_locks a counter similar to
> active_preempt_locks. bpf_rcu_read_lock() increments this counter and
> bpf_rcu_read_unlock() decrements it, MEM_RCU -> PTR_UNTRUSTED transition
> happens when active_rcu_locks drops to 0.
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---

[...]

> @@ -13863,7 +13863,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  	preempt_disable = is_kfunc_bpf_preempt_disable(&meta);
>  	preempt_enable = is_kfunc_bpf_preempt_enable(&meta);
>
> -	if (env->cur_state->active_rcu_lock) {
> +	if (env->cur_state->active_rcu_locks) {
>  		struct bpf_func_state *state;
>  		struct bpf_reg_state *reg;
>  		u32 clear_mask = (1 << STACK_SPILL) | (1 << STACK_ITER);
> @@ -13874,22 +13874,22 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  		}
>
>  		if (rcu_lock) {
> -			verbose(env, "nested rcu read lock (kernel function %s)\n", func_name);
> -			return -EINVAL;
> +			env->cur_state->active_rcu_locks++;

Could we add a check for the maximum of 'active_rcu_locks'?

From a cracker's perspective, this could potentially be abused to
stall the kernel or trigger a deadlock. Underneath 'rcu_read_lock()',
there are several RCU functions that tracing programs are able to
attach to. If those functions are traced, a deadlock can be triggered.

This scenario was already discussed in the thread:
"[BUG] Deadlock triggered by bpfsnoop funcgraph feature"[1].

[1]
https://lore.kernel.org/bpf/a08c7c19-1831-481f-9160-0583d850347a@linux.dev/

Thanks,
Leon

[...]

