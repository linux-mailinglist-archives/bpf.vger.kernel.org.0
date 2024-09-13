Return-Path: <bpf+bounces-39863-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD55D9789ED
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 22:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 650D81F26F8D
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 20:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249AF84A27;
	Fri, 13 Sep 2024 20:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iyJtLQQM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26B12BAE3
	for <bpf@vger.kernel.org>; Fri, 13 Sep 2024 20:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726259484; cv=none; b=sbQB7W/nQCVEM8mikfutDiGaOKKRZCvXHNtIc9c5zOs2WmcewjQ7Q6op3enXYyGrCVVWe/u6sVm+GplAGEA8oIfAp3c6lJnqMLAUWKGA9pkU7JTDSHF9yM5RFKbQvb+YvglkuMTxtse/IMOcpnQhouhzG2g2STRO7P15c3UQYtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726259484; c=relaxed/simple;
	bh=EZpThYOqXehcFex6SypdfxukQjQ3ITmpEPD+rR7YP0k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=r4BPxIF+YIco/McIBqWtq4tLKOPP/MTCZFnE6c+OhYLXZ3WSGzDPTodIaP2GmZTpDmg8sDmyw4ierLaY4gyZaGbHCaRNdmdSS0eyMrq4fC56smVBZr7t7gXugJ3rhvutGfJf6msGj0x2c5C6uyXvzUhEKym13nWGBIbMKGBb6rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iyJtLQQM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32AA1C4CEC0;
	Fri, 13 Sep 2024 20:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726259484;
	bh=EZpThYOqXehcFex6SypdfxukQjQ3ITmpEPD+rR7YP0k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iyJtLQQMPtRWb/cn8KzUmKrZ+GU643Jjg8gCBTqBRTB2ZkVkclvKUT8Cf7aDTZVPu
	 yEU4yrJuVkgQYFityt4VgZaIA43mJIPxZ4eFDBnzp9oT2ZRXOPU6qVviY6In+S7EhI
	 sEMyY/uyI1/XztRNLC2sT0RUvaeDFclcC4HTA3skk82x0pJRKx/T/87VJH5bdXhQ9h
	 zRfkuwNUfYxfyR6YqdliYoo23f33ofpR6LszMKWGzQ+9XeIuJZcO4Jako2DOi2FOTl
	 vFswcz2CNENdPFFk1QsQAIRvAoO289L+T+aQy6L06LqKYQB7mXCZ8aIe4nKjHza+QR
	 qVyNVUpRwiJrw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE67A3806655;
	Fri, 13 Sep 2024 20:31:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 1/9] bpf: Fix bpf_strtol and bpf_strtoul helpers
 for 32bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172625948552.2358571.7329976357946121826.git-patchwork-notify@kernel.org>
Date: Fri, 13 Sep 2024 20:31:25 +0000
References: <20240913191754.13290-1-daniel@iogearbox.net>
In-Reply-To: <20240913191754.13290-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, shung-hsi.yu@suse.com, andrii@kernel.org,
 ast@kernel.org, kongln9170@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 13 Sep 2024 21:17:46 +0200 you wrote:
> The bpf_strtol() and bpf_strtoul() helpers are currently broken on 32bit:
> 
> The argument type ARG_PTR_TO_LONG is BPF-side "long", not kernel-side "long"
> and therefore always considered fixed 64bit no matter if 64 or 32bit underlying
> architecture.
> 
> This contract breaks in case of the two mentioned helpers since their BPF_CALL
> definition for the helpers was added with {unsigned,}long *res. Meaning, the
> transition from BPF-side "long" (BPF program) to kernel-side "long" (BPF helper)
> breaks here.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,1/9] bpf: Fix bpf_strtol and bpf_strtoul helpers for 32bit
    https://git.kernel.org/bpf/bpf-next/c/cfe69c50b055
  - [bpf-next,v5,2/9] bpf: Remove truncation test in bpf_strtol and bpf_strtoul helpers
    https://git.kernel.org/bpf/bpf-next/c/7d71f59e0280
  - [bpf-next,v5,3/9] bpf: Fix helper writes to read-only maps
    https://git.kernel.org/bpf/bpf-next/c/32556ce93bc4
  - [bpf-next,v5,4/9] bpf: Improve check_raw_mode_ok test for MEM_UNINIT-tagged types
    https://git.kernel.org/bpf/bpf-next/c/18752d73c189
  - [bpf-next,v5,5/9] bpf: Zero former ARG_PTR_TO_{LONG,INT} args in case of error
    https://git.kernel.org/bpf/bpf-next/c/4b3786a6c539
  - [bpf-next,v5,6/9] selftests/bpf: Fix ARG_PTR_TO_LONG {half-,}uninitialized test
    https://git.kernel.org/bpf/bpf-next/c/b8e188f023e0
  - [bpf-next,v5,7/9] selftests/bpf: Rename ARG_PTR_TO_LONG test description
    https://git.kernel.org/bpf/bpf-next/c/b073b82d4d3c
  - [bpf-next,v5,8/9] selftests/bpf: Add a test case to write strtol result into .rodata
    https://git.kernel.org/bpf/bpf-next/c/2e3f06602047
  - [bpf-next,v5,9/9] selftests/bpf: Add a test case to write mtu result into .rodata
    https://git.kernel.org/bpf/bpf-next/c/211bf9cf178a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



