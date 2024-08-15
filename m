Return-Path: <bpf+bounces-37302-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E39953C58
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 23:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D88BEB23A70
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 21:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CC314B947;
	Thu, 15 Aug 2024 21:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WO1YinDD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C2CBA53;
	Thu, 15 Aug 2024 21:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723756082; cv=none; b=t2s/IDgIj9O4HCme914+GxtlBcMFOWkwwin6FgMfXlke63FkHIhwBVy2WLPsxtSIsHcgt0NiOm6SmW9PDJu6bAuGaz+0LGAT/8LOgdbaiZlwCBl74IaNIAkVRj9uX7vriOAL5k/JXZM/7o1WELCyBnSrAIa6yfLaR5tFuH/znbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723756082; c=relaxed/simple;
	bh=BgAKQ3CAkdssRwyCBidKG3WBViBdpcMz3i+/zGg1l4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uY9o0dfTcYanhToIvWXl5B76sNkSKVLqPV9d0+MSYoW3QWO/FNDYKWGdMG35nxVAy5mBWdqTVv7MM7DxP+OCmDXiqOj40cNcgPCKdIkLI4eGqalpLR9XFkgOekq9IitNl9YDr27oD3xWysLMTgMK2KwsV9aD7Pm083yCGihRYn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WO1YinDD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7365DC32786;
	Thu, 15 Aug 2024 21:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723756082;
	bh=BgAKQ3CAkdssRwyCBidKG3WBViBdpcMz3i+/zGg1l4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WO1YinDDjKKrMiCxosOq0lnLGAk1NDTUK6Y9o5e9q/qN9Ua23w/1z+lYAu4BXLsSj
	 JWj3eVDDh10IZb6JONBooBdzga/lzyaoAbPxZq0ggmmnSmONye3YtqVWOyjgf6jnu0
	 WVGbnHCqfuMeKoO4KpZ3PbwqEU8hKKfL4jZmYmpvsAeVrpJklCblUKIvdWOS7Pch2w
	 H2B68z5ksZXjcUdGJlqIqlFtKeGLX0G23c5w/bu16mPHj7be8LYtO3/CzBhEeTVxKy
	 brZNI/2xL7dqGEvqzDyVriFx9lWXpBlSYFwko2ew2yHvds6zZK+InyZWik35LrMrPd
	 XlMkxGTc8bzjw==
Date: Thu, 15 Aug 2024 18:07:58 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Brian Norris <briannorris@chromium.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] tools build: Provide consistent build options for fixdep
Message-ID: <Zr5uLlWGUEMYaroE@x1>
References: <20240814173021.3726785-1-agordeev@linux.ibm.com>
 <CA+ASDXMafY_w5Cm5EWS+dUn59kL3d_h4ZBW9w_Hn=7OZ=5n8kQ@mail.gmail.com>
 <ZrzvDb+gitYx3KLL@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <88a67613-9597-4770-b777-51975e163513@leemhuis.info>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88a67613-9597-4770-b777-51975e163513@leemhuis.info>

On Thu, Aug 15, 2024 at 09:03:58AM +0200, Thorsten Leemhuis wrote:
> On 14.08.24 19:53, Alexander Gordeev wrote:
> > On Wed, Aug 14, 2024 at 10:35:00AM -0700, Brian Norris wrote:
> >
> >> FWIW, I already fielded some reports about this, and proposed a very
> >> similar (but not identical) fix:
> >>
> >> https://lore.kernel.org/lkml/20240814030436.2022155-1-briannorris@chromium.org/
> >>
> >> Frankly, I wasn't sure about HOSTxxFLAGS vs KBUILD_HOSTxxFLAGS -- and
> >> that's the difference between yours and mine. If yours works, that
> >> looks like the cleaner solution. So:
> >>
> >> Reviewed-by: Brian Norris <briannorris@chromium.org>
> >>
> >> Either way, it might be good to also include some of these tags if
> >> this is committed:
> >>
> >> Closes: https://lore.kernel.org/lkml/99ae0d34-ed76-4ca0-a9fd-c337da33c9f9@leemhuis.info/
> >> Fixes: ea974028a049 ("tools build: Avoid circular .fixdep-in.o.cmd issues")
> > 
> > Ah, I missed the issue was reported already - I would include these tags otherwise.
> > 
> > @Thorsten, would it be possible to test this fix?
> 
> Yeah, np. This one works as well, so feel free to add:
> 
> Tested-by: Thorsten Leemhuis <linux@leemhuis.info>

Thanks everybody, applied to perf-tools-next,

- Arnaldo

