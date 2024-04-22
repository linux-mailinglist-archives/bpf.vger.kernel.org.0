Return-Path: <bpf+bounces-27422-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C228ACDCD
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 15:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 881D6B20BC0
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 13:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B42414F12A;
	Mon, 22 Apr 2024 13:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ANvLJA7b"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93B2145342;
	Mon, 22 Apr 2024 13:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713791278; cv=none; b=L/YRBOeXP2tJg+4UnpXHLzFvycBZZfdmf4zspUvG0R+6z9xVH+W/9SveMrOWaoFBPhVdOs5u7pZd29/LW8CACct3l062Zi/I6oaz2rez6IDCZgsAWoWWkp4Hgc/Cowrxs6vNxXngC8Zh1vIEbyNo8KFJAMj4I1I0dP4TcTR3iFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713791278; c=relaxed/simple;
	bh=yfG+kUmCzNShwqakh8yn3JA3rJOrIkdZFg2+CO25P+o=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=siINBYeDLZh14tvX/T+gr8FqYUrrYwejMetow3ulvIQJRorneb2hVGT3rjbLWS2nlWbc1iduG9Kb8oxoM5BfBIesKDNkjeiJrrhgBEuUpEI3hbpH9drZiwf4Rgz4cP/IyUxd6buA0V9hz7VrDTxMPt9a30UEfe72CZDGwwY5Qh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ANvLJA7b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 030FDC113CC;
	Mon, 22 Apr 2024 13:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713791277;
	bh=yfG+kUmCzNShwqakh8yn3JA3rJOrIkdZFg2+CO25P+o=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=ANvLJA7biQ9f6pkY5lJrJl+ZcdKSSALWrgT6llVYoiv35Imd5Zo+H6zpMIL/usbEP
	 1zY8AXLDhqhHe7DxBNq8Zp0YnkFut7iq5c0imJAMyYh1Q70pIFczPuHmPwF5W7FL98
	 cB+67aE+2KWePsmpE1Ku9uFhBf0Tnje6fjv2cYExqBdfG4ycIkkaCdVx8MMguXMIvi
	 YHTSMeeN19NHzEDZVWZJ6wF7XD0Pawu3LAEh/FsWo9k/T6Uo1oGLh7aYnljfLNOQR1
	 U09qYeGKM9FDM7Yik0XukOqQg9H3irEvD91hgMtYxZh7vrU4JcCJ/RL7jBQV7yBx1z
	 7P6R43TEygQ1w==
From: Kalle Valo <kvalo@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: aleksander.lobakin@intel.com,  kuba@kernel.org,  davem@davemloft.net,
  pabeni@redhat.com,  edumazet@google.com,  elder@kernel.org,
  linux-arm-kernel@lists.infradead.org,
  linux-mediatek@lists.infradead.org,  nbd@nbd.name,
  sean.wang@mediatek.com,  Mark-MC.Lee@mediatek.com,  lorenzo@kernel.org,
  taras.chornyi@plvision.eu,  ath11k@lists.infradead.org,
  ath10k@lists.infradead.org,  linux-wireless@vger.kernel.org,
  geomatsi@gmail.com,  Igor Mitsyanko <imitsyanko@quantenna.com>,
  quic_jjohnson@quicinc.com,  leon@kernel.org,
  dennis.dalessandro@cornelisnetworks.com,  linux-kernel@vger.kernel.org,
  netdev@vger.kernel.org,  bpf@vger.kernel.org,  idosch@idosch.org,
  angelogioacchino.delregno@collabora.com,  matthias.bgg@gmail.com
Subject: Re: [PATCH net-next v7 08/10] wifi: qtnfmac: Use netdev dummy
 allocator helper
References: <20240422123921.854943-1-leitao@debian.org>
	<20240422123921.854943-9-leitao@debian.org>
Date: Mon, 22 Apr 2024 16:07:49 +0300
In-Reply-To: <20240422123921.854943-9-leitao@debian.org> (Breno Leitao's
	message of "Mon, 22 Apr 2024 05:39:01 -0700")
Message-ID: <87ttjtv93u.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Breno Leitao <leitao@debian.org> writes:

> There is a new dummy netdev allocator, use it instead of
> alloc_netdev()/init_dummy_netdev combination.
>
> Using alloc_netdev() with init_dummy_netdev might cause some memory
> corruption at the driver removal side.
>
> Fixes: 61cdb09ff760 ("wifi: qtnfmac: allocate dummy net_device dynamically")
> Signed-off-by: Breno Leitao <leitao@debian.org>

I assume this goes via net-next:

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

