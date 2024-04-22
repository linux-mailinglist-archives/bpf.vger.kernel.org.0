Return-Path: <bpf+bounces-27423-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF65B8ACDD1
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 15:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75CDB284B85
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 13:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678AF14F136;
	Mon, 22 Apr 2024 13:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BWWeePq7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D418C14F11C;
	Mon, 22 Apr 2024 13:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713791306; cv=none; b=jwN8UiGBOOmx8Vc3N0H2C15pHMTUB5Yy/p4ulBdMLEcn/8NZt7CLYtFuYZrNEVBeNE1NsTrl7pm8OFQO3GM5PKGlKqJS2vNHLyySCMjGAeMKKjEsNNP3VvyQ93s0R9/GZ5ESwRCvEWMP+F2Vmpf2UQuf/kPB4ki0b57g8zL3Mzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713791306; c=relaxed/simple;
	bh=nznyQx8/p+3KHBmfBdZ9fWAd5pFk+wk0RpKca9y7nEY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=RnbD6vI42JOtZfaG5ghxQQTAi3iyIcaFDj+DG70xetXPxU63YyGnwEPmnsWxFxwvUCZwMK0eU/0Nvy20ZK7LQydSaWQPRMhb7CcdxtXq2jOTXI2lwGyp45AB+jQh8e69CgJZEjYrzSYtTTvuquOXeFiaBy6mKIyBRNqzTwSGo7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BWWeePq7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1CC6C113CC;
	Mon, 22 Apr 2024 13:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713791305;
	bh=nznyQx8/p+3KHBmfBdZ9fWAd5pFk+wk0RpKca9y7nEY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=BWWeePq7vCnYC1rDnhl46rbfsAP83k7q/x3Q3lUzGSjnUMUQIhUqsdwSj7B+QHsUT
	 TJxNZwu/It8/kfuDOxr+7fR/Gxuuekf9dThdZF6BE1JItRKXMPkSrq3frGiVH1r0xW
	 L8fuputkj427+VfwNLdg4HGOQwxsr2FkSzbe/D7jbA7UK2aL7WgyRhtPTRyS1GEDSF
	 U/R13zM6yHGfF4Ar2391FPP3Oe3dxjEg9FmMrVpke8K22WL35HrwSnsJUUE5HDiQ93
	 e9/YdctW7fGJnrZV7fkKjq+C4Ril6Qjq7t2VMHBijsJBRnEGzXkukWwVx+zT+XCVU/
	 HDX6k5rLN9hLw==
From: Kalle Valo <kvalo@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: aleksander.lobakin@intel.com,  kuba@kernel.org,  davem@davemloft.net,
  pabeni@redhat.com,  edumazet@google.com,  elder@kernel.org,
  linux-arm-kernel@lists.infradead.org,
  linux-mediatek@lists.infradead.org,  nbd@nbd.name,
  sean.wang@mediatek.com,  Mark-MC.Lee@mediatek.com,  lorenzo@kernel.org,
  taras.chornyi@plvision.eu,  ath11k@lists.infradead.org,
  ath10k@lists.infradead.org,  linux-wireless@vger.kernel.org,
  geomatsi@gmail.com,  Jeff Johnson <jjohnson@kernel.org>,
  quic_jjohnson@quicinc.com,  leon@kernel.org,
  dennis.dalessandro@cornelisnetworks.com,  linux-kernel@vger.kernel.org,
  netdev@vger.kernel.org,  bpf@vger.kernel.org,  idosch@idosch.org,
  angelogioacchino.delregno@collabora.com,  matthias.bgg@gmail.com
Subject: Re: [PATCH net-next v7 09/10] wifi: ath10k: allocate dummy
 net_device dynamically
References: <20240422123921.854943-1-leitao@debian.org>
	<20240422123921.854943-10-leitao@debian.org>
Date: Mon, 22 Apr 2024 16:08:18 +0300
In-Reply-To: <20240422123921.854943-10-leitao@debian.org> (Breno Leitao's
	message of "Mon, 22 Apr 2024 05:39:02 -0700")
Message-ID: <87pluhv931.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Breno Leitao <leitao@debian.org> writes:

> Embedding net_device into structures prohibits the usage of flexible
> arrays in the net_device structure. For more details, see the discussion
> at [1].
>
> Un-embed the net_device from struct ath10k by converting it
> into a pointer. Then use the leverage alloc_netdev() to allocate the
> net_device object at ath10k_core_create(). The free of the device occurs
> at ath10k_core_destroy().
>
> [1] https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/
>
> Signed-off-by: Breno Leitao <leitao@debian.org>

I assume this goes via net-next:

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

