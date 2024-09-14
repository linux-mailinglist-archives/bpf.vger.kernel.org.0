Return-Path: <bpf+bounces-39886-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AEF978D01
	for <lists+bpf@lfdr.de>; Sat, 14 Sep 2024 05:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A58CB285C2D
	for <lists+bpf@lfdr.de>; Sat, 14 Sep 2024 03:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F16F1759F;
	Sat, 14 Sep 2024 03:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cve48Wgn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F6B8462;
	Sat, 14 Sep 2024 03:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726283429; cv=none; b=aaxEzm5Lo/slwVn9zVGl8cBqjIHIVzQhk5/WIyfiCyn7oSSApSeGC7Fm996wMtlTETi5YtUNG8HKTJ2RFDSVmyot6TUxkHWpbK7gCad8rM3rFinu8rQ8QH8nze24Eq/tEuSgqCiRAAgH5+TrK6iE7kp6Ol3vfT3G11hn2HHwk2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726283429; c=relaxed/simple;
	bh=DyEgc3d/VLDrSlr8tQW+qSGWD4Nni9C1Kv9VIi8oNpw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ur+YJYqj72B0L7gwLLAF4aCsqd0AOiB2hO90GczTHOf7D6c3TB+P65eeSh4tKMu9eiCAH1fY1wehvf5C0ZDVZZK5yXqgX1HSOGGEIBJP9RxCjl8PZe67OGmNg7TxN2zYFJpiCIYNQOq136Ti6ApSYA3y4OJCnYOYVY71xl57VzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cve48Wgn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B17FC4CEC0;
	Sat, 14 Sep 2024 03:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726283429;
	bh=DyEgc3d/VLDrSlr8tQW+qSGWD4Nni9C1Kv9VIi8oNpw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Cve48WgnXe4vwJT4UKVVv7wSXBjqhttPghwiZA+UlsBYmg3FneeInkpC052Fzg/xh
	 2GPGp4qRxBDaYPGlwnnzmEIn9qiY0gsQ5TpS8iDIuuo8+jjjzsBlkwN46344tWRNFE
	 uKbXaFjRX7CU3znNoKjcpgewi7Sngz7NHvglvhTnr95ggVWeQYlsAPePLLYez44gsV
	 VfPrIqr3Vum+xIxJ1vE8iYFu160VwpKeMr3ovJwUir5iWs1dq7yXWjyWHgrbt29ZzF
	 YCHUcI9VALX/eD2LF0Q/mqFu4GK7s+lydUNGpw2aXLxgGBsB46dDP/RCkkAtiPh7AB
	 Vjhbb2gVN58/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB2403806655;
	Sat, 14 Sep 2024 03:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/3] btf: remove redundant CONFIG_BPF test in
 scripts/link-vmlinux.sh
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172628343077.2438539.18220678074751617298.git-patchwork-notify@kernel.org>
Date: Sat, 14 Sep 2024 03:10:30 +0000
References: <20240913173759.1316390-1-masahiroy@kernel.org>
In-Reply-To: <20240913173759.1316390-1-masahiroy@kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: martin.lau@linux.dev, bpf@vger.kernel.org, andrii@kernel.org,
 linux-kernel@vger.kernel.org, nathan@kernel.org, alan.maguire@oracle.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 14 Sep 2024 02:37:52 +0900 you wrote:
> CONFIG_DEBUG_INFO_BTF depends on CONFIG_BPF_SYSCALL, which in turn
> selects CONFIG_BPF.
> 
> When CONFIG_DEBUG_INFO_BTF=y, CONFIG_BPF=y is always met.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> 
> [...]

Here is the summary with links:
  - [v2,1/3] btf: remove redundant CONFIG_BPF test in scripts/link-vmlinux.sh
    https://git.kernel.org/bpf/bpf-next/c/c980dc9c67a9
  - [v2,2/3] btf: move pahole check in scripts/link-vmlinux.sh to lib/Kconfig.debug
    https://git.kernel.org/bpf/bpf-next/c/42450f7a9086
  - [v2,3/3] btf: require pahole 1.21+ for DEBUG_INFO_BTF with default DWARF version
    https://git.kernel.org/bpf/bpf-next/c/5277d130947b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



