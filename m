Return-Path: <bpf+bounces-28946-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B228BEC9C
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 21:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF0421C21AED
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 19:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D53D16DED9;
	Tue,  7 May 2024 19:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ErnI20Pi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D252616D9A7;
	Tue,  7 May 2024 19:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715110384; cv=none; b=bn0y5ejKYBKuF6cq4UIXVAdlW33TP7v7+9A0GB6NhLy7rYhW+B41BDOZfZer21ukGHkP8Gb2o5vvyxrD0gRri1RGbPnCk5kmIo+rpCkyPJgq/yMQSI8RkC9wzQwhTyqrj7JFfnxjSHdXWH7DD1PyhnsWmeOxbgpem+wJ4NpDxv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715110384; c=relaxed/simple;
	bh=CPR9ch/GlHpyWLKQMttI7SNbnSjRL50R4RhvP9mm7xA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N0UGzmMh57UJtJ9WZK6sfKHp2EW3lB4ao0cyttRE031YGsWsJuN64poW6IzUQwdII/SaDnw6R9pw3el7YMvLq/jtbpXcJyUUdGq8BV/u+i3LYuxGpbiTRLatsBppnukbVEclM+SKZ2FYJZE6e89LQIFrTXWz1jnnpD0gDlW1/hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ErnI20Pi; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso2677906a12.0;
        Tue, 07 May 2024 12:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715110382; x=1715715182; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rD7v0gDbWiCf1lZMYfNtzi2ZYFCwoMta/CS/cvWRqtc=;
        b=ErnI20Pi/q6O8h+UjmHHLOaA3YYaXT7eSJXBm7I/sQi+iYurjK3sKYEOKU0gN8br+T
         NS9Mdz/uZusaJu4Ua4g0m0oX0MtoPvNg8Ytrj/8ZQcyC3Paw8PHW6hRlKNf/Xt+vUpsj
         IBSmefXTnb+gZ+SjsiaWtddLHilMS17oF5LKp7PqYIEWlXbTPsflMqh7poSjCu6JeAeu
         2Tc5q+3Cm1FtjNoRDh22ERwi6K0PqGTwDbs9HHBRPHWOTpEOLi7GYTwQFmLXOVTMbnLt
         AgR0A4fX3l3gnYMHcS+aUAB3b44ElsNrg7Vds4qsW5jLc2yVpxGHHLuF14Vnr0Asizkc
         uBlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715110382; x=1715715182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rD7v0gDbWiCf1lZMYfNtzi2ZYFCwoMta/CS/cvWRqtc=;
        b=eCjkOMcBk5N78lHN13raRrG4/tLVJEZBHePXelx/jEaiCiNpLZol52gMn9JaNZJzC+
         jlpavcSt1zWgwmw0chcX6e298N6ArrxNmCXuW0BegxQEsKYLz3HjTc9pdrdvHS8tivMO
         Bh1Oq9Ei3rd0I5ECsNbTQaO4N7XgH8QH4h8IlzOE/ip1IwEq81XEmboiIHsk14JzpHYt
         QjuMYiwaj45vlbf3P8BURW2ku4Uwzeg0GW1Tjul0nKn4j8msMPfeLKzu9JtyBdjFeoiq
         HSiivfE4C8QrPRkAbOxPQTwhb2Ithi6PaqqysZnxpVzArx4jWcRNcUyHt6O6Fuz33ld7
         iquA==
X-Forwarded-Encrypted: i=1; AJvYcCUt5HSp7EvKDeQWJGjupl7aDz0qTg2NsP42+uVd6CiJDb8HnGAI6fspLRoVuHe/EHW61R5phgAfgeSVwNvmxSHniFvie4J1vgsReysl66QAbjbxQXKLerheSlmKivG+u2ZV
X-Gm-Message-State: AOJu0YymIZslCvARj5W8IflFhPgSzZqlF1ZP2Jb6mVsCPwxoynu/lluc
	2mTJfBNfeXJKR9fG0sQVnrDh4hWMnR8TV1ZC9fPncPdV03fpkHxA
