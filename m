Return-Path: <bpf+bounces-50795-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4E1A2C9D9
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 18:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 915A43AC284
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 17:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB3B1922FD;
	Fri,  7 Feb 2025 17:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYvxN0aL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2AE18E03A;
	Fri,  7 Feb 2025 17:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738948079; cv=none; b=lA1//EOD7+pdrhw10qkVIXrzEZYdGESnIiIz2Sd00AGjCVrp/bpIleW9CxHdwCLR6EJ3Pm126GNErFCZi9Hh/jdVd8EVEpyW8yHurNCBH8GOTbLd/bWOh3xRirBHrGy8qLYhb1eyOOPuxhOU7YCFLSTjlMP5pyLGKS84IKWDbtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738948079; c=relaxed/simple;
	bh=t/4S+8J9MTTxJwCzhekj7YPInfQFs+BdYGFjT9aqJdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKt/FPwOIMd49AsdNd845/pzTXp03kE4Tp2VuA62zVYRyEyftq7hbyG7bimVct9JcHdXEmjjMawSnmjClf5yjS5v8MBk0rOweadTEAspCGS3XuFI4qb/DUOCbB5EXfEU3iNXu4N3V3DluJT84q0kckGbUViac7hqiVtyn8m23d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VYvxN0aL; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21670dce0a7so55957255ad.1;
        Fri, 07 Feb 2025 09:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738948078; x=1739552878; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=08MQI/7p2pWywhil/+KkdjVWbJLo6VeasSWtMWNWJO0=;
        b=VYvxN0aL0hs52ANPu0ADEGERhMq0sfehW7xKsT+ybuh1eLLhceBHEMW6/XfeV9m7nI
         O1TyEvGPkv3BlfKWtmLfagyvJ+namFjsTQM9IS0svgUaVDbSv7UMHZzkUVVLZCOcAbGg
         gJ5wIQcmlR4yUioiP/mQQw+iXbFzIdPtbG94SQLdSvUpUC+0WZ/EmtdAymBZ5n80lrjb
         67bYPchocAd6UUibBZDR14WlkxvmG9QrI6P49Zc1O4rsQyukrtcLl9FyQlrglwZYum4q
         NeWlJophZLOCCJMxxr5QrgbauharHVxAB+zTpaoQ1qZxhXoqSiCP7ai3rBbmUxzpq7WC
         vkhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738948078; x=1739552878;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=08MQI/7p2pWywhil/+KkdjVWbJLo6VeasSWtMWNWJO0=;
        b=pmTh08zgQSPoamb8ZjRmHfCUuG8SIC9+a9FmR4OdxhnabG91upsarxmGFrNyIIk36l
         wPKiRRWB1mu33Tr6eFGpDHb5AhrcOHFTppz1xKEaL+aeorGWH4abb3NjOsWh1kFCoMAt
         RO/Uv+iMF8NLcfxQKo+FP6kehF0xmzow4BVzaSp5yM34jYDF/lIUKkzLriGrZ4fUoJMC
         4Sqnowx6PKCj09Ej+NJYosV5bGqJ1QUsaikVyPlX8ruYuuUgP7eAkItIWIiPKomz0hSm
         iJKjXTTRkffoGWF0Jqc6q4Ey/G1lXjXRCo2MmRG9wtpHd6NA0bpsbKm5ONGww9kRRae4
         J5Qg==
X-Forwarded-Encrypted: i=1; AJvYcCVJZGh8h5HewmTN39fiMpgiKNPi4unGK1pD+ovjvPAjHDCBZBdGL6gVJlx1j4eN9pG+PStyzArp2px+e33w@vger.kernel.org, AJvYcCVqFaxiKdOHC+pS+i/WX3Wb1JEUTIZxb7RDFnj/E6Y04O3f8Pe1UJ0u2lr7UCvrATDE0NU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHLCjkhbUTcwd0dVUJsga8rGMaCAJZS3o9/gBejL/Sjdyln588
	lfMwHeQmDo9M7Iodyg4DPCHhaWRwz9659DDZsPlDHV0MT/QMPKk+Owzvfi2m
