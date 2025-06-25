Return-Path: <bpf+bounces-61613-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 298AAAE9209
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 01:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C04D7B6D85
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 23:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1422F5473;
	Wed, 25 Jun 2025 23:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UodmVyY5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA732D29D7;
	Wed, 25 Jun 2025 23:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750893307; cv=none; b=ixRzdGrvbcT1dQpceOEHczOVKLWbU+aqjbbYtHRlq71twNcbk7/2fuymgyFnuvTlzKpL0zzIP7AQdMmghC8vFUSLt6D/d0WLOtVhTxVDNEWUWU1anBUOcvGJeA1KwcEH/2fmc3CXObjTbFisLMM4zvceG9P5//zEwSA9rdOxk/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750893307; c=relaxed/simple;
	bh=ULpLJIaM9TeysiPeOAcS+WIhV2fOnk1DrQVpGmf26r0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e6EdGOE1c+5Z0r0dUn8MEF95GudXltJ2HfCmn3k9Z1rRsFDky5KulVI+cd4exW+7V71dzNdtw+ljfMoLOR2bNXhGzLw/W/K9eB1DW6ObgaKZrycNCphh2QtPB4Ef+C5p8Muo60g/UBW9+p5cviCVCuuQDizCRWCLBTLsYNPbu5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UodmVyY5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF42C4CEEA;
	Wed, 25 Jun 2025 23:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750893306;
	bh=ULpLJIaM9TeysiPeOAcS+WIhV2fOnk1DrQVpGmf26r0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UodmVyY5VH9Sz5Hxy+Qk6bEH9syQ5IfHG4YR+ADKnsVNpuXPRWAREKVZqv/EUnEfG
	 fePlHbL/wPzx1kh8iYGi42y7ayO3QJBAX2/YW93+g+bAjmqH9KfuwN9VcPz1nRk0di
	 2TOYb+tkYralsp4THivq58cPs2HpxPJUMrJnb9bZwkKmigR4YRt75jnAC0B8vRaagA
	 IJLKj2iTk4rTwgj+vNkUlUpSgijzzjUFI2CRAmAQXYxjjKB4i5FObPEgnw5dURF3mb
	 JFzfmytkWvg5nFlDQKORyFzYqc5CL6+iKMwRRencmg0heAWyEGIzTWJg7zvTf3gWhA
	 chGebt3qJLdAg==
Date: Wed, 25 Jun 2025 13:15:05 -1000
From: Tejun Heo <tj@kernel.org>
To: jake@hillion.co.uk
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Drop kfuncs marked for removal in 6.15
Message-ID: <aFyC-WVI1fkk0rPN@slm.duckdns.org>
References: <20250625-scx-kfunc-cleanup-v1-1-d93335286fd5@hillion.co.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625-scx-kfunc-cleanup-v1-1-d93335286fd5@hillion.co.uk>

On Wed, Jun 25, 2025 at 06:05:46PM +0100, Jake Hillion via B4 Relay wrote:
> From: Jake Hillion <jake@hillion.co.uk>
> 
> sched_ext performed a kfunc renaming pass in 6.13 and kept the old names
> around for compatibility with old binaries. These were scheduled for
> cleanup in 6.15 but were missed. Submitting for cleanup in for-next.
> 
> Removed the kfuncs, their flags, and any references I could find to them
> in doc comments. Left the entries in include/scx/compat.bpf.h as they're
> still useful to make new binaries compatible with old kernels.
> 
> Tested by applying to my kernel. It builds and a modern version of
> scx_lavd loads fine.
> 
> Signed-off-by: Jake Hillion <jake@hillion.co.uk>

Applied to sched_ext/for-6.17.

Thanks.

-- 
tejun

