Return-Path: <bpf+bounces-33194-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A73D91996D
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 22:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4BE9B22E6D
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 20:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8FB19048C;
	Wed, 26 Jun 2024 20:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0sMRRia"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4021F1E886;
	Wed, 26 Jun 2024 20:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719434966; cv=none; b=Iuwyt+1gL4qhHBc7dsywa4oivuRqpvWCgZrmfkMgLeL7HEvL79NV3PDzSN/o2oI1ZeTPduJK2LKXEMLqFeOE+oeQ4gYOvshxIIQicEmwEy+64+Eqx/58S6x/GQDdL9eAt3I1n+/swieAMX9z4cp5GV/aw+l4YduB030rFoP+WwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719434966; c=relaxed/simple;
	bh=3WzvJv9ZJkJhv/LzaHbkS2KIXRgUhh11sk+s5zEP75k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhqJ24aLayaEUzuS9WD1xm2YtGTc/8LnC6fcCo+YWlWJDO/dVa6KYXFjqq2UJVi94trOTrdjFJgsmRJBDTdPm1Hu3VXbHAnNG8W7VDLGeJpIs0jZWIeR0iO2MBd2CydxsPM1id1W5zmSN7NtrZKSSq0yWJqnhwo/GR6taX6rYOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0sMRRia; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f9c6e59d34so59239345ad.2;
        Wed, 26 Jun 2024 13:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719434964; x=1720039764; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vlFUvIoHCM6Q2GQfm9jFsLthDN9alT+0NRitEVH5/1s=;
        b=l0sMRRiaD2+VpeuqT+ReO3FplKMBtduyhfGPXUJd+gJMXOC5feIHvWt293A6nyYpMq
         +fm7P2JuDRrnxzG0nOqg2XYG+AhvVkDFiPPC70EtLQsTOi4hZ7pDFFUxfKiIqCOLe/+X
         IXtpvY7ontWSPyv2+0Lb+t7hft7vO/6vItOXvYrZhDUtmGwJTo0rnJAm8N6DvJAkCH23
         XAxFdaJfl23y8BW4c6sqlZ0Fklp3JX25QGMTB59H/NDZxsb0OaXGJw6hSxeWgOwpthFp
         RXMyJKfR6kxanvfyhsu8V+01ZWSnCKPxDDY21/6IKbWklTmz2vk7TEub19/SWFjhz8mV
         yraA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719434964; x=1720039764;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vlFUvIoHCM6Q2GQfm9jFsLthDN9alT+0NRitEVH5/1s=;
        b=qD90Ie1dqTHLqJPYkAUjcVA0j+Pp/IM1xwsFAg+oIml9iLpljdlCltfxyNrpsEfVgR
         j4Wp389Ro4CrYOz70OfomMuo3eCbJn+TLuPSgEgMIYp5RAJLmgT5xMABDwIEhq8BVOZP
         l+mk/VqKcr4XhwiCbjcxIIMWGn8Nljf5dZLN2F+s1PFj4HVEEb9HeG+ZXKPL59NWEB9a
         5yoWlYAVEF6i3Bri313Sdk9J6SFbRVk4PdGJF1PgdhvSQAqs76YANfy950xvmFiBuBb4
         h5sFIu/YKxPpNxLc7BSNXzOuLqKsnse+QMdVmCeH4Ei5ivFOuvyIOz7PxumeoInyG14G
         7Z+w==
X-Forwarded-Encrypted: i=1; AJvYcCWdg2nwebCqdQTdm7BVmiPGah0LpY1QretmSrG9akxDS41PlmUFbpI9Ldt759VzJmx54d3XilpgpctgRyHFpL6c2It/5ehdxyMSlsqzb+iNiGmorK+f6q2lG4aFzeaGy2g4
X-Gm-Message-State: AOJu0YztILW38z5OARyO2hrjwOhnD3xRDN5diUC4PYEuWN+MxbOiAlMa
	WRV4nH5YC0DK2W8KhekWm8IN1nkfMpF5y87AC5IvuMsqsjxR3L4h
X-Google-Smtp-Source: AGHT+IGfyMrMPf/R3KOxyyDDYSUkC+WVZ2qJXfm+7+KjI++uLivtkfVCcQevm374x/kl8NBMVXKe1Q==
X-Received: by 2002:a17:903:18d:b0:1f9:b4eb:ce4a with SMTP id d9443c01a7336-1fa1d51c2b4mr164435775ad.23.1719434964334;
        Wed, 26 Jun 2024 13:49:24 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb320917sm103970405ad.75.2024.06.26.13.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 13:49:23 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 26 Jun 2024 10:49:22 -1000
From: Tejun Heo <tj@kernel.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, torvalds@linux-foundation.org,
	mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
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
Subject: Re: [PATCH 10/39] sched: Factor out update_other_load_avgs() from
 __update_blocked_others()
Message-ID: <Znx-0ksd-Be3YC1C@slm.duckdns.org>
References: <20240501151312.635565-1-tj@kernel.org>
 <20240501151312.635565-11-tj@kernel.org>
 <20240624123529.GM31592@noisy.programming.kicks-ass.net>
 <CAKfTPtD-YHaLUKdApu=9AhKAdg5z7Bp-3089DcdA7NL2Y5pxiA@mail.gmail.com>
 <ZnnIACPPrnUxP1Mw@slm.duckdns.org>
 <CAKfTPtB2AbXryzQ+NvPKJML7pbKh8MeW6gmNwLK04b=Wd+SMtw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtB2AbXryzQ+NvPKJML7pbKh8MeW6gmNwLK04b=Wd+SMtw@mail.gmail.com>

Hello,

On Tue, Jun 25, 2024 at 11:13:54AM +0200, Vincent Guittot wrote:
> > Hmm.... I think I saw RT's schedutil signal stuck high constantly pushing up
> > the frequency. I might be mistaken tho. I'll check again.
> 
> This is used when selecting a frequency for fair tasks

When schedutil is used as the governor, sugov_get_util() provides the source
utilization information to determine the target frequency. sugov_get_util()
gets the CFS util metric from cpu_util_cfs_boost() and then runs it through
effective_cpu_util().

effective_cpu_util() does a bunch of things including adding cpu_util_irq(),
cpu_util_rt() and cpu_util_dl(), so if SCX doesn't decay these utilization
metrics, they never decay and schedutil ends up making decisions with stale
stuck-high numbers. I can easily confirm the behavior by sprinkling some
trace_printks and commenting out update_other_load_avgs() on the SCX side.

Thanks.

-- 
tejun

