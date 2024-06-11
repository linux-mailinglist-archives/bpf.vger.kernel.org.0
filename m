Return-Path: <bpf+bounces-31764-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFF4902E01
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 03:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 400A81F21F6F
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 01:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2621B673;
	Tue, 11 Jun 2024 01:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IG9vYEoV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1F18493;
	Tue, 11 Jun 2024 01:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718070039; cv=none; b=QLL34F5DeS8LgsKPjIb+GmpA+MAG7Ubr+KQfFcKlOijQoEKhntzEsHJYNBq7lMaiEQbyLynMUKGDxORi7SIH5/orYdGWe9E6Qe2IIZTGNVjKoU69dDEJUj8rSHVWZZbfRrhGh1s8y/XpvejkwvInjxRwDpSKEMJuyZSJAl2cEnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718070039; c=relaxed/simple;
	bh=zNhu5pv74/0YgzcNxpZ0CEreH1xs1OhCRuHlie/CuRw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YXeNtpT4mXd966pVjJJKS2ZNcaRmwW/mbUjs8ytHZjitYYg1CTptw6sDmRJWq9gqq+kfRdifhj/a2EgKjcO9j8xNxtGSdDaBPOXYPVHW/zAJIIw3MGFBp9Rg0XMwS2+k3ftCntD0abHVy1Q/Y6n9yvjMH8E9ErTShTBDS2Uya8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IG9vYEoV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9C03C4AF48;
	Tue, 11 Jun 2024 01:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718070038;
	bh=zNhu5pv74/0YgzcNxpZ0CEreH1xs1OhCRuHlie/CuRw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IG9vYEoVHE2dZnyaPlheX5Mb8SgccoCYVoQZ2Uc66VX9hYR1qhc+gNS1uheWfN3jg
	 3EjiU6DOs3/7CSzpASjoYMVibEtsIaKw0BlUqrpTlt0JIEbDhw404DRWnLqUx7QELI
	 ZLCNWK1405fqtiCj1B/ecU8dvOEZKag0x5fHR/Eu/nqK22nxMdpBBUYvpdEPFGYva2
	 T4SJ07anUDnY1mw6C/qOO8OlCQ090ZuvhlFZ/y/o0YXtGi45RhUZUUiig/0ADPf2Fw
	 QV0RumNLceTzZ5yNAQaswYuQWI5/TDQrp4WzWtOFz8U/iUN76m/e8YW9zDFh4/s6JB
	 VMUeyR7yoYYkg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 91594C595C0;
	Tue, 11 Jun 2024 01:40:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf-next 2024-06-06
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171807003859.13638.9594019239427847256.git-patchwork-notify@kernel.org>
Date: Tue, 11 Jun 2024 01:40:38 +0000
References: <20240606223146.23020-1-daniel@iogearbox.net>
In-Reply-To: <20240606223146.23020-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  7 Jun 2024 00:31:46 +0200 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net-next* tree.
> 
> We've added 54 non-merge commits during the last 10 day(s) which contain
> a total of 50 files changed, 1887 insertions(+), 527 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf-next 2024-06-06
    https://git.kernel.org/netdev/net-next/c/b1156532bc29

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



