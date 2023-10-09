Return-Path: <bpf+bounces-11714-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6224F7BDF7C
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 15:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 857F91C20B23
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 13:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1071731A8D;
	Mon,  9 Oct 2023 13:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXDAW8bq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7A49CA51;
	Mon,  9 Oct 2023 13:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1135BC433CB;
	Mon,  9 Oct 2023 13:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696858226;
	bh=C39SPpzW99vurbXbnnvIqZlQvyv6UcGtJqYlt3AsiaU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KXDAW8bqXCIGms7jk5QAOFHZd2FZbviViTXgR5WMHGGl8Qxd5MXTHhJGS+27kOzC2
	 vXuPUOi3QVwJWRBH87coO+uUp8ifGFD4thAJoTtyxwxck3Bgg+mwPR1YB35rPl7C/5
	 ypRUmyLRSuwc4CWpa7XVXIQWrVsr03NMXAcXA6Tja6liZGY2BDou003VnYJd6FMnvx
	 Qd+tmyXnPR5oB36DVJqOVqi4+P/pg4QEoYnMpgjW0e/xrV8LAznH+c1kf48cC8xgyd
	 TvxBmz/OB7BeZUwCdUksPIw+wvpSjV6CSyn9lYh94ocSq30j4VsWlpslNzE8hThmf0
	 ruAWACqdmhm0Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E7E12E11F46;
	Mon,  9 Oct 2023 13:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 0/2] riscv, bpf: Properly sign-extend return values
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169685822594.15728.14523871698572342357.git-patchwork-notify@kernel.org>
Date: Mon, 09 Oct 2023 13:30:25 +0000
References: <20231004120706.52848-1-bjorn@kernel.org>
In-Reply-To: <20231004120706.52848-1-bjorn@kernel.org>
To: =?utf-8?b?QmrDtnJuIFTDtnBlbCA8Ympvcm5Aa2VybmVsLm9yZz4=?=@codeaurora.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org, pulehui@huawei.com,
 bjorn@rivosinc.com, linux-kernel@vger.kernel.org, luke.r.nels@gmail.com,
 xi.wang@gmail.com, linux-riscv@lists.infradead.org

Hello:

This series was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed,  4 Oct 2023 14:07:04 +0200 you wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> The RISC-V architecture does not expose sub-registers, and hold all
> 32-bit values in a sign-extended format [1] [2]:
> 
>   | The compiler and calling convention maintain an invariant that all
>   | 32-bit values are held in a sign-extended format in 64-bit
>   | registers. Even 32-bit unsigned integers extend bit 31 into bits
>   | 63 through 32. Consequently, conversion between unsigned and
>   | signed 32-bit integers is a no-op, as is conversion from a signed
>   | 32-bit integer to a signed 64-bit integer.
> 
> [...]

Here is the summary with links:
  - [bpf,1/2] riscv, bpf: Sign-extend return values
    https://git.kernel.org/bpf/bpf/c/2f1b0d3d7331
  - [bpf,2/2] riscv, bpf: Track both a0 (RISC-V ABI) and a5 (BPF) return values
    https://git.kernel.org/bpf/bpf/c/7112cd26e606

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



