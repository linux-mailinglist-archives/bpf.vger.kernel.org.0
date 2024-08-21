Return-Path: <bpf+bounces-37755-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B64E95A476
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 20:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD161B224CD
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 18:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197341494D1;
	Wed, 21 Aug 2024 18:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dEXSQs29"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9491D1B2EE2
	for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 18:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724263833; cv=none; b=ujT4bVNTUUaoGsyd3wqHbz8R0vYkM/8s2ztKXOaXe07e0tpKabk9C/jNoftP64z1C2IQ7+P/CGCBRCfdPp3kyFIK8ljwIpZgauOIEFDc8F0EJ1YaIninMWtn0cxodNjl7ogqrXY/Dlvpgu963KjvpPKbtkb+Chm5kdeVPZH76Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724263833; c=relaxed/simple;
	bh=TCSf15VchM8KavyfqkVyU6pJGOtv5lOtelKU1mT2kD0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CZB5C0Maq9m0JbNMlDdTDOYeD89rLZ9hyPSwVe3cXVg8z0NZfh8gjTKgn9lII71ajwlIrVU7KGc91SSI/QqhdmuozJ0Ru0B1g7gFe7ACTgLYeaXgFLPVpLzSSKqamo1DP1wSqQIOUU5GFoOt4tp2ENg82Bu/u0CFi6y5at/5IyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dEXSQs29; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64BE0C32781;
	Wed, 21 Aug 2024 18:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724263833;
	bh=TCSf15VchM8KavyfqkVyU6pJGOtv5lOtelKU1mT2kD0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dEXSQs29yoz8+scXSk1sMujbs9ado+zyRjR7UPs1MtdXSZeJ1Nu6sE2JY7y8hKOZP
	 SFyEWe3ds1o8ijzkgDXr0oFdFP91zkZ/kccvc3Squq/40DSzobVgWgjdjDPUXMKNXL
	 y9VuDt4rr4Hjm6X/0y8ogEItRf8yi2o9G6yx19pSL2oEI+M+h57RfUCvnelJy6jk3W
	 zk2Sx2qQ9B0gkisGvOiLAFPO0cj062Td7o3M+fuK+TUU/1TIXroSybhJAXYn+0nnG9
	 ukgR8VTXHioF4qlYTUjeJqVHXieXXGbpAucWs0M9m+eaavETvgkBYIKaEUvXIL0fOq
	 8uc9KBkS/3uFw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DD63804C86;
	Wed, 21 Aug 2024 18:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/8] __jited test tag to check disassembly after
 jit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172426383300.1797184.1251643260550153835.git-patchwork-notify@kernel.org>
Date: Wed, 21 Aug 2024 18:10:33 +0000
References: <20240820102357.3372779-1-eddyz87@gmail.com>
In-Reply-To: <20240820102357.3372779-1-eddyz87@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, hffilwlqm@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 20 Aug 2024 03:23:48 -0700 you wrote:
> Some of the logic in the BPF jits might be non-trivial.
> It might be useful to allow testing this logic by comparing
> generated native code with expected code template.
> This patch set adds a macro __jited() that could be used for
> test_loader based tests in a following manner:
> 
>     SEC("tp")
>     __arch_x86_64
>     __jited("   endbr64")
>     __jited("   nopl    (%rax,%rax)")
>     __jited("   xorq    %rax, %rax")
>     ...
>     __naked void some_test(void) { ... }
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/8] selftests/bpf: less spam in the log for message matching
    https://git.kernel.org/bpf/bpf-next/c/7d41dad105b6
  - [bpf-next,v3,2/8] selftests/bpf: correctly move 'log' upon successful match
    https://git.kernel.org/bpf/bpf-next/c/d0a29cdb6ef9
  - [bpf-next,v3,3/8] selftests/bpf: fix to avoid __msg tag de-duplication by clang
    https://git.kernel.org/bpf/bpf-next/c/f00bb757ed63
  - [bpf-next,v3,4/8] selftests/bpf: replace __regex macro with "{{...}}" patterns
    https://git.kernel.org/bpf/bpf-next/c/f8d161756d42
  - [bpf-next,v3,5/8] selftests/bpf: utility function to get program disassembly after jit
    https://git.kernel.org/bpf/bpf-next/c/b991fc520700
  - [bpf-next,v3,6/8] selftests/bpf: __jited test tag to check disassembly after jit
    https://git.kernel.org/bpf/bpf-next/c/7d743e4c759c
  - [bpf-next,v3,7/8] selftests/bpf: validate jit behaviour for tail calls
    https://git.kernel.org/bpf/bpf-next/c/e5bdd6a8be78
  - [bpf-next,v3,8/8] selftests/bpf: validate __xlated same way as __jited
    https://git.kernel.org/bpf/bpf-next/c/a038eacdbf59

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



