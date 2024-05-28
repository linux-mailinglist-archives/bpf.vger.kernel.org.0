Return-Path: <bpf+bounces-30806-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 665CB8D28D8
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 01:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE34BB23036
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 23:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77E113E043;
	Tue, 28 May 2024 23:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RB+thYHk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED4422089;
	Tue, 28 May 2024 23:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716939980; cv=none; b=O43dxqFS6gnVWl9hqd8MKeo4HK2vvlgXkzzAicpnT6b4Yn1A2wIsqwx5+/C4lp7A6DI/7/ND5Rozf3azQbeerchI0TkevVwu+z2QyfMIMDTCFIJLdA1Dxm0asYQd4M3MkFXga1HXe/guhNgdQeyzh0odvtumy5rSV3uuzj/vqE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716939980; c=relaxed/simple;
	bh=YLqkXKeVVXIKaRanTO4nqmtbsAC4ZBl7oQ9qvXWYfpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nYPbfqqXa4vK8I8Nx469n2yYfxPPvrbtb2K4Yk2MfiNwIKjwrVni2a5gU2tOmBvTktMuVDItw3IJvM5dTayqONtR2BZGGpZU7ryYQfNXcnHJM6n7o9swsgYrbjH8eVR6/PXNfyi/zTbpWje2xeRcGBCG46reCAg7xiwT/tCfhkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RB+thYHk; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6f8eaa14512so1160948b3a.3;
        Tue, 28 May 2024 16:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716939978; x=1717544778; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6rGifC2Ni1u+HmrCMWiv1iMCtdV6Wvnc9UrGi2Lwz2U=;
        b=RB+thYHku6Qa40JpgoUq8h+k99G+ULWZ3vBGw3Gosse1Wsrp+MmVHnhh1LcF0Bc0ah
         46FxOvVKNPRLoHziMnIvBZdxu1rcsSbf5BM7BgakIz2vDXwYZYNKt4GBD6XqjO5pkMyl
         BgplIHCfsCA25vMj9/ks1ny2F17HPSu6sW6TJjxbSDW6DZHSuiu4KlkYDc+KFgbGkhoO
         hjcfKgNtahy/Aa/ec83Ml7F7FYStI0nBtHI9xirxrGDGi72+KdsD/nj85XfO1aLgapYj
         GCEBVunUxMgC1kEJG84UbvQgLK1hAQyysqmJEwg7RdEy7DcoyLIu5vNTn4VWedi4xck5
         QODg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716939978; x=1717544778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rGifC2Ni1u+HmrCMWiv1iMCtdV6Wvnc9UrGi2Lwz2U=;
        b=biIyb93kTSmSbgXQXE8rY7aMZionfXI8vA0n+7GySoy26lyz0I6nrKjLLT8TSeauLJ
         +QsyABQv8m/FaBkOIAwpMN181GxYjpjbVu5taZ9bI0OSjJrcN/B5Lbk+05xiajLW8l6s
         95FRCagHax0Z5bZuVDWv2+3bpysz0FhqRnvGgyTpArvHItJV97lL6wVB9/9eYMiPPGTC
         iEcxTTHW7VfIkbTGM0beSQd2+xmRPHos2b0DhWQWK3it1hyLUoxBP1kqfb1/hB3jySnS
         IWHuDn/B491SV29NOxqIUoMikRVLf/o8hSkrhU5gAg/L8fwLUD3sJUHjOiMYle/EBfUK
         0meA==
X-Forwarded-Encrypted: i=1; AJvYcCUFfR4PDC7w2Pbk0jY1tnv2ZQKuF8tpAU4hAvXurWrMmf1aL4/7+UOv7TSeVXVEe6vL08IE8Xf7I+JBNVDAS4oeC0kwUfNjYWCu3FvezJLCDzmsXhYXF9c3X2ZVpUyL265J
X-Gm-Message-State: AOJu0Yydb2qHFDt6dqz/qEF+hBkbWPXq+1kkJNC3/bquvzM3DIiJG2Ug
	Si2ZljfJXrpcphR95MQniHdPR4/OJsLbbPiqHvS8a9vKYH/jz0zq
