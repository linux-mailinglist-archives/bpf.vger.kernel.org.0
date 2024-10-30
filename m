Return-Path: <bpf+bounces-43487-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BE39B5A1B
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 03:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4DE81C227E4
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 02:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A89D192D7C;
	Wed, 30 Oct 2024 02:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sE4mn51z"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B504437
	for <bpf@vger.kernel.org>; Wed, 30 Oct 2024 02:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730256622; cv=none; b=a9tIEhH+fzxhnhJEcBy8WEqmhI2L+Nl7Gw7jYsMY9EetSyIq2cn2trHe46+tmyBUUbi5YZGBjBU+vgHVWaYvoebl7MvOQ7DcBimNe9TSwCumeDKUgxiCoe4WRptK04nMGQvmYuYS8KMAOtQZIaJ2RblH9sPMh2Wr9P+mQkC5Yos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730256622; c=relaxed/simple;
	bh=K9AsPaQtgaVpQWzk0XjKR5RzgnSUNkcdHEHsd4onqbU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=S0UEAPtktukQkNBjSzp180mIZGUnzHVEt0Q3NLqunMFKwNdzFwh6UZawpK3oimxEDQMlWXHUVuxRT7xw3SqREV16ZkI7lHIUhOs1Fcs1bLsEKszcx7gM4yIOjU580d35q73vTk8Fs7siS5OQ7kt076h78v5qiqBFAEI7G+OBy2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sE4mn51z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4853C4CECD;
	Wed, 30 Oct 2024 02:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730256621;
	bh=K9AsPaQtgaVpQWzk0XjKR5RzgnSUNkcdHEHsd4onqbU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sE4mn51z57XGzhhh/sfcbPW43DKfmUvt3VyAcGp0gzhX7KholXiSL9qnE+CIKxfgq
	 OMQlzxNDJ6XchELfD1mTmPnJ6pwyh3ylukKAVMIcVAK/eU1ZiC7pIT7NRKA5Wdbmv6
	 CmiiyiHu5HaphJkd2J+/ecfOyuTjYuQvCtMrE90TdXKSSjBOmYTHa90Hj227V/tLKe
	 93O8COQXZo5N0w/L4NdmeEsfl3Vv836u5kLetpc7B34/GKdy3SGRRc+nCY2+mwL/1L
	 YwWW0AldIx6bIwyS0TVLH5YL3ah8g7gPwmBXqNmn2UlNHo02M3/3MIkBmf6zezYbad
	 cJWNxH7G68qEw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC94380AC00;
	Wed, 30 Oct 2024 02:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: disallow 40-bytes extra stack for bpf_fastcall
 patterns
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173025662951.895316.155312076603507081.git-patchwork-notify@kernel.org>
Date: Wed, 30 Oct 2024 02:50:29 +0000
References: <20241029193911.1575719-1-eddyz87@gmail.com>
In-Reply-To: <20241029193911.1575719-1-eddyz87@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, houtao@huaweicloud.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 29 Oct 2024 12:39:11 -0700 you wrote:
> Hou Tao reported an issue with bpf_fastcall patterns allowing extra
> stack space above MAX_BPF_STACK limit. This extra stack allowance is
> not integrated properly with the following verifier parts:
> - backtracking logic still assumes that stack can't exceed
>   MAX_BPF_STACK;
> - bpf_verifier_env->scratched_stack_slots assumes only 64 slots are
>   available.
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: disallow 40-bytes extra stack for bpf_fastcall patterns
    https://git.kernel.org/bpf/bpf/c/d0b98f6a17a5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



