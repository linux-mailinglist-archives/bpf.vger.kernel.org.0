Return-Path: <bpf+bounces-41588-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F339998DCE
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 18:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55658B39C6C
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 16:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED601CCECA;
	Thu, 10 Oct 2024 16:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I26nUxRX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D36B13C682;
	Thu, 10 Oct 2024 16:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728576029; cv=none; b=is0GBLZKsLYgWW+cUurZLox7u0s5ItFe7LIWtQjh5zECW1CXIOQ4MFep9ATi2u+d38xVniAS8hhzt3pXsIllAd413WJ8XyD+obq0z8ojAIlRsEjGfeJERuk52/HLapZZ/uHdbfBbQI+18fEJY98RY4reFEaXsyLD4qpqw1wRrWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728576029; c=relaxed/simple;
	bh=bOXfCK9aa6Z+FHkqe8BT3+D5wySGG8XgdIRoiD27rJg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hjLZKXBTe//WyQ0+/pcC2q4g/gguS1khiWJ+kgFYPDk8YV1xr4Xt1XDN6dVt+ZNjQEUtfAakaqO/kzIdhwHQlq/WREMurpHTkEosT2tvycPMZKN1+clof+Ae69PyAbl2mgInhlkTbz7OQNvJHlens1h4budlcASQFmfPSxNgAkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I26nUxRX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A12C4CEC5;
	Thu, 10 Oct 2024 16:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728576027;
	bh=bOXfCK9aa6Z+FHkqe8BT3+D5wySGG8XgdIRoiD27rJg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=I26nUxRX1Oc5WtUzgH72oKUI/ZZmIJFQr8dyEUDXjHSGWjmvabhmt8WnVSZaKZ9xQ
	 67kSmvTRiSl+uzCesXEVBnHIsRwGJQhu20Zo1WAhosOLcE/JdpovprHeh2v+3Ab21j
	 I07/bB/7U8UJeIFWT/jdj4389UixdfOdDGw6MmMsW3eQq/iab8FmQ3klKOAd29xIb7
	 C+4thJKKDZpi4t6tU/mVRZZ6J5duEhE9zodA5Unfej9sWJkwS4ORHwxYS9u+hQ5F5r
	 O5j93L3EOmcKtcV9Hd5rHBEblpl+QHEtBx636/0tBkCYexF5QHcwTC2Hyr6AJa1biy
	 FsVSUCNDNDndg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 348573803263;
	Thu, 10 Oct 2024 16:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2] bpf: fix argument type in bpf_loop documentation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172857603201.2077656.16946456539767560762.git-patchwork-notify@kernel.org>
Date: Thu, 10 Oct 2024 16:00:32 +0000
References: <20241010035652.17830-1-technoboy85@gmail.com>
In-Reply-To: <20241010035652.17830-1-technoboy85@gmail.com>
To: Matteo Croce <technoboy85@gmail.com>
Cc: andrii@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 teknoraver@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 10 Oct 2024 04:56:52 +0100 you wrote:
> From: Matteo Croce <teknoraver@meta.com>
> 
> The `index` argument to bpf_loop() is threaded as an u64.
> This lead in a subtle verifier denial where clang cloned the argument
> in another register[1].
> 
> [1] https://github.com/systemd/systemd/pull/34650#issuecomment-2401092895
> 
> [...]

Here is the summary with links:
  - [bpf,v2] bpf: fix argument type in bpf_loop documentation
    https://git.kernel.org/bpf/bpf-next/c/5bd48a3a14df

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



