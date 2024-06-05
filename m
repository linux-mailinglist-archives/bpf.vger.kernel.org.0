Return-Path: <bpf+bounces-31417-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2854C8FC50E
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 09:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D823328516C
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 07:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32A018F2EB;
	Wed,  5 Jun 2024 07:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSEX49P4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1694C6E;
	Wed,  5 Jun 2024 07:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717573831; cv=none; b=aReCtLPFIrX2KmJpZ1Yf83KzXuP9SnQOZKIDMzoazTRJAr9TeKPv/PqtZIgOPe20L/lR35+nLE6QjFapUVKmWE3liI/1PGrLT+deKvhEHojoR4TLq+6vnVS3BZq6jWBBvXfqtkzVO8JAuAXJUjbdtwdUIFqEUlO9T70aHf3iY/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717573831; c=relaxed/simple;
	bh=l60+a+2F773diGs/DhPR4GbCIfTEFMLCq+IM9bitPyo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=STrAzrsInZ75Kd3QNiH9cGWeMBUKQTLmfVdvXyHRCQfq/96amtyzWNXkrhVXHCmrZTdLlwx7qG/ByaZktsHwJGxUVIM3QvQd4YG8O9v25Ohjcc3y7OjSqyLF9iSQRB/S/rQZrOhlAJFkAykWDp6z6DPC/n6E7gbmuI2J7gzL7Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WSEX49P4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EA6FEC4AF07;
	Wed,  5 Jun 2024 07:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717573831;
	bh=l60+a+2F773diGs/DhPR4GbCIfTEFMLCq+IM9bitPyo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WSEX49P4U+iBr63WLV4bHnHJAyBq/JulfSJuXRIe5kZMo3IvnKYFute7tpflDDf7a
	 cF870mXa5wvnge09hJpy8QAOGQXepOeRHshnWfsIO+IlldBzZ2sHykSRZXR3CwofwD
	 y5gFf5zt+g+X0vOsKWZNTKLrn5R87E8lBH2aPNn+tcUD7TAw3UFc4zEhjRhadFL2AB
	 T8MU+lnbvAfQoInOSSds6kxX7PJphbzmp01Ix4D5C37+nsG/TSVYd/axM4opLcl1xS
	 UMkTqwbOY9mWxC3QeqiEq9Wl0wThprTw6A3JprZhay5ysk+q3jQdD31LcrSt099qGB
	 dkqR2EV3PiegA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E1832C4332C;
	Wed,  5 Jun 2024 07:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 0/2] Revert "xsk: support redirect to any socket bound to
 the same umem"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171757383091.23600.1874186480870306313.git-patchwork-notify@kernel.org>
Date: Wed, 05 Jun 2024 07:50:30 +0000
References: <20240604122927.29080-1-magnus.karlsson@gmail.com>
In-Reply-To: <20240604122927.29080-1-magnus.karlsson@gmail.com>
To: Magnus Karlsson <magnus.karlsson@gmail.com>
Cc: magnus.karlsson@intel.com, bjorn@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, netdev@vger.kernel.org, maciej.fijalkowski@intel.com,
 bpf@vger.kernel.org, YuvalE@radware.com

Hello:

This series was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue,  4 Jun 2024 14:29:24 +0200 you wrote:
> Revert "xsk: support redirect to any socket bound to the same umem"
> 
> This patch introduced a potential kernel crash when multiple napi
> instances redirect to the same AF_XDP socket. By removing the
> queue_index check, it is possible for multiple napi instances to
> access the Rx ring at the same time, which will result in a corrupted
> ring state which can lead to a crash when flushing the rings in
> __xsk_flush(). This can happen when the linked list of sockets to
> flush gets corrupted by concurrent accesses. A quick and small fix is
> unfortunately not possible, so let us revert this for now.
> 
> [...]

Here is the summary with links:
  - [bpf,1/2] Revert "xsk: support redirect to any socket bound to the same umem"
    https://git.kernel.org/bpf/bpf/c/7fcf26b315bb
  - [bpf,2/2] Revert "xsk: document ability to redirect to any socket bound to the same umem"
    https://git.kernel.org/bpf/bpf/c/03e38d315f3c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



