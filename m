Return-Path: <bpf+bounces-51539-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1ADAA35897
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 09:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9397016AB7E
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 08:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270E6221D9A;
	Fri, 14 Feb 2025 08:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YwgqQogE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D451632C8
	for <bpf@vger.kernel.org>; Fri, 14 Feb 2025 08:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739520891; cv=none; b=cku/8FhVT1FXOoW6xxGXLL2jY/dCHX1ciSQvghMLXsgTDOWmBaPaAdas29j5s0A82K3LzHeu64K6UumFoAgwoYgXhVSCI13nImC3GBow6oWACmI8KrXk2H4a+FIpDe3nBGsUgQwqtYCD6CXvslTSeXMll4V9aNR/tHyGt1nSJYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739520891; c=relaxed/simple;
	bh=VbCvetVGZ8B8T7oEM9KWNk18Yc4FqEmKNIDrIVooY2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UsguNFRn0PCATdI/C6WdaLAeDRev0zsWGv9vNJXMsd1co65W2LsVFj0yr7mpUolasTSBkBN/pVRoqPcqUNnTnUgWE1oRzLvqP9/nxhGqmK92eSmH3RtcsynGqzLGNB+4LfjRfEqllcX8n81nnkgfUpjCDk0jsfQAl4mPJFBbnkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YwgqQogE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB97C4CED1;
	Fri, 14 Feb 2025 08:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739520891;
	bh=VbCvetVGZ8B8T7oEM9KWNk18Yc4FqEmKNIDrIVooY2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YwgqQogE9L4AKsZgzHlZTr9cHDVC45ogl0twq9DRPVMKDQ/b35vEMAIt0WCsYR+od
	 Bx0XrsUQ5i4UD9EHoFO65lyLfzVmKy2WWobVcz7A57+ESV3yqA/mlBNnc17XbDbuvw
	 wj7aXe+0zWmD6UayruVvrlhzJTbrCW1EvUTY9xu3P9t0SkFjFXC3XRCi9B3qnnEh4m
	 JdZvyo1RHxRvL0tvyP+o6K5E46QuZltez8LIxg6lTcv5Qd06Jqn6fWH3jmnzUjoOuo
	 dBkYhWGhKL7NIzmigiP1/Z+wxCYix+WC7fzeEZ2BXOTPkYz04eS+pNFF5PUYgEigGo
	 YIaySouJHyb+w==
Date: Fri, 14 Feb 2025 00:14:49 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, peterz@infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/3] objtool: Move noreturns.h to a common
 location
Message-ID: <20250214081449.akzs34d772344it5@jpoimboe>
References: <20250211023359.1570-1-laoar.shao@gmail.com>
 <20250211023359.1570-2-laoar.shao@gmail.com>
 <50d8dd8af3822f63f1a13230e6fa77998f0b713d.camel@gmail.com>
 <20250211161122.ncnrwinacslvyn6k@jpoimboe>
 <CALOAHbCkpSrCTmEBzS141f+B4Ux3+vEa5u1DgBsDsXUwy9bogQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbCkpSrCTmEBzS141f+B4Ux3+vEa5u1DgBsDsXUwy9bogQ@mail.gmail.com>

On Fri, Feb 14, 2025 at 03:29:43PM +0800, Yafang Shao wrote:
> On Wed, Feb 12, 2025 at 12:11 AM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> > Only problem is, objtool doesn't currently
> > have a dependency on CONFIG_DEBUG_INFO.
> 
> Is there any reason we can't make it dependent on CONFIG_DEBUG_INFO?"

Objtool is enabled by default on x86 and is pretty much required at this
point.  We definitely don't want to force enable CONFIG_DEBUG_INFO as
that will slow the build down considerably.

-- 
Josh

