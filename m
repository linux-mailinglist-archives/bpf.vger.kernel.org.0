Return-Path: <bpf+bounces-28719-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A2F8BD680
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 22:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3F25B20525
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 20:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFFC15B56E;
	Mon,  6 May 2024 20:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPmIaOya"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634C0EBB
	for <bpf@vger.kernel.org>; Mon,  6 May 2024 20:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715028629; cv=none; b=IME1t0RZxyWTpq9by3E1lkwqeHELt2/i1Hw/LWNz0lxD9gvfzwVsuxltVOhGhDN99aG0Yd1YLzsodlbTQjkY4LAQL15akI3ncNX0AsOfUWJTVF/pNj842GR6OfDBAHBeeuxa9l9yc0PyyxVGOPanXV705CqtcVKDz1gRGlnnXYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715028629; c=relaxed/simple;
	bh=oRto/GHZYY5kD5y6l1qcq06OaWl/dB2xlR1OOsz3DtU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bsd3iuWFoprrmYiqTrrYHS0+iniJlxjMLgCb3R6ZF0ndUzk7mEgI17kJzqN9qkZ8dTdtOqYv3v6W6qVuNvMEDnSyJlwznPOYTRwjPo9sCNOxzC88+c0Hu9MXDc1vlBW9YGCyd1uCNeStMPsaGQ6EM8bpnJgye5I/fB+2PbBc92Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPmIaOya; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 05A9CC4AF63;
	Mon,  6 May 2024 20:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715028629;
	bh=oRto/GHZYY5kD5y6l1qcq06OaWl/dB2xlR1OOsz3DtU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XPmIaOyaTMd/GZaWIEVS9cDPihsY7ITSZzwjuVXS9f5CAvfg4PeYSte/Hhl5YVb+/
	 lT+yk5CkTxypc+a4+zaCB3h1fjX3sd03K72lcbdkIY3wgxbSnZOZnqc8mp2tVZIBku
	 LdYnM06bxAM1d3LOlhTcplX7sanWxujwE769cc594RZKsxDDizNNA04k+SKOmc3jLx
	 JNcptOU4FEyR+rPcVXV+W4RgPdlhbZAyEmCXizpwwvCvMVDwIanpcoi5m8oqqFAmTs
	 pJsm3kR9cXQoLIYBd1ji4A9/S7HcSO74tJ+S+2Y42PbggAM2XZMOBR5W2CJEOpzzGp
	 V2rZikgNJZ0bQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E818BC43334;
	Mon,  6 May 2024 20:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Use bpf_tracing.h instead of
 bpf_tcp_helpers.h
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171502862894.17124.3307277720723637686.git-patchwork-notify@kernel.org>
Date: Mon, 06 May 2024 20:50:28 +0000
References: <20240504005045.848376-1-martin.lau@linux.dev>
In-Reply-To: <20240504005045.848376-1-martin.lau@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri,  3 May 2024 17:50:45 -0700 you wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
> 
> The bpf programs that this patch changes require the BPF_PROG macro.
> The BPF_PROG macro is defined in the libbpf's bpf_tracing.h.
> Some tests include bpf_tcp_helpers.h which includes bpf_tracing.h.
> They don't need other things from bpf_tcp_helpers.h other than
> bpf_tracing.h. This patch simplifies it by directly including
> the bpf_tracing.h.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Use bpf_tracing.h instead of bpf_tcp_helpers.h
    https://git.kernel.org/bpf/bpf-next/c/8e6d9ae2e09f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



