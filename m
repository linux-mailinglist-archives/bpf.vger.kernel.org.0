Return-Path: <bpf+bounces-43405-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 322849B5219
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 19:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D159E1F2444C
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 18:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9071FF7B9;
	Tue, 29 Oct 2024 18:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LDTIP5Qp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C6C199951
	for <bpf@vger.kernel.org>; Tue, 29 Oct 2024 18:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730227826; cv=none; b=IgzJBHBJWtZlsTVsGUmtu2YYW4Ut91MNJZseYF0g8zbWRR84or5jXxLWis1ohjgv32R7NcMtORh5jcKQstX6I6w2cIlJCwKiFqTkPY51lylzyFSq4OI5bbmQErHQPMbF3i6E/CMh3N1YXjom1F8UEzfdgbA+FsJjQtEtvVVNWUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730227826; c=relaxed/simple;
	bh=/lGVWoGNxtDm/x7PQ3JQJfUbxeSYKMh3ynV59R/6tRs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IycTLQFjMlsEoblk2M6hRQxyj+BQbIVWIOlBUfTLQPbtIwlZyAKUZRNY/QUUM1uAz43+G2qJo/pqb0Zp0Wz3CbQNVW0DNgovpHxSymFe+xYXp/LhuZhEJcfUWOSogqkYoMaFaqZm0XYyIGdfZHJoixCes2Xbg+vkTTedhgfM9i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDTIP5Qp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E00F8C4CECD;
	Tue, 29 Oct 2024 18:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730227825;
	bh=/lGVWoGNxtDm/x7PQ3JQJfUbxeSYKMh3ynV59R/6tRs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LDTIP5QpdNkbwDVnMUEfdL9Hv3W22bbsC0+FKnKJoGw96Tmy42BhV6cj3TjWMPCA4
	 qR2ZOLem6PmSkit7vKcZTczx/q05OxljRPwltZSBywAX9D8IZrJ9qB4T4u3i4G4X/t
	 bJIAMaV/cTS3XOY36lW1P2srpyKoNBS2UJ0GciuWT6HUJ2gY6p2wfcJUBlPCDDXsaz
	 OwIhixVFMBPFhBZM0TuMmQjFMmzUlFxo7qzkVsmkOs+6iXnklASF2blxVGMma0g328
	 ogj/0uerl4z+iGvpTqdQm9pFjZ1+DtG+Q7vi98jn3jr9Mjm1INYgIrb0j2U9xJRYpJ
	 L1GBxPzbUvR7g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE70380AC08;
	Tue, 29 Oct 2024 18:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2 1/2] bpf: force checkpoint when jmp history is too long
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173022783352.787364.14183224290672600419.git-patchwork-notify@kernel.org>
Date: Tue, 29 Oct 2024 18:50:33 +0000
References: <20241029172641.1042523-1-eddyz87@gmail.com>
In-Reply-To: <20241029172641.1042523-1-eddyz87@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,
 syzbot+7e46cdef14bf496a3ab4@syzkaller.appspotmail.com

Hello:

This series was applied to bpf/bpf.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 29 Oct 2024 10:26:40 -0700 you wrote:
> A specifically crafted program might trick verifier into growing very
> long jump history within a single bpf_verifier_state instance.
> Very long jump history makes mark_chain_precision() unreasonably slow,
> especially in case if verifier processes a loop.
> 
> Mitigate this by forcing new state in is_state_visited() in case if
> current state's jump history is too long.
> 
> [...]

Here is the summary with links:
  - [bpf,v2,1/2] bpf: force checkpoint when jmp history is too long
    https://git.kernel.org/bpf/bpf/c/aa30eb3260b2
  - [bpf,v2,2/2] selftests/bpf: test with a very short loop
    https://git.kernel.org/bpf/bpf/c/1fb315892d83

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



