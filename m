Return-Path: <bpf+bounces-68414-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D34B5B5842F
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 20:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16BC31AA72CA
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 18:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287C6285CB3;
	Mon, 15 Sep 2025 18:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uLVZvyrR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA0F2D0C7F
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 18:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757959209; cv=none; b=ARchOt8+wW68Mg5PVpn5rRVaVrOtcl6FPOmGSF/GrV+h/BLEXXGoT5yr1cQHQSMRT0+nyfpii7pCffAcLtnVjw+hLOdOyHdgEXevXdkp4jWvtHygf1+R7z3MRCdJTGvuOYP4OuP7XNYkcRn4y8kt5W6L9EtOAZU34RVNdgNqLJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757959209; c=relaxed/simple;
	bh=1xdRwODzrb0Wxd7Zv6W9c013IWxBC59fDnhwJk5Nx8A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=p0igw8wMY4canaG2hs3E3cMgoRQbTrs7/mO/0xut18UcXhqKb42iiMisIi+c36xBIp9XmKvPJMB0d4QwiduLyXogPagkbcm5aTc/tw7pxVtwZ1U0RENalLpkLg8ia924Wk+8gCTB8hXr5AO1HoamKGcqkO/kQRHcz0+xWJWIaEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uLVZvyrR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AEE3C4CEF1;
	Mon, 15 Sep 2025 18:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757959209;
	bh=1xdRwODzrb0Wxd7Zv6W9c013IWxBC59fDnhwJk5Nx8A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uLVZvyrRrIzpdyIjmOe+k1fNB6h4mk5z0kPAyvrUWhfSr6REgRM/B7z+B/0CyxVBp
	 noCocDEV4CivpiJMDd5zFzg8/rJHqrnl95nQobFuh6W7BYDrrQy9kueK9a7rDnT0mo
	 8Hoqo/8DSnssG8kT6D+zInT+jSPNCh1waBTOKz56emId/EFpV9BY9t7PW7P8XQ54YK
	 ydZtQadHxCHZ0i5lIufvLtjf1pEvNqWXmDbRPLlSAZ2bt2tJwADr2Ogjmel2khtlhr
	 o82eHQCVDUzI1/4EP6WUbcCHJ0tks+RzHkIGaHW7uD/GEKQ+4HeOh165IOLsxpuife
	 5rxiERqNYBLOA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB33A39D0C18;
	Mon, 15 Sep 2025 18:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/2] Remove use of current->cgns in
 bpf_cgroup_from_id
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175795921075.78773.9684528758037599872.git-patchwork-notify@kernel.org>
Date: Mon, 15 Sep 2025 18:00:10 +0000
References: <20250915032618.1551762-1-memxor@gmail.com>
In-Reply-To: <20250915032618.1551762-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
 tj@kernel.org, dschatzberg@meta.com, kkd@meta.com, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 15 Sep 2025 03:26:16 +0000 you wrote:
> bpf_cgroup_from_id currently ends up doing a check on whether the cgroup
> being looked up is a descendant of the root cgroup of the current task's
> cgroup namespace. This leads to unreliable results since this kfunc can
> be invoked from any arbitrary context, for any arbitrary value of
> current. Fix this by removing namespace-awarness in the kfunc, and
> include a test that detects such a case and fails without the fix.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/2] bpf: Do not limit bpf_cgroup_from_id to current's namespace
    https://git.kernel.org/bpf/bpf-next/c/2c8951339506
  - [bpf-next,v3,2/2] selftests/bpf: Add a test for bpf_cgroup_from_id lookup in non-root cgns
    https://git.kernel.org/bpf/bpf-next/c/a8250d167c0c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



