Return-Path: <bpf+bounces-51002-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5CDA2F3D6
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 17:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C96C41682E5
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 16:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2082124BCEC;
	Mon, 10 Feb 2025 16:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MwKQo8OD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90C21F4601;
	Mon, 10 Feb 2025 16:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739205713; cv=none; b=RwqGKG3+Yp/BvGmyx5auTYZJGHg0LWq9fotthVixFPwKr+wdcwZ/eSlzPgBvc22QdOZHMxBtIyIHcEBay2FwlSdL70mBVpfhsNdggcDAc1yFodbLI794+rwuHIt/Q3AInTatvUvRmJR1f4OLU9VGOWm0cdugSvcQiUGn4Iiikx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739205713; c=relaxed/simple;
	bh=if/o2+rveq4RiqTF+vl1ue17c8C6feNSicVEFq4UYjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K5fZKH+0GseaGi0NZ4yVa3no7hyGZkwSkHW8mXvIa5oCuzs1r7XigzQnN9blSV6PeWzI1u+ea1QczPcRpD7XQ6iUMWeLLZgKlM7OQRlGe1qzApWeSOaer1GY0Iivj0cBClHr/66K91BGzvAVVRU7vJUuvJ1qFnzq6vBoH80bCpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MwKQo8OD; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21f49bd087cso59582075ad.0;
        Mon, 10 Feb 2025 08:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739205711; x=1739810511; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pvGEOc8BE6X4W6r1gQepdpWa/L1MctZloj1XHUzmyk0=;
        b=MwKQo8OD9/uJXx5F1C+VcoK8QCAAFKzdfUyfCKQ1mAoTrNsMHeWlP3EcRf2fJc3gr9
         u4P83STh+hkWigUg4iOLwlUHeLArpma9YVxoTE0hczsNjSIAAG+SEN1Vg9GvJ6oH6Vhg
         xZ/OW40D3lSAV+aoN3wJxs26kL7chB9LjNbS1EJqCPVhg9xWDHv3Z66Ehpk8zK+G/5dd
         jeXsQG3hfT71FdlncH0TUOI5iBTpUWH/ImATH4QKHmE9YOSjmm7eq5rfx2roe8lSQ4Ij
         W71YMmfY2cKWsWtAQK+wn9Op32PrdsiXNpk9QCs70OuV04HBsZ0gcnjQjbWPRW165zob
         9BWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739205711; x=1739810511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvGEOc8BE6X4W6r1gQepdpWa/L1MctZloj1XHUzmyk0=;
        b=tn+dt10+6nlPmaX+qOVjWSfjaVyUKu8lJC+mipakIXIQ1rEWOoHB2RofZ0LbwuU0iO
         2khxn2PLOmdKj63bSABKyEv0FyRh9uWe8Kmayh25Am/Ed0EWC+BEcdx2m9JxJMyIcdMM
         eCotUVZyDBUG2Z7hVF/klv7tPZl1Gp7rCevfDL3Nhn7P0GGO/R8cdT+m1bdQCdQbwMLE
         padUgG837zCKPqhTlbLAExq1XaWeXqKcBlACKcaMFfUs+LXdMsG/iK/R9UhRWr09FPeX
         ETUxP77ykv5DTYBanptRIiBRmrjAwagiWjXYTfFtbo8FT/rSazPrTROdhA4roSg+Ql+Z
         TWEw==
X-Forwarded-Encrypted: i=1; AJvYcCUHwjYEiK3PpLXoq5ICUX3nWShsRfV0LUqgbl04upnMzzHWpBW5xXzJJQ/6TlP+gzjnFNRCMWrzNMF/dr3o@vger.kernel.org, AJvYcCW3zbQUyF/k4P6/jTZ4GXrTOYCjs9YryVRW2M6/b5FpQWgQ3LhQ2He0GGAWA20BzFFoWcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXpZCOao0Ow0h3lAPi/vzq1Qqh6is0gz2zXQhZRzf9P0gl7AmQ
	N7ysasCrEiCakq/5EkWFP/CNrUu6Ho4G1rzw0yBZNLDxMUa+zBPR
X-Gm-Gg: ASbGncs3JAH71c8rK+DQTuQttZL3GVGj33n2Z90INa+UIu8Ra7bNygGomgnKRc6CKo8
	mKwSDD3YwZCbgH/YNtLQhrZBkceNKArrb2xGx8FulHUNnHWpTa0/xgFvkc12C4zQseJl2M6q7wI
	mcAPfJ/YI2m5hAsPHPDH26PAJUa8q8HCGfmpyrYKBAK1HdV0qQ4g0hVJleyPyeP+lSjZkEuzU2U
	w73tiNqQjGb/8ngZuMuGod1Wcl5muVBLY94tnBKui9rc4X9eDRejppmL5raQCR8eBtxI/2Wytww
	w2WZTJnz2L1nZuU=
