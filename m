Return-Path: <bpf+bounces-32557-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA7A90FC1B
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 07:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03F1B1C218B5
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 05:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B35C2BAE2;
	Thu, 20 Jun 2024 05:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="b5nEx0pe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D2F22625
	for <bpf@vger.kernel.org>; Thu, 20 Jun 2024 05:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718860117; cv=none; b=nrFgHkDneQK6Unxuj+9pQNSfIcUW1HExKLLv8g3AZdk7F2l8Z5aBNj9ssn0NY5U6wt7gGeiu/Ww7yPvQcSHz/RsoZ0UENpgHgl/zNGAcnm/HzU7duZbsAH1NcRxIEdoavsKKYLZCIZT7lYWOPPvSuPqKCI1UeUI4WzOb6kiWlss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718860117; c=relaxed/simple;
	bh=PGEcj8aZ0X8uBbNFw1pg4Ohn4geSnMhLB5GTcNk6DQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XzvxU8gjITVjmuPEwaBtU1B+QtzOJYZJEvoz6QP/XPs31EwkW27s90s3tz700DqyEk2CV9rcqWaaacHsYJNcDKo6SeP0d8+wNl5Sd2Tq1qybVcEuEkxcLivDS7Lv+BfLxejuYS94eO8ZarjXSBkBcOW3UqK4Tho7TktCGD5n+P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=b5nEx0pe; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52c32d934c2so460077e87.2
        for <bpf@vger.kernel.org>; Wed, 19 Jun 2024 22:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718860114; x=1719464914; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mKJ7tA0uxmt7GivwOPU2qhqe93NAGJzAby4kZnJZbdI=;
        b=b5nEx0pe/gYDTazkR0ULDSkSFzo2OCtd+RwRt6i8ho9DXOc9KFIztYM0M5+sTPaQBZ
         B87ozhePoCzBF3YLmq7sYAVwv+JHfYw8ltYq0H6UNyNdF9J/+9AXKwH6j8N8tstOnViZ
         z/yY0Np0abBy9p3aXMAfKA/9RlPbpRXArNGI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718860114; x=1719464914;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mKJ7tA0uxmt7GivwOPU2qhqe93NAGJzAby4kZnJZbdI=;
        b=Fb2YdmDVNHgT51qY5FAx+5sAWg+aQg0jsWZ3vEV7+q6rMUcNznnJ1Mm8cAD4OTvq4M
         sW5eXujqSM38DuKcaVhLsa0GeC6yOedpfLjNPDdKApHy/J1C6yy4V22kK0ZrI2ASP6Op
         0f7f550aDTKOqy06KrqXUkpqh9DLnBhrN6GzP06SQyGx6TzoTVOMTHQygb4v37OMagtT
         H+qDO59BFCeLF+9SbVHDr3WgTYQDz3cdZeibe/fBHTexYSl3ch6/btyRc5H4cGEZAPYU
         9BGm5zyowTzTD5t32m9B2odnS9aiGqVMhleQl6X4Tld1NRRx16FLn3oVecfHgbZhcu+x
         4hHA==
X-Forwarded-Encrypted: i=1; AJvYcCU1/A0mqfA27tquUJns19E5HAjjhEvi8rIuW8WhlGSc+8mtKKcXWzvq8ZqObYocOIJDr499RC83yK2TI7TK2/htIHCN
X-Gm-Message-State: AOJu0YzwFAGJLbgACrOZEt6q2EOJFB/WeX35tesHlKimYIKSd2KWF2Xl
	+EZKjWSJNFXRrqQa+BP2QOw0M157vWS5OlT9tWai6cw/E18QHXbb2MfqrcVXJoXqH0QQCceOG4t
	LRLjS9g==
X-Google-Smtp-Source: AGHT+IH7bB3BAINDA+QvpI0mkRXTM3epiSDvDPcSFC4cR+BDCVcLS8Gy5YEAEM9yCEHwVRAIkHQiRA==
X-Received: by 2002:ac2:4650:0:b0:52c:4cfa:c5a6 with SMTP id 2adb3069b0e04-52ccaa3775emr2137076e87.34.1718860113881;
        Wed, 19 Jun 2024 22:08:33 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca282f55bsm1924749e87.102.2024.06.19.22.08.32
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 22:08:32 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52bc3130ae6so431135e87.3
        for <bpf@vger.kernel.org>; Wed, 19 Jun 2024 22:08:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX7bFSu6iY0CugYJZMEn8Cn6Lvu7egxkWdTwmR5gr8zKxozuNorA9YZjv0QQ9khI63M75BRhmCIc8uAawwlwitFkc1M
