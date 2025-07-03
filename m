Return-Path: <bpf+bounces-62245-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 613B5AF6E37
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 11:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA0951C27126
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 09:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D78B2D4B79;
	Thu,  3 Jul 2025 09:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bSweQX75"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DBA2D4B57;
	Thu,  3 Jul 2025 09:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751533786; cv=none; b=dkD/svZFEOXkD3YWsgowr3bE/v+Fjg95D54zXBvMrezIGpIWXVZGfA+zUK3uc6lY6u3RMmyPvnm8G5C0lbODgPHEI3IbqfQ9pZvsIR12b9b08zrtg+p+Doy30MlhE6W4tudsS0iaEi1r3zcaqIoUliaUkFmP2uPwlglRRzcbzAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751533786; c=relaxed/simple;
	bh=Pg/UwjFOcZzuqyjOTqG0yIOy7JK3IesDORgQKCAf2ZQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AN3yaDeJyoygRLRg4pw2V8jBiLPLP5skpEmn7DfT3GKeXdDc3K/t3KyZFUBiqKDVShtbGTKU5VXeW3At4E5lnAAu6skQha5I04UN8EBpT0V21b56BSunstF4PiWcXc5MI71C9IgpdkuPqJeGeBRKPdb9zF7e8s7GxpVFHROg0Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bSweQX75; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245BBC4CEE3;
	Thu,  3 Jul 2025 09:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751533786;
	bh=Pg/UwjFOcZzuqyjOTqG0yIOy7JK3IesDORgQKCAf2ZQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bSweQX75kAK9tCjdGOTMlv6rGVagwP2XSnsw0lGHOoPFAjo3pcmuA1hgooocTHAt5
	 6LVqV9vCdR5yJ52Wy4wLk3EjralBAFl1Dmy0OviFMrqMehIGa91ND41yThVJsgUzZW
	 DdoZUzq+iE9y6QmlUqyeRvw1VbDF2tx7nqaBuXidJ5/o9eY4/s81GkhOlVbdaNYIb7
	 CG1SNAirLUSKNRHbHCMOSSHNguiEWwtel5eBlVpLB5K8N21JhcdzWOhD9VaxRYnLsJ
	 Qc+rpzC50AWonr9gmsdRqZnKZPNie6VhMpXVLUg+EXrWntP22NLhXOjlziA66eAzlM
	 qjS+NCAGgDTdQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE269383B273;
	Thu,  3 Jul 2025 09:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/3] virtio-net: fixes for mergeable XDP receive
 path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175153381052.1020232.17030043875291925197.git-patchwork-notify@kernel.org>
Date: Thu, 03 Jul 2025 09:10:10 +0000
References: <20250630144212.48471-1-minhquangbui99@gmail.com>
In-Reply-To: <20250630144212.48471-1-minhquangbui99@gmail.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, eperezma@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 30 Jun 2025 21:42:09 +0700 you wrote:
> Hi everyone,
> 
> This series contains fixes for XDP receive path in virtio-net
> - Patch 1: add a missing check for the received data length with our
> allocated buffer size in mergeable mode.
> - Patch 2: remove a redundant truesize check with PAGE_SIZE in mergeable
> mode
> - Patch 3: make the current repeated code use the check_mergeable_len to
> check for received data length in mergeable mode
> 
> [...]

Here is the summary with links:
  - [net,v2,1/3] virtio-net: ensure the received length does not exceed allocated size
    https://git.kernel.org/netdev/net/c/315dbdd7cdf6
  - [net,v2,2/3] virtio-net: remove redundant truesize check with PAGE_SIZE
    https://git.kernel.org/netdev/net/c/4be2193b3393
  - [net,v2,3/3] virtio-net: use the check_mergeable_len helper
    https://git.kernel.org/netdev/net/c/7d4a119e4582

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



