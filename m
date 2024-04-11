Return-Path: <bpf+bounces-26496-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1338A0B71
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 10:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E1911C21CD7
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 08:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1471411D1;
	Thu, 11 Apr 2024 08:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAFuS0Pp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A39D6FB5;
	Thu, 11 Apr 2024 08:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712824733; cv=none; b=WAU8+UrvJlBH79s0Ux0mG9uMpsluLQsDBAM4tuSpLBAiMRVkLa6d7KutT+HBT9Enyw8hJ4RTLOi9nqyqyGeii/5SpwZxzUOsjZnLWDWK2T7R4yDcg3qMMYp1UsOA5Xj9Uh8zrr41Fd4XP3hVcPfdjavfYdZEzGycrN7X1aVJEKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712824733; c=relaxed/simple;
	bh=hFPKYBGIMfpUrwovYlZJbiVjlexhjRbaRyeGHPPWlns=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=PZDVh09OIyfbRjQrmoxCvCYtOJ0Vefuba3jn/iqO672NUspGP9cDOpx9E59ZH6AEfFEaDq/O0/civXIAMRqAObJAK4BznaecBvm93OuqJcb77RnkLVi2WXEZJCkOPZf+D9ixfArc3EjvfX4CZ7Y2JUl/8itvdl0hJ9H9Yzrl+kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAFuS0Pp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BF14C433F1;
	Thu, 11 Apr 2024 08:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712824733;
	bh=hFPKYBGIMfpUrwovYlZJbiVjlexhjRbaRyeGHPPWlns=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=NAFuS0Ppx0+PkVXSEJz4rvVpoClDsOe3OP/22UTvK7TVNvqysCmc8ya7CP2kXYKvq
	 MEzj40HuEA/CIdTXGdMDf4FVp2dQlSbFqLoCRy35QUEqVmt8aFV8jgAtdGQoqiZq6b
	 BcfQG6FtYZhS9tDybY8gp5mq07k1BpKuWR7Te7A3rCLgTY2AW/t69iINWHG4b/X7GT
	 4vOoFym4qjz6G+QWNyugZh3HemWLtgqsvwx0eVo+r65d63JWxk7GFJXZAY+IE1RxEt
	 Du5oakGX1TS7W6YWY6MWkYSCOM8v+fPCQQ03DzRgwDh08cEfH0rlwvp3CzAPwRwrjf
	 MW64XnTh5rKaQ==
From: Kalle Valo <kvalo@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: aleksander.lobakin@intel.com,  kuba@kernel.org,  davem@davemloft.net,
  pabeni@redhat.com,  edumazet@google.com,  elder@kernel.org,
  linux-arm-kernel@lists.infradead.org,
  linux-mediatek@lists.infradead.org,  nbd@nbd.name,
  sean.wang@mediatek.com,  Mark-MC.Lee@mediatek.com,  lorenzo@kernel.org,
  taras.chornyi@plvision.eu,  ath11k@lists.infradead.org,
  ath10k@lists.infradead.org,  linux-wireless@vger.kernel.org,
  geomatsi@gmail.com,  Matthias Brugger <matthias.bgg@gmail.com>,
  AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
  quic_jjohnson@quicinc.com,  leon@kernel.org,
  dennis.dalessandro@cornelisnetworks.com,  linux-kernel@vger.kernel.org,
  netdev@vger.kernel.org,  bpf@vger.kernel.org,  idosch@idosch.org
Subject: Re: [PATCH net-next v5 00/10] allocate dummy device dynamically
References: <20240410131407.3897251-1-leitao@debian.org>
Date: Thu, 11 Apr 2024 11:38:45 +0300
In-Reply-To: <20240410131407.3897251-1-leitao@debian.org> (Breno Leitao's
	message of "Wed, 10 Apr 2024 06:13:41 -0700")
Message-ID: <87frvsz42y.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Breno Leitao <leitao@debian.org> writes:

> struct net_device shouldn't be embedded into any structure, instead,
> the owner should use the private space to embed their state into
> net_device.
>
> But, in some cases the net_device is embedded inside the private
> structure, which blocks the usage of zero-length arrays inside
> net_device.
>
> Create a helper to allocate a dummy device at dynamically runtime, and
> move the Ethernet devices to use it, instead of embedding the dummy
> device inside the private structure.
>
> This fixes all the network cases plus some wireless drivers.
>
> PS: Due to lack of hardware, unfortunately most these patches are
> compiled tested only, except ath11k that was kindly tested by Kalle Valo.
>
> ---
> Changelog:
>
> v1:
> 	* https://lore.kernel.org/all/20240327200809.512867-1-leitao@debian.org/
>
> v2:
> 	* Patch 1: Use a pre-defined name ("dummy#") for the dummy
> 	  net_devices.
> 	* Patch 2-5: Added users for the new helper.
> v3:
> 	* Use free_netdev() instead of kfree() as suggested by Jakub.
> 	* Change the free_netdev() place in ipa driver, as suggested by
> 	  Alex Elder.
> 	* Set err in the error path in the Marvell driver, as suggested
> 	  by Simon Horman.
> v4:
> 	* Added a new patch to add dummy device at free_netdev(), as suggested
> 	  by Jakub.
> 	* Added support for some wireless driver.
> 	* Added some Acked-by and Reviewed-by.
> v5:
> 	* Added a new patch to fix some typos in the previous code,
> 	  suggested by Ido.
> 	* Rebased to net-net/main

I'm nitpicking here but I prefer to have the changelog in reverse order,
that is v5 first and v1 last. I'm most interested about the changes in
v5, I don't care about v1 at this point. Though I don't know if net
folks have a different prefence, just wanted to mention this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

