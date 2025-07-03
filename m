Return-Path: <bpf+bounces-62352-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DF5AF836E
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 00:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96CF27ADCEF
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 22:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577F42BE634;
	Thu,  3 Jul 2025 22:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rOfmBjah"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56AA2BDC2B
	for <bpf@vger.kernel.org>; Thu,  3 Jul 2025 22:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751581786; cv=none; b=eSg4+LlwppVvey3TWejGi5rT72B3RHolAP2eZDuq6uNFOMtPTVkpOdMg7jVAe1MUEGv09Qp3hXuEVlee4Srvj7HWmwVlNuc7NHIMb/DjDCrFHnqw18ZVdiT9vH8Yxrpso1KcoUjnsplcjGxs+FElk2XxycaFGhIhNlY8e4f2+Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751581786; c=relaxed/simple;
	bh=LASsV/7kYgPXAwzfHNssWMGwP4MKBwG5Mm0Dc3BDanY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UDukJ9PE5yAJY8SJs9Vx7stTgIMyyawbKaOyBs+eGaWRg1twHeKJj9qtrKH1M4CB5qiC74iuiVsnYHP4ldizmqDWx+BNdgZdBh1LzmYxVPHDKFthMTxtbaNj/aCWnVCdbx4uymX6lvhYlEhKx78VTMGw6PDfV7m7yzh/4LeZs7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rOfmBjah; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD2DC4CEE3;
	Thu,  3 Jul 2025 22:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751581785;
	bh=LASsV/7kYgPXAwzfHNssWMGwP4MKBwG5Mm0Dc3BDanY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rOfmBjahl49ll62S11ns7mJZvVmnnrEOwzY4RjaEHVWxq/8hJwXHEhD9TzFXu3P7g
	 /703nkiUn4d30dIl2HZJBvx0BLEDhcF6KMAS9uC+A+osbFDkNpVCGdjwMCeR9Sz2kX
	 RTsunk6uoBZ40JxVc2/7lcHE9/T+q6BQQA7+Sz4+12ECdNstBFko+hThY7urey0/2/
	 LJkE2ATdeQ6QB7IuJ+bO1N94LyKnpNAffAFp6cUjUumTg4vnr3D3S02W8zlIfEjrSJ
	 lfWSuG2nvw0uBBtK5NL8qQi87BqJDNcoXQtWqIW0qmcQgPjtxE7WBrMeNZdzEp29KF
	 Cgm4PN26GqMVg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFE2383BA01;
	Thu,  3 Jul 2025 22:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/2] bpf: add bpf_dynptr_memset() kfunc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175158180951.1634970.14324249850522313424.git-patchwork-notify@kernel.org>
Date: Thu, 03 Jul 2025 22:30:09 +0000
References: <20250702210309.3115903-1-isolodrai@meta.com>
In-Reply-To: <20250702210309.3115903-1-isolodrai@meta.com>
To: Ihor Solodrai <isolodrai@meta.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, eddyz87@gmail.com,
 mykyta.yatsenko5@gmail.com, mykolal@fb.com, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 2 Jul 2025 14:03:07 -0700 you wrote:
> Implement bpf_dynptr_memset() kfunc and add tests for it.
> 
> v3->v4:
>   * do error checks after slice, nits
> v2->v3:
>   * nits and slow-path loop rewrite (Andrii)
>   * simplify xdp chunks test (Mykyta)
> v1->v2:
>   * handle non-linear buffers with bpf_dynptr_write()
>   * change function signature to include offset arg
>   * add more test cases
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/2] bpf: add bpf_dynptr_memset() kfunc
    https://git.kernel.org/bpf/bpf-next/c/5fc5d8fded57
  - [bpf-next,v4,2/2] selftests/bpf: add test cases for bpf_dynptr_memset()
    https://git.kernel.org/bpf/bpf-next/c/7b29689263fb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



