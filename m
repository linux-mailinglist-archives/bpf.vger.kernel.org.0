Return-Path: <bpf+bounces-34160-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B3E92AC19
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 00:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D72E71C203AA
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 22:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E039415219B;
	Mon,  8 Jul 2024 22:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbiHnF5M"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DC650276;
	Mon,  8 Jul 2024 22:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720477833; cv=none; b=V0yHpbTzHYK+N/XaSkVDTaa3ffT0lpXoH4f+ovzEHDLsM5BpERf9GA5dv/IZqYWX5kA7qOFP9nao4zRrw1/rjZt4VSYUYkVY4/x70lCLJ0EEX3HH73rV2g09UKNlQIen5gdQRqapmvqEuKp7qt9m/SRTzNFpsvXT9iZqtYaHLKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720477833; c=relaxed/simple;
	bh=Lt1sPnBmBELsxeDwYg9NblzD+5zoh0qpCKcy/lGokGo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Nz0p55cEr2dbs6on/2TYcHHUN8CIS8Kt4ApPJGNEGfrwBg8342IEBUBDg1lcQZXsyA/XOIjYo9z/awGf3xrqQVgQflSnvZD9Wahk1SgCYFwhOAVGiVc74fk71zXQN5SAwFGM1kA42b+30EcVweJ8Ze21wjC5CPvWtEa3ZXvvPY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbiHnF5M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3600CC3277B;
	Mon,  8 Jul 2024 22:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720477833;
	bh=Lt1sPnBmBELsxeDwYg9NblzD+5zoh0qpCKcy/lGokGo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WbiHnF5MJGf/4AW4uj+5O3RA+/aRDm2Z18XoYGkLvd4IC4blff6UVZPCTJaNY6mrx
	 D5Uu1KpLLahxs7K3l2noBx7Bkv+h21lujZZuVkoFb68gIeBXFsDAsd2Ph6V6kNdqWN
	 BynFPbND/PeNZ9PBgcT4RaCqVuI1PPPareRwjA7CNu4zbDiT/xst0zU9NH9yxGPfO2
	 KV+wZuTuvIiAFKIUHFFdeZ/eP+HQOi+v1W/xqDrPvAqG0QWKiNgDa+2dx65b65iGzq
	 PFpXkfMAD+sCh3RyeFwTrjhq4JE4QRjokd5npuC9mB7DlkIRWP20fS2zxetZYuF2qo
	 OAk6uJ3LfIkGQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2205DDF3714;
	Mon,  8 Jul 2024 22:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 1/2] bpf: Fix too early release of tcx_entry
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172047783313.17442.16042215164463451364.git-patchwork-notify@kernel.org>
Date: Mon, 08 Jul 2024 22:30:33 +0000
References: <20240708133130.11609-1-daniel@iogearbox.net>
In-Reply-To: <20240708133130.11609-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: martin.lau@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org,
 xten@osec.io, v4bel@theori.io, qwerty@theori.io

Hello:

This series was applied to bpf/bpf.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Mon,  8 Jul 2024 15:31:29 +0200 you wrote:
> Pedro Pinto and later independently also Hyunwoo Kim and Wongi Lee reported
> an issue that the tcx_entry can be released too early leading to a use
> after free (UAF) when an active old-style ingress or clsact qdisc with a
> shared tc block is later replaced by another ingress or clsact instance.
> 
> Essentially, the sequence to trigger the UAF (one example) can be as follows:
> 
> [...]

Here is the summary with links:
  - [bpf,1/2] bpf: Fix too early release of tcx_entry
    https://git.kernel.org/bpf/bpf/c/1cb6f0bae504
  - [bpf,2/2] selftests/bpf: Extend tcx tests to cover late tcx_entry release
    https://git.kernel.org/bpf/bpf/c/5f1d18de7918

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



