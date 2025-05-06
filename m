Return-Path: <bpf+bounces-57563-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCE6AACF5C
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 23:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DA5A7ADFA1
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 21:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDAE2153E1;
	Tue,  6 May 2025 21:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gaUdSc2n"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64731A0BF1
	for <bpf@vger.kernel.org>; Tue,  6 May 2025 21:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746565788; cv=none; b=jtHAuV4/HigxT7VOmwp+sJoVEg05MKDc+9940CqFjyR+/MSTUbNkjcpn2T+M9TXIxPtC1pf1yOjOji8wIqTI8OQEO5hTxNsh3e3ciRyHx6rjKw1+0d5O/fcCuqHdn7MGK10RfuIpAl0glwtoYZ1TssHzh7F5nENtC6NZ2vqMSLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746565788; c=relaxed/simple;
	bh=oPHeCWMa6z87MyrW4B91awPYlqOkuzrtG8IK0s2eYVc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mQqO56q4CG3QKFzDSarwpNdqhCyf6yoBHBLm+dLigScfXk/PtLnOE/9AYAuDJCWFckIxHT+Qmdf23Zs5Zz9l6RkyGQeZAAqrZbZw5YV3jKPi/e5lp2qZ0P4qKcX8QSelY5TFpCf/2uoZJghOa4n1IQLT1Q9oHy6CugginjzzT0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gaUdSc2n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27ADCC4CEEE;
	Tue,  6 May 2025 21:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746565788;
	bh=oPHeCWMa6z87MyrW4B91awPYlqOkuzrtG8IK0s2eYVc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gaUdSc2nR1Nqnrb+miuGvXZyDh6VPnAIrxFVxaOzYg6yuXE+4bSgl/m/ffU/5L1tM
	 O1v7zalX176nSIRqqWYt9Yy90L+TFKuVixudAcGHsOJWL+Yp983uoh+ZAzUogbg7y3
	 unctfA/SEN8fo32drbZ1NckmkLuQ2SQjAyonwdSa+inY2P4SVMfMPFFKZJjvpdTOZa
	 G0mO2yGsAYhhvn541BAmkmPqkKHvmc23/9BBY9mCyjaN2/4ZjsY2eBX/QpkPX/+PI3
	 Olq6BSLNE7lmEdreA7/YIEYHIAcP5j3fThhCEVC1CdQxD2jwkbnaalj9tB1LwLiBHQ
	 Bf3J1bkoAITQw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D6F380CFD7;
	Tue,  6 May 2025 21:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpftool: Fix regression of "bpftool cgroup tree" EINVAL
 on older kernels
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174656582725.1652357.5444508643664724718.git-patchwork-notify@kernel.org>
Date: Tue, 06 May 2025 21:10:27 +0000
References: <20250428211536.1651456-1-zhuyifei@google.com>
In-Reply-To: <20250428211536.1651456-1-zhuyifei@google.com>
To: YiFei Zhu <zhuyifei@google.com>
Cc: bpf@vger.kernel.org, qmo@kernel.org, ast@kernel.org,
 tadakentaso@gmail.com, daniel@iogearbox.net, andrii@kernel.org,
 irogers@google.com, gthelen@google.com, maheshb@google.com,
 minhanhdn@google.com, sharmasagarika@google.com, xuanyao@google.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 28 Apr 2025 21:15:36 +0000 you wrote:
> If cgroup_has_attached_progs queries an attach type not supported
> by the running kernel, due to the kernel being older than the bpftool
> build, it would encounter an -EINVAL from BPF_PROG_QUERY syscall.
> 
> Prior to commit 98b303c9bf05 ("bpftool: Query only cgroup-related
> attach types"), this EINVAL would be ignored by the function, allowing
> the function to only consider supported attach types. The commit
> changed so that, instead of querying all attach types, only attach
> types from the array `cgroup_attach_types` is queried. The assumption
> is that because these are only cgroup attach types, they should all
> be supported. Unfortunately this assumption may be false when the
> kernel is older than the bpftool build, where the attach types queried
> by bpftool is not yet implemented in the kernel. This would result in
> errors such as:
> 
> [...]

Here is the summary with links:
  - [bpf] bpftool: Fix regression of "bpftool cgroup tree" EINVAL on older kernels
    https://git.kernel.org/bpf/bpf-next/c/43745d11bfd9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



