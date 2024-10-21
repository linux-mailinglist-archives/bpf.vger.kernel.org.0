Return-Path: <bpf+bounces-42666-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A20D9A708C
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 19:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AA7BB22043
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 17:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730881EF941;
	Mon, 21 Oct 2024 17:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmYY5Esa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD2C1E8838;
	Mon, 21 Oct 2024 17:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729530297; cv=none; b=TdzX3r1zN9PiMDH1kuCVTUrgSProCWB7WgCSi5e1NuJGC/s4WoU0J/Gn1jQXzbiAAIBjKy/zZozQcanBbVF3gbNmCGcayiE4lciEMvgVGDG4oCAy4xfEKZWk2J+cmEWKJHzoVFAuVRvavtQ1ApUgcP77IuqiLIVSU9IwjCpBFq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729530297; c=relaxed/simple;
	bh=CR5RjoyQjmJ04onc1gUas0ad+msgrElFQsuZL2VMhg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bBIlojKivQvF5wjsT3cLAYNoh4AhzrvXUOTHDCx3uSZBMSklsCkjU9ERGLMROF3kIw0lkru8dg/wCrYykXF91gxUfWDb6apyLzilxCcdDxpjq/5dGQ+aHlYsIbiOXKALdHstc61Wf5k1D4XY/ppeY2hSkglT1mwzkWYUKbolHbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MmYY5Esa; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71e4e481692so3921441b3a.1;
        Mon, 21 Oct 2024 10:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729530295; x=1730135095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQG6MR1AENI44ceUDAJNSQ0PP8riW7rnDgze7XGFkjc=;
        b=MmYY5Esavq423IKt5JTW5b/WFtbH4MAvNZR3NNo3xWuWFAV4aBht278kBFKaplyG1X
         wmX+ct32HQs4uBzCqVPE1VJLDJvH8TN0F5g3GDryiXZ+LCV6ht9zMcbrRC1cRv/CAk/q
         OhLG/4A2L/XjEfGYs4filL3mWOewwRUbvKB4VzLv5uDGrxtLvrs42UVRZ7QDs18LmiSi
         Yn6uDTOs8E1ifeX8/agysaGMtRc0zywk/r4yjiDgAQAzX4BDlnpCdZZAmX0Qb7MeDMdB
         cbOuqM3esN9kVkrIMznQ/jH6A50Z5I/xFjam+4iTDS/0SQ4QhsMjTc/okl7gG83hOK7K
         C6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729530295; x=1730135095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CQG6MR1AENI44ceUDAJNSQ0PP8riW7rnDgze7XGFkjc=;
        b=c8U4In53Xh28X3D9wbZFNS/ED8YhkOmIgDsf2xAXa8JH8y43DzY4GnoGuO/cBlHfKI
         ki2bBmQMZdBBQVLg/GtYwnnc55fedOE/3I+RpNSzlaAL3553uddsROjoZyC5FxmjseZm
         H9zsI5TT+u3EnTK479Bl5D7K8pz5NXGP6CYllfss2V6tw8YGyCf8GQPLu/vO2malXOkm
         Kc3iKQRuMLrqBB1w4xvmRQW13G8kf0s3ssKOYyFfqIgSXqAlyYGYa3ODFRbQIkTzzBBE
         V/6xiHwNa3f5hyVf/Y8Cf7U/Teau0LCym9IATw0ho8if9+EQ8kXfsMqten1WSrsA6qEz
         czgg==
X-Forwarded-Encrypted: i=1; AJvYcCV98qJWkb8v00cF8EL+eEGywC+FvTsAZ/J13HNnkDofkJVOs55f2W+KTvPnwntzatMQBYw=@vger.kernel.org, AJvYcCWSkBbYCiPegsm6SMrZ649Gm29rYBLPUtb8w89TwZNbmheuK9jS2I29rSfth1M6jUmMkWRFDs8z5scKS9sc@vger.kernel.org, AJvYcCXovAmEBKy1C8GPUzGAh6xekzwLyLEXyP6bsMIS7V+KTSZGB7pF7NzNDuyrR4rvGiwdDtWAcVCMIHTTwFTTdaduq+jF@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3u/yGTBdtInPQjIKQs7Ucuz+3gJPU8YqMJtfnMeUFAp7FvIpG
	GUEHic+AKLQP1dKaV7NZlD3VI20Ks87jHFrGlM554COOzwB4xadAsS0qpru0pufHvxhmLzp63tv
	dDK7id9VV0WP/oKASGOU7JHGhdTY=
