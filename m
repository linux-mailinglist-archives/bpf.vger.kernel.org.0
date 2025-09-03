Return-Path: <bpf+bounces-67336-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D16B42A19
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 21:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52DC43B63E3
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 19:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8E2369350;
	Wed,  3 Sep 2025 19:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BS+sllF6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBE22D374A;
	Wed,  3 Sep 2025 19:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756928674; cv=none; b=VDuF3furFF6uPbhUJ0vgF5oKJCf7fTOlNnkgFWf6AQa2pxgDA/DJ90v6CtO7ExYiVjSaUklHt98mqNWZ0/nos+0J1+kQH/2aD2iMJt3sLxzIrnt27SR8XQyysFTqyMM8hnp4+oVDHU93FEtuW2xilp4baCyWO86Y+ZpQbVPPdXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756928674; c=relaxed/simple;
	bh=UP4T6LM97lFutL/tx/kN2e9+VzBS++vmXMkexWenMgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jmkTb0asn/GPwAXGWFX5z6fa2h8Vvl6N1/kwd4NWW5ovK5SWBf1Ahqi7EGqaWWH/sNp1MKZRbA0BBHDdwmR4LdO7yMXOIxDv77d78r2nzLgGfVX3g94caRPiVu19herAWgW5oraMcq8AMxZ2JMNYBTkO2fe4K/0EbmFBms43e00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BS+sllF6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F0D0C4CEE7;
	Wed,  3 Sep 2025 19:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756928673;
	bh=UP4T6LM97lFutL/tx/kN2e9+VzBS++vmXMkexWenMgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BS+sllF6CI++5IoYBaTZn2THiH7wTjCT0dvDc5+Zs3uweKSXOppCdt4JaAwItM5v/
	 3DoXI0gU/ZqRI/C6tsykwQ23EDIc7kl0cmpQlQ0SnzUCB9C/idvThvT+JOnTQYCi/j
	 yl0hVmzQs1Qyhmr6SvewpKJ4AO/gQokL9qFzZeIjiRIEzpgJ5CaIFWRo5OKrzVz/F4
	 nEzLKQZUW46Izo3rXk/GVa/63WhQ44L9WiA9YYDDsCJFvRXPF+AOHTdgWGBPhkW3mj
	 CX7zDN1mevlgSUh3h8qy4CMX+KWyotVfwBXrw5tkzlO3cslpUsKnpeaErrcclzJ/WQ
	 Mbc8JXsh9utxg==
Date: Wed, 3 Sep 2025 09:44:32 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/16] sched_ext: Exit early on hotplug events during
 attach
Message-ID: <aLiaoEvjBfBsp-tR@slm.duckdns.org>
References: <20250903095008.162049-1-arighi@nvidia.com>
 <20250903095008.162049-2-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903095008.162049-2-arighi@nvidia.com>

Hello,

On Wed, Sep 03, 2025 at 11:33:27AM +0200, Andrea Righi wrote:
>  static int validate_ops(struct scx_sched *sch, const struct sched_ext_ops *ops)
> @@ -5627,11 +5630,15 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
>  		if (((void (**)(void))ops)[i])
>  			set_bit(i, sch->has_op);
>  
> -	check_hotplug_seq(sch, ops);
> -	scx_idle_update_selcpu_topology(ops);
> +	ret = check_hotplug_seq(sch, ops);
> +	if (!ret)
> +		scx_idle_update_selcpu_topology(ops);
>  
>  	cpus_read_unlock();
>  
> +	if (ret)
> +		goto err_disable;

The double testing is a bit jarring. Maybe just add cpus_read_unlock() in
the error block so that error return can take place right after
check_hotplug_seq()? Alternatively, create a new error jump target - e.g.
err_disable_unlock_cpus and share it between here and the init failure path?

Thanks.

-- 
tejun

