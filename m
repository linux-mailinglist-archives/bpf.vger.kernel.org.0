Return-Path: <bpf+bounces-33042-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBD091621B
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 11:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1D091C20A0E
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 09:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855FE1494B2;
	Tue, 25 Jun 2024 09:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XLNH/oYr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC6D149018
	for <bpf@vger.kernel.org>; Tue, 25 Jun 2024 09:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719306848; cv=none; b=JVgZKfY95q0eQs6WvYcLMxXqwbQg1gTq7LWW9q9XSydsZf27B2OAuLEmbSGAgOqGI3+5h+fx7EG9SCnyXMHjQqZFmhwGGznBc6Mem0UbjQZGOi1XZsDXCn0VHAdP6BxkXE9VN00Cg2y2M1wKKwUHr1bL2jwzptnvr1aJd4tBRkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719306848; c=relaxed/simple;
	bh=X+Sc8l2azZ51CBIhjssFPzCx3K7rV4p+AyMoqaAY3K0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pfOT56d10fw4mFa3mtL9YXK+a2oPDS0qdchjAkAyXtyPq2v1ePtcZGAf16t92ZcmwEokxTaMO/qMi1iObk1oWHdLVUMdOsu3ioCgwlksfsc+iGfa4rJGzsCsuakglj9yAF3a+ekaGL2qwAzr4vEI4BfmpLGxlYjgKDR8fajPnbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XLNH/oYr; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f44b45d6abso41077015ad.0
        for <bpf@vger.kernel.org>; Tue, 25 Jun 2024 02:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719306846; x=1719911646; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wev5lsdKr9oDdIaoqOVZDJQGx2Mtu6O5XRfIhomTg4k=;
        b=XLNH/oYrlGuaAw+MeqwVF8sjhleKPI3Rnblq6t88lHyj1/82bYhCLXyzIkVWAm63eR
         FO702I2myUvcGO9Fe3V6lrrzIww4moc9PSFf0SFXTBzWwpyYPoXVuxnAksmnLPDIFRNP
         VHrqDC4xiKY1O6HhP+Lcgp50RzR04AMB9ezKvc29aAu/eVGjSECw6vbQOs6I3QGzNm0i
         D1p2AzjMPat4vH64YGb941WyRA7gCd2PKcHJ0E/Xxa1zEdbkFKUT4h6hoOVJ3emN7grn
         R0RLzTb7qmdQ8Jz9oPoNrTKGE1EJ4UJraVBbt76tUsQcpmxfB7Dsh2iviw8lCr4UA+n+
         8tDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719306846; x=1719911646;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wev5lsdKr9oDdIaoqOVZDJQGx2Mtu6O5XRfIhomTg4k=;
        b=Ten0nfNcaksU83BHH8pQNW3BJ/dewnM4gX1Sa9eDMvydpXR/Hbdfp1DkkmsMZ4wQGl
         4B9SSeHHW8PdjMo8w7BPkPbo1CSqlmFIMXTdi7C04ssFJciSWXpq4yLqJH3wkrAu9MuJ
         AAfYGkUDRcwjpbLhWswHVHnjIOd0RDJzv3eT95YSWWh9vMYvuyI5DTc890yP07DHJSXQ
         7uw3J0GLWASZUETDdvsFaI85aoll7Xf3aLi8Lhx2R2cMfkBRAyCGgT0yDb5IYCYLqCRD
         pXsOAfEp/lH6BJLo1ySJ8UaA6hTUht0eH6AOZrgqmqVj3FRbpAICZkkJnR5Pf/NVCWLs
         32rg==
X-Forwarded-Encrypted: i=1; AJvYcCXbTacn6kGO5pKREiYOeO2lkYjreczsI6fqZSIsSA+01OlbaBjcqC64OMn5D61GvhETsNLgbX/Lu7RQEJQ3Uj5vh+0S
X-Gm-Message-State: AOJu0Yx7BMUq4WEf/xyGoQrw22vi6NGMJgciLNeH60PlVFfEm6L5/qO3
	mSGgx3Y2j25OpI7JzxWVRiwJQlq5aEVXU+XpGG4zLjjZPab34v1XsDkB2GYGE77afCyqSaMsVp8
	5vtQd31fgYiXZDA1th2L0WqF9JboRnitM0yjXbw==
