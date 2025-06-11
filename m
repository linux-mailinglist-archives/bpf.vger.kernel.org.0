Return-Path: <bpf+bounces-60387-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE78AD60C0
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 23:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5A6F3AADC4
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 21:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F71B2BDC34;
	Wed, 11 Jun 2025 21:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gL0dKys7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FDE28850C;
	Wed, 11 Jun 2025 21:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749676208; cv=none; b=kAilPs8VIksjn2+ZXNarJawneT9j0VepK0Hlvobr6jVZg9TYtTxJWb4l88M+ONai97mwerd9m+ss8GhxMWr5IHu3asHiIDOW4F1Li4aVyoBv7BdPO9ZqYvsVCSGcsHhdXVy9atCtI/9zet1Rd/iXa1mJlMaezAjLRt3Kt2Zqxm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749676208; c=relaxed/simple;
	bh=yoZJsoXICfhX05KpANME2Lttp2iQeV3DjkQP8RzmicE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W8AwK2JFiwypa8IwNtDL6MD2ACc4BnU7tsEiRPhBtT02jIX/cLLxSTxcIMpNB4j8XXpfqf0eQPZXLENw7xQy4pYm44WvDZrZtFz9FBiV/98B2I6sf70nrm8VVDOI/mLPlcnRLrXqMZeRfVD3jUF27XXJpO2Iu8IP66QDiw4z34k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gL0dKys7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25806C4CEE3;
	Wed, 11 Jun 2025 21:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749676208;
	bh=yoZJsoXICfhX05KpANME2Lttp2iQeV3DjkQP8RzmicE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gL0dKys7kONY6Sqa0j/qwgNuku1s+rT0Al/A7o8Rvk49e4nYcswnjcXrs6WlkBaka
	 Z7pLuR5y9EF7HDLUJCwo8jnw1eTsALX6uBICJOln4uhbuXWjH+cZuUgP6zFWEcd3yX
	 qYCnJOiF1EnYtj48UY2WMiXWVR+Kwxri/vkE5663zSmITSsF0xtUXpGtcaXMigjWBS
	 X3ut8e4cjc8fE+GSKeXzHRa3TVue3ODNZAUeCjtPimL0WuWSfy3i/40mI22s/LoKSa
	 HdnF/cqmfPavUzvCeI4BqneJ4pXM/faifqeNreSd4KyvIbELzC4CbpEEB3Qdv58hRR
	 n5pxLfRMmNu/A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DFD380DBE9;
	Wed, 11 Jun 2025 21:10:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1 0/7] netlink: specs: fix all the yamllint
 errors
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174967623825.3484955.9903714612397953732.git-patchwork-notify@kernel.org>
Date: Wed, 11 Jun 2025 21:10:38 +0000
References: <20250610125944.85265-1-donald.hunter@gmail.com>
In-Reply-To: <20250610125944.85265-1-donald.hunter@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 mptcp@lists.linux.dev, kernel-tls-handshake@lists.linux.dev,
 bpf@vger.kernel.org, donald.hunter@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Jun 2025 13:59:37 +0100 you wrote:
> yamllint reported ~500 errors and warnings in the netlink specs. Fix all
> the reported issues.
> 
> Link: https://lore.kernel.org/netdev/m2tt4tt3wv.fsf@gmail.com/
> 
> Donald Hunter (7):
>   netlink: specs: add doc start markers to yaml
>   netlink: specs: clean up spaces in brackets
>   netlink: specs: fix up spaces before comments
>   netlink: specs: fix up truthy values
>   netlink: specs: fix up indentation errors
>   netlink: specs: wrap long doc lines (>80 chars)
>   netlink: specs: fix a couple of yamllint warnings
> 
> [...]

Here is the summary with links:
  - [net-next,v1,1/7] netlink: specs: add doc start markers to yaml
    https://git.kernel.org/netdev/net-next/c/ce6bd277e1f7
  - [net-next,v1,2/7] netlink: specs: clean up spaces in brackets
    https://git.kernel.org/netdev/net-next/c/880d43ca9aa4
  - [net-next,v1,3/7] netlink: specs: fix up spaces before comments
    https://git.kernel.org/netdev/net-next/c/2338bab56951
  - [net-next,v1,4/7] netlink: specs: fix up truthy values
    https://git.kernel.org/netdev/net-next/c/3c90fd2baaa0
  - [net-next,v1,5/7] netlink: specs: fix up indentation errors
    https://git.kernel.org/netdev/net-next/c/ec362192aa9e
  - [net-next,v1,6/7] netlink: specs: wrap long doc lines (>80 chars)
    https://git.kernel.org/netdev/net-next/c/d26552d38c82
  - [net-next,v1,7/7] netlink: specs: fix a couple of yamllint warnings
    https://git.kernel.org/netdev/net-next/c/97c6383113b5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



