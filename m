Return-Path: <bpf+bounces-63781-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA74B0ACC1
	for <lists+bpf@lfdr.de>; Sat, 19 Jul 2025 02:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D6C91AA7F36
	for <lists+bpf@lfdr.de>; Sat, 19 Jul 2025 00:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119E010957;
	Sat, 19 Jul 2025 00:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f45VpnpN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE062F56
	for <bpf@vger.kernel.org>; Sat, 19 Jul 2025 00:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752884387; cv=none; b=M9uVePI5HIKIi2BjPW4ieBYPFFdWrIIcLeE+P3V+TLLobd0FVFvAfng4A9JhiXo6QgrvfxnC941VZbaPghNYMHd4fXz1vfT0D3SKTIKRozQMNW9DehjU4Xt8dWZWEXzXrZ2DDw0HYIR2OryBdW1U6JcpDQ7NiP+uSyie+tbjHd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752884387; c=relaxed/simple;
	bh=9KT/PaeZIf84esHkoiXZhb2SUJOBKn0afvPZyCCDp7E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eVtpFgS/SNC/SdOZU4+D1B2AFJ1aJJOrgMC5d6v4u+wbOX31N2WS1dQZwSgL9NADeCyMyDIjr8BXGWBgg6kspgjY7SRrTTMj49UCeRHXBhBKkcUM4nXQz8awKsK+4CN4sIPRBGjwnVgn9N3c3bEsDKotyz1ERkw9uxGWPG5xUhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f45VpnpN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29814C4CEEB;
	Sat, 19 Jul 2025 00:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752884387;
	bh=9KT/PaeZIf84esHkoiXZhb2SUJOBKn0afvPZyCCDp7E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=f45VpnpNK+wW6XVlaUteDyrcS1x3aC1cq9gW2WmI/pxouvtUt/7Kp1eizGfDpD79j
	 1vTaUpoJGK5JKOyHQRFcPyR1EWUmtnthtp4K274RoAjQeyrWF8UrGU4VpWtvMkVcWp
	 V1xWaA1HCB32s/JjkVA4WoNulP1SB2wDkzzur510qel0/tsa0/ujvNbrEorg8IOi+d
	 q0ayDx5bAtDzyxRct3W7HATM/TwmF4cTMnWedH5gtazfHVh09dDGn26ED6sZP0ATbC
	 cxkHiesh26wAxmFNJh0xP/neavpxyN4cR/NxYf1Zr8LYcG47TLVova+zmI0AnNVnjp
	 O38xiq/WoAyQw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF85383BA3C;
	Sat, 19 Jul 2025 00:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1] libbpf: verify that arena map exists when
 adding
 arena relocations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175288440676.2833543.4513886583027683839.git-patchwork-notify@kernel.org>
Date: Sat, 19 Jul 2025 00:20:06 +0000
References: <20250718222059.281526-1-eddyz87@gmail.com>
In-Reply-To: <20250718222059.281526-1-eddyz87@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 18 Jul 2025 15:20:59 -0700 you wrote:
> Fuzzer reported a memory access error in bpf_program__record_reloc()
> that happens when:
> - ".addr_space.1" section exists
> - there is a relocation referencing this section
> - there are no arena maps defined in BTF.
> 
> Sanity checks for maps existence are already present in
> bpf_program__record_reloc(), hence this commit adds another one.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1] libbpf: verify that arena map exists when adding arena relocations
    https://git.kernel.org/bpf/bpf-next/c/42be23e8f2dc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



