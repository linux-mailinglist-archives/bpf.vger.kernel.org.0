Return-Path: <bpf+bounces-64544-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FC3B140FA
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 19:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D154A3A36A9
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 17:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F19275B04;
	Mon, 28 Jul 2025 17:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdJCCi8o"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968AF212B2F;
	Mon, 28 Jul 2025 17:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753722599; cv=none; b=PaC670yFrGVd6sE9DQ4aZk9BpDj/4BB22M13cxz0p+jMsTro07SzTr1iB0Nw4I3LAFYSgrVTKcv6Y042HlDBIEYrZkKEIvu0eNG8Ogl5fv+oz+P6/subTbiKJFJ9d3xoouIgKtcZLd6kAIKTiVH7OrQdUBfYFXoEo2KKodVGxWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753722599; c=relaxed/simple;
	bh=R1vdApnUTa0XVkDMxZ5plGA2QUU2Wb2D1CXngx3jTyY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QeISV3V/xolgQNsVKSbTErtUkoDVtQySDuTubsszeNwyK6Hu1dty9Z/JC4o+hau8GQaI5R83a+jqV2A1m2wECT/xtAENUCFEfDMnu/12r4U9KE/7kt6AVTI2Ca4Xion1bWlFLhsSalnd3AeN0sRKuQR7jcd2jMy9K8QflQOqxLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdJCCi8o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27F3BC4CEE7;
	Mon, 28 Jul 2025 17:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753722599;
	bh=R1vdApnUTa0XVkDMxZ5plGA2QUU2Wb2D1CXngx3jTyY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kdJCCi8o5rkYpjFkCZzzrW/qUgyHJ2AWwVHYPR/FSIXBsX05imu5K5SkahpPN0q4u
	 DLxjDpwPbm3ziAtCHGE1OArrCc8Fs5J/Rnkm4vsx05FBJ83AaVaG6EyztUnklzhTVu
	 GlDOAtB2TB7xXQsS17zzECADwyVi5+vAGg8ATgDfRNZ/uqaRxEld5eqjHTJjQvgCtY
	 oMdOr2soqkZxlWV1Q02gJ9O+EkFTr/pTMOqVa9iUf1ICfE6oO/R6cIVOJL5RskPe92
	 q2BJUp1LVyMp73AbemyWXnA/RwkBNI/ut/fG1T8MaBG2xD2tEiHRTpNpgZWOl/tdNo
	 rBb2mJUyxFIPg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE7E383BF5F;
	Mon, 28 Jul 2025 17:10:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: fix various typos in verifier.c comments
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175372261550.782645.13223663463015341862.git-patchwork-notify@kernel.org>
Date: Mon, 28 Jul 2025 17:10:15 +0000
References: <20250727081754.15986-1-suchitkarunakaran@gmail.com>
In-Reply-To: <20250727081754.15986-1-suchitkarunakaran@gmail.com>
To: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sun, 27 Jul 2025 13:47:54 +0530 you wrote:
> This patch fixes several minor typos in comments within the BPF verifier.
> No changes in functionality.
> 
> Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> ---
>  kernel/bpf/verifier.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Here is the summary with links:
  - bpf: fix various typos in verifier.c comments
    https://git.kernel.org/bpf/bpf-next/c/5b4c54ac49af

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



