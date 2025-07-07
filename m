Return-Path: <bpf+bounces-62521-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FFCAFB7E9
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 17:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE2851896B5F
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 15:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDF92153C1;
	Mon,  7 Jul 2025 15:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFyqXRwe"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DF3215062
	for <bpf@vger.kernel.org>; Mon,  7 Jul 2025 15:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751903389; cv=none; b=QsSgEs265INZyB+n381+EnPEAu7QPcXgtUdBB+uBCWvXqoQTkXjvSd9anWNc+oDj+pSoaXw0cczzBvTcTYgaIskTAR6aSWc+YOtKcq+s45YSCBukjbXSjdnteA9D7NlESCiUS5qejUgSrha4gkIFQR6v8iyNLd78i62wsuoYPEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751903389; c=relaxed/simple;
	bh=3da5e4+r6JEx56xIWiT5UnonB6+c7cXUQnWMhwzgGq8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LcU/aWShTjMU03t8TT0rTNFjdMrAlilBwlNWBjwLPQwddnTJ115HiCpi3nAkBlStiewNwjBLFwnxry2gumBri7xp0P910DFaM2kPZjGclen3STl28/e6Qh9cQ5FoQfpDdzD/unLvLHBJI7sRwcXTA3/TdYfg67KePx9WpkSPVwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MFyqXRwe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C06DC4CEE3;
	Mon,  7 Jul 2025 15:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751903388;
	bh=3da5e4+r6JEx56xIWiT5UnonB6+c7cXUQnWMhwzgGq8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MFyqXRwe7I+QZUN71OsOQx9wsD7eTq+P3PIpg39jRJh4GFX1X2yz2UxWYNNV8AFz8
	 NzuEJjbTzBSntzsCoarCE+4ApMuz1mp+09AmoO5GnWxsnquNdHCodboe3iIHnYlwgJ
	 82LWVfOz/38lZUxlUoLMkBatEM9yCG4feh0+sC2m/bjqjed8KcOMOwd+nTPpx4J98e
	 krcr2WOyI7qs93zxdQkx2FgH8PwUJgdy2H0X6TABhY25pXNCo4qGcw2AJ86Tc1NxKP
	 I6gbO0xAc4GCmT1ZtjJyOUkhavMe+M2jAfffpJvTUhg81X8LPk01vIVFGs6uw7A4dx
	 ZGMCp/SJePxLw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD8E383BA25;
	Mon,  7 Jul 2025 15:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4] selftests/bpf: Negative test case for tail
 call
 map
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175190341151.3340086.4670967766988405188.git-patchwork-notify@kernel.org>
Date: Mon, 07 Jul 2025 15:50:11 +0000
References: <aGu0i1X_jII-3aFa@mail.gmail.com>
In-Reply-To: <aGu0i1X_jII-3aFa@mail.gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 7 Jul 2025 13:50:35 +0200 you wrote:
> This patch adds a negative test case for the following verifier error.
> 
>     expected prog array map for tail call
> 
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4] selftests/bpf: Negative test case for tail call map
    https://git.kernel.org/bpf/bpf-next/c/192e3aa14529

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



