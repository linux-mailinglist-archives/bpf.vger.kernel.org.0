Return-Path: <bpf+bounces-16973-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B86A2807E0B
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 02:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 284B92825EF
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 01:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD123567B;
	Thu,  7 Dec 2023 01:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGo63Y/j"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCEA539E
	for <bpf@vger.kernel.org>; Thu,  7 Dec 2023 01:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0EE4C433CC;
	Thu,  7 Dec 2023 01:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701913225;
	bh=eo9PljR7z7O0v4NwA7fdI4q3MuaX0CoLWuIShpqzalI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PGo63Y/jjaMcZjgr3jS81mUnqpGnjcGJ/TPCd2nulgzbTxtEoaczsXZ8e20zXO83s
	 sRArgpALL0OUQyafIzSjWWWYeGFGoDUP2KgQr8xNqy8A/A9SOViat6+uEOl3b3Edax
	 dMhwscb6MPoBz07YW5h8iN17quEa5Qcw5aC6LBEPCsvXiZeAYHuQ+7EXMowF1hgE5Z
	 D8YvmVffe/l93IFecX1JV6D5+skR/vNj5dqMTavXtZHOjfuSxEcRg3D743Ii1KcTDR
	 VTNiakxmqW6tYNhpNvaS5SXFSrFwNdOMXlsmG07iAgHdqmYcxgdSuoqb7uuaBkbv9z
	 0Mfa0CMqvccsg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 89634C395DC;
	Thu,  7 Dec 2023 01:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v7 bpf-next 0/7] Allocate bpf trampoline on bpf_prog_pack
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170191322555.26401.9706369522702299505.git-patchwork-notify@kernel.org>
Date: Thu, 07 Dec 2023 01:40:25 +0000
References: <20231206224054.492250-1-song@kernel.org>
In-Reply-To: <20231206224054.492250-1-song@kernel.org>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  6 Dec 2023 14:40:47 -0800 you wrote:
> This set enables allocating bpf trampoline from bpf_prog_pack on x86. The
> majority of this work, however, is the refactoring of trampoline code.
> This is needed because we need to handle 4 archs and 2 users (trampoline
> and struct_ops).
> 
> 1/7 through 6/7 refactors trampoline code. A few helpers are added.
> 7/7 finally let bpf trampoline on x86 use bpf_prog_pack.
> 
> [...]

Here is the summary with links:
  - [v7,bpf-next,1/7] bpf: Let bpf_prog_pack_free handle any pointer
    https://git.kernel.org/bpf/bpf-next/c/f08a1c658257
  - [v7,bpf-next,2/7] bpf: Adjust argument names of arch_prepare_bpf_trampoline()
    https://git.kernel.org/bpf/bpf-next/c/7a3d9a159b17
  - [v7,bpf-next,3/7] bpf: Add helpers for trampoline image management
    https://git.kernel.org/bpf/bpf-next/c/82583daa2efc
  - [v7,bpf-next,4/7] bpf, x86: Adjust arch_prepare_bpf_trampoline return value
    https://git.kernel.org/bpf/bpf-next/c/38b8b58ae776
  - [v7,bpf-next,5/7] bpf: Add arch_bpf_trampoline_size()
    https://git.kernel.org/bpf/bpf-next/c/96d1b7c081c0
  - [v7,bpf-next,6/7] bpf: Use arch_bpf_trampoline_size
    https://git.kernel.org/bpf/bpf-next/c/26ef208c209a
  - [v7,bpf-next,7/7] x86, bpf: Use bpf_prog_pack for bpf trampoline
    https://git.kernel.org/bpf/bpf-next/c/3ba026fca878

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



