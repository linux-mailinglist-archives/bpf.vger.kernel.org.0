Return-Path: <bpf+bounces-36219-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B5E94488F
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 11:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B4E1287755
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 09:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4EB170A18;
	Thu,  1 Aug 2024 09:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ion0ssjP"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E197916F267;
	Thu,  1 Aug 2024 09:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722504910; cv=none; b=DhwUYGF/PnsSEBCmEX/waHU4ZyK6Fot9EJlyLPYxsZUIyNgL9+y9FKQ9k32m+2nJhVY1GYNG/qGEMfXYZmcxy8U3OOtxgz8GCd5UUBfSyrtiYJKpMapMrJf1Rp2breqteVi8tSqID4DIi0yOU8kp7TQMDDRPGwHrW07GlFeVmbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722504910; c=relaxed/simple;
	bh=ayapRnAa1le9nfXZPiuif0xUtIRAkLKcntn7oOM9diQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L090ppGHGe7PDvPn3/K67h7HP1NXMzO+ctbJBscRQLl8k6mNY7iH8Yo7qUJPOlsRKY+78IJI6l1ve9Ib58w46x88+0UVUMI2L202TlwU2KOLuZi5ywFMaGMPmTVqKt/5xVKka4NqkD4cpt8oMI5VvsmRzvS/ZEEJP8/3Ablqwsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ion0ssjP; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KAh+Y1GaVDxSrqV6y/eFMe2W+Op7o4l23YzOcNg+zOw=; b=Ion0ssjPgSBYM7tuFL823RH36F
	yLhLYla6wE6dnaG9Sk9EG0JLdb8RI7ctWcs36bVuJ8lWPbJuut6bmdqpoOAUdVfsw7AcHpV5NsjoK
	HHAkEGirmeF5/uUzTkCbrMEjXzJwBrpe2Njr0qIhpzJpuGPlX5k5DuSZR961rHd3w/c+LjUsgx3dw
	9BvABmMspvMnCV+2Xr22NFUDaN5J2Y3ETY0Tx+hOGwLatWH4IoIF7WX63t4WayT2kAiDC6cp/I8ub
	GxDgKIB78bOb4q4wpqlPAhw62PVpDm1ar7FmCvvVeRXZ6ADNsy2xQ/YiwHY/nbXNQaoJzihipLYk2
	6I5LFReQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZSDC-0000000HGXy-1vc0;
	Thu, 01 Aug 2024 09:35:06 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F184A30074E; Thu,  1 Aug 2024 11:35:05 +0200 (CEST)
Date: Thu, 1 Aug 2024 11:35:05 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, oleg@redhat.com,
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org
Subject: Re: [PATCH 8/8] uprobes: switch to RCU Tasks Trace flavor for better
 performance
Message-ID: <20240801093505.GP33588@noisy.programming.kicks-ass.net>
References: <20240731214256.3588718-1-andrii@kernel.org>
 <20240731214256.3588718-9-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731214256.3588718-9-andrii@kernel.org>

On Wed, Jul 31, 2024 at 02:42:56PM -0700, Andrii Nakryiko wrote:
> This patch switches uprobes SRCU usage to RCU Tasks Trace flavor, which
> is optimized for more lightweight and quick readers (at the expense of
> slower writers, which for uprobes is a fine tradeof) and has better
> performance and scalability with number of CPUs.
> 
> Similarly to baseline vs SRCU, we've benchmarked SRCU-based
> implementation vs RCU Tasks Trace implementation.

Yes, this one can be the trace flavour, the other one for the retprobes
must be SRCU because it crosses over into userspace. But you've not yet
done that side.

Anyway, I think I can make the SRCU read_{,un}lock() smp_mb()
conditional, much like we have for percpu_rwsem and trace rcu, but I
definitely don't have time to poke at that in the foreseeable future :(

