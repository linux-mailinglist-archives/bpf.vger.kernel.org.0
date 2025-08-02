Return-Path: <bpf+bounces-64949-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A7FB18A10
	for <lists+bpf@lfdr.de>; Sat,  2 Aug 2025 03:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0510AAA3B22
	for <lists+bpf@lfdr.de>; Sat,  2 Aug 2025 01:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F1713B7A3;
	Sat,  2 Aug 2025 01:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fngj/bq9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7884414;
	Sat,  2 Aug 2025 01:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754097299; cv=none; b=mmwRnSAaLHdEDngF7yQkmLLCXw8D5DDl1MlhbDqy/pNwxb/ur/wEecBCXBQE/oiaKD9nIE+T0IXIRO+nfNX7DjG6/dYp0zPAxNAIicLwsbA1zn5sA7g8w/swwwkUvJjebo68WA/YOKJ1SNkPKDnrHIBhGAJMUkdgoTvI4ifGVWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754097299; c=relaxed/simple;
	bh=O1IrQpiIYWlCiF6kCrG1Oq38yPMAFJho8WfQbTZhxg4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cJUvWhao3ImMhULkacjvGl8BSj7rUsyv2Cp8NbamTIabsIHqcqCLMIIwhjzGARZaPXJU97x/L948FNdiTFc9G53snNlHccUO49VCC3TO/h44a3dJbNJjst5s9ZOfNj7lrijuQPQzwQRbUyI+HXMzQvxqV/uVoIrKgfa1T3S2C18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fngj/bq9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0656C4CEE7;
	Sat,  2 Aug 2025 01:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754097299;
	bh=O1IrQpiIYWlCiF6kCrG1Oq38yPMAFJho8WfQbTZhxg4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Fngj/bq9K6S5OShqpy6iV/TmrNKnBfZI+k0ai3SZxZfZ8lyMXQuFkKeKBXsqnw/Zx
	 VqZooREr2hFEFnOq/zOI/snLMsYorK2To3I5KP8Ak9Cq5Eu4JwEDsj0LwkU/Ng09Uc
	 SgkO2I7sowjMOT5F6A5qlbtiymgIpd0rDDVHRONOkwnISXV/juwYd8i8gyR5GYccsF
	 JORCo76hrnw2jrCbrU81ujY+GVgq8IhJpzfo2X0+SJ6m/NB2OAT1BFLaWcA4i2qZYv
	 pSRvcyCfvbxfUwEjexLiaoZMXEvmXgQGdCxMszYd7K7vFJCwFt8YoUMqOLiGkWvMyw
	 zaYcIHjAUcMqQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C8A383BF56;
	Sat,  2 Aug 2025 01:15:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 1/3] bpftool: Add bpf_token show
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175409731401.4179816.14714600690863735034.git-patchwork-notify@kernel.org>
Date: Sat, 02 Aug 2025 01:15:14 +0000
References: <20250723144442.1427943-1-chen.dylane@linux.dev>
In-Reply-To: <20250723144442.1427943-1-chen.dylane@linux.dev>
To: Tao Chen <chen.dylane@linux.dev>
Cc: qmo@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 23 Jul 2025 22:44:40 +0800 you wrote:
> Add `bpftool token show` command to get token info
> from bpffs in /proc/mounts.
> 
> Example plain output for `token show`:
> token_info  /sys/fs/bpf/token
> 	allowed_cmds:
> 	  map_create          prog_load
> 	allowed_maps:
> 	allowed_progs:
> 	  kprobe
> 	allowed_attachs:
> 	  xdp
> token_info  /sys/fs/bpf/token2
> 	allowed_cmds:
> 	  map_create          prog_load
> 	allowed_maps:
> 	allowed_progs:
> 	  kprobe
> 	allowed_attachs:
> 	  xdp
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/3] bpftool: Add bpf_token show
    https://git.kernel.org/bpf/bpf-next/c/2d812311c2b2
  - [bpf-next,v4,2/3] bpftool: Add bpftool-token manpage
    https://git.kernel.org/bpf/bpf-next/c/b7f640084916
  - [bpf-next,v4,3/3] bpftool: Add bash completion for token argument
    https://git.kernel.org/bpf/bpf-next/c/f3af62b6cee8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



