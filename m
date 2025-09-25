Return-Path: <bpf+bounces-69781-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D22EBA1A74
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 23:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 829123A58E2
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 21:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24311322C97;
	Thu, 25 Sep 2025 21:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXhahbr8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A4E322A3B;
	Thu, 25 Sep 2025 21:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758836412; cv=none; b=RrR4pRqbIObh/R5iiCwDKEmX5YMib1t8k1WnJiQKPfawwQJ25fXC1mXCOELJDvCVgifgDhCHm9od+7+Tv56qx7TB7U5vz8OaFoGOXh+yMqNj+mUu/SJ4v/ib7PGlT7vMAFfMT7P/ZD3TY8pnWvbJ83Kv3rHH5lFiHZFV2DasIjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758836412; c=relaxed/simple;
	bh=gSSrGyBBpdLbSXuc/SA7gWEgUI6TZMIVWi/no3LmN/o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jRjdKh3jwp7nQ+McoFPcQ1KOQuMFtsMyfZedtsTXzyJaZbYaSjKJIDJxjLX9nt1GDO+R+HFblNe+a7CTOTzn40lQqfJ9+zhxw416sh1vreqHAKqGHuWa/BhIMMkMIdB0k04m5hA7zOh/DrWrD9Gm8H1JMz+dYLmb+cV5DNOXDKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VXhahbr8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2637FC4CEF0;
	Thu, 25 Sep 2025 21:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758836412;
	bh=gSSrGyBBpdLbSXuc/SA7gWEgUI6TZMIVWi/no3LmN/o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VXhahbr84AaQ8VoH0D/DcBbQ9IhDP0CnrWx7QHFKmPfoVkKn+9ekPAmKkZd92CY3v
	 VMYxIB9DX7GWJkEqJrjmAOTSNZTXmtGti9SpDeyTRJnhhIsElk3rCf1aVcEo2x/VgW
	 4Bjcqx7zRIhC9ByfVimC8ufnh/UVGhAxzjVNF6f5E7NwBNMygBxVVrcckPE+XGVDpP
	 L/buZ5YpeaNakWfRG5GSOoMeb5ZlE3VaQdPMwDK3jbRZ0rMXD7BFHe0XEQ2jb3pRbX
	 /Q5ZqlIX5IiH53OgBiIIhMpPv23YsR+wbDXKlr36synt0eWESScXKwwtDdheqBtLSR
	 djMzHbM37L9zg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DAB39D0C9F;
	Thu, 25 Sep 2025 21:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/2] bpf: Emit struct bpf_xdp_sock type in
 vmlinux
 BTF
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175883640801.3525190.13922850394504839816.git-patchwork-notify@kernel.org>
Date: Thu, 25 Sep 2025 21:40:08 +0000
References: <20250925170013.1752561-1-ameryhung@gmail.com>
In-Reply-To: <20250925170013.1752561-1-ameryhung@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com,
 andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
 kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Thu, 25 Sep 2025 10:00:12 -0700 you wrote:
> Similar to other BPF UAPI struct, force emit BTF of struct bpf_xdp_sock
> so that it is defined in vmlinux.h.
> 
> In a later patch, a selftest will use vmlinux.h to get the definition of
> struct bpf_xdp_sock instead of bpf.h.
> 
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf: Emit struct bpf_xdp_sock type in vmlinux BTF
    https://git.kernel.org/bpf/bpf-next/c/bc8712f2b525
  - [bpf-next,2/2] selftests/bpf: Test changing packet data from global functions with a kfunc
    https://git.kernel.org/bpf/bpf-next/c/9b5c111c3cd6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



