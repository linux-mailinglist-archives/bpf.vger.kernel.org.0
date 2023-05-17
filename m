Return-Path: <bpf+bounces-709-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18204705F28
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 07:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C4481C20E0D
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 05:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187225239;
	Wed, 17 May 2023 05:20:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CCE210D
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 05:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E14ABC4339B;
	Wed, 17 May 2023 05:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684300822;
	bh=GNN5D8RBqe+6LpuJB/PJcbtmtMaYZFPS55MHCsbOk3Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=i4sKz7PNX1KV+vVTqLqPzXIqaLAt2pE4A/n15RKj970qC9pxZkJwM7suZjGW3WBqh
	 lPixOaBik90OQvz6RoKQQoT+iTzV6dM22wbuvIcKiZCo1UuFnAg9dfoNJchsx/YMPg
	 P5NCQ9rW/TElunCgg5PNrljsdqBPN3YBoOEjvae7lq46SU0dpfO4Kd9Sb2isKJwXlG
	 aWv5kD+xFORR65aXDOVRTYGvd6phzS7wzvj+T76IMQ9ZNiHHzKRzqLb9/8PnojTmsc
	 iMk3QycvjIeRoC0PsGWDk3O2KPXm3xSPYjelFVXa/R0zT8eVORCL4/3P93zDOuj1F2
	 DfdrxTKJ2CDJw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CB0D0E5421C;
	Wed, 17 May 2023 05:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv4 bpf-next 00/10] bpf: Move kernel test kfuncs into
 bpf_testmod
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168430082282.27237.3835689466845721990.git-patchwork-notify@kernel.org>
Date: Wed, 17 May 2023 05:20:22 +0000
References: <20230515133756.1658301-1-jolsa@kernel.org>
In-Reply-To: <20230515133756.1658301-1-jolsa@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@chromium.org, sdf@google.com,
 haoluo@google.com, void@manifault.com, memxor@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 15 May 2023 15:37:46 +0200 you wrote:
> hi,
> I noticed several times in discussions that we should move test kfuncs
> into kernel module, now perhaps even more pressing with all the kfunc
> effort. This patchset moves all the test kfuncs into bpf_testmod.
> 
> I added bpf_testmod/bpf_testmod_kfunc.h header that is shared between
> bpf_testmod kernel module and BPF programs.
> 
> [...]

Here is the summary with links:
  - [PATCHv4,bpf-next,01/10] libbpf: Store zero fd to fd_array for loader kfunc relocation
    https://git.kernel.org/bpf/bpf-next/c/10cb8622b695
  - [PATCHv4,bpf-next,02/10] selftests/bpf: Move kfunc exports to bpf_testmod/bpf_testmod_kfunc.h
    https://git.kernel.org/bpf/bpf-next/c/8e9af8217124
  - [PATCHv4,bpf-next,03/10] selftests/bpf: Move test_progs helpers to testing_helpers object
    https://git.kernel.org/bpf/bpf-next/c/45db310984bf
  - [PATCHv4,bpf-next,04/10] selftests/bpf: Use only stdout in un/load_bpf_testmod functions
    https://git.kernel.org/bpf/bpf-next/c/d18decca69e3
  - [PATCHv4,bpf-next,05/10] selftests/bpf: Do not unload bpf_testmod in load_bpf_testmod
    https://git.kernel.org/bpf/bpf-next/c/b58f3f0e6f3c
  - [PATCHv4,bpf-next,06/10] selftests/bpf: Use un/load_bpf_testmod functions in tests
    https://git.kernel.org/bpf/bpf-next/c/11642eb92b3b
  - [PATCHv4,bpf-next,07/10] selftests/bpf: Load bpf_testmod for verifier test
    https://git.kernel.org/bpf/bpf-next/c/b23b385fa18f
  - [PATCHv4,bpf-next,08/10] selftests/bpf: Allow to use kfunc from testmod.ko in test_verifier
    https://git.kernel.org/bpf/bpf-next/c/f26ebdd3e4e4
  - [PATCHv4,bpf-next,09/10] selftests/bpf: Remove extern from kfuncs declarations
    https://git.kernel.org/bpf/bpf-next/c/6e2b50fa818b
  - [PATCHv4,bpf-next,10/10] bpf: Move kernel test kfuncs to bpf_testmod
    https://git.kernel.org/bpf/bpf-next/c/65eb006d85a2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



