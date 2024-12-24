Return-Path: <bpf+bounces-47575-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD759FB900
	for <lists+bpf@lfdr.de>; Tue, 24 Dec 2024 04:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 973A718847B1
	for <lists+bpf@lfdr.de>; Tue, 24 Dec 2024 03:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2A74438B;
	Tue, 24 Dec 2024 03:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VnBsU3Ld"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D52DEBE;
	Tue, 24 Dec 2024 03:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735012407; cv=none; b=mxk3k5P2NcqWCah9F7RRdY43BSmLCjCl5Fxq47UW37HZDMzUf1Oj/QiWrIzKW+pKunSAi24XL4+Lj8hu8Uh3Uj2HXpS12t2KCQOaZN5ZttiTnSNsZn7VSSDfzp2msx4QXzHxrUC8/stZqZoBR9lz1ICusBDsalLqEeF31nocvy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735012407; c=relaxed/simple;
	bh=stXYn2KyoGbzTEgZDVWbK8KIQ0No9Arkgrs+/F7bepQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CctKdbCIalr5JtRwomfQ+CfcqLZpJeItMgXTJKbypkyaPfRfQIwhy0Key9i3lyh3gUOc3ec2nLiMHi6ZI6Mbph6cnw91UeIDU90fqRUoMcvs8F9GuTNUZS83WNtRmNVcOUePfugglm/VVMproOTcrxwNCQ4OKWJb7TESXwDbNio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VnBsU3Ld; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e3984b1db09so3896013276.3;
        Mon, 23 Dec 2024 19:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735012404; x=1735617204; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RH3YIns7BJrGHpiIQC2Ath1meKddo+eVphCfV4irGoo=;
        b=VnBsU3LdLJXsRnOsuubXI1N06OTIU6/i4WSKlpkUhMml6Kbf6jYmzO67CdJTKIehgZ
         mWMz1WuQxGsGWwPieWRdLPE5RF8EzSgOn35LLbNQfpPOA52PW178zZjVdiFIP1tYQZWt
         X4t65QGV1AL92vSIjle9nkF6C5seuEY9hK19k4bZzUcMWK4/wAzbtQeam7r9WfVQSLUP
         TYu2BjMNdtA/Hnr9iiZsSjIkt0sqRdSbgff0cG3eTt+uMOyNc0CSWxvTmvv6B5cqwVL+
         ZlUoymuFtNhFVn45IjqYnaz94qQFemLte3m0yC2Do+Nfap+rkRL003uu/PBo+YLJ99x5
         6bsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735012404; x=1735617204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RH3YIns7BJrGHpiIQC2Ath1meKddo+eVphCfV4irGoo=;
        b=PaegJAkE/CJUWYbKWICGnFDczDFNndpp+Izuh79xshFWo6qRxZe8RJpa0zZiEwKHwk
         X0qXEjhxZDANN0xoxNlru0UU1OJiQmr6vWZuq66bfHdniHIuXnuADzk7IvHn5JhJPWOt
         xlYjDqweH/nqUSEfQpQcIPPir1OTtrVDF+brkmn7MIgS/6+czMC7Mn3NaD6Yw3JPmntx
         IjBwkFAuoqHrBm9ooJU3IgFEFCs0Jth/uNHyZP4A5KbonxxMWmZ8dg181PaELfISITKO
         nGg3zBM9M5XmSmUz6Uncg7BhYwwEqGdx6Bjgs5ap7MpWUSNL6PCoqCtE0DBU09fKNuIS
         z2OQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5epP+6QdL528cXwy0HhG/8Npz6p8sZBb5kkCeG6/ST2vKUaaU9MAzYg38kP+fcXdnktiw097MRSdpGqcm@vger.kernel.org, AJvYcCV4qf0Lg4/EwoiNysaZcc1nrsv3sStpKrrEC+KUAY753VIGj2Xa+mkHR/1EeixpsupSFig=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM+di3hsGr/jT4iGxBioaB5rFNqGzcPfRIzRyVvLlCGrjvLtLT
	d757P9GBRUEHMZgYFs9fO6BKxulrT2x0mTtz0duBMamk9AP6ZpTo
X-Gm-Gg: ASbGncuFkMB6dqNO6M5DeloA603BpuK2aKRFQu93joa9b5bjztx121FVLaXpVhvCVPV
	E7JW+QMasn8Twy7TuZKY2WXaRKTcTO84bx0BJR+DdQcvf/o52XhE5azA05h3r8hPIemiDGEaviB
	63j3Gqzqoogr9WIUMUGJw+vyp28j3L1dQr03IrCiopQRhjej/M/lj4MDG0Yme+0CvBXhtZHFNYM
	D/qb+QG8IfzmKjCZt+ePq4ZOw5BJo0fctrQfezCQM8aeo1thLyK+lTKXylCAAHutaZiCm7f+hHV
	z3BtND3a27V3q7Hy
X-Google-Smtp-Source: AGHT+IGIyivkgstOB+kMt6iSfliLdAXhhjDScmWxRmqXpnrLWX3Z39gIXEr7vneVpyEX5M+ddgj+Ig==
X-Received: by 2002:a05:690c:4885:b0:6ef:68b9:c97d with SMTP id 00721157ae682-6f3f823b780mr116508447b3.39.1735012404369;
        Mon, 23 Dec 2024 19:53:24 -0800 (PST)
