Return-Path: <bpf+bounces-35102-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 463B3937BBB
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 19:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E47681F22613
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 17:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230E31474A5;
	Fri, 19 Jul 2024 17:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZUImu2Z"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93572146A9B;
	Fri, 19 Jul 2024 17:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721410832; cv=none; b=CSp4c5fdaSid1fWsmCAdHp+2y4SLI5pUAvj9f2zWTN3SbDHnts6UmCcLL/GWH7ItaYhHcYUzYis/z+iZ8PKmBfAB6YZP20UkSnEi6OWEYvCcvKVbsNS4TiB/FLR3H97131JGsYBGuXUIYJI1rGd5HScXiNeWVRLPVwyiJ2mX+RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721410832; c=relaxed/simple;
	bh=TjfN75utI1HAwRWIlmMQLKY2x3790Gbf9MewzLevCbo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UZRllrvyMVr9WsNjEw9mXPQxlAGtS1xVDquBw9q74KhOapcbhl1pzJa7PgWlkIKvwTPAjh/R5t5r4pmGpinslJxfVvQUJRSAeEv/JE6kC/4fJ/ww9PthRwIeMBqoRp6HoMlLNUpUBEYMlzS+OqbkXKcI0fw0y9TS2YYbMLRg7VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZUImu2Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4B62CC4AF0C;
	Fri, 19 Jul 2024 17:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721410832;
	bh=TjfN75utI1HAwRWIlmMQLKY2x3790Gbf9MewzLevCbo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CZUImu2Zj/xxiDthBIrpnxL9TZEWDwoAcVQ+gKVudo+65assb+NU/6cVhmzFP8gG0
	 a9Aa7ANg2SDN+K+Rd8L43NlbqT8K8XKJaLWF5VVFOY5HziY8+Seel5vt9G94qEmTZY
	 Zqc4IiA4FlUkCQqmiut7g5mGXv/9UMAl2qp2qHnF3+amC0k59/g4pxRjjdJFovc7Za
	 QLDJGLIQHSajo8cGJCj+KJ0u+n+ywq1nJK1x/hiS59UQMuPBvpCHT8G1zcpzhDP5nw
	 TLN1eZcOr1qkOTjzo2sKBp9HhmlITFCu8IQa+SWPmb3hS1waGzW928K3V1gQXQVkw0
	 ixZz5Z0ajiVtA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 395A8C4333D;
	Fri, 19 Jul 2024 17:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: Simplify character output in seq_print_delegate_opts()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172141083222.15079.8073585538848691989.git-patchwork-notify@kernel.org>
Date: Fri, 19 Jul 2024 17:40:32 +0000
References: <abde0992-3d71-44d2-ab27-75b382933a22@web.de>
In-Reply-To: <abde0992-3d71-44d2-ab27-75b382933a22@web.de>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: bpf@vger.kernel.org, kernel-janitors@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org, christophe.jaillet@wanadoo.fr, daniel@iogearbox.net,
 eddyz87@gmail.com, haoluo@google.com, jolsa@kernel.org,
 john.fastabend@gmail.com, kpsingh@kernel.org, martin.lau@linux.dev,
 song@kernel.org, sdf@fomichev.me, yonghong.song@linux.dev,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 15 Jul 2024 11:20:27 +0200 you wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 15 Jul 2024 11:12:30 +0200
> 
> Single characters should be put into a sequence.
> Thus use the corresponding function “seq_putc” for two selected calls.
> 
> This issue was transformed by using the Coccinelle software.
> 
> [...]

Here is the summary with links:
  - bpf: Simplify character output in seq_print_delegate_opts()
    https://git.kernel.org/bpf/bpf-next/c/51f1bb929647

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



