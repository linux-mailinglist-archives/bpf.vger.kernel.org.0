Return-Path: <bpf+bounces-32413-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A3490D758
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 17:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14DBF1F23BC8
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 15:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30954AEEF;
	Tue, 18 Jun 2024 15:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Evu1Ln3A"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEE549658
	for <bpf@vger.kernel.org>; Tue, 18 Jun 2024 15:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718724631; cv=none; b=H+0eM58C6ooJNVX6qvlBrAL9nl2nFQwbrgkOOLgRJqhpTcVLra53EzTKpAWLHVeg7TrtNN0gkyXGLRrY6okdJ6uKFy8anbBz248X1dxHG74x2q0HVkmtBrYXsdMxKTttedseWpJGOV7rfyaC6Q925ZL4nVznzix7V6gJ+cK+PYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718724631; c=relaxed/simple;
	bh=tSBWau1xhha8Xw+q/NXwxzxbDBOa8B3Nb/OVTgILNqs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BWX6NtCl0V2YQC/CNOfBarW/bkq51ksHYsftA50DnlE7mxlL75MGP4hqWMeoT4kYvdlmKsblihowfYByqLXVAGSW9JeZ0ncOcpae3o88521jUQlcHazX3B+LHVMW6vnWtibfCMXheCmqUjOu2/xSOTnnADM7RkESYVW1X3ZwUOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Evu1Ln3A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BC4CBC4AF4D;
	Tue, 18 Jun 2024 15:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718724630;
	bh=tSBWau1xhha8Xw+q/NXwxzxbDBOa8B3Nb/OVTgILNqs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Evu1Ln3A4RmfigMDfzd/ZWu3HwKCuWdRPaVjHVjtfQljMUPCleLKXZb6kYmu5w3Iy
	 gDPlU57rNWfVFmDQnudfhi68SaETe9GoXU5b1pOnA7wEqhEfltEmyFbPS+N7BMgFrr
	 /eXfAkaJt3swfQsHeelPItaDR/oSLtD2w+MogXV5sh0WoExi3iLGTlDTdERxrq5B8q
	 odZQypEY8uXiwfALzIUoinICMWSnCrxHW8BsBlAcBuVpzxt8HwH1Dprf6L5rlMutaY
	 hqMYRhrKgL4aJpPq8jUVbgNVr3uUOAfmL46r/0f0/BMpKMVdBsqVTIgHvdNcy6RJpv
	 OlT+kQaaMnzgw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A3790CF3BA4;
	Tue, 18 Jun 2024 15:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf] bpf: Fix remap of arena.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171872463066.11632.12661604683114368092.git-patchwork-notify@kernel.org>
Date: Tue, 18 Jun 2024 15:30:30 +0000
References: <20240617171812.76634-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20240617171812.76634-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org, memxor@gmail.com, eddyz87@gmail.com,
 pengfei.xu@intel.com, brho@google.com, kernel-team@fb.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon, 17 Jun 2024 10:18:12 -0700 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> The bpf arena logic didn't account for mremap operation. Add a refcnt for
> multiple mmap events to prevent use-after-free in arena_vm_close.
> 
> Reported-by: Pengfei Xu <pengfei.xu@intel.com>
> Closes: https://lore.kernel.org/bpf/Zmuw29IhgyPNKnIM@xpf.sh.intel.com/
> Fixes: 317460317a02 ("bpf: Introduce bpf_arena.")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> 
> [...]

Here is the summary with links:
  - [v2,bpf] bpf: Fix remap of arena.
    https://git.kernel.org/bpf/bpf/c/b90d77e5fd78

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



