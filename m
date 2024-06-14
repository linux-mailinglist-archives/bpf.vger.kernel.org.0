Return-Path: <bpf+bounces-32195-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37476909153
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 19:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C214728417A
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 17:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8E015FD13;
	Fri, 14 Jun 2024 17:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SbhzyMpl"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FBE9441
	for <bpf@vger.kernel.org>; Fri, 14 Jun 2024 17:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718385632; cv=none; b=Qjto0WbmgWWdnoqlIFVs9SvN0P1opbBIbrybM1JYSp0+u7zWj9PuSvvodVUfkVPjytORBv0P31K0uHHMs+xCx6x/IEI48Sc7jAbL5QAlT2p/snWzk6bKrWGbNpmEENPyo61I4XXsA+hBbrk7yBTrSYuQ5Ppy5HHYSVYRPbHs2Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718385632; c=relaxed/simple;
	bh=xzqWcKm8mrVppEi/3ovK/d5OyYvcS3SAP5bLpieGgEg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HyPCpz5okF4YfAVDaNT/NP6TU3kg25M/yazxdBG4MOZa/40SPPIQTOUL2NL8DBcQg2Oic5tuLpTSBkKp/ujP3Fz//b7cA6Mugpu6OMT18VSWNXMN/0EBnH1amxa2/yyf9VZ1pbPzJakRD/IjBsCOG4iL2N6Qs1+ZR+J73ukaJd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SbhzyMpl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79ACAC4AF1A;
	Fri, 14 Jun 2024 17:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718385631;
	bh=xzqWcKm8mrVppEi/3ovK/d5OyYvcS3SAP5bLpieGgEg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SbhzyMpleE12hBN0pDI76ulz/FrFnZDbhbb18ET99SQZBx9+wpSl8bfIQ5nswjNkq
	 3jxNLTOvqyLYkV62rY9dA5A+zKxUfKMxLVuBwSIwCdnS7TXhgsQcUsfMqb3tkJWKpx
	 JHxaUVNPHIcCjZO/r9afXtjFh0rpYL1Bup5XPCel6GJffc7gri+bDhD16KZNjLmQvW
	 h6BWSaY1q5ai1UFXTfIZI8gPkhkI4nFKQ7AO0HvaFdUt8QxrqeNMkZoS1pZtEH2pMR
	 Lj8Ba7wu1fTY0fmvouIluCJkaTnDzcQGA9iqA/Fd3fp4JXPMW6mYyRUZX1g99ha5Y6
	 Ui10KmuuHGAzw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 63A05C43612;
	Fri, 14 Jun 2024 17:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2 0/2] bpf: Fix linker optimization removing kfuncs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171838563140.12119.1794667369752421264.git-patchwork-notify@kernel.org>
Date: Fri, 14 Jun 2024 17:20:31 +0000
References: <cover.1717477560.git.Tony.Ambardar@gmail.com>
In-Reply-To: <cover.1717477560.git.Tony.Ambardar@gmail.com>
To: Tony Ambardar <tony.ambardar@gmail.com>
Cc: bpf@vger.kernel.org, Tony.Ambardar@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, ojeda@kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon,  3 Jun 2024 22:23:14 -0700 you wrote:
> This patch series fixes unwanted stripping of kernel kfuncs during linker
> optimization, as indicated by build warnings from resolve_btfids e.g.
> "WARN: resolve_btfids: unresolved symbol ...". This can happen because the
> __bpf_kfunc macro annotating kfunc declarations is ignored during linking.
> 
> Patch 1 adds support for the compiler attribute "__retain__", used to
> avoid linker garbage cleanup. Patch 2 then updates __bpf_kfunc to use this
> attribute when LTO builds are enabled.
> 
> [...]

Here is the summary with links:
  - [bpf,v2,1/2] compiler_types.h: Define __retain for __attribute__((__retain__))
    https://git.kernel.org/bpf/bpf/c/0a5d3258d7c9
  - [bpf,v2,2/2] bpf: Harden __bpf_kfunc tag against linker kfunc removal
    https://git.kernel.org/bpf/bpf/c/7bdcedd5c8fb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



