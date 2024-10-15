Return-Path: <bpf+bounces-42090-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EE499F5D9
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 20:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 740D61C237DB
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 18:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DD51F5826;
	Tue, 15 Oct 2024 18:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGcie4Cd"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39BE1B6D03
	for <bpf@vger.kernel.org>; Tue, 15 Oct 2024 18:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729017624; cv=none; b=uA/RhvyIGsG2sMZuNlBOOPP04NV4DSk8xVEbMMm7i4xWEtZ/R/vrw5V/y6Hb5AQelf+xDMRTIi1pnYLJhaYq/MHKmiswxQqPi900AzE3DqpFdUlIu6GgVONynI2upPoxqOxwcT+0A0+fd9m7CeEUCuBkijM17dn80nFfklP9Z8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729017624; c=relaxed/simple;
	bh=MCVeok1v0gmjMHLLLADmduebZtZdCSL2hlph9GbxbYg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oeHOxTUkovHVR4+UMRHVC7ZcILkKd7wMuOpgry++TXllORoPKTcFseB5N0U+NVGFtxK5NVFAjmZ/Ytxgvh4zyaGsXLJ+uAX779lU68Ky34mO+NQdvSyBcJosi+qhBUpYsqQiIRRZurLwIeVnGB3wmnnicyEFNlEqGlfO2HVSlkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGcie4Cd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 509CBC4CEC6;
	Tue, 15 Oct 2024 18:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729017624;
	bh=MCVeok1v0gmjMHLLLADmduebZtZdCSL2hlph9GbxbYg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EGcie4Cda0ZWjikoWZQ9JNiunCnoBzXoI0iKILrxWJJgH4oWnjZcCBvhLvPX1Z4RG
	 kDpQ59xnTxLuhRM8TZX5DRQQGU9FXP2L96ICJ8dtJ6LS+c+zZaV1wASjKTvWqI/bLT
	 5ZBGLFr8oQwBUbjrYfmVoP26seflpHcF/CrEDU8vvrvsD7Xe+qxDKJ3EiEOJa6DKGj
	 1UP6I14ZV3hqQ2qJ8a5KxeavnfI6wRWU9PyaqC5k6gt57IGuYDpKBLqQw1RyAQUd6m
	 iGk6UvQ6v063+N7oZTp6Z5SbY4sgiC/m9E1+mLketPyw8L2CRzcwdNL7jJZUQVivvu
	 5shx9rD4KjB1w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF8E3809A8A;
	Tue, 15 Oct 2024 18:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v8 0/2] bpf: Fix tailcall infinite loop caused by
 freplace
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172901762951.1255819.18163538713043138202.git-patchwork-notify@kernel.org>
Date: Tue, 15 Oct 2024 18:40:29 +0000
References: <20241015150207.70264-1-leon.hwang@linux.dev>
In-Reply-To: <20241015150207.70264-1-leon.hwang@linux.dev>
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, toke@redhat.com, martin.lau@kernel.org,
 yonghong.song@linux.dev, puranjay@kernel.org, xukuohai@huaweicloud.com,
 eddyz87@gmail.com, iii@linux.ibm.com, kernel-patches-bot@fb.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 15 Oct 2024 23:02:05 +0800 you wrote:
> Previously, I addressed a tailcall infinite loop issue related to
> trampolines[0].
> 
> In this patchset, I resolve a similar issue where a tailcall infinite loop
> can occur due to the combination of tailcalls and freplace programs. The
> fix prevents adding extended programs to the prog_array map and blocks the
> extension of a tail callee program with freplace.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v8,1/2] bpf: Prevent tailcall infinite loop caused by freplace
    https://git.kernel.org/bpf/bpf-next/c/d24c6a9d3a9f
  - [bpf-next,v8,2/2] selftests/bpf: Add test to verify tailcall and freplace restrictions
    https://git.kernel.org/bpf/bpf-next/c/5a2ac3844d47

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



