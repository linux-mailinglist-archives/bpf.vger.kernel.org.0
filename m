Return-Path: <bpf+bounces-20783-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED19484328F
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 02:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9D0928255A
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 01:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C564B139E;
	Wed, 31 Jan 2024 01:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mk8Yaef2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDA01368
	for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 01:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706663426; cv=none; b=I74fgmup5PkCbiAo37dPdUNBsv4ZeEWSk7bLK+o2/h5dtZc5wwoc8qxwhvw339bOZBEC0UOKQ6DZH3sGN+ZrJvqx9Yonya0eFLT3rGuvNEpzjHQzXpHv3ng6oZhNIXzslFzxGddyHYiJaSNOiBzbs3VkztLeFUf8LieaFrVuIyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706663426; c=relaxed/simple;
	bh=Vonc65X/uNvTH3UmonYZvL4o8i62OMU5G9VEfFWTsLo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NIOzJxThZKVZ1u196nN1E5MdPVxVQuPfixBMdn74ypPfjdO8D+yByDQk12HFEtc7J7np//zYH2mODmRRg2Xa2u48q9EX6U8IRmwRixUzrl/iAvgrEgDcoEWsKoP+TISI7itRhhvtm2si34wCnvu9g9bamZGGqx3nOkfxYVv+Sy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mk8Yaef2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B8664C433F1;
	Wed, 31 Jan 2024 01:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706663425;
	bh=Vonc65X/uNvTH3UmonYZvL4o8i62OMU5G9VEfFWTsLo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Mk8Yaef2zizArsUAF33kIGDeSweJr1eWY9Mhx9R90M3WD1ktkTn2tbU0eWzMf19pN
	 6Wz1U3xzt78DnNmhBXlfjsA5txxns3y7seKxpBsPUasnOxcnjby6ZuHl39QVwIG24A
	 jbklSAayvf6be/ZdJ5kkEVQZ5fPsGnly0EHNW/dXniAv+NCEfCYaux7R8pfgR5D+/o
	 MQap6Ed+1lo3QqMFmGUcf2vSMoibKZSWHHGZQcLfh1488Xa7mJLPMq7I+HSUEXsSPu
	 vMh9EOOSm1LRZsdCUQtdoQrrLWqvz2iFinjiwXa8RcCAvNMSNBAI7qEfNMR97o0z8S
	 iZoUTwfK9LQog==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9E970C395FE;
	Wed, 31 Jan 2024 01:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/2] libbpf: add bpf_core_cast() helper
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170666342564.7191.14337606154910020823.git-patchwork-notify@kernel.org>
Date: Wed, 31 Jan 2024 01:10:25 +0000
References: <20240130212023.183765-1-andrii@kernel.org>
In-Reply-To: <20240130212023.183765-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Tue, 30 Jan 2024 13:20:21 -0800 you wrote:
> Add bpf_core_cast(<ptr>, <type>) macro wrapper around bpf_rdonly_cast() kfunc
> to make it easier to use this functionality in BPF code. See patch #2 for
> BPF selftests conversions demonstrating improvements in code succinctness.
> 
> Andrii Nakryiko (2):
>   libbpf: add bpf_core_cast() macro
>   selftests/bpf: convert bpf_rdonly_cast() uses to bpf_core_cast() macro
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] libbpf: add bpf_core_cast() macro
    https://git.kernel.org/bpf/bpf-next/c/20d59ee55172
  - [bpf-next,2/2] selftests/bpf: convert bpf_rdonly_cast() uses to bpf_core_cast() macro
    https://git.kernel.org/bpf/bpf-next/c/ea9d561686fb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