X-Received: by 2002:a17:907:a0d5:b0:a6f:bd27:3f13 with SMTP id
 a640c23a62f3a-a6fbd273fccmr98231066b.34.1718860091359; Wed, 19 Jun 2024
 22:08:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wg8APE61e5Ddq5mwH55Eh0ZLDV4Tr+c6_gFS7g2AxnuHQ@mail.gmail.com>
 <87ed8sps71.ffs@tglx> <CAHk-=wg3RDXp2sY9EXA0JD26kdNHHBP4suXyeqJhnL_3yjG2gg@mail.gmail.com>
 <87bk3wpnzv.ffs@tglx> <CAHk-=wiKgKpNA6Dv7zoLHATweM-nEYWeXeFdS03wUQ8-V4wFxg@mail.gmail.com>
 <878qz0pcir.ffs@tglx>
In-Reply-To: <878qz0pcir.ffs@tglx>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 19 Jun 2024 22:07:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg88k=EsHyGrX9dKt10KxSygzcEGdKRYRTx9xtA_y=rqQ@mail.gmail.com>
Message-ID: <CAHk-=wg88k=EsHyGrX9dKt10KxSygzcEGdKRYRTx9xtA_y=rqQ@mail.gmail.com>
Subject: Re: [PATCHSET v6] sched: Implement BPF extensible scheduler class
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Tejun Heo <tj@kernel.org>, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, bristot@redhat.com, 
	vschneid@redhat.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@kernel.org, joshdon@google.com, brho@google.com, pjt@google.com, 
	derkling@google.com, haoluo@google.com, dvernet@meta.com, 
	dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com, 
	changwoo@igalia.com, himadrics@inria.fr, memxor@gmail.com, 
	andrea.righi@canonical.com, joel@joelfernandes.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

[ I'll try to look more at this tomorrow, but I'll send this part early ]

On Wed, 19 Jun 2024 at 19:35, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> When I sat there in Richmond with the sched_ext people I gave them very
> deep technical feedback especially on the way how they integrate it:
>
>   Sprinkle hooks and callbacks all over the place until it works by some
>   definition of works.

Are we even talking about the same thing?

There are basically two new hooks, for reweight_task (which is
something the fair scheduler wanted and was the only user of) and for
switching_to(), which is the class changing (again, mainly because
there's now not a hardcoded "normal" class).

And yes, there are a couple of other things where the CFS rules were
just encoded in the core scheduler code, and they got an extra check
or whatever (eg the SCHED_NORMAL changes and things like stop-tick -
things that changed simply because now there isn't a single normal
scheduler any more).

The rest are mostly all the existing scheduler call-ins, afaik. Or
_exactly_ the same thing that other schedulers already do, like the
task_prio() stuff.

Yes, there's scx_rq_activate/deactivate at CPU up/down time. Doesn't
look unreasonable to me. Same goes for the idle cpu management.

In other cases, it takes a few code sequences, turns them into helper
functions, just to be able to re-use them.

The ugliest parts are from what I can see the whole "ok, stop using
user space input over PM events" and that "bypass" stuff is sure not
pretty.

But that's pretty much all internal to sched_ext, and seems mostly
like a sane approach to "what if we do policy in user space"?

And scx_next_task_picked() isn't pretty - as far as I understand, it's
because there's only a "class X picked" callback ("pick_next_task()"),
and no way to tell other classes they weren't picked.

But "sprinkle hooks and callbacks all over the place"?

Could things like that next_active_class() perhaps be done more
prettily? I'm sure.

But I get the very strong feeling that people wanted to limit the
amount of changes they made to the core scheduler code.

> I clearly offered you to try to resolve this amicably within a
> reasonable time frame.
>
> How exaclty is that equivalent to "continue to do nothing" ?

So if we actually *can* resolve this amicably in three months, then
that sounds worth it.

But my reaction is "what changed"? Nothing has become more amicable in
the last nine months. What makes the next three months special?

                        Linus

