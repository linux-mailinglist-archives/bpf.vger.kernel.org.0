Return-Path: <bpf+bounces-30500-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 807728CE791
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 17:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B22691C21C44
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 15:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D2D12D741;
	Fri, 24 May 2024 15:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDkRkS3u"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF57412C550;
	Fri, 24 May 2024 15:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716563430; cv=none; b=pJhylspsfQuO8c9NswEG4kr3gvYrCoArofSzM1asooZ6425kO2jxBQSD68iQpIjEJxShDj7POxrkFhIgxqhu9ZirJc89ionz9Moc8uJOUJdJ8jR2xUWiBMfFUIrhaJbypk/ZssT4D3laQSxS9ama8I4oBVwzwi1NYK5zPcDbRDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716563430; c=relaxed/simple;
	bh=7qsZ8KN++70H6o9fyfEB2QodwleEGL1Akph4exyG+Zo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PTef972r1HoKQm+Yyro5l7kahoZfe3Y/xXj9cRQ2f6bhVB1V74WTLdA6HFyAijYRf/YOJOdGqezivoXmddFzlawFuXijSYe92MMu7EVLDOeAKKFSEQ3+u3gaJAubaCxuRbL+rtab5dSR/zStOPlB6qxZfgjtd0RWHSVjXoyo68I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDkRkS3u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71F89C32782;
	Fri, 24 May 2024 15:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716563430;
	bh=7qsZ8KN++70H6o9fyfEB2QodwleEGL1Akph4exyG+Zo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BDkRkS3uDN8twuAGNaLqAvJGKCkDBHrkDQvt2EzU/xrD2lFmz0HNwv+3dauIWCJ3v
	 itv7Ic1UJ8xXwVu41NWCOxN/NC1iFYdYvUFKfoByKwZI/Fv3KV78XS4PsmlYNtocv5
	 DeBpt1Gcx+LeZ4M+ndE+bIfEEYjP9qnBIsred9uRUAyn3jKeY+B2/kkLZpcc5B1q2D
	 q51mAGgohm+pXPobc94M+1fHkYEyhaH7GJImnKaQYDaBRHL2TKOr250Goz5PtevAlL
	 9irqUTHmJvJtUjfgcEMbolMAOyoaJPD7etvOurMLMzYOkhWmwTAN6EtLGpUvHQhQcb
	 A1jRKP+Le2Cdg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 55F11CF21F9;
	Fri, 24 May 2024 15:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/2] riscv, bpf: Introduce Zba optimization
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171656343034.3209.12321836414895669166.git-patchwork-notify@kernel.org>
Date: Fri, 24 May 2024 15:10:30 +0000
References: <20240524075543.4050464-1-xiao.w.wang@intel.com>
In-Reply-To: <20240524075543.4050464-1-xiao.w.wang@intel.com>
To: Wang@codeaurora.org, Xiao W <xiao.w.wang@intel.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 luke.r.nels@gmail.com, xi.wang@gmail.com, bjorn@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, pulehui@huawei.com,
 puranjay@kernel.org, haicheng.li@intel.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri, 24 May 2024 15:55:41 +0800 you wrote:
> The riscv Zba extension provides instructions to accelerate the generation
> of addresses that index into arrays of basic data types, bpf JIT generated
> insn counts could be reduced by leveraging Zba for address calculation.
> 
> The first patch introduces RISCV_ISA_ZBA Kconfig option and uses Zba add.uw
> insn to optimize zextw operation.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/2] riscv, bpf: Optimize zextw insn with Zba extension
    https://git.kernel.org/bpf/bpf-next/c/c12603e76ef6
  - [bpf-next,v4,2/2] riscv, bpf: Introduce shift add helper with Zba optimization
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



