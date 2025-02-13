Return-Path: <bpf+bounces-51454-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E42A34B82
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 18:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CF29188BF75
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 17:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C422040AF;
	Thu, 13 Feb 2025 17:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VzehUgkB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232E62036FF;
	Thu, 13 Feb 2025 17:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739466770; cv=none; b=VV0GXgUpSLBNis5BgydlLG3DHdPv8k8uP1gVeK6d6YS4FJTgtgO+MkD73qP+W7ksfA9rOJIN877141ZSSG7Mx+cb/3fbtb2Gz6tdfAsQj4g4G/BJLlJ2MXVvOJpbBXCyA3s+D35zcV1Ch/98Kkco0sTWjtXF6ugHW2zAcaGcGD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739466770; c=relaxed/simple;
	bh=oQMmCG0JieQzCQ+uaUeMIEGH/gb3IkxyxXVusVVC6Nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cREBLs+Kde6OYMIdZZB0PxatsfPVfPZ2dPdT3EM71+wC/pZDJDFZBB1CNpPW8sfd9vVkyb9cdSbxX/WRtKFNe2Sl6dhJO2DnJvJhI4Qvjfn5FdfL2qFL4uUHlS1vDWKpFEyCv7rD5XfQtOCkV9hQkqpzuMftBa3XibgoepHa+TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VzehUgkB; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e4930eca0d4so878705276.3;
        Thu, 13 Feb 2025 09:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739466768; x=1740071568; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7dBt47IiYkZ7hZiYejiIVfiEiNYrSx0WKx8EGdt/DhI=;
        b=VzehUgkBcfxBmjE8NKPU3xrr2Vu+djrmMnhXaBbJ1oaaWPwjbcEgJQ5W9OioXErlnP
         1nncvRkYJjkRxtVmdboM9JNhhdPVWteviKWsUuU67WKuslH7D2GivUk7N5X/0Tywjt35
         +4LfrudSjvsFQ+6sJQ4RpCde85xhMJjKetixJSFcczHkIf0Apb2y7u4/6BUsR4UaN+6a
         Snms2YAtdZHih7k4t9kg+ChiVtC8fZ5jFInO102oSHyb1cAWPTiLaca/P+Ajb6h3d98c
         iTD04l1uWkESIcWs9kHJfdY41krfIdV6UqDTgCTtVNMZOi6gd1HDV7cCwV1LaJmqjPUj
         SAOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739466768; x=1740071568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7dBt47IiYkZ7hZiYejiIVfiEiNYrSx0WKx8EGdt/DhI=;
        b=M547sZpGrUmgWBELr6D23LFF+ZLDRvVKegVw08wBa2RTsi7akRK/0KFuS3yOy/sqvz
         AK3tE1snJRjUSTl2AtqHrlgR84ZOnYpGfxMzsUCbGYWD2jugpFxBWd01400En6zshOdh
         oR4q10T16NyDyTMxJzk2MFnYpXnzJbcX66Qa2KUfSCBEmNGv3z/OADYIR9rArN7ZiNcY
         aekp09eJrbEU5AhqWMtZWiuX391k28WlXnOjebnvBEoTQv7P/tZvRiA0TUf71BbgtvvO
         NSXBYpww4P18X9L1bjJcIJkdrK8oXW/e7DRN5TCsSG/uiliWiANlEmENaTkMWdoBPt4p
         pjTw==
X-Forwarded-Encrypted: i=1; AJvYcCWYRiRh9xM5YSnTG5FURRbBcE8mCmcA+tNX9BKzcQEvsbpXkzNYJ6NtihzUbPm0++5wpEu9xtkzTFREAtJt@vger.kernel.org, AJvYcCWtOraG6Yh1YzSs1QmbltkZBD4dZix9tuyRLwbdVQv21IUhAhKHjeDK2qP6XsZNdNtiFbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVQeMDxsu/yhNxFejYW5dCNWCdl1VC+ZaAg+raHFB/1FaKlOFC
	IKo4tTe88f8bGF0n4iYTlShCAXPVE6AW3PO8gWCMX23ljkF7/vuzQxc0t9hC