X-Google-Smtp-Source: AGHT+IHRAAvpIYUwfUAYjePivltgLNxrz/atV3E/3nJxRaUKxcM0BqLpJ2Nyh5j/0jwN46ZciNphwQ==
X-Received: by 2002:a05:6a20:2d07:b0:1db:e464:7b69 with SMTP id adf61e73a8af0-1ee03a5e241mr23141039637.20.1739205710820;
        Mon, 10 Feb 2025 08:41:50 -0800 (PST)
Received: from localhost ([216.228.125.130])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad51aeb8cfesm8084279a12.10.2025.02.10.08.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 08:41:50 -0800 (PST)
Date: Mon, 10 Feb 2025 11:41:48 -0500
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
Subject: Re: [PATCH 1/6] mm/numa: Introduce numa_nearest_nodemask()
Message-ID: <Z6osTMrXVv54cES9@thinkpad>
References: <20250207211104.30009-1-arighi@nvidia.com>
 <20250207211104.30009-2-arighi@nvidia.com>
 <Z6joYmcjyT8eY32H@thinkpad>
 <Z6m4tEoiUBNBmIjV@gpd3>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6m4tEoiUBNBmIjV@gpd3>

On Mon, Feb 10, 2025 at 09:28:36AM +0100, Andrea Righi wrote:
> Hi Yury,
> 
> On Sun, Feb 09, 2025 at 12:40:15PM -0500, Yury Norov wrote:
> > On Fri, Feb 07, 2025 at 09:40:48PM +0100, Andrea Righi wrote:
> > > Introduce the new helper numa_nearest_nodemask() to find the closest
> > > node, in a specified nodemask and state, from a given starting node.
> > > 
> > > Returns MAX_NUMNODES if no node is found.
> > > 
> > > Cc: Yury Norov <yury.norov@gmail.com>
> > > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> > > ---
> > >  include/linux/nodemask_types.h |  6 +++++-
> > >  include/linux/numa.h           |  8 +++++++
> > >  mm/mempolicy.c                 | 38 ++++++++++++++++++++++++++++++++++
> > >  3 files changed, 51 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/include/linux/nodemask_types.h b/include/linux/nodemask_types.h
> > > index 6b28d97ea6ed0..8d0b7a66c3a49 100644
> > > --- a/include/linux/nodemask_types.h
> > > +++ b/include/linux/nodemask_types.h
> > > @@ -5,6 +5,10 @@
> > >  #include <linux/bitops.h>
> > >  #include <linux/numa.h>
> > >  
> > > -typedef struct { DECLARE_BITMAP(bits, MAX_NUMNODES); } nodemask_t;
> > > +struct nodemask {
> > > +	DECLARE_BITMAP(bits, MAX_NUMNODES);
> > > +};
> > > +
> > > +typedef struct nodemask nodemask_t;
> > >  
> > >  #endif /* __LINUX_NODEMASK_TYPES_H */
> > > diff --git a/include/linux/numa.h b/include/linux/numa.h
> > > index 3567e40329ebc..a549b87d1fca5 100644
> > > --- a/include/linux/numa.h
> > > +++ b/include/linux/numa.h
> > > @@ -27,6 +27,8 @@ static inline bool numa_valid_node(int nid)
> > >  #define __initdata_or_meminfo __initdata
> > >  #endif
> > >  
> > > +struct nodemask;
> > 
> > Numa should include this via linux/nodemask_types.h, or maybe
> > nodemask.h.
> 
> Hm... nodemask_types.h needs to include numa.h to resolve MAX_NUMNODES,
> Maybe we can move numa_nearest_nodemask() to linux/nodemask.h?

Maybe yes, but it's generally wrong. nodemask.h is a library, and
numa.h (generally, NUMA code) is one user. The right way to go is when
client code includes all necessary libs, not vise-versa.

Regarding MAX_NUMNODES, it's a natural property of nodemasks, and
should be declared in nodemask.h. The attached patch reverts the
inclusion paths dependency. I build-tested it against today's master
and x86_64 defconfig. Can you consider taking it and prepending your
series?
 
