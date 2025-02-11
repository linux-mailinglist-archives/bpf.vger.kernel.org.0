Return-Path: <bpf+bounces-51147-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C17BA30E0D
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 15:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97AF91885DE7
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 14:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E4124CEE0;
	Tue, 11 Feb 2025 14:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMiBQlsq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B298326BD81;
	Tue, 11 Feb 2025 14:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739283597; cv=none; b=ge3BJM61YhmoyjY6Fg3OwGZSv9CAasjZzwk8AM/o8Vdv6lGn7+wF+tpEnBEKqi+reLlxOcDaBq+xd3yUXyZCgZAFobmlYlI7usZEdd2buOpQ+Oy8pehloSqQvRJfBs54Y2br8X/zbmPQ/x/oMJukqLSmXTZmFBptVndcFdudMOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739283597; c=relaxed/simple;
	bh=9MU8B4Zf/sssug2V4L9tuSKzfCjLkDsIxE5odcilTvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kO7GDJrTUUM1//hGEH70gpXlnZyYAw+lybbReU98iheRPdAB/JlYjc2D9SUL/iK+tW6Li57+0XOPtQ4SLZn9vFZTkkXSe833ho7l29MDZQ57yHypHvlzyJEZGIC5ouQ9WTRuc/FmJ2dHoTrYejbKRF7LBjlAkhQPAWsh6Tfd24Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMiBQlsq; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21f53ad05a0so68991165ad.3;
        Tue, 11 Feb 2025 06:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739283595; x=1739888395; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1agFsb596cmb7w+8srnvvBsWS62p0CbY0pcV23aPyFs=;
        b=TMiBQlsqpKFjt5e7LNyoR2sjqt+AmxWb3fPLX7P+/Z9K9RdqBTU8SLDIHHs1caEXgs
         B2IdyKPZAjuGYxSbbcNU5PoIobIfm+8Sx22tSGpJlZFVpZ2bOg/53rBHeOJvsnk+c8PY
         IrGnhYiB2+3+NIyVmQ1BT1MyIPoY9t60HBi6NKSMi5ezB1SMSu5OAG/gMSKbTNCu7ziV
         QWAUBob91zVuDp1p+cVXORddJPPizTac84hmErlbFGtFE3zy/yS8PcZK13b41fS7+dZV
         6oG4DiIpNNdCYmPKTdLm/zak+22IbrukByoM9O4GiRryJhj+bIzMffNLIT0o6dZ81en7
         28Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739283595; x=1739888395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1agFsb596cmb7w+8srnvvBsWS62p0CbY0pcV23aPyFs=;
        b=tGCYP1o6GVEP4i91A5HMW2S00hqcKNXYAXeUgdkmjJyPbyN3xqk1uB4uOsbvUeQ8HR
         7GSpXE1kZCj+BbuDW6iuq57N9QWHdeyzWVmGEnldpbhXYstT11T1YdafcnTmWtcr0YCv
         w72xaiaCBN6NWNPMPomCTyUsSuc2giHOv3k062mkjyeUGGOgQf9thlG3VW1ci0W4fctr
         1hZCtxJCR82QmKLYn4F2Alz21KH3KS8Jiz3gMCicaZK/D1WAGpolwIcfdUezHbzc0nvP
         6r776XnanA6Fhi7ZUjA1I++WBKjJ2zetqyA6xwzUcA76ChTnOf80cF0dgMma7FHU1xPF
         i0Zg==
X-Forwarded-Encrypted: i=1; AJvYcCVNAhj0wdd400aQtGMl5VxaeWiOXisdDjIQ+ZYMRijSszWN0cibIhCI7TKa9pQrJ0a2fDs=@vger.kernel.org, AJvYcCX5gbGcfPGKclONBHW5TKXWSm3N55AYjAVBD6iUpvdU+VOr3ZzlhFjXe9xTX+tPjsXJfC1tdsmY6pqmodZw@vger.kernel.org
X-Gm-Message-State: AOJu0YxlG1SdFWmQxiad8mmpRCBOayiKCh36mrnVaFtdNWr4aGstxACV
	ezWbrMBNMY1SFMhWl7+DxYZxYh3U//YtCTO5UbLhq1rUw+jqomkG
