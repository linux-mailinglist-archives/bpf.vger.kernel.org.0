Return-Path: <bpf+bounces-61781-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C434AEC227
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 23:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEF031BC0C0A
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 21:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E27D28A1D5;
	Fri, 27 Jun 2025 21:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKkgLFNZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CC1171092
	for <bpf@vger.kernel.org>; Fri, 27 Jun 2025 21:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751060380; cv=none; b=JYRLQGNY1cqQCOZwIhG5EQTcAiaGc06tsOokGeLCHX5tf0lxWARLrAy63WbM7os+ukiNbctGKy06ZH8do48stFUMfvY1ePTVlnaxXwKrokpXL0QbrXyplXnmS1u9T1qVzPmBcpRdY9GQHDyLyM3f8h6joZdWw2oG8HEQNWcFCqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751060380; c=relaxed/simple;
	bh=0mzYll+aO0iYjWAXPWQ1V3zWc29K2DEr1avlbAhbjJ4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PGc/iFT2OApuulw8+5IpB49n65qoJCWheb/G6Fn4RRrf7tTjVBy9LdyGoGXFlzm6LYwg+s7wyG+iZkmjq4zdi5O2AF+mspsIuqGKeApCt3OlIWWPqU9OFCpfQ26DAOME8Ydx/MGvkSafcKBn1X28JuC6xvf+8DUJwvitdk6aTtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKkgLFNZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C658C4CEE3;
	Fri, 27 Jun 2025 21:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751060380;
	bh=0mzYll+aO0iYjWAXPWQ1V3zWc29K2DEr1avlbAhbjJ4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fKkgLFNZ7W2qFS2hYM9SriW5AmAt18IjFIfELsb5OxP0Jsubu76WcXZB1cbucuPrj
	 w4OwOlo5FX5Be91il6g/OZ1AOzGLySL6gECi3ezd/qIawgSPolaYlUP9snxEBw+p4m
	 ZMfXGE2ziY8sGZeUb6hQGUKuWLxDUCju/wK1xGoSMydKPgUkImhrMOzF6nCoCo3vr2
	 FTUkEmQGdx5KkHBk+LnfBgXEuDq3DUVvDuVVoUTGCA4tf6MQY6idxGlnkULB9xdxKi
	 /E2S+4MmD0UAywMbz6Es3s82ysJrzHPreQaRb9lAXgiIU48tPaHB4MGbDBMeSOhw6y
	 iR81yNN63IYGw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E9238111CE;
	Fri, 27 Jun 2025 21:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next] selftests/bpf: Fix
 cgroup_xattr/read_cgroupfs_xattr
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175106040601.2068050.6481377720178421832.git-patchwork-notify@kernel.org>
Date: Fri, 27 Jun 2025 21:40:06 +0000
References: <20250627191221.765921-1-song@kernel.org>
In-Reply-To: <20250627191221.765921-1-song@kernel.org>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, kernel-team@meta.com, andrii@kernel.org,
 eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 27 Jun 2025 12:12:21 -0700 you wrote:
> cgroup_xattr/read_cgroupfs_xattr has two issues:
> 
> 1. cgroup_xattr/read_cgroupfs_xattr messes up lo without creating a netns
>    first. This causes issue with other tests.
> 
>    Fix this by using a different hook (lsm.s/file_open) and not messing
>    with lo.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next] selftests/bpf: Fix cgroup_xattr/read_cgroupfs_xattr
    https://git.kernel.org/bpf/bpf-next/c/bacdf5a0e69d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



