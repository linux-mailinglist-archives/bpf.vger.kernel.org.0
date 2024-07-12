Return-Path: <bpf+bounces-34656-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D5C92FD37
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 17:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 641111F22B4C
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 15:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C93172BCE;
	Fri, 12 Jul 2024 15:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="okbnx9o5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1194E1094E
	for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 15:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720797033; cv=none; b=rIGXACkX8G6+EO9wCNTTCcDUY8G0CCfp/SCpO5cluvQmQ25uHk7s61ZtRX9c5TE7Do19PUASqLuBTQN+qCeaU+b97NigTk+kRJJnMF+FNUDtGis0ikA5emnAM0w3XRQZGgypnsEeVVjfPm9NvmqoCXN6q/1au9gNXDXbvGucN2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720797033; c=relaxed/simple;
	bh=Tdn3t/BTGcoV97ZfjDECngQm6XE6GUHkdfUsg464APg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OfP2zbDE0hkzbhZQVcdWCPjVmYC5JgXUpukVRuQAVHP7vpfoxUicK0cpFyW7XP5I/s5AweineJG9SAzjxP9j0zmMH6vtEjZomftk8L6F2e9lM09h6JvDiK7vEYrEdYlm+CXaxoubdjQLnGnkph92D2ZaKJpSzBVij97HT3HTNs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=okbnx9o5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 90B7BC32786;
	Fri, 12 Jul 2024 15:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720797032;
	bh=Tdn3t/BTGcoV97ZfjDECngQm6XE6GUHkdfUsg464APg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=okbnx9o5ImKNamUzxNn4/Oa4C/sV3tUdna/LW9NU3LDOpluizx5k/BUEVSG+4+RLX
	 3aHR/11xW6Xz5vZQA3XTMS3VuMz92VAFnCB16DccHyTOjPf7CJv+4cOwGErmLH4YTZ
	 bmPkxKFLW1oXGfxe8TAwoafdBrngC7ijY627N07iZeckV4QQwdwM/92UbYUChLeOD9
	 zTh+BLRRqUlQspL4hd7FM10ifuqa3DHJOwdIp8wiLDxGwI9PHEOFMFnEckOkeJ+7vG
	 /M72Zmh7wgOC+yBH0ZtUOYBGZN0e1aZ8+AZlUzj7+o51V6KbWczEheMwkhuLs6xMw2
	 5l9pgy8WMHO7A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 81638DAE95C;
	Fri, 12 Jul 2024 15:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: eliminate remaining "make W=1" warnings in
 kernel/bpf/btf.o
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172079703252.7928.12025847333447557623.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jul 2024 15:10:32 +0000
References: <20240712092859.1390960-1-alan.maguire@oracle.com>
In-Reply-To: <20240712092859.1390960-1-alan.maguire@oracle.com>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 mtodorovac69@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri, 12 Jul 2024 10:28:59 +0100 you wrote:
> As reported by Mirsad [1] we still see format warnings in kernel/bpf/btf.o
> at W=1 warning level:
> 
>   CC      kernel/bpf/btf.o
> ./kernel/bpf/btf.c: In function ‘btf_type_seq_show_flags’:
> ./kernel/bpf/btf.c:7553:21: warning: assignment left-hand side might be a candidate for a format attribute [-Wsuggest-attribute=format]
>  7553 |         sseq.showfn = btf_seq_show;
>       |                     ^
> ./kernel/bpf/btf.c: In function ‘btf_type_snprintf_show’:
> ./kernel/bpf/btf.c:7604:31: warning: assignment left-hand side might be a candidate for a format attribute [-Wsuggest-attribute=format]
>  7604 |         ssnprintf.show.showfn = btf_snprintf_show;
>       |                               ^
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: eliminate remaining "make W=1" warnings in kernel/bpf/btf.o
    https://git.kernel.org/bpf/bpf-next/c/2454075f8e29

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



