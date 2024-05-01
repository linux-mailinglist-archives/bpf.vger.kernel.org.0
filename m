Return-Path: <bpf+bounces-28385-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B949B8B8F0F
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 19:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9D6C1C211FA
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 17:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24011B27D;
	Wed,  1 May 2024 17:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jTkiKq1a"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AE5FBEA
	for <bpf@vger.kernel.org>; Wed,  1 May 2024 17:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714584633; cv=none; b=EHjaAMG6gTfCLhEArVnnF/Vmz4oU3BTZTDbINXm6525aIvlsfOzaoYElWyyAdVgbTC+PJKNZRW2xsrZQF32dF4Xop0gDKvBTOAmvhd7RBSbvpsDfGq0l7Wub2mteN9RVmLESWYvd+O3gIA8rR8q8oQC0NgJJBOA31gl2ovqaSx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714584633; c=relaxed/simple;
	bh=pFuqwhxae1iZSRBRw8hUb/x5IIEdzNUylHee5RMAH/E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XSNuK/W8cx3eKV9DkD7fbnOqsZCTWMnGkWPSNuckqioO7HrqHPwMLhNULiMdtRMZ7xZ8dq2d4fsmz7LfngcmarPjj4TuadzqQLdjae5nAOyZcGWJyIlpUiLlKxOpNWDVuI/OQT5pEgazoBrmej/NNNMT58mc9RoCbSMK2f6lnPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jTkiKq1a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9C521C4AF14;
	Wed,  1 May 2024 17:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714584631;
	bh=pFuqwhxae1iZSRBRw8hUb/x5IIEdzNUylHee5RMAH/E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jTkiKq1arFQoh6/t11qsXyAGR4jtql+XZ6dlH3g6kiMLG5/92+MErt0PJemhh1vEh
	 Ol6wOLJP2wg773p3LPN1sHxJJAQdT/6N3gDw6acGh/SdUiuMnTGZrDXtT1sW+tnMD3
	 73tACg7Zoe7rbTglbBFARbmq7zQ3Z7qrDi5mAE7tt01ed98Bh+VcC4xctuF0GP8wLn
	 tqRN7X5zKvp04hC+kZG+g621YHTDpa2xqDYFuWfNDRthexgP8av5n7X+ysMcIA/7lP
	 B91HoECPiuS7Xr81Oj8MyGuwSvf/VPw+KfBoRrlnJOqAjnhh9yicPC+THF5HEjnpED
	 nk0iE/Qm3I2hA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 86538C43444;
	Wed,  1 May 2024 17:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: better fix for handling nulled-out
 struct_ops program
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171458463154.23034.10864412473237791237.git-patchwork-notify@kernel.org>
Date: Wed, 01 May 2024 17:30:31 +0000
References: <20240501041706.3712608-1-andrii@kernel.org>
In-Reply-To: <20240501041706.3712608-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com, thinker.li@gmail.com,
 eddyz87@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Tue, 30 Apr 2024 21:17:06 -0700 you wrote:
> Previous attempt to fix the handling of nulled-out (from skeleton)
> struct_ops program is working well only if struct_ops program is defined
> as non-autoloaded by default (i.e., has SEC("?struct_ops") annotation,
> with question mark).
> 
> Unfortunately, that fix is incomplete due to how
> bpf_object_adjust_struct_ops_autoload() is marking referenced or
> non-referenced struct_ops program as autoloaded (or not). Because
> bpf_object_adjust_struct_ops_autoload() is run after
> bpf_map__init_kern_struct_ops() step, which sets program slot to NULL,
> such programs won't be considered "referenced", and so its autoload
> property won't be changed.
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: better fix for handling nulled-out struct_ops program
    https://git.kernel.org/bpf/bpf-next/c/0737df6de946

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



