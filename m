Return-Path: <bpf+bounces-61231-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAFDAE2988
	for <lists+bpf@lfdr.de>; Sat, 21 Jun 2025 16:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E0B71726A4
	for <lists+bpf@lfdr.de>; Sat, 21 Jun 2025 14:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEEA1E25F2;
	Sat, 21 Jun 2025 14:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zqlv9Q4o"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1E5770FE;
	Sat, 21 Jun 2025 14:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750517006; cv=none; b=aI0lm0diS5a/8zuXJqXCBZBoyzel9Iz3bXfSj+tAAtoYsASyqyLfLETefLDzknviko4IKijLKh4AbPIChQ9Pzq6SmjanmacdrKBeG77vYaZmQtlnHhjWqUXQBRXKi2aYmx7Rc0MImOdUXIBQCP4bOO30ZAMBNwNOjYJBYmDd+c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750517006; c=relaxed/simple;
	bh=3oaiRxyJtUt56IODFrqTXpXDTOsp06hhdQcX0250e+c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VCvsAc+fStAnDfq04TrKiu9mRVt9WMSw84L1Jo4+OZHI1+6As3ijSBnoWub+YSMObBH5asOV5/1Tl8IWSNLo4Lf+0+4Qvq9d5pbp6e1d6uea9v+m3P3gytX75ntwRWSON4EQWpFneEj7yQIalCWXH/XL7lq7n5bW0LyUebyndPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zqlv9Q4o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E290C4CEE7;
	Sat, 21 Jun 2025 14:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750517005;
	bh=3oaiRxyJtUt56IODFrqTXpXDTOsp06hhdQcX0250e+c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Zqlv9Q4o7L8IetOZc/Z5mYnw4dgHpA8VrtftM7m+Qz5yHIo6n93tw0qeHpzIy5N8b
	 rPevbJ20HTGPF58kEr9Nk3lQf9KL1aJscTZXLbhNyGRbYQE40rTG42J+XIeyijH6Lj
	 Oqa9rQAfIT/oD/biCBedp+Qx7YcGfWnaqEBthDOQx2Uy68QHLxoO2PyEp6FO1pLcOp
	 4tLDZWaVJX8BAKrEYP1RALmxgVHQOo1XjzSt1iGGONXMIEoJT/bcxAMKzzgJ64wuWw
	 z+obLkS2mdBafB0bJPOT9VjBS+nqyfw++7g6+2ou0/ZsGlLYYKTcCbWQQVcIQ6Mlwq
	 Oj7US2weSmL5w==
Date: Sat, 21 Jun 2025 07:43:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 joe@dama.to, willemdebruijn.kernel@gmail.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v3] net: xsk: introduce XDP_MAX_TX_BUDGET
 set/getsockopt
Message-ID: <20250621074324.63ab381d@kernel.org>
In-Reply-To: <CAL+tcoA=KQCLdthH3VXPhd-z=sieKQu_xOPgQEzxdy0Mtnycag@mail.gmail.com>
References: <20250619090440.65509-1-kerneljasonxing@gmail.com>
	<20250619080904.0a70574c@kernel.org>
	<CAL+tcoA=KQCLdthH3VXPhd-z=sieKQu_xOPgQEzxdy0Mtnycag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Jun 2025 08:17:48 +0800 Jason Xing wrote:
> > Jason, I think some additions to Documentation/ and quantification of
> > the benefits would be needed as well.  
> 
> Got it.
> 
> #1 Documentation. I would add one small section 'XDP_MAX_TX_BUDGET
> setsockopt' in Documentation/networking/af_xdp.rst.
> 
> #2 quantification
> It's really hard to do so mainly because of various stacks implemented
> in the user-space. AF_XDP is providing a fundamental mechanism only
> and its upper layer is prosperous.

Sorry for the awkward phrase. By "quantification of the benefits"
I meant what performance improvement you have seen from increasing 
this "budget".

