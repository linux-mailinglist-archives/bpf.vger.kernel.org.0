Return-Path: <bpf+bounces-19400-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7087282B9A7
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 03:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0901D1F25175
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 02:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224B5185A;
	Fri, 12 Jan 2024 02:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzaHOINR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70CAED7
	for <bpf@vger.kernel.org>; Fri, 12 Jan 2024 02:40:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3296CC433C7;
	Fri, 12 Jan 2024 02:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705027227;
	bh=upp1NwSzjhfQcc1hpr3QwgM4YMInuPYJhVhpRfSX/iw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mzaHOINRF/wkThbiXGbmCLm+FYoLsH4Pk2q5qxoFpdejIgiNZlLOTMOvnyMRIL9pR
	 kBKR+I0hnNsA0bjjg1fLQxKeXKmIMN1sv1cY7XjGvVtTZWh4bj5MncrA3ucDdKTaaN
	 qqr2EdIUm/KZiR5Sm+GLWgdYJWm0Vf2gGupwAxTxMLHCDLlJRwZcREdyxmS+a+OEIr
	 wUKKASb2+4Rt01myb8bpn8VI7c7ZrJDZx39d4A7oSHuY6jwnFdflVP8lH+2eXs36JP
	 mb+7g4WU73NX7kZeGA6/L4ttlvRKgfNqxy6YdfOjdzrGFBE9UTjXewpk4R0g4SDpoz
	 bOSQvm9E6t7lQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 17477D8C96C;
	Fri, 12 Jan 2024 02:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/8] PTR_TO_BTF_ID arguments in global subprogs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170502722709.15005.11239108129933936591.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jan 2024 02:40:27 +0000
References: <20240105000909.2818934-1-andrii@kernel.org>
In-Reply-To: <20240105000909.2818934-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com, davemarchevsky@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu,  4 Jan 2024 16:09:01 -0800 you wrote:
> This patch set follows recent changes that added btf_decl_tag-based argument
> annotation support for global subprogs. This time we add ability to pass
> PTR_TO_BTF_ID (BTF-aware kernel pointers) arguments into global subprograms.
> We support explicitly trusted and untrusted arguments. Legacy semi-trusted
> variant is not supported.
> 
> Patches #2 through #4 do preparatory refactorings to add support for multiple
> tags per argument. This is important for being able to use modifiers like
> __arg_nonnull together with trusted/untrusted arguments.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/8] selftests/bpf: fix test_loader check message
    https://git.kernel.org/bpf/bpf-next/c/7c5f9568564a
  - [bpf-next,2/8] bpf: make sure scalar args don't accept __arg_nonnull tag
    https://git.kernel.org/bpf/bpf-next/c/ca3950495684
  - [bpf-next,3/8] bpf: prepare btf_prepare_func_args() for multiple tags per argument
    https://git.kernel.org/bpf/bpf-next/c/5436740cc03d
  - [bpf-next,4/8] bpf: support multiple tags per argument
    https://git.kernel.org/bpf/bpf-next/c/6a21d4e515f5
  - [bpf-next,5/8] bpf: add __arg_trusted and __arg_untrusted global func tags
    (no matching commit)
  - [bpf-next,6/8] libbpf: add __arg_trusted and __arg_untrusted annotation macros
    (no matching commit)
  - [bpf-next,7/8] libbpf: add bpf_core_cast() macro
    (no matching commit)
  - [bpf-next,8/8] selftests/bpf: add trusted/untrusted global subprog arg tests
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



