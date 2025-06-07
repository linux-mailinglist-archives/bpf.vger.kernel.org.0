Return-Path: <bpf+bounces-59985-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3D6AD0B22
	for <lists+bpf@lfdr.de>; Sat,  7 Jun 2025 05:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3A1C1895E47
	for <lists+bpf@lfdr.de>; Sat,  7 Jun 2025 03:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48920219A80;
	Sat,  7 Jun 2025 03:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e3ATq996"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1CD2B9CD;
	Sat,  7 Jun 2025 03:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749266996; cv=none; b=FNIEhpolyZAPWB0nrpqTlC6J2FE/ILJnaW3kzMC15pBJrxAUqYNSsUu67hSitu1a3BctR+vqLj0toid5oGzr0dOucXrHKQjcF1WP6J6cz7a04DWFAEITPqeXZG4LhFM7VjetOgM/n5HYR4COJqfPcmUIgTIN4ikRs1bfIhNgpvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749266996; c=relaxed/simple;
	bh=TIl01MZ6QwJkAwLwgfNi1L7gG8/dK3TwzuDq26jaMT4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IG3eyfebkrlaolv5KXLgugnNFO+Ol7zAAphk0/SaTJnXyyQN5E0L3U++06BT6FmS1EwtWkpPrIG9QbMzMiPklm5rFOdLdh1LzibjMn931Y/cDauzwRRoglsHDiLdKWWK8jOO1L0s61SXpzbs0EyV53EU+v70F2J4YOaC+Nml4+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e3ATq996; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 402F2C4CEE4;
	Sat,  7 Jun 2025 03:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749266996;
	bh=TIl01MZ6QwJkAwLwgfNi1L7gG8/dK3TwzuDq26jaMT4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=e3ATq996x8FJO4xKtiOFQ6+KpAADHIEozwXBHlRuqRPZVQqvO5uY2uOy0Sj9iJLEO
	 ffLxxeX+V3vq3x50MekuNxKf0ip5a+sOwahKeOkbcgCfENipEh0OZ92mszlhT9TvpP
	 fiRkPSnrbVLMsFqf9lZbIiBM2zr5OZSI3Lz+SPFJcBSq5hTHCmIeniNwdae8i2J+VR
	 zkrq3By/F0WkGAV2LbnxJB0ob0P9annDIKhKaWLwSsZAGeSDUZqGxg3v0/YFl52qoh
	 JS0UyPi01ubVLEtC745OGz4h8u5WZEg+xBpZFZQyfaH0bpbmppVLZQKMnnDJrQ/9OV
	 +Bpk1r28S8zdQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF873806649;
	Sat,  7 Jun 2025 03:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] Documentation: Fix spelling mistake.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174926702776.4076603.7797789674870904310.git-patchwork-notify@kernel.org>
Date: Sat, 07 Jun 2025 03:30:27 +0000
References: <20250606100511.368450-1-eslam.medhat1993@gmail.com>
In-Reply-To: <20250606100511.368450-1-eslam.medhat1993@gmail.com>
To: Eslam Khafagy <eslam.medhat1993@gmail.com>
Cc: void@manifault.com, ast@kernel.org, linux-doc@vger.kernel.org,
 skhan@linuxfoundation.org, bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  6 Jun 2025 13:05:11 +0300 you wrote:
> Fix typo "desination => destination"
> in file
> Documentation/bpf/standardization/instruction-set.rst
> 
> Signed-off-by: Eslam Khafagy <eslam.medhat1993@gmail.com>
> ---
>  Documentation/bpf/standardization/instruction-set.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [bpf-next] Documentation: Fix spelling mistake.
    https://git.kernel.org/bpf/bpf-next/c/e41079f53e87

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



