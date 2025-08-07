Return-Path: <bpf+bounces-65214-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94892B1DB8D
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 18:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2DF77E0451
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 16:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582B9271470;
	Thu,  7 Aug 2025 16:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uFx0kQ98"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D390F2676F4
	for <bpf@vger.kernel.org>; Thu,  7 Aug 2025 16:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754583602; cv=none; b=R9fUneNnAEa4yQmqFGYlfrXDIk1azXsk/YFYLYmCDWcyecOPPcjnayIULn3b3nLME/lb4uS4fjYJciZdfMLcgc0WVsy/BVLcDUa8d3OSmYK7Je5/zF2LbQQIK7PU0K/2+A1q32jW64G9ria30FgY7ksTD5tOQ4qePesl6VB0Uwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754583602; c=relaxed/simple;
	bh=mQYGhtVKEYGzH/TVvlyQNshxQs9tAdww0jj66vAC7Uc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MqM/VBfnkk0uKr0URw8FmPja2hx9d5R8wkgGJrdx4Jiuy63HZ+JUyPCZDWmJTwGUDnONKqqK8fo2DqZiIsFz7hdOBkg7a9xr7+b95ae/pSRyQipskgQIHS9yVKXJXSo3x+JC3lCprmw9atVJlQK7truNIO6RPGm1YPbLrrZeYVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uFx0kQ98; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B3E0C4CEEB;
	Thu,  7 Aug 2025 16:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754583602;
	bh=mQYGhtVKEYGzH/TVvlyQNshxQs9tAdww0jj66vAC7Uc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uFx0kQ9899AOgJxuZcIQxS9n0+nwr9Ag3V/5yzuxdbQbR4KdOm5jl+7xNOo9IoqUW
	 LvEEy7awIG6GmNbk7FTF69JWteeK+loerIWk/Kct42PlT8x8n1a3pQg4jtLzFb/COO
	 lb4J3x1QLXEq1vWUJ7KqQk9X0MtGoWyIoK4YgQ5ib6zPYgk0nsYWpuZS9wvuuTAnGc
	 602mmLNQCPNI4m9gUUoYaHAc8fFNyM7weikD7Sru2Ji+tgc0YzlZkZpbxItkGpY/Lc
	 5HAB8EX1C3SoO4TyKCOtFOHV5JyP9i6qmQ3q+U1dAvtmi6XKXTwnb+hpIxZAKLtAWO
	 pODqq5VJ2kL6g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DF2383BF4E;
	Thu,  7 Aug 2025 16:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/2] bpf: use vrealloc() in
 bpf_patch_insn_data()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175458361574.3615598.7016868436044612025.git-patchwork-notify@kernel.org>
Date: Thu, 07 Aug 2025 16:20:15 +0000
References: <20250807010205.3210608-1-eddyz87@gmail.com>
In-Reply-To: <20250807010205.3210608-1-eddyz87@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  6 Aug 2025 18:02:03 -0700 you wrote:
> Function bpf_patch_insn_data() uses vzalloc/vfree pair to allocate
> memory for updated insn_aux_data. These operations are expensive for
> big programs where a lot of rewrites happen, e.g. for pyperf180 test
> case. The pair can be replaced with a call to vrealloc in order to
> reduce the number of actual memory allocations.
> 
> Perf stat w/o this patch:
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] bpf: removed unused 'env' parameter from is_reg64 and insn_has_def32
    https://git.kernel.org/bpf/bpf-next/c/cb070a8156c1
  - [bpf-next,v2,2/2] bpf: use realloc in bpf_patch_insn_data
    https://git.kernel.org/bpf/bpf-next/c/77620d126739

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



