Return-Path: <bpf+bounces-62509-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39894AFB763
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 17:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 119BE1AA49AE
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 15:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948032E3360;
	Mon,  7 Jul 2025 15:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lufOoArN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7271F09A5
	for <bpf@vger.kernel.org>; Mon,  7 Jul 2025 15:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751902194; cv=none; b=kRIoX6PgTv0C9bGk7UqPgW9XBwSykZ4jd4zaL0f7kTU1892Cm8in+3FFdOXjrraOw9C2IyxhR6nmiwFN1NcsniP8ayMzwS+9jcyNazsrYOSL/z4aOyfeudIxMOrVz1AAtZ+OqxiVD7lPvUVk7aLqFvoKKngqtGHdGVea3Poy1wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751902194; c=relaxed/simple;
	bh=94BO1CWyWxpelOAZsyYbPkEaL8q/K70trjQq/VXM5ps=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lyqCz57l2D28H4tPhg/u1sXspfF/EVFnHuU/576ovBU6nEFeil6yg/Y16WV1eVILbr8R/hgSdPfGMV9g/4Or4VXdvr1NfDk42fsepBL8ZY4Yuz9yVrJx+X86nVnE4tgGjEqlSaTBPLsWB0oA1c/V0a2RvYaZ7RF7dy5qEWHJ9hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lufOoArN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D017C4CEF1;
	Mon,  7 Jul 2025 15:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751902193;
	bh=94BO1CWyWxpelOAZsyYbPkEaL8q/K70trjQq/VXM5ps=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lufOoArNBVNZaNIwSGGQRolMbgEtFKnpQo17NKaQgNCGaq0awOHT73nJfZbpjn+xh
	 PAK+XvonZ+S/1gQEPPFEeqefbQkW8vqDzlosN5uK+t4v+yGR3vYXior2bMDDzAat8J
	 KtDVim8ZvWpxHqeQOKfgrjigLhoqVGDiBH3Wfa9wCLtcAwvmrNLy9XbnmGDUcRgHOf
	 EH5fJvWDnx/KQwqxU5MlSTXAiXp23f85H/waQZjs9xkeaKyaqMu3ssPqDX5wUgGfJm
	 XXU/7jceOuR1bJS41rpyKG3yFbO5EN5HwoSGl6D5bAwrHSzOrilllEXvOuHMryrsLc
	 fLQOjJLMX/Xsg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD66383BA25;
	Mon,  7 Jul 2025 15:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/8] bpf: additional use-cases for untrusted
 PTR_TO_MEM
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175190221676.3332981.13346618944357682704.git-patchwork-notify@kernel.org>
Date: Mon, 07 Jul 2025 15:30:16 +0000
References: <20250704230354.1323244-1-eddyz87@gmail.com>
In-Reply-To: <20250704230354.1323244-1-eddyz87@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  4 Jul 2025 16:03:46 -0700 you wrote:
> This patch set introduces two usability enhancements leveraging
> untrusted pointers to mem:
> - When reading a pointer field from a PTR_TO_BTF_ID, the resulting
>   value is now assumed to be PTR_TO_MEM|MEM_RDONLY|PTR_UNTRUSTED
>   instead of SCALAR_VALUE, provided the pointer points to a primitive
>   type.
> - __arg_untrusted attribute for global function parameters,
>   allowed for pointer arguments of both structural and primitive
>   types:
>   - For structural types, the attribute produces
>     PTR_TO_BTF_ID|PTR_UNTRUSTED.
>   - For primitive types, it yields
>     PTR_TO_MEM|MEM_RDONLY|PTR_UNTRUSTED.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/8] bpf: make makr_btf_ld_reg return error for unexpected reg types
    https://git.kernel.org/bpf/bpf-next/c/b9d44bc9fd30
  - [bpf-next,v2,2/8] bpf: rdonly_untrusted_mem for btf id walk pointer leafs
    https://git.kernel.org/bpf/bpf-next/c/2d5c91e1cc14
  - [bpf-next,v2,3/8] selftests/bpf: ptr_to_btf_id struct walk ending with primitive pointer
    https://git.kernel.org/bpf/bpf-next/c/f1f5d6f25d09
  - [bpf-next,v2,4/8] bpf: attribute __arg_untrusted for global function parameters
    https://git.kernel.org/bpf/bpf-next/c/182f7df70419
  - [bpf-next,v2,5/8] libbpf: __arg_untrusted in bpf_helpers.h
    https://git.kernel.org/bpf/bpf-next/c/aaa0e57e6930
  - [bpf-next,v2,6/8] selftests/bpf: test cases for __arg_untrusted
    https://git.kernel.org/bpf/bpf-next/c/54ac2c9418af
  - [bpf-next,v2,7/8] bpf: support for void/primitive __arg_untrusted global func params
    https://git.kernel.org/bpf/bpf-next/c/c4aa454c64ae
  - [bpf-next,v2,8/8] selftests/bpf: tests for __arg_untrusted void * global func params
    https://git.kernel.org/bpf/bpf-next/c/68cca81fd57f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



