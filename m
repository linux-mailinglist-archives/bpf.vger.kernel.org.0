Return-Path: <bpf+bounces-32935-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1407391571C
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 21:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A02DEB21899
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 19:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DFF21A00F9;
	Mon, 24 Jun 2024 19:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIBEDlDB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7751A00E0;
	Mon, 24 Jun 2024 19:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719257092; cv=none; b=fCU/JDa+p2QM9tZVjNMSK/q7cd42bUbE7uSr+tKYVV1tlB9nPTalC3NO4ugnRBlSzw5nZEiQdzoQFmkvbWVbNOdaDna/TD7jzpWaonBTPq8i5ikIrJhU5IQI24YNdpZGXD9e0v7ZJJN6GMRVAyoXGDE6ITqybtWxyoInnoEaOI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719257092; c=relaxed/simple;
	bh=xIDW9i50smvSTmJ/FbD37hFiAjeARz1ljegYLJhEni0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQRJmr73PDZ9oOtZzAIa7wDTH3Ztku+JArtT0HtSApd7mk8FU/0ZVXClL6MMgoF9Ze2m+5o+0gEaQlkFf+btMEuisxXzBwwoUUkj+1/Grefaa1Kz2KiOMhQm06q6Kjvs+JhojWVbF4AlwM0XFHA2NZ3tpjB1DMcWuetdl1pwND4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HIBEDlDB; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7041053c0fdso2764149b3a.3;
        Mon, 24 Jun 2024 12:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719257090; x=1719861890; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QEP0UkRZQJBBN4SuO6JvEUJZAsWrU17/pTvV7XuAUac=;
        b=HIBEDlDBdVAfDlcPsosUhc+S98w9gJyCDOIT8GAljD+LU5CdEVlY/PzWeAVEdl7Tfz
         Ei/FTheOuRNan5Crf4m2e5iEwgeNiZ6x4y3hR2EeDJ/eC2lWd5tVMpYPW48vwuQ22F4z
         RUXgTklwjKMAWhcuXRTNUtrGoWytn9irVb72jHB9NR0h+jGmv0Pq8ogwys/j8UvFn8Ap
         6TEUfGmTeMuUyyds4SVMrt5faFiWAWz2Jh8phyRJUiFGjSCMrlAcpbZP8fMZ41PwNONa
         Sdfj9ApN+ldYJ2bp+uA12m01VCy2VJznWfSl3nXnPgP7YMt8ACoRIiAi2IfoWVIukeOQ
         35nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719257090; x=1719861890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QEP0UkRZQJBBN4SuO6JvEUJZAsWrU17/pTvV7XuAUac=;
        b=hQW3LCNHUS3+Kk+K9hb060mIQzIhauTNx9qjT9bfTWUV900Jpz5Mp0qxHwYo4pfifQ
         bWlyi/0rLNRiLd4rtuF08CVxeH8wsC/DPnbqzNkzGRz2xUia54JFTDgYbybg1BbyDy5t
         /T7mQxc+YLMp0Lz8uAkVX7iefC0v4go3pU/QSnzkgzh63lsnPzgncxlLjxhEy3rDrTQI
         0ouvDPaKf6gmmXmTIByorcVgKUcrd5VBJ7lb9k8O/ADysZPnlvzv/R9Oxxq3J0l1XI5N
         5O0L8Ne4KGo0qYDYV0ECH2WSLhYvRD6dwF3nOZX6KcnlYz8nJ62oD6bpi9GTcWG21A/T
         5+5A==
X-Forwarded-Encrypted: i=1; AJvYcCVX7b9MYjPNh5cfjkZo7djQdSfRPTt+FXb1TjvrgPCIKJiZIvgTDo7Goe78sWCIJvCSbAxNRKnr2uBryICaZIH1eTvZ16sdzB4dymEhV/y52MC/FOK4CGMAlVVdr/UmH83/
X-Gm-Message-State: AOJu0YzN6j0Fu9dgAZziyCevE5EkgFN7fyuG/s2owP5D607rH8o/Vx46
	ewkoghB1DX8j2hBF9x68Z+RW03fhWZYgfUbOo53ZH7ml4Ynr8wuC
X-Google-Smtp-Source: AGHT+IGMvyAWOq5WPhnyItU1Zk7g/r/9QWQWzErhbHvku7uK0vJxzBH6sAejrzdjvPNOGCHfvKVS1w==
X-Received: by 2002:aa7:88c6:0:b0:705:a450:a9a9 with SMTP id d2e1a72fcca58-706745512c1mr6773884b3a.1.1719257089756;
        Mon, 24 Jun 2024 12:24:49 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-71783895e5esm5448117a12.17.2024.06.24.12.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 12:24:49 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 24 Jun 2024 09:24:48 -1000
From: Tejun Heo <tj@kernel.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, torvalds@linux-foundation.org,
	mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
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
Subject: Re: [PATCH 10/39] sched: Factor out update_other_load_avgs() from
 __update_blocked_others()
Message-ID: <ZnnIACPPrnUxP1Mw@slm.duckdns.org>
References: <20240501151312.635565-1-tj@kernel.org>
 <20240501151312.635565-11-tj@kernel.org>
 <20240624123529.GM31592@noisy.programming.kicks-ass.net>
 <CAKfTPtD-YHaLUKdApu=9AhKAdg5z7Bp-3089DcdA7NL2Y5pxiA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtD-YHaLUKdApu=9AhKAdg5z7Bp-3089DcdA7NL2Y5pxiA@mail.gmail.com>

Hello, Peter, Vincent.

On Mon, Jun 24, 2024 at 06:15:20PM +0200, Vincent Guittot wrote:
> > > +bool update_other_load_avgs(struct rq *rq)
> > > +{
> > > +     u64 now = rq_clock_pelt(rq);
> > > +     const struct sched_class *curr_class = rq->curr->sched_class;
> > > +     unsigned long thermal_pressure = arch_scale_thermal_pressure(cpu_of(rq));
> > > +
> > > +     lockdep_assert_rq_held(rq);
> > > +
> > > +     return update_rt_rq_load_avg(now, rq, curr_class == &rt_sched_class) |
> > > +             update_dl_rq_load_avg(now, rq, curr_class == &dl_sched_class) |
> > > +             update_thermal_load_avg(rq_clock_thermal(rq), rq, thermal_pressure) |
> > > +             update_irq_load_avg(rq, 0);
> > > +}
> >
> > Yeah, but you then ignore the return value and don't call into cpufreq.
> >
> > Vincent, what would be the right thing to do here?
> 
> These metrics are only consumed by fair class so my first question would be:
> 
> - Do we plan to have a fair and sched_ext to coexist ? Or is it
> exclusive ? I haven't been able to get a clear answer on this while
> reading the cover letter

Oh, there are two modes. In partial mode (SCX_OPS_SWITCH_PARTIAL), there can
be both CFS and SCX tasks running on the same system. If the flag is not
set, the whole system is on SCX.

> - If sched_ext is exclusive to fair then I'm not sure that you need to
> update them at all because they will not be used. RT uses a  fix freq
> and DL use the Sum of running DL bandwidth. But if both an coexist we
> use be sure to update them periodically

Hmm.... I think I saw RT's schedutil signal stuck high constantly pushing up
the frequency. I might be mistaken tho. I'll check again.

Thanks.

-- 
tejun

