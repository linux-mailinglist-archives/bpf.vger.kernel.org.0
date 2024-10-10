Return-Path: <bpf+bounces-41529-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A348997B26
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 05:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31BE81F22BD0
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 03:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D1118DF74;
	Thu, 10 Oct 2024 03:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJOyfsWB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2D18F6A;
	Thu, 10 Oct 2024 03:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728530250; cv=none; b=cw+mGNR9zXQtjS9shWDkkAcmrTYtM/ncvRD1Bt8DKAG8+XyhB5woUDolKGX0a1P5ipoQnaC1sCgec7Sw3BlGxdMn5i3yS+j60UP7h+ctQOICAxszEy0t2ipeXtATy1QZVhZ7izsBqcTbgqvtc0MdLilOCrnjeKHbpTJL+PUC0NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728530250; c=relaxed/simple;
	bh=VzwwyQY5EM/uXykBFGEkoHJoVmgVBsMoqU98yitb80M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gFI8ZjdX5j8kqvovBhFwwuMI7mE7YInHN2lT8CjxeFYPnhRnn08SD62yy1XddHF3BTMgw6eUD2p6JHqOg61GhcCGEKGT/cgZyfGh2DuDVWwX4ymsEtWHyqtFMLTHxlBYLCakho2fcaJlpBVpftNyPvMkAwdGlZ27pxoYNKNzH5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJOyfsWB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53BCCC4CEC3;
	Thu, 10 Oct 2024 03:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728530249;
	bh=VzwwyQY5EM/uXykBFGEkoHJoVmgVBsMoqU98yitb80M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CJOyfsWBBtrO5BNTSt+T+7pUiBlcwOtP7FU2mLPEUb01lcWOfe9lRJGaNCodSaIut
	 z1TEgEgZLbirM1CuBeWayGjYOS69DlFVWOm3Ck+3XWRbHxL1Hc2GyQ0MtJMvr5+PyX
	 vZTf+81y0p4J70AvJ8ndKT+kOfEk3M/STw9PmYLS8mJIGsp4SmNJMm6697RP0u2Y1f
	 ynUnHBIWAiqVJw/Saot570GfASmfuchZAT1hLhQhNVkrwinCMucJvEPWT0vwT67VEZ
	 jdee3UB6QCgK7Ltum8NR99ZygyDPINcSlvk0S0eOshtVu5kL2g6usFoDIA4eTkl4Wi
	 QwaZYpItCnSaQ==
Date: Wed, 9 Oct 2024 20:17:27 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jiri Olsa <olsajiri@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Juri Lelli <juri.lelli@redhat.com>, bpf <bpf@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"Jose E. Marchesi" <jose.marchesi@oracle.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: NULL pointer deref when running BPF monitor program (6.11.0-rc1)
Message-ID: <20241010031727.zizrnubjrb25w4ex@treble.attlocal.net>
References: <20240816153040.14d36c77@rorschach.local.home>
 <ZsMwyO1Tv6BsOyc-@krava>
 <20240819113747.31d1ae79@gandalf.local.home>
 <ZsRtOzhicxAhkmoN@krava>
 <20240820110507.2ba3d541@gandalf.local.home>
 <Zv11JnaQIlV8BCnB@krava>
 <Zwbqhkd2Hneftw5F@krava>
 <20241010003331.gsanhvqyl5g2kgiq@treble.attlocal.net>
 <20241009205647.1be1d489@gandalf.local.home>
 <20241009205750.43be92ad@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241009205750.43be92ad@gandalf.local.home>

On Wed, Oct 09, 2024 at 08:57:50PM -0400, Steven Rostedt wrote:
> On Wed, 9 Oct 2024 20:56:47 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > I was thinking if something like objtool (could be something else that can
> > read the executable code) and know of where functions are. It could just
> > see if anything tests rdi, rsi, rdx, rcx, r8 or r9 (or their 32 bit
> > alternatives) for NULL before using or setting it.
> > 
> > If it does, then we know that one of the arguments could possibly be NULL.
> 
> Oh, and it only needs to look at functions that are named:
> 
>   trace_event_raw_event_*()

Unfortunately it's not that simple, the args could be moved around to
other registers.  And objtool doesn't have an emulator.

Also it's not clear how that would deal with >6 args, or IS_ERR() as
Jirka pointed out upthread.

-- 
Josh

