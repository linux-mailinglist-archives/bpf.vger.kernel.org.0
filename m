Return-Path: <bpf+bounces-47597-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2760C9FC134
	for <lists+bpf@lfdr.de>; Tue, 24 Dec 2024 19:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C24B1884A19
	for <lists+bpf@lfdr.de>; Tue, 24 Dec 2024 18:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C9821322A;
	Tue, 24 Dec 2024 18:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKTUYwJZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20199212D9D;
	Tue, 24 Dec 2024 18:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735064106; cv=none; b=SIB7OnEcsrxkJFmsjiD3d9Ujac2V9dyJJdxAOof6WysehxqNZOIP/N3YMWWizhmj/VXcTUOxEUJD8o6pV18AwkWHTppYpnAO4WC5slo1Am+C1h30X4rlpPyAtGxtQ/rZhLiVCHr+LAGI98v6IF9Va3MM0t27zDU5GzTwFDe2BVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735064106; c=relaxed/simple;
	bh=1rxJSxi0U+p9Q9WWCeT+auP4PlVkfVdLame+lW9JyjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SXbQDLO8dNs/F92+rDQVEDgR8ZFCSbXbGDWVeCvTaCH8o7C1U/d2wUAo2E4YIRrgDfrGR1Jiw7prOUHcrrPKf1t4pGMHG2TKgibHSgCxXmpX2QTl234OA5KEqtqE1do5J4FPGV3PU1HHHqx8PAeVoyBEe3+0g4sX5W0R84q2N3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lKTUYwJZ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-216401de828so53971145ad.3;
        Tue, 24 Dec 2024 10:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735064104; x=1735668904; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D6AUQDEIKDktSz5K+GUl20kkeuhWstxptNLX0Y/BQMI=;
        b=lKTUYwJZ0dnuEz3nmdPVRdMPYTbk6v9zztgsBVeexK9ZS+KQtz6xenzmNpDxYHrPlC
         Sc2UDvt2a4jVGpnsweAu/l3cBlDBYYdQM99ssH8tTn8+DYei8kjNOwrhm053984v58sN
         mVW4Dn04JkdXJplpeck+9irOteSPP6IurrgxjhX4P7lce2RnMrkcjLTcd7q8iEhOnqCx
         TfCrqrrPtvFjQvFu8c91uR1F1kzRDIzjk3Es3AtHSzJDaopVSdLx8WKn1vLz9prnRaf9
         7w9aP5hDQ7cbzyvoYMoCUzRB5FU71jLgQsOxnKJ3Hn7/lGOAYPsTx/L+Cy8afciG19S5
         5YYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735064104; x=1735668904;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D6AUQDEIKDktSz5K+GUl20kkeuhWstxptNLX0Y/BQMI=;
        b=R30BYWZFyWcdSmka4oA+qLeMFdCrkS+1re7M3U5zQ2bT2rBNtUgz4YOKlUwdQvNv39
         qz5T5h0IkZcPl1KRDSWO0lQ/X1GXGhbSoHGL0zqqtRwK9++1hftSzp5RCwJ2v0WJlkrl
         K0Up24HVnOZ+UmoSQKyiPsDXNiAXsa5wFsEnUGDAwWn4CMVgkbIsHSkNU4tnR5juNHzV
         K0QzUp5XV6v3tPz8IgF7SiomqhG8l9EzujK+n8LlwJeeTqCCC/Fjj90kx/DVIPeYDaTW
         1+y890qzMZ9pYb0xmSWAgIuhVIz8A69vAXngmDw1uDA2NTTV4HwJIZpsE2uswNmLUhZn
         /1ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoNXBXFlBcDsDh8gI8R0HQCLp8hFjGMGEGyxISue9+B6A9gFNAhkNmVWuPbnkgAzKqSaHoLUR8ienKdtbh@vger.kernel.org, AJvYcCWlb9jCzxPJO3EFqJeKFtp4nl+xiY9LaTtPzJ/9+tQEsm97PNWiP2qoenNmvajJ+rOZc/s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3DFiaCvPFssNNaGYID2fvwfK1i4RWHUMs9RfbPV2PQGJdu0P2
	ah2svgAiZFBMldixdLm9GelfZHIPd66zcg48XGEi5BVkvE8hPY+I
X-Gm-Gg: ASbGnctcasgUh60rmJid74YFy2Tn+LddaYvox37jugfyJDzPUz5Bl73Ocax3UHhHO+w
	QdQi3kfES5eExmd90kebfI88/UzcDCTm1W3qiMDFxVDJDzRVbcPBL61g1Ug+/H6N2xx87+DuZDZ
	THBiS35N9Kl+DwRybI6r0D+J4OdnGPFVllSsTE+j4OUpxPBliwrQTQRL+yMS/7410eyA+u5uZ6q
	fzEuzwux67ezTQ4vNJljEzakUr6cqVUH0vqLLpzhjEIZjZsUKd6Q7Az
X-Google-Smtp-Source: AGHT+IFX/U/e+IWDrfiz98oP0ISlCou7n3JrQQWIyyDv0D0em+PR7dp0ItGcVLVPseIOxlQQ8milVw==
X-Received: by 2002:a05:6a20:7f8b:b0:1e0:dc06:4f4d with SMTP id adf61e73a8af0-1e5e04958f8mr26863387637.19.1735064104378;
        Tue, 24 Dec 2024 10:15:04 -0800 (PST)
