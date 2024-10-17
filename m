Return-Path: <bpf+bounces-42327-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3539A2BC4
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 20:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8085B26224
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 18:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BB01DFE2A;
	Thu, 17 Oct 2024 18:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVtowNYp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE6F1E049D
	for <bpf@vger.kernel.org>; Thu, 17 Oct 2024 18:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729188626; cv=none; b=bPJmEHurVCW4F2bO9t6PmjAt5dQT3gvyjrC9JrlymnCKiCBb/krhV+kN5sy437fjh5wjWwkDnVKtsZr9Mb/uyeBvfiicgZen/U4UyEtnMB28Jae95iv/yEUQmur8tGceuc9bSSnp5azuVzqEHu8yPA1jj26DE1ja+z6efWHV5Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729188626; c=relaxed/simple;
	bh=pxChfw60E7dcMgDXMGdR25SGlhJhseL0PhRQRo4DCig=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Lx1F+q1+rNMnJ2RAYm03nyUmIgmK0oC/dXN1RYGS+ZaIGeiXCGyYBgRgvhHQ8NSx0RDtjT26ww8wJpYS3hdngOC3XLlFFDzpgRrhm/Mq1NzEW+ZykXg1S6siuZvqJkdLWtHz81Fc/4klzxqZz5goVC+2iGTzoaK18BfhjmRsnvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVtowNYp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9E37C4CED1;
	Thu, 17 Oct 2024 18:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729188625;
	bh=pxChfw60E7dcMgDXMGdR25SGlhJhseL0PhRQRo4DCig=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bVtowNYpYqpgvYQIC1qwd/UDOlhwevyX9ngdbQZlUguA1wirZdpoFd2y8wzVdn4A0
	 QxU+s8cDTE0aoVXi+aw3q3rNrHUp5WWH/IO38MbyJbvTvQOKZ7TTs0I4swCBm5EBL+
	 pcQXtaT4mBkv7IOACVI0bTGdvK6+sBITL56hNd70jHrPDvm8BWu7kzhr1xHLgEksPm
	 t/bTSOmV685xIehCHf2S1n6d8MxaREe9Bo6vCEQ3qnal/JuiM3bOeLnMx3o3WJV3K3
	 LkK+O6OulSVEXuUhJNyuac0rbux35sh/taHqtoLcDpHlb0HP2wHQ/LEGfChgkIpc69
	 vP/yLJFN2QeAQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D323809A8A;
	Thu, 17 Oct 2024 18:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 1/3] bpf: Fix incorrect delta propagation between linked
 registers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172918863097.2561819.16960201256166830425.git-patchwork-notify@kernel.org>
Date: Thu, 17 Oct 2024 18:10:30 +0000
References: <20241016134913.32249-1-daniel@iogearbox.net>
In-Reply-To: <20241016134913.32249-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, nathaniel.theis@nccgroup.com, ast@kernel.org,
 eddyz87@gmail.com, andrii@kernel.org, john.fastabend@gmail.com

Hello:

This series was applied to bpf/bpf.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 16 Oct 2024 15:49:11 +0200 you wrote:
> Nathaniel reported a bug in the linked scalar delta tracking, which can lead
> to accepting a program with OOB access. The specific code is related to the
> sync_linked_regs() function and the BPF_ADD_CONST flag, which signifies a
> constant offset between two scalar registers tracked by the same register id.
> 
> The verifier attempts to track "similar" scalars in order to propagate bounds
> information learned about one scalar to others. For instance, if r1 and r2
> are known to contain the same value, then upon encountering 'if (r1 != 0x1234)
> goto xyz', not only does it know that r1 is equal to 0x1234 on the path where
> that conditional jump is not taken, it also knows that r2 is.
> 
> [...]

Here is the summary with links:
  - [bpf,1/3] bpf: Fix incorrect delta propagation between linked registers
    https://git.kernel.org/bpf/bpf/c/3878ae04e9fc
  - [bpf,2/3] bpf: Fix print_reg_state's constant scalar dump
    https://git.kernel.org/bpf/bpf/c/3e9e708757ca
  - [bpf,3/3] selftests/bpf: Add test case for delta propagation
    https://git.kernel.org/bpf/bpf/c/db123e42304d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



