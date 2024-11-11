Return-Path: <bpf+bounces-44524-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 821309C41AF
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 16:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 398E81F22E45
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 15:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C0F1482F2;
	Mon, 11 Nov 2024 15:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VD2q4V3C"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC5E25777;
	Mon, 11 Nov 2024 15:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731338265; cv=none; b=oedb81omG9wyVcgkPX4SxLKppfVhNhWcPDiSv7YBIuQp1LFsmEgi16mEDO0vGFdbAkSkXiN5cKcPfUdtMr39xDL3KBZmSsyz/WrAYaqYHLaTqKz4AFYGnGwxaLlUaqYlQTN+5sR/jgZf12JeN+tyaoMHKTV2Cciq7RV+lCRE70g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731338265; c=relaxed/simple;
	bh=k75w1qfiXO0fL1kaktNDSe57h1Vzct2emOIenZhdRHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ubMCvFWEra8KdPUKzhHNJgCYFjA2tIFFgofxsAoVkrc9CQ/FCQgXPxp4dzCoY+Wm+/kgDMtCT3VYla3KE1eCD5zFPj7X1oMDbR9ant/22b7+70Kljw+WzRlEPBNuKdg5+H00cZ4wuvw1botOWNrCjN7oZc9qVIc63/di+7Y1q6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VD2q4V3C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C1B7C4CECF;
	Mon, 11 Nov 2024 15:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731338264;
	bh=k75w1qfiXO0fL1kaktNDSe57h1Vzct2emOIenZhdRHs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=VD2q4V3ChyOI31Bhu0Kp5CmcGc4N6fSs+7WeUAideKuKQTW1MhGpZHgAxgby/WkNU
	 7hBqnCXmQJDAF4wZD5CW0UkVPZKzSz8dXi4BIuaXKHRutTYzIc3hkCfRpp7gh1soJZ
	 5OLKPYotVGezl2C1V4KVdGJNiIKPdXdL5+pX5NK9rGn4lPcCyZsnDOFOT8epKZdF/6
	 LQ8i/9PVPvaRQ2H1xAzEShdHn/r3sm9ltXPIsTE4hoCmDR5IIY0KOe/S/iPU92ultP
	 6RmgDb8IQi/Zwo4Zhf8bfUvBU9LpncsutyJuN3JtDzl6VgUDnaF8Y/Da1iS1busmTK
	 J8C8VYgBURR6Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3C3CDCE00C9; Mon, 11 Nov 2024 07:17:44 -0800 (PST)
Date: Mon, 11 Nov 2024 07:17:44 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, kernel test robot <oliver.sang@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>, bpf@vger.kernel.org
Subject: Re: [PATCH rcu 08/15] srcu: Add srcu_read_lock_lite() and
 srcu_read_unlock_lite()
Message-ID: <0726384d-fe56-4f2d-822b-5e94458aa28a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ddf64299-de71-41a2-b575-56ec173faf75@paulmck-laptop>
 <20241015161112.442758-8-paulmck@kernel.org>
 <d07e8f4a-d5ff-4c8e-8e61-50db285c57e9@amd.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d07e8f4a-d5ff-4c8e-8e61-50db285c57e9@amd.com>

On Mon, Nov 11, 2024 at 04:47:49PM +0530, Neeraj Upadhyay wrote:
>  
> > +/**
> > + * srcu_read_unlock_lite - unregister a old reader from an SRCU-protected structure.
> > + * @ssp: srcu_struct in which to unregister the old reader.
> > + * @idx: return value from corresponding srcu_read_lock().
> > + *
> > + * Exit a light-weight SRCU read-side critical section.
> > + */
> > +static inline void srcu_read_unlock_lite(struct srcu_struct *ssp, int idx)
> > +	__releases(ssp)
> > +{
> > +	WARN_ON_ONCE(idx & ~0x1);
> > +	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_LITE);
> > +	srcu_lock_release(&ssp->dep_map);
> > +	__srcu_read_unlock(ssp, idx);
> 
> s/__srcu_read_unlock/__srcu_read_unlock_lite/ ?

Right you are!  I am testing the patch.

The effect of this bug is that srcu_read_unlock_lite() has a needless
memory barrier and fails to check for RCU watching, so not a blazing
emergency.  But it does mean that Andrii was only seeing half of the
performance benefit of using _lite().

							Thanx, Paul

