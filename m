Return-Path: <bpf+bounces-47596-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8B19FC121
	for <lists+bpf@lfdr.de>; Tue, 24 Dec 2024 18:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81749188427D
	for <lists+bpf@lfdr.de>; Tue, 24 Dec 2024 17:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCFB212D7A;
	Tue, 24 Dec 2024 17:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRBP2Qke"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C751FF7AC;
	Tue, 24 Dec 2024 17:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735063175; cv=none; b=GY4p2Ln/MKur6AA28XTwMSjdxxyGjs4Xl3ZyuDNKQxxDH+k/IAoRTIyfyrcVkH8HYVCp4kmFmqjQI99Ld/oy3s8vntTWiPqwia4vYt6OSL/LW1Gwbx9akcnZb0hl4+ypNQt0EmoWpcURZNoHMUNBlAhSky+qpHQCtm7R/0R5vn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735063175; c=relaxed/simple;
	bh=jvn30eeZ+FT5R3AL3PupNkOjM1VXDfdd/Zh8ZzbnNQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upBc9ZZbDjDMGq7+RIE2DTfLGdmDxke9V/zlrpjtE7smwR2SfQMuR6sT5Qdv7QRobfjZZPfRW1jPo4tZBlNsMYAOCOzPRYys5X2ECUm3e9VZq+nJjXuJtD47R/xm933yoR94vIk2roOS5IZitQsztw5dEDoYscQPM1poCJGJYi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YRBP2Qke; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2166360285dso56480805ad.1;
        Tue, 24 Dec 2024 09:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735063173; x=1735667973; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dJ3dIPq/31Diktf0kbhMRRNEIki1cimlv9WDnIzfaOE=;
        b=YRBP2QkeKfNfzmQXJFaywp9ohedgSZ67vQ+eOkZa152ZL6V+Byzo64xQSSWdLaIDDO
         PxZilgqMx3t0XddNk3TckRdetFEgF0QpelY2xG5gTIdBYU4iL1RD83d/USn7M2IE604x
         tdn3sZLYjA+ldyu918za1EbCcb2WxdSUmAmc97pPXhZw8XIQ5Vk4VWITtfRZUD7JP3DV
         QUmTKdTY1g4LRkV5/ktU0MUrq9j2rDV4ZlU9yliabmdSXx2VCZdW6eDdokmRU6mq2yv0
         tFlh+1iWDKdMql5PLYH6YdxnF5KnhDehybR7GvDFfZD/WTiIMgTGuZKhhWy0WewWJKrS
         B7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735063173; x=1735667973;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dJ3dIPq/31Diktf0kbhMRRNEIki1cimlv9WDnIzfaOE=;
        b=gwEfa9htA2Te3yf3aCjMPUGLsqJ86V/hm5gG+R/MQufg6e3b3m717wVu+mCIonVThQ
         c9yOa+oPgVVWFrS23YOaoy4He3xUtcmXzVu+sN7kjv9mnsdeSNlooM7NEQXgkftb1Oxp
         nQU6yyiLQ/jOBrSb3kMMzxv0vVV4fTepZ3UtgB2oPnO+ETcXxSNorLxWy+8+qfQ3YZf5
         Sa0jDIyGAoEnZ7iwtvxk3GO58d7PNtcG4aWYdc2kM4EixpvGh6xduk5WHFPbUPLNMXOL
         iFM/54+t5AIMaCKGyEmxlrOGw6zXlAr8+r2Qm7386jE71ffAXGLua57ei/Qj90IxJIOc
         8kfw==
X-Forwarded-Encrypted: i=1; AJvYcCUGue5rwMJG5KPIF7A+xX3E52HyZBrM0snJBLJa3eobwe2NlSyH6NXlCGcOtRV34dN36sU=@vger.kernel.org, AJvYcCX1NCKTwv/LPSWhjNft86f87DSc498KQOBbp+8MO19buiR7jY4hIg3wXDwFX7BjbUkIdbr7hGwK+1sB6QTP@vger.kernel.org
X-Gm-Message-State: AOJu0YxhUjh/xoG7fhUBCkD4Grl2Ab32PVV7Vlw+Fa7bywZGZwi4K28U
	nCa9GQMB/EPQ4MfcmdKfR+XL6n1Gvr5vzOAiHgIoGuX9yt5jVHrzCssNhA==
