Return-Path: <bpf+bounces-79322-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB47D3846B
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 19:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C595C3004284
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 18:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41663491CD;
	Fri, 16 Jan 2026 18:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rz8F+syH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7527D283FEA
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 18:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768588419; cv=none; b=ZdRHXCg+2JTW1B3ezLlg7QlqHNiLIah/p5Y26ft2edx8clG5YNRYnvGLvgW5cCfEtH3A9CRGRJOHb1IhT1rOTB65y6hTahkp9GG6QQKGR6UI4FMcCoRtiG1WUPwSug7zIp7ndvhxCa6zXen58BClJUM40p0HfgB57rRWEVRz8eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768588419; c=relaxed/simple;
	bh=YyA/O9vUnR+K+4GMxQBkahiz+OQYRDgwPT6QCaX4i98=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=svtGd64GKB6QlKDbgJTcba5CeWQM6WzivhlnCEpL9tsK631/rU902piH02VceJlia8ZMEP+TOkzSk73JiAOzoIwaAbpST/S0X2YQ+S/a6iq+Us6sWcBqMbdCm+dLD8wtNLLGnPcuLNAknr+ix/rEuZv5kS1rOn8B1/GcElweO9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rz8F+syH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01316C116C6;
	Fri, 16 Jan 2026 18:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768588419;
	bh=YyA/O9vUnR+K+4GMxQBkahiz+OQYRDgwPT6QCaX4i98=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rz8F+syHSd1q1f0PNJ8811hslqdal4+kGoFjuPEG6TtXB8MIoduEWW2pgyNfF9xvM
	 K40wvewTSQ2LUROS24NKZTAztjel1fa7UaSI6+rynpPoDpI2ZRZbMaFtf4krFPHm8n
	 aevw7m74//aPhVCsV5sOsFB2W2oyAECCi1LodCxPxVg+VmnwSFe/f+kirlR5fifUfB
	 yA/NEp4ELnsFs1YnxUY49yZ0f/O+VnV/nhbse7LEMA9kyoG2N5CySET4jeh06GdK/Q
	 MhDSAmMKxwWx1iA8zLmKS/1HkpoN5u8aq4MsEh08pf8MKp0kFsqJgdLVcanTXnGzJl
	 i1bg4dkCK5aTw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B5ABF380CECB;
	Fri, 16 Jan 2026 18:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/2] bpf: Fix linked register tracking
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176858821054.756555.9976873306632220062.git-patchwork-notify@kernel.org>
Date: Fri, 16 Jan 2026 18:30:10 +0000
References: <20260115151143.1344724-1-puranjay@kernel.org>
In-Reply-To: <20260115151143.1344724-1-puranjay@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, puranjay12@gmail.com, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, mykyta.yatsenko5@gmail.com,
 kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 15 Jan 2026 07:11:39 -0800 you wrote:
> This patch fixes the linked register tracking when multiple links from
> the same register are created with a sync between the creation of these
> links. The sync corrupts the id of the register and therefore the second
> link is not created properly. See the patch description to understand
> more.
> 
> The fix is to preserve the id while doing the sync similar to the off.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf: Preserve id of register in sync_linked_regs()
    https://git.kernel.org/bpf/bpf-next/c/af9e89d8dd39
  - [bpf-next,2/2] selftests: bpf: Add test for multiple syncs from linked register
    https://git.kernel.org/bpf/bpf-next/c/086c99fbe450

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



