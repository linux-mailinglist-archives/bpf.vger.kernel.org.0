Return-Path: <bpf+bounces-61754-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 169B6AEBC69
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 17:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D7611C60C00
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 15:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDB02EA148;
	Fri, 27 Jun 2025 15:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bM/RQrMy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AEE2E9ED6
	for <bpf@vger.kernel.org>; Fri, 27 Jun 2025 15:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751039380; cv=none; b=WbeWe8v3BNy06PR1r6dTsZZWP0YEKd7wo43F0P/yAu7dWNcbV0WmP3L+V6tihDzk5bztfMzDBuaZ2cQchpdi8ZAkGQV716IviFjb8LWJQBxDUYZjhzxrmrWj+8CgbPkj6bHE0BfCAn/QYbhM/NLP0YlyxR7n4X8O/jw8kHbKs6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751039380; c=relaxed/simple;
	bh=mHCvBl0IcBRxOCVZxlmB0IN+ZeUT8cXgmpB9GAf+0bw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rUnvPLCp11eMfoVL3Cl2J0yQkureu+SihwpOH+JMT2cA+TbxGhbrz6TIX0S1nsk28VzGTda6uYbqu+IHaaoq18pNesp3f+RBShMKX4aPnjWUv9D3o/x7J+3vFLbcTyi/t4kA2AnC5wVT0qa66/utuv9M+7NHCC4eL9dKzn3VfLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bM/RQrMy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB914C4CEE3;
	Fri, 27 Jun 2025 15:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751039380;
	bh=mHCvBl0IcBRxOCVZxlmB0IN+ZeUT8cXgmpB9GAf+0bw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bM/RQrMyPmypiL1q3xVHZY24nVUhXXacUzsdWyeSNYE65fe3iZ3UXnH3syCQyD9OP
	 1ildE9sEoyDUMlsHgbjGFFZuCRePN3oiDVmDgkcWiPTYrxHLqy8d4ok6+Gzy2yA7eq
	 aLtyULH8XFHBJTuf191GHffqJTw7h45KSxIGlTeB/qQLo+UF7Q5p7u4hqsu7djY1pm
	 55vANz0hFl92K4sCXwzSpq5aiMA7o1n3iMb2BL+EVfByhfaBiaCw8yiYZ+2oNTzIrg
	 35tv11z0pnrUZfJtlfe/iAQIlGL0J1QLVoJsykEU6H1AWlfNwkpo2VpSjFKcHwrSxe
	 GTjcYoUIz8ISQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33AA8380DBEE;
	Fri, 27 Jun 2025 15:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Fix string kfuncs names in doc comments
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175103940601.1972453.4029054511124149314.git-patchwork-notify@kernel.org>
Date: Fri, 27 Jun 2025 15:50:06 +0000
References: <20250627082001.237606-1-vmalik@redhat.com>
In-Reply-To: <20250627082001.237606-1-vmalik@redhat.com>
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, sfr@canb.auug.org.au

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 27 Jun 2025 10:20:01 +0200 you wrote:
> Documentation comments for bpf_strnlen and bpf_strcspn contained
> incorrect function names.
> 
> Fixes: e91370550f1f ("bpf: Add kfuncs for read-only string operations")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/bpf/20250627174759.3a435f86@canb.auug.org.au/T/#u
> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Fix string kfuncs names in doc comments
    https://git.kernel.org/bpf/bpf-next/c/5272b51367ea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