X-Gm-Gg: ASbGnctm24SYICgPakTJ4F8lg/Xl/5JzddmlMK6QINm8/762Mlgsqb31xMaBteL7Nrt
	Uy3ypWqpbxMjbrcX4Q37iSbGy4+6rPCDcZbVPnNVjtX32CeTGa0hNJmkEYgs9tiURvod+16TwK6
	RA+5YvKd4/cBuLEzqoeHklYz4uaLW6Trnc9BzKjilyXFiE4SKdUGH5T+/64OvFIKwXkmouMy+71
	npU//TyRi8witXXD9gwAI1AJA3eVFnybCCAWLXHmAGsB6rK5gNN8tGt
X-Google-Smtp-Source: AGHT+IHCh1PoLkXDYgxJU5+0MUoP9Rthmc/ySHZpdktR0ZqAfwJXobzccCwF/tagHv2HkaFkWqDFwg==
X-Received: by 2002:a17:903:94e:b0:215:96bc:b670 with SMTP id d9443c01a7336-219e6e9df70mr229886335ad.18.1735063173042;
        Tue, 24 Dec 2024 09:59:33 -0800 (PST)
Received: from localhost ([216.228.125.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc96312asm92629605ad.21.2024.12.24.09.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2024 09:59:32 -0800 (PST)
Date: Tue, 24 Dec 2024 09:59:30 -0800
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
	Valentin Schneider <vschneid@redhat.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/10] sched_ext: Introduce per-node idle cpumasks
Message-ID: <Z2r2gs8kvx4ugNg7@yury-ThinkPad>
References: <20241220154107.287478-1-arighi@nvidia.com>
 <20241220154107.287478-8-arighi@nvidia.com>
 <Z2ozISbYmWPj7VNA@yury-ThinkPad>
 <Z2puVLPsfKtAqpTl@gpd3>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2puVLPsfKtAqpTl@gpd3>

On Tue, Dec 24, 2024 at 09:18:28AM +0100, Andrea Righi wrote:
> On Mon, Dec 23, 2024 at 08:05:53PM -0800, Yury Norov wrote:
> > On Fri, Dec 20, 2024 at 04:11:39PM +0100, Andrea Righi wrote:

...

> > > + * cpumasks to track idle CPUs within each NUMA node.
> > > + *
> > > + * If SCX_OPS_BUILTIN_IDLE_PER_NODE is not specified, a single flat cpumask
> > > + * from node 0 is used to track all idle CPUs system-wide.
> > > + */
> > > +static struct idle_cpumask **scx_idle_masks;
> > > +
> > > +static struct idle_cpumask *get_idle_mask(int node)
> > 
> > Didn't we agree to drop this 'get' thing?
> 
> Hm... no? :)
> 
> The analogy you pointed out was with get_parity8() which implements a pure
> function, so we should just use parity8() as "get" is implicit.
> 
> This case is a bit different IMHO, because it's getting a reference to the
> object (so not a pure function) and we may even have a put_idle_mask()
> potentially.
> 
> Personally I like to have the "get" here, but if you think it's confusing
> or it makes the code less readable I'm ok to drop it.

OK, whatever

...
 
> > > + * Find the best idle CPU in the system, relative to @node.
> > > + *
> > > + * If @node is NUMA_NO_NODE, start from the current node.
> > > + */
> > 
> > And if you don't invent this rule for kernel users, you don't need to
> > explain it everywhere.
> 
> I think we mentioned treating NUMA_NO_NODE as current node, but I might
> have misunderstood.

That's for userspace to maybe save a syscall. For in-kernel users it's
unneeded for sure.

> In an earlier patch set I was just ignoring
> NUMA_NO_NODE. Should we return an error instead?

Kernel users will never give you NUMA_NO_NODE if you ask them not to
do that. Resolving NO_NODE to current node for kernel users is useless.
They can call numa_node_id() just as well.

Userspace can do everything, so you have to check what they pass. For
userspace, it's up to you either to resolve NO_NODE to current node,
random node, simulate disabled per-numa idlemasks, do anything else or
return an error.
 

