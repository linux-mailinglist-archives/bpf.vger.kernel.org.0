Return-Path: <bpf+bounces-38717-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4003F968C0B
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 18:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8B421F232BE
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 16:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A52185B4C;
	Mon,  2 Sep 2024 16:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XzKagCFc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E08838DC0
	for <bpf@vger.kernel.org>; Mon,  2 Sep 2024 16:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725294629; cv=none; b=UBGsxwTed1MAQGjGbmv6KtSIxDsRUEE+qU1udN8nSX5l1LMVmjyIfuhR3mn+SdQG0P16r4NOmg0KJuhLRjtWYWos3Avko2HkePdc5KRpbhR6GdpkHX193emwt3WkluKlASpGzKLQIhyfqv9RfH0IrNwiA36UbALkn4+UA4UIjSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725294629; c=relaxed/simple;
	bh=vadKofD6B0JIX18Ux6/InUHMmh/9lyK2uU06GjEK23g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LA2FsNR0fFaAwi6QC9KaC34b5ikcRZkkgjp6quLkOdBW5Zr+ruFGqi6MuctbCk/WUvbwjLepO1h+X5prlsjZYWNPn0fYrm29/I4BiBmFJlZClpmK6xmKlcRZfcTsKQxY7/qB2vaZXocUEKfsgd1O2c5Fi92zDb0jYTAzLiRcT3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XzKagCFc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE779C4CEC2;
	Mon,  2 Sep 2024 16:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725294628;
	bh=vadKofD6B0JIX18Ux6/InUHMmh/9lyK2uU06GjEK23g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XzKagCFcC2ER5UU7to2AQzubcXpimAkXga5oOrUaT5zvvE4MiznR1QayEbKGdeRD8
	 h/g9GIRrhH1Arl8yWwnbKDzx1oCXcOWJTVr6BH0/ilSunVhsL6MEOz9GoXnESuuN9M
	 lIes/BnvDSeISVC7jG9wcFxAIQjW4jera4GVQWWhwc80RNSygznos16Ujgb1Zf4Ff4
	 FaAm/LROYa8C2z44MAgwjXfBWxJ9tjLzbO10X8YQAhaw+r9e9rLef2Jnhd7ubhZrdH
	 JzxySUcMDsFym7QHmmcUm5lATlJ+YZ4nvpuxFwbOmjGPoTzhMgrH6vK/GG+PL4GErW
	 cQIgQqnq/LuTw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF613805D82;
	Mon,  2 Sep 2024 16:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpftool: Add missing blank lines in bpftool-net doc
 example
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172529462950.3935899.5396247121344260485.git-patchwork-notify@kernel.org>
Date: Mon, 02 Sep 2024 16:30:29 +0000
References: <20240901210742.25758-1-qmo@kernel.org>
In-Reply-To: <20240901210742.25758-1-qmo@kernel.org>
To: Quentin Monnet <qmo@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Sun,  1 Sep 2024 22:07:42 +0100 you wrote:
> In bpftool-net documentation, two blank lines are missing in a
> recently added example, causing docutils to complain:
> 
>     $ cd tools/bpf/bpftool
>     $ make doc
>       DESCEND Documentation
>       GEN     bpftool-btf.8
>       GEN     bpftool-cgroup.8
>       GEN     bpftool-feature.8
>       GEN     bpftool-gen.8
>       GEN     bpftool-iter.8
>       GEN     bpftool-link.8
>       GEN     bpftool-map.8
>       GEN     bpftool-net.8
>     <stdin>:189: (INFO/1) Possible incomplete section title.
>     Treating the overline as ordinary text because it's so short.
>     <stdin>:192: (INFO/1) Blank line missing before literal block (after the "::")? Interpreted as a definition list item.
>     <stdin>:199: (INFO/1) Possible incomplete section title.
>     Treating the overline as ordinary text because it's so short.
>     <stdin>:201: (INFO/1) Blank line missing before literal block (after the "::")? Interpreted as a definition list item.
>       GEN     bpftool-perf.8
>       GEN     bpftool-prog.8
>       GEN     bpftool.8
>       GEN     bpftool-struct_ops.8
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpftool: Add missing blank lines in bpftool-net doc example
    https://git.kernel.org/bpf/bpf-next/c/5d2784e25d7a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



