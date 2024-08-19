Return-Path: <bpf+bounces-37558-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82465957812
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 00:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A670B227EC
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 22:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC091DD3A9;
	Mon, 19 Aug 2024 22:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRCxJ6cP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE873159565
	for <bpf@vger.kernel.org>; Mon, 19 Aug 2024 22:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724107831; cv=none; b=QXnBxDsblOShneyiyYUbM5qPNGMCFO2pCNn+qmc1YTkNLlz++LApwJ4RBBgBhHyhWyJsiElMhTk7dApeEs+eq6y2h9+rma6y1F68FDUDCh89LgiD3TJAkWVCZZNPhDowxhxEvvnVv9cKuiD6GeC17BGP2jh0E+22Op10u1CZKMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724107831; c=relaxed/simple;
	bh=CoG5ztsptPOKKhyiEG8ajgMkJZFZMQCT5SLzPOONeGg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tjsZ5IiE3Q4pnO70kIyCOd8l3ezjQKKnY5kpXKpTRcrdj8dldgPG1ThE98wm3YCnJQoJycV1jE8an1PClyEL4Rect4Yf2AE01q0iGd/ngDlocIDhzrlukNDZqj6+U3UpHY5F1WuEW9Z2CuebcMgGGJ2mwUnjDTWxfJClyKcODJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRCxJ6cP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ADF7C32782;
	Mon, 19 Aug 2024 22:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724107831;
	bh=CoG5ztsptPOKKhyiEG8ajgMkJZFZMQCT5SLzPOONeGg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DRCxJ6cPwYI8q4SFzgwvjhD/NUzg1w74NYsJl3UPTamPCHrcOHCFeOsmyfg2ZqCXa
	 vQw03WPkKbeskpNBoBI9FsD5wmAibxeOQ6j+h/uKFuknwXnNA8zUX62BOATRGRzVZb
	 rZv6omsBg1/Ryv6IE1Zcs7bNCX+P5eGE1t6brzyx5zvUuj6KGtASosd2Dvpkpo5njY
	 FWgIxaDKZf+lTGoiX/lOGv6E02K1xK4uIJkYAr1tmdtQw2VVH+OWcQrIyJ0t50hTON
	 rM6n18RX6r9H+wgvadICMaW0mYyQ/RzoQNJ7dUGlP2kZyrNEFcYSFMLEJ0WgdkvUmU
	 fmzjaV8ELsNKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD4A3823271;
	Mon, 19 Aug 2024 22:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/3] Correct recent GCC incompatible changes.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172410783077.676416.18219377490611454639.git-patchwork-notify@kernel.org>
Date: Mon, 19 Aug 2024 22:50:30 +0000
References: <20240819151129.1366484-1-cupertino.miranda@oracle.com>
In-Reply-To: <20240819151129.1366484-1-cupertino.miranda@oracle.com>
To: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 19 Aug 2024 16:11:26 +0100 you wrote:
> Hi everyone,
> 
> Apologies for the previous patches which did not include a cover letter.
> My wish was to send 3 indepepdent patches but after the initial mistake lets keep
> this as a series although they are all independent from themselves.
> 
> The changes in this patch series is related to recovering GCC support to
> build the selftests.
> A few tests and a makefile change have broken the support for GCC in the
> last few months.
> 
> [...]

Here is the summary with links:
  - [1/3] selftests/bpf: Disable strict aliasing for verifier_nocsr.c
    https://git.kernel.org/bpf/bpf-next/c/2aa93695081d
  - [2/3] selftest/bpf: _GNU_SOURCE redefined in g++
    (no matching commit)
  - [3/3] selftest/bpf: Adapt inline asm operand constraint for GCC support
    https://git.kernel.org/bpf/bpf-next/c/d9075ac631ce

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



