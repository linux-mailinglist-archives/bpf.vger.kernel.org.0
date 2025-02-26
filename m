Return-Path: <bpf+bounces-52607-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1839A453BA
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 04:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C882716D4CA
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 03:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B596225788;
	Wed, 26 Feb 2025 03:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7eBb1DU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0609B225776
	for <bpf@vger.kernel.org>; Wed, 26 Feb 2025 03:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740539401; cv=none; b=nYKTfpR9tGTSqrTh8CV0gFc+xFAeHo91prTHxW2tPBJaMAMMj0aXkvVTxODWobVL9+HY18wLdzmxxHRux4SeUl4EvGD27GDntzxQqTkEX3SF3U+wo7FxVsuYt0TvaZ7UnFgSB9gKhbJuBNYPw/BnmrwiiSESx9ucLRPGzq6KsfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740539401; c=relaxed/simple;
	bh=CbsCNZbm/IGazELtRNTRHkCId0ALHme/DKXjQE69HTk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UocEqIWxrsx9aQlQfzhOTYSIJyMQZf2phzBxGhbtTP8/bcSnnU5N/9qY8PqN4GNyATNPyDUpWn2QK9noYxOdSiVFODnbI1l0GgF7wYcw6WuDDdd+1i4hQ5Jpi0w0Buiadd/ged3a914/aTeyyJCsj44jpc7Y55SbCVfyYC/mEdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7eBb1DU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B0E7C4CED6;
	Wed, 26 Feb 2025 03:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740539400;
	bh=CbsCNZbm/IGazELtRNTRHkCId0ALHme/DKXjQE69HTk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=i7eBb1DUe/SVwg429TYecV12/4d0inalw11lkDGAhMhhh3nuQna3jxBQaLIHXUp5D
	 RFmlNrjgDX6n2H3yxNvyBBxviv/hTKzd8CqgTY2iCR6TPkrQeHcx/OksofapVc6YPw
	 TldBwbDDm1irVqiWBk4nBnhjx5UvFk+usSxsS3MlrPIPAKnBDTGMF1m9nNuoo+rbJA
	 SRfE+m2NJ8eMXZ0jNnVQq90S+l0gXLttfSn/ud12ivRQXew/YzzI7d+TMf0GCC0taV
	 TuHs0WuYrkoDchUNXNzAxlv2Os3EQQl30WDC5kNEzVSI9qnP4jX4/oaikLo1Lcn5VL
	 dLDPBWJ6n8btg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710FB380CFDD;
	Wed, 26 Feb 2025 03:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1] bpf: abort verification if
 env->cur_state->loop_entry != NULL
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174053943199.217003.4585355505255245911.git-patchwork-notify@kernel.org>
Date: Wed, 26 Feb 2025 03:10:31 +0000
References: <20250225003838.135319-1-eddyz87@gmail.com>
In-Reply-To: <20250225003838.135319-1-eddyz87@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, andrii.nakryiko@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 24 Feb 2025 16:38:38 -0800 you wrote:
> In addition to warning abort verification with -EFAULT.
> If env->cur_state->loop_entry != NULL something is irrecoverably
> buggy.
> 
> Fixes: bbbc02b7445e ("bpf: copy_verifier_state() should copy 'loop_entry' field")
> Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1] bpf: abort verification if env->cur_state->loop_entry != NULL
    https://git.kernel.org/bpf/bpf-next/c/f3c2d243a36e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



