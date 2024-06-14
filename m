Return-Path: <bpf+bounces-32204-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 344E090931F
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 22:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C91BB23B5E
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 20:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED72B16D339;
	Fri, 14 Jun 2024 20:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XyPRxwp0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8BD1487C1
	for <bpf@vger.kernel.org>; Fri, 14 Jun 2024 20:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718395232; cv=none; b=boYy05NaJj+06nDeZfXKKrz58gnJpjwRdUDdG23Z0LI58l1djPtjeJK0oholWVfSrGQMKntnjxcX3PfRzjsVh8GO+hGqOi/F+/ZbNTzak5mA5eagjFkxTvFCc4vRA1lupUEuwqyEZ/t6D2Wo4zmjx/0cAwqbsrYddMLf5JDK7CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718395232; c=relaxed/simple;
	bh=dPNWDAu4iEle51dQR96YxGkjVSzHXB72w2eJQbDOrZo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EpVvXsbF/h3GaEBsBJeuJ9iTRu8UqSqVuE/UMmy0WiR0SIOJEWXijjFKiS+ZMBKKZ80rM4sKJTZjKoZJ1gvK7qX0fyM8dQzKdJh8/TfEIJhmcisE55NO+5vUgPXIVoSx6nCITK0Z0Qv1xJt2ayidJmHR6rKH8EncsjBZhbDeICc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XyPRxwp0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 05453C4AF1C;
	Fri, 14 Jun 2024 20:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718395232;
	bh=dPNWDAu4iEle51dQR96YxGkjVSzHXB72w2eJQbDOrZo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XyPRxwp0W7awtnCZaEPkBr9uiSngUBFgrfdxj0qrd9PzbAflubPNG7YrN3Pfcesbi
	 52mapKuojSlp4ukbEsduWNRWtl2YvDk75BJe2EzPdGs8GPrBqpQR+5nCk8m8VKVLmv
	 kSBkawWUrhBmTnIAtZgqKabntzgdso1LHtoulQV2Pv98F/G2+9u4XI2CHoMPa2XTYa
	 PlyNQNpa1qwDsAGuPJ2OjQlHItsG3iiGfFFmzMYh5/u8kcpHTbTPS0YPT+qdAuiPqP
	 mo1H6Qv21FLkbNJZn9bfhvXOnu6tNKI3ZbRyGRTOMPegBRq5qNB8Ky6qWirVlUI31b
	 vj2k0qW7vMkAw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E6A71C43616;
	Fri, 14 Jun 2024 20:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 bpf-next 0/4] bpf: Track delta between "linked" registers.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171839523194.31909.17904163898198363320.git-patchwork-notify@kernel.org>
Date: Fri, 14 Jun 2024 20:00:31 +0000
References: <20240613013815.953-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20240613013815.953-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org, memxor@gmail.com, eddyz87@gmail.com,
 kernel-team@fb.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 12 Jun 2024 18:38:11 -0700 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> v2->v3:
> - Fixed test_verifier due to output change
> - Fixed regsafe()
> - Add another test
> 
> [...]

Here is the summary with links:
  - [v3,bpf-next,1/4] bpf: Relax tuple len requirement for sk helpers.
    https://git.kernel.org/bpf/bpf-next/c/124e8c2b1b5d
  - [v3,bpf-next,2/4] bpf: Track delta between "linked" registers.
    https://git.kernel.org/bpf/bpf-next/c/98d7ca374ba4
  - [v3,bpf-next,3/4] bpf: Support can_loop/cond_break on big endian
    https://git.kernel.org/bpf/bpf-next/c/6870bdb3f4f2
  - [v3,bpf-next,4/4] selftests/bpf: Add tests for add_const
    https://git.kernel.org/bpf/bpf-next/c/dedf56d775c0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



