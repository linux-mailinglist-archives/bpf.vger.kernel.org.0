Return-Path: <bpf+bounces-32484-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C9D90E152
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 03:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08EBC1C21120
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 01:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74838D27E;
	Wed, 19 Jun 2024 01:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/qp1vNm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB48C4A1C;
	Wed, 19 Jun 2024 01:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718760631; cv=none; b=kPJ57Gx1iZGXo4NrUCrCd34C6pwtHO2fmMcMNvfe4VdVq5G4XJRh2nyRA6CBoYeHFwiXN6eia1bZ+mjFfRq5luyRzCueLnFjDXotvZ4xztrJYCJI5N3Ew1gU31IyTrhPCXuhLEayVpXHrnkoQFlhlJsg8nGKvnhFpkc8wFfbUMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718760631; c=relaxed/simple;
	bh=wQ3Cz/uQIcGqihIGy+5skYzSVYyJDZw1/SIUXnbJ4U0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=b3syxXeKO0jEAy1lp9eIcL+nPj5QlDxppjRyrCYlFhZUwTaSC3tVL7toROiUlhc9zf8PcOFfQAnKlxNte5kNYTBFF25Fh/Src1UwCuVhjUlQHNmhxs+lBoY8rSe4SaZf4jpjCDMz+Rv4itevYFCABw+7QWpIgrdwIVN/P3Z+2tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/qp1vNm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9AB24C4AF49;
	Wed, 19 Jun 2024 01:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718760630;
	bh=wQ3Cz/uQIcGqihIGy+5skYzSVYyJDZw1/SIUXnbJ4U0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P/qp1vNmfj4Cz30qvlOzpOipaTwpAAQocBBKgTYbnuuWCWA3MiHvuwLtLHv5GPg8u
	 wsUsyqZ9yocbgno/nCacZDgdaQEQ9iasK2AWDGwFZDLHbrmAHM6ndNVD8778SBrsZa
	 jMRyNSQl58hRRsCCemOcWLP9TuyoPZAzYk69apIUPmInXSalbmAnBiJELkT8Qx2SBu
	 8yD7OojtsTFBpCLBgq7lP4cxu45vOCW0L4JWHjklrNRs7UrYRgSvvh1V3b/FaAtbFS
	 kjG+8N8+WiaTvojfE57BP6FDXiqtza36ZlkgQn1oRDLLPhw23c2Ql59ZjIBP3BoXP/
	 +w5KwqG4FMQxA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 757CFC43638;
	Wed, 19 Jun 2024 01:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3,net-next] net: mana: Add support for page sizes other than
 4KB on ARM64
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171876063046.16543.5866630072477597373.git-patchwork-notify@kernel.org>
Date: Wed, 19 Jun 2024 01:30:30 +0000
References: <1718655446-6576-1-git-send-email-haiyangz@microsoft.com>
In-Reply-To: <1718655446-6576-1-git-send-email-haiyangz@microsoft.com>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, decui@microsoft.com,
 stephen@networkplumber.org, kys@microsoft.com, paulros@microsoft.com,
 olaf@aepfle.de, vkuznets@redhat.com, davem@davemloft.net, wei.liu@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, leon@kernel.org,
 longli@microsoft.com, ssengar@linux.microsoft.com,
 linux-rdma@vger.kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 bpf@vger.kernel.org, ast@kernel.org, hawk@kernel.org, tglx@linutronix.de,
 shradhagupta@linux.microsoft.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 17 Jun 2024 13:17:26 -0700 you wrote:
> As defined by the MANA Hardware spec, the queue size for DMA is 4KB
> minimal, and power of 2. And, the HWC queue size has to be exactly
> 4KB.
> 
> To support page sizes other than 4KB on ARM64, define the minimal
> queue size as a macro separately from the PAGE_SIZE, which we always
> assumed it to be 4KB before supporting ARM64.
> 
> [...]

Here is the summary with links:
  - [v3,net-next] net: mana: Add support for page sizes other than 4KB on ARM64
    https://git.kernel.org/netdev/net-next/c/382d1741b5b2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