X-Gm-Gg: ASbGnct7XCuEyXMvWsHyVkY89nWDwcopHi0YexBPGONqUdZFeIfYHwduJKenR8/ZvtC
	oCNBp7yXuDLWHvE7FzWDujQpleA3mR94RHF3K39VQgp7O2BGzUTxo4TtE2MzBuPye0sMQJvLy5Z
	n9LXEKZ7k6URyNJsDouH2RgDE7/+gVjEPZWJZui0zkZCgObizChEQTiIlwFe1ifUeh/rPGLspPl
	VnEDRq/VhvVB3YCDeQlIgP2PfqhsfNMmxym1QSOvqRVxdhj6a8NgMd5mLO+dylJwNs+kw0a0eiv
	YO4Vt/i1hEcrG75Oc02ThjOWYeUy293v6ufYyeuhYaVUGzK4abU=
X-Google-Smtp-Source: AGHT+IFlB4wYC1w6uJ0YF4VXDz2MPTBEfcZ1VKUga6xphN2POd7ENGyQgY7rg62UdFf+Wpsmwy2RBA==
X-Received: by 2002:a05:6902:1442:b0:e5b:42c7:8f21 with SMTP id 3f1490d57ef6-e5d9f0c75aamr7707277276.7.1739466767765;
        Thu, 13 Feb 2025 09:12:47 -0800 (PST)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e5dadeca383sm483134276.29.2025.02.13.09.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 09:12:47 -0800 (PST)
Date: Thu, 13 Feb 2025 12:12:46 -0500
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
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joel@joelfernandes.org>, Ian May <ianm@nvidia.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] mm/numa: Introduce nearest_node_nodemask()
Message-ID: <Z64oDlh9vzvRYziL@thinkpad>
References: <20250212165006.490130-1-arighi@nvidia.com>
 <20250212165006.490130-3-arighi@nvidia.com>
 <Z64WTLPaSxixbE2q@thinkpad>
 <Z64brsSMAR7cLPUU@gpd3>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z64brsSMAR7cLPUU@gpd3>

On Thu, Feb 13, 2025 at 05:19:58PM +0100, Andrea Righi wrote:
> On Thu, Feb 13, 2025 at 10:57:00AM -0500, Yury Norov wrote:
> > On Wed, Feb 12, 2025 at 05:48:09PM +0100, Andrea Righi wrote:
> > > Introduce the new helper nearest_node_nodemask() to find the closest
> > > node in a specified nodemask from a given starting node.
> > > 
> > > Returns MAX_NUMNODES if no node is found.
> > > 
> > > Cc: Yury Norov <yury.norov@gmail.com>
> > > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> > 
> > Suggested-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
> 
> Ok.
> 
> > 
> > > ---
> > >  include/linux/numa.h |  7 +++++++
> > >  mm/mempolicy.c       | 32 ++++++++++++++++++++++++++++++++
> > >  2 files changed, 39 insertions(+)
> > > 
> > > diff --git a/include/linux/numa.h b/include/linux/numa.h
> > > index 31d8bf8a951a7..e6baaf6051bcf 100644
> > > --- a/include/linux/numa.h
> > > +++ b/include/linux/numa.h
> > > @@ -31,6 +31,8 @@ void __init alloc_offline_node_data(int nid);
> > >  /* Generic implementation available */
> > >  int numa_nearest_node(int node, unsigned int state);
> > >  
> > > +int nearest_node_nodemask(int node, nodemask_t *mask);
> > > +
> > 
> > See how you use it. It looks a bit inconsistent to the other functions:
> > 
> >   #define for_each_node_numadist(node, unvisited)                                \
> >          for (int start = (node),                                                \
> >               node = nearest_node_nodemask((start), &(unvisited));               \
> >               node < MAX_NUMNODES;                                               \
> >               node_clear(node, (unvisited)),                                     \
> >               node = nearest_node_nodemask((start), &(unvisited)))
> >   
> > 
> > I would suggest to make it aligned with the rest of the API:
> > 
> >   #define node_clear(node, dst) __node_clear((node), &(dst))
> >   static __always_inline void __node_clear(int node, volatile nodemask_t *dstp)
> >   {
> >           clear_bit(node, dstp->bits);
> >   }
> 
> Sorry Yury, can you elaborate more on this? What do you mean with
> inconsistent, is it the volatile nodemask_t *?

