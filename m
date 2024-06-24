Return-Path: <bpf+bounces-32960-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79401915AC9
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 01:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DFD41C21095
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 23:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1B51A2C1E;
	Mon, 24 Jun 2024 23:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDoRlTwi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F4E38F9A;
	Mon, 24 Jun 2024 23:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719273546; cv=none; b=YoODOU5H5LheRuFYeWmXayxx42vm8ZgClEwAV7OT25yg2PxPSdXfEVZY8e7mh78ey+cBh2kpBW/ffCmxc4svBypJ4Ug13lU714ftAaXNHtVOkz58eza2ubMQ4NHjFrS3kp0EWS5F4Qp3VIBU3WWCQkWIjEmeeI0ik/1hbQone/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719273546; c=relaxed/simple;
	bh=yf0TuOKYWLXbXTkdUahnzlNtME3QpThZc1YBYXYX5nM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P/XeSIDm9+IqT7tomRhcua3lqbrPFvv1klSQg9X8UkmvbfajolGprls54Rj0AKwmdStIhliISO60ojLeT8QiAMNrHHutOpPElsJ6FvTqtJRCADeRGJk2PsGmoC1v3sJWS2U/45AzIn1Fy9Hnd1TDGVeio/hbDzd51+mtR7M9Z5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dDoRlTwi; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70699b6afddso31269b3a.1;
        Mon, 24 Jun 2024 16:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719273544; x=1719878344; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dmgfdC7zQabcYbLKBYbYqzfAC0NAOR9Eyj2mz5NydgM=;
        b=dDoRlTwiiFRn8UlRGHGEXmfCOmuPYkk9lw0wkfSSbGb9JfDy0OoudhaB6XBN98NTD+
         nsAu2RsHUjVBN9JvojseP3SysKzU3gShsgxaV+yvVBMCnJBRonOxqw9Kqag3oubFDkDc
         G+E8JLXtQiHIDsoWHh3QTXgSEmPZuke4V06FCHm6COrq37vhuHgyjQtN9ib2KNGUEwY0
         o3V5AnUoRNE9puBmOerNhEAyidiTiMD3VVNLiXVurYveBQkySeR/VDqsUxi24v4zqO6e
         mvVglvRi7OslCtCRcMlHLuRLjC4O3jmVsPuxoeHd26uB4RWeSaqHU9EXrkCsyL7PWHz5
         +86w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719273544; x=1719878344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dmgfdC7zQabcYbLKBYbYqzfAC0NAOR9Eyj2mz5NydgM=;
        b=Fvk+phq6QDM0b56qCt/sAd6WeP3zX0wv7lo+Tjh9I+cA7R+D9NDb95/IBz3qAkozdO
         hEH75IUR9YSy8s5g4Yi+KqT7DFCQ0lx4/hfGLHRc50PcCFWi4dHUenxOHGWng0qiptw5
         cWBe3Ej1+dCVNH3NRv7Ob8/Z7k7RFPClQvPFJZiJKmuID4OuTwYWDe+H/29gqvao+k9c
         qzFZV4dp81Q6s2nBQP3Wap9ViNRaqYDuDhlO5983KbJ24ojlaXYj4fDT/4tYNUNuW36Z
         ataNGCNwFg+h9jRtsBsTekFJWVafXkMuciCMKl3tT7z39PGfQLjZOHi4Mix7C37y+Ec7
         eAJA==
X-Forwarded-Encrypted: i=1; AJvYcCWzbnOQ7AMVeAhQ5mxWFq4dFPFe0b6Eg7W3u0M9+R/f5dlspVG8bGoaobFZLiHrDlYuRZA1Ew6+iRua9YKAUy/zmZTj7ZpkfMw3f/2N9VR7G2I0ew+Ber5E5MuZGlQa6DbT
X-Gm-Message-State: AOJu0YxiZsXSWgZJbPzYMVIeLBjv+W/PaaJUjdD29n79PtK4fDmRN3FW
	W03QZql2ln13d0PWV+H9KOQozqHBEJYHRsdkYPWqjL5CAWdXyMOL
X-Google-Smtp-Source: AGHT+IEH533jJAHEVcfwhe7W0iYdHPHiDnyk5qw78599iuTw2cpRI/xUkJAFSWxEXKuZdZlACqnm5A==
X-Received: by 2002:a05:6a20:b91e:b0:1bc:f2f7:cf73 with SMTP id adf61e73a8af0-1bcf464560amr4899248637.55.1719273544137;
        Mon, 24 Jun 2024 16:59:04 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7065107b62bsm7011138b3a.16.2024.06.24.16.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 16:59:03 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 24 Jun 2024 13:59:02 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: torvalds@linux-foundation.org, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
	joshdon@google.com, brho@google.com, pjt@google.com,
	derkling@google.com, haoluo@google.com, dvernet@meta.com,
	dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com,
	changwoo@igalia.com, himadrics@inria.fr, memxor@gmail.com,
	andrea.righi@canonical.com, joel@joelfernandes.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 04/39] sched: Add sched_class->reweight_task()
Message-ID: <ZnoIRnCZaN_oHQ6N@slm.duckdns.org>
References: <20240501151312.635565-1-tj@kernel.org>
 <20240501151312.635565-5-tj@kernel.org>
 <20240624102331.GI31592@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624102331.GI31592@noisy.programming.kicks-ass.net>

Hello, Peter.

On Mon, Jun 24, 2024 at 12:23:31PM +0200, Peter Zijlstra wrote:
> This reminds me, I think we have a bug here...
> 
>   https://lkml.kernel.org/r/20240422094157.GA34453@noisy.programming.kicks-ass.net
> 
> I *think* we want something like the below, hmm?
> 
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 0935f9d4bb7b..32a40d85c0b1 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1328,15 +1328,15 @@ int tg_nop(struct task_group *tg, void *data)
>  void set_load_weight(struct task_struct *p, bool update_load)
>  {
>  	int prio = p->static_prio - MAX_RT_PRIO;
> -	struct load_weight *load = &p->se.load;
> +	unsigned long weight;
> +	u32 inv_weight;
>  
> -	/*
> -	 * SCHED_IDLE tasks get minimal weight:
> -	 */
>  	if (task_has_idle_policy(p)) {
> -		load->weight = scale_load(WEIGHT_IDLEPRIO);
> -		load->inv_weight = WMULT_IDLEPRIO;
> -		return;
> +		weight = scale_load(WEIGHT_IDLEPRIO);
> +		inv_weight = WMULT_IDLEPRIO;
> +	} else {
> +		weight = scale_load(sched_prio_to_weight[prio]);
> +		inv_weight = sched_prio_to_wmult[prio];

Hmmm... sorry but I'm a bit confused again. Isn't the code doing the same
thing before and after?

Before, if @p is SCHED_IDLE, @p->se.load is set to idle values and the
function returns. If @update_load && fair, calls reweight_task(). Otherwise,
update @p->se.load is updated according to @prio. After the patch, @weight
and @inv_weight calcuations are moved to set_load_weight() but it ends up
with the same result for all three cases.

Were you trying to say that if the idle policy were to implement
->reweight_task(), it wouldn't be called?

Thanks.

-- 
tejun

