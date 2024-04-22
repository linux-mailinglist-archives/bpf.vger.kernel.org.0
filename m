Return-Path: <bpf+bounces-27424-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB278ACDD9
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 15:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D73A1F21429
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 13:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94D214F9EA;
	Mon, 22 Apr 2024 13:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tKj1Ev0s"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4369614F9D4;
	Mon, 22 Apr 2024 13:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713791332; cv=none; b=W0qgamwXqdH2d4JSE/PyvI8FgP1KVl5T34iG/GSxED0S3N29RLjhbdYsIzD2QhX4dI5dk9wv7UVDBToFZTRoys5Kgns6Qj5ITmye+wvj2wM9YczezleK4ZcW+4SXu1ALkvL7mSWOaqNzOUzegEddSDLfp8Yn0LC1HqTWJnt8ETU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713791332; c=relaxed/simple;
	bh=J+i9N1KjmFk35PLTmY7h40rPANVS4NetGv5XWCcgOzg=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=ti2U64yyM1TK1C7ZulpHO/BoSuDDCnWs941m21Milfm7hgR19V4V23jBRJbn5aG71hrK+TGED18uFRZcWvW2z78us8WmpKlyNYLNw+rpyrFp5Jgae6DefiUvhwIsabtVHzPfVZYIBJ9Iu5fNpzwGtQvmqT5v2KCySD560YnQMXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tKj1Ev0s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19101C2BD11;
	Mon, 22 Apr 2024 13:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713791331;
	bh=J+i9N1KjmFk35PLTmY7h40rPANVS4NetGv5XWCcgOzg=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=tKj1Ev0sDkQi5+KEiB5LhY1YrapyhqPWj1xhNyldEFOrjYMdLC2NQNywPIpM2oCn9
	 KKR+ldrGnJ0vgDJG4XgwKBgLI5FgxOu432nBCICrmXQSH+gCWW0UTDdlAhAQBILxdo
	 xqF/R3vnu4jpugzmTn/hkZBf7SpnConYhE6huJdhyTx4EfL7nhXiFev8vfEpfZp+Lw
	 L0pJcnsCn5VjnI/vxE0yT7hls74KwUcZ1ud9MZJyYKzX2kxFcFbVphu8ZJaYeFhTzP
	 hCEBR8kB/Bdhv+iVxYObXPLD8tw+6rMlMYtLli9sAXUXAWh2sYW2PburZIAgpw4TBX
	 ODeXWH+Ch2/IQ==
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
Subject: Re: [PATCH net-next v7 10/10] wifi: ath11k: allocate dummy
 net_device dynamically
References: <20240422123921.854943-1-leitao@debian.org>
	<20240422123921.854943-11-leitao@debian.org>
Date: Mon, 22 Apr 2024 16:08:44 +0300
In-Reply-To: <20240422123921.854943-11-leitao@debian.org> (Breno Leitao's
	message of "Mon, 22 Apr 2024 05:39:03 -0700")
Message-ID: <87le55v92b.fsf@kernel.org>
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
> Un-embed the net_device from struct ath11k_ext_irq_grp by converting it
> into a pointer. Then use the leverage alloc_netdev() to allocate the
> net_device object at ath11k_ahb_config_ext_irq() for ahb, and
> ath11k_pcic_ext_irq_config() for pcic.
>
> The free of the device occurs at ath11k_ahb_free_ext_irq() for the ahb
> case, and ath11k_pcic_free_ext_irq() for the pcic case.
>
> [1] https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/
>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Tested-by: Kalle Valo <kvalo@kernel.org>

I assume this goes via net-next:

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

