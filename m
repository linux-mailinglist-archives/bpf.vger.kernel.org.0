Return-Path: <bpf+bounces-32612-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F66D910F68
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 19:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27101283694
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 17:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABC61BD010;
	Thu, 20 Jun 2024 17:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZCO6SSet"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632A41B9AA6;
	Thu, 20 Jun 2024 17:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718905276; cv=none; b=Altdz5pL7oIXAnBlmbVUFj20p1oiIngBvEwjNhjdf3vFlYfb8Nkg9n7lZneWDYY/Ydvg8rmmZGSWAa+0dPLjBh/9aI/2K8gparylhMLJ4/MfNDwi9IAQ3iL6TkZvhvCXgw12uJmsr8VsZbUsNivi6keQZQYocoMPkSioy+j9o44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718905276; c=relaxed/simple;
	bh=kspnDibYYqpAwWCwYVF3O/cAvoqZvd/Yv0Wd7jmZK/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QgZ5gsftYoMJzo1emmTrPenUC/HA5Z15mqsrwfiLXGW8hnew0aX+rNxgKDKEirTTdjk0jhhBgUasZNxkpWAKLrbIAexSfDO1RmAFCDskWPIuccegLh4KRTBQnNzjx1bgjJEJyB2yVozgQvbChgQwdc/LtDdOUGScMEyyTasCb8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZCO6SSet; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f6559668e1so9093565ad.3;
        Thu, 20 Jun 2024 10:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718905274; x=1719510074; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pz09689rZGZF/ODqBYzCJ0U3edNlqpyS+Vlz13ndJRQ=;
        b=ZCO6SSetbeNqLbgd16LGD2CHASrythBqpC585zU9HYwGzN9eGsRQ009sHhWT4X7ZzG
         uIPnsXpbJeEehWKtmKiKuYowCW2Qmb41TL1wO+JFt1f3VgzLgPOA8vyMaTI0BRwS9qn0
         2Tx05QJ8Z1UHHjn5Y3rkVD0Z4cKLYMtloGtW9p6dQhdGAiB/5BAQEnI7dfjJnYQ4olfm
         AfqA0OadR2sa6lALBA16aRbTkxQlrjvrA+mBswjcgrPTiZ/dF2HWTmAga2bDQg71SqPh
         KimfBtNKzoNEon+10op2coTtxchBla4YUxZAKyKoCTllccAO/3aZ4BOwRnUIOZO9neXi
         oZOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718905274; x=1719510074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pz09689rZGZF/ODqBYzCJ0U3edNlqpyS+Vlz13ndJRQ=;
        b=cqsxPXsJpA9WaGeXmRP6H4TBO5V0GgRLxxwadrzIOf/Wtn5fdFr76Z1VYZC0c6MPyU
         Xvr1i3qv44J9Dn6o/WOOnDCzaHMtOOo8XtSJAkDN88YBY0pI83KXr0/u2y++ylAgXkyM
         ERpcUZZ0dr6VXbMBaOor/4LV6NWARVrn0VKQNzu4AZi1iREEgQyrfbAkvV9lhS3GFJeN
         zZUjqJyfX8NW7xyJFaSKokwsju/K5NjgWiF8+NkOz8dN6han6lL9NDVTPwV1KuZSdhaD
         g+QQ0aF++Rhmoro46HnPoqiHTTNgYGTD0ULKQR9jANmJ0AtgJkUyD1Ex0W370kT3bK/7
         vcWg==
X-Forwarded-Encrypted: i=1; AJvYcCVESHyIBg4fxUPnfYF2VuiME2cdR0nJnbrwzrSv5yVxfOhVaLpCSJAcU49Dq/7EFhDDS+CcDQZAERfxq71M4pUXSReODftjx1mfl7GnmQlptaOXF/mkaw+dt5VsS8jHEoJU
X-Gm-Message-State: AOJu0YycF2pUW/bxZ8o0oeynR8P+LfmhKXGNAXi+bih+C1DacM0HhNox
	9pd6StP2wHqWia8DQDboxD4LuzlXToM2iJoEAAXqroH8iKnMNU+J
X-Google-Smtp-Source: AGHT+IEu+FrFyaUPLngd/9Th2JsxbWQzojStzeQC3cLPTUayXolPW4UU2GtiwXwCkOc3pwZjf0qWvQ==
X-Received: by 2002:a17:902:6508:b0:1f8:7436:58e6 with SMTP id d9443c01a7336-1f9aa47390dmr45232345ad.65.1718905272473;
        Thu, 20 Jun 2024 10:41:12 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9c22ae4a5sm23981345ad.7.2024.06.20.10.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 10:41:10 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 20 Jun 2024 07:41:09 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
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
Subject: Re: [PATCHSET v6] sched: Implement BPF extensible scheduler class
Message-ID: <ZnRptXC-ONl-PAyX@slm.duckdns.org>
References: <CAHk-=wg8APE61e5Ddq5mwH55Eh0ZLDV4Tr+c6_gFS7g2AxnuHQ@mail.gmail.com>
 <87ed8sps71.ffs@tglx>
 <CAHk-=wg3RDXp2sY9EXA0JD26kdNHHBP4suXyeqJhnL_3yjG2gg@mail.gmail.com>
 <87bk3wpnzv.ffs@tglx>
 <CAHk-=wiKgKpNA6Dv7zoLHATweM-nEYWeXeFdS03wUQ8-V4wFxg@mail.gmail.com>
 <878qz0pcir.ffs@tglx>
 <CAHk-=wg88k=EsHyGrX9dKt10KxSygzcEGdKRYRTx9xtA_y=rqQ@mail.gmail.com>
 <CAHk-=wgjbNLRtOvcmeEUtBQyJtYYAtvRTROBy9GHeF1Quszfgg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgjbNLRtOvcmeEUtBQyJtYYAtvRTROBy9GHeF1Quszfgg@mail.gmail.com>

Hello, Linus.

On Thu, Jun 20, 2024 at 10:11:49AM -0700, Linus Torvalds wrote:
> On Wed, 19 Jun 2024 at 22:07, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > And scx_next_task_picked() isn't pretty - as far as I understand, it's
> > because there's only a "class X picked" callback ("pick_next_task()"),
> > and no way to tell other classes they weren't picked.
> 
> I guess that could be a class callback, something like this:
> 
>         p = class->pick_next_task(rq);
>         if (p)
>         if (p) {
> -               scx_next_task_picked(rq, p, class);
> +               struct sched_class *prev = last->sched_class;
> +               if (class != prev && prev->switch_class)
> +                       prev->switch_class(rq);
>                 return p;
>         }
> 
> and that would be arguably much prettier. But maybe I've
> mis-understood the reason for that scx_next_task_picked() thing.

Yes, this would work. The callback is there to notify the BPF scheduler when
SCX class is preempted by one of the higher priority classes so that e.g.
the BPF scheduler can punt the task[s] that was running on or waiting for
the CPU to other CPUs. I'll prep a patch to make it a sched_class callback.

There are other hooks which are trickier. e.g. scx_tick() wants to be called
regardless of the class of the current task for the watchdog and
scx_rq_[de]activate() are there for two reasons - 1. sched core doesn't
distinguish actual CPU hotplugs and sched domain updates but the latter
doesn't translate well to BPF schedulers 2. it's nice to give sleeping
context to the BPF scheduler. The fork hooks are in a similar boat as SCX
just needs more synchronization and sleepable context where other classes
don't and likely won't.

I can make all of them callbacks but I'm not sure that'd be all that useful
for other classes and the semantics would be different from other callbacks,
so it's unclear that'd be an overall win.

Thanks.

-- 
tejun

