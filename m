Return-Path: <bpf+bounces-20626-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7488414A9
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 21:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7011F283855
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 20:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33ED7156967;
	Mon, 29 Jan 2024 20:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZgQ9ygdQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FE57602C
	for <bpf@vger.kernel.org>; Mon, 29 Jan 2024 20:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706561424; cv=none; b=fMHN1UFhe2olBcUu4IX85dzsjhxnOs0kwOw2Akh4XJeIk2yEXyZz8LYzWWoNHKi9haSMfX2SwGdaCT5oR9EJOlvtQ2yOa6QfKXJkJq8p10FmC9AiEMUgtVE2djtqjc+yuqTfRqfKNa/yIpXvL/7Yo5lQg+Rq4kvwZv/vx+Po1UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706561424; c=relaxed/simple;
	bh=1mX+NBsGeDFApJqLvMQ25EIlr1lbfVqGssZiXkSoJdI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rISAJROXQPL6AeBJ+/QrMXOnr5Qlua153z13J9nGZSIgjkKofvVZhcz3CGfwGWC93TNXqVKSI3u3zcBzg8uhX/VAcGE7heCJZjUGzjo1Ure/tYhX9xp/CA6Zp+wEmRiAO5IT7yGmoC/WiWa/b0ajiMzNcsvKp4r7K0L4mhSpRsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZgQ9ygdQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7BFC0C433C7;
	Mon, 29 Jan 2024 20:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706561424;
	bh=1mX+NBsGeDFApJqLvMQ25EIlr1lbfVqGssZiXkSoJdI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZgQ9ygdQEyKxHMC0UC35TDXf6EWhNaecwXbe3ZS70VS9GDm3Zmf5S4xaw+KlziTOx
	 SuZ6OkW/L3AjuxNdnkqHBM99a4Nut4ihceOE1CekBFtOMofdq++e8HvXNryDa8zqBp
	 eMK4D0agVltk+FiXhqKg2zExT853UNCdPU7TTAb1PPJ0mOjfZpb7raRNATn/0R+KKa
	 XWd6mdB6sOK+VHWU66Dc1+NNm/Mx4240GadVEeJ029UjAffCxNb2pN7+2H+bI9ynq8
	 4XwY0CariC7fmR7f92ceIeOjg48O5aZMoTc2LriZa6XDffOse1FMy+b+WbU42ZtfMo
	 JSv2c53i1kKzQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 60542C00448;
	Mon, 29 Jan 2024 20:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 0/7] Trusted PTR_TO_BTF_ID arg support in global
 subprogs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170656142439.13637.4545124045058862619.git-patchwork-notify@kernel.org>
Date: Mon, 29 Jan 2024 20:50:24 +0000
References: <20240125205510.3642094-1-andrii@kernel.org>
In-Reply-To: <20240125205510.3642094-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 25 Jan 2024 12:55:03 -0800 you wrote:
> This patch set follows recent changes that added btf_decl_tag-based argument
> annotation support for global subprogs. This time we add ability to pass
> PTR_TO_BTF_ID (BTF-aware kernel pointers) arguments into global subprograms.
> We support explicitly trusted arguments only, for now.
> 
> First three patches are preparatory. Patches #1 and #3 does post-BPF token
> code adjustments, to undo merge conflict avoidance measures. Patch #2 makes
> PERF_EVENT type enforcement logic aligned with kernel-side logic.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/7] libbpf: integrate __arg_ctx feature detector into kernel_supports()
    https://git.kernel.org/bpf/bpf-next/c/0e6d0a9d2348
  - [v2,bpf-next,2/7] libbpf: fix __arg_ctx type enforcement for perf_event programs
    https://git.kernel.org/bpf/bpf-next/c/9eea8fafe33e
  - [v2,bpf-next,3/7] bpf: move arg:ctx type enforcement check inside the main logic loop
    https://git.kernel.org/bpf/bpf-next/c/add9c58cd44e
  - [v2,bpf-next,4/7] bpf: add __arg_trusted global func arg tag
    (no matching commit)
  - [v2,bpf-next,5/7] bpf: add arg:maybe_null tag to be combined with trusted pointers
    (no matching commit)
  - [v2,bpf-next,6/7] libbpf: add __arg_trusted and __arg_maybe_null tag macros
    (no matching commit)
  - [v2,bpf-next,7/7] selftests/bpf: add trusted global subprog arg tests
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



