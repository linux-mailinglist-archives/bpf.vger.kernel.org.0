Return-Path: <bpf+bounces-38564-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E1C966659
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 18:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 122D21F26478
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 16:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9201B86D6;
	Fri, 30 Aug 2024 16:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/waq+62"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A691B5EC2;
	Fri, 30 Aug 2024 16:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725033626; cv=none; b=mqvBSiet97zlpt06oICT5poZQMUK90EhlSYKYA6y+LbghQ5uP4beJCyhOoOqU7dAsyhChg0hfT5VWg6UvOiVPUmZpAX/8gzTvI2XjHM7AH46tMv//fT+XNhVz6KSZytudEqexJNdQfeuYbDk7fs5hzLXnGVsNLlu6YbxDX73vJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725033626; c=relaxed/simple;
	bh=248ECo2yfsKcAquPHD4bXLciDXt4dXthlnnElfhvepM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Yu2FCHEqc28Z2TREQR1JXrybd+cH3NXaFc44r5B5u4pjBb6CEW41TH09iT7YJfJjFAy9hsDf2oatWxtFTz//X5sWov58gl8oPKbsg7OKN3Nm9MUPWWrPGwJpG2USrW/D2bmQoaGSH0FCu7OcZArdODiroirU40xOnjJIlKPmhOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F/waq+62; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21CCAC4CEC9;
	Fri, 30 Aug 2024 16:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725033626;
	bh=248ECo2yfsKcAquPHD4bXLciDXt4dXthlnnElfhvepM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=F/waq+62DoXgGkQitmjBVhJTL+dDVzk7slAvAYHjvhc1YfRFyIGR75AMpp+lyPxoQ
	 lFgPrWkzpAZYmHICUHbbmhug7m5r0NtQJ4chgV276UDt9S8DM+CxmUaD6OR1UDBWfD
	 vO/kvMX/vPFBeMCYPGdG+sPsP1WYfRHh7eDcF7DjLsOpvAO4LIpCrRCJJSj+b5Q4V4
	 /mzxzp91Av21dL0+kt/uKRF2DV9mlthCTa8uTXj+4dW2xgNaYNmO+mlyYFS/zJZKiP
	 t6gmhOIyD1eCNpFO82rskb6sGMXbJnU+ACn0kDj1g9WaoRZ0iwR+U2Zem/g4OBY6Zo
	 3jRAabmWGLQyQ==
Received: from ip-10-30-226-235.us-west-2.compute.internal (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B837B3809A82;
	Fri, 30 Aug 2024 16:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next RESEND] bpf: Use sockfd_put() helper
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172503362774.2640228.3124163275432986124.git-patchwork-notify@kernel.org>
Date: Fri, 30 Aug 2024 16:00:27 +0000
References: <20240830020756.607877-1-ruanjinjie@huawei.com>
In-Reply-To: <20240830020756.607877-1-ruanjinjie@huawei.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 30 Aug 2024 10:07:56 +0800 you wrote:
> Replace fput() with sockfd_put() in bpf_fd_reuseport_array_update_elem().
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
> v1-> RESEND
> - Use bpf-next instead of -next for commit title prefix.
> - Add acked-by.
> 
> [...]

Here is the summary with links:
  - [bpf-next,RESEND] bpf: Use sockfd_put() helper
    https://git.kernel.org/bpf/bpf-next/c/65ef66d91803

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



