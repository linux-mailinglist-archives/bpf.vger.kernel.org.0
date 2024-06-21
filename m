Return-Path: <bpf+bounces-32751-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA54912CDC
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 20:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A95AB2520B
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 18:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFA816A95E;
	Fri, 21 Jun 2024 18:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TE1Cj7j6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E25316A935
	for <bpf@vger.kernel.org>; Fri, 21 Jun 2024 18:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718992834; cv=none; b=p+cNaF5s/au4rHB5U+90313V8M0l1BCOmfijZk4FEtjKbHQv1moj1GczpDlSU8UKZWGDydPrCG/XKx/RnPMq9LE00CveIXQfvBcjhXFIDJryjhrD7lFrx/oRSLjMx51AT4MOPFef6BKQI58XPQPLfL68COI4og6CzkcIdewwEFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718992834; c=relaxed/simple;
	bh=ZkY+D+2YhESr5g19XNXpIgL5JY61jIiIFeauSPFu++8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=swrUFk7yn4tEEfcCPKNtADYE/ix9A3jIYfjrTpa2LQC9UHxYC4L5/sIK+BiP6dfsucyfamAkVFlrikEhRsr4n8ZBOTId8qH5gyzcKaf55O5AKwvSVCHYZZlzK/7Zy7KA2pBi3HuAeCxb/6F9WgqczliFjc5CUazxlg4ejJEEJEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TE1Cj7j6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BCFD3C2BBFC;
	Fri, 21 Jun 2024 18:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718992833;
	bh=ZkY+D+2YhESr5g19XNXpIgL5JY61jIiIFeauSPFu++8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TE1Cj7j6jwwzpUSxWtO3N81k6g6LENykbnzopoAU8hYQI6OJlof3esNTT/Pd1c0HH
	 Dbbc2rehwnZogrQTVKX1Cw/smc53Ut+CRfqGpEjErZf3JMc98RiayF1IsQECs2HrNU
	 SFizNdNNk+AQ45EuREZrjYpRyfNv0S9o+536h1GtZ8iEKIW6uvFr28MoS9Jq5lMVVG
	 ZKit4YNVS5qs9sYetIGm3po2hhGN/mN1zpKhfEQTq2dYapM9rnDfntoR2U0YxXZq1+
	 sYdOj5UaqBwrP2fwLgAZzUcePJewBGMRSPR2cnc9AY7T3ArtM1tpqKdgHQmqqvI6yy
	 Tdxd0IR1jCjPA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A372ECF3B97;
	Fri, 21 Jun 2024 18:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpftool: allow compile-time checks of BPF map
 auto-attach support in skeleton
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171899283366.11208.4246933303972594627.git-patchwork-notify@kernel.org>
Date: Fri, 21 Jun 2024 18:00:33 +0000
References: <20240618183832.2535876-1-andrii@kernel.org>
In-Reply-To: <20240618183832.2535876-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, tj@kernel.org, void@manifault.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 18 Jun 2024 11:38:32 -0700 you wrote:
> New versions of bpftool now emit additional link placeholders for BPF
> maps (struct_ops maps are the only maps right now that support
> attachment), and set up BPF skeleton in such a way that libbpf will
> auto-attach BPF maps automatically, assumming libbpf is recent enough
> (v1.5+). Old libbpf will do nothing with those links and won't attempt
> to auto-attach maps. This allows user code to handle both pre-v1.5 and
> v1.5+ versions of libbpf at runtime, if necessary.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpftool: allow compile-time checks of BPF map auto-attach support in skeleton
    https://git.kernel.org/bpf/bpf-next/c/651337c7ca82

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



