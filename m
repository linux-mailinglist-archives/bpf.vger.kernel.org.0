Return-Path: <bpf+bounces-54006-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6A4A603FC
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 23:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BCBB880B74
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 22:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00AB1F754C;
	Thu, 13 Mar 2025 22:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ciXF3L4h"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732811F4706;
	Thu, 13 Mar 2025 22:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741903800; cv=none; b=jZ6L8YZVmktbVnvhtAzmQPC3WP/DJJjroPRu4+JN2pjfFSffztOcjfeX8Y+oIF4oYfGCemdGcfTvKNY0k6R2HMwL+NkqsrJNVf6sbrTHOUEN3PkhtbT56D6rHVTZhFTqOicmd6n85VrRzhW11KQ17V/4EsLaZnqPraDHv6Ap2F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741903800; c=relaxed/simple;
	bh=BsI/hiQQI+LLlIfr0e6ujEsRqcfk2Qh9lglbhDA8zMw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iznz8H1dHJ5r/+Ke84zQrHcbBLXBfexkfAzEsVZlPXNIHgq74pooEI9NoawfaF5qcHjKJg84JwCJ1R54rkyPnYqtftJHLT531Zi3/2qJw+B/RR8bSMBClmeYsAjFhKaxPLUIxUwBWdHHywk5gCSw50pZO+YNa4ZlXYpG8Eqg82Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ciXF3L4h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA8CC4CEDD;
	Thu, 13 Mar 2025 22:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741903800;
	bh=BsI/hiQQI+LLlIfr0e6ujEsRqcfk2Qh9lglbhDA8zMw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ciXF3L4hiqFoxX6/YYMt4h4dn+aYSsiGso7RaKl5E5nxn4le3Ik2DwwKo94kt5Fjc
	 gFVDLJXRR3xjbzfOlNH8iWbttjVl3uXXyyGWoTvB0GnMh64bEfM+4q5Vq5gfR6oj3C
	 C8BFvEmJBgh6SDB1b0ArYNnl8jtGdEBiHvNs/n7JOyFnp9cOMPo25UtDMFrqKCaq/U
	 s2UmmPDIzmezTa4hx52ze+F/NpUWa/9fxbpLwRBYFSHhwqbVFWtH3BwtjHnFBFd3QH
	 5tyisXNbWncNA08Oy/X9B8PVawwYq0gB6grxlAMWnG0+xN4D0H/Vzwgt5IKosbmtHc
	 5QhDYRIEuxO7Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1A23806651;
	Thu, 13 Mar 2025 22:10:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/4] tcp: add some RTO MIN and DELACK MAX
 {bpf_}set/getsockopt supports
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174190383475.1677603.6052935547894772421.git-patchwork-notify@kernel.org>
Date: Thu, 13 Mar 2025 22:10:34 +0000
References: <20250312153523.9860-1-kerneljasonxing@gmail.com>
In-Reply-To: <20250312153523.9860-1-kerneljasonxing@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, horms@kernel.org,
 kuniyu@amazon.com, ncardwell@google.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (net)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Wed, 12 Mar 2025 16:35:19 +0100 you wrote:
> Introduce bpf_sol_tcp_getsockopt() helper.
> 
> Add bpf_getsockopt for RTO MIN and DELACK MAX.
> 
> Add corresponding selftests for bpf.
> 
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/4] tcp: bpf: introduce bpf_sol_tcp_getsockopt to support TCP_BPF flags
    https://git.kernel.org/bpf/bpf-next/c/49f6713cb691
  - [bpf-next,v3,2/4] tcp: bpf: support bpf_getsockopt for TCP_BPF_RTO_MIN
    https://git.kernel.org/bpf/bpf-next/c/5584cd7e0ddd
  - [bpf-next,v3,3/4] tcp: bpf: support bpf_getsockopt for TCP_BPF_DELACK_MAX
    https://git.kernel.org/bpf/bpf-next/c/d22b8b04b88e
  - [bpf-next,v3,4/4] selftests: add bpf_set/getsockopt() for TCP_BPF_DELACK_MAX and TCP_BPF_RTO_MIN
    https://git.kernel.org/bpf/bpf-next/c/a1e0783e1036

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



