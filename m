Return-Path: <bpf+bounces-49582-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3528CA1A83D
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 17:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3B4E188C0FB
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 16:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9850153BF8;
	Thu, 23 Jan 2025 16:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFSefZzm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B93C1448E4;
	Thu, 23 Jan 2025 16:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737651480; cv=none; b=f07ButX9PjlITbOEwqxvFn5A9Sv8DgMm4mhV1oWnfXMk8iiEeVTpFfymP8rJS1DtCKmDG/XKhtc1gIhtwwVJnxXEUo2tDtj8aH9xALmFQBTWClwjvyqdNPSzIX5rkaVcwVynmY+tvWRo2NVczb+OdOMwPT+KGgHGeP1cCaFqYwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737651480; c=relaxed/simple;
	bh=EdXDKN8/jMZQwOGQrsZ+xLxPyNE7bcYwLF1/RYlZH7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cEC96p+MAV6E6fXmC9f7IRuhHxFI+wPrYCDqq6LaJQWLywjkO9qaHqU2j8+V9FrXuxIm18vM4jfqmgpIw5bGqJ6OqTN9Z8l0q65vsHUdDTM7z2wO1V4Pmbz3vQT8+yUu9JbTLtV/qmro/uKpmcL9G+Dr9v1lqVog64oNiV/BKGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFSefZzm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5DB5C4CED3;
	Thu, 23 Jan 2025 16:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737651479;
	bh=EdXDKN8/jMZQwOGQrsZ+xLxPyNE7bcYwLF1/RYlZH7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KFSefZzmyaV1WMbwvRCeQO786yKLVIySpS+nhmQIwP2/tq7PtbNg0OMqlMMCcy68u
	 VIfksw9J0XAOKaPcBOQbNz8PE87ia+SlfHJ4uko9BVal4F2/TLUxmsyipz6hV48x7n
	 /j4fZlrcgd7NPA6UWWn4mnkt66/7OnegdWu6R7Az9iBBktjn964a9E9W49mpW7Czt+
	 RUAANPr/8vxUj38gJ+vsofUXgHkqhGRv97EcEq38clP9d6KLrWLyNBI4g6FKbKUPvC
	 b0lQ7NY5cUwLiyGNLMfT32lWkAKjalicMFsgIaOx2+jgLBNd2/p0ED4iJPrjA/DLCK
	 RxJzMaYodygAw==
Date: Thu, 23 Jan 2025 06:57:58 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Ihor Solodrai <ihor.solodrai@pm.me>, sched-ext@meta.com,
	kernel-team@meta.com, linux-kernel@vger.kernel.org,
	bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH sched_ext/for-6.13-fixes] sched_ext: Fix dsq_local_on
 selftest
Message-ID: <Z5J1Ft2YwSRpedzx@slm.duckdns.org>
References: <Z1n9v7Z6iNJ-wKmq@slm.duckdns.org>
 <SJEarr1ol1z7N83mqHJjBmpXcXgHNnnuORHfziWINcHBQCJzY0RczexPKxdq_vE5cDYPeO3bx1RdsNhLqw5UYI40HSX9cPZ9rdmebYwwAP8=@pm.me>
 <HdoCQccNk3GZdnPx5w1vuAfOMMgtWeUgrUhn_e8B-hyRrWoOPakTGcoI3Q4-QmK_44msuvivoRUykxxeB82uR-S3enkmFaQl2t6Zgu-Nq6Y=@pm.me>
 <Z2MV001RfiG7DNqj@slm.duckdns.org>
 <ouIylyHgXTVZ9RiyVeHZ26YXQLKMEKHoOVPWIgpWRDD2FL2RDwwUEocaj4LMpMR3PjbwpPuxEnJAjMeD4e7LnWIAYvIbGC5BPvPGtzyumYk=@pm.me>
 <Z2tNK2oFDX1OPp8C@slm.duckdns.org>
 <QHB1r-3fBPQIaDS8iz26J-zoMbn3O6VLlwlZP1NQdkMzlQTsCX_xrfTPBoGt6SQOGgtg6vN7aXles4CndepTvjIVQ7bVXDBrvPaiRH5R8tc=@pm.me>
 <Z5BMkyJ8I7cth1GH@slm.duckdns.org>
 <m94EAn-xiPWJ1dRFTqcm6urBNNOPza94BmyYvp_5ti06uAZF0Izg2mBC9rpbc3PEfWWvDf7UyDt1x_2gB-7y3esTH3f54s05QBxcTXh4YhQ=@pm.me>
 <Z5IOpOD9cs2fLaIg@gpd3>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z5IOpOD9cs2fLaIg@gpd3>

On Thu, Jan 23, 2025 at 10:40:52AM +0100, Andrea Righi wrote:
> On Wed, Jan 22, 2025 at 07:10:00PM +0000, Ihor Solodrai wrote:
> > 
> > On Tuesday, January 21st, 2025 at 5:40 PM, Tejun Heo <tj@kernel.org> wrote:
> > 
> > > 
> > > 
> > > Hello, sorry about the delay.
> > > 
> > > On Wed, Jan 15, 2025 at 11:50:37PM +0000, Ihor Solodrai wrote:
> > > ...
> > > 
> > > > 2025-01-15T23:28:55.8238375Z [ 5.334631] sched_ext: BPF scheduler "dsp_local_on" disabled (runtime error)
> > > > 2025-01-15T23:28:55.8243034Z [ 5.335420] sched_ext: dsp_local_on: SCX_DSQ_LOCAL[_ON] verdict target cpu 1 not allowed for kworker/u8:1[33]
> > > 
> > > 
> > > That's a head scratcher. It's a single node 2 cpu instance and all unbound
> > > kworkers should be allowed on all CPUs. I'll update the test to test the
> > > actual cpumask but can you see whether this failure is consistent or flaky?
> > 
> > I re-ran all the jobs, and all sched_ext jobs have failed (3/3).
> > Previous time only 1 of 3 runs failed.
> > 
> > https://github.com/kernel-patches/vmtest/actions/runs/12798804552/job/36016405680
> 
> Oh I see what happens, SCX_DSQ_LOCAL_ON is (incorrectly) resolved to 0.
> 
> More exactly, none of the enum values are being resolved correctly, likely
> due to the CO:RE enum refactoring. There’s probably something broken in
> tools/testing/selftests/sched_ext/Makefile, I’ll take a look.

Yeah, we need to add SCX_ENUM_INIT() to each test. Will do that once the
pending pull request is merged. The original report is a separate issue tho.
I'm still a bit baffled by it.

Thanks.

-- 
tejun

