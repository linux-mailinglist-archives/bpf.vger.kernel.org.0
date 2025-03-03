Return-Path: <bpf+bounces-53130-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF2BA4CF58
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 00:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99B053AC7B2
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 23:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B32A23C8CB;
	Mon,  3 Mar 2025 23:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0u23X7R"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C1823C8A7;
	Mon,  3 Mar 2025 23:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741044935; cv=none; b=bkED4EMefg3JM4tN0j9hizWXrdOXwGhXxZU0Efy9bxH1B3wGhJ79XH1NLOwAkKgR1zOmtrgHPlLb4Lq5kuqlLgXCoRFps3AVBl8kdsEoLuxzQaM1UzTBIOcktIT3PIGXLfH7LKUtlhJhLLq2czzEBQIt1NFYE8yk7wlQ9oNIipY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741044935; c=relaxed/simple;
	bh=MTmdEmC2+ZdM+IJliZV8YI/e9ZZJr5Z5GvKKUbvgs60=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QNGekilWbA6cbBiXakzkiNpkysnp211BsnZE8zFldzQm5n5JgahVuVo25z2I8jtBP+6ou7luLN1LjTwS2lj8bPcGyT6BEm71c1qtuF2vzJ1K1cLF0OUnVzJRM2OMckYisPf/lIZf8180SAlTVT3MQ3aJB8wdBMGUtXhuDH4fm8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G0u23X7R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BE13C4CEF1;
	Mon,  3 Mar 2025 23:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741044934;
	bh=MTmdEmC2+ZdM+IJliZV8YI/e9ZZJr5Z5GvKKUbvgs60=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=G0u23X7RywBCMWPmzl/9T6PQM4Idad3rEnrNMzlviKJ63ZNCfkqIjKkfmEof7MIjR
	 DgPrXWjRUQDMJCiIoC4wB0bqqcRFGajJICH402uv0mmoLl/pvh+4dzWn3syOqUJ2be
	 KzKEpXtmXHuEsYK5gDZc6+QvQhc35XuRbZ94puOxiMK9fR4FYxZ7L6fl6GMAoQD7zV
	 K8R+aebVBWM0FQjAimNVopODNH+2+/HGZOvyw7DKk+lHDlaj2z5Fi3Zwg1Uf5EwLRt
	 oIrwVYJIvp2u+e2TdDzY2P33MeWVl92cV5HPu7oh3u0ggowSiG5mFtpJGjAJYTeXQr
	 lB+i2qvHVmq5w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CE93809A8F;
	Mon,  3 Mar 2025 23:36:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: filter: Avoid shadowing variable in
 bpf_convert_ctx_access()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174104496699.3745415.15179484349437262281.git-patchwork-notify@kernel.org>
Date: Mon, 03 Mar 2025 23:36:06 +0000
References: <20250228-fix_filter-v1-1-ce13eae66fe9@debian.org>
In-Reply-To: <20250228-fix_filter-v1-1-ce13eae66fe9@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: martin.lau@linux.dev, daniel@iogearbox.net, john.fastabend@gmail.com,
 ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Fri, 28 Feb 2025 10:43:34 -0800 you wrote:
> Rename the local variable 'off' to 'offset' to avoid shadowing the existing
> 'off' variable that is declared as an `int` in the outer scope of
> bpf_convert_ctx_access().
> 
> This fixes a compiler warning:
> 
>  net/core/filter.c:9679:8: warning: declaration shadows a local variable [-Wshadow]
> 
> [...]

Here is the summary with links:
  - [net-next] net: filter: Avoid shadowing variable in bpf_convert_ctx_access()
    https://git.kernel.org/bpf/bpf-next/c/122f1fd14f44

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



