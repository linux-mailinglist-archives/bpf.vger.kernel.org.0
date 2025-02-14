Return-Path: <bpf+bounces-51538-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8747BA35892
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 09:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D17C27A0491
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 08:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4328221DA2;
	Fri, 14 Feb 2025 08:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uyYGl8R1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F669221D96
	for <bpf@vger.kernel.org>; Fri, 14 Feb 2025 08:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739520760; cv=none; b=d3LXY8K1JEvn5SASszye1BWVF+BAhT6SIAU/s9wDBPqWkcBDBD7q1f5jLbNQV3ibWAEczYrexjZ5YhiLPyAQPHTCiZdPTZmO5rojQn2iRlJPa3h0Q1X0tzyqMp/y3GnsxgqrWACO0WSyPoTaJxDl1RDZeJpecKDQO51C6eP+93Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739520760; c=relaxed/simple;
	bh=+PEP/HwkVg88TPc/4rCpcuocZl5jelJALnlbm9kOpIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UNJmTLPV8mdAMc80sT001ual2QY3FkamutkdG6y12Tn2YHd6jV2Auc64taO+om9fIRg6pae0HGx1KzDPoIShG8c/9A269l40qpAh3M4rwcR2U4V5scAs34kz9U2K5okmVLJPFCjBjpUMZiv3a45a5+766bK6Mqxpe9ccZcJ3EE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uyYGl8R1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E316C4CED1;
	Fri, 14 Feb 2025 08:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739520760;
	bh=+PEP/HwkVg88TPc/4rCpcuocZl5jelJALnlbm9kOpIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uyYGl8R1ME/I5zO5pQgnjc3Tvzf49x56uOD7SXKBW+1Xw5FQ0clofnhj/VaKeX0Ai
	 c8fOWhELqtV/wZz/69QlogJzXDOi2akLDQ3T2B3I2eay+hdhqFniuugP29oIlXdHqr
	 mhqRE3GsfX+/zZ2jJQCZ79fHGoUTHRtO4mb2q3QuGeGyY/hUFa8AW15eTPf/kEC4f8
	 ONaQtjd6FB/qtFgW2GNRPxk8Q+mzvRFOmh3SP5BhH9NafLMuec7rkW+U7kujX7fLbX
	 clCyRzmfuArRvyI8o8P+K7g7DaCTbAGvsUEPuvuIlW8aoLU5C9T7BGaqUFQauF3zdp
	 OiKmG8o2MDDPw==
Date: Fri, 14 Feb 2025 00:12:38 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, peterz@infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/3] objtool: Move noreturns.h to a common
 location
Message-ID: <20250214081238.x5iypixqxoxv2tl6@jpoimboe>
References: <20250211023359.1570-1-laoar.shao@gmail.com>
 <20250211023359.1570-2-laoar.shao@gmail.com>
 <20250211155055.q2kequxtplzz47u4@jpoimboe>
 <CALOAHbAjnR5Y-4SD-WUGk0KuYz6aBvEVEQLCv-W3gwfqG1CVyA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbAjnR5Y-4SD-WUGk0KuYz6aBvEVEQLCv-W3gwfqG1CVyA@mail.gmail.com>

On Fri, Feb 14, 2025 at 03:26:40PM +0800, Yafang Shao wrote:
> On Tue, Feb 11, 2025 at 11:50 PM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> >
> > On Tue, Feb 11, 2025 at 10:33:57AM +0800, Yafang Shao wrote:
> > > It will used by bpf to reject attaching fexit prog to functions
> > > annotated with __noreturn.
> > >
> > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > Cc: Josh Poimboeuf <jpoimboe@kernel.org>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > ---
> > >  {tools/objtool => include/linux}/noreturns.h |  0
> > >  tools/include/linux/noreturns.h              | 52 ++++++++++++++++++++
> >
> > Instead of moving the file, please make a copy
> 
> Are you suggesting we keep tools/objtool/noreturns.h as is and simply
> copy it to include/linux/noreturns.h? In other words, the two files
> would be tools/objtool/noreturns.h and include/linux/noreturns.h.

Right.

-- 
Josh

