Return-Path: <bpf+bounces-77715-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C174FCEF4E4
	for <lists+bpf@lfdr.de>; Fri, 02 Jan 2026 21:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B8EA0300D645
	for <lists+bpf@lfdr.de>; Fri,  2 Jan 2026 20:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D869D2D2391;
	Fri,  2 Jan 2026 20:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgfoEBNh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE072BE05F
	for <bpf@vger.kernel.org>; Fri,  2 Jan 2026 20:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767385419; cv=none; b=YgSNDXMRJiTINm/pKVSfEMWkvJuiBwWCnH0PpJjt8L9XuzA49r48kKQEG2xQs/COXVRXbQ6k0fKJj5gVT/ntUs523/gg9X2ABDDrk/E4+QOySv/xVhi0wbQ5cZ9Yn6/XT6QMuOwPP5nWDMKDskPoIpx/yp2IQmEqE3q1Y6881i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767385419; c=relaxed/simple;
	bh=1FieRFvdJyHIf9RGnAO8WUPbkzzR5Mal0YbxH/DeRMk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=T4uCXSmV8B2yXaOh9aebPepV2/nS2f5U84jfDjwHWFizoagOJh0omhB6fJocYNDeHDQvgKc5QvxeqFHB0qYtus3mq2bsG8A+Vjbexxq/9wWz+O3eOH94euVYd9r10q7So8jYiirzGrc7BUs56+029cbluwGsd6prueRnWHLIaaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgfoEBNh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F75FC116B1;
	Fri,  2 Jan 2026 20:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767385419;
	bh=1FieRFvdJyHIf9RGnAO8WUPbkzzR5Mal0YbxH/DeRMk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fgfoEBNhq0d92dgiOcFZ5fD6cOVTusMus/7ZDKDF4AyExcK6/ZDNqrWLhmmtxoub5
	 u5wIAKWrHmG+bSDH7QMxjONsmbENX5vu1kyI1Tdo4HMcBePR4o0AT6nG+iYlNU1In5
	 1HGdqUn5DZZ9EZaq80orGP9VqhUtVPb6dE2QU3dPHaLzX564odWaQA1Bs17GfSlVH9
	 BrCm3vPM4KZFOyPDjWruNPHg2Bv51Qos0HRY6xmxH+zANLxZuVKJ/g/l5GEC5FMQ2l
	 gIGiRw5ARkkZ6kphlvbs/qKgzXX0l7uuN/b2xusXCBlTqGtn7HQatHXmlCckcynw11
	 WGRKcxBkmiGdg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78828380A962;
	Fri,  2 Jan 2026 20:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 00/10] bpf: Make KF_TRUSTED_ARGS default
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176738521902.3999999.8092738930277465797.git-patchwork-notify@kernel.org>
Date: Fri, 02 Jan 2026 20:20:19 +0000
References: <20260102180038.2708325-1-puranjay@kernel.org>
In-Reply-To: <20260102180038.2708325-1-puranjay@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, puranjay12@gmail.com, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, emil@etsalapatis.com,
 kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  2 Jan 2026 10:00:26 -0800 you wrote:
> v2: https://lore.kernel.org/all/20251231171118.1174007-1-puranjay@kernel.org/
> Changes in v2->v3:
> - Fix documentation: add a new section for kfunc parameters (Eduard)
> - Remove all occurances of KF_TRUSTED from comments, etc. (Eduard)
> - Fix the netfilter kfuncs to drop dead NULL checks.
> - Fix selftest for netfilter kfuncs to check for verification failures
>   and remove the runtime failure that are not possible after this
>   changes
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,01/10] bpf: Make KF_TRUSTED_ARGS the default for all kfuncs
    https://git.kernel.org/bpf/bpf-next/c/1a5c01d2508a
  - [bpf-next,v3,02/10] bpf: Remove redundant KF_TRUSTED_ARGS flag from all kfuncs
    https://git.kernel.org/bpf/bpf-next/c/7646c7afd9a9
  - [bpf-next,v3,03/10] bpf: net: netfilter: drop dead NULL checks
    https://git.kernel.org/bpf/bpf-next/c/bddaf9adda72
  - [bpf-next,v3,04/10] bpf: xfrm: drop dead NULL check in bpf_xdp_get_xfrm_state()
    https://git.kernel.org/bpf/bpf-next/c/cd1d60949143
  - [bpf-next,v3,05/10] HID: bpf: drop dead NULL checks in kfuncs
    https://git.kernel.org/bpf/bpf-next/c/8fe172fa305f
  - [bpf-next,v3,06/10] selftests: bpf: Update kfunc_param_nullable test for new error message
    https://git.kernel.org/bpf/bpf-next/c/df5004579bbd
  - [bpf-next,v3,07/10] selftests: bpf: Update failure message for rbtree_fail
    https://git.kernel.org/bpf/bpf-next/c/03cc77b10e00
  - [bpf-next,v3,08/10] selftests: bpf: fix test_kfunc_dynptr_param
    https://git.kernel.org/bpf/bpf-next/c/230b0118e416
  - [bpf-next,v3,09/10] selftests: bpf: fix cgroup_hierarchical_stats
    https://git.kernel.org/bpf/bpf-next/c/cf82580c86a9
  - [bpf-next,v3,10/10] selftests: bpf: Fix test_bpf_nf for trusted args becoming default
    https://git.kernel.org/bpf/bpf-next/c/cf503eb2c6c3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



