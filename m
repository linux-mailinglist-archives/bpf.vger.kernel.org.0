Return-Path: <bpf+bounces-33284-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DC891AE85
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 19:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88DE3282582
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 17:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B90919B580;
	Thu, 27 Jun 2024 17:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QHV9svyz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAE919AA52;
	Thu, 27 Jun 2024 17:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719510656; cv=none; b=KJduMup4fsBmBZmS1ljvvcMSPr8URfJKZNpFW+NPyq+0Z7Ovf9d58gJleSTCflZWNKYhK47tQ6isJdnhmv8C0HJmrLkVsIW3e/j7eBiidM71qLUmDv40vkX23zg1HOMDe1XXBDq8iWpvkSBeR0xN4WvT937Z8BLJ07WJPDOBQ/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719510656; c=relaxed/simple;
	bh=1xNe1u/aXvULtcQUTH3SvYXu4kNm78KffnqOzZDJdnw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SE/cIlJH5q63hAn9i7tcTmszZYrZZf8gAqN41y3WHRra7XeA4BLR2JvwykkzbI3sbhHa+OkB6JvVNpegg7KnB95l7IpFlsXOc8sqJ7SWSuK1Zcjb/mvkWgj6Tw7lweg3+R9k4KfEWUwNTgGwgECfvvR3v//zPgcbmBgdwvVVUrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QHV9svyz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 771DEC4AF09;
	Thu, 27 Jun 2024 17:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719510656;
	bh=1xNe1u/aXvULtcQUTH3SvYXu4kNm78KffnqOzZDJdnw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QHV9svyzahf3yrCqi8QXPqwP7zRiUAZbQFiqWK8HM/+ZV9P16PfYVUDWyJ7BUNJ7b
	 IbAR+uVQMHlr1anDnrYhx1vGkb0K9rZRcHJLmboDNT6J17AW9gvgcWSkbSkZ+Wc0vu
	 VTuKgfjLl5SRafkJYXPGUuRzRGJ43fxoKmwxAcv0GGSFITi6Gxrbc94V+qEOunslE5
	 oxPXyrYrtXAbxGSeD2r1RKaHo647/dnOgSIVyIbt/MzYtXbToM6G8yPuM4j9n4TRyx
	 me3AjXcPr6MZOpX0BzgGjHQOAjVpmah+oiu0JL55XjAYJw/H3d9xHxngGU9L8Z+BGn
	 V/EQlZlQfCwIA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 52547C43443;
	Thu, 27 Jun 2024 17:50:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/7] riscv: Various text patching improvements
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171951065633.6762.12967635589292912560.git-patchwork-notify@kernel.org>
Date: Thu, 27 Jun 2024 17:50:56 +0000
References: <20240327160520.791322-1-samuel.holland@sifive.com>
In-Reply-To: <20240327160520.791322-1-samuel.holland@sifive.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: linux-riscv@lists.infradead.org, palmer@dabbelt.com, bjorn@rivosinc.com,
 linux-kernel@vger.kernel.org, ardb@kernel.org, daniel@iogearbox.net,
 jbaron@akamai.com, jpoimboe@kernel.org, peterz@infradead.org,
 rostedt@goodmis.org, bpf@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed, 27 Mar 2024 09:04:39 -0700 you wrote:
> Here are a few changes to minimize calls to stop_machine() and
> flush_icache_*() in the various text patching functions, as well as
> to simplify the code.
> 
> This series is based on "[PATCH v3 0/2] riscv: fix patching with IPI"[1].
> 
> [1]: https://lore.kernel.org/linux-riscv/20240229121056.203419-1-alexghiti@rivosinc.com/
> 
> [...]

Here is the summary with links:
  - [v2,1/7] riscv: jump_label: Batch icache maintenance
    https://git.kernel.org/riscv/c/652b56b18439
  - [v2,2/7] riscv: jump_label: Simplify assembly syntax
    https://git.kernel.org/riscv/c/2aa30d19cfbb
  - [v2,3/7] riscv: kprobes: Use patch_text_nosync() for insn slots
    https://git.kernel.org/riscv/c/b1756750a397
  - [v2,4/7] riscv: Simplify text patching loops
    https://git.kernel.org/riscv/c/5080ca0fe9b5
  - [v2,5/7] riscv: Pass patch_text() the length in bytes
    https://git.kernel.org/riscv/c/51781ce8f448
  - [v2,6/7] riscv: Use offset_in_page() in text patching functions
    https://git.kernel.org/riscv/c/eaee54875630
  - [v2,7/7] riscv: Remove extra variable in patch_text_nosync()
    https://git.kernel.org/riscv/c/47742484ee16

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



