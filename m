Return-Path: <bpf+bounces-33501-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55ED091E373
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 17:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1788D282E72
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 15:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6675116CD2C;
	Mon,  1 Jul 2024 15:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pxxPALGx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51F616CD12
	for <bpf@vger.kernel.org>; Mon,  1 Jul 2024 15:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719846629; cv=none; b=V9JnspBER2sYUEFRU6X35RjyqepF9Av6BrBP36EPjxN1cqbXqUQCEow14dmWkEcF0YXCGFqv9nG/0KfrRxTY7/lF2QdQQi43JTOl3eWp5KZiT9uzL7eqpcFERuYfEA+9+BMheAwmxgWrCa/q+MjVpLHtn+l6UkdFqefeQgj5lLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719846629; c=relaxed/simple;
	bh=H1BDaOVnPwmuDwssrxKeT9EVEBeIKv29CV3OV2Tg7/g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Rhrqd8R78G0yNB7806ufxkwe4uQpt7d3VcWTikCclqLqMhxZQ6fNITiA8pNi5FRhe5UubeL9jcei5XE1kPtCIHD9n7S46fedJ3TcY0gsOdk8IWjMG1XFYQiMmVXRQyUj1o8Ce0TkMk1UwUD7uwO+isxUX97prkqaOycSFKdpy98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pxxPALGx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89CD4C4AF10;
	Mon,  1 Jul 2024 15:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719846628;
	bh=H1BDaOVnPwmuDwssrxKeT9EVEBeIKv29CV3OV2Tg7/g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pxxPALGxEeH3BjDR9hTH3y3Z8ObWX4au8d8IqWNRUeoS6v1dqWStOhzCAF6FMvclv
	 YHKDc2TrDvssT+tABOEZkm2f9DsmNXSQUM9Tihzh+ieX6y35tA6rT9mM+3Ld8jyLv0
	 Kb72O2HCZwRO57gbbxDuN4ikdzkvQKdSaFHQdRHt2GSph1XWDWNJ4gnZRMqU5M0XfO
	 SNEDsHosNzp/a2ANr8TzjW1LZN0ayjK93VznBa/4tIW4cljKv6rmQrQFrE5zoTa1fm
	 2lVq7R4biYg53fH3UnorWY7Z8gBksKe1AeU/mgytbn1cFPL1H++i657Pxh+d2/GW9e
	 5tJ30oLsYxExA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 73572C43339;
	Mon,  1 Jul 2024 15:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: fix error handling in btf__distill_base()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171984662846.25774.2873329512116921141.git-patchwork-notify@kernel.org>
Date: Mon, 01 Jul 2024 15:10:28 +0000
References: <20240629100058.2866763-1-alan.maguire@oracle.com>
In-Reply-To: <20240629100058.2866763-1-alan.maguire@oracle.com>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, jolsa@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Sat, 29 Jun 2024 11:00:58 +0100 you wrote:
> Coverity points out that after calling btf__new_empty_split()
> the wrong value is checked for error.
> 
> Reported-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/lib/bpf/btf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [bpf-next] libbpf: fix error handling in btf__distill_base()
    https://git.kernel.org/bpf/bpf-next/c/5b747c23f17d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



