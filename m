Return-Path: <bpf+bounces-35469-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE9593ABB8
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 06:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55B17284826
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 04:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093891C6B4;
	Wed, 24 Jul 2024 04:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iP2+STic"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B79C10F4
	for <bpf@vger.kernel.org>; Wed, 24 Jul 2024 04:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721793645; cv=none; b=llxk2v9fScQEN0jYmm0OsvojQGdHRsu5CHRGMC27WL9nKzU7w4zYJ3xi5OZiruar3pWcwd0v8I4gWQLBlkZOHP1wXpo/L/LXA5nuuS114EDHk1EDXJXK+PE+9BfI9ygW0zXDAYAKszQcgprQCskdk1AzDSPR6fHR4Q4rQyASJ3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721793645; c=relaxed/simple;
	bh=koE57bKXyi3FSQZG0hWKd4XEVS6t/Z2VTZvvKK1jvvY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Pb5GMeBCOIFXjwQ4X2quz5DZQUKvg6mzV/7626TVQIRcKQ7zDLieaePpFwMNj44PiMq7UNsBUTXNwr/5GoIz+JX8BPXWn2h2+mpfc1EnoVyXIPgeeDrS+d+qbQxTffL1jEaMuvquwCILSDgjvyCAVn/CvdwU4HJ7v+cdlF0jKxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iP2+STic; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DCFE9C4AF0B;
	Wed, 24 Jul 2024 04:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721793644;
	bh=koE57bKXyi3FSQZG0hWKd4XEVS6t/Z2VTZvvKK1jvvY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iP2+STicbdsu2hY9edMBd7uXbK2fbKWU2AM3+1UPVBoJOd1xyLy8p3GX+OkxFtB/B
	 QLrtzl5QT9kWqANYDMCO6QRsN3PId25yi4cD/kKyxkzijERnUQPG9N4THiWlBrY3et
	 GplhkD+Yr+4sfh37HHgUT8SDV+k+M30jsUZVRZyh/cLC7YTPAN0ucnHB4ESJ/Ggkoe
	 o8g/9DlsYPfvgM3BMh7NRDuR+1wBvkXU9goZZhofrDm1yc4AzudTLwMtSQbmBHxGJc
	 WZ1GXTKPYOLK4xQ5L7fw7FEDMOAhUZsUL70WIGqMw41xEvWP2f5e525I9DdxbRpia5
	 voHYdngeLFGkA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CA32BC43338;
	Wed, 24 Jul 2024 04:00:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 00/10] no_caller_saved_registers attribute for
 helper calls
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172179364482.1919.9590705031832457529.git-patchwork-notify@kernel.org>
Date: Wed, 24 Jul 2024 04:00:44 +0000
References: <20240722233844.1406874-1-eddyz87@gmail.com>
In-Reply-To: <20240722233844.1406874-1-eddyz87@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, jose.marchesi@oracle.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 22 Jul 2024 16:38:34 -0700 you wrote:
> This patch-set seeks to allow using no_caller_saved_registers gcc/clang
> attribute with some BPF helper functions (and kfuncs in the future).
> 
> As documented in [1], this attribute means that function scratches
> only some of the caller saved registers defined by ABI.
> For BPF the set of such registers could be defined as follows:
> - R0 is scratched only if function is non-void;
> - R1-R5 are scratched only if corresponding parameter type is defined
>   in the function prototype.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,01/10] bpf: add a get_helper_proto() utility function
    https://git.kernel.org/bpf/bpf-next/c/19b0934f0b13
  - [bpf-next,v4,02/10] bpf: no_caller_saved_registers attribute for helper calls
    https://git.kernel.org/bpf/bpf-next/c/c473f709550f
  - [bpf-next,v4,03/10] bpf, x86, riscv, arm: no_caller_saved_registers for bpf_get_smp_processor_id()
    https://git.kernel.org/bpf/bpf-next/c/a5a0f95ba4e9
  - [bpf-next,v4,04/10] selftests/bpf: extract utility function for BPF disassembly
    https://git.kernel.org/bpf/bpf-next/c/67b1c158c54e
  - [bpf-next,v4,05/10] selftests/bpf: print correct offset for pseudo calls in disasm_insn()
    https://git.kernel.org/bpf/bpf-next/c/9f3e5a694b03
  - [bpf-next,v4,06/10] selftests/bpf: no need to track next_match_pos in struct test_loader
    https://git.kernel.org/bpf/bpf-next/c/0bbaa40df698
  - [bpf-next,v4,07/10] selftests/bpf: extract test_loader->expect_msgs as a data structure
    https://git.kernel.org/bpf/bpf-next/c/a70c32d65ec7
  - [bpf-next,v4,08/10] selftests/bpf: allow checking xlated programs in verifier_* tests
    https://git.kernel.org/bpf/bpf-next/c/69c992268830
  - [bpf-next,v4,09/10] selftests/bpf: __arch_* macro to limit test cases to specific archs
    https://git.kernel.org/bpf/bpf-next/c/c64d2f72bf2e
  - [bpf-next,v4,10/10] selftests/bpf: test no_caller_saved_registers spill/fill removal
    https://git.kernel.org/bpf/bpf-next/c/2daa48f6e400

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