X-Google-Smtp-Source: AGHT+IEay4FYcmWDyON/XJSoe4K5dh73uhcv1K355uE7k7CYuYjr+hj+dv937U/aUdp++6LOQ1wbUKe7+LSa3MzXpMc=
X-Received: by 2002:a05:6a00:3e0f:b0:71e:4a1b:2204 with SMTP id
 d2e1a72fcca58-71ea331b398mr15912077b3a.25.1729530295151; Mon, 21 Oct 2024
 10:04:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008002556.2332835-1-andrii@kernel.org> <20241008002556.2332835-2-andrii@kernel.org>
 <20241018082605.GD17263@noisy.programming.kicks-ass.net> <CAEf4Bzb3xjTH7Qh8c_j95jEr4fNxBgG11a0sCe4hoF9chwUtYg@mail.gmail.com>
 <20241021103151.GB6791@noisy.programming.kicks-ass.net>
In-Reply-To: <20241021103151.GB6791@noisy.programming.kicks-ass.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 21 Oct 2024 10:04:43 -0700
Message-ID: <CAEf4BzYc-YACW6XnHMVZLE+8_zJqkaJWBKE4iNeo3Jfj9RwaNQ@mail.gmail.com>
Subject: Re: [PATCH v2 tip/perf/core 1/2] uprobes: allow put_uprobe() from
 non-sleepable softirq context
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, oleg@redhat.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, mingo@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org, 
	paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 3:31=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Fri, Oct 18, 2024 at 11:22:00AM -0700, Andrii Nakryiko wrote:
> > On Fri, Oct 18, 2024 at 1:26=E2=80=AFAM Peter Zijlstra <peterz@infradea=
d.org> wrote:
> > >
> > > On Mon, Oct 07, 2024 at 05:25:55PM -0700, Andrii Nakryiko wrote:
> > > > Currently put_uprobe() might trigger mutex_lock()/mutex_unlock(), w=
hich
> > > > makes it unsuitable to be called from more restricted context like =
softirq.
> > >
> > > This is delayed_uprobe_lock, right?
> >
> > Not just delated_uprobe_lock, there is also uprobes_treelock (I forgot
> > to update the commit message to mention that). Oleg had concerns (see
> > [0]) with that being taken from the timer thread, so I just moved all
> > of the locking into deferred work callback.
> >
> >   [0] https://lore.kernel.org/linux-trace-kernel/20240915144910.GA27726=
@redhat.com/
>
> Right, but at least that's not a sleeping lock. He's right about it
> needing to become a softirq-safe lock though. And yeah, unfortunate
> that.
>
> > > So can't we do something like so instead?
> >
> > I'll need to look at this more thoroughly (and hopefully Oleg will get
> > a chance as well), dropping lock from delayed_ref_ctr_inc() is a bit
> > scary, but might be ok.
>
> So I figured that update_ref_ctr() is already doing the
> __update_ref_ctr() thing without holding the lock, so that lock really
> is only there to manage the list.
>
> And that list is super offensive... That really wants to be a per-mm
> rb-tree or somesuch.

Probably hard to justify to add that to mm_struct, tbh, given that
uprobe+refcnt case (which is USDT with semaphore) isn't all that
frequent, and even then it will be active on a very small subset of
processes in the system, most probably. But, even if (see below),
probably should be a separate change.

>
> AFAICT the only reason it is a mutex, is because doing unbouded list
> iteration under a spinlock is a really bad idea.
>
> > But generally speaking, what's your concern with doing deferred work
> > in put_uprobe()? It's not a hot path by any means, worst case we'll
> > have maybe thousands of uprobes attached/detached.
>
> Mostly I got offended by the level of crap in that code, and working
> around crap instead of fixing crap just ain't right.
>

Ok, so where are we at? Do you insist on the delayed_ref_ctr_inc()
rework, switching uprobe_treelock to be softirq-safe and leaving
put_uprobe() mostly as is? Or is it ok, to do a quick deferred work
change for put_uprobe()  to unblock uretprobe+SRCU and land it sooner?
What if we split this work into two independent patch sets, go with
deferred work for uretprobe + SRCU, and then work with Oleg and you on
simplifying and improving delayed_uprobe_lock-related stuff?

After all, neither deferred work nor delayed_ref_ctr_inc() change has
much practical bearing on real-world performance. WDYT?

