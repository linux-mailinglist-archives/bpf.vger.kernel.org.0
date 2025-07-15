Return-Path: <bpf+bounces-63373-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC831B068D2
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 23:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D5BB564F37
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 21:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6663F27511F;
	Tue, 15 Jul 2025 21:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omISNenc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AE826AD9
	for <bpf@vger.kernel.org>; Tue, 15 Jul 2025 21:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752616187; cv=none; b=Y3FsA5/p7gdFKKFh/CZxgoUwd50zSojmSRIR8BEKAVcQGifj2t0snRB2ANkObzLNy88O8nVsa14LSBikblgUCU6Xo3+wdeZaEg/8TRpbiE/ssplNpSpl6BDdh7sz4KgG+LFfLjNaBDRNCpCApFEAYJfD73r2EiX7wE1+7s84xpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752616187; c=relaxed/simple;
	bh=k6R7rWpg24vuoniXTBFyXeojGDUsGPI6fLu3PyAXjhs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j55bXzjc/6Go/dg72H6GIXS/92WtyTpkAqdDrGmDf1VPvfN+jMuv4+CjoawKSLHEokKTwdX/L/GWLSL/VKCUfIxQtsxg0n2Lk4aH8PCbMrBU+N9vEAbGYKbdL8l8ncJtuXKtaxgVFXOB+OXzdj0l2B6JHXHkE7Cz0HKTGyAnxVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omISNenc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69AC6C4CEE3;
	Tue, 15 Jul 2025 21:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752616186;
	bh=k6R7rWpg24vuoniXTBFyXeojGDUsGPI6fLu3PyAXjhs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=omISNenc79QHR+jzRMk3AGNBEcjpXdXtlHDSStyObWx2MWk+WD2H/JIRBjdYcnriA
	 /QIxu1AbiXTdiUvFnzpzrQKbho4Bk4AB3V4RmbPb6CJ6L9gB9eHDexzXGSYmWGTEfW
	 dYs09HibGNBFOEEkA0yRcfuf1VfxOUFs3BbYVG4j0nnItDBmrnWzXXstEx/ZsEvMpn
	 Ueotm4xlVmr9XTdOPCP9etJxukDtqFY0r2ZFQzUHh59nZie3+PTDwvw0zBTN25opbV
	 WWTmMas3A/DpMftH1+V7UXVIevS0Sly27dLI3rXj44dMtHIiX9Nzs86RliDmyMm8T5
	 FwOo9GgnanTdA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D5F383BA30;
	Tue, 15 Jul 2025 21:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix build error due to certain
 uninitialized variables
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175261620676.591886.12198265090549711186.git-patchwork-notify@kernel.org>
Date: Tue, 15 Jul 2025 21:50:06 +0000
References: <20250715185910.3659447-1-yonghong.song@linux.dev>
In-Reply-To: <20250715185910.3659447-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 15 Jul 2025 11:59:10 -0700 you wrote:
> With the latest llvm21 compiler, I hit several errors when building bpf
> selftests. Some of errors look like below:
> 
>   test_maps.c:565:40: error: variable 'val' is uninitialized when passed as a
>       const pointer argument here [-Werror,-Wuninitialized-const-pointer]
>     565 |         assert(bpf_map_update_elem(fd, NULL, &val, 0) < 0 &&
>         |                                               ^~~
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Fix build error due to certain uninitialized variables
    https://git.kernel.org/bpf/bpf-next/c/e860a98c8aeb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



