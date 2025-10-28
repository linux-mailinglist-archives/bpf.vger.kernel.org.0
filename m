Return-Path: <bpf+bounces-72642-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A3DC173E1
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 23:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C6F11C63654
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 22:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CC936A5EE;
	Tue, 28 Oct 2025 22:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQx4NYXw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83443557FE;
	Tue, 28 Oct 2025 22:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761692160; cv=none; b=eP5Ieg2Y9Ey/JDajIeO5dop03bYVhgHJ9EBvm4FAQHxHHbDI4WC3Pg2CG5uyro5nZTMxqsinjNU/CV3pGrRX3zljZGlWS7+BIZilu4wMTGE5WoFqgkX4EBMGRXKtsOAbWn1oP9kFQam+ZjhcXedXXNWrvLGn7fQrKzaFlNpgYdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761692160; c=relaxed/simple;
	bh=Amr5MegNa+GUk0UvEl/vAOGkL8dGnPJ/P9XfcV4DI5A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mkuhJMlKY5vm9MK9CqM6bcB1UQq9su+btUSoStM+1Np8uzc58lGI+zsH2Y8T7rra7LcEJ7DsCdnvPpeI8u0R/o3HoOLGcAyiDMxn0gQEU0tf7ySybXOzUzP8YtkQUmG9XUQsKyK0E30ZEyGivksd+zHD0nB3uUayf7wpYcBM74o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pQx4NYXw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB0CC4CEE7;
	Tue, 28 Oct 2025 22:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761692159;
	bh=Amr5MegNa+GUk0UvEl/vAOGkL8dGnPJ/P9XfcV4DI5A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pQx4NYXw5p42eH3I5MdlpE2SZQ9TlBWUALl/IRqpEuJiJ2PNR+WEr7shApJeDYqN8
	 yfexHRVKQGyprS8YwVauOUXOS514dAQy9wYEpWR5W5L8T3crBB2BtM2jcKIlfj7VVA
	 H9FwkHNIIZIVkM1SGyuqE2tFW2J8V4lw8P1UCK+W3GSR55DCTe63Ml+O19QTuJLaaL
	 3V7iDVLyuw9diUmmtCb4CpSkFJw6PYXZ795aeiW7kTWGr0iDIf7KikfX0UhywAV5AD
	 AJRNKLIIHtK/IgyxcKIGBtLS81vqapK7hIEMgTHQ7sdFCybcjsedzJH8eI2iRCkBNQ
	 dcb5ldsVqCsUw==
Date: Tue, 28 Oct 2025 15:55:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com, sdf@fomichev.me, kerneljasonxing@gmail.com,
 fw@strlen.de
Subject: Re: [PATCH 1/2 bpf v2] xdp: add XDP extension to skb
Message-ID: <20251028155558.7c13b033@kernel.org>
In-Reply-To: <20251028183032.5350-1-fmancera@suse.de>
References: <20251028183032.5350-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Oct 2025 19:30:31 +0100 Fernando Fernandez Mancera wrote:
> This patch adds a new skb extension for XDP representing the number of
> cq descriptors and a linked list of umem addresses.
> 
> This is going to be used from the xsk skb destructor to put the umem
> addresses onto pool's completion queue.

This increases the size of skb extensions and burns a bit in every skb.
Unacceptable for a fallback / slowpath.

