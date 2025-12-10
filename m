Return-Path: <bpf+bounces-76398-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E29BCB23DF
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 08:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA77D301B102
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 07:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0E33016EB;
	Wed, 10 Dec 2025 07:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEAxtl4n"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D509301470;
	Wed, 10 Dec 2025 07:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765351996; cv=none; b=dZW5qbJEDqnrDcQJO4dgV3yyn6yZDI30GNMeKBCZR6JXjf5VDnGyIEOHXCd7fsa8zXOgU2LVbWvEvrrqhuqjYauMYtHT3BRUGa7fu4bnktQGgdx+coxTZfMuPGVxSy/Nw5ExNIIbEJJZAKXrDZg/K5b+9lu7V5G1DrENgLZ6fSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765351996; c=relaxed/simple;
	bh=z32QeBspTHvfGL7jT4zgsGt50dcCo9fMPnf9xtq3X9A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=peLDOgq2XvwXr9JnGhNp9FRAFdPKi1BXqIL/F2C2Uc979KNs+wLXUwi5SxJGx954Q8zOKINjmuRPvhjpr0aBVwrTlZG4OqSctInwMl7Wu8o6QtoEyHCQCTAgwU7fyt2xdIYOhsw4HwpBiRQejGfxRtR91Q83F6F6zLCGU5JsTgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEAxtl4n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DAC4C116B1;
	Wed, 10 Dec 2025 07:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765351996;
	bh=z32QeBspTHvfGL7jT4zgsGt50dcCo9fMPnf9xtq3X9A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FEAxtl4n/dE8j2tgbOfAC0aRj0oMADjly1Y7eYym4r1/h0AHWHd+msfqZscjgA2ys
	 J5TKwMM+gwM36agvp6KNeLKumtc53QXwEMq3lvmsv6YY9Mm08kPTivEvQ58mXGNHWx
	 8kKMPr2F/amgC3HLyHga3JUrOgY76SUYh33Ks+1tDCkh5mwbHsds7rPxQKRevlrfm5
	 9pMq2/w38fiHmWWl99urOhDiNqpJvLLyLz1FwtOHGZrVJYxiFHjoHyZXyWu4DzuHp9
	 BobSUGpGPA5rYtWmXQnEhaiDuD67FW0cdeX875SmZJjv2UIztQsEgYjOHpSYrSfQ3L
	 JJRruqcT5u1Iw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 788BE3809A18;
	Wed, 10 Dec 2025 07:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf, arm64: Do not audit capability check in do_jit()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176535181104.487333.8109866817495387423.git-patchwork-notify@kernel.org>
Date: Wed, 10 Dec 2025 07:30:11 +0000
References: <20251204125916.441021-1-omosnace@redhat.com>
In-Reply-To: <20251204125916.441021-1-omosnace@redhat.com>
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: ast@kernel.org, daniel@iogearbox.net, bpf@vger.kernel.org,
 selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
 serge@hallyn.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu,  4 Dec 2025 13:59:16 +0100 you wrote:
> Analogically to the x86 commit 881a9c9cb785 ("bpf: Do not audit
> capability check in do_jit()"), change the capable() call to
> ns_capable_noaudit() in order to avoid spurious SELinux denials in audit
> log.
> 
> The commit log from that commit applies here as well:
> """
> The failure of this check only results in a security mitigation being
> applied, slightly affecting performance of the compiled BPF program. It
> doesn't result in a failed syscall, an thus auditing a failed LSM
> permission check for it is unwanted. For example with SELinux, it causes
> a denial to be reported for confined processes running as root, which
> tends to be flagged as a problem to be fixed in the policy. Yet
> dontauditing or allowing CAP_SYS_ADMIN to the domain may not be
> desirable, as it would allow/silence also other checks - either going
> against the principle of least privilege or making debugging potentially
> harder.
> 
> [...]

Here is the summary with links:
  - bpf, arm64: Do not audit capability check in do_jit()
    https://git.kernel.org/bpf/bpf/c/189e5deb944a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



