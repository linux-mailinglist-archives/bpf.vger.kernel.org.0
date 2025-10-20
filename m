Return-Path: <bpf+bounces-71443-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7E7BF3742
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 22:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24A493A6F9D
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 20:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6832E0417;
	Mon, 20 Oct 2025 20:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+ozydVv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC95C2D661E;
	Mon, 20 Oct 2025 20:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760992225; cv=none; b=pyIWDqUcYFMtYL6Ae8uFoq566zzrw623RMeORH9YkKKybUa3XqZTDzLVsfORlx5cdgq+Cvkb2ojmSVbiHAgzbaCL5TITvkrZmbz4IBYWEPbFWVyFh90wOSXH8Gq48ctvVTbSKwUNxzJ9ZfZvNrRFVUobvzKWsS5rcwXaV0mW7/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760992225; c=relaxed/simple;
	bh=CxP/ms/tIXigmL02zeCR9egOpoIvu6mO40TBXnTBGe0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NOY1DuaCzgUFOw7f8/pzppzFKVWC972fWMsX+7NJa31swGvMRXdOPnleKD0k7COPwgtLynTHepwf7WnbMQZgOoINxqaGNb/3by92WrWVtr7YeaIpGwd69s5BdHMz9mfUJlAICefep8zoAZ1IHM2K7FrPwMPRsUS0ho7noYLvzFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+ozydVv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D831C116C6;
	Mon, 20 Oct 2025 20:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760992225;
	bh=CxP/ms/tIXigmL02zeCR9egOpoIvu6mO40TBXnTBGe0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=X+ozydVv/SsHLIkZrCRQPTVT0aKi5jlDoZkyxo8F3JTj6ZBzA9uibs4A/lZMdSacq
	 OkkZXOGIG3KhF4N3+UVQsHaxa+c8+KswvfEUHN7vFBzOk1f6Nq8ZPKeSmoJQ4l7J4B
	 X5IE5PzBP0Di80M9cqiFGRjjgcjs6vfuMXnKYhVJYoC0QU6GeLcH4eOtP6Y1De3tgu
	 aBGTrXKDwNkQ4lMI8UowIe5Swuz8iN+W6V823ZGSF2J0/2n99oI7yr1Pbl+lGr8Rt+
	 ByqH5B2wUuAEzM4QQih4IzbyS6BjSTFXfyQG5BFiKK760KqAYCHkWNSImPA0CQ2t60
	 u6J09jk/3u7Qw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BA23A4101D;
	Mon, 20 Oct 2025 20:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: Do not let BPF test infra emit invalid GSO types
 to
 stack
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176099220626.401229.10029182117746939973.git-patchwork-notify@kernel.org>
Date: Mon, 20 Oct 2025 20:30:06 +0000
References: <20251020075441.127980-1-daniel@iogearbox.net>
In-Reply-To: <20251020075441.127980-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: martin.lau@linux.dev, kuba@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dddddd@hust.edu.cn, M202472210@hust.edu.cn,
 dzm91@hust.edu.cn, willemb@google.com, sdf@fomichev.me

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Mon, 20 Oct 2025 09:54:41 +0200 you wrote:
> Yinhao et al. reported that their fuzzer tool was able to trigger a
> skb_warn_bad_offload() from netif_skb_features() -> gso_features_check().
> When a BPF program - triggered via BPF test infra - pushes the packet
> to the loopback device via bpf_clone_redirect() then mentioned offload
> warning can be seen. GSO-related features are then rightfully disabled.
> 
> We get into this situation due to convert___skb_to_skb() setting
> gso_segs and gso_size but not gso_type. Technically, it makes sense
> that this warning triggers since the GSO properties are malformed due
> to the gso_type. Potentially, the gso_type could be marked non-trustworthy
> through setting it at least to SKB_GSO_DODGY without any other specific
> assumptions, but that also feels wrong given we should not go further
> into the GSO engine in the first place.
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: Do not let BPF test infra emit invalid GSO types to stack
    https://git.kernel.org/bpf/bpf-next/c/04a899573fb8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



