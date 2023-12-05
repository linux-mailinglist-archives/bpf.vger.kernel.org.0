Return-Path: <bpf+bounces-16734-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7F18056DE
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 15:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3489BB20F52
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 14:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBB665EA7;
	Tue,  5 Dec 2023 14:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m42C+4Hr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDBF61FCF
	for <bpf@vger.kernel.org>; Tue,  5 Dec 2023 14:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DA99CC433C8;
	Tue,  5 Dec 2023 14:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701785423;
	bh=0Jlx1C0XJJBJB/Kemq5wYTh5H+Jaf5STcas6wKQbg2w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m42C+4HraTFWFc1AsBO5Z5J5COfch8/RPlVCRz0lxZKLi+y0cughH0VwkrWqME3ae
	 qbTdZ/3VnZOpjkWLUZf02lfVvGFWcIoN+hu/z6NjpwPLsmlhjPJKIOUYi06vsNoAHB
	 ZnS9NA46tVaoL2aIwPP1KKp0j96/9ItdAJ+EAw0kz6zm+UMh6RAaa0B7WnpzQlpJod
	 2sj91q4VxNflR/20v2eNGMfTnhjwIHptybx+bBN7tqH4GzE63bi+IdM0oQwIX+62P4
	 LqfKzpk6qoKrpArtE7DD4oIptvkJ/2RaPJKPfiGHyG198GHzAngEXfv65k6dWT2q6l
	 RyIiHkwzYoXNw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BF501C40C5E;
	Tue,  5 Dec 2023 14:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 bpf-next] selftests/bpf: Test bpf_kptr_xchg stashing of
 bpf_rb_root
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170178542377.14907.15657150184110251308.git-patchwork-notify@kernel.org>
Date: Tue, 05 Dec 2023 14:10:23 +0000
References: <20231204211722.571346-1-davemarchevsky@fb.com>
In-Reply-To: <20231204211722.571346-1-davemarchevsky@fb.com>
To: Dave Marchevsky <davemarchevsky@fb.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@kernel.org, kernel-team@fb.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon, 4 Dec 2023 13:17:22 -0800 you wrote:
> There was some confusion amongst Meta sched_ext folks regarding whether
> stashing bpf_rb_root - the tree itself, rather than a single node - was
> supported. This patch adds a small test which demonstrates this
> functionality: a local kptr with rb_root is created, a node is created
> and added to the tree, then the tree is kptr_xchg'd into a mapval.
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> 
> [...]

Here is the summary with links:
  - [v1,bpf-next] selftests/bpf: Test bpf_kptr_xchg stashing of bpf_rb_root
    https://git.kernel.org/bpf/bpf-next/c/1b4c7e20bfd6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



