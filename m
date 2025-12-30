Return-Path: <bpf+bounces-77540-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CA90FCEA9C3
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 21:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A1FC301E18D
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 20:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14659223336;
	Tue, 30 Dec 2025 20:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iith7RyG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819741F95C;
	Tue, 30 Dec 2025 20:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767126720; cv=none; b=PXTGKhwnszl7OtP6trCwAbufEQfCADksvnlbG/xrXeMVmUdSmS4bqsTdzc47E1UK3LxAzeej9RQV5MvoX7I4QxBVk/aimPwCSljzTxjKkqSW4138jysn9xiC9gYlV3nomi/ByxLw7StmfmrCVM3nihkm2T0THIsSh/FeBDZ2YQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767126720; c=relaxed/simple;
	bh=4u5e0fMkjgaUZ1oU9t+Zpd9Xl9tAAI4rsfqfmlUrWe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sNQrbY7Hinbs1nBpYMU8hVX/O/4Q5NUpcOQNUMmfQW+zTi1/FZ1hG4dH0uuk7pUZ00706JkJTsoGsu8mPGbwKmP76AjP5Jrk/GjJLhAi60rokGxybUn6sqY9IDic2FIG0kboOqJoZZDeemXOPYpPW0lk5z+uOEh8VRNHUfkr7kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iith7RyG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB1D1C113D0;
	Tue, 30 Dec 2025 20:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767126720;
	bh=4u5e0fMkjgaUZ1oU9t+Zpd9Xl9tAAI4rsfqfmlUrWe0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Iith7RyGBc4rTzG0IUcLbRungYMUaZ/1vGNIH/UNMWfdZjFj1MQAcXiiKLe1aVARP
	 eLvJPmhQHJ25OLFPeIkcFNAEaeKAx/vYG6TsixJiS1aHQqJgft0j6bFkWpA3CTJnTi
	 DeG6m4sIUXZk4pH9Ys5V33TmC8N+IqtClmbHgokEwbZbbiEAMG7MaFTdvge3eaEbvo
	 HhAaP07lHlz18izsXC6UzQBRCdNsZzLns5NTdKlWd1hxC5xWw/VgH6ezC6MT5JZWPU
	 89X3EYlNHy4ShtN/cgdzyjaWjvsFFLKZlcGovmfunzAv33d5BaG9usprlQ9Foxcj59
	 3jHx6USGUProw==
Date: Tue, 30 Dec 2025 13:31:56 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Nicolas Schier <nsc@kernel.org>, Brian Cain <bcain@kernel.org>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, linux-hexagon@vger.kernel.org
Subject: Re: [PATCH 0/5] kbuild: uapi: improvements to header testing
Message-ID: <20251230203156.GD4062669@ax162>
References: <20251223-uapi-nostdinc-v1-0-d91545d794f7@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251223-uapi-nostdinc-v1-0-d91545d794f7@linutronix.de>

Hi Thomas,

On Tue, Dec 23, 2025 at 08:04:07AM +0100, Thomas Weiﬂschuh wrote:
> Also validate that UAPI headers do not depend on libc and remove the
> dependency on CC_CAN_LINK.
> 
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> ---
> Thomas Weiﬂschuh (5):
>       kbuild: uapi: validate that headers do not use libc
>       hexagon: Drop invalid UAPI header asm/signal.h
>       kbuild: uapi: don't compile test bpf_perf_event.h on xtensa
>       kbuild: uapi: split out command conditions into variables
>       kbuild: uapi: drop dependency on CC_CAN_LINK
> 
>  arch/hexagon/include/{uapi => }/asm/signal.h |  0
>  init/Kconfig                                 |  2 +-
>  usr/include/Makefile                         | 87 +++++++++++++++++++++++++++-
>  3 files changed, 87 insertions(+), 2 deletions(-)

This seems like a great improvement to the UAPI header testing. I don't
see any immediate problems and it works for me in my brief local
testing. I will give a week or so for comments before I apply this to
kbuild-next (plus -next should be operating at that point).

Cheers,
Nathan

