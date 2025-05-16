Return-Path: <bpf+bounces-58433-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F245ABA60D
	for <lists+bpf@lfdr.de>; Sat, 17 May 2025 00:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4A05A24A9C
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 22:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F346280338;
	Fri, 16 May 2025 22:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6hPO2eC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B72022D782;
	Fri, 16 May 2025 22:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747435799; cv=none; b=H4RLAJAbtgHdsnWrzSnW+X71qzrQXbF1Ej/R5MayaBQxNmOWR6VTEJ4K515iCH0sS9xQQ0d9DywDqnU319T/a66TDSPBhUVINV0soLIkQ58BTsE45j2pkwRI8EsVaa4EjQwt7rF1q4lMH8fcv5rA7KBZMFSE93vmIveiXVKTOqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747435799; c=relaxed/simple;
	bh=NacLtLtlAanoYX5bSIOd2FakTpOx4RBbjocPn2RrtMI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=K3LYxo2UZEjQ6IeiGT6J+ZWIAOufYzvyfEeS2RZUZ3VPeicOWddVR/1z+hp+4a5wiQjXfQhcujzvYHwdIE/7TXcBknPqFJUjtBXXmZS/+6wkdDq5RqsO39zsn4xOPqKhmoWe4T5lnHsaou9YsK9SGpedD/CXJGkqFfvtea4Nva4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6hPO2eC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF677C4CEE4;
	Fri, 16 May 2025 22:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747435799;
	bh=NacLtLtlAanoYX5bSIOd2FakTpOx4RBbjocPn2RrtMI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=J6hPO2eCtyg5gSdYJgXxEj1NFAwmwFmCgZ1/F9f7v2LMAGVtHgT0NvB0vrYPNwzx8
	 g0bDjJ/EaFIBx7z+Ffwzs5nlJfSJ4do/FoFmh+JWpTemB4lRh4F1AZHr7V77dmk1zC
	 3G2ltNy3e/wB2o/kWlnDfxNMrEkUVTcfpwDe8dItMWdPlyeOdwMKmyupgRamaDflzC
	 2rN2Rsa1NXCRzhqEIhK5Xsoa0ZXNplKKFeSOY/mURc53wXZOg2Y2j2f6Ke+PI76tR5
	 PGhKBZPH6N74Xq+S1D6jJz/C2yeNUGTu0PEQpOsGfK2TzbowLEwwfXXaWzX+S6I2eK
	 jDeMQ8BZw9dhw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE613806659;
	Fri, 16 May 2025 22:50:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/mlx5e: Reuse per-RQ XDP buffer to avoid stack
 zeroing overhead
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174743583575.4084431.15931290887900865187.git-patchwork-notify@kernel.org>
Date: Fri, 16 May 2025 22:50:35 +0000
References: <1747253032-663457-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1747253032-663457-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, saeedm@nvidia.com,
 leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, moshe@nvidia.com,
 mbloch@nvidia.com, gal@nvidia.com, cjubran@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 14 May 2025 23:03:52 +0300 you wrote:
> From: Carolina Jubran <cjubran@nvidia.com>
> 
> CONFIG_INIT_STACK_ALL_ZERO introduces a performance cost by
> zero-initializing all stack variables on function entry. The mlx5 XDP
> RX path previously allocated a struct mlx5e_xdp_buff on the stack per
> received CQE, resulting in measurable performance degradation under
> this config.
> 
> [...]

Here is the summary with links:
  - [net-next] net/mlx5e: Reuse per-RQ XDP buffer to avoid stack zeroing overhead
    https://git.kernel.org/netdev/net-next/c/b66b76a82c88

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



