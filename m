Return-Path: <bpf+bounces-52834-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7300CA48E24
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 02:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F48616CA41
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 01:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6B475809;
	Fri, 28 Feb 2025 01:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bh8eo2yH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4046035953;
	Fri, 28 Feb 2025 01:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740707295; cv=none; b=auVzY16zwCKcQOQY7YFKPDoTdmGzTLYB5yRwEPD6KEmphMj2ex0aJ5yV1sxyPLGwF3wMHKJ9TgepMJ8ZlGsFx2CTPvHqaRx9N2/hwy7aA3RKZHjdzZ7O40mApbuDr0Y/6mIZD4XCRLj18WV328QZlGQb5j3/HFJ3bjDEyLEu0No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740707295; c=relaxed/simple;
	bh=BjmmzH/Au8DAGNDCASojsQ3C9P33uMc+Z3Tpdc2Lo1g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ataVwjmzLGyebp8SvGmptC2XQ6smQsuIUP8Hn+Z7H7Fsi4Mcf9CFZKNWMuMh59Yw1OkAiqhaYYLiAdGqzjsoA5+tZuCtAssXnwqTplC2XktZw0CnljO7vc3RcaLwQJP/wz09NaDzxX6ZQ37CdkhgUmwD84Ra5q2govB1GjmvdO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bh8eo2yH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF41C4CEDD;
	Fri, 28 Feb 2025 01:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740707294;
	bh=BjmmzH/Au8DAGNDCASojsQ3C9P33uMc+Z3Tpdc2Lo1g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Bh8eo2yHRBbRfMkXeOCkbJxDaQvEtf60/RyoWsFj7ssICKGqywm2umN6ufAdL2qT3
	 Aq5p2mJ4Fk348BbIinCEykfNLyJz0MWM0ZBt3P1PSWdZAE1TApWSvLVCiuikqKJtCz
	 UI6ntr0+ZqzVck+buqbBfboMG6w4h/SMgmBCGOTdMc5m66nIjGmbCuWxjcKl2VrNop
	 TK7Z5pFLCuXeiXYXChkQfmyeNfX6EcQ5bgsAySpK35Q9y8+cCUJZgn3lrLpKVI3RYj
	 kL3R8ocDkcfJZ7Sacp2cVWG6jEJl4mIRdsORSO1i7khc21fdJ89Mo4+dUXPWB9zixU
	 gIzqcb6QQoWWQ==
Date: Thu, 27 Feb 2025 17:48:12 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: horms@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, ricardo@marliere.net, viro@zeniv.linux.org.uk,
 dmantipov@yandex.ru, aleksander.lobakin@intel.com,
 linux-ppp@vger.kernel.org, linux-kernel@vger.kernel.org, mrpre@163.com,
 syzbot+853242d9c9917165d791@syzkaller.appspotmail.com
Subject: Re: [PATCH net-next v4 1/1] ppp: Fix KMSAN warning by initializing
 2-byte header
Message-ID: <20250227174812.50d2eabe@kernel.org>
In-Reply-To: <20250226013658.891214-2-jiayuan.chen@linux.dev>
References: <20250226013658.891214-1-jiayuan.chen@linux.dev>
	<20250226013658.891214-2-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Feb 2025 09:36:58 +0800 Jiayuan Chen wrote:
> The PPP driver adds an extra 2-byte header to enable socket filters to run
> correctly. However, the driver only initializes the first byte, which
> indicates the direction. For normal BPF programs, this is not a problem
> since they only read the first byte.
> 
> Nevertheless, for carefully crafted BPF programs, if they read the second
> byte, this will trigger a KMSAN warning for reading uninitialized data.
> 
> Reported-by: syzbot+853242d9c9917165d791@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/bpf/000000000000dea025060d6bc3bc@google.com/
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Could you add:

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

And combine the cover letter with the commit message?
For a single-patch postings cover letter is not necessary.

> +		*(__be16 *)skb_push(skb, 2) = htons(PPP_FILTER_OUTBOUND_TAG);
>  		if (ppp->pass_filter &&
>  		    bpf_prog_run(ppp->pass_filter, skb) == 0) {
>  			if (ppp->debug & 1)

The exact same problem seems to be present in ppp_receive_nonmp_frame()
please fix them both.
-- 
pw-bot: cr

