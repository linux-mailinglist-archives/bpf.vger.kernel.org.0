Return-Path: <bpf+bounces-22889-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5CC86B59E
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 18:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F28A285052
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 17:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102763FBB0;
	Wed, 28 Feb 2024 17:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZMvL8zC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120C43FB9D;
	Wed, 28 Feb 2024 17:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709140283; cv=none; b=V+xUVkG5sI2ODFQ3wrKXIDm5C5hbIYfZVcpcZL98zHXhY11mIuj2KLC1aZcGI8pRqP07GRiB3fFT9iMvstUCLx5LHQtXJQhJJmoKaw79lOGqOL9cukHndhBPcBjAWwj+ijVV4jpRqsucKo6h0P9u168wlmKtsEPjaXUncKyMFGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709140283; c=relaxed/simple;
	bh=3ixjbIltYHoDVs7Imn4zX/Im3xOsfQ4dJyhH14FwETI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=uB8Z0RgPQwjgP1fSW6e1cbI/YChnOIh/jApfrpGttwUR94fcs4M6unyqHIEAaj33OLYe7U1MdPN2aFPPa+Rv3XyE7Fd8xS9IBOP64odvBw5vF2TPJrQPdgo9Qdz18sT46Gf4nQCG800YQVX3N1uqO/SAqEOmdRnZhbN23Qyg5Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZMvL8zC; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dc1ff58fe4so144265ad.1;
        Wed, 28 Feb 2024 09:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709140281; x=1709745081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ERuCe3PB4RAvwahCgoveLr57K9P6ykzEm9eQ8lfFFKY=;
        b=VZMvL8zCfY7ZpEYZo0ZHHCw1tCwM5/n/kpW3rq/3M1+l63aPIBJffUFee81gUP0X28
         ZzhQHb+8vY2l1I0ZZMkBbq3os5LPm+xM7lYUv9FHIijXHrDypJXA1M7ROr+7zoEjwB0V
         5GwiZqLp79LrvdMGaiBqXKVwe0ENm2B5XNG3Cp9wuu64onTK5cCWCqFkM4aBhsHtrSdO
         SJQHSqL8zd7vb88QfjGfN72N6xPQlDRyreXSiIpYI4MhsTYDU6GTKmV03/xnIxDHP+dD
         pPHq3GBkTVydiac0t0jx0XwQO42sJUkP/FVPf2aIXTEXwEy2sjPhT5XsTDSm3qr0BrBk
         OF3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709140281; x=1709745081;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ERuCe3PB4RAvwahCgoveLr57K9P6ykzEm9eQ8lfFFKY=;
        b=q+sTt6NyPH9IVe68TBq3Bc56TymbAtXw20fpyAWxP90JTXj7r+iYg8iNW2OPQAG8r2
         jMfrFI0D0SK+Nl6HJ8etpn8igbM6BZg815y3AbAPHQksy2h9myCkzQJft+Rn314kDOFJ
         CnR+0fHHdq+tcpStSajdpQDA4peetYh450iRmbCy5Dgnn6Vx7JwF+q0FxwKD0AZoIhb7
         lricy88UCyvkkjAiSbjkCVZQlin48+wgRKKCPFJVjPuY37fekQmFbwzYi9eaY4LuR/Qk
         rVbsqUyZOpBK6PEEvmud+ZtVr6Cy9n8RMg6sxWB6tc88WUPqfHcGcE2oMzKj+6Ogs+C0
         NEtw==
X-Forwarded-Encrypted: i=1; AJvYcCXqkmfKwZUkIfODTKqIe5VSU9M7L8dfckul5uh/c/6JpViMgYWqxDTRmYzDDvp40oQDpeg90lGNbu52PdcPbbCWxKWqNkRUDW+nGJT4NmWpdfkfD2qtPaIQyVhU
X-Gm-Message-State: AOJu0YwT3WfXrXU5tlTPdJempwCPKLxcPLol7bmlyt2E9/+iJgytLAzn
	kgAyEdOka7nsV9TjhDkt3J6sLgwZrkQ3lOOh7/UsIHaOT/EJ9ttC
