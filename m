Return-Path: <bpf+bounces-71658-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EBAE2BF99C6
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 03:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 74FAE352D06
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 01:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106FB85626;
	Wed, 22 Oct 2025 01:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pAgdMDZE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2A117BB35;
	Wed, 22 Oct 2025 01:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761096625; cv=none; b=bZlSssVX0g0QV6mHsLknMGesAHwmu+/OG/jtx0s6gB1DsJ51Lmsbx7v2EAs9rJH+hpBGDw7MYxEZyH0WxBBvG18bDdDI8uB3Uy0+8p53oLBWIhkxc2+5YddJAbYzdm8cxl9TVnANBNZifsewI0LOZTH6VYMO1rnGcEU53+7zcLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761096625; c=relaxed/simple;
	bh=ymAVWAHf0BJa45BA3s4sAFxJvkl72Dgk6mkroNNUlyA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qdk21QHXWP8c5ayq8o5XmHC0stP4Qx4AoObJ4UT4f+JtPyE5wGAMUlSEdAS3zc/y9ugjGBi+5WZMQvOyEF8d4j3eaVzqOHHQFzPuFiwIpSq/f33uXNRWvCMx3I9/SoumppWNSYo02NO5Y/yhULq6Pe0O4JsiqK3pjS8D2hT2ncU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pAgdMDZE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1222C4CEF1;
	Wed, 22 Oct 2025 01:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761096624;
	bh=ymAVWAHf0BJa45BA3s4sAFxJvkl72Dgk6mkroNNUlyA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pAgdMDZEsV6iBUaYhqJ8ClbSmx0awXB9KSyec5wlVtz8MyqP1fY0HfS2XCcbYkadp
	 azYfPocrQ9FVQ9S11GeXRJN/Rd/dYbS0yLXT0TSJOPT1kRuLTyf76MpHGdWxOI1JYp
	 mgHUxy63necGa5Pkpd6Hj0fQ9w75vMjFJfJ8shvkIQkP1PgPJRmvyPsxvrhteEmPcG
	 bdVHyB1835oAw5w8WRqB2ioJ3S3BNVPkipXanURDLZfMGlMP4Oy8CpjbBponjKEToA
	 6YSA/M4O7FKd7JJcQVgzyoZDUwo+F17g8nwfxMMbEkc5D0sSlVs6k7sBbfF5bTHGUH
	 OGoDGDMSqq4Iw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E443A55FAA;
	Wed, 22 Oct 2025 01:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] x86/bpf: do not audit capability check in do_jit()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176109660626.1300441.2793398513274288624.git-patchwork-notify@kernel.org>
Date: Wed, 22 Oct 2025 01:30:06 +0000
References: <20251021122758.2659513-1-omosnace@redhat.com>
In-Reply-To: <20251021122758.2659513-1-omosnace@redhat.com>
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: ast@kernel.org, daniel@iogearbox.net, bpf@vger.kernel.org,
 selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
 serge@hallyn.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 21 Oct 2025 14:27:58 +0200 you wrote:
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
  - [v2] x86/bpf: do not audit capability check in do_jit()
    https://git.kernel.org/bpf/bpf/c/881a9c9cb785

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



