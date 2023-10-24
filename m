Return-Path: <bpf+bounces-13133-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6457D5204
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 15:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72B28B20CE6
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 13:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14702AB2F;
	Tue, 24 Oct 2023 13:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMnBi4fA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BF2134B1
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 13:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9BD39C433CA;
	Tue, 24 Oct 2023 13:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698154823;
	bh=GuoeLtNsixLSsGotdqVqSnXzqMDuAs393mlNbp65ecU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IMnBi4fAgNmzTXNWLENOiDt/X11Fjy7zhHGnHacRk304p54dZf7+bGBu771HipL1B
	 Wd3eBJexyT63LtyrtplaA8D3Y2D9vn4JFCP2LSFQU+706pcZeyBeZq/Q67Mkc3PzPP
	 ffjARFdFeUvu5EwCjsfAot61CqhUUrFEJdhZ9Y0JTdDDwY+lGyKjqmz3r8BRbmsOhy
	 3DCzRiTsDO/ECLR1+qdGVgTM7Q0V5vgBDulCYmRAOdz33Zx3qlGl+Pd3z+iHAReUDg
	 qra4N/RbY1uKPT2g9M7SNpd1Pw94tnM+CLSX8XjG076awUOZfHFD6lhrIk5xKysXWP
	 sPhEBu/k50u6g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 82AC4C04D3F;
	Tue, 24 Oct 2023 13:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 bpf-next 0/7] BPF register bounds logic and testing
 improvements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169815482353.9646.13398548339433732959.git-patchwork-notify@kernel.org>
Date: Tue, 24 Oct 2023 13:40:23 +0000
References: <20231022205743.72352-1-andrii@kernel.org>
In-Reply-To: <20231022205743.72352-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Sun, 22 Oct 2023 13:57:36 -0700 you wrote:
> This patch set adds a big set of manual and auto-generated test cases
> validating BPF verifier's register bounds tracking and deduction logic. See
> details in the last patch.
> 
> To make this approach work, BPF verifier's logic needed a bunch of
> improvements to handle some cases that previously were not covered. This had
> no implications as to correctness of verifier logic, but it was incomplete
> enough to cause significant disagreements with alternative implementation of
> register bounds logic that tests in this patch set implement. So we need BPF
> verifier logic improvements to make all the tests pass.
> 
> [...]

Here is the summary with links:
  - [v4,bpf-next,1/7] bpf: improve JEQ/JNE branch taken logic
    https://git.kernel.org/bpf/bpf-next/c/42d31dd601fa
  - [v4,bpf-next,2/7] bpf: derive smin/smax from umin/max bounds
    (no matching commit)
  - [v4,bpf-next,3/7] bpf: enhance subregister bounds deduction logic
    (no matching commit)
  - [v4,bpf-next,4/7] bpf: improve deduction of 64-bit bounds from 32-bit bounds
    (no matching commit)
  - [v4,bpf-next,5/7] bpf: try harder to deduce register bounds from different numeric domains
    (no matching commit)
  - [v4,bpf-next,6/7] bpf: drop knowledge-losing __reg_combine_{32,64}_into_{64,32} logic
    (no matching commit)
  - [v4,bpf-next,7/7] selftests/bpf: BPF register range bounds tester
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



