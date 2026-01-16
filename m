Return-Path: <bpf+bounces-79344-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3247D3892B
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 23:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 034D430552EC
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 22:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E9C3101D2;
	Fri, 16 Jan 2026 22:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WN1N6omw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33DD2FFFBE
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 22:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768602215; cv=none; b=AZWh5nTnxJzqbVY4rdX3ogqzHskoMYx3w/YiBo35mra81A85cwy/3MWpoOqMd5j0ao6stalBdFXZlfb2Dia2PHae8yHkWHJH3M9dmF/rkfi+n0sGa6vOJUA/l41UgLR2t9i9p46MYw3OGaaQ1B8leejguFaHjNsJQTV46nYJDTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768602215; c=relaxed/simple;
	bh=aURJh++m0C3MaqNHUo8y8Vx1znHzKpaVp8zKYEmxH2o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bWAi7b0ua86CGLK7viD6PDVfQ9SOpEZe/jJqPr2kwa67CMXTLByg3l0j+NX/LrwnY8Djhyv48y5KmYFnKiaaig5YiH86sUfVh1JKJR/xBqq9I2QU7BLAMki/tELwBzWFalRoRvwp8i0Yn50BS22egA5TBAAqQ+BuZbtZA/LZTZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WN1N6omw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E82AC116C6;
	Fri, 16 Jan 2026 22:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768602215;
	bh=aURJh++m0C3MaqNHUo8y8Vx1znHzKpaVp8zKYEmxH2o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WN1N6omwTZoLiNwNh0IB8iq9WsrX6NYewn1vzCNcvy1mG233csHPiojs6OzEBWrBt
	 mVEL+wJdH4b/0BIl8eQne61h77Wjx32gpZ67WUYw8jQuWtBumGWDejyNfpEG2juFSA
	 f8VTCJNBwtI2TTyc2ZdKSVMsGmDK7zEJuvgTVSbEMVqErf7PqNEf+nZagYMQQa451s
	 N5qOazqj6zWU9TutVRqHLRhaTVcA7mQXHtD+rR5LXD0gwOgiLQD34XnsmU0pUa17+k
	 27IdfjN3K29A8MPKxFNwqnwId/1/va6XEx8TmRQd0fXZtT4Sgjdti3f9PYi2w6GiPi
	 FLmiEdxmkb//Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2D67380CECB;
	Fri, 16 Jan 2026 22:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1] bpf: Add __force annotations to silence
 sparse
 warnings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176860200680.819374.11642331369076459428.git-patchwork-notify@kernel.org>
Date: Fri, 16 Jan 2026 22:20:06 +0000
References: <20260115184509.3585759-1-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260115184509.3585759-1-mykyta.yatsenko5@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 yatsenko@meta.com, lkp@intel.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 15 Jan 2026 18:45:09 +0000 you wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> Add __force annotations to casts that convert between __user and kernel
> address spaces. These casts are intentional:
> 
> - In bpf_send_signal_common(), the value is stored in si_value.sival_ptr
>   which is typed as void __user *, but the value comes from a BPF
>   program parameter.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1] bpf: Add __force annotations to silence sparse warnings
    https://git.kernel.org/bpf/bpf-next/c/170014769761

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



