Return-Path: <bpf+bounces-40290-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 531C09856CD
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 12:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E50991F2525D
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 10:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155AF15F33A;
	Wed, 25 Sep 2024 10:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKAinrEv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938D01EB36
	for <bpf@vger.kernel.org>; Wed, 25 Sep 2024 10:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727258432; cv=none; b=LxC6LNsgJNlsVQo16FYyZrhPswBSCcIVM6pafdS8vCBM8A3gYIyRjFDzrfHTAtv/mhJQwRK6Za9SIPIJsDQjmM3KaT3y5JOAGpApXn9v+ZTrcAU1Tl9dXFVEJhGucZb4h6EeS+UfgUxVFoz2OG/15EzICEZf6DNj1H3zBmpz7q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727258432; c=relaxed/simple;
	bh=eERZGMWbRJzMNCCn1Tx5e5SesAJ4R64VEqIQ63cUAtY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PdLagBPrx0DQO6SgiQfJmSkW5T9EDVBcTbm/gIK5J1odBmT2f56IHC0ztsQ7cfkixd+tMkJcGX+pDhpb+fMRs2KBM8xzivxzGoafe63eSwVdrqVkdq7sZU4Bfi5pO7bB8DAHQuszUkaT5kDVDEVcL2SoCEPdzfyf9P/FuWAcy3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKAinrEv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 160B2C4CECD;
	Wed, 25 Sep 2024 10:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727258431;
	bh=eERZGMWbRJzMNCCn1Tx5e5SesAJ4R64VEqIQ63cUAtY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PKAinrEvo3lDuKLFUPE9zDQkI4mWRVOxGFyJPUncJil6ZDpy8OpCDjC4OMMR0otNi
	 J/dlzfQ01Fp3rXm4FLWvJkpZ2UT0GcgEhEp3O067fBEXY9q1Qe4EAIG8CVrO+adNwN
	 DbRAO4Qlh4EB5QaQLP6B0oZ7Vct+key8NtOzSVkIwDtvJZ2mxoKJIdk8YCpGepZcGz
	 mC6TN1YC9GMezpdl8vWd90SichL/nBED8LB5JuNRlRs/5heVm5dxkc+IU4VgnSgscG
	 T0y9rmeqxzD5+MNUH57cS+wvnihAC+8J2ViMp4yEFU/2a5aUV+jqEA3zOkHuZcaOPG
	 nyE2gehWdVfDA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADB873809A8F;
	Wed, 25 Sep 2024 10:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/2] selftests/bpf: Fix uprobe consumer test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172725843324.522662.7812055814094907335.git-patchwork-notify@kernel.org>
Date: Wed, 25 Sep 2024 10:00:33 +0000
References: <20240924110731.2644249-1-jolsa@kernel.org>
In-Reply-To: <20240924110731.2644249-1-jolsa@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 ihor.solodrai@pm.me, bpf@vger.kernel.org, kafai@fb.com,
 songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@chromium.org, sdf@fomichev.me, haoluo@google.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 24 Sep 2024 13:07:30 +0200 you wrote:
> With newly merged code the uprobe behaviour is slightly different
> and affects uprobe consumer test.
> 
> We no longer need to check if the uprobe object is still preserved
> after removing last uretprobe, because it stays as long as there's
> pending/installed uretprobe instance.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] selftests/bpf: Fix uprobe consumer test
    https://git.kernel.org/bpf/bpf-next/c/510c654dfa3b
  - [bpf-next,2/2] selftests/bpf: Bail out quickly from failing consumer test
    https://git.kernel.org/bpf/bpf-next/c/9eac650cd120

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