X-Google-Smtp-Source: AGHT+IGzHwXatJazufht+aUX1oiyytAppXaUsbzFl/OP5WP3nWqHHoFPkIdSzo7EHXl7K/yFpxk+xg==
X-Received: by 2002:a05:6a20:f3b0:b0:1b1:f7a1:dfa6 with SMTP id adf61e73a8af0-1b212dfe653mr12291813637.38.1716939977891;
        Tue, 28 May 2024 16:46:17 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-701cdd8fb27sm1591942b3a.7.2024.05.28.16.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 16:46:17 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 28 May 2024 13:46:16 -1000
From: Tejun Heo <tj@kernel.org>
To: Qais Yousef <qyousef@layalina.io>
Cc: David Vernet <void@manifault.com>, Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	torvalds@linux-foundation.org, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
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
Message-ID: <ZlZsyFl79Zk074eK@slm.duckdns.org>
References: <20240501151312.635565-1-tj@kernel.org>
 <20240502084800.GY30852@noisy.programming.kicks-ass.net>
 <ZjPnb1vdt80FrksA@slm.duckdns.org>
 <20240503085232.GC30852@noisy.programming.kicks-ass.net>
 <ZjgWzhruwo8euPC0@slm.duckdns.org>
 <20240513080359.GI30852@noisy.programming.kicks-ass.net>
 <20240513142646.4dc5484d@rorschach.local.home>
 <20240514000715.4765jfpwi5ovlizj@airbuntu>
 <20240514213402.GB295811@maniforge>
 <20240527212540.u66l3svj3iigj7ig@airbuntu>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527212540.u66l3svj3iigj7ig@airbuntu>

Hello,

BTW, David is off for the week and might be a bit slow to respond. I just
want to comment on one part.

On Mon, May 27, 2024 at 10:25:40PM +0100, Qais Yousef wrote:
...
> And I can only share my experience, I don't think the algorithm itself is the
> bottleneck here. The devil is in the corner cases. And these are hard to deal
> with without explicit hints.

Our perceptions of the scope of the problem space seem very different. To
me, it seems pretty unexplored. Here's just one area: Constantly increasing
number of cores and popularization of more complex cache hierarchies.

Over a hundred CPUs in a system is fairly normal now with a couple layers of
cache hierarchy. Once we have so many, things can look a bit different from
the days when we had a few. Flipping the approach so that we can dynamically
assign close-by CPUs to related groups of threads becomes attractive.

e.g. If you have a bunch of services which aren't latency critical but are
needed to maintain system integrity (updates, monitoring, security and so
on), soft-affining them to a number of CPUs while allowing some CPU headroom
can give you noticeable gain both in performance (partly from cleaner
caches) and power consumption while not adding that much to latency. This is
something the scheduler can and, I believe, should do transparently.

It's not obvious how to do it though. It doesn't quite fit the current LB
model. cgroup hierarchy seems to provide some hints on how threads can be
grouped but the boundaries might not match that well. Even if we figure out
how to define these groups, figuring out group-vs-group competition isn't
trivial (naive load-sums don't work when comparing across groups spanning
multiple CPUs).

Also, what about the threads with oddball cpumasks? Should we begin to treat
CPUs more like other resources, e.g., memory? We don't generally allow
applications to specify which specific physical pages they get because that
doesn't buy anything while adding a lot of constraints. If we have dozens
and hundreds of CPUs, are there fundamental reason to view them differently
from other resources which are treated fungible?

The claim that the current scheduler has the fundamentals all figured out
and it's mostly about handling edge cases and educating users seems wildly
off mark to me.

Maybe we can develop all that in the current framework in a gradual fashion,
but when the problem space is so wide open, that is not a good approach to
take. The cost of constricting is likely significantly higher than the
benefits of having a single code base. Imagine having to develop all the
features of btrfs in the ext2 code base. It's probably doable, at least
theoretically, but that would have been massively stifling, maybe to the
point of most of it not happening.

To the above particular problem of soft-affinity, scx_layered has something
really simple and dumb implemented and we're testing and deploying it in the
fleet with noticeable perf gains, and there are early efforts to see whether
we can automatically figure out grouping based on the cgroup hierarchy and
possibly minimal xattr hints on them.

I don't yet know what generic form soft-affinity should take eventually,
but, with sched_ext, we have a way to try out different ideas in production
and iterate on them learning each step of the way. Given how generic both
the problem and benefits from solving it are, we'll have to reach some
generic solution at one point. Maybe it will come from sched_ext or maybe it
will come from people working on fair like yourself. Either way, sched_ext
is already showing us what can be achieved and prodding people towards
solving it.

Thanks.

-- 
tejun

