Return-Path: <bpf+bounces-60216-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB7CAD413E
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 19:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E201E17BD9E
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 17:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC3C245028;
	Tue, 10 Jun 2025 17:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xtr7RKbo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE71F21322F;
	Tue, 10 Jun 2025 17:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749578051; cv=none; b=Tag753WT6AH1VLeynnimKW5DYwN0EiU+vZpnh44B2EPdyd7zr3jGARQUZvSjI275jHa0sps9hCOvKQfyVqwinUpt2maUGOj3tfM+OFZ+rhoCPCsTBMqUflWZIRVr2ux1LnFJC0IqYBtmoOv/uvBJ1EpXEHiawhd1YoCWtiB+6I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749578051; c=relaxed/simple;
	bh=g8srZIuC7DXP+YZfVbIrDXDZGP9WZWOx3s6txz1uaKc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OnbYQTyiXFIGm4y45JyuQNJ4KC/WaksI47YkZB1nshdHaBgKEB+6tcJWjh26xwU/RIOPoLbjV+2zShFCnd16mnzFug3J5xFWoksi+ZiEM8MKgxiP8/EqB7z4O9DXi8tlWgdqzaUA1L3WIzuOixHKXIZ6B0pePQkmfGcMa9NHHpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xtr7RKbo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AF82C4CEED;
	Tue, 10 Jun 2025 17:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749578051;
	bh=g8srZIuC7DXP+YZfVbIrDXDZGP9WZWOx3s6txz1uaKc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Xtr7RKbo9Iyv/pE3+vc8EYLVMRcG+P66Ci+NPkKjgeQlRjqyJa9lgGvwppo/ZcLY3
	 ZNiWzJWxvdzvrQPVTjpxzjnV0Kc4lRsICRB4PvwmbQc9RKoaoCDLk4ccTE/EHyV96S
	 hkqp1wtZGKTLhk1hx7HfAxlEzGZ0ISfpoayDjIxYZ94QRLtsHe8u6P3K8T3dPonFuu
	 VdSQCO64V59IYLLdZz5SGkXSPrnoSTtRXkk6/zksEKqQMbFAuqlugaBqTrBFzkGk4f
	 nJRq4tvXMWbONbzm8nSgrMmvJnv2Df+WeOdJI3nnhZVVCWZjgX1nT4EXQzIZlI1POG
	 sUnYE/RPwQNdg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB01E39D6540;
	Tue, 10 Jun 2025 17:54:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpf,
 sockmap: Fix psock incorrectly pointing to sk
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174957808176.2523637.14786222447534572080.git-patchwork-notify@kernel.org>
Date: Tue, 10 Jun 2025 17:54:41 +0000
References: <20250609025908.79331-1-jiayuan.chen@linux.dev>
In-Reply-To: <20250609025908.79331-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, john.fastabend@gmail.com, jakub@cloudflare.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (net)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon,  9 Jun 2025 10:59:08 +0800 you wrote:
> We observed an issue from the latest selftest: sockmap_redir where
> sk_psock(psock->sk) != psock in the backlog. The root cause is the special
> behavior in sockmap_redir - it frequently performs map_update() and
> map_delete() on the same socket. During map_update(), we create a new
> psock and during map_delete(), we eventually free the psock via rcu_work
> in sk_psock_drop(). However, pending workqueues might still exist and not
> be processed yet. If users immediately perform another map_update(), a new
> psock will be allocated for the same sk, resulting in two psocks pointing
> to the same sk.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf, sockmap: Fix psock incorrectly pointing to sk
    https://git.kernel.org/bpf/bpf-next/c/76be5fae32fe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



