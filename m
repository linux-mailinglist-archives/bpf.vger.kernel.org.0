Return-Path: <bpf+bounces-44105-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8972E9BDE99
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 07:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D2141F23AEB
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 06:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98ABE1922E5;
	Wed,  6 Nov 2024 06:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b34fdUOB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF801EA84;
	Wed,  6 Nov 2024 06:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730873544; cv=none; b=k/9ix0KBVZqBChtb29aK2PoBCNu9cswoZzOZd2C32xuI9LWPf6Wa9PHCQS6WqZniOcEisUe7Wq2fvU+wvebjB+9ngIJFbnj8vBwLPwkS2iBsF/jpEuMGrSa+dgnkvlCePBgirdHTGImFcNqEeic+yxpxtaNdWrVpfFwc1J516jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730873544; c=relaxed/simple;
	bh=6YQgNFtiYqYiPHsmciPXwphPHzESzeWrJm3U7ilIrSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MpspSJB00xMmtvEWLIHEezrE7kMRN6GZ3CltmEvvEhvx9dLJ1sEdAxsTFpJDvVh/RiI7WmQSFtHB11YuW56EUXQwBdUIq4WUvjuXYUlPO1rieKwL9hRfyKIPuiFbTlbFkoVx0RtJGhfVIFje+0iHu7F/LlYbVpne70CSsnEU8Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b34fdUOB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97B55C4CED4;
	Wed,  6 Nov 2024 06:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730873544;
	bh=6YQgNFtiYqYiPHsmciPXwphPHzESzeWrJm3U7ilIrSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b34fdUOB/EBMFMgL/+qj+JLvj2ezZZ4PTx5joDh+BOvoJ67a0I4yzdUAH1w7dFoow
	 yD3Sp5oWV1yrzmb2aYsn+wwR21/c66xntHFDMkVTJq0szXdP9RfsUDrCfFcXMrY/aj
	 F6cS6fHF07Ldwq+6GyxQIFVgFIP9niNeb1qyE7Zc=
Date: Wed, 6 Nov 2024 07:12:05 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: stable@vger.kernel.org, bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: Fix build ID parsing logic in stable trees
Message-ID: <2024110636-rebound-chip-f389@gregkh>
References: <20241104175256.2327164-1-jolsa@kernel.org>
 <2024110536-agonizing-campus-21f0@gregkh>
 <ZyniGMz5QLhGVWSY@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyniGMz5QLhGVWSY@krava>

On Tue, Nov 05, 2024 at 10:15:04AM +0100, Jiri Olsa wrote:
> On Tue, Nov 05, 2024 at 07:54:48AM +0100, Greg KH wrote:
> > On Mon, Nov 04, 2024 at 06:52:52PM +0100, Jiri Olsa wrote:
> > > hi,
> > > sending fix for buildid parsing that affects only stable trees
> > > after merging upstream fix [1].
> > > 
> > > Upstream then factored out the whole buildid parsing code, so it
> > > does not have the problem.
> > 
> > Why not just take those patches instead?
> 
> I guess we could, but I thought it's too big for stable
> 
> we'd need following 2 changes to fix the issue:
>   de3ec364c3c3 lib/buildid: add single folio-based file reader abstraction
>   60c845b4896b lib/buildid: take into account e_phoff when fetching program headers
> 
> and there's also few other follow ups:
>   5ac9b4e935df lib/buildid: Handle memfd_secret() files in build_id_parse()
>   cdbb44f9a74f lib/buildid: don't limit .note.gnu.build-id to the first page in ELF
>   ad41251c290d lib/buildid: implement sleepable build_id_parse() API
>   45b8fc309654 lib/buildid: rename build_id_parse() into build_id_parse_nofault()
>   4e9d360c4cdf lib/buildid: remove single-page limit for PHDR search
> 
> which I guess are not strictly needed

Can you verify what exact ones are needed here?  We'll be glad to take
them if you can verify that they work properly.

thanks,

greg k-h

