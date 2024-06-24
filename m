Return-Path: <bpf+bounces-32948-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7355C9158B2
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 23:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29726284FBF
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 21:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3851A0707;
	Mon, 24 Jun 2024 21:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SALN9ePl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A164C8F6B;
	Mon, 24 Jun 2024 21:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719263890; cv=none; b=pBWt4tmf0CGLeZbWYBL/kzCH8p2lKj23HyJGj5ju7aBFvW0T/8Xj4LDgZ3G6hBbahriAF9tLx3VYQT1NLh3iZMgYMHV3Domg+E3rO4B4eWagk7Na1wjm/pL8qJwtyAPogVVTVf9x2av5ZC0RT0lt3MS8crLRx1q48MEeoO/Dt0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719263890; c=relaxed/simple;
	bh=l8Zv6zTZkrFFWNVvlwnKFMv5uzpJV0PDxOetpCVnLgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iqZVh0JYZdqbBFzlc1bqRI1yNrlCuNG65vbuFyxmqmiW4VcoEHrgJnQKF0qMwGY+Bam/UBg6kZCcAlH5j/ZRjyci2Oq5uPYj71XulejZLCzbZmF7FmYpkfWK1WIMZjhOMVc8WbMjKSMhLyCtkIxRU7wZxjYYYvJFAhSqISX+/RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SALN9ePl; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f47f07aceaso37717245ad.0;
        Mon, 24 Jun 2024 14:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719263888; x=1719868688; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XOg8+lXJdsURB0vv97T/giYlSsMyAfF7fszjN+D+tlo=;
        b=SALN9ePl1kznUY6pNCKZ0Qor4wjnB/b3rL3XjdxtOFKG8napi1B2Bslw6xMbHojV+4
         A/J+m40590MTlQAV/sqHo+HtLgKabsH+tLq+pcR6bLs5oUeQHoh+GzCcXTbqgVT1eJ3A
         yyu1FG6ThIMbOP4sQNBmnBXObfZTb/8Cjt7ZXl/nInKf6b2Ble20R5n1bZJrNKMAf1ll
         z/7DF09JKZ1wQJ0RQ9zDgubNcY+/01dUVD7BBlz5lE5e/tNV19r/WeZ8DZDrPGr87Qrw
         6878BGfzzp9S5d4tm2hIXNlDpArFjOfCNweSn8lcxPBmz5yz11eJD+F5mgm3pynksj0k
         eK1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719263888; x=1719868688;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XOg8+lXJdsURB0vv97T/giYlSsMyAfF7fszjN+D+tlo=;
        b=kVKtoGuQRkOiouEAxL2dcyWdJ27cXPkPoE5z975zKFAu1nzYvuScNVZm6CkvWe9qfD
         yzRD3dvdGyklPsKmuqJWleSv9tyo9eCYW4PwsLdAw8/EFZjvl+6vbx9zOECwA7sfS2wA
         VyaTGaIslZd3KK4HWNwFthwRHMA/GCItSa4fMm7K1DWmMGPJdJ+nZN0UqFHHPa/BjuKR
         P3g7tDjF1C5n0gW9uunc6jMxDohQcIuElydxAiyCSBAgF34Buf9ft+Z9U5vfyVFn8BAk
         /z81K4VANOuwsopJPUBXO9aa1lrgkAAlkRtsmoUWBYh3Rgk2/FLFIJOGOStpIpYY8uTc
         gNdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXft2nMgiJ27bmyBC/oeKos7frhYLQyrtusT2q1RkFm7i9v6vR/Zyl02EZVX//+KGscmpGRlQ8SIGI9/jCi56KO9CQLNOVEq3BCROKmkVANFR/c0vjH1R0EunedggRFsasn
X-Gm-Message-State: AOJu0YykVjB7CyXr6h1oUi9xB82e7mraQ2l8qRr9eYsCUw248bbrHaYd
	2MFLIvh3ALIrJPULBLLKBiUNq7/Z5JR4k8uimp5sTa84ML2SHkDG
X-Google-Smtp-Source: AGHT+IHWmimvJ7K6ZtF/mv7MnJM5fetCwbtgJhLSAAJVi4lplWlvxGL5tFr+cHILNGkCYyOUoRuRTw==
X-Received: by 2002:a17:902:f611:b0:1f6:89b1:a419 with SMTP id d9443c01a7336-1fa158de8e8mr62866925ad.17.1719263887840;
        Mon, 24 Jun 2024 14:18:07 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9ebbc3185sm66912095ad.289.2024.06.24.14.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 14:18:07 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 24 Jun 2024 11:18:06 -1000
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
Message-ID: <ZnnijsMAQYgCnrZF@slm.duckdns.org>
References: <20240501151312.635565-1-tj@kernel.org>
 <20240501151312.635565-10-tj@kernel.org>
 <20240624113212.GL31592@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624113212.GL31592@noisy.programming.kicks-ass.net>

Hello, Peter.

On Mon, Jun 24, 2024 at 01:32:12PM +0200, Peter Zijlstra wrote:
> On Wed, May 01, 2024 at 05:09:44AM -1000, Tejun Heo wrote:
> > ->rq_{on|off}line are called either during CPU hotplug or cpuset partition
> > updates. A planned BPF extensible sched_class wants to tell the BPF
> > scheduler progs about CPU hotplug events in a way that's synchronized with
> > rq state changes.
> > 
> > As the BPF scheduler progs aren't necessarily affected by cpuset partition
> > updates, we need a way to distinguish the two types of events. Let's add an
> > argument to tell them apart.
> 
> That would be a bug. Must not be able to ignore partitions.

So, first of all, this implementation was brittle in assuming CPU hotplug
events would be called in first and broke after recent cpuset changes. In
v7, it's replaced by hooks in sched_cpu_[de]activate(), which has the extra
benefit of allowing the BPF hotplug methods to be sleepable.

Taking a step back to the sched domains. They don't translate well to
sched_ext schedulers where task to CPU associations are often more dynamic
(e.g. multiple CPUs sharing a task queue) and load balancing operations can
be implemented pretty differently from CFS. The benefits of exposing sched
domains directly to the BPF schedulers is unclear as most of relevant
information can be obtained from userspace already.

The cgroup support side isn't fully developed yet (e.g. cpu.weight is
available but I haven't added cpu.max yet) and plans can always change but I
was thinking taking a similar approach as cpu.weight for cpuset's isolation
features - ie. give the BPF scheduler a way to access the user's
configuration and let it implement whatever it wants to implement.

Thanks.

-- 
tejun

