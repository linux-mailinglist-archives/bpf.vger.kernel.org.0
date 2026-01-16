Return-Path: <bpf+bounces-79349-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A3637D3897B
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 23:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B61443059342
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 22:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51715314A8F;
	Fri, 16 Jan 2026 22:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bu+HdUjr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02FE7260D;
	Fri, 16 Jan 2026 22:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768604016; cv=none; b=Sq2UIzyzY8LIFUTNXIudRGlzeG2dd1z1SfXjvKI0T60fRMYuRQAU8gEmiOynsALZy7q/+xrSOlwFZat5jjaGGpW2k3EwjSRcSRtE39cpbXjCrg8BGrDBSN+wWiDEk+WjwNOKoWvla3jbcCnmI4iIdk3BiYymphpyGEdbpn7+4/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768604016; c=relaxed/simple;
	bh=grmZgYmjTafH6ZyCdmPzfOmNXHLTkF2+dQyjV3L7V7c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VSOeufAKb/DTGj+/k0XJm9US8jf6X0SJ7lR38Qz32ZtulCUEuIclOF12Jf7eWG8xorKzyyJroly+z1bcuQuPGAfNEczwPoyh2z3tNnwmbXGkGJZzaR7K7lQ5WIioBoHUF6BgmV5yM8s01mYNTXohZ3Nn7hW057sl+H9ms9jCgCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bu+HdUjr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE6BC116C6;
	Fri, 16 Jan 2026 22:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768604016;
	bh=grmZgYmjTafH6ZyCdmPzfOmNXHLTkF2+dQyjV3L7V7c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bu+HdUjr1ZKSAs05/zWM8GRyqEtxujz2tjublCdBDmiYdz31G4gUXydS4aft1niGs
	 Am73iF+X/hbDDOCn5MOUVKIT4L9sMx9jJppSWBcqZUtpIEA/P4cmE1rfUQrlc0otbY
	 i1hqLnfhnZAVf3vXs6nl4RhDMrVuIRV0oCsIpxhLl9D2I8lEXDXbxQEG6SWR2DImgR
	 keeov45TTyKzgLqW0As7RKsjSerEOujT9RG2VbAvPfEx7g4bnTl3hl4WPqwUm1tOVw
	 7UcIc4WEp5vuM280HAQIFP4cm2mZLTbINiSwAHC+sJuFvK5Qg+caeP1Wea3j313m1z
	 +7Pvr7YNC6ISA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2B01380CECB;
	Fri, 16 Jan 2026 22:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] bpftool: Add 'prepend' option for tcx attach to insert
 at
 chain start
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176860380780.826620.7253991857849966503.git-patchwork-notify@kernel.org>
Date: Fri, 16 Jan 2026 22:50:07 +0000
References: <20260112034516.22723-1-gyutae.opensource@navercorp.com>
In-Reply-To: <20260112034516.22723-1-gyutae.opensource@navercorp.com>
To: None <gyutae.opensource@navercorp.com>
Cc: qmo@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
 linux-kernel@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 gyutae.bae@navercorp.com, siwan.kim@navercorp.com, dxu@dxuuu.xyz,
 jiayuan.chen@linux.dev, chen.dylane@linux.dev, memxor@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 12 Jan 2026 12:45:16 +0900 you wrote:
> From: Gyutae Bae <gyutae.bae@navercorp.com>
> 
> Add support for the 'prepend' option when attaching tcx_ingress and
> tcx_egress programs. This option allows inserting a BPF program at
> the beginning of the TCX chain instead of appending it at the end.
> 
> The implementation uses BPF_F_BEFORE flag which automatically inserts
> the program at the beginning of the chain when no relative reference
> is specified.
> 
> [...]

Here is the summary with links:
  - [v4] bpftool: Add 'prepend' option for tcx attach to insert at chain start
    https://git.kernel.org/bpf/bpf-next/c/999b2395e3c3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



