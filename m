Return-Path: <bpf+bounces-55341-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EC8A7C125
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 18:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45C277A82B6
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 15:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D0F1FF5FC;
	Fri,  4 Apr 2025 16:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYDRNRZ6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57231FF1DF;
	Fri,  4 Apr 2025 16:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743782401; cv=none; b=XRMKEMNS4AchN6MAgb+N2QPKobsto05tIF9NgnYhYkvvmYfjFEBiIaVwJhAW9kb5piXUyyugo10N7gUw83cKtA7OEC8Xzo6Po84EZVvzgEz/jBbg9wOrvtFYwPTS4Fo/2Yo8DpANPigPCNMJXKcYzkBfyoSShKStETkInbTwnc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743782401; c=relaxed/simple;
	bh=nQdFXXIKaoERhNWeH43Oq8QQ94Ak0dMDb/oiWCWAxpk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FYIwpSv3wDRGKCr07DNWpsKN6cvshSNUA0rnBVCQ6eTDUQPxtqoz/t+Gs3z2uCBE2iQidS9eaH8l7f1R6cPxHeH9trJZAkbWlwO11sy5u0M41fi5uOYlQ1VlrlO8hse4uao1XiGo/jdnTduBSZe0cmu8BbW7G0yuNNYIjp8SljY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYDRNRZ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25DC3C4CEEB;
	Fri,  4 Apr 2025 16:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743782401;
	bh=nQdFXXIKaoERhNWeH43Oq8QQ94Ak0dMDb/oiWCWAxpk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OYDRNRZ6CqFRxk9QUsNYoymJb3uooyCGTL1HA7texa23Ova4Qgm53s46qF+DFWlCp
	 YQTeIoj0wLuttBfk+sA5popK6C8vbGmGhCwCcDqEx7Jvjndb9Z5RiV3YmN7kZY3aD6
	 PvYpWlMJoELa2heVAxSMON/dVO9ACNn3/z7PMU4aDZEzi6mnkvsRs5ufGyi1NPH6kl
	 be9L+WBCwdgNOQsIHAGtFj6dqHTVRdlzhVLEtuwfCmj13pPaJei5mKrIhyVI5FVeF3
	 QjYMMow7Ricks62i9/eVLb0gE614QhIjgZ0XvLuRojli0GpxFWcnBVMTR0Im7gyCpQ
	 yc2eJuPjnw4vA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 717203822D28;
	Fri,  4 Apr 2025 16:00:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] libbpf: Fix implicit memfd_create() for bionic
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174378243803.3310001.18332336515872982400.git-patchwork-notify@kernel.org>
Date: Fri, 04 Apr 2025 16:00:38 +0000
References: <20250330211325.530677-1-cmllamas@google.com>
In-Reply-To: <20250330211325.530677-1-cmllamas@google.com>
To: Carlos Llamas <cmllamas@google.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, ajor@meta.com, linux-kernel@vger.kernel.org,
 kernel-team@android.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Sun, 30 Mar 2025 21:13:23 +0000 you wrote:
> Since memfd_create() is not consistently available across different
> bionic libc implementations, using memfd_create() directly can break
> some Android builds:
> 
>   tools/lib/bpf/linker.c:576:7: error: implicit declaration of function 'memfd_create' [-Werror,-Wimplicit-function-declaration]
>     576 |         fd = memfd_create(filename, 0);
>         |              ^
> 
> [...]

Here is the summary with links:
  - [bpf] libbpf: Fix implicit memfd_create() for bionic
    https://git.kernel.org/bpf/bpf-next/c/75011ad69bc5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



