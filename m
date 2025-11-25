Return-Path: <bpf+bounces-75501-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A52C875D8
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 23:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E1F23A62B7
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 22:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6944A32D7F1;
	Tue, 25 Nov 2025 22:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QN+05lDs"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA552ED872;
	Tue, 25 Nov 2025 22:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764110456; cv=none; b=A3LHfyUmEfgOU9crjm0hTip20ygh7LwUaltQSJwLyyYtFp6agYrhrl73TcCrp5oB44giWK385Gi0HvuoDGJcAnxhkajcM0ks8TiLVvU3Glout5lIbMa50uS/Hywj1/BufV9MxWzL+lq/t+nJagl+0HwQEZd3i22og5xVOu9KIuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764110456; c=relaxed/simple;
	bh=aBQmqjf4vzy3CbK+tTgPfQVNXcB4/qiNFn0OcJkyJhQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mykIxypBxaMlKn75pIUU4WKjz107vzj+576MPhF3ur0pHl32bwqhOqX1ROMRkkbprqqeGeBclEPtAI8MKARecyNvgqSz1IZYd9yk9XJUmTOP5KI+k75Lk8mf9Au6EevlNXbPazsV7Zo3YsR3NAgyOQMxr+C5uACIGvL4CiIT5gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QN+05lDs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70EB4C4CEF1;
	Tue, 25 Nov 2025 22:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764110456;
	bh=aBQmqjf4vzy3CbK+tTgPfQVNXcB4/qiNFn0OcJkyJhQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QN+05lDshhjgMUNUp5n3/lOTJCgS43FwsVRcN7o419hSZo/6UGu3Y7tLvFT/pVM5m
	 u3wv+2rRmYK2uik+7yIVVccLHYi2aDHkKTDNG+acthlAxTLyXV1v1GHZ995EJgu5hb
	 7o8o1tFFgSXq8iECEXMMXxV5Ps70pkpKp401BCCoKb01ee1m/AO+QhkP4wGT99ZSnn
	 emaYumXex6TZEpVxoEJdpNKIEW0gLiuCUcRNy+i1kQz3Awfns/a3Hhk3fw3N19VBU1
	 /2XeCBzhzZN6712Ss6GRMYjP13z9Wis2fNmuMHu45zV9ye1Qe5BI/kZI4p8Bw/IWsv
	 4ktqF3c8mdG/A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB16B380AADF;
	Tue, 25 Nov 2025 22:40:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1] docs: bpf: map_array: specify
 BPF_MAP_TYPE_PERCPU_ARRAY value size limit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176411041852.938389.7598956472785504768.git-patchwork-notify@kernel.org>
Date: Tue, 25 Nov 2025 22:40:18 +0000
References: <20251115063531.2302903-1-alex.t.tran@gmail.com>
In-Reply-To: <20251115063531.2302903-1-alex.t.tran@gmail.com>
To: Alex Tran <alex.t.tran@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, corbet@lwn.net,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 14 Nov 2025 22:35:31 -0800 you wrote:
> Specify value size limit for BPF_MAP_TYPE_PERCPU_ARRAY which
> is PCPU_MIN_UNIT_SIZE (32 kb). In percpu allocator (mm: percpu),
> any request with a size greater than PCPU_MIN_UNIT_SIZE is rejected.
> 
> Signed-off-by: Alex Tran <alex.t.tran@gmail.com>
> ---
>  Documentation/bpf/map_array.rst | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [bpf-next,v1] docs: bpf: map_array: specify BPF_MAP_TYPE_PERCPU_ARRAY value size limit
    https://git.kernel.org/bpf/bpf-next/c/44bf4611827b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



