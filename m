Return-Path: <bpf+bounces-20146-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4687B839D4F
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 00:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07296289AEB
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 23:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DCE55771;
	Tue, 23 Jan 2024 23:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJzChJs3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957A94F5F3;
	Tue, 23 Jan 2024 23:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706053250; cv=none; b=k8tc1ERw55CmLFEwiM3bKV64jD5wDcR2l4u7YRRdDn6SwTyUdFD9/nwwpXRGEogQZdhM/ofQzGHNfuVEcwft9B3u5qIYy1TxNLSinNiiotSxz2BrtViGVXcKZWKbDC8RU5HiXvUt4Ko/ApWSvr88qcnNNCADMXX2XLTf6kSNhc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706053250; c=relaxed/simple;
	bh=J6rnNUzVj1P2Qg/1GF111rxMutxfmlksq0mYZS2yDjE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OEUsc8paSxPnZS45ZmjyqngKoB9XE4vzuPMd/GwnUanSWG8tsAi9+K1+BGDTcl9SmAVLVwORTEiZk/D+GjRsGoI0XeuR+FUt6s1Luir16iwuMccB3ddcznUuoxhwCUpF6MGkH1k0vCCqAyDDn5NkBfY5688ow4b1G9dmqsIkhpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJzChJs3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2FFE0C433A6;
	Tue, 23 Jan 2024 23:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706053250;
	bh=J6rnNUzVj1P2Qg/1GF111rxMutxfmlksq0mYZS2yDjE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EJzChJs3r2a0rWoG85Zs3Vj8Mh3yBc+jcmhfD9iXGVYSCT9GsOuizEx9emv6+UrOq
	 h2wzJ5mZGQGHBhg5mXKkoAM08RBzRM2WeXA6COZ0+JmIZXJhqZ9U8AVvQFMNb/g8d0
	 HJf177y+JHmllKMXUQX2SuCb48pHDLKdUFFGl3GwieQc3LBU0/VtJYLE8fErOyDZXR
	 4j8/3q5/0Y5kvRY73BQhQGOSQH5pVl0ROEP3SmoJ+klAzIX1UCL99oy15sL0bQ2BLT
	 F8Wgx71uYSIC88l1M0RRCvzFFUh27FpkUGKhjsKPzg2xFWrJ+veIMVGx9S1CXbqZRO
	 nn0LbYJkemJrw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1894DDFF767;
	Tue, 23 Jan 2024 23:40:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: Refactor ptr alu checking rules to allow alu explicitly
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170605325009.25186.130330660193751446.git-patchwork-notify@kernel.org>
Date: Tue, 23 Jan 2024 23:40:50 +0000
References: <20240117094012.36798-1-sunhao.th@gmail.com>
In-Reply-To: <20240117094012.36798-1-sunhao.th@gmail.com>
To: Hao Sun <sunhao.th@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 17 Jan 2024 10:40:12 +0100 you wrote:
> Current checking rules are structured to disallow alu on particular ptr
> types explicitly, so default cases are allowed implicitly. This may lead
> to newly added ptr types being allowed unexpectedly. So restruture it to
> allow alu explicitly. The tradeoff is mainly a bit more cases added in
> the switch. The following table from Eduard summarizes the rules:
> 
>         | Pointer type        | Arithmetics allowed |
>         |---------------------+---------------------|
>         | PTR_TO_CTX          | yes                 |
>         | CONST_PTR_TO_MAP    | conditionally       |
>         | PTR_TO_MAP_VALUE    | yes                 |
>         | PTR_TO_MAP_KEY      | yes                 |
>         | PTR_TO_STACK        | yes                 |
>         | PTR_TO_PACKET_META  | yes                 |
>         | PTR_TO_PACKET       | yes                 |
>         | PTR_TO_PACKET_END   | no                  |
>         | PTR_TO_FLOW_KEYS    | conditionally       |
>         | PTR_TO_SOCKET       | no                  |
>         | PTR_TO_SOCK_COMMON  | no                  |
>         | PTR_TO_TCP_SOCK     | no                  |
>         | PTR_TO_TP_BUFFER    | yes                 |
>         | PTR_TO_XDP_SOCK     | no                  |
>         | PTR_TO_BTF_ID       | yes                 |
>         | PTR_TO_MEM          | yes                 |
>         | PTR_TO_BUF          | yes                 |
>         | PTR_TO_FUNC         | yes                 |
>         | CONST_PTR_TO_DYNPTR | yes                 |
> 
> [...]

Here is the summary with links:
  - bpf: Refactor ptr alu checking rules to allow alu explicitly
    https://git.kernel.org/bpf/bpf-next/c/2ce793ebe207

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



