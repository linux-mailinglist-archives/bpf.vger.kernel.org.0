Return-Path: <bpf+bounces-71291-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A597BBEDDCB
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 04:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23DA118A1228
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 02:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83EA81F1517;
	Sun, 19 Oct 2025 02:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ROd8h9dW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3210354AE8;
	Sun, 19 Oct 2025 02:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760841036; cv=none; b=e7Xi3mgQxPeiiSvuCq9WiS4C8jB5jfgHgL01eCk5aSoFLDqcdl+l/Fo/Dcxp7aEeI2zeHbkTjXNezRrOFXJge+Xa7saRfIOBo+ELq1quOKwA8QKoecFdlCUMAVNzlbRE5VhMZ0oK3WS/Z0BISQiHRQLShzK5X40dgWjjSMbKbAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760841036; c=relaxed/simple;
	bh=5Uy1uuUJE/gVOnrS2Z8GCA6zmbtPIqgYn8HaGyfzvBA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WDMlOWVeeZCAS43yYvzieTcoawDGSlH+aAluMKQioaXpuMoL1lFC73xYYcdxzRR6t5iEPEOavEvn8bl/LHtxBusS7WlZzZZB6WELWOg0bpqxBBQOnJ7zkkoSru/pnDG1D4sqBcpldU1X8Wm9W9LBBzZ6lgFnxw5VjMFRbmClN4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ROd8h9dW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AD45C4CEF8;
	Sun, 19 Oct 2025 02:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760841035;
	bh=5Uy1uuUJE/gVOnrS2Z8GCA6zmbtPIqgYn8HaGyfzvBA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ROd8h9dWIB/T0aFpfI882NBlmfJ3H4uuzD2f9rLZOTMus7O4UYhd0jaHYmjVfjeNT
	 L00Zpzyv2wel+V4bft8O7Br8AsscU75HHMghJBTYcRtEI/QOADqijK8xiRHxBD1Cc1
	 BIFJcohn5QTWwLaj8mGrkycclJmbE4k9taaGBE3ruqupcP17DOpr0Xw9efHLRjod2y
	 gJnJN25RYmeuAgGUp0u+aL8hUPahT3RMt7YVaB4JNUhBnnlZlAaPOMYeUVrA9yBebw
	 /lOClm3tKpKAQhBo/Tq75mxtdGVrDrrUfrYlIcNkXbbX10Omg1lPMB70C0P9bY1fSh
	 Exa33QbvPL+4g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF4939EFBBF;
	Sun, 19 Oct 2025 02:30:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2] selftests/bpf: Fix set but not used build errors
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176084101825.3155740.15331784475261731465.git-patchwork-notify@kernel.org>
Date: Sun, 19 Oct 2025 02:30:18 +0000
References: <20251018082815.20622-1-yangtiezhu@loongson.cn>
In-Reply-To: <20251018082815.20622-1-yangtiezhu@loongson.cn>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 18 Oct 2025 16:28:15 +0800 you wrote:
> There are some set but not used build errors when compiling bpf selftests
> with the latest upstream mainline GCC, at the beginning add the attribute
> __maybe_unused for the variables, but it is better to just add the option
> -Wno-unused-but-set-variable to CFLAGS in Makefile to disable the errors
> instead of hacking the tests.
> 
>   tools/testing/selftests/bpf/map_tests/lpm_trie_map_basic_ops.c:229:36:
>   error: variable ‘n_matches_after_delete’ set but not used [-Werror=unused-but-set-variable=]
> 
> [...]

Here is the summary with links:
  - [bpf,v2] selftests/bpf: Fix set but not used build errors
    https://git.kernel.org/bpf/bpf-next/c/c67f4ae73798

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