> > >  #ifdef CONFIG_NUMA
> > >  #include <asm/sparsemem.h>
> > >  
> > > @@ -38,6 +40,7 @@ void __init alloc_offline_node_data(int nid);
> > >  
> > >  /* Generic implementation available */
> > >  int numa_nearest_node(int node, unsigned int state);
> > > +int numa_nearest_nodemask(int node, unsigned int state, struct nodemask *mask);
> > >  
> > >  #ifndef memory_add_physaddr_to_nid
> > >  int memory_add_physaddr_to_nid(u64 start);
> > > @@ -55,6 +58,11 @@ static inline int numa_nearest_node(int node, unsigned int state)
> > >  	return NUMA_NO_NODE;
> > >  }
> > >  
> > > +static inline int numa_nearest_nodemask(int node, unsigned int state, struct nodemask *mask)
> > > +{
> > > +	return NUMA_NO_NODE;
> > > +}
> > > +
> > >  static inline int memory_add_physaddr_to_nid(u64 start)
> > >  {
> > >  	return 0;
> > > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > > index 162407fbf2bc7..1cfee509c7229 100644
> > > --- a/mm/mempolicy.c
> > > +++ b/mm/mempolicy.c
> > > @@ -196,6 +196,44 @@ int numa_nearest_node(int node, unsigned int state)
> > >  }
> > >  EXPORT_SYMBOL_GPL(numa_nearest_node);
> > >  
> > > +/**
> > > + * numa_nearest_nodemask - Find the node in @mask at the nearest distance
> > > + *			   from @node.
> > > + *
> > 
> > So, I have a feeling about this whole naming scheme. At first, this
> > function (and the existing numa_nearest_node()) searches for something,
> > but doesn't begin with find_, search_ or similar. Second, the naming
> > of existing numa_nearest_node() doesn't reflect that it searches
> > against the state. Should we always include some state for search? If
> > so, we can skip mentioning the state, otherwise it should be in the
> > name, I guess...
> > 
> > The problem is that I have no idea for better naming, and I have no
> > understanding about the future of this functions family. If it's just
> > numa_nearest_node() and numa_nearest_nodemask(), I'm OK to go this
> > way. If we'll add more flavors similarly to find_bit() family, we
> > could probably discuss a naming scheme.
> > 
> > Also, mm/mempolicy.c is a historical place for them, but maybe we need
> > to move it somewhere else?
> > 
> > Any thoughts appreciated.
> 
> Personally I think adding "find_" to the name would be a bit redundant, as
> it seems quite obvious that it's finding the nearest node. It sounds a bit
> like the get_something() discussion and we can just use something().
> 
> About adding "_state" to the name, it'd make sense since we have
> for_each_node_state/for_each_node(), but we would need to change
> numa_nearest_node() -> numa_nearest_node_state((), that is beyond the scope
> of this patch set.
> 
> If I had to design this completely from scratch I'd probably propose
> something like this:
>  - nearest_node_state(node, state)
>  - nearest_node(node) -> nearest_node_state(node, N_POSSIBLE)
>  - nearest_node_nodemask(node, nodemask) -> here the state can be managed
>    with the nodemask (as you suggested below)
> 
> But again, this is probably a more generic discussion that can be addressed
> in a separate thread.

Yes, it's not related to your series. Please just introduce
nearest_node_nodemask(node, nodemask) as your minimal required change.
I will do a necessary cleanup later, if needed.

Thanks,
Yury

From 3ad589b371d671485d61d7debcb7526283a2f703 Mon Sep 17 00:00:00 2001
From: Yury Norov <yury.norov@gmail.com>
Date: Mon, 10 Feb 2025 10:56:04 -0500
Subject: [PATCH] nodemask: numa: reorganize inclusion path

Nodemasks now pull linux/numa.h for MAX_NUMNODES and NUMA_NO_NODE
macros. This series makes numa.h depending on nodemasks, so we hit
a circular dependency.

Nodemasks library is highly employed by NUMA code, and it would be
logical to resolve the circular dependency by making NUMA headers
dependent nodemask.h.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/nodemask.h       |  1 -
 include/linux/nodemask_types.h | 11 ++++++++++-
 include/linux/numa.h           | 10 +---------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
index 9fd7a0ce9c1a..27644a6edc6e 100644
--- a/include/linux/nodemask.h
+++ b/include/linux/nodemask.h
@@ -94,7 +94,6 @@
 #include <linux/bitmap.h>
 #include <linux/minmax.h>
 #include <linux/nodemask_types.h>
-#include <linux/numa.h>
 #include <linux/random.h>
 
 extern nodemask_t _unused_nodemask_arg_;
diff --git a/include/linux/nodemask_types.h b/include/linux/nodemask_types.h
index 6b28d97ea6ed..f850a48742f1 100644
--- a/include/linux/nodemask_types.h
+++ b/include/linux/nodemask_types.h
@@ -3,7 +3,16 @@
 #define __LINUX_NODEMASK_TYPES_H
 
 #include <linux/bitops.h>
-#include <linux/numa.h>
+
+#ifdef CONFIG_NODES_SHIFT
+#define NODES_SHIFT     CONFIG_NODES_SHIFT
+#else
+#define NODES_SHIFT     0
+#endif
+
+#define MAX_NUMNODES    (1 << NODES_SHIFT)
+
+#define	NUMA_NO_NODE	(-1)
 
 typedef struct { DECLARE_BITMAP(bits, MAX_NUMNODES); } nodemask_t;
 
diff --git a/include/linux/numa.h b/include/linux/numa.h
index 3567e40329eb..31d8bf8a951a 100644
--- a/include/linux/numa.h
+++ b/include/linux/numa.h
@@ -3,16 +3,8 @@
 #define _LINUX_NUMA_H
 #include <linux/init.h>
 #include <linux/types.h>
+#include <linux/nodemask.h>
 
-#ifdef CONFIG_NODES_SHIFT
-#define NODES_SHIFT     CONFIG_NODES_SHIFT
-#else
-#define NODES_SHIFT     0
-#endif
-
-#define MAX_NUMNODES    (1 << NODES_SHIFT)
-
-#define	NUMA_NO_NODE	(-1)
 #define	NUMA_NO_MEMBLK	(-1)
 
 static inline bool numa_valid_node(int nid)
-- 
2.43.0


