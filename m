Return-Path: <bpf+bounces-13919-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 681F37DECC9
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 07:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08FAEB20AEC
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 06:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB80525D;
	Thu,  2 Nov 2023 06:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RRV9YgO2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD0F187A
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 06:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC99AC433CC;
	Thu,  2 Nov 2023 06:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698905424;
	bh=sDWEmiYMvqJqDHhLRCxFeAkCaG2bsjycMQsFcwDeffY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RRV9YgO2DJBIr774lPv34QGxO7njYDqd8Lv65/ZKsOAgLxUPAaGkvmnwUZSq3sZfD
	 1dwlNQ3U+oMCPOVNR4lXE3pz/Pb5z0ixVIvD7t683tZ5Iy9oLzO95KRl2nOXU+UMDU
	 KDHDXsD1i7DqJkZ/SxYh20HlL4G6ziwdVkr2ZV9yw7N3DmK9rKxiflaXwupY0/7vbc
	 vqapNR59OuUNwLOq+fDZ+3ck8JzPamMMyRmQt+TJbXPeNLPH66RpBNe07u1n1VnnNc
	 jOBJO8Qg9isUZon5Oiy6wnK2n95Hdwk5TwyCI+diOtgTwmfy18q1lgIm1dnwErPhHw
	 AOg3gEEDB8wKg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 94FCBC43168;
	Thu,  2 Nov 2023 06:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v1 0/2] bpf: Fix precision tracking for BPF_ALU |
 BPF_TO_BE | BPF_END
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169890542460.15699.16584110684180733586.git-patchwork-notify@kernel.org>
Date: Thu, 02 Nov 2023 06:10:24 +0000
References: <20231102053913.12004-1-shung-hsi.yu@suse.com>
In-Reply-To: <20231102053913.12004-1-shung-hsi.yu@suse.com>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, ast@kernel.org,
 toke@redhat.com, john.fastabend@gmail.com, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 eddyz87@gmail.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu,  2 Nov 2023 13:39:02 +0800 you wrote:
> Changes since v1:
> - add test for negation and bswap (Alexei, Eduard)
> - add test for BPF_TO_LE as well to cover all types of BPF_END opcode
> - remove vals map and trigger backtracking with jump instead, based of
>   Eduard's code
> - v1 at https://lore.kernel.org/bpf/20231030132145.20867-1-shung-hsi.yu@suse.com
> 
> [...]

Here is the summary with links:
  - [bpf,v1,1/2] bpf: Fix precision tracking for BPF_ALU | BPF_TO_BE | BPF_END
    https://git.kernel.org/bpf/bpf/c/291d044fd51f
  - [bpf,v1,2/2] selftests/bpf: precision tracking test for BPF_NEG and BPF_END
    https://git.kernel.org/bpf/bpf/c/3c41971550f5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