X-Google-Smtp-Source: AGHT+IF1S4xLAxfEV+v2kGwYbpkcLbBP3Asj7FZbDuz3DoE/FfoGBPklSdilK8HrS14wNu9HcEHcgA==
X-Received: by 2002:a05:6a20:a111:b0:1af:acb1:84bb with SMTP id adf61e73a8af0-1afc8d05bb5mr894293637.4.1715110381991;
        Tue, 07 May 2024 12:33:01 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id gd12-20020a056a00830c00b006f47df0ab80sm3826830pfb.124.2024.05.07.12.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 12:33:01 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 7 May 2024 09:33:00 -1000
From: Tejun Heo <tj@kernel.org>
To: Rik van Riel <riel@surriel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, torvalds@linux-foundation.org,
	mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@kernel.org, joshdon@google.com, brho@google.com,
	pjt@google.com, derkling@google.com, haoluo@google.com,
	dvernet@meta.com, dschatzberg@meta.com, dskarlat@cs.cmu.edu,
	changwoo@igalia.com, himadrics@inria.fr, memxor@gmail.com,
	andrea.righi@canonical.com, joel@joelfernandes.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCHSET v6] sched: Implement BPF extensible scheduler class
Message-ID: <ZjqB7MT6DeLznAgu@slm.duckdns.org>
References: <20240501151312.635565-1-tj@kernel.org>
 <20240502084800.GY30852@noisy.programming.kicks-ass.net>
 <ZjPnb1vdt80FrksA@slm.duckdns.org>
 <20240503085232.GC30852@noisy.programming.kicks-ass.net>
 <798768ad5db073d36467a432352b968b01649898.camel@surriel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <798768ad5db073d36467a432352b968b01649898.camel@surriel.com>

Hello, Rik.

On Mon, May 06, 2024 at 02:47:47PM -0400, Rik van Riel wrote:
> I believe the issues that Paul pointed out with my flattened cgroup code
> are fixable. I ended up not getting back to this code because it took me a
> few months to think of ways to fix the issues Paul found, and by then I
> had moved on to other projects.
> 
> For reference, Paul found these two (very real) issues with my
> implementation.
>
> 1) Thundering herd problem. If many tasks in a low priority cgroup wake
>    up at the same time, they can end up swamping a CPU.

The way that scx_flatcg (which seems broken right now, will fix it) works
around this problem is by always doing two-level scheduling. ie. The top
level rbtree hosts the tasks in the root cgroup and all the active cgroups,
where each cgroup is scheduled according to their current flattened
hierarchical share. This seems to work pretty well as what becomes really
expensive is the repeated nesting which can easily go 6+ levels.

This doesn't solve the thundering herd problem completely but shifts it one
level. ie. Thundering herds of threads can be handled easily. However,
thunderding herds of cgroups can still cause unfairness. I can imagine cases
where this can lead to scheduling issues but they all seem pretty convoluted
and artificial. Sure, somebody who's intentionally adversarial can cause
temporary issues but perfect isolation of adversarial actors isn't what
cgroups can or should practically target.

Even in the case this is an actual issue, we can solve it by limited
nesting. cgroups already have deligation boundaries. Maybe it needs to be
made more explicit but one solution could be adding a nesting layer only on
delegation boundaries so that misbehaviors are better contained within each
delegation domain.

>    I believe this can be solved with the same idea I had for
>    reimplementing CONFIG_CFS_BANDWIDTH. Specifically, the code that
>    determines the time slice length for a task already has a way to
>    determine whether a CPU is "overloaded", and time slices need to be
>    shortened. Once we reach that situation, we can place woken up tasks on
>    a secondary heap of per-cgroup runqueues, from which we do not directly
>    run tasks, but pick the lowest vruntime task from the lowest vruntime
>    cgroup and put that on the main runqueue, if the previously running

When overloaded, are the cgroups being put on a single rbtree? If so, they'd
be using flattened shares, right? I wonder what you're suggesting for the
overloaded case is pretty simliar to what flatcg is doing plus avoiding one
level of indirection while not overloaded.

Thanks.

-- 
tejun

