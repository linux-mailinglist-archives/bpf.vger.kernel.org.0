Return-Path: <bpf+bounces-19828-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB08831EF5
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 19:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 803ADB22761
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 18:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40A22D618;
	Thu, 18 Jan 2024 18:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFiwSM7v"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E802D609;
	Thu, 18 Jan 2024 18:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705601429; cv=none; b=I3DngGgfqMAkFr0EZmuzlLxOsOU8TMYIyAYDYpb8sDpoVwJ7oBJOhjML6eRhbtDiwZIOzVUcIFg0HwTFxMRNFqc3e2FzA4iL20BQgP+IyVy/bQeU2V07BaBn7H0mlfpK+w6zt2LpOSgmHJhE09gZUUwfBy6W2LP/Dem//jpMBiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705601429; c=relaxed/simple;
	bh=bylF9isZKEAsCKkaUkQIIek6czURxuagXyFR264idB4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sqtaIuWxdIox9j7+92vYeEjaSar1AgPJERh4WJpGDkdHdgpQ6GJbDisOX8cYece+QJluTARlr26ZBI3sOdrnVijKQkfT8QwwuViEVmolSZra6puqhC0YI6p2/cf9agz3KBJAfwT9p3/5Mt6N+ssEEfSbQnNT4D0R2xNeJqm0J2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFiwSM7v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BF36EC43394;
	Thu, 18 Jan 2024 18:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705601427;
	bh=bylF9isZKEAsCKkaUkQIIek6czURxuagXyFR264idB4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KFiwSM7vGKNXjIFnUdBDjxiMWSZt4wcTN2WlW0V/FCv6ZutJMIX4QmnwAYvshltMQ
	 bqtlCyLS8duITvmXIZYDWEIQoPGdE8dzrepabkezWe61U2nYdcH9e6cGfUAHMSk1aK
	 6e9UksShqg1mycDM7NvlNbuPuW+OqKzx5jAfJTb2isvYtSyzochn6NizVuGLnQomBC
	 dFQODmB+VIbTUFnJvhlR+WcLmDCXWUohF66UzQO8rMzq2JRv7vXSAYcJZgy2yjvj8i
	 /GLKj5To/DANWCxXSNJ2koGZpH1XJ4xpj4UIL04OtLeJTyvhvsN5/6CmY/+ADP57GE
	 x/EgueoEQJHZQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9F50DD8C97A;
	Thu, 18 Jan 2024 18:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf 2024-01-18
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170560142764.12543.8612146975469676555.git-patchwork-notify@kernel.org>
Date: Thu, 18 Jan 2024 18:10:27 +0000
References: <20240118153936.11769-1-daniel@iogearbox.net>
In-Reply-To: <20240118153936.11769-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 18 Jan 2024 16:39:36 +0100 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net* tree.
> 
> We've added 10 non-merge commits during the last 5 day(s) which contain
> a total of 12 files changed, 806 insertions(+), 51 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf 2024-01-18
    https://git.kernel.org/netdev/net/c/4349efc52b83

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



