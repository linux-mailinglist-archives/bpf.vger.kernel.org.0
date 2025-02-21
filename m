Return-Path: <bpf+bounces-52139-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB577A3EADE
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 03:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCCE919C5CBF
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 02:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D995017A2E2;
	Fri, 21 Feb 2025 02:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p9u7ZR5K"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F04433EA
	for <bpf@vger.kernel.org>; Fri, 21 Feb 2025 02:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740106205; cv=none; b=Is1x/4+8YY+AB+K0/NZi7OprU/28lAv/o7W9u+XRiDIgF38NCJS7QrILv7doFkZZmaStli9du5gbCrXch2HAepEk52sYN+ao0nnRoRqtW+llRO1Zngl/zGc4U2ol3Ww/1LOJwz8aq9eviJOCpdPGwYqj6tabF9qUyFUbaquEHDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740106205; c=relaxed/simple;
	bh=ebSEq8r9wMEV3tY1OAANoHctuPzXToC6gImBupBcttg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=awc7dh4TfC3YEsjPG91XsPL4CwoQ3P23qOdiUO1dDDRKaENq6L+OaEiuzPDvisa3gmGK/ISoc6ueREy1GyHIMJNu13g38AOY4LmGWhxvH2/4M32VPXA64dZHuzQLk9RIcAviZwK7OBQ/ueK8ubn38Hg8/9PDTzZXZ875+9Z1c18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p9u7ZR5K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33792C4CED1;
	Fri, 21 Feb 2025 02:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740106205;
	bh=ebSEq8r9wMEV3tY1OAANoHctuPzXToC6gImBupBcttg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p9u7ZR5KtZ3titK58SlCOkXFGIpg1C87JFqjNXfH0+vR4pLmoQ3Sr8VlE/PukB6DQ
	 SZiMnoxJHu5JaWaZX0YIQLY1HyRms2UfEUoev/f9lWwLRDbqN8SYUg9zHjq0oN2qSm
	 oV5m7iY2lL5PLGGUfytAiMcB8pSFlcEkm/7nz7iMIzqikjvgNQQSgbhWu7AMOrdPI0
	 x3DNNhsZvQz7uV0JZMAmzRzPqXM8eFw50SzxOlPbHLFfLu3w7+3rUoZ3pEk/QXLGz9
	 itGEvoLkEmHl9c1N/3zBKgNXRPeEwT/g1d/JW4YHECiDRrZHQeU3LFCduaFx7/5b6H
	 sVNJ7ncSG/g+A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C2B3806641;
	Fri, 21 Feb 2025 02:50:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Do not allow tail call in strcut_ops
 program with __ref argument
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174010623604.1561130.8352208858606703024.git-patchwork-notify@kernel.org>
Date: Fri, 21 Feb 2025 02:50:36 +0000
References: <20250220221532.1079331-1-ameryhung@gmail.com>
In-Reply-To: <20250220221532.1079331-1-ameryhung@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 alexei.starovoitov@gmail.com, martin.lau@kernel.org, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 20 Feb 2025 14:15:31 -0800 you wrote:
> Reject struct_ops programs with refcounted kptr arguments (arguments
> tagged with __ref suffix) that tail call. Once a refcounted kptr is
> passed to a struct_ops program from the kernel, it can be freed or
> xchged into maps. As there is no guarantee a callee can get the same
> valid refcounted kptr in the ctx, we cannot allow such usage.
> 
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1,1/2] bpf: Do not allow tail call in strcut_ops program with __ref argument
    https://git.kernel.org/bpf/bpf-next/c/38f1e66abd18
  - [bpf-next,v1,2/2] selftests/bpf: Test struct_ops program with __ref arg calling bpf_tail_call
    https://git.kernel.org/bpf/bpf-next/c/63817c771194

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



