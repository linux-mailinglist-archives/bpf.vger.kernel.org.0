Return-Path: <bpf+bounces-6507-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 502F376A69C
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 03:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1262728179D
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 01:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C6A10E1;
	Tue,  1 Aug 2023 01:58:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86647E;
	Tue,  1 Aug 2023 01:58:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1DB95C433C8;
	Tue,  1 Aug 2023 01:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690855132;
	bh=/YKmEXb0/vW9TocEcNGoTalJ2qkpZWR+jmhHZQny6G0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GYVDLxh4Lma3f+d0kdq4ciAHK6NlnRMEL6ke8fA4MveQmUI//i0u4pGKiFJSb4QVI
	 sCkmeR2XU1kB7awO4yQzNZ+1bLgVtgHgUTKlfWG2TZ9YTNod4RdzK8tzuD0SgAxLeY
	 u8VIlb9H6vq2d25mv9b5OToBdf9rM39U7iAOEYYUIU0DwHYaUNTsqGsvpVtNBWJ+bt
	 Sy43NWeLpDrKWMCqch+cB8NvWRIW0c5I8sM827RmxUgDcDICr8YzXWgCL7klQrntxU
	 qcT0uRotv3gcdQb3rKRAmzhEX5+hWToeOR/myBKg4ujfRWcJGkrJJwxO+tzFdgHqrJ
	 bL2eAXQEVKodA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 011E7C595C0;
	Tue,  1 Aug 2023 01:58:52 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/2] Remove unused fields in cpumap & devmap
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169085513200.17783.16957076223549181701.git-patchwork-notify@kernel.org>
Date: Tue, 01 Aug 2023 01:58:52 +0000
References: <20230728014942.892272-1-houtao@huaweicloud.com>
In-Reply-To: <20230728014942.892272-1-houtao@huaweicloud.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com,
 bjorn.topel@gmail.com, martin.lau@linux.dev, alexei.starovoitov@gmail.com,
 andrii@kernel.org, song@kernel.org, haoluo@google.com,
 yonghong.song@linux.dev, daniel@iogearbox.net, kpsingh@kernel.org,
 sdf@google.com, jolsa@kernel.org, houtao1@huawei.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Fri, 28 Jul 2023 09:49:40 +0800 you wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Hi,
> 
> Patchset "Simplify xdp_do_redirect_map()/xdp_do_flush_map() and XDP
> maps" [0] changed per-map flush list to global per-cpu flush list
> for cpumap, devmap and xskmap, but it forgot to remove these unused
> fields from cpumap and devmap. So just remove these unused fields.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf, cpumap: Remove unused cmap field from bpf_cpu_map_entry
    https://git.kernel.org/bpf/bpf-next/c/2d20bfc315eb
  - [bpf-next,2/2] bpf, devmap: Remove unused dtab field from bpf_dtab_netdev
    https://git.kernel.org/bpf/bpf-next/c/1ea66e89f68c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



