Return-Path: <bpf+bounces-47574-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 129A39FB8BC
	for <lists+bpf@lfdr.de>; Tue, 24 Dec 2024 03:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E17416542D
	for <lists+bpf@lfdr.de>; Tue, 24 Dec 2024 02:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D5742A9D;
	Tue, 24 Dec 2024 02:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M62D09vp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E82418D;
	Tue, 24 Dec 2024 02:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735008530; cv=none; b=oU7cJOeGmEsgMKVRHXs/7isMf5ShEJVP9ofFoJJaf4k+/RjSxPWA/+dOChX7/idV0dC9IeaS8IPW8qBml0G5mcUPlQzne2mH1za8GJrxQwA6dtRem7FnrEXzhkKRs1Zb8uy64GGKCldy/tgKRphk5IXUX3MR5me26F0+tT05KPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735008530; c=relaxed/simple;
	bh=03YDCCaWVcbPfcbDKtCNDdEONHgMOfCwWTUhamdkVK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fsJAlvU5K1js4cf6wXAhJeMhL5Mk+e5k2oFPm9x6aMP2l/tMwi9J6RpEULlNJ3FdboM9StHcbXEMiJWdihznPWDiPlwOvYWdyN/f/QuH0uhZXoINGN3/nFxuAFsnfe4UEki7Sm/LShJKs/ViTHe9vP1NLn6u7gzbmNNBanYyAkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M62D09vp; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e455bf1f4d3so3535407276.2;
        Mon, 23 Dec 2024 18:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735008528; x=1735613328; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8wZGTnzQLd+hXaD/puDgKaF0sK04UxWHdMquN6C8pIY=;
        b=M62D09vpweSvT/SMoyO2MeP98TZYd2Z4q/T+91Xu43IqME1AqFrkj2e64VSjjElAkF
         /Ju0N0bR59oKt1jZZUD93W80SYiSY5pd5gfk4tR8yL2o7wzasaQuUhrG/mbda7Aer/9K
         J3Af7XSQ0EN2jJfmL9eY+y8I5lJE8hWw+t+h1FlpZtjaAkmFp4qg+sS2HkmF5J/PWkA4
         3pcUcC1Kh8J2ygQ0Nu+xjypK2uoDHgoQpwZ+V9kF5dUBVqOkVLYRrQzmBbCjkXZxYeEF
         hQVOV4j6C4hr08jgadbo3wbmxRw6zvakDHpXgZW/8UvFAT2Vp0hHg37IqjQCA9jBsP/a
         biUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735008528; x=1735613328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8wZGTnzQLd+hXaD/puDgKaF0sK04UxWHdMquN6C8pIY=;
        b=c+Q8FGq/OstbWgK0vRaGsOPQ1dAnemooi02djpYS6MesImoE6/BPDfTZhSMFCMfPSN
         s/Tnu4eVCRaM+NiMuVGeR/w3k81EAKoB67frqkeLvr5Fpn1VzFi13Kgnlg+nJPaRrS8l
         hwRUKMNVl0pKRbG4GcI8+6HPZ8BkQVU1ugDjIcRUHj1hQV8T/+r26W33pU5MLrWit29P
         XrZnWAuF4MtYJopb5zfQP4GFlvZhfUMgVPE2+j9vPrdWw7Vh/BwIdUwxQMgvuW0tUnHQ
         7vFeeYcItS5/4DwUgl5cVW05/crQ1Tdt1ATTSEmtfNDrtAOwB+tXUXrPm1iq6hSCUG7i
         HgYA==
X-Forwarded-Encrypted: i=1; AJvYcCUM5ODv/43gQWdLPOvYEem5bdgYVVii6KA68smzzUT1vuGqf9mnErj2453pX03MjJpMSw2RidrZ0N3FyqPC@vger.kernel.org, AJvYcCX+boAyE2eXvJYVfYeoDDv7nJulYUpaypKUaxG7Zc2xuKujai0m/a6S+4oX0TsPfcIIB5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLdNDJz/muD8oYKrHGccoDyc8sfbbYI8NAiN90/Z7OvkkB0kdy
	26k6lpiklXBsBSM8yBu7l4SErfqi3S8mFQRb6UiUQuoKpDu2R8lM
