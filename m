Return-Path: <bpf+bounces-74988-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8114AC6A344
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 16:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id B98422BA6C
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 15:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EA7363C54;
	Tue, 18 Nov 2025 15:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4doJTDC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326B72367DC;
	Tue, 18 Nov 2025 15:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763478046; cv=none; b=Z7lSbM/4R2nVIIhNJDb8n/ExYoiVIm2DEdxf5fbDBHDfuqQpYDN+ejryW0ZkMkRvY5JodBXcAGX4RTZNXrfpklLsAHCuivpoVAIqVr2a2dcSy2l3FTLn6DrxCkoTbbPWgEFlEqCzYU8gnKYo5iMZfzyqKZEn5Ibh8vHjWMbM0j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763478046; c=relaxed/simple;
	bh=dQzpbT2F2qJaoBjb2XPpXsQz/3pWhfQOSIcwv25p/BU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FGA0ov0E9D4IHecYZ6o8Ka1ATrt8Le4XGsOtY6MCtaWpDFVw9j3CNHLIy3uh0QIijcLR8UWCo7Phkqxp3k6P56KE7tCgwBMX0gyRAyqOFtkQKE8h4LpKH6J8KSCiKU9roHv8VHWA3V3ifRpNaCiGt25Hh5Ajli/cwYlgraNwwU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4doJTDC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2860C116B1;
	Tue, 18 Nov 2025 15:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763478045;
	bh=dQzpbT2F2qJaoBjb2XPpXsQz/3pWhfQOSIcwv25p/BU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=e4doJTDCZlA1GNWXbFlJoa+OLXjbMfkt3pOpy1hH4mX6QPpdNycp2E/cf8R+g3Srk
	 ACK8lehT2XVnMYG1wisubMiOHMBbLixYjNMVz+XC4RGEhsazH2hVqbygb9yh3FRxP9
	 RtnekfKL+6TxCFOW7Fz9Rhnf7EadTKVVy//XOSD/zUcWUG6uvk85s+XIrKeBGYU4sH
	 F4UBqEIktOHQieKIRW6tJ4R7Weyp3iMO6DWqKVywiDgXmVeXUREQ3q95Q8p9lc9xtv
	 e8Qi9t/V6DACl9ppGSUy3VI9De+cznM5lFgaOnCtk5TvhgmfubpeSuzwOMAFwFZmXC
	 DzjdAoZYbNBFA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7105C3809A8F;
	Tue, 18 Nov 2025 15:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] gve: Implement XDP HW RX Timestamping
 support
 for DQ
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176347801225.4178761.8286232845240261074.git-patchwork-notify@kernel.org>
Date: Tue, 18 Nov 2025 15:00:12 +0000
References: <20251114211146.292068-1-joshwash@google.com>
In-Reply-To: <20251114211146.292068-1-joshwash@google.com>
To: Joshua Washington <joshwash@google.com>
Cc: netdev@vger.kernel.org, hramamurthy@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 willemb@google.com, pkaligineedi@google.com, thostet@google.com,
 yyd@google.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 14 Nov 2025 13:11:42 -0800 you wrote:
> From: Tim Hostetler <thostet@google.com>
> 
> This patch series adds support for bpf_xdp_metadata_rx_timestamp from an
> XDP program loaded into the driver on its own or bound to an XSK. This
> is only supported for DQ.
> 
> Tim Hostetler (4):
>   gve: Move ptp_schedule_worker to gve_init_clock
>   gve: Wrap struct xdp_buff
>   gve: Prepare bpf_xdp_metadata_rx_timestamp support
>   gve: Add Rx HWTS metadata to AF_XDP ZC mode

Here is the summary with links:
  - [net-next,1/4] gve: Move ptp_schedule_worker to gve_init_clock
    https://git.kernel.org/netdev/net-next/c/46e7860ef941
  - [net-next,2/4] gve: Wrap struct xdp_buff
    https://git.kernel.org/netdev/net-next/c/f356a66b87bb
  - [net-next,3/4] gve: Prepare bpf_xdp_metadata_rx_timestamp support
    https://git.kernel.org/netdev/net-next/c/66adaf102128
  - [net-next,4/4] gve: Add Rx HWTS metadata to AF_XDP ZC mode
    https://git.kernel.org/netdev/net-next/c/1b42e07af1ee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



