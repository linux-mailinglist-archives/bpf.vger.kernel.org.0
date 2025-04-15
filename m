Return-Path: <bpf+bounces-56009-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2BAA8AB4D
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 00:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A688D3B2F43
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 22:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A32228DF1D;
	Tue, 15 Apr 2025 22:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OxmOcfvS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1687161310
	for <bpf@vger.kernel.org>; Tue, 15 Apr 2025 22:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744756245; cv=none; b=jBC37IhPrnyVNVW8iwNUql5GjLl0+yz3dWu+o/Ry4FNV0ULMjBnDh4xtXos1UMrEI4l91+0UMqrWK6XEcPJAKloace0CsXrvXTooTmYCpAGr9xeb71ySWPr9IsoWs+oraGjv+D0ctgo0ITeIXx2BBLclY82kHZ6FlEX5CuEoDfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744756245; c=relaxed/simple;
	bh=uvKB57cQZUnwjGfjRsmIooCbwSophqb8XzAdG9bEP+o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e3q80L7CVSa98hc4QB3NJPlHf31a+JJtg2931gpGCgm7INMLL2lNVtOLx0+1Fw5TaX5sD4Aokq3g3FngfX1RYRojpETCW5dFcxVSTF87Mz2mRY1IxqwOnw3igM6cp4eoryTGu2rlWBlq5Tzich8AZ6uyrg26rsdOdnB0vocXd20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OxmOcfvS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07152C4CEE7;
	Tue, 15 Apr 2025 22:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744756244;
	bh=uvKB57cQZUnwjGfjRsmIooCbwSophqb8XzAdG9bEP+o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OxmOcfvSlrdLPpAD3mZxPGWmb5BQ+JiwVPANpfmnt43CXPk8BYpgw4oB5x4u2/MM2
	 gLTx4swidCJznXicQ5Kt4+cMlZygOk7PASoIffZl3GKjPmB6J2AnbWUgLNuTJ4qxBm
	 GIsH+KTnlAKHAMNn0Dst5yPnBd3+CAI5Guj/476DeWvYG4asynm/FGDXFwZqqchoL9
	 vTGk+Qbbce/iFrCt2sMhPs+KZmQOZfCunFastzM+5RIDHiu5H5ftPJIFx6R86ywDFK
	 RE7zdn4Qmr5ro7tbqaN4UaKLjQTcZOJGyGp6RmCQkMDcvyvG4a9DFWzB1c3zIQocUr
	 CtsgT1PsnO4Dg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BBF3822D55;
	Tue, 15 Apr 2025 22:31:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] libbpf: verify section type in
 btf_find_elf_sections
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174475628166.2800528.3544197341402482245.git-patchwork-notify@kernel.org>
Date: Tue, 15 Apr 2025 22:31:21 +0000
References: <20250410182823.1591681-1-ihor.solodrai@linux.dev>
In-Reply-To: <20250410182823.1591681-1-ihor.solodrai@linux.dev>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, bpf@vger.kernel.org, mykolal@fb.com, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 10 Apr 2025 11:28:23 -0700 you wrote:
> A valid ELF file may contain a SHT_NOBITS .BTF section. This case is
> not handled correctly in btf_parse_elf, which leads to a segfault.
> 
> Before attempting to load BTF section data, check that the section
> type is SHT_PROGBITS, which is the expected type for BTF data.  Fail
> with an error if the type is different.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] libbpf: verify section type in btf_find_elf_sections
    https://git.kernel.org/bpf/bpf-next/c/8582d9ab3efd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



