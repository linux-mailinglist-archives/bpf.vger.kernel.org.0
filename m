Return-Path: <bpf+bounces-27783-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED2E8B19BA
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 05:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 902D5B218A7
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 03:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682942E622;
	Thu, 25 Apr 2024 03:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sS0tlyUw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC1A2940B;
	Thu, 25 Apr 2024 03:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714017029; cv=none; b=MlzaZWXITVgQWj9hR4nrUBMzZPqzb721HLXISTcsnGLy/MDhLy/p9u7o5sWlgwPAhvNJnKo8Azi19np5igji+DDwNwi8/J5rHXOHfqYl5dd6VG/M7jdeDgzi4s7H9sV9ClaDKlCxiL7aLO61hPY26ucswDSsg8g2ABTOrTTS6Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714017029; c=relaxed/simple;
	bh=L+Lbm4Ez2kppLBnCSzQpnozC/0nBXUvkK/R2EZqJ+W8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HkkoUAs+Ajx/vDoksfZ5KDRGE2+WmAbzOthIulZ4GYz43mFhcTHG3QQpQ69+24bcKPtMP2y7FP7V4zwRMrBWHI2kZ9u9KxjfIS1SyMPCztb4NkQcWKcCB9Xh2vE4hKl7GiE748tHugE7omQHr7t0ycN2lUMeDfarwM45a7UbhX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sS0tlyUw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5024EC113CE;
	Thu, 25 Apr 2024 03:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714017028;
	bh=L+Lbm4Ez2kppLBnCSzQpnozC/0nBXUvkK/R2EZqJ+W8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sS0tlyUwebNgDh8a8tPMJIhF3Pd8VQ6RkLG4YAipjO0142SBmGsBeVR1GFbNvFjnQ
	 cfQI/bhbpMhyycBgUJTeWMYWy7LU41wPv6Y4Y5pfMHrWhJKRQIQcPYisBMRs6lN/R6
	 g+DLce9vemtF5oEOJILunXpYdLsPPG9/y3K1r6YOdxPNN8hyf95WH0n1AtH8ta0Glm
	 jBTNys7Vfd71qt80tBll9JTkpco1Fy5+HGf730yJZNIbUcdA7W9bZmrtWP3AAeYl4D
	 PoX5UjJZIJ6Y6vc5vpSCYvjl3VmHxlD1EBjhy2Nbpt9en+5IDbYi+ygpPBdlCTP8OB
	 4HluAAY9B+Bmw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 426FCCF21C2;
	Thu, 25 Apr 2024 03:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] selftests: net: extract BPF building logic from
 the Makefile
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171401702826.27021.16042743392175785852.git-patchwork-notify@kernel.org>
Date: Thu, 25 Apr 2024 03:50:28 +0000
References: <20240423183542.3807234-1-kuba@kernel.org>
In-Reply-To: <20240423183542.3807234-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, bpf@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 23 Apr 2024 11:35:40 -0700 you wrote:
> This has been sitting in my tree for a while. I will soon add YNL/libynl
> support for networking selftests. This prompted a small cleanup of
> the selftest makefile for net/. We don't want to be piling logic
> for each library in there. YNL will get its own .mk file which can
> be included. Do the same for the BPF building section, already.
> 
> No funcional changes here, just a code move and small rename.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] selftests: net: name bpf objects consistently and simplify Makefile
    https://git.kernel.org/netdev/net-next/c/6b88ce902f0b
  - [net-next,2/2] selftests: net: extract BPF building logic from the Makefile
    https://git.kernel.org/netdev/net-next/c/3f584c211d8c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



