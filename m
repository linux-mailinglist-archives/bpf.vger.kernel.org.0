Return-Path: <bpf+bounces-63540-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D82FB0829B
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 03:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 780EA1A6604E
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 01:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EBE191499;
	Thu, 17 Jul 2025 01:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f4c2kPWQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47373FBF0;
	Thu, 17 Jul 2025 01:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752716988; cv=none; b=hIpFHkVH3F1qc7roAnE6P221nbovkHqjGOqrOMOTtstMY1YMxPL98KmiicVNZnvV0iDM2pqrVpX/0e0U5D6SKukftFNZC4LgyEpX1PAHGbcX0kzctRw0tXOTfID5TqJG37YfeyXaSZYaVK2kJ0MxjOuh8kfD2w/xF3dfJh2RMk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752716988; c=relaxed/simple;
	bh=wGad5u9D4gBJQzmzLVHad8FkkuNUEHduVtO97jZN3YI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=E/koryRGZJMfs+5bqSB0fIxLSyRC0vkqPI+OAFdEGOR6Z8O4mXlsJ4a+9Lkro17l32r50qtUSMb/lsgA/Lk4WFwV+aBVHec21Ctwh6nzXNC2SJUuXM9HOO2RElIE9dSkRDez3iNof8/vj5R9GukOJsW9uBya7CCErGoJRA+WMHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f4c2kPWQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C8E8C4CEE7;
	Thu, 17 Jul 2025 01:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752716988;
	bh=wGad5u9D4gBJQzmzLVHad8FkkuNUEHduVtO97jZN3YI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=f4c2kPWQFDIFaNv1Y+u7OupG22GRBbv2Nd+1Mi/ETtys2Un8/douvG/OstGK56wED
	 LrNuDp+t9e6J741NFjwZtlQgiwAciXm1iLlYIPhzx8SrYtL9Xsd8n7Gm+lH73n7pUn
	 /SMXE5VG30fP9KYAiMpaLpGyrzgkjUYQ3Z86IM8c9L+xIrCi0UKTBjl+lG3dMWCtYj
	 fM341E6u6M0AnjeOg7ibufN6BCTZ3Uigxse+vC1GO5lAM6P8o6a1ACeqSjykH/befy
	 ADmEJZaNYiZwxhrfBDeEJ+R+wyZn/ObLVfC2fXn1F2hmpslC3VsQPe8RPXR5Ts40Ym
	 YmuavjLerbAVg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DEA383BA38;
	Thu, 17 Jul 2025 01:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/1] A tool to verify the BPF memory model
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175271700826.1394291.8116417405326135907.git-patchwork-notify@kernel.org>
Date: Thu, 17 Jul 2025 01:50:08 +0000
References: <20250710175434.18829-1-puranjay@kernel.org>
In-Reply-To: <20250710175434.18829-1-puranjay@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, memxor@gmail.com,
 paulmck@kernel.org, bpf@vger.kernel.org, lkmm@lists.linux.dev

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 10 Jul 2025 17:54:32 +0000 you wrote:
> I am building a tool called blitmus[1] that converts memory model litmus
> tests written in C into BPF programs that run in parallel to verify that the
> JITs are enforcing the memory model correctly.
> 
> With this tool I was able to find a bug in the implementation of the smp_mb()
> in the selftests.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/1] selftests/bpf: fix implementation of smp_mb()
    https://git.kernel.org/bpf/bpf-next/c/0769857a07b4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



