Return-Path: <bpf+bounces-78747-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B8AD1AD16
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 19:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DFACD300E428
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 18:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C207134DCFD;
	Tue, 13 Jan 2026 18:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WpvrOccM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DABC34B68F
	for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 18:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768328464; cv=none; b=rsB4771vDzTwI4WjRU6wovW+89hpPLvqIE3Z82uV8RSft0tnWlBTftlvwU7E8mnbElh57cJbTwdtheURme9JaYNPs8/KowrSCFxZafjEyk5yyg0ZnO0L/vjN0og3mXHlNZc4/6/duSDIGGIeIcmsoD/jefqtIlfZTK9CN8qsrPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768328464; c=relaxed/simple;
	bh=3wJpDfhSVDDqjM949aqENvQ/NKfSy/gYdIC55v1uQDk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UU+FhH71hRNlCnMxqvMI59mkWn8/5dXypMDsL4RF2nDcvMzzgsedop1ptkgNFW65MXZBjT1kcAICsCPgyOsGfeLajFLNZfQx04pSmDXB55olggMQY05tuhSyhnJ0pchOflBMirf+P0OFJuu9vQQuMKLFkl7m5k3Q68bAIOAaHgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WpvrOccM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE0DDC19422;
	Tue, 13 Jan 2026 18:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768328463;
	bh=3wJpDfhSVDDqjM949aqENvQ/NKfSy/gYdIC55v1uQDk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WpvrOccMbsyymVfQWcdxE0wiHSxd00XH/hvdqtD6UtSiY39EjJZiTQxFLA1tPkByf
	 UH7idwpFLklzqGjJ4jaVUsG71NMMztl+CIFWEeqWB7UQTyHUDFXZC0csb6HKropKW1
	 5gT6/DC9yI5LiaJhxjKVk8MJHG1BOnI2IWdR2qcOb+6ElTO4y+i7d/R0JOs2o/rojo
	 kxU2uV2gw5I2XIU6EdH391ZZOacfitMA3ObiuToGo0jJvquRaLKFOP6GL+sD1xjX6l
	 6kTot6/H7DAETx8C4DE245g469781AAfEApIRPx1W63Nb1zpdpVBVIUHQMZ2nPsCpC
	 z1oa7Ysdy9DtA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 79C8E3808200;
	Tue, 13 Jan 2026 18:17:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/2] bpf: Recognize special arithmetic shift
 in
 the verifier
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176832825702.2345780.7373274588102237050.git-patchwork-notify@kernel.org>
Date: Tue, 13 Jan 2026 18:17:37 +0000
References: <20260112201424.816836-1-puranjay@kernel.org>
In-Reply-To: <20260112201424.816836-1-puranjay@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, puranjay12@gmail.com, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, mykyta.yatsenko5@gmail.com,
 kernel-team@meta.com, sunhao.th@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 12 Jan 2026 12:13:56 -0800 you wrote:
> v3: https://lore.kernel.org/all/20260103022310.935686-1-puranjay@kernel.org/
> Changes in v3->v4:
> - Fork verifier state while processing BPF_OR when src_reg has [-1,0]
>   range and 2nd operand is a constant. This is to detect the following pattern:
> 	i32 X > -1 ? C1 : -1 --> (X >>s 31) | C1
> - Add selftests for above.
> - Remove __description("s>>=63") (Eduard in another patchset)
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/2] bpf: Recognize special arithmetic shift in the verifier
    https://git.kernel.org/bpf/bpf-next/c/bffacdb80b93
  - [bpf-next,v4,2/2] selftests/bpf: Add tests for s>>=31 and s>>=63
    https://git.kernel.org/bpf/bpf-next/c/9160335317cb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



