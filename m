Return-Path: <bpf+bounces-74099-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE98C49325
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 21:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C20A63AFC9B
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 20:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5C7340264;
	Mon, 10 Nov 2025 20:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d1dk9dvr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F364033F8BD;
	Mon, 10 Nov 2025 20:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762805443; cv=none; b=FmuDh4iLvtUbTnl5em5c/MpTxuNO0y9a1wuXOrpaRQRDff+qPekHFjTXfk0GEbWKy/xm/BrHjx2vX3Vu5CT6zaDoW2q6xdn9NHYXPAayV3wT1VRJ4qwohju5+VjUDmarzn6bMOYii70MCCIP29+yBZVaEac47bfNBGlp0ATvibQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762805443; c=relaxed/simple;
	bh=KAoV0nJNu/15iAQr2uWfgmu7VS979kqZ/TT0hSE1/6E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gQp4wtslbQm/6WdjpJX/UOjWK3aDrxulkV0fB43Kmkp3pleu76685LGnm/2Bo/ufDJvP7BwfS+HCqLqpOPgvSCwL+kFm5hH/z4Vt2M3zRXMNilXe39X2iQOi0ijv++vkUAn/duqFtDiQyXUkz4oTUjpW+FYPL6/0e/cWjVbXOKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d1dk9dvr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA9CC19421;
	Mon, 10 Nov 2025 20:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762805442;
	bh=KAoV0nJNu/15iAQr2uWfgmu7VS979kqZ/TT0hSE1/6E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=d1dk9dvr+QOF1grKM8ecYrASOiTLg102nZXQBOTbkRVvIsFf9Rgc8QpA98gknQQb3
	 2qUJHdHrSjltdTnBrLBeiHODuk1Z6+BKeSxXTH0cVgYPal2PYNSctNRFMwLu/YFtTa
	 OjA0b8xleCpwlpaTbPA3mGNu7QbsXPfMTKfNlgNdxVb48vhvycsK5HwAPqv6sjiQCZ
	 ogTazg8w8T5mgqWqWCMaXLbTi4k5mILPWFYgaLS2Cb/romxVGUdVaetaPSCNmIqxiN
	 RkR4cPTTVaJGh0kQuE+xHi1cmhjJYA0I7II5LZqbefz+xXt4KZFuLntGeccLWU2wlQ
	 QJh0zGRnUsXzA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710B1380CEF8;
	Mon, 10 Nov 2025 20:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 0/3] net/smc: Introduce smc_hs_ctrl
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176280541325.2759707.7993878047530807107.git-patchwork-notify@kernel.org>
Date: Mon, 10 Nov 2025 20:10:13 +0000
References: <20251107035632.115950-1-alibuda@linux.alibaba.com>
In-Reply-To: <20251107035632.115950-1-alibuda@linux.alibaba.com>
To: D. Wythe <alibuda@linux.alibaba.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, pabeni@redhat.com, song@kernel.org, sdf@google.com,
 haoluo@google.com, yhs@fb.com, edumazet@google.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, jolsa@kernel.org, mjambigi@linux.ibm.com,
 wenjia@linux.ibm.com, wintera@linux.ibm.com, dust.li@linux.alibaba.com,
 tonylu@linux.alibaba.com, guwen@linux.alibaba.com, bpf@vger.kernel.org,
 davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 sidraya@linux.ibm.com, jaka@linux.ibm.com

Hello:

This series was applied to bpf/bpf-next.git (net)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Fri,  7 Nov 2025 11:56:29 +0800 you wrote:
> This patch aims to introduce BPF injection capabilities for SMC and
> includes a self-test to ensure code stability.
> 
> Since the SMC protocol isn't ideal for every situation, especially
> short-lived ones, most applications can't guarantee the absence of
> such scenarios. Consequently, applications may need specific strategies
> to decide whether to use SMC. For example, an application might limit SMC
> usage to certain IP addresses or ports.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,1/3] bpf: export necessary symbols for modules with struct_ops
    https://git.kernel.org/bpf/bpf-next/c/07c428ece322
  - [bpf-next,v5,2/3] net/smc: bpf: Introduce generic hook for handshake flow
    https://git.kernel.org/bpf/bpf-next/c/15f295f55656
  - [bpf-next,v5,3/3] bpf/selftests: add selftest for bpf_smc_hs_ctrl
    https://git.kernel.org/bpf/bpf-next/c/beb3c67297d9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



