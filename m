Return-Path: <bpf+bounces-4046-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B781C748411
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 14:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 723E828100A
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 12:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05A07485;
	Wed,  5 Jul 2023 12:20:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCB9747A
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 12:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EF64DC433C8;
	Wed,  5 Jul 2023 12:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688559621;
	bh=TsDebQxhlydLwXRKM7SEn15m+ZqWqY0TNb0R/6cHzjo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WQYKtZ9k0Igo2JUJhrZXgmotmR3/OAHUDEwcE6wiauSzP5WfGjqbOsJGxDhqAB4Ax
	 esESajsLrW6vdDu7Il075Ii3T5jqCk6mvlCnEFDLFvX5kl/By2W3xWTA3QIMWAfnnQ
	 AjjzFqP3pqtsnb736H4CcD+MkoUdBuCoLKoABgnjjHUAHyzIwto3aVlG3zGyCSa49G
	 uuZRjjX1uN4yLzaFuKEpRBi8bF3uRJRGwMj3MW71QsvxkAThjzxUzCIMZPS8iTjK8h
	 zGEGU2QRLr04nesFhWOoyNUtEgCUZ9TItNcSR3ik/2tHaisF/uPG7e+M0pDRS6MhfC
	 wcNpqACckmuKQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D7061C40C5E;
	Wed,  5 Jul 2023 12:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Remove unnecessary ring buffer size check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168855962087.31139.17394206661172150919.git-patchwork-notify@kernel.org>
Date: Wed, 05 Jul 2023 12:20:20 +0000
References: <20230704074014.216616-1-houtao@huaweicloud.com>
In-Reply-To: <20230704074014.216616-1-houtao@huaweicloud.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, alexei.starovoitov@gmail.com,
 andrii@kernel.org, song@kernel.org, haoluo@google.com, yhs@fb.com,
 daniel@iogearbox.net, kpsingh@kernel.org, sdf@google.com, jolsa@kernel.org,
 john.fastabend@gmail.com, dan.carpenter@linaro.org, houtao1@huawei.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue,  4 Jul 2023 15:40:14 +0800 you wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> The theoretical maximum size of ring buffer is about 64GB, but now the
> size of ring buffer is specified by max_entries in bpf_attr and its
> maximum value is (4GB - 1), and it won't be possible for overflow.
> 
> So just remove the unnecessary size check in ringbuf_map_alloc() but
> keep the comments for possible extension in future.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Remove unnecessary ring buffer size check
    https://git.kernel.org/bpf/bpf-next/c/cf6eeb8f9dac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



