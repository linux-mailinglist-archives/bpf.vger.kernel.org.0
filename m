Return-Path: <bpf+bounces-32825-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79286913746
	for <lists+bpf@lfdr.de>; Sun, 23 Jun 2024 04:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C1E01F22659
	for <lists+bpf@lfdr.de>; Sun, 23 Jun 2024 02:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66CE8801;
	Sun, 23 Jun 2024 02:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8coIPjl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE933372;
	Sun, 23 Jun 2024 02:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719108015; cv=none; b=YerHTkB+3BNYj+CuBMQzmw2fjnTakNDKwrGno92ciPtFPhYxf2glXBFB2yGftlJSW0guyNy5jk4g8ZP5OHscU2cinCQhd3gt6Egc+ewg9IBv2VjhHtorsuroTjyWxw4attTGy5VVH4gZ0hqlXNEbXCwukAPts2e/xJtj3/j0H2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719108015; c=relaxed/simple;
	bh=eqz1nYUW2n1wPnD+OrSmxaH89giYF+r0uVidt7/uExM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P87kfeX3idYOcOPHahE56NTeV01v1NX6vcT06nD786rOvjFwZDLWGXWypAxw5HDmoXhkAeVQIUdEPqY0zKJWuhjdHGLfZREjj2Ck5mh9eXVbqh1mcRYU6z246RqOX4PyKnIGqpxMefg25az1PrnaWZ0XLi61TdrwFbW/zl5dcxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e8coIPjl; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c9d70d93dbso2180638b6e.3;
        Sat, 22 Jun 2024 19:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719108013; x=1719712813; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KVGgnXFuBXdUfPKL+5geh4O7aTo/c5rb9X3Ypx2XCbA=;
        b=e8coIPjlMz9GLbS1Qpg93XnLcZJJJAORxyb1BCwWYlGIz4JJkqtfU6giCn5PMQe6uw
         0I5l2ndB+z2O+Bbgw2ZprPvriZRvzoQy7NEKHU4Qhz0H+JYF2sxZ2F4shtyGR5/vg4lf
         NNF+mAOtsvDw7ZOlXyuR9NcMC4ID1hYBUue9ozekrQOiKUFLMG9RlYyXAGrj6+bM2QJf
         Q8UtAN6JmO978P8+TnPPsiB/8C7P8qXIw5XAWhSBRt0AWrU5fVwwDMeoenMFL6fT9+F9
         iNB9hnKzRAzWKxnVSE5TfnlSnsRgA5f/hf3ZXpzoBZ79Z+pI6nF2sRqieKBXrjPT+nO1
         vIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719108013; x=1719712813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KVGgnXFuBXdUfPKL+5geh4O7aTo/c5rb9X3Ypx2XCbA=;
        b=Y+lHSHc0Niot8eTv/HPqq1Uav35vRg7a0ixLdCUxPVxBlnGKHuwSjMD9FRbVDk+UEd
         CSbpU5a5mnjy4Aiv6742tVfRfCqWzJJTi9wmgXpnUKfVWUOlU39z7ke0GpBzriSb3rgB
         BshK2q9ieelHXCAsdvBluMx1WcYmF/4UmCctCIVkS1nhoci/1RUBLWEiEwxtJqB34lIL
         QpsL2valh12E+zmlke1pkQN7CFaDXYOC1WusyCIGGWar6K0OLwuwwd3Akzko9m1HB3Au
         zXlbLlSszMVqf73b4KRwwZsxIhGnD3WtHa+LOToCoWugSyDVQrwwtacuHGzCOEH5dboa
         5gLw==
X-Forwarded-Encrypted: i=1; AJvYcCXU0i48KflYhPAmQqL6Mn1LxpBNrF4cghIESi08q+6vBTAHy8L51ns5f3JOoimFE18UHg1IcmR0zFAtWXTQuCT5R9vuD68y+5z/OwDbJMnQ+rRepDLeVj7cdTuRGlbAOJj5
X-Gm-Message-State: AOJu0Yws13A4arXxssXMPLAEdix6vhKgYs0dqTcjXsXckAB26+FHir8a
	plvXU4JdBaVJQbGQ0g0iCGejRzPpVq6mPAXOT+pWaiSL7sF/hBXZ
X-Google-Smtp-Source: AGHT+IGzqz6bzpwCOUAvh7s0zDmqCxafGtXwXCV7J66ZAG4Yj+vbnhVwsGYHiRZs+3+xWiBg/GqANw==
X-Received: by 2002:a05:6808:f8e:b0:3d5:2bb7:867 with SMTP id 5614622812f47-3d54596af33mr1599564b6e.17.1719108012928;
        Sat, 22 Jun 2024 19:00:12 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7066aeeaa5asm1652196b3a.29.2024.06.22.19.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 19:00:12 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Sat, 22 Jun 2024 16:00:10 -1000
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
Message-ID: <ZneBqla93mBpGdH0@slm.duckdns.org>
References: <CAHk-=wg88k=EsHyGrX9dKt10KxSygzcEGdKRYRTx9xtA_y=rqQ@mail.gmail.com>
 <871q4rpi2s.ffs@tglx>
 <CAHk-=wgN6DRks55fsqiJYE3uV=_QTgzdxOvh1ZZNgm_YooKdYA@mail.gmail.com>
 <87v822ocy2.ffs@tglx>
 <CAHk-=wiRgsFsrnTR8XShrS_-aYS--4DSrRPmaWtYJ55-fmjznA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiRgsFsrnTR8XShrS_-aYS--4DSrRPmaWtYJ55-fmjznA@mail.gmail.com>

Hello,

On Fri, Jun 21, 2024 at 09:34:22AM -0700, Linus Torvalds wrote:
>  (b) the for_each_active_class() thing that I think would actually be
> better off just being done explicitly in sched/core.c, but probably
> only makes sense after integration

Just posted a patchset to integrate sched_ext a bit better. I open coded
for_balance_class_range() and moved for_each_active_class() and friends to
kernel/sched/sched.h. If something else would look better, please let me
know.

  http://lkml.kernel.org/r/20240623015057.3383223-1-tj@kernel.org

Thanks.

-- 
tejun

