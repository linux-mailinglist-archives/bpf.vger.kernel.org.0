Return-Path: <bpf+bounces-65453-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB80B23A31
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 22:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 324607B521C
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 20:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C022D0636;
	Tue, 12 Aug 2025 20:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iXwEyuUr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C763413B58B;
	Tue, 12 Aug 2025 20:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755031694; cv=none; b=MsNpAuz1UDiSSOG+WuqPWkLWRY+18DZ5Rp2ucmDpJOvdqTmeOJFFvkWiCI5JKKbPBdA6IE4e7gg81k5rxauzp4i1ZTk390HJ75Z8JTRX3Aa0w4PRA7IaonaXYrcz+xqdtGZvJasUnZJVxt0AD2BVvzzakogcIX3yHgVw/K7Z+As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755031694; c=relaxed/simple;
	bh=OlAKrjKi+FHoGWuz6d6aZG8S0aTidx2jUWsXjgxNNnY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PGMsP/ngyQ07u41dJI7k/SQTLcNyCCYFS2NuSaXEtXwV9Or/D6B7MTuOaa5cVOOhqNif4n789Uspj6hAhuh4ii3D61XIA8o2kvQVA1SmaOlTfBNhH/s5xvpbtx+S71WvpfdR+qmghZx+f8QOk9sbrl/fxyUy63UeH6rizQlg318=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iXwEyuUr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1335BC4CEF0;
	Tue, 12 Aug 2025 20:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755031694;
	bh=OlAKrjKi+FHoGWuz6d6aZG8S0aTidx2jUWsXjgxNNnY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iXwEyuUrq2SThIz4NtCAH+4DOZlfF58FZtwmAIjKeimhK0e9rAESTZ1Oa2zAGaZ06
	 4uMmulzeUoAVZpC6h2+eyZ91S87qJC2+2pz/ALz/gWSaiWnGzRARp/3TCsFtJt3vy6
	 kHnwKAuo8MmbbJDjqbJo+5c9Is2/G8VRyWjfQKD25yIBdToNhfKTCv9OhUjoXSWM4P
	 iBE3HYzixPVVPSlatbZPsGOv5YhtMFgHxp2HLppWWPld3CXpHffEocvDf4mYqJGuBs
	 PlCCIudpvi9U/hyWfOzWWr3i7Stw/K/AEwG9d9jmAcClRAov+pbIzajRq+T0DEAWsf
	 G3SI13RC/Fh9w==
Date: Tue, 12 Aug 2025 13:48:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jiri Slaby
 <jirislaby@kernel.org>, Nick Kossifidis <mickflemm@gmail.com>, Luis
 Chamberlain <mcgrof@kernel.org>, Brian Norris <briannorris@chromium.org>,
 Francesco Dolcini <francesco@dolcini.it>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Johannes Berg
 <johannes.berg@intel.com>, Sascha Hauer <s.hauer@pengutronix.de>, Kalle
 Valo <kvalo@kernel.org>, Aditya Kumar Singh <quic_adisi@quicinc.com>,
 Roopni Devanathan <quic_rdevanat@quicinc.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, intel-wired-lan@lists.osuosl.org (moderated
 list:INTEL ETHERNET DRIVERS), netdev@vger.kernel.org (open list:NETWORKING
 DRIVERS), linux-kernel@vger.kernel.org (open list),
 oss-drivers@corigine.com (open list:NETRONOME ETHERNET DRIVERS),
 linux-wireless@vger.kernel.org (open list:ATHEROS ATH5K WIRELESS DRIVER),
 bpf@vger.kernel.org (open list:XDP (eXpress Data
 Path):Keyword:(?:\b|_)xdp(?:\b|_))
Subject: Re: [PATCH 0/5] net: use vmalloc_array() to simplify code
Message-ID: <20250812134812.298c7d97@kernel.org>
In-Reply-To: <20250812133226.258318-1-rongqianfeng@vivo.com>
References: <20250812133226.258318-1-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Aug 2025 21:32:13 +0800 Qianfeng Rong wrote:
> Remove array_size() calls and replace vmalloc() with vmalloc_array() to
> simplify the code and maintain consistency with existing kmalloc_array()
> usage.

You need to submit the first 3 as a separate series.
They get applied to a different tree than wireless patches.