X-Gm-Gg: ASbGnctPPb6hWEgKcjc39peihshUtCnVsYDcdzaXMY46fJEtzCpVi4cEm5QQCT2Ej56
	1Z69fhV91gqihodGYlBjPV6PX7iY7RJ3j+zXoGPFiVG93Og6L3+MG3QhnZrhBg6B+ThJ/hiAUfF
	nBYHvwQJn5XIlcLxHcc1sDpKkK00+dPdExj/+zm1Xx9NnZsTgPwTr4pLEMVFohT/kFaq3+xZTdp
	2ksOOaH/8w18hDiu33pJbrV0z7ocWoob8KAq/bJ3WpGMyEUgORzADey0pCgLI+MAh1k1o08sFyR
	D3XsG2qPhz2+JVVQ
X-Google-Smtp-Source: AGHT+IGAvxYFFYWpBWfVN67mDIlTOymT4yE1ovxQ97wQjCGSRerws/7DikbcNbLKXb39+tkDLqg66Q==
X-Received: by 2002:a05:6902:1108:b0:e4d:25c6:c3b0 with SMTP id 3f1490d57ef6-e538c207637mr7656977276.9.1735008528006;
        Mon, 23 Dec 2024 18:48:48 -0800 (PST)
Received: from localhost (c-24-129-28-254.hsd1.fl.comcast.net. [24.129.28.254])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e537cf9d226sm2779226276.61.2024.12.23.18.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 18:48:46 -0800 (PST)
Date: Mon, 23 Dec 2024 18:48:45 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/10] sched_ext: idle: introduce SCX_PICK_IDLE_NODE
Message-ID: <Z2ohDX-F6bvBO3bx@yury-ThinkPad>
References: <20241220154107.287478-1-arighi@nvidia.com>
 <20241220154107.287478-9-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220154107.287478-9-arighi@nvidia.com>

On Fri, Dec 20, 2024 at 04:11:40PM +0100, Andrea Righi wrote:
> Introduce a flag to restrict the selection of an idle CPU to a specific
> NUMA node.
> 
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---
>  kernel/sched/ext.c      |  1 +
>  kernel/sched/ext_idle.c | 11 +++++++++--
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 143938e935f1..da5c15bd3c56 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -773,6 +773,7 @@ enum scx_deq_flags {
>  
>  enum scx_pick_idle_cpu_flags {
>  	SCX_PICK_IDLE_CORE	= 1LLU << 0,	/* pick a CPU whose SMT siblings are also idle */
> +	SCX_PICK_IDLE_NODE	= 1LLU << 1,	/* pick a CPU in the same target NUMA node */

SCX_FORCE_NODE or SCX_FIX_NODE?

>  };
>  
>  enum scx_kick_flags {
> diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
> index 444f2a15f1d4..013deaa08f12 100644
> --- a/kernel/sched/ext_idle.c
> +++ b/kernel/sched/ext_idle.c
> @@ -199,6 +199,12 @@ static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, int node, u64 f
>  		cpu = pick_idle_cpu_from_node(cpus_allowed, n, flags);
>  		if (cpu >= 0)
>  			break;
> +		/*
> +		 * Check if the search is restricted to the same core or
> +		 * the same node.
> +		 */
> +		if (flags & SCX_PICK_IDLE_NODE)
> +			break;

Yeah, if you will give a better name for the flag, you'll not have to
comment the code.

>  	}
>  
>  	return cpu;
> @@ -495,7 +501,8 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
>  		 * Search for any fully idle core in the same LLC domain.
>  		 */
>  		if (llc_cpus) {
> -			cpu = pick_idle_cpu_from_node(llc_cpus, node, SCX_PICK_IDLE_CORE);
> +			cpu = scx_pick_idle_cpu(llc_cpus, node,
> +						SCX_PICK_IDLE_CORE | SCX_PICK_IDLE_NODE);

You change it from scx_pick_idle_cpu() to pick_idle_cpu_from_node()
in patch 7 just to revert it back in patch 8...

You can use scx_pick_idle_cpu() in patch 7 already because
scx_builtin_idle_per_node is always disabled, and you always
follow the NUMA_FLAT_NODE path.  Here you will just add the
SCX_PICK_IDLE_NODE flag. 

That's the point of separating functionality and control patches. In
patch 7 you may need to mention explicitly that your new per-node
idle masks are unconditionally disabled, and will be enabled in the
last patch of the series, so some following patches will detail the
implementation.

>  			if (cpu >= 0)
>  				goto cpu_found;
>  		}
> @@ -533,7 +540,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
>  	 * Search for any idle CPU in the same LLC domain.
>  	 */
>  	if (llc_cpus) {
> -		cpu = pick_idle_cpu_from_node(llc_cpus, node, 0);
> +		cpu = scx_pick_idle_cpu(llc_cpus, node, SCX_PICK_IDLE_NODE);
>  		if (cpu >= 0)
>  			goto cpu_found;
>  	}
> -- 
> 2.47.1

