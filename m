Return-Path: <bpf+bounces-34599-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE7192F109
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 23:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 090781F23EED
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 21:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8974619EECC;
	Thu, 11 Jul 2024 21:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qAc7kFCP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136DC155741
	for <bpf@vger.kernel.org>; Thu, 11 Jul 2024 21:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720732832; cv=none; b=XkQHGqHTODsnHfE/GEyCoaGf5EcOLO07bxy2pPC8ORQXgd8/P1ngb5yffQMTHM7ZPBDVMKjJGCg2036Jx7yr/5lZyTd7LoZGHks3m/Yk8TGEAocjRHDKZFHNBNyU/yQd3qJUBF+3GNfgXIi9iUdEroXH/OhjerzQ3rtWUa885Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720732832; c=relaxed/simple;
	bh=knf1GEb+pVou8jKxLKgDbBpZg/YVMKmAWHrpukQ5xX4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lXdc/R4N9jIoaZ5ke9AULHSiu77Lo7Hdu60CjtWiRtTZVuCTVXi9E6O2GFIzuxAV248D6NGbB1Qj55xAMj4W5Yd3wwEBf4TRmQHpJepU16WeP0ELraLPZcK+tR/ba/9a6BB6EjUI2LwCNX6FQrZJ4CbGG1bHbE/PAVfQmB0EIzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qAc7kFCP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id ACB7BC4AF09;
	Thu, 11 Jul 2024 21:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720732831;
	bh=knf1GEb+pVou8jKxLKgDbBpZg/YVMKmAWHrpukQ5xX4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qAc7kFCPAKnIp2Bx055sfz1TncrHbeE0YVXH4HZB6da0At2sA5r5OAKxOH6PHaTo0
	 UyLnOiBdpkrx4MiXbjpKL/1zAhmT9bQESvN22MbqVM6dKoST6AMZ5v/+4aiJHa5siA
	 DFS/MZpVOa45Huj4ieZbLOtzCjGH0dINnoo0OZCCNQyaOrgteBaUID/pROW8H4+WFN
	 5XbAqRhBrN0UsNokazKnBV4szVZB4zJszEqBw8QP7O8JjZmbIny4KTshoFnQsE8Y4Y
	 gvdUPyrEytenVS79a16HhmtyiNfD3/TVKqc5xlOHPag/6JqQ+hAZ+RqRB1Vcgn/daz
	 t+9q0etMZ7aOQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 94436C433E9;
	Thu, 11 Jul 2024 21:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: annotate BTF show functions with __printf
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172073283160.29568.3699886456998663650.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jul 2024 21:20:31 +0000
References: <20240711182321.963667-1-alan.maguire@oracle.com>
In-Reply-To: <20240711182321.963667-1-alan.maguire@oracle.com>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 mtodorovac69@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 11 Jul 2024 19:23:21 +0100 you wrote:
> -Werror=suggest-attribute=format warns about two functions
> in kernel/bpf/btf.c [1]; add __printf() annotations to silence
> these warnings since for CONFIG_WERROR=y they will trigger
> build failures.
> 
> [1] https://lore.kernel.org/bpf/a8b20c72-6631-4404-9e1f-0410642d7d20@gmail.com/
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: annotate BTF show functions with __printf
    https://git.kernel.org/bpf/bpf-next/c/b3470da314fd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



