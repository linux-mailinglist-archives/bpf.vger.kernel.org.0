Return-Path: <bpf+bounces-47952-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A081AA027B4
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 15:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26EB5188592D
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 14:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859481DE8AF;
	Mon,  6 Jan 2025 14:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rX0i1QG3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0660C433CA;
	Mon,  6 Jan 2025 14:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736173210; cv=none; b=StdEwVTrS/adLaUlgf6JBuXCkRmD1YRWrIjjwL7ncApwpBkiDF1ZeQjoUNM1ysWbQCT5K2v/qwM7bdvtG/KFtaBoLhECHH1UmljmL4rADgRbtVWcWGPUGUyAB0AUg3muw+pnSYms8RBkFRVJvd7jt3KkaaC2HivqN+489I6u3Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736173210; c=relaxed/simple;
	bh=RKd7knf1LcOLKPssmb/Vq2FTYvbMnTcKGAZPremeTsY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=p7Xh8g50XKzABKW3sO4nRGPno0+p8QGzzzO+doKkDLNkVoUFDpYItp+rps1V0Q4/nKmdKWmm89UdEedh6nWPlhS3+H1QxzGv6XNtKe6u418jqVqOpBlznEMFrLaQ1MCElSLYZeuP1tnDCddMs/sOoLIO7IujJBHuChOTvwVoEHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rX0i1QG3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 999CBC4CED2;
	Mon,  6 Jan 2025 14:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736173209;
	bh=RKd7knf1LcOLKPssmb/Vq2FTYvbMnTcKGAZPremeTsY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rX0i1QG37+O46vITWZvwj7oCSpTvSPXyDRIb+QtnK7tdMNxN0o4sRXcfNyzuuEgHj
	 41loxt4nzIjAh9nPDgfIt3SRWGjJqDRB8Hqulj0HtS1nOOvaB29NLuO+MAjeswSr+z
	 Z9zL8pTK76aJpIYRJbOdWw2lj72jaXRQReXXp32m3hBsZq4nQduBEQhHkuLRk/i3jn
	 3PdaSlmMRAmDcL4ck3VR5pDXfzrromsjGcSgVeXRwgVsTU75eO/2Bn18xV97bohfl2
	 hAZxh3y1nryadMuoRB9ClAYoHluHa2+MH8pqfHAjm8kZ3qbqodS/CYmkfkDsRdA6Fr
	 OsMeDLkPsi7RA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB104380A97D;
	Mon,  6 Jan 2025 14:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 1/3] bpf,
 arm64: Simplify if logic in emit_lse_atomic()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173617323051.3507566.4440450851266640533.git-patchwork-notify@kernel.org>
Date: Mon, 06 Jan 2025 14:20:30 +0000
References: <e8520e5503a489e2dea8526077976ae5a0ab1849.1735868489.git.yepeilin@google.com>
In-Reply-To: <e8520e5503a489e2dea8526077976ae5a0ab1849.1735868489.git.yepeilin@google.com>
To: Peilin Ye <yepeilin@google.com>
Cc: bpf@vger.kernel.org, xukuohai@huaweicloud.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, puranjay@kernel.org,
 catalin.marinas@arm.com, will@kernel.org, joshdon@google.com,
 brho@google.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri,  3 Jan 2025 02:02:53 +0000 you wrote:
> Delete that unnecessary outer if clause.  No functional change.
> 
> Signed-off-by: Peilin Ye <yepeilin@google.com>
> ---
>  arch/arm64/net/bpf_jit_comp.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)

Here is the summary with links:
  - [bpf-next,v2,1/3] bpf, arm64: Simplify if logic in emit_lse_atomic()
    https://git.kernel.org/bpf/bpf-next/c/0a5807219a86
  - [bpf-next,v2,2/3] bpf, arm64: Factor out emit_a64_add_i()
    https://git.kernel.org/bpf/bpf-next/c/66bb58ac06c2
  - [bpf-next,v2,3/3] bpf, arm64: Emit A64_{ADD,SUB}_I when possible in emit_{lse,ll_sc}_atomic()
    https://git.kernel.org/bpf/bpf-next/c/8c21f88407d2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



