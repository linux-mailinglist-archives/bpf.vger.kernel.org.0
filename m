Return-Path: <bpf+bounces-44077-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 132429BD831
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 23:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBC2B1F23073
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 22:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F37921503B;
	Tue,  5 Nov 2024 22:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQwAafzX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54D51FEFCD
	for <bpf@vger.kernel.org>; Tue,  5 Nov 2024 22:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730844645; cv=none; b=aOwJSYo17Ps6E8AbEQmHK/V2yMhNimsiRCAL7Er+cC2+k27JVXDiG3EyFXxE/9V9/fO707FZv+25ip/lwaWp90ntrIkML0kKynvEfX8Le6cHTOEv7Fp587RWAyshhyqbgMRfi9bwSK4v6+GNMiG7y6nNryoZE0CTP72YHFbf7cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730844645; c=relaxed/simple;
	bh=apquenW4QXCiHK4OM4FTG64xTZRE2I++3niWYvmPvDI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GAtO2iBsRP6dpoDF0lDLob/jtQLriWjXP/Srr84QHKKktErmEoNTjnlxkr6wehYaOETd5tjfSz1q/aMYXGNmVy8lmS8FyPvs2t9Wxu4E+6R9WcLs6zJiXlRRlW3dXn/oJc0llM+R701borMFgJBNN8fcPMRIYzSVOJp/jimS0SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQwAafzX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DDBDC4CECF;
	Tue,  5 Nov 2024 22:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730844645;
	bh=apquenW4QXCiHK4OM4FTG64xTZRE2I++3niWYvmPvDI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cQwAafzX2LiF6Pqls/CAXJxaAgSPFCnSxQZ0n84v18TiSxlUFeQENZxBvkx1UPNPR
	 J6jwZSN/d7FHWJVKzR/grWNsvtjGERLjXswJBTKj1g22X2XCRhLANf6dT6YBaPAiDO
	 cQwUW66vJA0+qD9CmWnFoMNaa7lZRmGoW/P9jocAKBxyMp0OKXRL55z18YYvKI/7dU
	 hwE0b2LSlUAEGyI1WLkMdHdvoxG/DrZnksb/vArmJrE6ebi6S+LPtrb9IbSZe2IkHl
	 5U3rO4uCyA+vfYqZ6bjB7oNlERguF+x2cfvqiBMDC5J1M3CnJ0QwKvaPkOys2g4nNk
	 1u9BeD4Su9WKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCC73809A80;
	Tue,  5 Nov 2024 22:10:55 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] selftests/bpf: Use -4095 as the bad address for bits
 iterator
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173084465451.708559.9556991877632475772.git-patchwork-notify@kernel.org>
Date: Tue, 05 Nov 2024 22:10:54 +0000
References: <20241105043057.3371482-1-houtao@huaweicloud.com>
In-Reply-To: <20241105043057.3371482-1-houtao@huaweicloud.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, alexei.starovoitov@gmail.com,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org, haoluo@google.com,
 yonghong.song@linux.dev, daniel@iogearbox.net, kpsingh@kernel.org,
 sdf@fomichev.me, jolsa@kernel.org, john.fastabend@gmail.com,
 iii@linux.ibm.com, jungbu2855@gmail.com, laoar.shao@gmail.com,
 houtao1@huawei.com, xukuohai@huawei.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  5 Nov 2024 12:30:57 +0800 you wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> As reported by Byeonguk, the bad_words test in verifier_bits_iter.c
> occasionally fails on s390 host. Quoting Ilya's explanation:
> 
>   s390 kernel runs in a completely separate address space, there is no
>   user/kernel split at TASK_SIZE. The same address may be valid in both
>   the kernel and the user address spaces, there is no way to tell by
>   looking at it. The config option related to this property is
>   ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE.
> 
> [...]

Here is the summary with links:
  - [bpf] selftests/bpf: Use -4095 as the bad address for bits iterator
    https://git.kernel.org/bpf/bpf/c/6801cf7890f2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