X-Gm-Gg: ASbGncsKNynEJrhEK7Ua5LMDTjQn7zDGvKVxA9dia+Ikqa78L1bLE+BT/X8su+jwU6q
	nDrSTblvvaZYXR7pZcjXVAh4nn5I+8YFb9YMELcMk2yaIiEYHALIBhz9kNWbymE9fTBVwzCEc5j
	FTNrnZPKNzIMVhQq/ipISgNRJdkDAFpk6KTM7MAS0F8bKcgUSfVu4pmQyQ0U2lBxabRsAuEeg9o
	pWnk0J0cVPRZsxE2I4A3xYn9VhvrRG+Ih8wPl7VXgnKBC3qM5Sa2Oi/BgUBZVYNAWCIUhcicXdT
	DlBSkFCkRHN2m7Y=
X-Google-Smtp-Source: AGHT+IGYGVVHtOmDYW+y3pU3zChlJ9nnsgWrN+fXB7nGSg4LTRjucPETC2sDyNkiugpkB1KEHfQ6mA==
X-Received: by 2002:a05:6a20:d490:b0:1e4:80a9:3fb8 with SMTP id adf61e73a8af0-1ee03a3d045mr7540791637.16.1738948077544;
        Fri, 07 Feb 2025 09:07:57 -0800 (PST)
Received: from localhost ([216.228.125.131])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad51aee5bbcsm2846496a12.39.2025.02.07.09.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 09:07:57 -0800 (PST)
Date: Fri, 7 Feb 2025 12:07:55 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Ian May <ianm@nvidia.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] sched/topology: Introduce for_each_numa_node()
 iterator
Message-ID: <Z6Y94mI8o1dFRmYP@thinkpad>
References: <20250206202109.384179-1-arighi@nvidia.com>
 <20250206202109.384179-2-arighi@nvidia.com>
 <Z6WEllH4yvzkWCYG@thinkpad>
 <Z6YqRw_DJ-Czply8@gpd3>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6YqRw_DJ-Czply8@gpd3>

On Fri, Feb 07, 2025 at 04:44:07PM +0100, Andrea Righi wrote:
> Hi Yury,
> 
> On Thu, Feb 06, 2025 at 10:57:19PM -0500, Yury Norov wrote:
> > On Thu, Feb 06, 2025 at 09:15:31PM +0100, Andrea Righi wrote:
> ...
> > > @@ -261,6 +267,29 @@ sched_numa_hop_mask(unsigned int node, unsigned int hops)
> > >  }
> > >  #endif	/* CONFIG_NUMA */
> > >  
> > > +/**
> > > + * for_each_numa_node - iterate over NUMA nodes at increasing hop distances
> > > + *                      from a given starting node.
> > > + * @node: the iteration variable, representing the current NUMA node.
> > > + * @start: the NUMA node to start the iteration from.
> > > + * @visited: a nodemask_t to track the visited nodes.
> > 
> > nit: s/nodemask_t/nodemask
> 
> The type is actually nodemask_t, do you think it's better to mention
> nodemask instead?

We just don't put types in variables descriptions. Refer the comment
on top of memcpy():

 /**
  * memcpy - Copy one area of memory to another
  * @dest: Where to copy to
  * @src: Where to copy from
  * @count: The size of the area.
  *
  * You should not use this function to access IO space, use memcpy_toio()
  * or memcpy_fromio() instead.
  */
 void *memcpy(void *dest, const void *src, size_t count)

We don't say like
  * @count: The size_t of the area.

Right?
 
> > int numa_nearest_nodemask(int node, const nodemask_t *mask);
> > #define for_each_numa_node(node, unvisited)			                      \
> > 	for (int start = (node), n = numa_nearest_nodemask(start, &(unvisited));    \
> > 	     n < MAX_NUMNODES;					                      \
> >              node_clear(n, (visited)), n = numa_nearest_nodemask(start, &(visited)))
> 
> I like the numa_nearest_nodemask() idea, I'll do some experiemnts with it.

Yeah, this one looks like the most generic API I can figure out, and
still it fits your needs just as well.

Please in the comment refer that the 'unvisited' will be touched by
the macro.

