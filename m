Return-Path: <bpf+bounces-58161-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B282AB60AD
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 04:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA9F81B62408
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 02:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951C31DEFFE;
	Wed, 14 May 2025 02:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tLCJv1uH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A9917C220
	for <bpf@vger.kernel.org>; Wed, 14 May 2025 02:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747188592; cv=none; b=QWF5kb2Xq8iwi3aeX0qoYuc70P6sv9kskt4ayl8+OUAGNZrzdGf6KltRnyY85myllxCccF4n0PWHzfS4NtmmrLBZhqoqqEvFRQ+p+vh4CQD1B/vAScOh3of+RsOTCOD4eVgbtHeyjdhzfutJKN8/9zRIaHzoywDuXjJrHV6hS0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747188592; c=relaxed/simple;
	bh=5nyk0tnh4+M8Ef7CnRxH/YbNKkSW0uxoOQHIBtRTrNo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GAU53SAHu5RTFIAPWhw0hVeElWd1zsbeWzrxVebnPc7yfQav5v1r3G4u0LgD/mMbfS+mRDsWc/t8wg9QlyjFtBa0j6vDEdrLdBrpYjKwTqIK5Ik2bkt2dffVkPt2+a6LM4uHGnEQKNoWZWh9+0NtP+7iypd0U2lHUAJ0hJWg51c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tLCJv1uH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD09C4CEED;
	Wed, 14 May 2025 02:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747188591;
	bh=5nyk0tnh4+M8Ef7CnRxH/YbNKkSW0uxoOQHIBtRTrNo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tLCJv1uHxlZBWQpRd5eYWf3QazZs17XCjmlu8+ekiQgfiAxTspTUns21R+C/wbX/M
	 B2nb6oHD+BMXX2cUyfCl5MO+kdMSHD62Z/vVcpRIWaxcMGDXbn/ucNibDyJIPCpKar
	 AJB2XXiIYj78I74WUy3tXpgHTvwzmXOEK4kH/7bPi8MJGrscNXLM1WuJtroaELNTut
	 tHO+gVzgM5jVw8kCye9NUth5bBQAY+QHI+h9lvB+MVHEfFIUFLOgca2Bx2lRmsZAkP
	 JsxWX9WTCgLdOTEAqKKmZbW8wGT1yZoChgjJhzr5Bm/4Fjd2pUDcagiQDzt7y3ju5d
	 MsO43u7iQlvdQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3402A39D61FF;
	Wed, 14 May 2025 02:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] bpf: Add __prog tag to pass in prog->aux
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174718862901.1850334.4509034023326195141.git-patchwork-notify@kernel.org>
Date: Wed, 14 May 2025 02:10:29 +0000
References: <20250513142812.1021591-1-memxor@gmail.com>
In-Reply-To: <20250513142812.1021591-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, tj@kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com, kkd@meta.com,
 kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 13 May 2025 07:28:12 -0700 you wrote:
> Instead of hardcoding the list of kfuncs that need prog->aux passed to
> them with a combination of fixup_kfunc_call adjustment + __ign suffix,
> combine both in __prog suffix, which ignores the argument passed in, and
> fixes it up to the prog->aux. This allows kfuncs to have the prog->aux
> passed into them without having to touch the verifier.
> 
> Cc: Tejun Heo <tj@kernel.org>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] bpf: Add __prog tag to pass in prog->aux
    https://git.kernel.org/bpf/bpf-next/c/bc049387b41f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



