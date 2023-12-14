Return-Path: <bpf+bounces-17743-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5C18123A6
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 01:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13387B20E5C
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 00:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E154279E26;
	Thu, 14 Dec 2023 00:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rWum+91Z"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23ADB384
	for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 00:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F779C433C8;
	Thu, 14 Dec 2023 00:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702512026;
	bh=J5TWjmrt1bDvzlTAPL9GbvCISb+aW4+NQYoyqDA8yDg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rWum+91ZYT67u3PLRb8E4//ZC+8IXZPYJn7d06qmGc2b4UJQiBcNYiGOXQFFJ2hPR
	 hzqGzWpKux1kFVEblIPD/nq/vodOzIP7pO5E2NWJ6t6e89yJUAmvcwam0ex8WjaZuZ
	 BWdAPlh+GC71JinyzTVTlf56GP6mVS9yfl9EIruyOi2FeSPOaBp2TBlpxDM+xmyxAi
	 6wDzXkPwin8syunPkicB+bZX9Z+SvDELjSiTTqGv4vpLJI3E96YQl8gGHxxIsOkWjo
	 IGmdIIU/iWOqp2z8zo8C6LnvmV453NHZkg3ORq5WCS7dEhLy78FiKFqGk3G5S3AAne
	 ir/Nz7GoTIo7w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 754DBDD4F00;
	Thu, 14 Dec 2023 00:00:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 bpf-next 00/10] BPF token support in libbpf's BPF object
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170251202647.16780.12089257527704932829.git-patchwork-notify@kernel.org>
Date: Thu, 14 Dec 2023 00:00:26 +0000
References: <20231213190842.3844987-1-andrii@kernel.org>
In-Reply-To: <20231213190842.3844987-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 13 Dec 2023 11:08:32 -0800 you wrote:
> Add fuller support for BPF token in high-level BPF object APIs. This is the
> most frequently used way to work with BPF using libbpf, so supporting BPF
> token there is critical.
> 
> Patch #1 is improving kernel-side BPF_TOKEN_CREATE behavior by rejecting to
> create "empty" BPF token with no delegation. This seems like saner behavior
> which also makes libbpf's caching better overall. If we ever want to create
> BPF token with no delegate_xxx options set on BPF FS, we can use a new flag to
> enable that.
> 
> [...]

Here is the summary with links:
  - [v3,bpf-next,01/10] bpf: fail BPF_TOKEN_CREATE if no delegation option was set on BPF FS
    https://git.kernel.org/bpf/bpf-next/c/f5fdb51fb980
  - [v3,bpf-next,02/10] libbpf: split feature detectors definitions from cached results
    https://git.kernel.org/bpf/bpf-next/c/c6c5be3eee97
  - [v3,bpf-next,03/10] libbpf: further decouple feature checking logic from bpf_object
    https://git.kernel.org/bpf/bpf-next/c/29c302a2e265
  - [v3,bpf-next,04/10] libbpf: move feature detection code into its own file
    https://git.kernel.org/bpf/bpf-next/c/ab8fc393b27c
  - [v3,bpf-next,05/10] libbpf: wire up token_fd into feature probing logic
    https://git.kernel.org/bpf/bpf-next/c/a75bb6a16518
  - [v3,bpf-next,06/10] libbpf: wire up BPF token support at BPF object level
    https://git.kernel.org/bpf/bpf-next/c/1d0dd6ea2e38
  - [v3,bpf-next,07/10] selftests/bpf: add BPF object loading tests with explicit token passing
    https://git.kernel.org/bpf/bpf-next/c/98e0eaa36adf
  - [v3,bpf-next,08/10] selftests/bpf: add tests for BPF object load with implicit token
    https://git.kernel.org/bpf/bpf-next/c/18678cf0ee13
  - [v3,bpf-next,09/10] libbpf: support BPF token path setting through LIBBPF_BPF_TOKEN_PATH envvar
    https://git.kernel.org/bpf/bpf-next/c/ed54124b8805
  - [v3,bpf-next,10/10] selftests/bpf: add tests for LIBBPF_BPF_TOKEN_PATH envvar
    https://git.kernel.org/bpf/bpf-next/c/322122bf8c75

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



