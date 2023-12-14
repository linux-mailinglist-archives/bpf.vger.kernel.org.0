Return-Path: <bpf+bounces-17753-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F15812432
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 02:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 591D81C2148E
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 01:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8F265B;
	Thu, 14 Dec 2023 01:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qCBHqZf9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D8A38E;
	Thu, 14 Dec 2023 01:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E3A4CC433C7;
	Thu, 14 Dec 2023 01:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702515623;
	bh=6jmwql5g5U21XJnk9g8EAl84SFH9+WWqjHIygw+ORWA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qCBHqZf9FWGI6P/tGO7EVVUzN+P/42eCJhYOu5cCQBVvBAOeBTEOuUPaav/2q4hnC
	 QAqzsFGN9s/gOy6d53M3JMGmDxi1g9kEdbIO4WPJz10dQzsd+3bjd1tME0RjbT6PAU
	 2uLZI1k/5PV2eD0bQh1ggWor29tOwq0yMyoV7ipIzkh2mQa1mwt9tp2hg9YL7Yd0qt
	 RAEcXrNWcGAI5RlgGPlQJx7/po+qoW6QKi8SfANc2WOuwbH+E6nFE7p+Jtn98VPy8U
	 xlFmFlGlPFh1DBraar2+JQTrItURxcHoTMUPXFxLxS4gvGaAx3wN8PJ2b4+sw086+e
	 HDMF0yLGgOTiA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C97F7C4314C;
	Thu, 14 Dec 2023 01:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: add small subset of SECURITY_PATH hooks to BPF
 sleepable_lsm_hooks list
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170251562381.14848.1101996884810955258.git-patchwork-notify@kernel.org>
Date: Thu, 14 Dec 2023 01:00:23 +0000
References: <ZXM3IHHXpNY9y82a@google.com>
In-Reply-To: <ZXM3IHHXpNY9y82a@google.com>
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: kpsingh@kernel.org, ast@kernel.org, andrii@kernel.org,
 revest@chromium.org, jackmanb@chromium.org, yonghong.song@linux.dev,
 bpf@vger.kernel.org, linux-security-module@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 8 Dec 2023 15:32:48 +0000 you wrote:
> security_path_* based LSM hooks appear to be generally missing from
> the sleepable_lsm_hooks list. Initially add a small subset of them to
> the preexisting sleepable_lsm_hooks list so that sleepable BPF helpers
> like bpf_d_path() can be used from sleepable BPF LSM based programs.
> 
> The security_path_* hooks added in this patch are similar to the
> security_inode_* counterparts that already exist in the
> sleepable_lsm_hooks list, and are called in roughly similar points and
> contexts. Presumably, making them OK to be also annotated as
> sleepable.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: add small subset of SECURITY_PATH hooks to BPF sleepable_lsm_hooks list
    https://git.kernel.org/bpf/bpf-next/c/b13cddf63356

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



