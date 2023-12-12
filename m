Return-Path: <bpf+bounces-17483-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E47B80E2A4
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 04:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 489D72823D5
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 03:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879D17484;
	Tue, 12 Dec 2023 03:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzmHp7K+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14266AB3
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 03:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5CC96C433C9;
	Tue, 12 Dec 2023 03:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702351223;
	bh=iie8KqJTKp4ymrWk27S5Rr2bKyW+K5mSbJKkEhjuS3U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hzmHp7K+a9+Ban8X2h6oJY20xHdDXxlasRJr5HjCtMxnwonlbRORP+4TiYqLxKtBc
	 rrQ4VJw7qNFfpmkgaYd0vVkJDOiMHb5civKc6JeHNTNw7p5IhZ+3vh1+kdbTeqO3a2
	 KYtNVi0X693eRdwRrKKOajkAclyqQh4ZUzVk9jn0v3aSBDm2vNOQnN/tFDIvSv4waM
	 XVVi8vkLPRC3MCDmMkk5oBMW5kgxvymEodD2Yy75okevtzkbh2zY+Tth0jDMkvnW71
	 CczZAH6mwSTqpqPLbbwXHnI/BQKXe8k/s71DLPRG/x35RdpOn3QDJGYF2FvG4Cw4ti
	 AZmXkZs6wH5Vw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 44A3DC04DD9;
	Tue, 12 Dec 2023 03:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 bpf-next] selftests/bpf: validate eliminated global subprog
 is not freplaceable
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170235122327.10568.5726324397309497701.git-patchwork-notify@kernel.org>
Date: Tue, 12 Dec 2023 03:20:23 +0000
References: <20231211174131.2324306-1-andrii@kernel.org>
In-Reply-To: <20231211174131.2324306-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com, eddyz87@gmail.com,
 alan.maguire@oracle.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 11 Dec 2023 09:41:31 -0800 you wrote:
> Add selftest that establishes dead code-eliminated valid global subprog
> (global_dead) and makes sure that it's not possible to freplace it, as
> it's effectively not there. This test will fail with unexpected success
> before 2afae08c9dcb ("bpf: Validate global subprogs lazily").
> 
> v2->v3:
>   - add missing err assignment (Alan);
>   - undo unnecessary signature changes in verifier_global_subprogs.c (Eduard);
> v1->v2:
>   - don't rely on assembly output in verifier log, which changes between
>     compiler versions (CI).
> 
> [...]

Here is the summary with links:
  - [v3,bpf-next] selftests/bpf: validate eliminated global subprog is not freplaceable
    https://git.kernel.org/bpf/bpf-next/c/e72c1ccfd449

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



