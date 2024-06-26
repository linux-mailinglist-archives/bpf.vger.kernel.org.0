Return-Path: <bpf+bounces-33182-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8178918DD1
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 20:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DC7D288AAF
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 18:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5757D19046A;
	Wed, 26 Jun 2024 18:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bb0Am2uZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8926218A93E;
	Wed, 26 Jun 2024 18:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719424895; cv=none; b=lfePISk13WMy94F5ac2MC5IYYODISCNKi6d0Dxfmt26XIjGlRCGTtNIJJCQUV3UNjhGQanvswgp8/mrapt6v0bRUbuaJm/AuKcHDI9ncfBZq2sHsiqxqnO71mBNrAjTCCpgdTbZKdOI5ys0OadstJf7fGcstK+krtapSKlKpYAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719424895; c=relaxed/simple;
	bh=VH9eTlbey4YEknBPwZDg/V86C5yDehMvjvBBOP4nxvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQ86AFHtvYM+4qU97H0s6fRGu2JYElgWlDU5jE40V4Q9KLUWpEFIQ5hT9kx8wWevPHfFdD/AbYS5BmPEbK8ICZm94gsg693d9gJBzg7K7X5UdVlcPCRRZlj4qztj0WSnUZXhs6oz/Qi5E1ICGR2Wy4bUfSTgT+xa82OEQT1xt28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bb0Am2uZ; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7041053c0fdso4178878b3a.3;
        Wed, 26 Jun 2024 11:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719424894; x=1720029694; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f35yjTzW3qs/RVmB7ro2MWDbHt/eSZTbqia8JUbmZI4=;
        b=bb0Am2uZNxUio4G4hvPfBPxTgXcAxctcDTM2XxVKuOBnH+/W7q6oKF5l+LYSHtJk6w
         nUzUq/VilWs+qoIbFsCdvw18duG0etNL2BzkW0txisawDo4vEDzVwAmvlxXsK7kWo2fz
         zv7giEycHr0i+Wah63xju9zJPvYRehkDif12Gw98iyIOkxI/4SJKA17GC7qQM95N/TeW
         elJf8eekBA/VQ92yG2K0+73sLBoDM23xssdATNdE3I/wLlzeUbiavNXZADWdolPJfb6F
         RdoCKm5vGAkLAwPsPwYdYDoJRxj+ai6t0BbYkwq0qhhIlXRhHisPUKfQNvXMOBc2lB1D
         4t2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719424894; x=1720029694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f35yjTzW3qs/RVmB7ro2MWDbHt/eSZTbqia8JUbmZI4=;
        b=tS82fwt4Q3zbpBoECZCGaJzpSgPHCgpb3Pxwd5RVIM10/m+cIPDqwYfH014bV6ruP/
         WeNcrrtjdKPsPb/phBbxFnCBDwtLF8rXdHyz/byixFWhTDyhL/GmGBRmqIgD50jSquC5
         y2iWeN0spnlYxejUweJ4aJIyYO5zGlQW96TlrJGwkXTmlg6WOEv4J2SksMKSsOmNxzwe
         G9hUJ9NAlD/qf7ziyZnF7ifY1Z9gEKIHzwWr6XAMTEJGgL4k8Pkw/phrP34jK6zEJsmc
         BsXeWwVYNYIrJVBDFVdSX4QI3chuMRVM9lleUM48Joe0A4djzSz0wk6JlqcPiA1xZvfY
         WT0Q==
X-Forwarded-Encrypted: i=1; AJvYcCW5MUQ2b7t3ogx7OREM1oDOt7qwjFWj6dVFRfhJur/F8Zre+2hLxeycWnXE/Asy6zOaTtNNigXItqT74GXYsvsZpbidp8sFMqMapwyNlchYQ1XnY/vWTfTGrv38MNJVxPzA
X-Gm-Message-State: AOJu0Ywi4HsT6GNr5uvIB5HKYjSryXD1aLfPKOLzi3EMzuVXHs9HEgZc
	5wXqwptvY/Qh99fWmZnYuQyoMcihWWoZAtteCVGYVYot3+Q+PYus
X-Google-Smtp-Source: AGHT+IFLyjjoTP1GIASZ81awOilBOorYy6Hhb0RvvL/scejGbcauCj0fjkfpTYUVlylNF7av/eBnTw==
X-Received: by 2002:a05:6a00:928b:b0:706:82d7:9394 with SMTP id d2e1a72fcca58-70682d79858mr10611541b3a.34.1719424893723;
        Wed, 26 Jun 2024 11:01:33 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706a0af2278sm2672027b3a.170.2024.06.26.11.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 11:01:33 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 26 Jun 2024 08:01:30 -1000
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
Subject: Re: [PATCH 09/39] sched: Add @reason to
 sched_class->rq_{on|off}line()
Message-ID: <ZnxXej8h46lmzrAP@slm.duckdns.org>
References: <20240501151312.635565-1-tj@kernel.org>
 <20240501151312.635565-10-tj@kernel.org>
 <20240624113212.GL31592@noisy.programming.kicks-ass.net>
 <ZnnijsMAQYgCnrZF@slm.duckdns.org>
 <20240625082926.GT31592@noisy.programming.kicks-ass.net>
 <ZntVjZ3a2k5IGbzE@slm.duckdns.org>
 <20240626082342.GY31592@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626082342.GY31592@noisy.programming.kicks-ass.net>

Hello,

On Wed, Jun 26, 2024 at 10:23:42AM +0200, Peter Zijlstra wrote:
...
>  - cpuset
>  - cpuset-v2
>  - isolcpus boot crap
> 
> And they're all subtly different iirc, but IIRC the cpuset ones are
> simplest since the task is part of a cgroup and the cgroup cpumask is
> imposed on them and things should be fairly straight forward.
> 
> The isolcpus thing creates a pile of single CPU partitions and people
> have to manually set cpu-affinity, and here we have some hysterical
> behaviour that I would love to change but have not yet dared do --
> because I know there's people doing dodgy things because they've been
> sending 'bug' reports.
> 
> Specifically it is possible to set a cpumask that spans multiple
> partitions :-( Traditionally the behaviour was that it would place the
> task on the lowest cpu number, the current behaviour is the task it
> placed randomly on any CPU in the given mask.

This is what I was missing. I was just thinking cpuset case and as cpuset
partitions are always reflected in the task cpumasks, there isn't whole lot
to do.

...
> > While it would
> > make sense to communicate partitions to the BPF scheduler, would it make
> > sense to reject BPF scheduler based on it? ie. Assuming that the feature is
> > implemented, what would distinguish between one BPF scheduler which handles
> > partitions specially and the other which doesn't care?
> 
> Correctness? Anyway, can't you handle this in the kernel part, simply
> never allow a shared runqueue to cross a root_domain's mask and put some
> WARNs on to ensure constraints are respected etc.? Should be fairly
> simple to check prev_cpu and new_cpu are having the same root_domain for
> instance.

Yeah, I'll plug it. It might as well be just reject and ejecting BPF
schedulers when conditions are detected. The BPF scheduler doesn't have to
use the built-in DSQs and can decide to dispatch to any CPU from its BPF
queues (however that may be implemented, it can also be in userspace), so
it's a bit tricky to enforce correctness dynamically after the fact. I'll
think more on it.

Thanks.

-- 
tejun

