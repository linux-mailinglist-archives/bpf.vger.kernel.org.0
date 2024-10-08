Return-Path: <bpf+bounces-41173-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA09993CA8
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 04:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACD332858FF
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 02:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F901E535;
	Tue,  8 Oct 2024 02:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qKxnwhRi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BC8125A9;
	Tue,  8 Oct 2024 02:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728353430; cv=none; b=Z0KXHyef43O5SqaOMdGyk3oFKAU1CPzGR1TmBFdwjY7nz8FM3K8uK9jOx3sY8guxh/8wJwmkDCl8xQUwSY+mufkbXF2+u3lJzwcKKSZcEUeSwJDvcdr7D8/CboJElpbRadh1rXBkmg+FBqW0HLdPPCb4Bk8uitrV8ZCp7Qg1AGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728353430; c=relaxed/simple;
	bh=5VvY/3JQbZsRAcFU4w9O+RUiuCXNDKWwQnc2j7YruLk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bBcU2KIZuX2fVqj/0ZtzWqgW01x0JDd/j7UNUUHZ/rKZqbKXW5gcitpd9dYc7uJWWHMyowyPl4UEVBsrQTm9sXZWw0H3mxENJFLtIecbAVvGl98nUoyV/DxAmpzSHQViE33hPcvZ4eoS1FHTv8Cx1q0b8jxgqb2J/MNKc8WBMg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qKxnwhRi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62829C4CEC6;
	Tue,  8 Oct 2024 02:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728353430;
	bh=5VvY/3JQbZsRAcFU4w9O+RUiuCXNDKWwQnc2j7YruLk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qKxnwhRio5JqxZCnKoKW7UK+JXTFpCJWPKKKMZEiigKP7/NS8NttVDCQdhB7D+sGC
	 k/Z6i7/hJ2wBcLQVXE0kIYxgKLezantzM5eji20mAUmpcMfKFRt1q5hCtxGXzybs25
	 xC+FDE/YV5Bs75LX2sR0Xvl8RhQy+oVDVMyuOsR1TCqvaMcM5i6mAYLIutvRhWDRgY
	 +0a9mQA/d0yOOQ4hKazg+xZnw0X19y9Kb+erEypmts0B5Q66IRvIK8DMAMuzs+mMAg
	 I9BfoTJhyiGoPcsDysxfjANrUkKJPbh5FRdzhnydhjtjNu00/Klx5tgcoVB/Tf9uE9
	 B+PiP8cledemQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0693803262;
	Tue,  8 Oct 2024 02:10:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 1/5] netkit: Add option for scrubbing skb meta
 data
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172835343452.49945.13615267856776299352.git-patchwork-notify@kernel.org>
Date: Tue, 08 Oct 2024 02:10:34 +0000
References: <20241004101335.117711-1-daniel@iogearbox.net>
In-Reply-To: <20241004101335.117711-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: martin.lau@linux.dev, razor@blackwall.org, kuba@kernel.org,
 jrife@google.com, tangchen.1@bytedance.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (net)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Fri,  4 Oct 2024 12:13:31 +0200 you wrote:
> Jordan reported that when running Cilium with netkit in per-endpoint-routes
> mode, network policy misclassifies traffic. In this direct routing mode
> of Cilium which is used in case of GKE/EKS/AKS, the Pod's BPF program to
> enforce policy sits on the netkit primary device's egress side.
> 
> The issue here is that in case of netkit's netkit_prep_forward(), it will
> clear meta data such as skb->mark and skb->priority before executing the
> BPF program. Thus, identity data stored in there from earlier BPF programs
> (e.g. from tcx ingress on the physical device) gets cleared instead of
> being made available for the primary's program to process. While for traffic
> egressing the Pod via the peer device this might be desired, this is
> different for the primary one where compared to tcx egress on the host
> veth this information would be available.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/5] netkit: Add option for scrubbing skb meta data
    https://git.kernel.org/bpf/bpf-next/c/83134ef46093
  - [bpf-next,v2,2/5] netkit: Simplify netkit mode over to use NLA_POLICY_MAX
    https://git.kernel.org/bpf/bpf-next/c/0ebe224ffce8
  - [bpf-next,v2,3/5] netkit: Add add netkit scrub support to rt_link.yaml
    https://git.kernel.org/bpf/bpf-next/c/7b9b713b8ef3
  - [bpf-next,v2,4/5] tools: Sync if_link.h uapi tooling header
    https://git.kernel.org/bpf/bpf-next/c/107525833bce
  - [bpf-next,v2,5/5] selftests/bpf: Extend netkit tests to validate skb meta data
    https://git.kernel.org/bpf/bpf-next/c/716fa7dadf11

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



