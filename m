Return-Path: <bpf+bounces-59080-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86031AC5FFC
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 05:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AE413B75CA
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 03:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE6D1E32BE;
	Wed, 28 May 2025 03:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EqjusKF3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9871DF273
	for <bpf@vger.kernel.org>; Wed, 28 May 2025 03:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748402394; cv=none; b=j9/jbh7uUOLxwowANlBs/2XdJGnw23vOqydmeCVhNEfpjvwdxTds2+NiIhjj9FCNxWkBCgRbpO+EIE67XiQXzDNeBmPGCbzipCnbqYb1MJAJcWEnerp97xiCma+IxJpRJkbNrXIVwBGDdDjN4P6MUCgHiaZJPc7PEyjpKXG9ysM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748402394; c=relaxed/simple;
	bh=oseWyLaOFtpU2QeTyvoJU/Qa5UpQ1HvsrUKXVf2L2nY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=X0FCziCLCvl8Hh4zxoHUrYoR+4WNfHm06/yFwCLNxcW31ivdF+5q6uNEoM0gSYOY2yVHE1sOqHm3mG4u4gXMP6qDECs5N4qCcMbJgVI+Pt3hETDSHmPoZQn4TnBLKNGDOizNmKSCyb6yvldCCuqTbQkE9YiC3EzQUHomRELL3nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EqjusKF3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F213C4CEE9;
	Wed, 28 May 2025 03:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748402393;
	bh=oseWyLaOFtpU2QeTyvoJU/Qa5UpQ1HvsrUKXVf2L2nY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EqjusKF30/IYAHNldRJO7PFhDssZh4eUI6fH1cXbt2CFACq7tsqLb8M0d7C/5rVNH
	 WCT0IgxpEFpTfBxrdz/1hHapPaxT4oTft8GVHdBlkrrJZOCqAWHK32VgzQvliytynj
	 o0FoZaEGAYBiQCkQ2cpRxiEdoyOTnDYCzlLS0+IoK09DEm9VDb3Ww2evGiyQyjpzhm
	 tGyIyVz0QXop3a2iR2BRybFPsx3fAH+4LTwpjCfd2EzIqAdwljxpLPx901TGxmlrsd
	 qRDVIFX+c6heyi1Etre96u5dq0/3QNQfzhpOPTeSjrLhB6Xsdius5+NUCZtg8ieozL
	 AZVU3OVPekHWA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDEF3822D1A;
	Wed, 28 May 2025 03:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf,
 arm64: Remove unused-but-set function and variable.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174840242751.1879649.4496440116192194532.git-patchwork-notify@kernel.org>
Date: Wed, 28 May 2025 03:20:27 +0000
References: <20250528002704.21197-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20250528002704.21197-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org, xukuohai@huawei.com, alexis.lothore@bootlin.com,
 kernel-team@fb.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 27 May 2025 17:27:04 -0700 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Remove unused-but-set function and variable to fix the build warning:
>    arch/arm64/net/bpf_jit_comp.c: In function 'arch_bpf_trampoline_size':
> >> arch/arm64/net/bpf_jit_comp.c:2547:6: warning: variable 'nregs' set but not used [-Wunused-but-set-variable]
>     2547 |  int nregs, ret;
>          |      ^~~~~
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf, arm64: Remove unused-but-set function and variable.
    https://git.kernel.org/bpf/bpf-next/c/c5cebb241e27

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



