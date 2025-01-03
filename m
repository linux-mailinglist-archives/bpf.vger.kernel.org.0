Return-Path: <bpf+bounces-47852-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5152DA00D92
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 19:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 893491884EDC
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 18:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3621FC7CF;
	Fri,  3 Jan 2025 18:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXnlF6WA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CEF188CCA
	for <bpf@vger.kernel.org>; Fri,  3 Jan 2025 18:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735928411; cv=none; b=nM4/ewLw8VtW2Vo8R0wiMOciyyB8aa4cxEDq0bb+7OvFZ59974LO+Y3dVgjG75YkCko9Wvjfb7LFZqYUjljdx/r1nnjj+HH+r2pYXJyxVAo5Zk5cUazKhK2kzJrm/c3tjMBwVSitvNltuscMnZ6OsZIYzIbdo8khD58qbHRP3kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735928411; c=relaxed/simple;
	bh=LawA113wb33Cb4gHZjPjyBtHvhbPsXBV9uQLhvGPELM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tXC2CCGAl/eowmXUoEIFkTbmeAOTk2EwdIO4e408sdmzIlMwCCn+N1GNcmLVCs7B5L3PLT3LBmPS4/W72ezWujVSuMJY+2IJ0OzvXzIOJ02T6/jI4xhLAVcn4O3FGNJzN+RG//5V9VyIXuBPKaJ7FdkUckeD3FUmA/eno1dr5ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXnlF6WA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01496C4CECE;
	Fri,  3 Jan 2025 18:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735928411;
	bh=LawA113wb33Cb4gHZjPjyBtHvhbPsXBV9uQLhvGPELM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NXnlF6WAoEqw4xYdrciQ25EoTmIz7lR0dSGz4kzmztVrjHfwrlFVEjpddOwAf0ABJ
	 6qlpq/XTwrhcCxwE9R8emLtKoc3fGtYmubtFVqyNS27P5w7k75CtBuzXWVhLq4oUws
	 TzWABUzHjq2s+CgPxiwU0pknb6/VIQzf+XkXpB5+mcrkdPl+FFOWqEbFT71FpJkZIb
	 a2mOi6sv+xFnEaA87ZpIoUmps4CZiCwv8RDs9Yyxl9WDTn+Zna8lqz10lAvrOKrKJ6
	 M4m4m4FOxScOzuFyXDJz3FTZ8PfRPVYq8p+9FS1BsQ4jEfg8STBHWCekp+FYgpwBY0
	 O6cPZkcpP0HHg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE067380A96A;
	Fri,  3 Jan 2025 18:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Reject struct_ops registration that uses module
 ptr and the module btf_id is missing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173592843152.2272787.3893764785124967304.git-patchwork-notify@kernel.org>
Date: Fri, 03 Jan 2025 18:20:31 +0000
References: <20241220201818.127152-1-martin.lau@linux.dev>
In-Reply-To: <20241220201818.127152-1-martin.lau@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@meta.com, rtm@csail.mit.edu

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 20 Dec 2024 12:18:18 -0800 you wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
> 
> There is a UAF report in the bpf_struct_ops when CONFIG_MODULES=n.
> In particular, the report is on tcp_congestion_ops that has
> a "struct module *owner" member.
> 
> For struct_ops that has a "struct module *owner" member,
> it can be extended either by the regular kernel module or
> by the bpf_struct_ops. bpf_try_module_get() will be used
> to do the refcounting and different refcount is done
> based on the owner pointer. When CONFIG_MODULES=n,
> the btf_id of the "struct module" is missing:
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Reject struct_ops registration that uses module ptr and the module btf_id is missing
    https://git.kernel.org/bpf/bpf-next/c/96ea081ed52b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



