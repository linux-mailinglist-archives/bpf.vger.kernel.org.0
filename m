Return-Path: <bpf+bounces-51642-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 977DBA36BEF
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 05:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA1A53AA427
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 04:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB75517799F;
	Sat, 15 Feb 2025 04:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sGe8MdaN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3179021345
	for <bpf@vger.kernel.org>; Sat, 15 Feb 2025 04:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739592606; cv=none; b=fjEFNm31bxcrx6R/9tNJxdQzgRwYRNhzqvZLzZ3C0s/L0RjAD4AE3f01luMyrX3tblTHrzT5y3jUTDXyGCZOPhCLIDM2mjnRLfyPrkGG0c8nOeK+kJIDkEtNUNV3WRVrltesRGogMM8n9LZZiTNAsBgDxJPG11miJYBOV9xcQ9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739592606; c=relaxed/simple;
	bh=LJZMF0aZywRhKgSWU/ga3sEDKOvwvf/x77PILRG7Tps=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hy1qVXbxlo17roFpk4DqC0oreRLYzKWyxnqQvdLUwLuVd9vBjqlpGjShFX7pG2txVSE/qOpsv2vjFMuoGzKvF5faAL+zaqu7Ca0abnhAEDO3m3/4YaJS/YzIxC+RcVZz5sAfElx/rgzQVF49OksaJq58bWibPe1Pgsht/UedLf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sGe8MdaN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1991C4CEE4;
	Sat, 15 Feb 2025 04:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739592604;
	bh=LJZMF0aZywRhKgSWU/ga3sEDKOvwvf/x77PILRG7Tps=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sGe8MdaNo4Yl4G9CM/O+MLilWQ+LYsyH2agniyBbh531ZqVIJDwxpP0IfwHdeoERz
	 o4+2afXD+6MJHjBRNh1kCxMWgzgjo6/lMbVf/WUr0/cok1/m4wT1JM6ltv8kB5RDf5
	 3hmQ6VIzcsytTs6SvpO991+PfR/VhLdg5lmdqGqXZOgSI5o38++TuzInQ3165htCuu
	 1IkpJRIgpC8CZku6rpfEO3jbu6VgcZYlAEry4NZwymImTG8R7k5JHHKLqoyjvpGa1g
	 oF1EtU7bvvLPYUgAfY0ZqUJRd4Lrvd76HRFqx+CoCL0bjU3inO60lmb2Gktays5g51
	 aTnqQOjviAFRw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 712CB380CEE9;
	Sat, 15 Feb 2025 04:10:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/2] libbpf: fix LDX/STX/ST CO-RE relocation size
 adjustment logic
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173959263404.2192280.1463303594074991492.git-patchwork-notify@kernel.org>
Date: Sat, 15 Feb 2025 04:10:34 +0000
References: <20250207014809.1573841-1-andrii@kernel.org>
In-Reply-To: <20250207014809.1573841-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com, emil@etsalapatis.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu,  6 Feb 2025 17:48:08 -0800 you wrote:
> Libbpf has a somewhat obscure feature of automatically adjusting the
> "size" of LDX/STX/ST instruction (memory store and load instructions),
> based on originally recorded access size (u8, u16, u32, or u64) and the
> actual size of the field on target kernel. This is meant to facilitate
> using BPF CO-RE on 32-bit architectures (pointers are always 64-bit in
> BPF, but host kernel's BTF will have it as 32-bit type), as well as
> generally supporting safe type changes (unsigned integer type changes
> can be transparently "relocated").
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] libbpf: fix LDX/STX/ST CO-RE relocation size adjustment logic
    https://git.kernel.org/bpf/bpf-next/c/06096d19ee38
  - [bpf-next,2/2] selftests/bpf: add test for LDX/STX/ST relocations over array field
    https://git.kernel.org/bpf/bpf-next/c/4eb93fea5919

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



