Return-Path: <bpf+bounces-27443-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 376B58AD168
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 18:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68BC91C2261B
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 16:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EFB15357B;
	Mon, 22 Apr 2024 16:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDYn816V"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01D515350A
	for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 16:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713801629; cv=none; b=owT+Z+PurnE2EVgpNxAeZxiYtlClKoscHOd3caZLWI+Esi60RAa4iDb/Rl1qPzXNKaCygc7NnOriOgB0eXkFKtZLpTwH0PyTzYMfxws/ZYmm2Xp0pgHihKoPwcI//fhGeS/eqgmQ4uCahKmI2dbKKznqQ2Dwq/+/YOF3hpEoo4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713801629; c=relaxed/simple;
	bh=QkrPWOcTU/3YIgjl4F+eZ2pKMJfRfw3K07q0JbQQZKk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oxOF5hQm/ke/TTb16PXgR86dHOoajQjZJq8BaJJqUy/05B6JicJoxvf/mUBnWC4ciwh/Jm86VMQIFeyihoMmdjMpfO6GY7PTg5fRm24twOsXveBoFHlfFImkz5DLp1cW5e5RiKOpFkG7lo7yfF6Q+KIFjS2NGXt13ZbSZkXG2i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDYn816V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2CD00C32781;
	Mon, 22 Apr 2024 16:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713801629;
	bh=QkrPWOcTU/3YIgjl4F+eZ2pKMJfRfw3K07q0JbQQZKk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iDYn816VHGB+0xWNCvyAG9/KYdG3hRes1cuBkoJA/f1dj/r4jnDfW1Uc4WRIH5mvr
	 Gk3+9LXI6B98VvHzbyUI6XYiR5w4Yk3R4KO4/c+Bfd4cQp3SmL0zoEzL2kE+Q6Jn7P
	 eSEXBMPt0WrJLKe/AE0h5dqHE4zBl3DAipoZ9lLFkktoRxehof86/ePoyaxPuTnRcq
	 Vwqj0d560NfXqoBjFKTTkpK2dnAXKK/h3YIcpjWWptPBql03btWQFJsasi49jX3P/J
	 NdIrK73vR7l2cJM6CpfB9D1jhacY99txy0Rslicb9vmMPX0xca4vp2d/OTR+N0E764
	 yr3IYwF0wPX7A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 19770C43440;
	Mon, 22 Apr 2024 16:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/2] bpf: fixes typos in comments
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171380162909.14642.13258792385476743002.git-patchwork-notify@kernel.org>
Date: Mon, 22 Apr 2024 16:00:29 +0000
References: <6af7deb4-bb24-49e8-b3f1-8dd410597337@smtp-relay.sendinblue.com>
In-Reply-To: <6af7deb4-bb24-49e8-b3f1-8dd410597337@smtp-relay.sendinblue.com>
To: Rafael Passos <rafael@rcpassos.me>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 17 Apr 2024 15:49:14 -0300 you wrote:
> I found the following typos in the comments, and fixed them:
> s/unpriviledged/unprivileged/
> s/reponsible/responsible/
> s/possiblities/possibilities/
> s/Divison/Division/
> s/precsion/precision/
> s/havea/have a/
> s/reponsible/responsible/
> s/responsibile/responsible/
> s/tigher/tighter/
> s/respecitve/respective/
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf: fixes typos in comments
    https://git.kernel.org/bpf/bpf-next/c/a7de265cb2d8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



