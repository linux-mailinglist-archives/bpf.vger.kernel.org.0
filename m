Return-Path: <bpf+bounces-75388-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F9FC821C1
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 19:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 35E71342A80
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 18:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAC52C0F78;
	Mon, 24 Nov 2025 18:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="og9Ankol"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416421B532F
	for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 18:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764009047; cv=none; b=a4aeZsEBUt8rGXdxocwGPbBtnYPtM4kqpWqjO91yxZ72RF2BVV+hhwJ0mp08EKbQJeAsL8VS8MUgqp4FtI91Ok4iW60bzkhC8TzuDYNq25kzWj5K+fwUE05KldlMu4SIvLKD0kTyb83p6xjrXRxxvnVBTGHWw+sb13Zh2LFEWDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764009047; c=relaxed/simple;
	bh=Vs/eAhvC5OyfpJ7MjLdWaUQ8Qen1BSYVynAG6XR0sso=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Tf2BU++xy2x/Vq3O8BKpq5zGJAa7j48opIYNj2tUMG+Qwi0BA+L6er1nu/+1lDQkf/iQY/AXq728KqZ8YjLQtGCNDVqPZhb3WVSeBcsN5lflul1XYDqCV6o3xYnq+yGSLoDUDjXmhkS9VgJ7KSWsqX3+DzlCXVR5TiVSTX30BDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=og9Ankol; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCEFEC4CEF1;
	Mon, 24 Nov 2025 18:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764009046;
	bh=Vs/eAhvC5OyfpJ7MjLdWaUQ8Qen1BSYVynAG6XR0sso=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=og9Ankol2bN4u2DRK7GUWrvaEbJpaSCMoPFfaJMrG1Jvd1VF64dkIDj2vzZKdteWJ
	 DlFwW2fBcgs4Qm7upoEKXFU0h8BboQVstzOTRGZyUWQkZN14jtwRAQ8UcuyPBA4kUe
	 dNOYXXMXJkwjCmdXSm/G3QGFfVZKxYKrabkpQBqKIGFHq58IbB9JhbFqCm4YlDX2g+
	 MwgywxJoGt1n+v6NiVEoHC63ckqfj2FJJ8Adv7Oq2fp1rrtHhvXGtsz7UV7+ULOTFk
	 GA1b8oC+lOb846NTHOSDBflhr5WzCqlpw+GlqhIoohs3pOui0UCXiZgXcQTY1iLwri
	 t/oPVBTNjA7Gg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0883A86295;
	Mon, 24 Nov 2025 18:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/2] Ease BPF signing build requirements 
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176400900979.36456.12257313690030895068.git-patchwork-notify@kernel.org>
Date: Mon, 24 Nov 2025 18:30:09 +0000
References: <20251120084754.640405-1-alan.maguire@oracle.com>
In-Reply-To: <20251120084754.640405-1-alan.maguire@oracle.com>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: qmo@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 kpsingh@kernel.org, sdf@fomichev.me, yonghong.song@linux.dev,
 song@kernel.org, haoluo@google.com, jolsa@kernel.org,
 ihor.solodrai@linux.dev, john.fastabend@gmail.com, eddyz87@gmail.com,
 bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 20 Nov 2025 08:47:52 +0000 you wrote:
> This series makes it easier to build bpftool and selftests with
> signing support, removing reliance on >= openssl v3 (supporting
> openssl v1) to build bpftool and not requiring latest xxd to
> build verification cert header in selftests.
> 
> Changes since v1 [1]:
> 
> [...]

Here is the summary with links:
  - [v2,1/2] bpftool: Allow bpftool to build with openssl < 3
    https://git.kernel.org/bpf/bpf-next/c/90ae54b4c7ec
  - [v2,2/2] selftests/bpf: Allow selftests to build with older xxd
    https://git.kernel.org/bpf/bpf-next/c/ad93ba02678e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



