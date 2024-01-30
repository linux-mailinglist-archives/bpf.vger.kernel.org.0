Return-Path: <bpf+bounces-20759-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34851842B36
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 18:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E61C228BBA6
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 17:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A6D14E2CE;
	Tue, 30 Jan 2024 17:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDlHOg+5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B0F1292E9
	for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 17:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706637027; cv=none; b=Ccx7OIajWnOyAv90QgmgtQeVgvr7vEVXg5I3TkyW5F6BZdz7aIRx8hEpC0amaOUZXknmCh8EwMvDiZAO2VuoxXMES6e2rztRiwuHvgXe7YJU9VSPbZDHxD1bAJ46+ULAiY5+eUKT39mi/3FtQXK3ZK5NCb0FAT6PP5tA0JyV07g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706637027; c=relaxed/simple;
	bh=kXT4rgUZM0haKxI7jx6ceO6uwS3zjGBNs5oiC7cttmM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XE+3PnxK8MoDIgJbeHmSoHzqXDLBpNXG/iijJ6OcstSyiMq+TEMtxpZoa5j7vPjtqRBRNI1LxhfrXIjuKxaBfkE8C4mpVNNYXJYx09f84TnqrknFTaWYzKoi/FgRiq4V984hANv2xQQr5pcy4G85FoOb745oYeZ1DZ86BNnXhuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDlHOg+5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36A1AC433F1;
	Tue, 30 Jan 2024 17:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706637027;
	bh=kXT4rgUZM0haKxI7jx6ceO6uwS3zjGBNs5oiC7cttmM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fDlHOg+5qK+oPUIaWqOBlyD4gPXQLJ0cyUPnOeE5nyiqU5UT+oUOtLLL1uG5lzb4f
	 weqYqM3hip8ropomUhLhakld4xxJdxpWLVNluvBScNvb6d9PJScfDgI1gfAoCBu0Kx
	 385QHR9PeLiK7mMeGGels9tBz84IAGWP/JuEtL8JLNoJSjObJHD9XvGnTZYo4u2L/Y
	 wlSvtGh12jPUxvu0TSz9HeDSqV0l33zemRRhG+UaFfVlIFeXD6QJHcCL9AVs2ga5Ys
	 UUotJJ6pobl0wKVK+mCx4QxgYAbukOnBJ7vKkd0LHzkjWZN4N/DBN2GVMDT8eyVnC2
	 P9vQxavOZJ3mA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1CAB0E3237E;
	Tue, 30 Jan 2024 17:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 bpf-next 0/4] Trusted PTR_TO_BTF_ID arg support in global
 subprogs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170663702711.29629.11599775562612495162.git-patchwork-notify@kernel.org>
Date: Tue, 30 Jan 2024 17:50:27 +0000
References: <20240130000648.2144827-1-andrii@kernel.org>
In-Reply-To: <20240130000648.2144827-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 29 Jan 2024 16:06:44 -0800 you wrote:
> This patch set follows recent changes that added btf_decl_tag-based argument
> annotation support for global subprogs. This time we add ability to pass
> PTR_TO_BTF_ID (BTF-aware kernel pointers) arguments into global subprograms.
> We support explicitly trusted arguments only, for now.
> 
> Patch #1 adds logic for arg:trusted tag support on the verifier side. Default
> semantic of such arguments is non-NULL, enforced on caller side. But patch #2
> adds arg:nullable tag that can be combined with arg:trusted to make callee
> explicitly do the NULL check, which helps implement "optional" PTR_TO_BTF_ID
> arguments.
> 
> [...]

Here is the summary with links:
  - [v3,bpf-next,1/4] bpf: add __arg_trusted global func arg tag
    https://git.kernel.org/bpf/bpf-next/c/e2b3c4ff5d18
  - [v3,bpf-next,2/4] bpf: add arg:nullable tag to be combined with trusted pointers
    https://git.kernel.org/bpf/bpf-next/c/8f2b44cd9d69
  - [v3,bpf-next,3/4] libbpf: add __arg_trusted and __arg_nullable tag macros
    https://git.kernel.org/bpf/bpf-next/c/d28bb1a86e68
  - [v3,bpf-next,4/4] selftests/bpf: add trusted global subprog arg tests
    https://git.kernel.org/bpf/bpf-next/c/c381203eadb7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



