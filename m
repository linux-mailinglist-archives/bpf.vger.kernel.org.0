Return-Path: <bpf+bounces-51558-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 608CBA35BEF
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 11:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B37C13B0D71
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 10:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F082566C9;
	Fri, 14 Feb 2025 10:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DAm84gtY"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFEB211497
	for <bpf@vger.kernel.org>; Fri, 14 Feb 2025 10:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739530355; cv=none; b=Dpw+geaH4u3iqdYeItzypmxRnur2nu2zi8ftdkMkFc/V8x2XU38zwdVBghAHw74TU6BDdvtwpZ64KzhjW0nYE54JbJq2rJFBmdg36koUB35MASgr0eglTLYevIoistR8r5AUwZeOpQbEJmkbUZfS/496oA7PPYCwGIxfdqIfd/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739530355; c=relaxed/simple;
	bh=0Yj75Jh4sP+wUb1a3PkmosQORweL7wsy5ctFSy5GAC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=plVC2KD//lkxGhJDSku/6o94aIuihBtNCYb3ej/ov+VyKHeeCSRVXcAcvXSlo1t6Sm0q9Q92FHIst5F+OA+ryzq7G6NTIUJYe/4ElkDl3/p2N2gWCT/URUTnOdTvCCVLINHHtWIjuCIOT/+0N+AnI3MAXR9XdXrdjw7f95Q4CEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DAm84gtY; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=3BokTc3vpoD7btJqcivRWmosI9hrm2+/P7YKnt5tP5U=; b=DAm84gtY6hwgMcgZWfZHhxrH7c
	7ya72qqsMM8hnCt4a0YMcubiNqewwhqODIsRJIxS+/zMyAd6jUR18YHvQEFQenLeWaTcqSkNoEBqU
	S6Q7+LbfYN0G1jpIPOiOPeR41gdi6dEzNuR3XARJeoPyifIQbZCzepo8BRuCO2kIWeth72g8oAF9S
	DJBf0BRSubErr/4+KrKGwTnUnCjRFePQ6ytaVqsM5jSDKinRP+Ylqj2Zq1TN0spQCSbbeSIsF7774
	QcfL2vuqJ96d2BkJpXgYvs8Bg3feoX12+FDv24OtgAfcpGQLlJYwd8PihhjgEZ4kaU26hF2gbvLZk
	ApJHkLyw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1titJ4-00000001EZY-04LK;
	Fri, 14 Feb 2025 10:52:26 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DF7A330050D; Fri, 14 Feb 2025 11:52:24 +0100 (CET)
Date: Fri, 14 Feb 2025 11:52:24 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Yafang Shao <laoar.shao@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/3] objtool: Move noreturns.h to a common
 location
Message-ID: <20250214105224.GJ21726@noisy.programming.kicks-ass.net>
References: <20250211023359.1570-1-laoar.shao@gmail.com>
 <20250211023359.1570-2-laoar.shao@gmail.com>
 <50d8dd8af3822f63f1a13230e6fa77998f0b713d.camel@gmail.com>
 <20250211161122.ncnrwinacslvyn6k@jpoimboe>
 <CALOAHbCkpSrCTmEBzS141f+B4Ux3+vEa5u1DgBsDsXUwy9bogQ@mail.gmail.com>
 <20250214081449.akzs34d772344it5@jpoimboe>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250214081449.akzs34d772344it5@jpoimboe>

On Fri, Feb 14, 2025 at 12:14:49AM -0800, Josh Poimboeuf wrote:
> On Fri, Feb 14, 2025 at 03:29:43PM +0800, Yafang Shao wrote:
> > On Wed, Feb 12, 2025 at 12:11 AM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> > > Only problem is, objtool doesn't currently
> > > have a dependency on CONFIG_DEBUG_INFO.
> > 
> > Is there any reason we can't make it dependent on CONFIG_DEBUG_INFO?"
> 
> Objtool is enabled by default on x86 and is pretty much required at this
> point.

x86_64, but yeah, disabling objtool for x86_64 is going to be *really*
hard.

i386 is still limping along without -- mostly because nobody cared
enough to make it work.

> We definitely don't want to force enable CONFIG_DEBUG_INFO as
> that will slow the build down considerably.

This, very much this. Same reason I hardly every use clang to build a
kernel -- just too slow.

