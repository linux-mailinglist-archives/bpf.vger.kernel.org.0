Return-Path: <bpf+bounces-40438-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87346988B7D
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 22:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39F2D1F24A55
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 20:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD61D1C2DB3;
	Fri, 27 Sep 2024 20:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iO1Rl+Fo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F0115B57C
	for <bpf@vger.kernel.org>; Fri, 27 Sep 2024 20:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727470228; cv=none; b=PRvZwCE2p8e18rJsr++5BJ+aYdMDtEr31bA5mrHwGW5LgtuAU8iErqBSs4uAB6NDNyx7nEjSxsDxEmAlAwuKiZ0oPJeP5MZoxFZNkxRKEUYv+CU9pZaQZHFC5/PnhKRfxENMVEG2bjdKE6Rjk6cvcQOdmE5mEJhWB5uiDigrcr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727470228; c=relaxed/simple;
	bh=jb/shboc0zdOXkJtWcknXQzVCir8lJXxy8TATOVnJs8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IIJtUaYHZjMNJodgRS0P8bIyWodfQRUy316nR1b/ZqoTCmvXM4DWIrwMVs8eHHWKYPVMuMZSDgPTR8KW66UWkGgrsvE6cyMjtPAUauRu5RECwx6HJ5Fw06RmTRNYnPppIVuBum2UUFqihju2y749Wpv4aL3l3JzEUm/8J3CPc/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iO1Rl+Fo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB90DC4CEC4;
	Fri, 27 Sep 2024 20:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727470227;
	bh=jb/shboc0zdOXkJtWcknXQzVCir8lJXxy8TATOVnJs8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iO1Rl+Fo1c55A9bIpfq25TuzQsmjnNJpzBWrHDwwjsovMnWqV6+ZSBRDAhXBjdSOR
	 XTisCAOG26b2qQstyDrDVGXaLigm5lSkicoJUHpqIwq75nPBBjX0QM2rQIEj43imEe
	 LIbRIzNXjC8sfF9XQePhY1KftFLwEJEoX4fqROxFV6HYzv2MwsgOXflj2uaGvz+nsx
	 pzMy8Qom5qyP/ROeILLXSS9F/Wg3WpD1nz1X3/MZGDN8nndy+5fQzO0WQmeenC4gX8
	 +EOWKV0DbVpp0NkV8xi04VcxeqOm/fNbxQmDMy9kUHfTFXa6I6QY0jlINVm3o/umsk
	 KjzTrlAg5nL7A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AF1AD3809A80;
	Fri, 27 Sep 2024 20:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: fix uprobe_multi compilation error
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172747023053.2079499.6816701153103508294.git-patchwork-notify@kernel.org>
Date: Fri, 27 Sep 2024 20:50:30 +0000
References: <20240926144948.172090-1-alan.maguire@oracle.com>
In-Reply-To: <20240926144948.172090-1-alan.maguire@oracle.com>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 26 Sep 2024 15:49:48 +0100 you wrote:
> When building selftests, the following was seen:
> 
> uprobe_multi.c: In function ‘trigger_uprobe’:
> uprobe_multi.c:108:40: error: ‘MADV_PAGEOUT’ undeclared (first use in this function)
>   108 |                 madvise(addr, page_sz, MADV_PAGEOUT);
>       |                                        ^~~~~~~~~~~~
> uprobe_multi.c:108:40: note: each undeclared identifier is reported only once for each function it appears in
> make: *** [Makefile:850: bpf-next/tools/testing/selftests/bpf/uprobe_multi] Error 1
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: fix uprobe_multi compilation error
    https://git.kernel.org/bpf/bpf-next/c/db38ed2cfa62

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



