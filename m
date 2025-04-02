Return-Path: <bpf+bounces-55127-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0147BA788CA
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 09:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 227013AE690
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 07:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C5123373F;
	Wed,  2 Apr 2025 07:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Wl2+76ZL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C73C232373
	for <bpf@vger.kernel.org>; Wed,  2 Apr 2025 07:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743578442; cv=none; b=OzTqxYtECS6/v6L9t2GDJ+e/ZuyofwJNvbJ/gtv6zaOEaBCve5/zUP0Ghg0ipUd1xkQadyuWh5cXFrxpDVleED9JECVZjuZnl6NhuYNHrnwBFlSUSEStFy/w/JZySRyMq5NZGlpQPEslJE/PPQzlvTllEtCbu2NrZgwV+AhzlGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743578442; c=relaxed/simple;
	bh=0MDNHCK3VkRwh2BYBJWxYBpWRqft3Wr/rGV8AuF6Ucs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hzld/Gt1dQ3Mg0TECoPhNN1a3okiBEjDuytic3ufwMZecXfCWL8emNbwPjWEKXh/Mol50lkE6euVbZz8OldDKxBf+mzY7F0cD+MZmuKFSMA1QhPeEx2/VzwfMIbYTFA4W+DNV62H7ziyja2svnOblro3fq9SVhuvNP5I34Lvqzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Wl2+76ZL; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cfa7e7f54so2836685e9.1
        for <bpf@vger.kernel.org>; Wed, 02 Apr 2025 00:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1743578439; x=1744183239; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EIdJj957E0zfMC1C52ln0X1wpZ+moU8YgwfPLRZy4XE=;
        b=Wl2+76ZLFt9/UsQSkbfnVRXQAO6ntU1Lmk5ZVjmb6m9eKnfdc1lgCwzC01hxPx3qmO
         wy56iy/hrhM+l8VyVddblGs1jFgW3dU7WAIV+RX2FMXXKpDuxwC4xCTClLpp06nH3+e/
         b/ROjl3lOVjhC++ZlFdKsd/Egw+5GLXwxmTuS3qiZb1TGrK0/rudWYnQDpzZd2yN07iI
         QxO0I+JWhtKo88a5lWUDRTZ7Dzeig0O3/Am1zBGNvsTleMLhHFexcO4ienZGhQlVN0w3
         Ck7S3Rbk3fetxe9R7sYPb6WzlODo/6aDHsmX3XzSmt+kDOLQwJvgpZY2IBnVcq0My/Lz
         88uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743578439; x=1744183239;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EIdJj957E0zfMC1C52ln0X1wpZ+moU8YgwfPLRZy4XE=;
        b=CD50deiKTLFsu1tS4eCeW2wt01416IcH9XYRQaD2AK438FFl+cLV5O11pKLlpWSgbb
         +F/tFHsmr91oB3ViJRxb1BWXxHdZUJ3nHG1cHbTPYtA+LBv/dP5KVf4jPt/KeTVf6dA4
         sZXFPews5uJ7ExwlJJJp17bryTJaSebjkWfcgOeLlkYBuAPM8o87UD1pF/LvACrOw/o9
         6rGh0wpxd0ueQMS+R+Lc6Jofmj4W45bfZgdy8TitCWW1nWrhLW2U2StQ9vHQHlzlM0hf
         31c7WuDqWaiQ7QykDuBrDqvZJK1+ALEyd+SoQOFPZQ7eyi4DwvKvWpepJNuRb7v+HwQP
         hIwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCUThEURHSfBfBcYdg8+rCHdzssXC+6r/bvuN6F0UWGzCs/v5MJThjO+AjZD5cYi1rTIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeIig91kzQ6TbVyPMjVO6Y870/Rflp9c0ZQrP/TTXgj7mKaVfa
	862zBx6jcYlrGIrlentCE59pUBlinMVsJgaq4w21LJSK2cSxcjj7cM2FkV3Cg9U=
