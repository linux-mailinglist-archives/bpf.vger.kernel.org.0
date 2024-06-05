Return-Path: <bpf+bounces-31444-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AAA08FD150
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 17:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D19DA1F26B54
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 15:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7B43A8D2;
	Wed,  5 Jun 2024 15:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="reULL759"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D7C2AF16
	for <bpf@vger.kernel.org>; Wed,  5 Jun 2024 15:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717599632; cv=none; b=jvRbwY1B5VVlNOO4GU87mZ7iYrGNvhzDTbTGVBaQTmLw0TLXadnvFhEAaoyWX6dsavdGNI16omJ2DQ4+ahbf15fyelna9xsOlp04GHIBK44z3VN3tRrGlfhebFvIGCDSmF7pgiH34KENCEto4tvQ7dtsXswOopcATpi/o60r17I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717599632; c=relaxed/simple;
	bh=PNw/a6cfGfKoGgICUZd5Rte+i/gwDsSsemMUFOq/MrM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZOxbVDrImEpCV1F3hr6JtcrK/yEWDFHUZp+oMsjCFPFKNXxzlHcQwdcdUiMmnAfQp2gP32bbbnwEfBUVAXpx2w50QMvjaLSrReQjmioNzuOSID+HR0yQFCX86XuKXcL8Y9k4vbBi1THTWXja+I4JqlkI80GqzxIWQkZZbv1wZGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=reULL759; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E0DD8C3277B;
	Wed,  5 Jun 2024 15:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717599631;
	bh=PNw/a6cfGfKoGgICUZd5Rte+i/gwDsSsemMUFOq/MrM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=reULL759MTpuWfaj6PIk4bo0FbtIUU+HulRuO+bBKpBe6jkNF/HAiDw0fmi4keUmp
	 +qLxm9HTFTF+3XACkDtOdDv1mmdktrA7D0P9Pv0xfHnKi9MxvzA2AjI0qkyWpL9fEQ
	 UB6AnxaD9T+E7EY/OoHob8x1lFu/7HJn0i4M+ONowuV+iWxsaXNv8X91Joy6cPRMwe
	 FABysxkv74I/19Y0szhdQeawFThHGw0OpaeAQtQNuuoWg7RqzHfEhMe+b0FCXpxHFz
	 8pCxOVRknsFzwENgS/2w5TdzTmVR4jDPuE2bnBt8gokt9i148U6RTYqBnP3ZfoXJGQ
	 ABtPbvqW87D7Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C75B4D3E997;
	Wed,  5 Jun 2024 15:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 0/5] libbpf: BTF field iterator
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171759963081.16614.17209889293631246757.git-patchwork-notify@kernel.org>
Date: Wed, 05 Jun 2024 15:00:30 +0000
References: <20240605001629.4061937-1-andrii@kernel.org>
In-Reply-To: <20240605001629.4061937-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, alan.maguire@oracle.com, eddyz87@gmail.com,
 jolsa@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue,  4 Jun 2024 17:16:24 -0700 you wrote:
> Add BTF field (type and string fields, right now) iterator support instead of
> using existing callback-based approaches, which make it harder to understand
> and support BTF-processing code.
> 
> v1->v2:
>   - t_cnt -> t_off_cnt, m_cnt -> m_off_cnt (Eduard);
>   - simpified code in linker.c (Jiri);
> rfcv1->v1:
>   - check errors when initializing iterators (Jiri);
>   - split RFC patch into separate patches.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/5] libbpf: add BTF field iterator
    https://git.kernel.org/bpf/bpf-next/c/68153bb2fffb
  - [v2,bpf-next,2/5] libbpf: make use of BTF field iterator in BPF linker code
    https://git.kernel.org/bpf/bpf-next/c/2bce2c1cb2f0
  - [v2,bpf-next,3/5] libbpf: make use of BTF field iterator in BTF handling code
    https://git.kernel.org/bpf/bpf-next/c/c2641123696b
  - [v2,bpf-next,4/5] bpftool: use BTF field iterator in btfgen
    https://git.kernel.org/bpf/bpf-next/c/e1a8630291fd
  - [v2,bpf-next,5/5] libbpf: remove callback-based type/string BTF field visitor helpers
    https://git.kernel.org/bpf/bpf-next/c/072088704433

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



