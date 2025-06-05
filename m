Return-Path: <bpf+bounces-59787-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64514ACF77A
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 20:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E2DE18937A5
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 18:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3188B27BF83;
	Thu,  5 Jun 2025 18:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o6tNeLXb"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E4A27AC36;
	Thu,  5 Jun 2025 18:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749149399; cv=none; b=fUmsmH/rvZhggBpJ/lW+7T2GcIQUzKPH6cJiYlysBgHrMiDZAVYthnNBoWUTqgpKYMr5CPviQO4RvBuphEYtB00up5LwsnpF0c6/ZA43M3HLFhpGxpae8FfquSjX8PAstmcRsKM42GMADGXq06xYP05PcGpJWtPO2HVRSAwPfAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749149399; c=relaxed/simple;
	bh=pbq1aBxbhOTEQlMuwvx2n4uhA8uX7MJO3VGI3/YzuHM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Hv9qjyEq/1uknKrIL58uip5SLVq1e9RnpgWMwjL4Avw6+A12cpWt7hWmNaOZFwgbXQalD1uJ258eht+ChYOf8PCVvDXqLJpH58tluGPBm6rNJDX5G9/ETBA4USwyR4XIkEzR30BPx3np52WYyrZos5oajs8kvsnNXTiK2RMr8pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o6tNeLXb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 266BAC4CEE7;
	Thu,  5 Jun 2025 18:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749149399;
	bh=pbq1aBxbhOTEQlMuwvx2n4uhA8uX7MJO3VGI3/YzuHM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=o6tNeLXbqOYgfUsNc8JhCVQEP3DREsdT0rEkaBDbY8rOqBJHKJw+p1BhBpCVz1/HY
	 2nSZP0dkjBxVX7cTs/ehiLtxgZFH7nfRltzIoVyNdpJ6+hmkDi3z2NrcU5qS0ug8wh
	 uY5M26lF5a+HlbmTxqgyjYuKr68PsZAchDUFgSZmZDXUYKtME9w7prnuk3GUIZAkLQ
	 ptvxtiATyEBAlx9bYUJb11nLiNzf0loXmtZ7n9lJ3SrJPuPHDcJ61OfhhWZf+Dd92I
	 AgVGh/V8I24QG9yXXIzNQuDd5zXYJ8WlZimEhrpYh+MJyr998ZGRFnlZ5wmHpaC9Y1
	 zTaRkq7JSpjdA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3405339D60B4;
	Thu,  5 Jun 2025 18:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 1/3] bpf: Add cookie to raw_tp bpf_link_info
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174914943101.3195461.18326988295120859046.git-patchwork-notify@kernel.org>
Date: Thu, 05 Jun 2025 18:50:31 +0000
References: <20250603154309.3063644-1-chen.dylane@linux.dev>
In-Reply-To: <20250603154309.3063644-1-chen.dylane@linux.dev>
To: Tao Chen <chen.dylane@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, qmo@kernel.org, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue,  3 Jun 2025 23:43:07 +0800 you wrote:
> After commit 68ca5d4eebb8 ("bpf: support BPF cookie in raw tracepoint
> (raw_tp, tp_btf) programs"), we can show the cookie in bpf_link_info
> like kprobe etc.
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/3] bpf: Add cookie to raw_tp bpf_link_info
    https://git.kernel.org/bpf/bpf-next/c/2fe1c5934736
  - [bpf-next,v3,2/3] selftests/bpf: Add cookies check for raw_tp fill_link_info test
    https://git.kernel.org/bpf/bpf-next/c/25a0d04d3883
  - [bpf-next,v3,3/3] bpftool: Display cookie for raw_tp link probe
    https://git.kernel.org/bpf/bpf-next/c/9c8827d773bf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