X-Gm-Gg: ASbGncsanxJND4lrDFR0wkU6pNcec+iZTuPqa4QsBvbPif64YABHTP55+fDH4JPsRdZ
	KwJC6U9Ki1jYQm8wA78+idIx5Q58Vdnn71XYS7FrcmT7xEIR0khPBnL2EXX5VQAg/HISr3G/LSQ
	NbxX1gOHE29HKF0gzQfxV432fHCalCV2K5LBxz9ttXSaDYHTAWATh+nBYQe8anFH2flsAZTJ7ZV
	lbWcB1yxwY5yZFio6+a7X2pn2JA/JQP6IgiD5MkcXfYL72ktL+zNAbuUNbeUcWa6kmz53volXPp
	djqaMxhXy6Uaccd3ZttLGar0V2iVhiS1ejEN2J2scfScvQeamHk05IoRlQ==
X-Google-Smtp-Source: AGHT+IE2L4my6sPk4at5ftAoG0v5WbxGaVF/fk8d5mLzPcR4uQonJ76hNjwuuSa/akA9CASfpugANw==
X-Received: by 2002:a05:600c:1e0e:b0:43d:16a0:d98d with SMTP id 5b1f17b1804b1-43eb71d7d27mr7335715e9.15.1743578438623;
        Wed, 02 Apr 2025 00:20:38 -0700 (PDT)
Received: from localhost (109-81-92-185.rct.o2.cz. [109.81.92.185])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43eb5fcd3d7sm11659375e9.12.2025.04.02.00.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 00:20:38 -0700 (PDT)
Date: Wed, 2 Apr 2025 09:20:37 +0200
From: Michal Hocko <mhocko@suse.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
	mingo@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, oleg@redhat.com, brauner@kernel.org,
	glider@google.com, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, akpm@linux-foundation.org
Subject: Re: [PATCH] exit: add trace_task_exit() tracepoint before
 current->mm is reset
Message-ID: <Z-zlRSo6G1xWcd7I@tiehlicka>
References: <20250401184021.2591443-1-andrii@kernel.org>
 <20250401173249.42d43a28@gandalf.local.home>
 <CAEf4BzYB1dvFF=7x-H3UDo4=qWjdhOO1Wqo9iFyz235u+xp9+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYB1dvFF=7x-H3UDo4=qWjdhOO1Wqo9iFyz235u+xp9+g@mail.gmail.com>

On Tue 01-04-25 15:04:11, Andrii Nakryiko wrote:
> On Tue, Apr 1, 2025 at 2:31 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Tue,  1 Apr 2025 11:40:21 -0700
> > Andrii Nakryiko <andrii@kernel.org> wrote:
> >
> > Hi Andrii,
> >
> > > It is useful to be able to access current->mm to, say, record a bunch of
> > > VMA information right before the task exits (e.g., for stack
> > > symbolization reasons when dealing with short-lived processes that exit
> > > in the middle of profiling session). We currently do have
> > > trace_sched_process_exit() in the exit path, but it is called a bit too
> > > late, after exit_mm() resets current->mm to NULL, which makes it
> > > unsuitable for inspecting and recording task's mm_struct-related data
> > > when tracing process lifetimes.
> >
> > My fear of adding another task exit trace event is that it will get a
> > bit confusing as that we now have trace_sched_process_exit() and also
> > trace_task_exit() with slightly different semantics.
> >
> > How about adding a trace_exit_mm()? Add that to the exit_mm() code?
> 
> This is kind of the worst of both worlds, no? We still have a new
> tracepoint, but this one can't tell if it's a `group_dead` situation
> or not... I can pass group_dead into exit_mm(), but it will be just
> for the sake of that new tracepoint.

Is it important to tell the difference between thread and the
whole process group exiting?

Please keep in mind that even group exit doesn't really imply the mm is
going away (clone allows CLONE_VM without CLONE_SIGNAL - i.e. mm could
be shared outside of thread group).
-- 
Michal Hocko
SUSE Labs

