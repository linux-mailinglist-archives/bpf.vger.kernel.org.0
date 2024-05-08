Return-Path: <bpf+bounces-29000-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D64648BF3B0
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 02:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76BBA1F227AD
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 00:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0085E1C27;
	Wed,  8 May 2024 00:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GrkydclS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780B938B
	for <bpf@vger.kernel.org>; Wed,  8 May 2024 00:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715128232; cv=none; b=u9Nt0XijhCOy3a4swX9AfKCQ5HTzty2fgMiZ5Iq2FO5eS0i0Vw4n5FITbT2+xStw9nXk5FBSYB5pUfsa+ToXXuEk3pMjkg6Df5mXV4rMvipB9hPcdcAyXXi/LqylI/IE2QNFNspcv56WUOZ4aPF3o/eCsrgClL+cTLKY/qq7cB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715128232; c=relaxed/simple;
	bh=FPgZ36rboE4gpRvFY/XMf6wHtvReseULSt3ZnhKkjlM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e79pX9IpI8eL+4nnEDsOq1gWMsSCvkgFbX0qpPvHYHRsnhWaXBxV88IkFJcemiLbaXFzSIC6oS1ncSdXjvcjIektSZMCVnU5opNsdmDyR4SyLMXdwAoHeFxVyDSBxw+kq6BZ8+V8xwet0z0p5zO4UBXEwHqyoq1CPWO2eVA0aj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GrkydclS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E8D51C4AF17;
	Wed,  8 May 2024 00:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715128232;
	bh=FPgZ36rboE4gpRvFY/XMf6wHtvReseULSt3ZnhKkjlM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GrkydclSJN7b1H1/KZ6UjdDvAFWZ0dyagECTbADYs/mcsNGeS9qpyWp5sFnDAkMpK
	 EmGjkqS1WQJd+tVW3EmbvTzX6eD3jtsFx1cWG1FIHBNLf7bsTRMr6o+jB859iLI15w
	 1lWSvOUVxW0xTY0l2qdiVo5ct2vUX4V7RKtBh8AzCp26mjV8eu5fJuylcDKXmImUzA
	 XB/YziqbrmXRemXP6ECKRdmo2E7o1M1ENiWcckayaoYvYvQ6YpCsEAAh344Mi3pwXf
	 hzjyQjabTVt7+RKBEIFCCFfHdZl0K5gs0+KbjznAoQXI37ProV0xiu45+oO3XnPEwf
	 drOt9abZaFh/g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D554EC43617;
	Wed,  8 May 2024 00:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/7] libbpf: further struct_ops fixes and
 improvements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171512823186.17947.11978986618832814926.git-patchwork-notify@kernel.org>
Date: Wed, 08 May 2024 00:30:31 +0000
References: <20240507001335.1445325-1-andrii@kernel.org>
In-Reply-To: <20240507001335.1445325-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Mon,  6 May 2024 17:13:28 -0700 you wrote:
> Fix yet another case of mishandling SEC("struct_ops") programs that were
> nulled out programmatically through BPF skeleton by the user.
> 
> While at it, add some improvements around detecting and reporting errors,
> specifically a common case of declaring SEC("struct_ops") program, but
> forgetting to actually make use of it by setting it as a callback
> implementation in SEC(".struct_ops") variable (i.e., map) declaration.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/7] libbpf: remove unnecessary struct_ops prog validity check
    https://git.kernel.org/bpf/bpf-next/c/8374b56b1df5
  - [bpf-next,2/7] libbpf: handle yet another corner case of nulling out struct_ops program
    https://git.kernel.org/bpf/bpf-next/c/e18e2e70dbd1
  - [bpf-next,3/7] selftests/bpf: add another struct_ops callback use case test
    https://git.kernel.org/bpf/bpf-next/c/9d66d60e968d
  - [bpf-next,4/7] libbpf: fix libbpf_strerror_r() handling unknown errors
    https://git.kernel.org/bpf/bpf-next/c/548c2ede0dc8
  - [bpf-next,5/7] libbpf: improve early detection of doomed-to-fail BPF program loading
    https://git.kernel.org/bpf/bpf-next/c/c78420bafe7c
  - [bpf-next,6/7] selftests/bpf: validate struct_ops early failure detection logic
    https://git.kernel.org/bpf/bpf-next/c/41df0733ea41
  - [bpf-next,7/7] selftests/bpf: shorten subtest names for struct_ops_module test
    https://git.kernel.org/bpf/bpf-next/c/7b9959b8cdbc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