Received: from localhost ([216.228.125.131])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842aba7310bsm7774075a12.1.2024.12.24.10.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2024 10:15:03 -0800 (PST)
Date: Tue, 24 Dec 2024 10:15:01 -0800
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
Subject: Re: [PATCH 08/10] sched_ext: idle: introduce SCX_PICK_IDLE_NODE
Message-ID: <Z2r6Jdbl7ekbH-OM@yury-ThinkPad>
References: <20241220154107.287478-1-arighi@nvidia.com>
 <20241220154107.287478-9-arighi@nvidia.com>
 <Z2ohDX-F6bvBO3bx@yury-ThinkPad>
 <Z2owJmy22Tk-bl4A@yury-ThinkPad>
 <Z2pyzzmrbcVJ14TI@gpd3>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z2pyzzmrbcVJ14TI@gpd3>

On Tue, Dec 24, 2024 at 09:37:35AM +0100, Andrea Righi wrote:
> On Mon, Dec 23, 2024 at 07:53:21PM -0800, Yury Norov wrote:
> > On Mon, Dec 23, 2024 at 06:48:48PM -0800, Yury Norov wrote:
> > > On Fri, Dec 20, 2024 at 04:11:40PM +0100, Andrea Righi wrote:
> > > > Introduce a flag to restrict the selection of an idle CPU to a specific
> > > > NUMA node.
> > > > 
> > > > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> > > > ---
> > > >  kernel/sched/ext.c      |  1 +
> > > >  kernel/sched/ext_idle.c | 11 +++++++++--
> > > >  2 files changed, 10 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> > > > index 143938e935f1..da5c15bd3c56 100644
> > > > --- a/kernel/sched/ext.c
> > > > +++ b/kernel/sched/ext.c
> > > > @@ -773,6 +773,7 @@ enum scx_deq_flags {
> > > >  
> > > >  enum scx_pick_idle_cpu_flags {
> > > >  	SCX_PICK_IDLE_CORE	= 1LLU << 0,	/* pick a CPU whose SMT siblings are also idle */
> > > > +	SCX_PICK_IDLE_NODE	= 1LLU << 1,	/* pick a CPU in the same target NUMA node */
> > > 
> > > SCX_FORCE_NODE or SCX_FIX_NODE?
> > > 
> > > >  };
> > > >  
> > > >  enum scx_kick_flags {
> > > > diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
> > > > index 444f2a15f1d4..013deaa08f12 100644
> > > > --- a/kernel/sched/ext_idle.c
> > > > +++ b/kernel/sched/ext_idle.c
> > > > @@ -199,6 +199,12 @@ static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, int node, u64 f
> > 
> > This function begins with:
> > 
> >  static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, int node, u64 flags)
> >  {
> >       nodemask_t hop_nodes = NODE_MASK_NONE;
> >       s32 cpu = -EBUSY;
> >  
> >       if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
> >               return pick_idle_cpu_from_node(cpus_allowed, NUMA_FLAT_NODE, flags);
> > 
> >       ...
> >  
> > So if I disable scx_builtin_idle_per_node and then call:
> > 
> >         scx_pick_idle_cpu(some_cpus, numa_node_id(), SCX_PICK_IDLE_NODE)
> > 
> > I may get a CPU from any non-local node, right? I think we need to honor user's
> > request:  
> > 
> >       if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
> >               return pick_idle_cpu_from_node(cpus_allowed,
> >                      flags & SCX_PICK_IDLE_NODE ? node :  NUMA_FLAT_NODE, flags);
> > 
> > That way the code will be coherent: if you enable idle cpumasks, you
> > will be able to follow all the NUMA hierarchy. If you disable them, at
> > least you honor user's request to return a CPU from a given node, if
> > he's very explicit about his intention.
> > 
> > You can be even nicer:
> > 
> >       if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node)) {
> >                 node = pick_idle_cpu_from_node(cpus, node, flags);
> >                 if (node == MAX_NUM_NODES && flags & SCX_PICK_IDLE_NODE == 0)
> >                         node = pick_idle_cpu_from_node(cpus, NUMA_FLAT_NODE, flags);
> > 
> >                 return node;
> >       }
> > 
> 
> Sorry, I'm not following, if scx_builtin_idle_per_node is disabled, we’re
> only tracking idle CPUs in a single NUMA_FLAT_NODE (which is node 0). All
> the other cpumasks are just empty, and we would always return -EBUSY if we
> honor the user request.

You're right. We can still do that like this:

       if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node)) {
                 cpumask_and(tmp, cpus, cpumask_of_node(node));
                 node = pick_idle_cpu_from_node(tmp, NUMA_FLAT_NODE, flags);
                 if (node == MAX_NUM_NODES && flags & SCX_PICK_IDLE_NODE == 0)
                         node = pick_idle_cpu_from_node(cpus, NUMA_FLAT_NODE, flags);
 
                 return node;
       }

But I'm not sure we need this complication. Maybe later...

> 
> Maybe we should just return an error if scx_builtin_idle_per_node is
> disabled and the user is requesting an idle CPU in a specific node?

The problem is that NUMA_FLAT_NODE is 0, and you can't distinguish it
from node #0. You can drop NUMA_FLAT_NODE and ask users to always
provide NUMA_NO_NODE if idle_per_node is disabled, or you can ignore
the node entirely. You just need to describe it explicitly.