X-Gm-Gg: ASbGncuP/D0NEhlM3krmtokntNWkaNVAe4qighn6pjHBM6BYsZtIY+mj6GJwGM6mg4k
	xFfcnCmXJEDFi+nrt57GjerY7a/FiyPxOOPv0Qk9c1EHGDF46Fo+TqMD4Nqzjj7JPp1s9mWxkVF
	vFAV8Hxo9NjK9C0dYfZiATFvSS9bE7TPAt5luZgm4Re+k66YyfRKdy/sY3vPcu+O84CoTgh3gMb
	1qjNm09ZzQq5yWup+VDo3vbez8IKUFVXdm65E5Hxwidwbi16UdnXJCTSyVPWaB+kGxp2Tl2ZbYJ
	o1yO56AMN3dXPWg=
X-Google-Smtp-Source: AGHT+IE48JuX3nPPLzhsj9EAcEo6AShv7US7cecHIDUEyOdtEqptcml0fXqMZO/fDCCntN8pDpyWrw==
X-Received: by 2002:a17:902:ecc1:b0:216:4c88:d939 with SMTP id d9443c01a7336-21fb64a81a8mr58785785ad.38.1739283594851;
        Tue, 11 Feb 2025 06:19:54 -0800 (PST)
Received: from localhost ([216.228.125.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3653babfsm96602005ad.68.2025.02.11.06.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 06:19:54 -0800 (PST)
Date: Tue, 11 Feb 2025 09:19:52 -0500
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
Subject: Re: [PATCH 5/6] sched_ext: idle: Per-node idle cpumasks
Message-ID: <Z6tciKa58iqWZ3eM@thinkpad>
References: <20250207211104.30009-1-arighi@nvidia.com>
 <20250207211104.30009-6-arighi@nvidia.com>
 <Z6ju7vFK5TpJamn5@thinkpad>
 <Z6owBvYiArjXvIGC@thinkpad>
 <Z6r9H6JukZi19dQP@gpd3>
 <Z6r_NZui9GibrQHY@gpd3>
 <Z6sddk2otmAVrfcb@gpd3>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6sddk2otmAVrfcb@gpd3>

On Tue, Feb 11, 2025 at 10:50:46AM +0100, Andrea Righi wrote:
> On Tue, Feb 11, 2025 at 08:41:45AM +0100, Andrea Righi wrote:
> > On Tue, Feb 11, 2025 at 08:32:51AM +0100, Andrea Righi wrote:
> > > On Mon, Feb 10, 2025 at 11:57:42AM -0500, Yury Norov wrote:
> > > ...
> > > > > > +/*
> > > > > > + * Find the best idle CPU in the system, relative to @node.
> > > > > > + */
> > > > > > +s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, int node, u64 flags)
> > > > > > +{
> > > > > > +	nodemask_t unvisited = NODE_MASK_ALL;
> > > > 
> > > > This should be a NODEMASK_ALLOC(). We don't want to eat up too much of the
> > > > stack, right?
> > > 
> > > Ok, and if I want to initialize unvisited to all online nodes, is there a
> > > better than doing:
> > > 
> > >   nodemask_clear(*unvisited);
> > >   nodemask_or(*unvisited, *unvisited, node_states[N_ONLINE]);
> > > 
> > > We don't have nodemask_copy() right?
> > 
> > Sorry, and with that I mean nodes_clear() / nodes_or() / nodes_copy().
> 
> Also, it might be problematic to use NODEMASK_ALLOC() here, since we're
> potentially holding raw spinlocks. Maybe we could use per-cpu nodemask_t,
> but then we need to preempt_disable() the entire loop, since
> scx_pick_idle_cpu() can be be called potentially from any context.
> 
> Considering that the maximum value for NODE_SHIFT is 10 with CONFIG_MAXSMP,
> nodemask_t should be 128 bytes at most, that doesn't seem too bad... Maybe
> we can accept to have it on the stack in this case?

If you expect calling this in strict SMP lock-held or IRQ contexts, You
need to be careful about stack overflow even mode. We've got GFP_ATOMIC
for that:
     non sleeping allocation with an expensive fallback so it can access
     some portion of memory reserves. Usually used from interrupt/bottom-half
     context with an expensive slow path fallback.

Check Documentation/core-api/memory-allocation.rst for other options.
You may be interested in __GFP_NORETRY as well.

Thanks,
Yury

