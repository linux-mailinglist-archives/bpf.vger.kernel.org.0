Return-Path: <bpf+bounces-20739-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E708427DC
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 16:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 872121F2684F
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 15:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0C7823B3;
	Tue, 30 Jan 2024 15:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L00kfVwR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E1981AAE
	for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 15:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706628026; cv=none; b=L75wkz/8lERzNsOX4tT02CoPd3wp3jId804KRXSXzHlQ6dd+0xo7u8+VC6/RaDDzOJrl/yXfzC2lWNThGhgsNa52+gM1u1Qk5ySjH2W2gIISPZFGlTHTLT8mc5uhKqado8go12xDhMsbEjAN0bGTeZCUBP+sBNMgPbbiqk15Chs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706628026; c=relaxed/simple;
	bh=GlEo2belGeydci9feDx30DdrB+k3Bi5Fylb/b/IHXz8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=r8J6IFk0ZPXXsEqnHO8dE/qiB5r3RDP0J1GFZMv0Tw5TOX5rbXOIfMaG+QoiGfkOqkZsllfdWmML5eiYe8iLU84CMCZ5MgNEzEkG4wuJ6rhoLznTU8XFYQAywRVJwPy+aSiOk3L/eAmqbiAnbqHTbc6lb+OnqiXf8eJA28NH9A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L00kfVwR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F1E8C41674;
	Tue, 30 Jan 2024 15:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706628025;
	bh=GlEo2belGeydci9feDx30DdrB+k3Bi5Fylb/b/IHXz8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=L00kfVwRxAQwyNqNFXM5w9p7if5bQdstXnDoSoqP6S+G/o5oKvuYp6Kw4uvbFWWj/
	 XqKea2Q+wSwOjzuOv7+Eid4H4vi3A/EhQWgpUjv1A6v8QHsf6Ny4xgMGXXRy8+TCNg
	 gJOK291rvmg0JIl6p2zdRKP97StMdc+kf3/Z3gku0/MwMpxe14rCgI2T04RauIVdCy
	 D7n3xMRHdHmUCs+IpBFm+mwvTA3piMxc+m5KZ9tAOrB7BvaGJ60/AdLKoBpq+7SUTY
	 LDab1AJRghbX6AsIoF+cxZAWATkS9CLGxJlw2tvuAlgruXoPhoAz7+5BwSrE7MYvnK
	 cGQYH5QEw7L7A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 744D6E3237E;
	Tue, 30 Jan 2024 15:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: move -Wno-compare-distinct-pointer-types to
 BPF_CFLAGS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170662802547.4509.9560964397702165653.git-patchwork-notify@kernel.org>
Date: Tue, 30 Jan 2024 15:20:25 +0000
References: <20240130113624.24940-1-jose.marchesi@oracle.com>
In-Reply-To: <20240130113624.24940-1-jose.marchesi@oracle.com>
To: Jose E. Marchesi <jose.marchesi@oracle.com>
Cc: bpf@vger.kernel.org, yhs@meta.com, eddyz87@gmail.com,
 david.faust@oracle.com, cupertino.miranda@oracle.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 30 Jan 2024 12:36:24 +0100 you wrote:
> Clang supports enabling/disabling certain conversion diagnostics via
> the -W[no-]compare-distinct-pointer-types command line options.
> Disabling this warning is required by some BPF selftests due to
> -Werror.  Until very recently GCC would emit these warnings
> unconditionally, which was a problem for gcc-bpf, but we added support
> for the command-line options to GCC upstream [1].
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: move -Wno-compare-distinct-pointer-types to BPF_CFLAGS
    https://git.kernel.org/bpf/bpf-next/c/24219056805f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



