Return-Path: <bpf+bounces-58487-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCAFABC274
	for <lists+bpf@lfdr.de>; Mon, 19 May 2025 17:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF22A189FA61
	for <lists+bpf@lfdr.de>; Mon, 19 May 2025 15:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EAF286417;
	Mon, 19 May 2025 15:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOj4k6p9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E0943147
	for <bpf@vger.kernel.org>; Mon, 19 May 2025 15:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747668595; cv=none; b=p1XN5e3vmd9fA1OFlHII2Cpa24D32XFf1mU+QHg7E2k0xGec7U+QOXZKolzXjAvkgKGRaIs9ouk3Vao9mK6R10LGrPft7C3JG+1UQTfl+mf0cA01uHac5b6kRK7EhTiKkID/2rcyQ6467Ep7iZWnnPGEFSDDyTAsdOjBVS8HXCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747668595; c=relaxed/simple;
	bh=ft8lxfqHuUxaLPcoNQw8kO/Hvep0/2Ppc/pfn8EsrP8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j2rxAa/d2bdEr/3uouNa1JEjs7tshxAx46hISt8kbH8klwnApirLwIKDJFTsExbVpatZiXjehTKYjtAMmZ/OTvpteMRJ+iBjg9gc49aE+DF8SkbRhR41Wi2kvXRaPwJBpCprx/7qgstZW3UYq/WJRqea12UhQE7fAlqToQs8WQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOj4k6p9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C97DC4CEE4;
	Mon, 19 May 2025 15:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747668594;
	bh=ft8lxfqHuUxaLPcoNQw8kO/Hvep0/2Ppc/pfn8EsrP8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aOj4k6p9kM2BP9AZWUY2cIQMwdqKJDBepAZFGawewbvhB5EHOGgZpzCNxfgqvdN+O
	 UUcOdWPGbxqx0dprzZPCAFP2R6XtYTG+bAbEfO+LLlhl0xOyYSsNQFl6rr2CfNaC6D
	 KRW5tUzkRjN9ne1CaYiaW1c2ws2jwcJqm1/zfUOkgVT7ymxJG7xAgiHXQV850UyG1V
	 RzdzOJclunsHNrBSrrCPnxV0UqWKbDrN9cr5Ipz0ozvKfqyXQXnTchNvSTmivDHBep
	 drjsyEkmPAXvpM1iQ5hb0CUv+OZ/lpOPmfdsiMSUhQmls/pc0a7spviyg+Z0yHqlRT
	 +iwjjP28cIVNg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB6D8380AA70;
	Mon, 19 May 2025 15:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v6] bpf: WARN_ONCE on verifier bugs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174766863077.967382.2031635280036322717.git-patchwork-notify@kernel.org>
Date: Mon, 19 May 2025 15:30:30 +0000
References: <aCs1nYvNNMq8dAWP@mail.gmail.com>
In-Reply-To: <aCs1nYvNNMq8dAWP@mail.gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 19 May 2025 15:43:57 +0200 you wrote:
> Throughout the verifier's logic, there are multiple checks for
> inconsistent states that should never happen and would indicate a
> verifier bug. These bugs are typically logged in the verifier logs and
> sometimes preceded by a WARN_ONCE.
> 
> This patch reworks these checks to consistently emit a verifier log AND
> a warning when CONFIG_DEBUG_KERNEL is enabled. The consistent use of
> WARN_ONCE should help fuzzers (ex. syzkaller) expose any situation
> where they are actually able to reach one of those buggy verifier
> states.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v6] bpf: WARN_ONCE on verifier bugs
    https://git.kernel.org/bpf/bpf-next/c/1cb0f56d9618

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



