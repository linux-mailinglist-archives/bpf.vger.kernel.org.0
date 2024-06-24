Return-Path: <bpf+bounces-32934-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5083E9156E8
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 21:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12CDD285589
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 19:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0319219FA92;
	Mon, 24 Jun 2024 19:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7ruaRUJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0892419EEC8;
	Mon, 24 Jun 2024 19:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719256002; cv=none; b=BhSW9RCLYQC0ajfYKrMYh2USsA7fvmR9+iFDavWQ5KCFHNtH1tiQagzEkC8o0hvvUKIAodMy0gpCm01VioKSSIeFm2zi9sQweOcWjGAlk3HINJdsVwlvq9rKKZBHpkWsWtltVYWsBlN1Px5f1G3fJZfvPpYLXCGXOoMxgmfWdY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719256002; c=relaxed/simple;
	bh=98K3I6JpoWZlFoBxPNgSj6G7nD056PuEl8Mzo6chLdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=amrNHP1tvp8BZP7IUyubaf9nQgoEqCAVAfFTZyYay908OkNd1J1QvZ2nHmoU+f0sXgO0Xi2HntUr6ZEKAbKB21Ycj7HG01mO1ra7Tm/B1Zw2rz4BJhX+pwxdSeMTJKfAYiGJNs51IlpGwGhdWH+HwF2flej5ITEOtFgqe/TPzvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M7ruaRUJ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f480624d0fso36580075ad.1;
        Mon, 24 Jun 2024 12:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719256000; x=1719860800; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oyqW3OxhXyEo8374isZdsKRGiqDGGV7DUgBfzoWrQ+A=;
        b=M7ruaRUJ0TYWy2AUswZw9wXxaknGWInMIXRcHgVaz8clXLKnaPyrnh7D7tux0picTz
         r3c7W3gL1hx9YhZw2JTo5zv0+BdQUN5oalQXoGHAKztwZ9Sl1u4SxlSntFK2fpV/rvbB
         27fphHZa0Ssd6Gkw9OrZL1s8DPSb5cEgcwO1uxQXOoau1AOg62Wkz6dDQIGMrK97igBI
         9XdRGjEe5bCHluc7rlGtut5EYqtkE7t0N28JLHbHBSCblrpm4auwqbnYk4nrSzwxVYhk
         TAs0tAk8H23EdrBTbbPEw1y3rbhpAd1GtSVON0mfeMIXC9FZBkhQwmY1Q6inKQ61HIVI
         CO6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719256000; x=1719860800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oyqW3OxhXyEo8374isZdsKRGiqDGGV7DUgBfzoWrQ+A=;
        b=n/sSXSEEFRMByVeR13phNpg0DqS4zpoLMyvuuXcAvNKKhSfCi4RrtOTAVFfk3au5lA
         fjWM914C5V/njoL5VVHgT/UOz8R88m8ICymrPqswEowZmb5W6/o5ZypnXgL6J5We/WbL
         WVhdK76MgQD5Ut3zwK8PTXPIyeHYu2ieiazT5i1mYVGeZB2xKz1XaQGKps65HA7NEDrA
         ilqQ+FKbMdLt+F5mVscmYMKfKptg9aSyl0394xpCTl/9LBZ4mowD1BvEOsHj/2uPGdqs
         vKplj43ej4PaYAe5dd4gCSIsrX+R/NiS4bUgMyqCVA7Z8of6XFFASTnMDozTnDv0R24L
         r/sQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWwkw+5Re7edzrisLLb5tMET7J/v5NDHrSA/7Oa5Lw6wc/Zi1sAF3yw/mg9yrIXWkG45HRMZ+cnj7vL5YsB0vJrWljSsPZrAA4W/mmPSsfNqfzR3ggp0wfNOAm1W/Y6tSw
X-Gm-Message-State: AOJu0YzykA84uzbwRIf/AY72nBtsXf6uBGkWkJmzNAxbCsNKrr/OTX30
	PXgIqtFWxseGD9dFsCJRAu1crMhHXiDP/SYpm7RjnQkKeSX6DXHq
X-Google-Smtp-Source: AGHT+IGKJ271VSNPC62Dp395/dIAHhklrFReOlcggoz7FxFOJ+zfobtEQEO5LKP2wkfZzm+TkYZTkg==
X-Received: by 2002:a17:902:db06:b0:1f6:7f45:4d37 with SMTP id d9443c01a7336-1fa24187520mr48373015ad.66.1719256000120;
        Mon, 24 Jun 2024 12:06:40 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb5e0a3esm66355225ad.215.2024.06.24.12.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 12:06:39 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 24 Jun 2024 09:06:38 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: torvalds@linux-foundation.org, mingo@redhat.com, juri.lelli@redhat.com,
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
Subject: Re: [PATCH 18/39] sched_ext: Allow BPF schedulers to disallow
 specific tasks from joining SCHED_EXT
Message-ID: <ZnnDvlt1WmYm8LWN@slm.duckdns.org>
References: <20240501151312.635565-1-tj@kernel.org>
 <20240501151312.635565-19-tj@kernel.org>
 <20240624124053.GN31592@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624124053.GN31592@noisy.programming.kicks-ass.net>

Hello, Peter.

On Mon, Jun 24, 2024 at 02:40:53PM +0200, Peter Zijlstra wrote:
> On Wed, May 01, 2024 at 05:09:53AM -1000, Tejun Heo wrote:
> > BPF schedulers might not want to schedule certain tasks - e.g. kernel
> > threads. This patch adds p->scx.disallow which can be set by BPF schedulers
> > in such cases. The field can be changed anytime and setting it in
> > ops.prep_enable() guarantees that the task can never be scheduled by
> > sched_ext.
> 
> Why ?!?!
> 
> By leaving kernel threads fair, and fair sitting above the BPF thing,
> it is not dissimilar to promoting them to FIFO. They will instantly
> preempt the BPF thing and keep running for as long as they need. The
> only real difference between this and actual FIFO is the behaviour on
> contention.

Yes, from sched_ext's POV, in partial mode, CFS isn't all that different
from FIFO. Whenever there are tasks to run in CFS, CPUs are taken away.
Right now, partial mode can be useful for leaving a part of system on CFS
(e.g. in a cpuset partitioned system), when the scheduler is narrowly
focused and doesn't cover everything necessary (e.g. EAS).

> This seems like a very bad thing to have, and your 'changelog' has no
> justification what so ever.

This is a bit of duplicate interface in that in partial mode sched_ext can
already be opted in by setting per-thread sched class. However, some use
cases wanted this so that the BPF scheduler has the final say over who can
be on it rather than the userspace. It's a convenience feature for some use
cases.

Thanks.

-- 
tejun

