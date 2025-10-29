Return-Path: <bpf+bounces-72662-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB523C178E2
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 01:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CB3F3BB2BD
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 00:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0703D2D0C68;
	Wed, 29 Oct 2025 00:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tje16n3h"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF932C15AF;
	Wed, 29 Oct 2025 00:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761697857; cv=none; b=kytZWQCVZ5tg4Z2Mi8TT/U/xBO+mBt/eiJdI0GFW5Wpepf9q5wnJy9rTuLZeGqP89+vQky0YIYK4x3sAx3dcjWZ9ZHFfd2skmA2wrahOwK5AUj2IPXb4C48P/feFZoJYLVFcmHwtrLs4PUpV1JVdVFb758A0WSijZZnp+BjQcLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761697857; c=relaxed/simple;
	bh=xm0R+ATHDvzHxjQgNo1eRW3RnLdNUcIUkvBmiPKhXA0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F9IJM7AHXgSi1dsQPQi7cROn/t3bfxGMFPnEdnErwOI8kTJtk9Ic4prh+86pfjkqo3cMV1iQiUJ9OLzDcGiXha7gCqY9L0wwb2fTwbQ5Oi9ButPMNwXMbGiCLKaFYCeS8sLq20CV/Mz2HRSN1tzmVBFuzh6HlU/jrdL6xtdoJBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tje16n3h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F95BC4CEE7;
	Wed, 29 Oct 2025 00:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761697857;
	bh=xm0R+ATHDvzHxjQgNo1eRW3RnLdNUcIUkvBmiPKhXA0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Tje16n3h9ll1QOkO2D+KriRpR1sR0q8/DpiEQWvPL6DKKmHcbbk2iu9NXN0s1zFch
	 tetGLP+sX15A4hdMXj48XFnu7qnt3PTA2O8aPWilBTFL0C/r4tIvXljG50DSW9PcJ5
	 K/tDD27AZKSSd3ajvK9B4TFKyke5vTSRNeAx2ZeV6K52syEPST0x1+XrZ1ZTeD+Hdn
	 cIFpz0DJoLH5Mw8gvuM0PaK2GcUkOnRwqJXmDnPV8SSo93xdNLn8kOxPam4/nbyVKE
	 sNODggJi00AWhKejh1moVzpDD7PnpP1KxvaSoPMgmciWFwi6QZ/YV/w2z3BISeFHZN
	 5REqTVOIjrlPw==
Date: Tue, 28 Oct 2025 17:30:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 joe@dama.to, willemdebruijn.kernel@gmail.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>, Alexander
 Lobakin <aleksander.lobakin@intel.com>
Subject: Re: [PATCH net-next v2] xsk: add indirect call for xsk_destruct_skb
Message-ID: <20251028173055.17466418@kernel.org>
In-Reply-To: <20251026145824.81675-1-kerneljasonxing@gmail.com>
References: <20251026145824.81675-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 26 Oct 2025 22:58:24 +0800 Jason Xing wrote:
> Since Eric proposed an idea about adding indirect call for UDP and
> managed to see a huge improvement[1], the same situation can also be
> applied in xsk scenario.
> 
> This patch adds an indirect call for xsk and helps current copy mode
> improve the performance by around 1% stably which was observed with
> IXGBE at 10Gb/sec loaded. If the throughput grows, the positive effect
> will be magnified. I applied this patch on top of batch xmit series[2],
> and was able to see <5% improvement from our internal application
> which is a little bit unstable though.
> 
> Use INDIRECT wrappers to keep xsk_destruct_skb static as it used to
> be when the mitigation config is off.

FTR I don't think this code complication is worth "stable 1%" win
on the slowpath. But maybe it's just me so I'll let Paolo decide.