X-Google-Smtp-Source: AGHT+IGIeKDfsUPQYIn+n1qGUeY/4CJHWhBRMcbaLHLCU+vkoyGaALc9otx4nPOWd5aMQ1HE/Sd2YA==
X-Received: by 2002:a17:902:8206:b0:1dc:7279:8a3e with SMTP id x6-20020a170902820600b001dc72798a3emr75299pln.21.1709140281019;
        Wed, 28 Feb 2024 09:11:21 -0800 (PST)
Received: from localhost (c-73-157-148-15.hsd1.or.comcast.net. [73.157.148.15])
        by smtp.gmail.com with ESMTPSA id je20-20020a170903265400b001d9b537ad0bsm3542035plb.275.2024.02.28.09.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 09:11:19 -0800 (PST)
Date: Wed, 28 Feb 2024 09:11:17 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>, 
 netdev@vger.kernel.org
Cc: deb.chatterjee@intel.com, 
 anjali.singhai@intel.com, 
 namrata.limaye@intel.com, 
 tom@sipanda.io, 
 mleitner@redhat.com, 
 Mahesh.Shirshyad@amd.com, 
 Vipin.Jain@amd.com, 
 tomasz.osinski@intel.com, 
 jiri@resnulli.us, 
 xiyou.wangcong@gmail.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 vladbu@nvidia.com, 
 horms@kernel.org, 
 khalidm@nvidia.com, 
 toke@redhat.com, 
 daniel@iogearbox.net, 
 victor@mojatatu.com, 
 pctammela@mojatatu.com, 
 dan.daly@intel.com, 
 andy.fingerhut@gmail.com, 
 chris.sommers@keysight.com, 
 mattyk@nvidia.com, 
 bpf@vger.kernel.org
Message-ID: <65df6935db67e_2a12e2083b@john.notmuch>
In-Reply-To: <20240225165447.156954-1-jhs@mojatatu.com>
References: <20240225165447.156954-1-jhs@mojatatu.com>
Subject: RE: [PATCH net-next v12 00/15] Introducing P4TC (series 1)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jamal Hadi Salim wrote:
> This is the first patchset of two. In this patch we are submitting 15 which
> cover the minimal viable P4 PNA architecture.
> 
> __Description of these Patches__
> 
> Patch #1 adds infrastructure for per-netns P4 actions that can be created on
> as need basis for the P4 program requirement. This patch makes a small incision
> into act_api. Patches 2-4 are minimalist enablers for P4TC and have no
> effect the classical tc action (example patch#2 just increases the size of the
> action names from 16->64B).
> Patch 5 adds infrastructure support for preallocation of dynamic actions.
> 
> The core P4TC code implements several P4 objects.
> 1) Patch #6 introduces P4 data types which are consumed by the rest of the code
> 2) Patch #7 introduces the templating API. i.e. CRUD commands for templates
> 3) Patch #8 introduces the concept of templating Pipelines. i.e CRUD commands
>    for P4 pipelines.
> 4) Patch #9 introduces the action templates and associated CRUD commands.
> 5) Patch #10 introduce the action runtime infrastructure.
> 6) Patch #11 introduces the concept of P4 table templates and associated
>    CRUD commands for tables.
> 7) Patch #12 introduces runtime table entry infra and associated CU commands.
> 8) Patch #13 introduces runtime table entry infra and associated RD commands.
> 9) Patch #14 introduces interaction of eBPF to P4TC tables via kfunc.
> 10) Patch #15 introduces the TC classifier P4 used at runtime.
> 
> Daniel, please look again at patch #15.
> 
> There are a few more patches (5) not in this patchset that deal with test
> cases, etc.
> 
> What is P4?
> -----------
> 
> The Programming Protocol-independent Packet Processors (P4) is an open source,
> domain-specific programming language for specifying data plane behavior.
> 
> The current P4 landscape includes an extensive range of deployments, products,
> projects and services, etc[9][12]. Two major NIC vendors, Intel[10] and AMD[11]
> currently offer P4-native NICs. P4 is currently curated by the Linux
> Foundation[9].
> 
> On why P4 - see small treatise here:[4].
> 
> What is P4TC?
> -------------
> 
> P4TC is a net-namespace aware P4 implementation over TC; meaning, a P4 program
> and its associated objects and state are attachend to a kernel _netns_ structure.
> IOW, if we had two programs across netns' or within a netns they have no
> visibility to each others objects (unlike for example TC actions whose kinds are
> "global" in nature or eBPF maps visavis bpftool).

