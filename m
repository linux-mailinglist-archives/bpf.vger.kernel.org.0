Return-Path: <bpf+bounces-59008-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84848AC5805
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 19:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 870571BC1653
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 17:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0AC27FD49;
	Tue, 27 May 2025 17:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nM7bB2LG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B21E1CAA7B
	for <bpf@vger.kernel.org>; Tue, 27 May 2025 17:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748367600; cv=none; b=iw277tiXWReCsynOkDDq913peqWO6sKtGumRvmCOZbwtxL7Fef45G137WPqMLeDyB+P8MaRDbnNnAW/X48dh++Z+ZaLFpTqmutpIQ9OA/wwqzli1/gPDcOA4w0fxAI2izbTH3uLarxjZ3AYXfjyW8oi6YTX+0t8q3ywv6jpZyR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748367600; c=relaxed/simple;
	bh=z0tVvRZVJBocbPOjtBNIkH5LfMkKZssMD8cSxScUtMU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ctqNKUjEyAExvZlnMExvDRVprfs7z0qV2/19zVElMsYwhEGOYbE/Jj5rWp8ssUphBLLskq2dO7I/3PIhSTKJg+IrN8U5reTpYAmQBJPlIIq86KTKzL6dTFeJcRh1k+/WSoUYUmCjGcYTJ3+lHzI/UdcOEIj2jGJ6JWZx5jaDav4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nM7bB2LG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD90C4CEE9;
	Tue, 27 May 2025 17:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748367600;
	bh=z0tVvRZVJBocbPOjtBNIkH5LfMkKZssMD8cSxScUtMU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nM7bB2LGQJRQh4jlZppZx1XAH/+86NNTLLFjQxVJ6HoiAZJksgE1pOFufCNFPKDt7
	 +cXQig2p5SvvyOm37j4nZQnIqina8IjQJ9E7j9rwL941YcYzsJCglo6SekYRIBLkp9
	 B56ULCV2BZYipEgwKB9jDuti+Ams23OPfIWTsAXasMV7Yq3fPBUHuFNT/pBiGrRBR5
	 8rO10mjuBh/TdYZr2M+pIIQ5abXgbjhxM1RGhPx84Xw8qcpU1cbGWe33dPVdzwx2Ez
	 QjUTYmd9X8U9Tc3dSfsIueJb4l4PKqzGABpbh6QCw8DhfJS5MXyzAEVBI0fC+I623z
	 3aL/B1bLyd2RQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71016380AAE2;
	Tue, 27 May 2025 17:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 0/3] bpf: Warn with __bpf_trap() kfunc maybe due
 to uninitialized variable
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174836763425.1722871.5370662019575930191.git-patchwork-notify@kernel.org>
Date: Tue, 27 May 2025 17:40:34 +0000
References: <20250523205316.1291136-1-yonghong.song@linux.dev>
In-Reply-To: <20250523205316.1291136-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 23 May 2025 13:53:16 -0700 you wrote:
> Marc Suñé (Isovalent, part of Cisco) reported an issue where an
> uninitialized variable caused generating bpf prog binary code not
> working as expected. The reproducer is in [1] where the flags
> “-Wall -Werror” are enabled, but there is no warning as the compiler
> takes advantage of uninitialized variable to do aggressive optimization.
> Such optimization results in a verification log:
>   last insn is not an exit or jmp
> User still needs to take quite some time to figure out what is
> the root cause.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,1/3] bpf: Remove special_kfunc_set from verifier
    https://git.kernel.org/bpf/bpf-next/c/d848bba68034
  - [bpf-next,v5,2/3] bpf: Warn with __bpf_trap() kfunc maybe due to uninitialized variable
    https://git.kernel.org/bpf/bpf-next/c/f95695f2c465
  - [bpf-next,v5,3/3] selftests/bpf: Add unit tests with __bpf_trap() kfunc
    https://git.kernel.org/bpf/bpf-next/c/92de53d247df

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



