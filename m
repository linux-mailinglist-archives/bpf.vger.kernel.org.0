Return-Path: <bpf+bounces-27835-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA0C8B27E8
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 20:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED5AF1F21982
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 18:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F8814EC72;
	Thu, 25 Apr 2024 18:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4kHqWhL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6012814EC45
	for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 18:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714068630; cv=none; b=cubQzd5nMefa4EOr79LPj08BBRviYNkpV3n1FVZLEnxWSahVRXHGDXsC4KwzG2xzMhP4VbjMaiVYe5gbubdYqUodJUpJ8Ht60cnxosJqWwNi3y9sSqr7/zOzQlgYXpA6KCAsgjHbZxnHvdCa0+CYsmtmpQ5btAnq+8bNRAtzziI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714068630; c=relaxed/simple;
	bh=cEptmY9fYHTATGkdufU+UaxnZwvcmMNuIDTGjhSiRp8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=b1w0qvCRgR59PTCHcVMbTrKWm+6rD+rCMDX3BO0uAUnghv8/A/v0VUlupC2QBtdAN7Zc7rBycz+lCKLnq0Eg5oAcnA4r+6rXuWolDCqoKI27V3x8x36krTdalU/phfEDdKfJv2JlylCq5Mae5vD9FuF/QvHVKQgXTUwwM+kH2jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4kHqWhL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3259C113CE;
	Thu, 25 Apr 2024 18:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714068630;
	bh=cEptmY9fYHTATGkdufU+UaxnZwvcmMNuIDTGjhSiRp8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=N4kHqWhLAWiDf1eC3wvrr53CWWk3ptJX4d4H2ancJbTC8GFNb4U4lspZifQ0p238K
	 Mqp566++i0DDXow2q8RdtZ1hb7qYwpTHKklTDZcolNmsXt7mmBQnlDU19Y0xnjxhrk
	 a5dX7BIdq1nPRD+o5gODBg5twqzq6IZ4Da2VPvQ+4D7HoyaKfSc0MfqiklT4PYXTlS
	 UE7WN7AKLbE2v+aFzW4L2F3XXk2ItekzoZyV9WzLzYiokF9MFAEE4bSJufL1X/I2BH
	 ELFSva3qhfn1yEnFIw4XPUgcoq6dvGPu3q4sVxf5qBhbCffoXPSi10rCLSqIaoFe4I
	 3q65kwdsrhJXg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DF7A7C43140;
	Thu, 25 Apr 2024 18:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Add bpf_guard_preempt() convenience macro
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171406862991.4522.12565458124125428485.git-patchwork-notify@kernel.org>
Date: Thu, 25 Apr 2024 18:10:29 +0000
References: <20240424225529.16782-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20240424225529.16782-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org, memxor@gmail.com, eddyz87@gmail.com,
 kernel-team@fb.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Wed, 24 Apr 2024 15:55:29 -0700 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Add bpf_guard_preempt() macro that uses newly introduced
> bpf_preempt_disable/enable() kfuncs to guard a critical section.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Add bpf_guard_preempt() convenience macro
    https://git.kernel.org/bpf/bpf-next/c/8ec3bf5c31d2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