X-Google-Smtp-Source: AGHT+IHzMrB7eF0/Jmgi7Ny369maF5+KKw/j7S1V9TXdis6CgHM2sJlMmClu8LZ3bzlKotw8q0963TSa6DlfPrTk6LU=
X-Received: by 2002:a17:90a:1283:b0:2c3:11fa:41f with SMTP id
 98e67ed59e1d1-2c8582db392mr5075143a91.45.1719306845881; Tue, 25 Jun 2024
 02:14:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501151312.635565-1-tj@kernel.org> <20240501151312.635565-11-tj@kernel.org>
 <20240624123529.GM31592@noisy.programming.kicks-ass.net> <CAKfTPtD-YHaLUKdApu=9AhKAdg5z7Bp-3089DcdA7NL2Y5pxiA@mail.gmail.com>
 <ZnnIACPPrnUxP1Mw@slm.duckdns.org>
In-Reply-To: <ZnnIACPPrnUxP1Mw@slm.duckdns.org>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 25 Jun 2024 11:13:54 +0200
Message-ID: <CAKfTPtB2AbXryzQ+NvPKJML7pbKh8MeW6gmNwLK04b=Wd+SMtw@mail.gmail.com>
Subject: Re: [PATCH 10/39] sched: Factor out update_other_load_avgs() from __update_blocked_others()
To: Tejun Heo <tj@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, torvalds@linux-foundation.org, mingo@redhat.com, 
	juri.lelli@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@kernel.org, joshdon@google.com, brho@google.com, pjt@google.com, 
	derkling@google.com, haoluo@google.com, dvernet@meta.com, 
	dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com, 
	changwoo@igalia.com, himadrics@inria.fr, memxor@gmail.com, 
	andrea.righi@canonical.com, joel@joelfernandes.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Jun 2024 at 21:24, Tejun Heo <tj@kernel.org> wrote:
>
> Hello, Peter, Vincent.
>
> On Mon, Jun 24, 2024 at 06:15:20PM +0200, Vincent Guittot wrote:
> > > > +bool update_other_load_avgs(struct rq *rq)
> > > > +{
> > > > +     u64 now = rq_clock_pelt(rq);
> > > > +     const struct sched_class *curr_class = rq->curr->sched_class;
> > > > +     unsigned long thermal_pressure = arch_scale_thermal_pressure(cpu_of(rq));
> > > > +
> > > > +     lockdep_assert_rq_held(rq);
> > > > +
> > > > +     return update_rt_rq_load_avg(now, rq, curr_class == &rt_sched_class) |
> > > > +             update_dl_rq_load_avg(now, rq, curr_class == &dl_sched_class) |
> > > > +             update_thermal_load_avg(rq_clock_thermal(rq), rq, thermal_pressure) |
> > > > +             update_irq_load_avg(rq, 0);
> > > > +}
> > >
> > > Yeah, but you then ignore the return value and don't call into cpufreq.
> > >
> > > Vincent, what would be the right thing to do here?
> >
> > These metrics are only consumed by fair class so my first question would be:
> >
> > - Do we plan to have a fair and sched_ext to coexist ? Or is it
> > exclusive ? I haven't been able to get a clear answer on this while
> > reading the cover letter
>
> Oh, there are two modes. In partial mode (SCX_OPS_SWITCH_PARTIAL), there can
> be both CFS and SCX tasks running on the same system. If the flag is not
> set, the whole system is on SCX.

ok thanks for the clarification because this will have an impact on
how fair tasks are scheduled

>
> > - If sched_ext is exclusive to fair then I'm not sure that you need to
> > update them at all because they will not be used. RT uses a  fix freq
> > and DL use the Sum of running DL bandwidth. But if both an coexist we
> > use be sure to update them periodically
>
> Hmm.... I think I saw RT's schedutil signal stuck high constantly pushing up
> the frequency. I might be mistaken tho. I'll check again.

This is used when selecting a frequency for fair tasks

>
> Thanks.

>
> --
> tejun

