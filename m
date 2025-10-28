Return-Path: <bpf+bounces-72585-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DA6C15D68
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 17:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 609C0189A8FE
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 16:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0403A33F8C6;
	Tue, 28 Oct 2025 16:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7twYd5N"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7548129ACC0;
	Tue, 28 Oct 2025 16:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761669030; cv=none; b=rGa0kb3k+wNbNT11nNlnpYXdLJomVHR4LNQUEKjMjNlynHeQ/dcZmvmXESuFsY9Z8SkRWVCEFYUqDHOeYLrLYend6po43aed8hOBzdmmwfYtqKudTr4BmyTfI/LbW6RiwNGTKzy9ZUL8oE8+rd6abAnjUCLV0fN8IX2lFo976Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761669030; c=relaxed/simple;
	bh=Ju7I/4XLe5wPX3bvjVLHfU8M+za/o+NbpqhxOXUvqR0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NSwHDSV7lMiv1Kn2jeSPN6kUi3PWQfrofm413UoiwsQM80iHxKJzIPIT/t/rLU6jTB7z957T4SLPRQKhp9kdw3lWkZxcfSnIuXO+Kj5mpn6rVaKiT7Y4lZ5bvNgWVORz4IOWrzZoA6lpKmUH3oBJA2Y3tjSKOQRA6f31GudTCuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k7twYd5N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 080AAC113D0;
	Tue, 28 Oct 2025 16:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761669030;
	bh=Ju7I/4XLe5wPX3bvjVLHfU8M+za/o+NbpqhxOXUvqR0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k7twYd5Nx5zVwcObQ7aVEzjMO8kw630B/sM4yLoO2/g8WAAwqseUoYw90RyF+RTG6
	 lYmG4if8/fbxqjoS5NebhIFr5/ZRFe+1+MKu2gFoz9SciQWV6x+OXJYWbrwZLQiiZu
	 l3Oisy9fFg2gRDUREaQ/J8aEMx8mi5D/oywzPD2gK2vLvF/oyRJ9s1W0aq70pDxswo
	 IyKQSBbIvH2UFDiU98q3hJFHo0AFK1oIkJrsv9HdSlCNVzLjlGWut0+wL1NHWdQ//e
	 WR7f66Cth+5P0jPbaDX4fozMUnh+NcwEwSIHXc6z36bLxrypb8QR8RIxXjpgJ6bhQ3
	 j3HrGbaiHfoYA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE4E39EFA69;
	Tue, 28 Oct 2025 16:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V10 RESEND 1/2] bpf: refactor stack map trace depth
 calculation into helper function
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176166900751.2299764.16778692195336587842.git-patchwork-notify@kernel.org>
Date: Tue, 28 Oct 2025 16:30:07 +0000
References: <20251025192858.31424-1-contact@arnaud-lcm.com>
In-Reply-To: <20251025192858.31424-1-contact@arnaud-lcm.com>
To: Arnaud Lecomte <contact@arnaud-lcm.com>
Cc: alexei.starovoitov@gmail.com, andrii.nakryiko@gmail.com,
 andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, haoluo@google.com, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
 martin.lau@linux.dev, sdf@fomichev.me, song@kernel.org,
 syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Sat, 25 Oct 2025 19:28:58 +0000 you wrote:
> Extract the duplicated maximum allowed depth computation for stack
> traces stored in BPF stacks from bpf_get_stackid() and __bpf_get_stack()
> into a dedicated stack_map_calculate_max_depth() helper function.
> 
> This unifies the logic for:
> - The max depth computation
> - Enforcing the sysctl_perf_event_max_stack limit
> 
> [...]

Here is the summary with links:
  - [V10,RESEND,1/2] bpf: refactor stack map trace depth calculation into helper function
    https://git.kernel.org/bpf/bpf-next/c/e17d62fedd10
  - [V10,RESEND,2/2] bpf: fix stackmap overflow check in __bpf_get_stackid()
    https://git.kernel.org/bpf/bpf-next/c/23f852daa4ba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



