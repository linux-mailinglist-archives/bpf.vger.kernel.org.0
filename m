Return-Path: <bpf+bounces-27987-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 909808B41A8
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 23:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2358D1F228DB
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 21:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E917376E6;
	Fri, 26 Apr 2024 21:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DrMdf5y9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C4D2261F;
	Fri, 26 Apr 2024 21:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714168701; cv=none; b=TFQtEA7KIslqAx1lpJ/ulShNgme1asAYs3ZC20zFduciCertYgSH6c0PLCRyaiO+c5E816VHIlRmh0MCertK2LDE2PNZDSdFyJPpZ1kOfNV0ez4OOAbyy6r14VCuW9vNcLzagjR9JrXY6StpGxkcERYnvy87/4yEcUx2ZwHKk4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714168701; c=relaxed/simple;
	bh=F09Jk4mr/KRVa2zBQ4I2CxYJD4+p3VrGSWgySqY4HlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZqTGK9gkZ7shUPTIwmqUJS4uMrwIr54oSS4rgfsIsYUklshGdotUDgPZwfxW8g9rol7r6/IgMsIZijqaQCOO6Fo/iOzkFNefJzbglvcxpLpq6QcbbVtv2iD/II4f34j74Nk2gvRISNc/HqcW88D6apoSqWcH7UPiMmeGR4NbBXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DrMdf5y9; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e3c9300c65so23935335ad.0;
        Fri, 26 Apr 2024 14:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714168699; x=1714773499; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ue2nqv6/HSeXIMK2oRLDDbYOhYHkW9Rq2UYozwmhcT0=;
        b=DrMdf5y9FiCl2R1nA3NSp+VTZ6bE2ZGS3BNL8EBylf1L8VA7zYJHkjTATb76UvkSe/
         fR6AoVoujkXGeC0ysLQMBBLu/q7vwe4vIpJdEPGRcWUzJeaoCe1Y4rz5NblAB4YfXNAg
         bb/A8dU7McMy3bV3BfzFLfpm9BwcETPxcPh1Ht0kx/2N+NssMRDOeWyIsEKIKjc524aM
         IZcNssp6z3ZqkhOUJEna+jaMUn/2lnXL9eQmH3oMrM4ukGSItsYAdXdtXxjgg91gKq2A
         Kkr1g2LPVYbda1EJKK4puWPeXOYTCV+xYJizpy/eNbaEVyA93yX0L+BiJjE9XZrf1BFx
         651A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714168699; x=1714773499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ue2nqv6/HSeXIMK2oRLDDbYOhYHkW9Rq2UYozwmhcT0=;
        b=GCYFQthVsoI97sd5cdK29HxuYt8guyhQeUNCOWF+K1ACyJ2Z1H0eun4zEKnaE1rmWT
         Ppn5nIiPXTYG7W/mEjhv41zu0awClvhnx9BbXLfHXlVoRicgxZ/OmKmBSzVHtgqKqhLF
         rAppJEpIU5EGFbryyHUkct41JRW/hXdxPc8rcMSPo8AUErSv1XFIueV0IWWAn5/tp8fx
         6XoRiNErZefRJLYbNMAZtFTTI4oX7hQHYsLjy8XtQbLyDE3lxV2yzE95YQqWGVPuEJV1
         UgmLO384Z1Xi/B9J8vG8DTz9NW7+iceQNa6WscN7B8jcMGfc9jRsr940INjFBY7oTNYW
         XupA==
X-Forwarded-Encrypted: i=1; AJvYcCUkyWWVB5tROUicDek5zLIEOPlOTBL6P+EtZ/XsXOCGEv1cdjaNWiQudZXymGR2cKtm99pO0SzvAR34naVgblRjMzNDLWa2Jjtdcw21NJWp3jW5/316stLPILG4OR+6Y7bW
X-Gm-Message-State: AOJu0YwMrqIY2fr+TKjWEz2+sNQFi9OWqwJN1akld/h6L0/dLdjRG5Zw
	zbVryw9P4DstY9A10atM8V6+OXR0L+iAjQF+9ijmqK4cieYT5aCDX84o1hgu
