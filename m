Return-Path: <bpf+bounces-29101-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C901F8C026E
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 19:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05FC11C223B3
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 17:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5920DF5C;
	Wed,  8 May 2024 17:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BILyaDRM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2E946B5
	for <bpf@vger.kernel.org>; Wed,  8 May 2024 17:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715187631; cv=none; b=eE2PfyouDQcdfsG/LXjz2gllyiGEcwL61PEXPEuacDEsEcHWz7xnKWThtG+BxywTc2i0VyA36TyHCDDlqm8GPlwYzYxEwgAEtxoUXwEzZRslLmn+TcRlIbSz3iH5QkLwqwutXHmb0a+30BFwfPRTNLC/pXTRp+GcDw/Wj6G8ObM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715187631; c=relaxed/simple;
	bh=jkc0U2Apkfu7GaJ1EHF0AlqEZ66jeDrNhHVB4Wmw9H0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MtvjuqaUQx8ftcz0+P0AndP1ewsna+bBeNH4zbs5+al9YjJZ86ziDXz5NICRkclxSzUTS5fSFBN1urJp7jdOzeGMZn0bG6Gbal+CN1ynj643HjQt+E+pvW6Ps6yUMjqk6Qxky1rC0m34t7u/JKe6T9SrQDOyxev26dJSbeED7wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BILyaDRM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6D34C4AF07;
	Wed,  8 May 2024 17:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715187630;
	bh=jkc0U2Apkfu7GaJ1EHF0AlqEZ66jeDrNhHVB4Wmw9H0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BILyaDRMp/wcCgb+n9WfKNkLbSp09NRSGxr/DOwZvo9qOao4NHbfzHdVhAHgZWRCo
	 Fwj0kcZNuLfg3cCH7XrrFKRe6RPlk+FRCxfS7wGPvc1/VwCnvekhvuPqAYSjI7eE1m
	 UagNB5eyXpSDdWQlyGF7ebf19sgWK3AhMzUu4Er73ppfx+R4FbMVREoOZuCcKOZEBd
	 aZErc11+18LUzCSBIHe/6HbG7pyoRhroFEyd49ifXGZL78eOwQUJSEZbdQBtEvy0kY
	 nt5MpDmxQZdrpuEO6aP0Wlb+JA5RdPIoNWS+6vCJ7FIsqBvC9X9nv/+WpkC2dIfpsP
	 co6EPI9dTmsKg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D184EC43332;
	Wed,  8 May 2024 17:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next V3] bpf: avoid UB in usages of the __imm_insn macro
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171518763085.20768.9178276784469181139.git-patchwork-notify@kernel.org>
Date: Wed, 08 May 2024 17:00:30 +0000
References: <20240508103551.14955-1-jose.marchesi@oracle.com>
In-Reply-To: <20240508103551.14955-1-jose.marchesi@oracle.com>
To: Jose E. Marchesi <jose.marchesi@oracle.com>
Cc: bpf@vger.kernel.org, david.faust@oracle.com, cupertino.miranda@oracle.com,
 yonghong.song@linux.dev, eddyz87@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  8 May 2024 12:35:51 +0200 you wrote:
> [Changes from V2:
>  - no-strict-aliasing is only applied when building with GCC.
>  - cpumask_failure.c is excluded, as it doesn't use __imm_insn.]
> 
> The __imm_insn macro is defined in bpf_misc.h as:
> 
>   #define __imm_insn(name, expr) [name]"i"(*(long *)&(expr))
> 
> [...]

Here is the summary with links:
  - [bpf-next,V3] bpf: avoid UB in usages of the __imm_insn macro
    https://git.kernel.org/bpf/bpf-next/c/1209a523f691

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



