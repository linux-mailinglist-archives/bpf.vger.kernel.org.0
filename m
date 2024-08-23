Return-Path: <bpf+bounces-37997-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5552F95D94A
	for <lists+bpf@lfdr.de>; Sat, 24 Aug 2024 00:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10E0A28696C
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 22:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E6B17C9FC;
	Fri, 23 Aug 2024 22:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCg5Tu36"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDDA195
	for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 22:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724452230; cv=none; b=fh1tIgLBHAYQ/EdGR4hKynbQjn5CJDEMbEmieeT2yn6tQuepj9lXnPIoYwM0Cpmq+YtFat9M3mg0yVKbUXvUm/vn9fBWlj/e+qXESXnn7X7+kV3zsApOY4O1W4dvboKV6vZFWATbYfh/OLEXX7dqp1Ce7BGtGpxA6krOpNagMjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724452230; c=relaxed/simple;
	bh=OpWLxCIOZidLnkDPMBJuwRnWti+Yu7WEtk+i+H7F3TU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YfKpJMlflGLCLnSY5wA+/2FqvmgKFbTupCZNDUjab0id7VRUdmEHi3B0NCQVHEwF2TRbZ2FHSbTmjFMw55tW7+ldS/LbhdhJ4sa0VjRbSn9T6Rr7yvBIl+qrBHraa+Pkhes8wgRbBrw3yupRoThsoNdDP7YFLpFFDGfKowLj4Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCg5Tu36; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B534CC32786;
	Fri, 23 Aug 2024 22:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724452229;
	bh=OpWLxCIOZidLnkDPMBJuwRnWti+Yu7WEtk+i+H7F3TU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kCg5Tu36Tc2HWrSvXTeb8OmmDeebnB0Sv1oo46cdV/qJYh5RO1oY9usCUcKUTbWI9
	 ESKKgY2CJne9saG186DfLPH1m0bZflYXxgFzSCq+QsORIZW1iP/cW6pu7fFK3mbD0F
	 wome6Chk0aUmWRrosp2fltfHU42cpBSJ8q6xQkWT51yCnra9h1XhauRmdzoR7i0Upf
	 iRVpEz5Ztgcim6O5Y8dsWFsoWuCKuR9TTmMbTC8hZ49usmj09XslhRpA9y9qlL+21i
	 ThTOawyWsticEtDMMTqwTtohNNslvdUjdnYxt2h0IoBYFlucgsKXDOsPPbySyUS+8N
	 dW5abTfdv+TfA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCA63804C87;
	Fri, 23 Aug 2024 22:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: use simply-expanded variables for
 libpcap flags
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172445222952.3101306.18132185601555679046.git-patchwork-notify@kernel.org>
Date: Fri, 23 Aug 2024 22:30:29 +0000
References: <20240823194409.774815-1-eddyz87@gmail.com>
In-Reply-To: <20240823194409.774815-1-eddyz87@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Fri, 23 Aug 2024 12:44:09 -0700 you wrote:
> Save pkg-config output for libpcap as simply-expanded variables.
> For an obscure reason 'shell' call in LDLIBS/CFLAGS recursively
> expanded variables makes *.test.o files compilation non-parallel
> when make is executed with -j option.
> 
> While at it, reuse 'pkg-config --cflags' call to define
> -DTRAFFIC_MONITOR=1 option, it's exit status is the same as for
> 'pkg-config --exists'.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: use simply-expanded variables for libpcap flags
    https://git.kernel.org/bpf/bpf-next/c/5772c3458bb8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