Received: from localhost (c-24-129-28-254.hsd1.fl.comcast.net. [24.129.28.254])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f3e77ee18fsm26601817b3.82.2024.12.23.19.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 19:53:23 -0800 (PST)
Date: Mon, 23 Dec 2024 19:53:21 -0800
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
Message-ID: <Z2owJmy22Tk-bl4A@yury-ThinkPad>
References: <20241220154107.287478-1-arighi@nvidia.com>
 <20241220154107.287478-9-arighi@nvidia.com>
 <Z2ohDX-F6bvBO3bx@yury-ThinkPad>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2ohDX-F6bvBO3bx@yury-ThinkPad>

On Mon, Dec 23, 2024 at 06:48:48PM -0800, Yury Norov wrote:
> On Fri, Dec 20, 2024 at 04:11:40PM +0100, Andrea Righi wrote:
> > Introduce a flag to restrict the selection of an idle CPU to a specific
> > NUMA node.
> > 
> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> > ---
> >  kernel/sched/ext.c      |  1 +
> >  kernel/sched/ext_idle.c | 11 +++++++++--
> >  2 files changed, 10 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> > index 143938e935f1..da5c15bd3c56 100644
> > --- a/kernel/sched/ext.c
> > +++ b/kernel/sched/ext.c
> > @@ -773,6 +773,7 @@ enum scx_deq_flags {
> >  
> >  enum scx_pick_idle_cpu_flags {
> >  	SCX_PICK_IDLE_CORE	= 1LLU << 0,	/* pick a CPU whose SMT siblings are also idle */
> > +	SCX_PICK_IDLE_NODE	= 1LLU << 1,	/* pick a CPU in the same target NUMA node */
> 
> SCX_FORCE_NODE or SCX_FIX_NODE?
> 
> >  };
> >  
> >  enum scx_kick_flags {
> > diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
> > index 444f2a15f1d4..013deaa08f12 100644
> > --- a/kernel/sched/ext_idle.c
> > +++ b/kernel/sched/ext_idle.c
> > @@ -199,6 +199,12 @@ static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, int node, u64 f

This function begins with:

 static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, int node, u64 flags)
 {
      nodemask_t hop_nodes = NODE_MASK_NONE;
      s32 cpu = -EBUSY;
 
      if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
              return pick_idle_cpu_from_node(cpus_allowed, NUMA_FLAT_NODE, flags);

      ...
 
So if I disable scx_builtin_idle_per_node and then call:

        scx_pick_idle_cpu(some_cpus, numa_node_id(), SCX_PICK_IDLE_NODE)

I may get a CPU from any non-local node, right? I think we need to honor user's
request:  

      if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
              return pick_idle_cpu_from_node(cpus_allowed,
                     flags & SCX_PICK_IDLE_NODE ? node :  NUMA_FLAT_NODE, flags);

That way the code will be coherent: if you enable idle cpumasks, you
will be able to follow all the NUMA hierarchy. If you disable them, at
least you honor user's request to return a CPU from a given node, if
he's very explicit about his intention.

You can be even nicer:

      if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node)) {
                node = pick_idle_cpu_from_node(cpus, node, flags);
                if (node == MAX_NUM_NODES && flags & SCX_PICK_IDLE_NODE == 0)
                        node = pick_idle_cpu_from_node(cpus, NUMA_FLAT_NODE, flags);

                return node;
      }

> >  		cpu = pick_idle_cpu_from_node(cpus_allowed, n, flags);
> >  		if (cpu >= 0)
> >  			break;
> > +		/*
> > +		 * Check if the search is restricted to the same core or
> > +		 * the same node.
> > +		 */
> > +		if (flags & SCX_PICK_IDLE_NODE)
> > +			break;
> 
> Yeah, if you will give a better name for the flag, you'll not have to
> comment the code.
> 
> >  	}
> >  
> >  	return cpu;
> > @@ -495,7 +501,8 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
> >  		 * Search for any fully idle core in the same LLC domain.
> >  		 */
> >  		if (llc_cpus) {
> > -			cpu = pick_idle_cpu_from_node(llc_cpus, node, SCX_PICK_IDLE_CORE);
> > +			cpu = scx_pick_idle_cpu(llc_cpus, node,
> > +						SCX_PICK_IDLE_CORE | SCX_PICK_IDLE_NODE);
> 
> You change it from scx_pick_idle_cpu() to pick_idle_cpu_from_node()
> in patch 7 just to revert it back in patch 8...
> 
> You can use scx_pick_idle_cpu() in patch 7 already because
> scx_builtin_idle_per_node is always disabled, and you always
> follow the NUMA_FLAT_NODE path.  Here you will just add the
> SCX_PICK_IDLE_NODE flag. 
> 
> That's the point of separating functionality and control patches. In
> patch 7 you may need to mention explicitly that your new per-node
> idle masks are unconditionally disabled, and will be enabled in the
> last patch of the series, so some following patches will detail the
> implementation.
> 
> >  			if (cpu >= 0)
> >  				goto cpu_found;
> >  		}
> > @@ -533,7 +540,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
> >  	 * Search for any idle CPU in the same LLC domain.
> >  	 */
> >  	if (llc_cpus) {
> > -		cpu = pick_idle_cpu_from_node(llc_cpus, node, 0);
> > +		cpu = scx_pick_idle_cpu(llc_cpus, node, SCX_PICK_IDLE_NODE);
> >  		if (cpu >= 0)
> >  			goto cpu_found;
> >  	}
> > -- 
> > 2.47.1

