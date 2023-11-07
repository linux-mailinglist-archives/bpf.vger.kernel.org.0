Return-Path: <bpf+bounces-14435-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF217E47E3
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 19:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07DD01C20BAE
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 18:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDB7358A0;
	Tue,  7 Nov 2023 18:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jFYNuxmf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A0C3588D;
	Tue,  7 Nov 2023 18:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 042C8C433CA;
	Tue,  7 Nov 2023 18:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699380627;
	bh=+HzkP4Kescl5ETtpnZgfZ1H6Oq13CAxwyRlb2Gc8oB0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jFYNuxmfGmIc8TV4E4QywWpiITR8m1cHvczri8jhi33ioTtQ6Dt4k/DvniMty6UXN
	 bCFoxTHRKiXJUh1LIb1IOgkZgDeARS+E5CN0ilILaGNdLNm39FNKM+Fwg2wBP4IflI
	 N0PWSbdJgl3y76xnDcPDD4b9C0k19cDdQmn0VGDsIkfkrVSSAvoVLv59ej8Px2ub7M
	 KqErGqFiXrYt5MkYTt3q7vMezpwZwbc5e0b34bBOtZILv7ZT6T8hS7S5GjD5575NEr
	 Xb3FZkTCr8lPnoyFcaXIoiI5Sb0vg2AC3Am8Dz4u2ADyPdDJillkqZgivAC3LVUzQY
	 iXWxZnNVqE4Nw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DA458E00087;
	Tue,  7 Nov 2023 18:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/3] bpf: __bpf_dynptr_data* and __str annotation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169938062689.9957.5221638465583040520.git-patchwork-notify@kernel.org>
Date: Tue, 07 Nov 2023 18:10:26 +0000
References: <20231107045725.2278852-1-song@kernel.org>
In-Reply-To: <20231107045725.2278852-1-song@kernel.org>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, fsverity@lists.linux.dev, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
 kernel-team@meta.com, ebiggers@kernel.org, tytso@mit.edu,
 roberto.sassu@huaweicloud.com, kpsingh@kernel.org, vadfed@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon,  6 Nov 2023 20:57:22 -0800 you wrote:
> This set contains the first 3 patches of set [1]. Currently, [1] is waiting
> for [3] to be merged to bpf-next tree. So send these 3 patches first to
> unblock other works, such as [2]. This set is verified with new version of
> [1] in CI run [4].
> 
> Changes since v12 of [1]:
> 1. Reuse bpf_dynptr_slice() in __bpf_dynptr_data(). (Andrii)
> 2. Add Acked-by from Vadim Fedorenko.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/3] bpf: Add __bpf_dynptr_data* for in kernel use
    https://git.kernel.org/bpf/bpf-next/c/afa58570c3f4
  - [bpf-next,2/3] bpf: Factor out helper check_reg_const_str()
    https://git.kernel.org/bpf/bpf-next/c/d8ace21aece8
  - [bpf-next,3/3] bpf: Introduce KF_ARG_PTR_TO_CONST_STR
    https://git.kernel.org/bpf/bpf-next/c/6d857121c63b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



