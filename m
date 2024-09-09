Return-Path: <bpf+bounces-39374-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F21972583
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 01:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D39221F24421
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 23:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CDF18E053;
	Mon,  9 Sep 2024 23:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCu9h0bw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAD318E029;
	Mon,  9 Sep 2024 23:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725922831; cv=none; b=jhQRCMZvQyS0ZQ+u+a0F2ti1rEZmn29yAtdl7ubg3AVHuFT9+G0+CMyh6XDO62dsXqu8oeElZCpV6VEBNdUMcG4t3YXhky7QoMJ6W0GUxPO1YDcat1WM+FfMfY647o/GkmnoxcABzdOCdy4QP6OrF+A5mhZA4PU/Xa+AVBgXkgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725922831; c=relaxed/simple;
	bh=pf7xzqP7Y1hsXvR+kYPtuMst3jnXUpiYLj5ZARh5Zao=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=vBrCb9aNmzrPrhtcfmpMQClEv/ygL+/W1U3lbWUCw2qVZVZX618/Lx2CU8nqioJAvYCRjHaF7NqF+OVGzADh7vRTLnxQvUkGUM7sr/VZ0w4gJ7pNW+tbRwc0gKFbdn5WnZci+H1buXO9w73doj2RApAJyoij9Y/OFuHCoVZ7Dyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZCu9h0bw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C6E0C4CECA;
	Mon,  9 Sep 2024 23:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725922830;
	bh=pf7xzqP7Y1hsXvR+kYPtuMst3jnXUpiYLj5ZARh5Zao=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZCu9h0bwTASNqqTCcK9ADR++pqNCxqT+3R3uZ19QWQ2OtpzQ6ThhsKIj+rPD2scdG
	 OBNZct0I+lA4/I4Vsp3gxH/01f7VoyD2KDAhTcbZT6sAKeFnFte3VmK8vj1KVHjJt+
	 FXppGqFp42cSnhDdDWvy9dEXDKIceMSjKYGnXICpDgO4ZRkmZwBTP/TAjMouQTx5ji
	 YQQTh+g1EbA++vWz6YjXPXUtLBew03kDS5FMyeRGUByCQur1N6+/eMmIbm/hsqXMIz
	 DFOaEDuBk6p2dMft4E8is5MoYmvmgF3Ct84zBexKmLjI6mn558h3nNKLaHGHEe/eki
	 CjKuCOG0pLL2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7105B3806654;
	Mon,  9 Sep 2024 23:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] bpftool: Fix typos
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172592283100.3949024.11403579453952470139.git-patchwork-notify@kernel.org>
Date: Mon, 09 Sep 2024 23:00:31 +0000
References: <20240909092452.4293-1-algonell@gmail.com>
In-Reply-To: <20240909092452.4293-1-algonell@gmail.com>
To: Andrew Kreimer <algonell@gmail.com>
Cc: qmo@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 willy@infradead.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon,  9 Sep 2024 12:24:41 +0300 you wrote:
> Fix typos in documentation.
> 
> Reported-by: Matthew Wilcox <willy@infradead.org>
> Reported-by: Quentin Monnet <qmo@kernel.org>
> Signed-off-by: Andrew Kreimer <algonell@gmail.com>
> ---
>  tools/bpf/bpftool/Documentation/bpftool-gen.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [v2] bpftool: Fix typos
    https://git.kernel.org/bpf/bpf-next/c/f028d7716cde

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