[...]

Although I appreciate a good amount of work went into building above I'll
add my concerns here so they are not lost. These are architecture concerns
not this line of code needs some tweak.

 - It encodes a DSL into the kernel. Its unclear how we pick which DSL gets
   pushed into the kernel and which do not. Do we take any DSL folks can code
   up?
   I would prefer a lower level  intermediate langauge. My view is this is
   a lesson we should have learned from OVS. OVS had wider adoption and
   still struggled in some ways my belief is this is very similar to OVS.
   (Also OVS was novel/great at a lot of things fwiw.)

 - We have a general purpose language in BPF that can implement the P4 DSL
   already. I don't see any need for another set of code when the end goal
   is running P4 in Linux network stack is doable. Typically we reject
   duplicate things when they don't have concrete benefits.

 - P4 as a DSL is not optimized for general purpose CPUs, but
   rather hardware pipelines. Although it can be optimized for CPUs its
   a harder problem. A review of some of the VPP/DPDK work here is useful.

 - P4 infrastructure already has a p4c backend this is adding another P4
   backend instead of getting the rather small group of people to work on
   a single backend we are now creating another one.

 - Common reasons I think would justify a new P4 backend and implementation
   would be: speed efficiency, or expressiveness. I think this
   implementation is neither more efficient nor more expressive. Concrete
   examples on expressiveness would be interesting, but I don't see any.
   Loops were mentioned once but latest kernels have loop support.

 - The main talking point for many slide decks about p4tc is hardware
   offload. This seems like the main benefit of pushing the P4 DSL into the
   kernel. But, we have no hw implementation, not even a vendor stepping up
   to comment on this implementation and how it will work for them. HW
   introduces all sorts of interesting problems that I don't see how we
   solve in this framework. For example a few off the top of my head:
   syncing current state into tc, how does operator program tc inside
   constraints, who writes the p4 models for these hardware devices, do
   they fit into this 'tc' infrastructure, partial updates into hardware
   seems unlikely to work for most hardware, ...

 - The kfuncs are mostly duplicates of map ops we already have in BPF API.
   The motivation by my read is to use netlink instead of bpf commands. I
   don't agree with this, optimizing for some low level debug a developer
   uses is the wrong design space. Actual users should not be deploying
   this via ssh into boxes. The workflow will not scale and really we need
   tooling and infra to land P4 programs across the network. This is orders
   of more pain if its an endpoint solution and not a middlebox/switch
   solution. As a switch solution I don't see how p4tc sw scales to even TOR
   packet rates. So you need tooling on top and user interact with the
   tooling not the Linux widget/debugger at the bottom.

 - There is no performance analysis: The comment was functionality before
   performance which I disagree with. If it was a first implementation and
   we didn't have a way to do P4 DSL already than I might agree, but here
   we have an existing solution so it should be at least as good and should
   be better than existing backend. A software datapath adoption is going
   to be critically based on performance. I don't see taking even a 5% hit
   when porting over to P4 from existing datapath.

Commentary: I think its 100% correct to debate how the P4 DSL is
implemented in the kernel. I can't see why this is off limits somehow this
patch set proposes an approach there could be many approaches. BPF comes up
not because I'm some BPF zealot that needs P4 DSL in BPF, but because it
exists today there is even a P4 backend. Fundamentally I don't see the
value add we get by creating two P4 pipelines this is going to create
duplication all the way up to the P4 tooling/infra through to the kernel.
From your side you keep saying I'm bike shedding and demanding BPF, but
from my perspective your introducing another entire toolchain simply
because you want some low level debug commands that 99% of P4 users should
not be using or caring about.

To try and be constructive some things that would change my mind would
be a vendor showing how hardware can be used. This would be compelling.
Or performance showing its somehow gets a more performant implementation.
Or lastly if the current p4c implementation is fundamentally broken
somehow.

Thanks
John

