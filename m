Return-Path: <bpf+bounces-51860-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D864A3A728
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 20:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E9C8188A185
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 19:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2F81F582A;
	Tue, 18 Feb 2025 19:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bsI/Vc+M"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4931B043A;
	Tue, 18 Feb 2025 19:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739905862; cv=none; b=GS63dxMdWTw3KMcRWUo7f5PUclWjV8DNAVS/YMtRmGbEwxkW3Cxq0wcwC0X+YNIT4CqLv0333nE4ZXv4QM8oEKGZfKHsqKWzINPEOVXHY9m6BgEKhPLiEiCN/XoxFexoPbBljEJwvAc2M0bBNg54vSmo3iTadZkDZacftvZ1SHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739905862; c=relaxed/simple;
	bh=BC9xbGKRvWfL9+6jeV47LW3TbvNlrNDW2dRro2SsLSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQaa7Wp3o3Be34rck/sZzSSVoNOhtvy2C5yTPEXKiY0OAlaKUmHfJ+O5m+6dylwA37HbYYMmVL0Bw/0hleKu1HT0GUaq+6wJj3m/4meZ76iPIgmuhgbQTB1L6zhCriAwYiudThoUzreK3yUZUo4xIqCDe5ux0ZNWNkBwnEI6eAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bsI/Vc+M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC2DC4CEE2;
	Tue, 18 Feb 2025 19:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739905861;
	bh=BC9xbGKRvWfL9+6jeV47LW3TbvNlrNDW2dRro2SsLSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bsI/Vc+MYR87rl5ZU5eFifygvqJCc0Ns776+edmGJwI+njwblxqvrYnpER5Jp8jTt
	 LnVmrFcYIawnuEOFBkU+lB3QIh6sPjsPoRHfK1b2LqCLb/hFCApi4YGIFQE1eCOeLS
	 JSNWCp0hVXjp8Ot6quCy3nPhXaERGEfZAVKjTddo8vdLV5hh6mkTbrnfVP9sSroQW/
	 GyEtlUq73VJXypeEy/hPpa+yZe9d3Gn2BqPVwyno1KlVXhvMNlure7myO7j8TZ/ykJ
	 Zr5uLgiK0PBzM2p5WA5kiDD3HFPDs13EGP9Fgn7rVmCGLkwNthI1d8R8DnZydRNNAn
	 vFguXo7ptsHsQ==
Date: Tue, 18 Feb 2025 09:11:00 -1000
From: Tejun Heo <tj@kernel.org>
To: Yury Norov <yury.norov@gmail.com>
Cc: Andrea Righi <arighi@nvidia.com>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>, Ian May <ianm@nvidia.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-6.15] sched_ext: idle: Introduce node-aware
 idle cpu kfunc helpers
Message-ID: <Z7TbRNkC4xQiUDLa@slm.duckdns.org>
References: <20250218180441.63349-1-arighi@nvidia.com>
 <Z7TZIvaxzEDD2u9A@slm.duckdns.org>
 <Z7Ta9ULl141jcjFF@thinkpad>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7Ta9ULl141jcjFF@thinkpad>

On Tue, Feb 18, 2025 at 02:09:41PM -0500, Yury Norov wrote:
> On Tue, Feb 18, 2025 at 09:01:54AM -1000, Tejun Heo wrote:
> > On Tue, Feb 18, 2025 at 07:04:41PM +0100, Andrea Righi wrote:
> > > Introduce a new kfunc to retrieve the node associated to a CPU:
> > > 
> > >  int scx_bpf_cpu_node(s32 cpu)
> > > 
> > > Add the following kfuncs to provide BPF schedulers direct access to
> > > per-node idle cpumasks information:
> > > 
> > >  const struct cpumask *scx_bpf_get_idle_cpumask_node(int node)
> > >  const struct cpumask *scx_bpf_get_idle_smtmask_node(int node)
> > >  s32 scx_bpf_pick_idle_cpu_node(const cpumask_t *cpus_allowed,
> > >  				int node, u64 flags)
> > >  s32 scx_bpf_pick_any_cpu_node(const cpumask_t *cpus_allowed,
> > >  			       int node, u64 flags)
> > > 
> > > Moreover, trigger an scx error when any of the non-node aware idle CPU
> > > kfuncs are used when SCX_OPS_BUILTIN_IDLE_PER_NODE is enabled.
> > > 
> > > Cc: Yury Norov [NVIDIA] <yury.norov@gmail.com>
> > > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> > 
> > Applied to sched_ext/for-6.15.
> 
> I added my review-by in v12. Can you please add it here?
> 
> Reviewed-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>

Okay, updated.

Thanks.

-- 
tejun

