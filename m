Return-Path: <bpf+bounces-35142-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE4D937ECB
	for <lists+bpf@lfdr.de>; Sat, 20 Jul 2024 05:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 803292823DD
	for <lists+bpf@lfdr.de>; Sat, 20 Jul 2024 03:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5F3B64A;
	Sat, 20 Jul 2024 03:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e15wcxXD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557338F5D
	for <bpf@vger.kernel.org>; Sat, 20 Jul 2024 03:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721444432; cv=none; b=g3TMBYRidakf8dLFTNjrtcP+1UKiQKOgFOfM5D07xET6rK60W/juhT6Yjs+GX5KcEMxPckY9wAkqti0bpExLVb7atTN5C6ivWJGRXG5gv2fdcJ0kvYYQKbuDNLxxb4MfHPsnaf4oQNRjwiuurVi6ME1q/wKye34sgBCXLkQl6Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721444432; c=relaxed/simple;
	bh=EzyWMoAhdHUPmOlIsB67VlPyWYIhPkMYgig6AxI0YRI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=s8fbKk3htbqZUoxk59DXbs0E5K6o7WSPPqvEZSVTi4tU3ADJtH/CR+dxNERCG2lVqHRiJ+H7Cbb0z/qpBfrMBV7516AB15TteJkbZgb3MU3NcPFaPaJ/2hgbuZ69Mohn1qMd9DrT1Hu/kVFyOCu9IRoQoWMb2gsw/XmpQKyd7z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e15wcxXD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4A23C32782;
	Sat, 20 Jul 2024 03:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721444431;
	bh=EzyWMoAhdHUPmOlIsB67VlPyWYIhPkMYgig6AxI0YRI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=e15wcxXDjFGD7QvYtRVOFkJvk0DGWgFhmqiMcGRLRYFit7uI0SUXpzKjNJy4DLiP9
	 sdVSkDkcVcRMUYPrDPDJpy9N9d8E31rir42wR4FkY7CsOZkHwGu2S2h6YvbkWYhao4
	 qOHR/jj5coiz0lO8wkTE9SrZ9ouiXSatilMDshtsbK+xCR0AT1pK0QkU5Rt3IhKyeC
	 maMg+GEo873FtDPm9tCh0YOOygdU7XcoUUxe4nFBYipoq8eIFau2mAkJitN7PtTrPM
	 Phg4jegHsc+z/Seage0j5EQAgrfrA5LR15e/cjAXqO9Wcnw614nq1luwg3uxwiV5lJ
	 KLSsLpDy6NUGA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C911CC4333D;
	Sat, 20 Jul 2024 03:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 bpf-next 0/3] bpf: Fix tailcall hierarchy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172144443181.23894.1730433899460486996.git-patchwork-notify@kernel.org>
Date: Sat, 20 Jul 2024 03:00:31 +0000
References: <20240714123902.32305-1-hffilwlqm@gmail.com>
In-Reply-To: <20240714123902.32305-1-hffilwlqm@gmail.com>
To: Leon Hwang <hffilwlqm@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, maciej.fijalkowski@intel.com, eddyz87@gmail.com,
 puranjay@kernel.org, jakub@cloudflare.com, pulehui@huawei.com,
 kernel-patches-bot@fb.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sun, 14 Jul 2024 20:38:59 +0800 you wrote:
> This patchset fixes a tailcall hierarchy issue.
> 
> The issue is confirmed in the discussions of "bpf, x64: Fix tailcall
> infinite loop"[0].
> 
> The issue has been resolved on both x86_64 and arm64[1].
> 
> [...]

Here is the summary with links:
  - [v6,bpf-next,1/3] bpf, x64: Fix tailcall hierarchy
    https://git.kernel.org/bpf/bpf-next/c/00ac9693a3ba
  - [v6,bpf-next,2/3] bpf, arm64: Fix tailcall hierarchy
    https://git.kernel.org/bpf/bpf-next/c/a53c0f324aed
  - [v6,bpf-next,3/3] selftests/bpf: Add testcases for tailcall hierarchy fixing
    https://git.kernel.org/bpf/bpf-next/c/92a227f61911

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



