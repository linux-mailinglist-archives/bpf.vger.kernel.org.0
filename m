Return-Path: <bpf+bounces-34686-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC27930145
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 22:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C8A2284C71
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 20:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4919E3FE46;
	Fri, 12 Jul 2024 20:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t0WGP/wi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBB844C68
	for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 20:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720815632; cv=none; b=BgTh03in3Cl8xHkLAbgkTYg3b49gPPjawkaKEP9btAnrCtsvLaUXKFpMxel1DTkbI/dOWMocCbuiQAqQnnZJpBJIYqVR6miksvs0fqHsf/AC1DYgMK3vmWRu9B2nucx6RJisrzpyJSRXGifTHtSnkE83dqfht/ov5xvpe366aU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720815632; c=relaxed/simple;
	bh=LnvOc2soNo2bkNy2V9Pgp/B3X0MvVxDx1a3ta4/n3EQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dI398j0OCKaG4o2anLGyWkYJ6C1t1F8QZpYG1JF6ViDLKqYcA7GG0yo4gk2VLqdMUAA0uLioGdeCQZT1CnXL+wUdTYYtNxYHZ5YkT3iLxYrpacu1e5ajj17hsi89WNsz1np87PqXqr3MxXEpiS0iQaw480NhqB+czI+xXEyyv0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t0WGP/wi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41013C4AF07;
	Fri, 12 Jul 2024 20:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720815632;
	bh=LnvOc2soNo2bkNy2V9Pgp/B3X0MvVxDx1a3ta4/n3EQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t0WGP/wimbOIwAiAHwJC/WloOOPNqS1qolPNvuqmqrfThCsTKRfWpYH+Ik6tnvq1S
	 9dTGFOrZExpb9j7/QtUsGlfyR6p/JQN9IwjKS7hH7bVUyRKRI0Ve8paz9Kf/5A6bUT
	 Md9Zq2FbBSIKwpaBCPXG7wr51OhozHy1PyNcLh5AW+R4kxw4TWMu4b/FRAw3DgDxG8
	 GmeyLvFujCi8+xg2fzXSrC4++WzIK6xmrmuFVWS5KXSn5Ow1M9lGXjzqvubKcD2oIW
	 e3gMePAnsqUb3jGk58NcRFON3DmHNEzTvqyBa6pK1X6Q0wi1+AioDFthuYApB8qwCt
	 vKSLHsqumYRNw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 27D2CC43153;
	Fri, 12 Jul 2024 20:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v4 0/2] bpf: Fix null-pointer-deref in resolve_prog_type()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172081563215.23700.10781296355063378646.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jul 2024 20:20:32 +0000
References: <20240711145819.254178-1-wutengda@huaweicloud.com>
In-Reply-To: <20240711145819.254178-1-wutengda@huaweicloud.com>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 hffilwlqm@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 11 Jul 2024 22:58:17 +0800 you wrote:
> Hi,
> 
> This patchset is going to fix null-pointer-deref in resolve_prog_type()
> for BPF_PROG_TYPE_EXT.
> 
> `prog->aux->dst_prog` in resolve_prog_type() is assigned by
> `attach_prog_fd`, and would be NULL if `attach_prog_fd` is not
> provided. Loading EXT prog with bpf_dynptr_from_skb() kfunc call
> in this way will lead to null-pointer-deref.
> 
> [...]

Here is the summary with links:
  - [bpf,v4,1/2] bpf: Fix null pointer dereference in resolve_prog_type() for BPF_PROG_TYPE_EXT
    https://git.kernel.org/bpf/bpf-next/c/f7866c358733
  - [bpf,v4,2/2] selftests/bpf: Test for null-pointer-deref bugfix in resolve_prog_type()
    https://git.kernel.org/bpf/bpf-next/c/e435b043d89a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



