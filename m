Return-Path: <bpf+bounces-34397-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CE692D49C
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 16:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86940B234F0
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 14:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E89B194094;
	Wed, 10 Jul 2024 14:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WKNn1fpw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EF61DDC5;
	Wed, 10 Jul 2024 14:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720623381; cv=none; b=IvdZJCDyxWYMNTgVHPbd4YkjfVRpVhEMALyzNAdqF8lcrIyVF0SXv0ssciBExX5zyYeRBO4L5hyhRAWUKfkVC5by3AYc6j6HDrAoPAhIU/e4tWSOENrd7z9PGw2BVKtpKSQbJG5egdqATJitH5uewFUYl6XHC0plcM65clmJZtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720623381; c=relaxed/simple;
	bh=tnbDTbpHQOnSqTuFAT5Bl6MvUDU4H/kU92kC2+0SVuk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=m8el30ezsnitl1aHiO26SziUZe6Yj6RQSPSt6Xj13ZS2+/AHtZNNv/dNFqCG0Csrnk7VZ8GJU8yrVx88UQWe+rAPPC31Dd77A7JxVGxCra0xXxczdgyPs8415WTVi7ntnwoHz4tCID0Lk6+ae7mp4eOM0k/AY4iFin7hI9ojKvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WKNn1fpw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9069CC4AF09;
	Wed, 10 Jul 2024 14:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720623381;
	bh=tnbDTbpHQOnSqTuFAT5Bl6MvUDU4H/kU92kC2+0SVuk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WKNn1fpwU6pWrI+mMptruQDzqTuI/k9lf327zPjejidU1V7jMeo8fg4H/ZETuV+xK
	 2kOC6vrMGp9sa5FxbzrODl8huXQ52+qTLpvcbcEzOCWz+f6bYi8y6gNbUq/GJlwPMN
	 rlSxpOZPgFjVITcs/KpJ+SDTyT/LN7TekT8gn+AcuAmdGxGHASJ2dwsJ0Kwt6PIizW
	 sMcOEPCyQro6CavdI3rORtHzILJFJhnBnMJ5pW5TniBS3/BuSnbV2nD/ZaknEHQC0Y
	 XnLv/9JmwLsHgN41pl3tI2CE/aeeTW9p+THXAn7O2gbZwHwPcN1lYaYWjV/njXgHVp
	 jC99YzU/Q2iVA==
Date: Wed, 10 Jul 2024 23:56:16 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Andrii Nakryiko
 <andrii.nakryiko@gmail.com>, mingo@kernel.org, andrii@kernel.org,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org, oleg@redhat.com,
 clm@meta.com, paulmck@kernel.org, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH 00/10] perf/uprobe: Optimize uprobes
Message-Id: <20240710235616.5a9142faf152572db62d185c@kernel.org>
In-Reply-To: <20240710101003.GV27299@noisy.programming.kicks-ass.net>
References: <20240708091241.544262971@infradead.org>
	<20240709075651.122204f1358f9f78d1e64b62@kernel.org>
	<CAEf4BzY6tXrDGkW6mkxCY551pZa1G+Sgxeuex==nvHUEp9ynpg@mail.gmail.com>
	<20240709090304.GG27299@noisy.programming.kicks-ass.net>
	<Zo0KX1P8L3Yt4Z8j@krava>
	<20240709101634.GJ27299@noisy.programming.kicks-ass.net>
	<20240710071046.e032ee74903065bddba9a814@kernel.org>
	<20240710101003.GV27299@noisy.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jul 2024 12:10:03 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Jul 10, 2024 at 07:10:46AM +0900, Masami Hiramatsu wrote:
> 
> > > FFS :-/ That touches all sorts and doesn't have any perf ack on. Masami
> > > what gives?
> > 
> > This is managing *probes and related dynamic trace-events. Those has been
> > moved from tip. Could you also add linux-trace-kernel@vger ML to CC?
> 
> ./scripts/get_maintainer.pl -f kernel/events/uprobes.c
> 
> disagrees with that, also things like:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git/commit/?h=probes/for-next&id=4a365eb8a6d9940e838739935f1ce21f1ec8e33f
> 
> touch common perf stuff, and very much would require at least an ack
> from the perf folks.

Hmm, indeed. I'm OK to pass those patches (except for trace_uprobe things)
to -tip if you can.

> 
> Not cool.

Yeah, the probe things are boundary.
BTW, IMHO, there could be dependency issues on *probes. Those are usually used
by ftrace/perf/bpf, which are managed by different trees. This means a series
can span multiple trees. Mutually reviewing is the solution?

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

