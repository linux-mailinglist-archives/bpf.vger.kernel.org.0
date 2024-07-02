Return-Path: <bpf+bounces-33626-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B811923EC0
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 15:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8ED0EB25FE9
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 13:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1B81B47C2;
	Tue,  2 Jul 2024 13:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Azd7ESXw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AC318733F;
	Tue,  2 Jul 2024 13:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719926429; cv=none; b=NtgugC2+J1dLXcDY+Q/IUQx4SY+MsqxTB5yH2RhQyGzWLLsyTDZUYc07Gg3rEYlU2XpYjxI7a4z8BNyCuY0ywy5v8T1RiMdjvS1N1XdUGLuNhJE9m/yI/mZ7A/x81Bvq6LPhayP5y0dFXaqG3J0/zuKmYUIOvM1u0LOXDBaXcCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719926429; c=relaxed/simple;
	bh=pCbqn+qD4xtTx1wUkvRH8BBsvYS9w0HEd26xAfwMACI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jJKjgEf9U97hfWm0n9TuQ5ffFemLkHCQZCcxymxu+CKFokOAOs7Qann5zwxgylG+ebxr6Cdv6exhT0aURMDaGcfaGTyvmQE6NZ8L/lmRh8GgI7pb0PjG6GiHlQtNez6VAddbhWzwaVKZdekpgP9vkBWlZxOdQznQeRW5IbsxGF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Azd7ESXw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6588C2BD10;
	Tue,  2 Jul 2024 13:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719926429;
	bh=pCbqn+qD4xtTx1wUkvRH8BBsvYS9w0HEd26xAfwMACI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Azd7ESXwYchY2PtMCRmuxAfI/BMc+PObSjIrEAltw4/o3V7jzQuR1HvRcf5fax3hk
	 Y/ovVLvVK1SuNGeCmf6vje72F9klmVJR62g+szHEtq858nnR5vA2bZa4vzNc7Beh0x
	 Ox47J/Z0VEWtvGSyuAytfF0Yom6IZL2m8eNmzpp9+sIpx+JxBXDINYksAkYVHi5tzO
	 E9SPrSoSGRk3nfyn3TT+bYYQwsnTASIIFmZNCGYoDdoqg9Osvi+ozuOhB2ASnN8XgJ
	 dT0SLsJYSd8UVSQ4/WIOWkGoiwXVL9u+SVGs4xN2TnqP4qooEityMKljUCW7jBAJde
	 1G7E/BsvBIChg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DBD19C43331;
	Tue,  2 Jul 2024 13:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/2] selftests/xsk: Enhance traffic validation and
 batch size support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171992642889.16847.4890071581135436135.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jul 2024 13:20:28 +0000
References: <20240702055916.48071-1-tushar.vyavahare@intel.com>
In-Reply-To: <20240702055916.48071-1-tushar.vyavahare@intel.com>
To: Tushar Vyavahare <tushar.vyavahare@intel.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, bjorn@kernel.org,
 magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 tirthendu.sarkar@intel.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue,  2 Jul 2024 05:59:14 +0000 you wrote:
> This patch series introduces enhancements to xsk selftests, focusing on
> dynamic batch size configurations and robust traffic validation.
> 
> v1->v2:
> - Correctly bind UMEM queue sizes to TX and RX queues for standard
>   operational alignment.
> - Set cfg.rx_size directly from umem->fill_size when umem->fill_size is
>   true, ensuring alignment with test specifications.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/2] selftests/xsk: Ensure traffic validation proceeds after ring size adjustment in xskxceiver
    https://git.kernel.org/bpf/bpf-next/c/d80d61ab0609
  - [bpf-next,v3,2/2] selftests/xsk: Enhance batch size support with dynamic configurations
    https://git.kernel.org/bpf/bpf-next/c/e4a195e2b95e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



