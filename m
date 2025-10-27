Return-Path: <bpf+bounces-72352-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 81857C0F842
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 18:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C25D44F601D
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 17:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8E03148DD;
	Mon, 27 Oct 2025 17:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8mzZubS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C9A28AB0B
	for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 17:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761584442; cv=none; b=PybuO7l2+qpOtunDhxemtL0NE+F2+WOflTZw9TgypsSXARKdutrMXZXs0BSqTdLurQXvhX/+U6OnGf7koJxul59ZRnpc824yVa5fNr7gF4pEOD8MYCETugaEeCzWyKNlwMD8A3y4EefzbR7+xeyOzkndJflToGNdx7iOwUNiiN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761584442; c=relaxed/simple;
	bh=zdaN97o/dzSXtdRiNkixtSO6Xkd3uj8D5ixY9kX8V5g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Sw9E9FlbXeLWOGlWKusH+LTjz2bk3TrTC/cFuk5du1Kj6Qw7o3ZfneADHj4xDg6cOQk95snQ1kQz6qrKp3vITZpCT9qP5yzCKyBFHJ9kueUcfP9a9hCZHDQ0fjLXz247vk/E4iu7LUb2K+tdZIkavHEiRyKKgHkQbIUFCHrHwLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r8mzZubS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DAC8C4CEF1;
	Mon, 27 Oct 2025 17:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761584441;
	bh=zdaN97o/dzSXtdRiNkixtSO6Xkd3uj8D5ixY9kX8V5g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=r8mzZubSACRLBkBEEmF0tYEeLPb0JxMnBtdF6TVo/+cKG63f1SkUQgpF7ylpPPa/o
	 Ryz3tACcplLtLghyRw/hi0X1fHI9R+B0veFZLTz9IdqDYQgTVHYtfi489YHBf+06O4
	 +v+STzzQJAYjxD5bgoV/HAaaFaw5Ys+kybndKX3JIwIZcItWCwVMcEVwUt+rRTz0um
	 0PMSKbENmL8a4IWBcRIjzzJGxm2eccBApLqhouCLRJEYoKjW7HKmGmmQuMNWfTy79I
	 7oht4fORDgqLEFzwf3nBVCts5eGb3cYylfrlk9rLtDytzGf2La/g8dLSaFoB2IfTBn
	 j9DtgD3bYXgVg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF6F39B167A;
	Mon, 27 Oct 2025 17:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 00/10] bpf: Introduce file dynptr
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176158441975.1450474.531383794756795259.git-patchwork-notify@kernel.org>
Date: Mon, 27 Oct 2025 17:00:19 +0000
References: <20251026203853.135105-1-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20251026203853.135105-1-mykyta.yatsenko5@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, yatsenko@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sun, 26 Oct 2025 20:38:43 +0000 you wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> This series adds a new dynptr kind, file dynptr, which enables BPF
> programs to perform safe reads from files in a structured way.
> Initial motivations include:
>  * Parsing the executable’s ELF to locate thread-local variable symbols
>  * Capturing stack traces when frame pointers are disabled
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,01/10] selftests/bpf: remove unnecessary kfunc prototypes
    https://git.kernel.org/bpf/bpf-next/c/a61a257ff51c
  - [bpf-next,v5,02/10] bpf: widen dynptr size/offset to 64 bit
    https://git.kernel.org/bpf/bpf-next/c/531b87d865eb
  - [bpf-next,v5,03/10] lib: move freader into buildid.h
    https://git.kernel.org/bpf/bpf-next/c/76e4fed84712
  - [bpf-next,v5,04/10] lib/freader: support reading more than 2 folios
    https://git.kernel.org/bpf/bpf-next/c/5a5fff604fa3
  - [bpf-next,v5,05/10] bpf: verifier: centralize const dynptr check in unmark_stack_slots_dynptr()
    https://git.kernel.org/bpf/bpf-next/c/9cba966f1c55
  - [bpf-next,v5,06/10] bpf: add plumbing for file-backed dynptr
    https://git.kernel.org/bpf/bpf-next/c/8d8771dc03e4
  - [bpf-next,v5,07/10] bpf: add kfuncs and helpers support for file dynptrs
    https://git.kernel.org/bpf/bpf-next/c/e3e36edb1b8f
  - [bpf-next,v5,08/10] bpf: verifier: refactor kfunc specialization
    https://git.kernel.org/bpf/bpf-next/c/d869d56ca848
  - [bpf-next,v5,09/10] bpf: dispatch to sleepable file dynptr
    https://git.kernel.org/bpf/bpf-next/c/2c52e8943a43
  - [bpf-next,v5,10/10] selftests/bpf: add file dynptr tests
    https://git.kernel.org/bpf/bpf-next/c/784cdf931543

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



