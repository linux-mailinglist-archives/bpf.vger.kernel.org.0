Return-Path: <bpf+bounces-33181-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D66918DA4
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 19:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AA5C282869
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 17:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A4A19066F;
	Wed, 26 Jun 2024 17:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdlGoQI0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB8419066B;
	Wed, 26 Jun 2024 17:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719424564; cv=none; b=jlAiKcouDP9mMGCvRRqhkUp2hyPa1ZqM9puPy3i8WRNaqG+jVipGlVEHpiA7mRJNn2ptVVCrvLL9fv9+5UQUYtG+AbP9dfwQV/IoULoPDrz5UAOlARw2tUQ1ttfNysqVMCSvR7cmxkMG13mLNUuUmERYGXGVPsZrEKzM356hwCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719424564; c=relaxed/simple;
	bh=WCoPV67VMo5ajaQLAy72bRaJrigOMwbm9PqBFhY27aI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U8tbDRmCZ6Yenlev04eqGBhlKBYdUzNk4q8ZluzxWGUuQAWYcxhFeHtTI+fPt+SJuPgfh1lbPIwfl32q4rF50ncQi9qoWajIJeVZNf6NbxDLXXjWqc1OpFAKY9UDlLDFM+/DzyyjjsV9Zrdey9bWzRP6J0uRPZcZC+j0WAt+GiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gdlGoQI0; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f8395a530dso54603045ad.0;
        Wed, 26 Jun 2024 10:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719424562; x=1720029362; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Shvv5DbIqP+jAT/jdjRlZNwu0Kg87TDqBKeTSC45xCo=;
        b=gdlGoQI0MwLnV1rNxIafCo6jF8ocwYrSPPU4FbdUYa66fCH1CPbh3UEtPAZXPInIas
         Zx4KTeosR8sX9w3mbkB5SVz6iv89RdA58I0BoBYPFmrRKR83vg728LFgIMQfqYck6235
         xlw6eB1efEY4eoriVz2fft6yMPSLlPMCcWSEmInQiMThXf+wASAJyDspg6w0ZYIFgGqO
         iA/ubUehp6Ub/0J61QQDMq+w/gIx7W+raQB9SkPajZCu6KJi7KQ2PrxYLUZUjxis+VJK
         xFA7fvC6/E+dwccsHfm1wayE8/v5Os1HVbupkXQ2PrmosCTux+Afs1GEKC5Xucsx3yIA
         tfoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719424562; x=1720029362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Shvv5DbIqP+jAT/jdjRlZNwu0Kg87TDqBKeTSC45xCo=;
        b=rjeqNrQuTohBeyPobmKgCnwnln5nxSKIMzN/g3KBbFqY6YBdx/7so9XICzVT38yiQj
         +lmvN0S0L17hnwzjly8HAPMeXzhyF21eW8phwVTaI86hoy85vtwOBj8NLyYYd29Qx8Jd
         lMXnM5kahWDZrgaPD5EPMTMHEU5CwTEfwOH38Vy/56MB9irsKc5BvQc7K778KxX8Vvkd
         SLqeEOeQdWbtuPaxhVng3TWq+nmitQVVQQ8iyHIbEzk4HU1C50OqgQLOlOArDyJQVYLs
         noorLqXbWXSEEpSSTAD2BMy2W7BbyWoZ7GFHYXilSyGDjZEJc0XJd9T985ftidS+gUdr
         o1qw==
X-Forwarded-Encrypted: i=1; AJvYcCWjY/6mtKwoKcAoPfrf2ZXpSRXKpFfGvD7mXG/kyl4jxW3tX1Fo2svLomQPWwwptoT4nzAWK7iBJ/bxv/LBxsRTYxBijKflTStaKViaJh4rp4/4hQgnGJUIjdLslzXj8AKx
X-Gm-Message-State: AOJu0YyajXBpoTGJl+vuD4hf5GOGpH/g1PTaUU4ecYSEIQT5+YMvIiTO
	YU1N9zMLPSYK+3lM+Zoh+2Sy1sdDL5nB3iEb7QkWi/Wp4bcnZ7z0
X-Google-Smtp-Source: AGHT+IE2+VTnd6IxHv8qGt5zGutsXo28ej0Kwi2W7W1x1xLZr3om4XkbBAhVSFXw9X/a3DP+xJqaGw==
X-Received: by 2002:a17:902:ced2:b0:1fa:1f0c:f8fe with SMTP id d9443c01a7336-1fa23ee25famr120217565ad.32.1719424561792;
        Wed, 26 Jun 2024 10:56:01 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb1d448dsm102814395ad.0.2024.06.26.10.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 10:56:01 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 26 Jun 2024 07:56:00 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@kernel.org, joshdon@google.com, brho@google.com,
	pjt@google.com, derkling@google.com, haoluo@google.com,
	dvernet@meta.com, dschatzberg@meta.com, dskarlat@cs.cmu.edu,
	riel@surriel.com, changwoo@igalia.com, himadrics@inria.fr,
	memxor@gmail.com, andrea.righi@canonical.com,
	joel@joelfernandes.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH sched_ext/for-6.11] sched, sched_ext: Replace
 scx_next_task_picked() with sched_class->switch_class()
Message-ID: <ZnxWMB0BJ8H65NE0@slm.duckdns.org>
References: <878qz0pcir.ffs@tglx>
 <CAHk-=wg88k=EsHyGrX9dKt10KxSygzcEGdKRYRTx9xtA_y=rqQ@mail.gmail.com>
 <CAHk-=wgjbNLRtOvcmeEUtBQyJtYYAtvRTROBy9GHeF1Quszfgg@mail.gmail.com>
 <ZnRptXC-ONl-PAyX@slm.duckdns.org>
 <ZnSp5mVp3uhYganb@slm.duckdns.org>
 <20240624085927.GE31592@noisy.programming.kicks-ass.net>
 <ZnnelpsfuVPK7rE2@slm.duckdns.org>
 <20240625074935.GR31592@noisy.programming.kicks-ass.net>
 <ZntS_eM2reaszYcj@slm.duckdns.org>
 <20240626082848.GZ31592@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626082848.GZ31592@noisy.programming.kicks-ass.net>

Hello,

On Wed, Jun 26, 2024 at 10:28:48AM +0200, Peter Zijlstra wrote:
> I suppose I need to read more, because I'm not knowing what cpu_acquire
> is :/ I do know I don't much like the asymmetry here, but maybe it makes
> sense, dunno.

The sched_ext ops are symmetric - ops.cpu_release() is called when SCX loses
CPU to a higher priority sched class and ops.cpu_acquire() when the CPU
returns to SCX afterwards. Where they hook into is not symmetric. The class
which picks the next task already knows the previous task, so there's no
need to add anything. However, without the new sched_class->switch_class(),
the previous class has no way of knowing, so they're a bit different.

Thanks.

-- 
tejun