X-Google-Smtp-Source: AGHT+IHtHF7CDENMCIfBn2zgWSQcD1J8OTrrpfoSnSi7Wq5zyb2kUtnQlQJ/p+HPCEPNOqlee3Sa1g==
X-Received: by 2002:a17:902:8506:b0:1e5:8769:aadc with SMTP id bj6-20020a170902850600b001e58769aadcmr3535355plb.22.1714168698962;
        Fri, 26 Apr 2024 14:58:18 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:4652])
        by smtp.gmail.com with ESMTPSA id e6-20020a170902784600b001e2a3014541sm16246281pln.190.2024.04.26.14.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 14:58:18 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 26 Apr 2024 11:58:17 -1000
From: Tejun Heo <tj@kernel.org>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: torvalds@linux-foundation.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@kernel.org, joshdon@google.com, brho@google.com,
	pjt@google.com, derkling@google.com, haoluo@google.com,
	dvernet@meta.com, dschatzberg@meta.com, dskarlat@cs.cmu.edu,
	riel@surriel.com, changwoo@igalia.com, himadrics@inria.fr,
	memxor@gmail.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	kernel-team@meta.com, Andrea Righi <andrea.righi@canonical.com>
Subject: Re: [PATCH 12/36] sched_ext: Implement BPF extensible scheduler class
Message-ID: <ZiwjecOGR3G4ZGbS@slm.duckdns.org>
References: <20231111024835.2164816-1-tj@kernel.org>
 <20231111024835.2164816-13-tj@kernel.org>
 <20240323023732.GA162856@joelbox2>
 <Zf9Tz2wHT6KYtqEG@slm.duckdns.org>
 <CAEXW_YR02g=DetfwM98ZoveWEbGbGGfb1KAikcBeC=Pkvqf4OA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YR02g=DetfwM98ZoveWEbGbGGfb1KAikcBeC=Pkvqf4OA@mail.gmail.com>

Hello, Joel.

On Thu, Apr 25, 2024 at 05:28:40PM -0400, Joel Fernandes wrote:
> Got it. I took some time to look at it some more. Now I am wondering
> why check_preempt_curr() has to be separately implemented for a class
> and why the enqueue() handler of each class cannot take care of
> preempting curr via setting resched flags.
> 
> The only reason I can see is that, activate_task() is not always
> followed by a check_preempt_curr() and sometimes there is an
> unconditional resched_curr() happening following the call to
> activate_task().
>
> But such issues don't affect sched_ext in its current form I guess.

There's ttwu_runnable() path which just changes the target task's state and
then checks for preemption. The path doesn't involve enqueueing but can
still preempt. Maybe SCX might need to support this in the future too but it
doesn't seem pressing.

> Btw, if sched_ext were to be implemented as a higher priority class
> above CFS [1], then check_preempt_curr() may preempt without even
> calling the class's check_preempt_curr() :
> 
> void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags)
> {
>         if (p->sched_class == rq->curr->sched_class)
>                 rq->curr->sched_class->check_preempt_curr(rq, p, flags);
>         else if (sched_class_above(p->sched_class, rq->curr->sched_class))
>                 resched_curr(rq);
> 
> But if I understand, sched_ext is below CFS at the moment, so that
> should not be an issue.
>
> [1] By the way, now that I brought up the higher priority class thing,
> I might as well discuss it here :-D :
> 
> One of my use cases is about scheduling high priority latency sensitive threads:
> I think if sched_ext could have 2 classes, one lower than CFS and one
> above CFS, that would be beneficial to those who want a gradual
> transition to use scx, instead of switching all tasks to scx at once.
> 
> One reason is EAS (in CFS).  It may be beneficial for people to use
> the existing EAS for everything but latency critical tasks (much like
> how people use RT class for those). This is quite involved and
> reimplementing EAS in BPF may be quite a project. Not that it
> shouldn't be implemented that way, but EAS is about a decade old with
> all kinds of energy modeling, math and what not. Having scx higher
> than cfs alongside the lower one is less of an invasive approach than
> switching everything on the system to scx.

I see.

> Do you have any opinions on that? If it makes sense, I can work on
> such an implementation.
> 
> Another reason for this is, general purpose systems run very varied
> workloads, and big dramatic changes are likely to be reverted due to
> power and performance regressions.  Hence, the request for a higher
> scx, so that we (high priority task scx users) can take baby steps.

Yeah, as a use case, it makes sense to me. Would it suffice to be able to
choose between above or below the fair class tho?

Thanks.

-- 
tejun

