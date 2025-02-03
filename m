Return-Path: <bpf+bounces-50327-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB183A265A7
	for <lists+bpf@lfdr.de>; Mon,  3 Feb 2025 22:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 331A21629C9
	for <lists+bpf@lfdr.de>; Mon,  3 Feb 2025 21:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07C01FECC0;
	Mon,  3 Feb 2025 21:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8X203qI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409B82101B7;
	Mon,  3 Feb 2025 21:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738618208; cv=none; b=QT59aC5957KhpBn1NwGEl74+PKZqjQRV18PoMAIOup/3HPoCLCiw07KcuzZug/PyNDZvTELLc3chPcE5YKkUnb1YyK0in8BWCF04ZW61+9A+zs9T1xg9vW+gocMbipw975IujRf+pkwGvmxe+tNQPhuDTrMtmo8syAADZXHpQLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738618208; c=relaxed/simple;
	bh=PpOJmUYf36LxhrJSUyNYictHL+4hBcvbtXxHIS7yWis=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lvAlEr4pA6g2Txdo76a50Ga6Aqx7K6JHIXRbTkaIy8zPbijkaPCtuWV61wAVZLsLJfNoGiR9T+xxt1+Ngya1hLXYPH3C42f4n3yQ+mY5HlPUyU6n5fbLaTJXpxxMn9Xbk4lnymu4CpSsUWDfoNjXOIkxt/jjSMRnxgRp3CbPbek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8X203qI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 941F1C4CED2;
	Mon,  3 Feb 2025 21:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738618207;
	bh=PpOJmUYf36LxhrJSUyNYictHL+4hBcvbtXxHIS7yWis=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=f8X203qIpLhD4S5osECw8Uy9s5eceNEkH7fM2JI4JlHz50N4vtbyiNfQ8SzuiZC/N
	 UjTFxNJLek1oKHjb4UYWqDNGYtU4jO44afVmC6sizPYjIN0OtuppPXXR1PjCN0AOa/
	 EZEqn5YYakcoKFuCfsnUPX7iKgN7jj65VoYhRuWwslmjfN3E+VSyKLq3neN7v4LtiV
	 hYm1zL99YQ2SL36GlCnYbJD8pqt+6qWGI6yWzBydMnjP+kTod+T0d7fbQP/p3TWVB8
	 6+IEWtvxHWrCmTuMW75FB9sgVllbIWsLBN1/m47hJloEA6C8wtCuGDYv/aewZWNccx
	 ZZ2A25BY/W3zw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF6A380AA67;
	Mon,  3 Feb 2025 21:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3][pull request] ice: fix Rx data path for heavy 9k MTU
 traffic
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173861823477.3505817.7298121810604919963.git-patchwork-notify@kernel.org>
Date: Mon, 03 Feb 2025 21:30:34 +0000
References: <20250131185415.3741532-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20250131185415.3741532-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
 przemyslaw.kitszel@intel.com, jacob.e.keller@intel.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 bpf@vger.kernel.org, horms@kernel.org, xudu@redhat.com, jmaxwell@redhat.com

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Fri, 31 Jan 2025 10:54:10 -0800 you wrote:
> Maciej Fijalkowski says:
> 
> This patchset fixes a pretty nasty issue that was reported by RedHat
> folks which occurred after ~30 minutes (this value varied, just trying
> here to state that it was not observed immediately but rather after a
> considerable longer amount of time) when ice driver was tortured with
> jumbo frames via mix of iperf traffic executed simultaneously with
> wrk/nginx on client/server sides (HTTP and TCP workloads basically).
> 
> [...]

Here is the summary with links:
  - [net,1/3] ice: put Rx buffers after being done with current frame
    https://git.kernel.org/netdev/net/c/743bbd93cf29
  - [net,2/3] ice: gather page_count()'s of each frag right before XDP prog call
    https://git.kernel.org/netdev/net/c/11c4aa074d54
  - [net,3/3] ice: stop storing XDP verdict within ice_rx_buf
    https://git.kernel.org/netdev/net/c/468a1952df78

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



