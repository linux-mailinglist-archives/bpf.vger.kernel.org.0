Return-Path: <bpf+bounces-38330-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8179636CA
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 02:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88D811C21A1B
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 00:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC71DF5B;
	Thu, 29 Aug 2024 00:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZcRbJ2j"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F4CDDA0;
	Thu, 29 Aug 2024 00:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724890828; cv=none; b=lP2a0J8pCdCpRRrFOtLPbFzJxIUVs1eE+isBmcN4Bzjsn06wONj4YaQHSuIUdGiB7PoKgs8VE/KlNyjvcT0BvSrdriH9kHCyJDIKJ9ia1de0kmAYtOn9SgpBqCcfrQe9Pj3PBJ/2uybKPcH/iL1uAhtgKuVv9C+75MXbJAF8BIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724890828; c=relaxed/simple;
	bh=v7Vfq1FLzxcvFPHCYrnDbiAC/1KXvziYWaPf/6uFy8Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=n3ghCKpzom4O/zXeJ445nFJTuvDjlY3P8sTB7OtkqEevyIHcB37iTr7UpTgH/y2kAWsZjKCurPTmWxmD8MotGSJdYq15qZGnspyEOlf1QsBJlrEy7+2oLt76m5Msif8KwWGvD1y5tziEz+nsq+1KA4JawOXq2wLj9SfJzSIN75Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZcRbJ2j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA55C4CEC0;
	Thu, 29 Aug 2024 00:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724890827;
	bh=v7Vfq1FLzxcvFPHCYrnDbiAC/1KXvziYWaPf/6uFy8Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nZcRbJ2jsGJN4sPSltjMo6y5duw6Kn770ppSl8E6AE0Zv3At9ylppaqi4dEH6aZ7X
	 GgZjgAPgP53lBjZaQQUvBQUlBdyRpasuHKOfV6kNPiloTB288gabs5Z4A4pbGiDAg7
	 nm99zpEWjhTGck2wkM/CTGttC88YYw4O2P4uSbnelfnCNo6N0Uj/gmEOF0hQ7gEixL
	 lyUglcUCu7wZDcbjoCmWK2Ab46kjmTj6fgc1PWxwtyQITzj8eV8zA/d3SgVuoaX+Bf
	 Q9XLo2xWGLX0bOz/CcgmZvi4mNKScvk81wyGMZx3ylPRzR8ekTfDiF29iXvHwyBs2M
	 7ofACViKKM2YQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 341273809A80;
	Thu, 29 Aug 2024 00:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Relax KF_ACQUIRE kfuncs strict type
 matching constraint
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172489082801.1473828.12809886195574675697.git-patchwork-notify@kernel.org>
Date: Thu, 29 Aug 2024 00:20:28 +0000
References: <AM6PR03MB5848FD2BD89BF0B6B5AA3B4C99952@AM6PR03MB5848.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB5848FD2BD89BF0B6B5AA3B4C99952@AM6PR03MB5848.eurprd03.prod.outlook.com>
To: Juntong Deng <juntong.deng@outlook.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, memxor@gmail.com, snorcht@gmail.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 28 Aug 2024 20:48:11 +0100 you wrote:
> Currently we cannot pass zero offset (implicit cast) or non-zero offset
> pointers to KF_ACQUIRE kfuncs. This is because KF_ACQUIRE kfuncs
> requires strict type matching, but zero offset or non-zero offset does
> not change the type of pointer, which causes the ebpf program to be
> rejected by the verifier.
> 
> This can cause some problems, one example is that bpf_skb_peek_tail
> kfunc [0] cannot be implemented by just passing in non-zero offset
> pointers. We cannot pass pointers like &sk->sk_write_queue (non-zero
> offset) or &sk->__sk_common (zero offset) to KF_ACQUIRE kfuncs.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] bpf: Relax KF_ACQUIRE kfuncs strict type matching constraint
    https://git.kernel.org/bpf/bpf-next/c/f633919d132c
  - [bpf-next,v2,2/2] selftests/bpf: Add test for zero offset or non-zero offset pointers as KF_ACQUIRE kfuncs argument
    https://git.kernel.org/bpf/bpf-next/c/6db59c4935c9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



