Return-Path: <bpf+bounces-20281-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D559783B583
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 00:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 648D51F2364A
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 23:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA69B136651;
	Wed, 24 Jan 2024 23:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gO98NX1i"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7293E7E771
	for <bpf@vger.kernel.org>; Wed, 24 Jan 2024 23:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706138425; cv=none; b=c4Rio5L/CHysQ3k5dwD64CY50eJBpN9v5Ib+TN/QLYxSbrzGUiSHeh/pXe1coGcMU/yqSwO3dkfvnt9qSIDttVpeI1IyA/9fF7J6TojH4THOG+oHCadXErNLTFyOZbCy3mVHXttLCvqMV18HGLkF5NSy865Mr6NlvtLlQ4Av1wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706138425; c=relaxed/simple;
	bh=wQy9EUdcWe5pKydbHkP3hNI34viOGiAnVb9AXWtBEiI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FJpx/ekErcPJhpfcKxCVoOSV6KKZAGzf5U7kuOWZ0VtLwwXHCohyG1Xud0cbi3bhTuLQnyzekLJq+dPPFUMm/D6kXpRI7Ys+hipyHZNTmluuUn0xQcK9+ia4UhobwxwPZuG+FAQuo5/VJcsRNs03dIw72Q3qUuYNNhAELjb7RqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gO98NX1i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2442C433F1;
	Wed, 24 Jan 2024 23:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706138424;
	bh=wQy9EUdcWe5pKydbHkP3hNI34viOGiAnVb9AXWtBEiI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gO98NX1iJV/FB6Q7gdRVcI8LcEX6mtwHk2VImjSFWMY+7D3WzhEoO6ihndMbCXijW
	 bugJHGO5KGugbWHM6iF7yoi63yOn9Fk/flQ6tMdfLbVgaLxHdxB99mlwfEssipoy/T
	 pXrBbHqcks5bXBgrCK7VVfCcuLg3iQYigbJPUsu9+SiEPoZnMP1uMv2BzMahGdlk/e
	 gQC0XRKQBRelWkETb2apqjHTYrxRtTztvGXBc5agCl3+PH6CfO7uxh373740RxDTTH
	 IjkzKeOpgeaCWppP5EkXkTMdXjSzA7wf7s4ENCZxFLvhWr3EMJ8eFDgZJocoBR6e9Y
	 lb5tI3tZ023+w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BA405DFF762;
	Wed, 24 Jan 2024 23:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next] libbpf: Ensure undefined bpf_attr field stays 0
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170613842475.28029.9014326084721242761.git-patchwork-notify@kernel.org>
Date: Wed, 24 Jan 2024 23:20:24 +0000
References: <20240124224418.2905133-1-martin.lau@linux.dev>
In-Reply-To: <20240124224418.2905133-1-martin.lau@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@meta.com, thinker.li@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 24 Jan 2024 14:44:18 -0800 you wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
> 
> The commit 9e926acda0c2 ("libbpf: Find correct module BTFs for struct_ops maps and progs.")
> sets a newly added field (value_type_btf_obj_fd) to -1 in libbpf when
> the caller of the libbpf's bpf_map_create did not define this field by
> passing a NULL "opts" or passing in a "opts" that does not cover this
> new field. OPT_HAS(opts, field) is used to decide if the field is
> defined or not:
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next] libbpf: Ensure undefined bpf_attr field stays 0
    https://git.kernel.org/bpf/bpf-next/c/77c03cf314b4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