What I mean is:
  #define nearest_node_nodemask(start, srcp)
                __nearest_node_nodemask((start), &(srcp))
  int __nearest_node_nodemask(int node, nodemask_t *mask);

That way you'll be able to make the above for-loop looking more
uniform:

  #define for_each_node_numadist(node, unvisited)                                \
         for (int __s = (node),                                                \
              (node) = nearest_node_nodemask(__s, (unvisited));               \
              (node) < MAX_NUMNODES;                                               \
              node_clear((node), (unvisited)),                                     \
              (node) = nearest_node_nodemask(__s, (unvisited)))

> > >  #ifndef memory_add_physaddr_to_nid
> > >  int memory_add_physaddr_to_nid(u64 start);
> > >  #endif
> > > @@ -47,6 +49,11 @@ static inline int numa_nearest_node(int node, unsigned int state)
> > >  	return NUMA_NO_NODE;
> > >  }
> > >  
> > > +static inline int nearest_node_nodemask(int node, nodemask_t *mask)
> > > +{
> > > +	return NUMA_NO_NODE;
> > > +}
> > > +
> > >  static inline int memory_add_physaddr_to_nid(u64 start)
> > >  {
> > >  	return 0;
> > > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > > index 162407fbf2bc7..1e2acf187ea3a 100644
> > > --- a/mm/mempolicy.c
> > > +++ b/mm/mempolicy.c
> > > @@ -196,6 +196,38 @@ int numa_nearest_node(int node, unsigned int state)
> > >  }
> > >  EXPORT_SYMBOL_GPL(numa_nearest_node);
> > >  
> > > +/**
> > > + * nearest_node_nodemask - Find the node in @mask at the nearest distance
> > > + *			   from @node.
> > > + *
> > > + * @node: the node to start the search from.
> > > + * @mask: a pointer to a nodemask representing the allowed nodes.
> > > + *
> > > + * This function iterates over all nodes in the given state and calculates
> > > + * the distance to the starting node.
> > > + *
> > > + * Returns the node ID in @mask that is the closest in terms of distance
> > > + * from @node, or MAX_NUMNODES if no node is found.
> > > + */
> > > +int nearest_node_nodemask(int node, nodemask_t *mask)
> > > +{
> > > +	int dist, n, min_dist = INT_MAX, min_node = MAX_NUMNODES;
> > > +
> > > +	if (node == NUMA_NO_NODE)
> > > +		return MAX_NUMNODES;
> > 
> > This makes it unclear: you make it legal to pass NUMA_NO_NODE, but
> > your function returns something useless. I don't think it would help
> > users in any reasonable scenario.
> > 
> > So, if you don't want user to call this with node == NUMA_NO_NODE,
> > just describe it in comment on top of the function. Otherwise, please
> > do something useful like 
> > 
> > 	if (node == NUMA_NO_NODE)
> > 		node = current_node;
> > 
> > I would go with option 1. Notice, node_distance() doesn't bother to
> > check against NUMA_NO_NODE.
> 
> Hm... is it? Looking at __node_distance(), it doesn't seem really safe to
> pass a negative value (maybe I'm missing something?).

It's not safe, but inside the kernel we don't check parameters. Out of
your courtesy you may decide to put a comment, but strictly speaking you
don't have to.

> Anyway, I'd also prefer to go with option 1 and not implicitly assuming
> NUMA_NO_NODE == current node (it feels that it might hide nasty bugs).

Yeah, very true

> So, I can add a comment in the description to clarify that NUMA_NO_NODE is
> forbidenx, but what is someone is passing it? Should we WARN_ON_ONCE() at
> least?

He will brick his testing board, and learn to read comments in a hard
way.

Speaking more seriously, you will be most likely CCed as an author of
that function, and you will be able to comment that on review. Also,
there's a great chance that it will be caught by KASAN or some other
sanitation tool even before someone sends a buggy patch.

This is an old as the world and very well known problem, and everyone
is aware. 

Thanks,
Yury

