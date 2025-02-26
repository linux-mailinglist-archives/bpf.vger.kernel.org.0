Return-Path: <bpf+bounces-52654-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93453A46554
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 16:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 411133B65D6
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 15:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690612EAE4;
	Wed, 26 Feb 2025 15:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBCKeAqY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76114C80
	for <bpf@vger.kernel.org>; Wed, 26 Feb 2025 15:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740584398; cv=none; b=JUR9mpoHqpPTrlJxwSs/fM8FtuoH+tuAHp9tSbzfdcsnW3ZOdy7hShLtnB2oQA+/rh4o31wJvX4GfIFsnolkkqFsd/Ra2nAiNt8zWHMjFQ8hU0BesqzVZmfaxQUfmmRkuHLw+a7M3zFA0Flem5QGfTWY1veXmeAJUyAqnIL0Ze8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740584398; c=relaxed/simple;
	bh=zG9ulMUS1I//l2DTI7Hjc4IhVjQDbqtXFeuQApF+LY4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=r7YddXc57mnuntNmJ/MSfIdPHFH7DtrOq0pjhB12GdsjiAWo+32EBkJQ6K25dKoxhWZtEqvqLoiGUzSjI57TQ8gNMNrCnJGuKjQYM7JQfg9qYVpUM9JgGYGPKWyibjP+ecRLK3HO9dTfHPrU+HxQ98XdYyyCyD1DFCByQJ48pQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBCKeAqY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67FE8C4CED6;
	Wed, 26 Feb 2025 15:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740584397;
	bh=zG9ulMUS1I//l2DTI7Hjc4IhVjQDbqtXFeuQApF+LY4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WBCKeAqYO1TfkebnGc9E3q9fad+Jo5ExcR5VpFmw9XkuYVOjQKnxz4cVQxI/JBlNr
	 o+PYpIdNZIMpNLcwdgLeqPLSv8KIAFBQ+9fkMa5n+gxw9TX79jcnMY1Wfd10Qv+LAQ
	 DycW1r/FgseunP3BD9sDTz7ngIPvCyWyuGp7IH33zjE5noDGl4hpIcw1dG9V5k98zM
	 5ywdvwoI25rGT4DmdPoH8z0gLUNJE0NBgt4uyGpp0shXIKYgeP3hZH+YH93UTc5f/U
	 Xj2IzpP3Riug78oRhWgyZJu7d8F65ndMXEDU52PIrZhVvKy+SEUpk3wCaVun7pX6QT
	 2jI2K/4dCHp8g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70ED4380CFDF;
	Wed, 26 Feb 2025 15:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/2] bpf: add get_netns_cookie helper to cgroup_skb
 programs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174058442927.749473.13913556709440211868.git-patchwork-notify@kernel.org>
Date: Wed, 26 Feb 2025 15:40:29 +0000
References: <20250225125031.258740-1-mahe.tardy@gmail.com>
In-Reply-To: <20250225125031.258740-1-mahe.tardy@gmail.com>
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, daniel@iogearbox.net,
 john.fastabend@gmail.com, ast@kernel.org, andrii@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 25 Feb 2025 12:50:30 +0000 you wrote:
> This is needed in the context of Cilium and Tetragon to retrieve netns
> cookie from hostns when traffic leaves Pod, so that we can correlate
> skb->sk's netns cookie.
> 
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
> ---
>  net/core/filter.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf: add get_netns_cookie helper to cgroup_skb programs
    https://git.kernel.org/bpf/bpf-next/c/c221d3744ad3
  - [bpf-next,2/2] selftests/bpf: add cgroup_skb netns cookie tests
    https://git.kernel.org/bpf/bpf-next/c/9138048bb589

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



