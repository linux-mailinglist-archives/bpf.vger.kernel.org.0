Return-Path: <bpf+bounces-39168-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4085396FD13
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 23:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68EA41C22C0C
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 21:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5868F1D6DC5;
	Fri,  6 Sep 2024 21:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNKBz6If"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AB31B85F7
	for <bpf@vger.kernel.org>; Fri,  6 Sep 2024 21:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725657071; cv=none; b=BfnKOb2Yw8tc1LphEUJfZhxecObrRVHnbfxdUSjouIDBZU27D2kUV8QsMrjDaBWLQ6HdjFqHY06mnRYDk3lW3YX9N7C4sPCnmslSiyanue+tuQZcKDwY4qFUShA3xL0zR2nHjnv6ET2xawi4P9SbRCvodN0cUh6NZZyxsqbsgMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725657071; c=relaxed/simple;
	bh=F74NKUDoD08rQO3NDhaRvWcGFss51YWYR1c1MzMeTEo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FGOIt8GeHIYmUJZ8C+duWsFUsiZOjs9rJn5/Q/+JlssvPDlFgfeSAFgMlVUUspp9sMElVr2F5O1ncWMg4R8XPNLqK7J7ThfWVp1eDPr489l0blpkVS40CefjiTbw7mfn2UJ9du0gZOEHgQ0+Q5hGSz9lvfc0TFJ4opbJzDCIkYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNKBz6If; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E37EC4CEC4;
	Fri,  6 Sep 2024 21:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725657071;
	bh=F74NKUDoD08rQO3NDhaRvWcGFss51YWYR1c1MzMeTEo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mNKBz6IfOtLFRtVpV391Q5a0AGP9OC75PdSAl9zK+j938gUaBPGgEeoGDs3LDgaeS
	 Lnb6UW0bl5fgMN4vKp5ICg0Vop51Z57apt4zT1/y0v33/YOMUYWsySQe20UN/7kPHk
	 IKsNWywD0OvFq+M2FGYy0DPOkkA1XkZz2Hw1kseiLuxcSyJvJcfkHaWOUJo/9S6czD
	 R+I/jVzrYFuyL6rmuRN9AY9CRJXrWco2CjO7IKBxAzYk2/vvrbA8zx9EQgTx6tczFA
	 deLogUYatC0ReW/XYThfWLgBzQtv6un/HlhR+op9Psnr+V4T6TWNYjn2M5dQDLeZTk
	 So2jdPpjvvCtg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DCD3806644;
	Fri,  6 Sep 2024 21:11:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpftool: improve btf c dump sorting stability
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172565707209.2523687.3775326800001263535.git-patchwork-notify@kernel.org>
Date: Fri, 06 Sep 2024 21:11:12 +0000
References: <20240906132453.146085-1-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20240906132453.146085-1-mykyta.yatsenko5@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, yatsenko@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri,  6 Sep 2024 14:24:53 +0100 you wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> Existing algorithm for BTF C dump sorting uses only types and names of
> the structs and unions for ordering. As dump contains structs with the
> same names but different contents, relative to each other ordering of
> those structs will be accidental.
> This patch addresses this problem by introducing a new sorting field
> that contains hash of the struct/union field names and types to
> disambiguate comparison of the non-unique named structs.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpftool: improve btf c dump sorting stability
    https://git.kernel.org/bpf/bpf-next/c/f8c6b7913dfa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



