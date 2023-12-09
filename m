Return-Path: <bpf+bounces-17299-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3B280B160
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 02:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98DC8B20CC5
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 01:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F4D810;
	Sat,  9 Dec 2023 01:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+pwdwK1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8ED57F8
	for <bpf@vger.kernel.org>; Sat,  9 Dec 2023 01:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55879C433C7;
	Sat,  9 Dec 2023 01:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702084824;
	bh=5Ry9s3W8st1mB3Kc4YiBlMHwC2NLz2LYF5YbyEIvIcc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m+pwdwK1x3bY89vfkmI3hWBpdhZtgE/YP+1hxLRlaxjxMIY3oephVfs7COfbNoOHu
	 t5c1wBIVuByEjtkRPGaRNihDd/oRk7+6Hjj3ON8exJMWny12wu7P59rvJ0s/Whetnb
	 JiqGHT1e9plxvA0dpTpcp2WxbmVo29Qfu3EfPcYnP/bmvSwtffCnqOwXOqTEdJvbdR
	 u8LjE9t/a3z/BMq5LGxjt6OMsue9wjr2rgmd/4cqs2ZCWLapSVgwhstAktnkW2jZGG
	 C6xfhJL8UnnGgRU28ZDI1z1yCA4gvRigZEaBitvLwjKThFDvpeRhRmuHmy0aS82nTw
	 Ab7lNV4Y8ogKA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 39C23C04E32;
	Sat,  9 Dec 2023 01:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] libbpf: add pr_warn() for EINVAL cases in
 linker_sanity_check_elf
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170208482423.18108.3043597727814423980.git-patchwork-notify@kernel.org>
Date: Sat, 09 Dec 2023 01:20:24 +0000
References: <20231208215100.435876-1-slyich@gmail.com>
In-Reply-To: <20231208215100.435876-1-slyich@gmail.com>
To: Sergei Trofimovich <slyich@gmail.com>
Cc: bpf@vger.kernel.org, eddyz87@gmail.com, linux-kernel@vger.kernel.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri,  8 Dec 2023 21:51:00 +0000 you wrote:
> Before the change on `i686-linux` `systemd` build failed as:
> 
>     $ bpftool gen object src/core/bpf/socket_bind/socket-bind.bpf.o src/core/bpf/socket_bind/socket-bind.bpf.unstripped.o
>     Error: failed to link 'src/core/bpf/socket_bind/socket-bind.bpf.unstripped.o': Invalid argument (22)
> 
> After the change it fails as:
> 
> [...]

Here is the summary with links:
  - [v2] libbpf: add pr_warn() for EINVAL cases in linker_sanity_check_elf
    https://git.kernel.org/bpf/bpf-next/c/32fa05839862

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



