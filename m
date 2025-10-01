Return-Path: <bpf+bounces-70168-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C97BB2025
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 00:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1EC932177B
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 22:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1233A311968;
	Wed,  1 Oct 2025 22:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MYTNpHvG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BEA24678F
	for <bpf@vger.kernel.org>; Wed,  1 Oct 2025 22:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759358422; cv=none; b=hpLY7sh3cwO0QI1PcGW36bc0tEyVgCFYFH+kwfGvMkNm2XQe4DkgVYRooLDvFpj5RdSjKywDGeuTMugU8ZHUOFdyXlGBAdztbkitl+la+zTiE+Mz0Bn3f6LJZfPxtEmYc8iJj89vm265rUjUKl/WrhSJ7J9/ZbgBhllzSJM+glg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759358422; c=relaxed/simple;
	bh=Xrzn7Jg/TlH167Uqi3Yep4btx2BKvSnbbSDyexV/ELg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MkJhFY6EGQpOMUXu6tOzwd3Sdxyq1FS6ha9P7rzirwo3OriGKDQTQoTp37FcBpNSmGxaLZz28jpoLYtpzHJdVR5aUQ9yz6SdzjFZsdbWAP6KbLOFGHacvnaWH4uDwWSB3za+WQTnTjM8PHhH4MvECvMZaNBSrRGvrQ3E5rz1Cpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MYTNpHvG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BEA5C4CEF1;
	Wed,  1 Oct 2025 22:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759358420;
	bh=Xrzn7Jg/TlH167Uqi3Yep4btx2BKvSnbbSDyexV/ELg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MYTNpHvGdVRfSDAdVPmql8B07fSb1p55qyW7GQgYfjlACC6vfgzgFHj74UK87FSlK
	 EShYmZyCyS54b6CSV40nfbayW/MVvr3CLkjpK/pRUYuRSnoP0/yFLcNq+sUPFN3rQm
	 3p/g/CZCwlr85ODaCK9klggkTUz5HOgvU2tbO20h6hE1KdUC2vuPoci30gpENUDHW3
	 hcqt6Ab55lnuU/s6PV5n9m8omB8uboarD0f6DJZSPffOj+ewBBOmVInsbDDcuIFMb5
	 SsfvgV9A5MHqQOOxW/jl1VXtpGFdYspMqJ/KuPo9voY2Hn1FplvYaumsf00byko7kJ
	 TigwPX0E2CZMQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF3D39EE03D;
	Wed,  1 Oct 2025 22:40:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf 0/5] libbpf: fix libbp_sha256() for Github
 compatibility
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175935841250.2644364.16942203502727029189.git-patchwork-notify@kernel.org>
Date: Wed, 01 Oct 2025 22:40:12 +0000
References: <20251001171326.3883055-1-andrii@kernel.org>
In-Reply-To: <20251001171326.3883055-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  1 Oct 2025 10:13:21 -0700 you wrote:
> Recent reimplementation of libbpf_sha256() introduced issues for libbpf's
> Github mirror due to reliance on linux/unaligned.h header. This patch set
> fixes those issues to make libbpf source code compatible with Github mirror
> setup.
> 
> This patch set starts with a bit of organization: we introduce libbpf_utils.c
> as a place for generic internal helpers like libbpf_errstr() and
> libbpf_sha256(), and move a few existing helpers there. We also clean up
> libbpf_strerror_r(), which seems to be a leftover of some previous
> refactorings.
> 
> [...]

Here is the summary with links:
  - [v2,bpf,1/5] libbpf: make libbpf_errno.c into more generic libbpf_utils.c
    https://git.kernel.org/bpf/bpf/c/44d42bd80804
  - [v2,bpf,2/5] libbpf: remove unused libbpf_strerror_r and STRERR_BUFSIZE
    https://git.kernel.org/bpf/bpf/c/d05ab6181be0
  - [v2,bpf,3/5] libbpf: move libbpf_errstr() into libbpf_utils.c
    https://git.kernel.org/bpf/bpf/c/c68b6fdc3600
  - [v2,bpf,4/5] libbpf: move libbpf_sha256() implementation into libbpf_utils.c
    https://git.kernel.org/bpf/bpf/c/a7f36f81d0bd
  - [v2,bpf,5/5] libbpf: remove linux/unaligned.h dependency for libbpf_sha256()
    https://git.kernel.org/bpf/bpf/c/4a1c9e544b8d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



