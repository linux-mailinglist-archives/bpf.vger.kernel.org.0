Return-Path: <bpf+bounces-54492-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4561BA6AF81
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 22:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A405A3B7F05
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 21:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A1F22A1ED;
	Thu, 20 Mar 2025 21:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1Kkq/cT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A272C2AE6A;
	Thu, 20 Mar 2025 21:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742504426; cv=none; b=hiqzdstttIqdB20C06RBIIpKbkIYmNEi3lovPcu7EoebGHyEGDrrdR/Alw5iLlBgkel4DJfi+n0mhbCDL5qR0W1WvbEEIh7aVKIk3sVtAE1LmpWrFm5YQt0609+VwLwQ6es32vpVY2rlsK8EwP24V9UqLcpl9zzhRm8V7HUKRnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742504426; c=relaxed/simple;
	bh=ofQqhnsJ2xV2kT+e9NMewkJMTOTQ5E52sLjKskYl+Ww=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VxNAaAFv/2OQ83Gj4WkXuPXjdZehC4jDmgHqoK7zX6hFu8angJ9V2N77yq+tnnZRboadyuff0Mxmbm6wIHwp0rqW5Tqpm9RlNV+OfL4a6sLSrF7O4yS6eHgjAn/xRoxbjkg7BOjg272bqrwIVdo8yBXTz/HT6gtUrgUhR7TCbTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1Kkq/cT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A99C4CEDD;
	Thu, 20 Mar 2025 21:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742504426;
	bh=ofQqhnsJ2xV2kT+e9NMewkJMTOTQ5E52sLjKskYl+Ww=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=X1Kkq/cTj466c8nwHv+J7k+Zw2GbCRiAd0NW599iqYx5nnCehMzApq5hq93VcFABP
	 W+J35TzIrQAvdlFJomOrtErbkqU28L6HRmEWu1LfnrMWpcMDV87g4YLaJRA5AQ0sOJ
	 k6Ofk7qnCCcWkIBTrwV9CBsO/NovBOcUtIMRiT6VlyqwdH2w15UdTABLhUReuClSOA
	 WMs3gAJU1CZdLQ+wA2YUk8QkICR7Sn2/00itTAvsFYtdSVsRod4TKdJWeNilL6kopz
	 aZKvj5wYa7Sv8vynOOEeY6MWJ6PPKZp9ZJ5LNPuSaWdj5gVo8bpmoJfQnR8W/dCHin
	 /BuF9qi0nQzEg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E663806654;
	Thu, 20 Mar 2025 21:01:03 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf-next 2025-03-13
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174250446202.1908117.17348935964987648902.git-patchwork-notify@kernel.org>
Date: Thu, 20 Mar 2025 21:01:02 +0000
References: <20250313221620.2512684-1-martin.lau@linux.dev>
In-Reply-To: <20250313221620.2512684-1-martin.lau@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 13 Mar 2025 15:16:20 -0700 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net-next* tree.
> 
> We've added 4 non-merge commits during the last 3 day(s) which contain
> a total of 2 files changed, 35 insertions(+), 12 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf-next 2025-03-13
    https://git.kernel.org/netdev/net-next/c/6f13bec53a48

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



