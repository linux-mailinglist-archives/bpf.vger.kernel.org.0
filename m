Return-Path: <bpf+bounces-56531-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A75D4A9978B
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 20:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80A781B827E9
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 18:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CEA28F930;
	Wed, 23 Apr 2025 18:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="daQVXA9p"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1036926982F;
	Wed, 23 Apr 2025 18:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745431790; cv=none; b=iySZk73tkD4+BwNiKtTlybT/3AONnR8Vld/m8NTuEPvocPvOduYQivoemrxCoMBd5TuC0W77We6pCIzGBtAVmL4GDJYImJqV96rTNkD3ZS4C8A2/TgLiCHC2hpBe40krjJbsMH8JhZ2dwAvdcsCI6tOmu28W4sKt9GK6ilDH/vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745431790; c=relaxed/simple;
	bh=U9F+PeVnBpGsSyekbAgYUh9ERhGGMV7iRfE7ZeUqWsQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=P2pr7QU7ipo0RJ1IABl5AOCCO36rWcJ7VHuB+QLL8Gmm6wnPSdFb6VxMpKLNi1OSLm3n5R7u6MYf7wbNP5ybm9FpTDTgGdvBdj/EEw5RYHXA9BTdycVus+5dTEwPpVoi8WCCngWnZpcg+MKpCPJkiGLvcX2DIFcTdTQsUwkuYdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=daQVXA9p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B918C4CEE2;
	Wed, 23 Apr 2025 18:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745431789;
	bh=U9F+PeVnBpGsSyekbAgYUh9ERhGGMV7iRfE7ZeUqWsQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=daQVXA9p8n9Fh2VwDQ/9hhp9N7zLF5WAXuy+o4TGyaNSTUAKR4JdlQxjNI2kMvlth
	 +nPyQbvIv28S+WxkfBWMy7pXNx1fhL8oMMrqH4ViMR17+TUoXRIg04YCI+eFGIl0T4
	 VCPfg/a59P0rPYZhSWsHSf7CwGiuJD4dUoNarCP8vWyMZsOyG+JRaZI62aGdA9NCHB
	 Zq0CNSI9/v2AGSIoPUpBHgMDlIzTFhrHZPNkNJAP6ttE1fCi5vy3qJMHkw/cnvNAUU
	 zdC8fpVlp2EaNfpsHb75e8qju7W089Kci3//gIp30LVORZExRyod4j2xvAoxsdnrIl
	 kxORYu9o2e0rQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33EF6380CED9;
	Wed, 23 Apr 2025 18:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4] bpf: streamline allowed helpers between tracing
 and base sets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174543182801.2725891.7635648941344459709.git-patchwork-notify@kernel.org>
Date: Wed, 23 Apr 2025 18:10:28 +0000
References: <20250423073151.297103-1-yangfeng59949@163.com>
In-Reply-To: <20250423073151.297103-1-yangfeng59949@163.com>
To: Feng Yang <yangfeng59949@163.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 mattbobrowski@google.com, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 23 Apr 2025 15:31:51 +0800 you wrote:
> From: Feng Yang <yangfeng@kylinos.cn>
> 
> Many conditional checks in switch-case are redundant
> with bpf_base_func_proto and should be removed.
> 
> Regarding the permission checks bpf_base_func_proto:
> The permission checks in bpf_prog_load (as outlined below)
> ensure that the trace has both CAP_BPF and CAP_PERFMON capabilities,
> thus enabling the use of corresponding prototypes
> in bpf_base_func_proto without adverse effects.
> bpf_prog_load
> 	......
> 	bpf_cap = bpf_token_capable(token, CAP_BPF);
> 	......
> 	if (type != BPF_PROG_TYPE_SOCKET_FILTER &&
> 	    type != BPF_PROG_TYPE_CGROUP_SKB &&
> 	    !bpf_cap)
> 		goto put_token;
> 	......
> 	if (is_perfmon_prog_type(type) && !bpf_token_capable(token, CAP_PERFMON))
> 		goto put_token;
> 	......
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4] bpf: streamline allowed helpers between tracing and base sets
    https://git.kernel.org/bpf/bpf-next/c/6aca583f90b0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



