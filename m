Return-Path: <bpf+bounces-29223-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C388C14C5
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 20:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99DD3B20A5F
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 18:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E4A3201;
	Thu,  9 May 2024 18:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QiyBFuD0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679C77D41F
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 18:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715279429; cv=none; b=r8KyiWJtkhN2ID1WtyOBeNceHeUu0+krSyqjBWJdT+xkOgycEbqSNwEVIZ0f9/wGLnJMZS+40BTQfTmuTqL6hTVrVPLm+mtNddZgb8dyK5ocUjqGqPDAL+nVAsx+o0BYvd9F31IqqPCknAUc0EIynI4bTaDEgXO4VO+fk5W4EVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715279429; c=relaxed/simple;
	bh=nOck5Cmoop90qbd3mGHU/FokI7vM3nn/AvAYqJra/fQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OE4KNGiYZM3PMFzBAxFBPFFMSOm0K8Ehs2a3N3OvqCQwxvQEEZBEvm9quKKZUleMYSfAo7jeKGygmV71Ayq5ruPe021w8h7m5URjnThqr8iPVTt0JyJ3HZ1+lPdJV1UnT48rvkD+3xP1H7HGvnDtLJIOdIkLqstioa30HSNMCiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QiyBFuD0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 38AEDC2BD11;
	Thu,  9 May 2024 18:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715279429;
	bh=nOck5Cmoop90qbd3mGHU/FokI7vM3nn/AvAYqJra/fQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QiyBFuD0He+uNTy+8oCeZqGHEjwTvkT9KVS7QRZri1tbn48sKHhQxa3mq7b2XemMg
	 EBOPHdtFgZm8WpIFKtXpa09m0SYhkcljfGnCV1uQ/In/Sd3OdKSkT/YOGq71BtCfov
	 CYGd3OfOpQaODdz7SIOfpEdVhkIxLGoEET0lQAYa9J/mATlBfaK3R6wYX9sfUNmYDB
	 MhRI5fVBHWjbpOS4cz8qImCF7PhXoyzvZh8e+gVtqp5MT/DULVJfdazj0jK7F0ycxW
	 dKhfheXivMfPgFs5xsTA99OuY6a26TXZM4ke4vHMZ35C+Svpa3LS7Gm4psXI+SURbA
	 Ptt8esWWvjohg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 277DAE7C0E2;
	Thu,  9 May 2024 18:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 00/10] selftests/bpf: Retire bpf_tcp_helpers.h
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171527942915.14187.9244122060002143161.git-patchwork-notify@kernel.org>
Date: Thu, 09 May 2024 18:30:29 +0000
References: <20240509175026.3423614-1-martin.lau@linux.dev>
In-Reply-To: <20240509175026.3423614-1-martin.lau@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu,  9 May 2024 10:50:16 -0700 you wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
> 
> The earlier commit 8e6d9ae2e09f ("selftests/bpf: Use bpf_tracing.h instead of bpf_tcp_helpers.h")
> removed the bpf_tcp_helpers.h usages from the non networking tests.
> 
> This patch set is a continuation of this effort to retire
> the bpf_tcp_helpers.h from the networking tests (mostly tcp-cc related).
> 
> [...]

Here is the summary with links:
  - [bpf-next,01/10] selftests/bpf: Remove bpf_tracing_net.h usages from two networking tests
    https://git.kernel.org/bpf/bpf-next/c/c0338e609e6e
  - [bpf-next,02/10] selftests/bpf: Add a few tcp helper functions and macros to bpf_tracing_net.h
    https://git.kernel.org/bpf/bpf-next/c/cbaec46df6c0
  - [bpf-next,03/10] selftests/bpf: Reuse the tcp_sk() from the bpf_tracing_net.h
    https://git.kernel.org/bpf/bpf-next/c/cc5b18ce1714
  - [bpf-next,04/10] selftests/bpf: Sanitize the SEC and inline usages in the bpf-tcp-cc tests
    https://git.kernel.org/bpf/bpf-next/c/7d3851a31832
  - [bpf-next,05/10] selftests/bpf: Rename tcp-cc private struct in bpf_cubic and bpf_dctcp
    https://git.kernel.org/bpf/bpf-next/c/b1d87ae9b0d3
  - [bpf-next,06/10] selftests/bpf: Use bpf_tracing_net.h in bpf_cubic
    https://git.kernel.org/bpf/bpf-next/c/a824c9a8a4d9
  - [bpf-next,07/10] selftests/bpf: Use bpf_tracing_net.h in bpf_dctcp
    https://git.kernel.org/bpf/bpf-next/c/6ad4e6e94697
  - [bpf-next,08/10] selftests/bpf: Remove bpf_tcp_helpers.h usages from other misc bpf tcp-cc tests
    https://git.kernel.org/bpf/bpf-next/c/6eee55aa769c
  - [bpf-next,09/10] selftests/bpf: Remove the bpf_tcp_helpers.h usages from other non tcp-cc tests
    https://git.kernel.org/bpf/bpf-next/c/c075c9c4af28
  - [bpf-next,10/10] selftests/bpf: Retire bpf_tcp_helpers.h
    https://git.kernel.org/bpf/bpf-next/c/6a650816b098

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



