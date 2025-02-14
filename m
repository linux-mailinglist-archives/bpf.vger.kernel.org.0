Return-Path: <bpf+bounces-51556-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E113A35BC5
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 11:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4375B7A38FD
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 10:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD6622F388;
	Fri, 14 Feb 2025 10:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mWploVjp"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C815820A5FC
	for <bpf@vger.kernel.org>; Fri, 14 Feb 2025 10:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739530094; cv=none; b=N7BTv/ThQuK0NfnbzNnfYSsfnttUORKqyGReDopX0ivwSEwbZc6SIt/fZA3BPI6NFUO4BBu+8m1QB6s7ZycmfkJfFNynWrQqVeb1kFRdVzqgNMU8d/Yf5BJ2Ibmf0fZlR2cujVdy5f9shcQgdW+XgavvzceTikR3E9fR83K9s/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739530094; c=relaxed/simple;
	bh=GNUMrmtDva7R/rOaYeIYN1WZ+Qvx21/yFFlFeASGDjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qqdg/pZRt0LbK/uJuzuYaFbLKKYJAxuxxtefR79XxdaxLluMjevw1l4JTHixqYOTaw941I4kMVikoN73yELjIrrW8ybxsCXpuF5GUjKqHXPPHiuDxyPO5S9M5jNXCH9gCvEpjN3GBoYsJOk0QQKOoC6N10vY5GRZ03s1nuKOK90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mWploVjp; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WdxfnWvxahYr8BCQSQ0VlLGMEnDAgrNc0+/KqqPhuPQ=; b=mWploVjpZ2UrvaY6ISbDJR8H9d
	930IoM/wbnvxUSsLC+cEhQniyVMe9g0ZlwS6I/nXKPIkOinLD258CrKcVYvCB+a+Wj/CWRoRn3OP4
	mAf1e7+dEoJi8bJIHATpp8GJWqj/XI3xGERvLrSJ+sM42liQAu+KueWWpxA9Oid+rl6xKg70Uy/SY
	MCPqSeKPf1qt8xSRa/HpEeUFnzVphkaMu/ouonOj7vwXFM6KM/z1PO+PPrn8Y0gNXG4NyXw1VPa6q
	c20XFUQ/vQ1IVr3v9S8kQwJct5y4mFDstpfiNM8bnljRsp8zPZf3noOCfjLGF4GHnQanULikQboc6
	VjabJugA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1titEo-0000000B3Sb-0bw6;
	Fri, 14 Feb 2025 10:48:02 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2906130050D; Fri, 14 Feb 2025 11:48:01 +0100 (CET)
Date: Fri, 14 Feb 2025 11:48:00 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/3] objtool: Move noreturns.h to a common
 location
Message-ID: <20250214104800.GI21726@noisy.programming.kicks-ass.net>
References: <20250211023359.1570-1-laoar.shao@gmail.com>
 <20250211023359.1570-2-laoar.shao@gmail.com>
 <50d8dd8af3822f63f1a13230e6fa77998f0b713d.camel@gmail.com>
 <20250211161122.ncnrwinacslvyn6k@jpoimboe>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211161122.ncnrwinacslvyn6k@jpoimboe>

On Tue, Feb 11, 2025 at 08:11:22AM -0800, Josh Poimboeuf wrote:

> Also, for objtool we could use something based on your program to
> autogenerate noreturns.h.  Only problem is, objtool doesn't currently
> have a dependency on CONFIG_DEBUG_INFO.  Another option we've considered
> is compiler annotations (or compiler plugins).

But we don't need to re-generate the file on every build, right? We can
have every DBUG_INFO build verify the file is still complete.


