Return-Path: <bpf+bounces-64442-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0EBB12BD9
	for <lists+bpf@lfdr.de>; Sat, 26 Jul 2025 20:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 595181897A5B
	for <lists+bpf@lfdr.de>; Sat, 26 Jul 2025 18:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD06288C2B;
	Sat, 26 Jul 2025 18:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tYiVri0Q"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5176C1FC3;
	Sat, 26 Jul 2025 18:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753554594; cv=none; b=DdxsBc+u6MUHQI6AN8f8NidOA4a9sQ15/8V4A1zK39W7q34nqV5tEoTumkSMpFKdFFYdnUYPq5yyzKIkE6HeMAyeJNSgDiO2WPwS6z9omL9ZhFIN0J+nxPojZHX1CvNQ642cn6Ar26p8fK8GkDbFTCoLkl8OJwnDqDZnNFlq9T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753554594; c=relaxed/simple;
	bh=mxo9qya/kzvBI7JkhII6DI4w28F8yzccAxoPm1FQ4Mc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jAje75u/yKjngODBqscnIxshhuXK8Sl5BOePg58iN6RLNL8CHhD5TfJKc5xkQS6V1xyuDxe1BCMsuEwpspapHBXUK3/Wk/AD609OC4w2m/PO0YovXubIuclKPgDtGBIGWwv+3vXjp7+vDPHJbfKy80rhRIyb0GnDHTvjkoY4m78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tYiVri0Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3188C4CEF1;
	Sat, 26 Jul 2025 18:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753554593;
	bh=mxo9qya/kzvBI7JkhII6DI4w28F8yzccAxoPm1FQ4Mc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tYiVri0QD33QM0ljryw3G6aNP5+B/csvJqrOIvwmx3AGsJOo0dNaKCdXW+m5ViZWb
	 d+8uVdUCbGDy6ghfyIxWQFonT0WxCz4jiwY060cGdSgUsPJGJu3gNZOYFAT8RwpOS9
	 hch5tpQjrTyOp+XvpgKOSsI7YIThcvX+LoYdE2Z+tYZMhAO5/ufBUzpDkNKIUSP4XU
	 +HWtSCSpf6lBjv8lJFVZMhen5K/qrqRsnPa28RxqESE55KXpCENEMhgmjmmafx9cyW
	 UpSa8+g9qabVPejG3TF62QGmLEo+cYPCgutZmJe5dtiJJk9FelzYMCzjGZFhcFTVck
	 qbhbn3aEppxUw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D39383BF4E;
	Sat, 26 Jul 2025 18:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/2] xsk: fix negative overflow issues in zerocopy
 xmit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175355461105.3662765.16598122698049376540.git-patchwork-notify@kernel.org>
Date: Sat, 26 Jul 2025 18:30:11 +0000
References: <20250723142327.85187-1-kerneljasonxing@gmail.com>
In-Reply-To: <20250723142327.85187-1-kerneljasonxing@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, bjorn@kernel.org,
 magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 linux-stm32@st-md-mailman.stormreply.com, bpf@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 kernelxing@tencent.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 23 Jul 2025 22:23:25 +0800 you wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Fix two negative overflow issues around {stmmac_xdp|igb}_xmit_zc().
> 
> Jason Xing (2):
>   stmmac: xsk: fix negative overflow of budget in zerocopy mode
>   igb: xsk: solve negative overflow of nb_pkts in zerocopy mode
> 
> [...]

Here is the summary with links:
  - [net,v3,1/2] stmmac: xsk: fix negative overflow of budget in zerocopy mode
    https://git.kernel.org/netdev/net/c/2764ab51d5f0
  - [net,v3,2/2] igb: xsk: solve negative overflow of nb_pkts in zerocopy mode
    https://git.kernel.org/netdev/net/c/3b7c13dfdcc2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



