Return-Path: <bpf+bounces-13188-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6637D5ED0
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 01:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69171281C5E
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 23:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660839CA41;
	Tue, 24 Oct 2023 23:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WzJRoPCR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF430749D;
	Tue, 24 Oct 2023 23:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3C617C433C9;
	Tue, 24 Oct 2023 23:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698191425;
	bh=AUDrG4UAPjMJ6s3iVskY+0VqfVX9671klzRY+laVUq0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WzJRoPCRLlAvXJnvw/PD/+cBg+UKKsoie8vSPkjPMyo72+JDC/6DuAtjT6cpEuHxd
	 Iw9SezRL+nhDax8mWpqb10Aph/kmJUbgiU1a/UuBN6wBCkEpjNxFnnlvItLovMjCp+
	 M/i0Aru9BVU1xDhrcGAgZxVdef7Rf2+CwKM6PLZiC6SByZUS6D37B37muvDT4kF4nk
	 tF9p+A6c3XtGkJVpLVwuS2eD5KNcSHQY8zjJZcYm+PoInPsJmAMt/5SiEiH/v1Phy5
	 byJ5DYMhC0II9fGIgcAfLG4HdQYRdkEeE7uXcxfPrq0kyln0OKxd/B7aPsaUt9I7Al
	 oa+XuIinKMi/w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 23F10E4CC1C;
	Tue, 24 Oct 2023 23:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/7] Add bpf programmable net device
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169819142514.13417.3415333680978363345.git-patchwork-notify@kernel.org>
Date: Tue, 24 Oct 2023 23:50:25 +0000
References: <20231024214904.29825-1-daniel@iogearbox.net>
In-Reply-To: <20231024214904.29825-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, martin.lau@linux.dev,
 razor@blackwall.org, ast@kernel.org, andrii@kernel.org,
 john.fastabend@gmail.com, sdf@google.com, toke@kernel.org, kuba@kernel.org,
 andrew@lunn.ch

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Tue, 24 Oct 2023 23:48:57 +0200 you wrote:
> This work adds a BPF programmable device which can operate in L3 or L2
> mode where the BPF program is part of the xmit routine. It's program
> management is done via bpf_mprog and it comes with BPF link support.
> For details see patch 1 and following. Thanks!
> 
> v3 -> v4:
>   - Moved netkit_release_all() into ndo_uninit (Stan)
>   - Two small commit msg corrections (Toke)
>   - Added Acked/Reviewed-by
> v2 -> v3:
>   - Remove setting dev->min_mtu to ETH_MIN_MTU (Andrew)
>   - Do not populate ethtool info->version (Andrew)
>   - Populate netdev private data before register_netdevice (Andrew)
>   - Use strscpy for ifname template (Jakub)
>   - Use GFP_KERNEL_ACCOUNT for link kzalloc (Jakub)
>   - Carry and dump link attach type for bpftool (Toke)
> v1 -> v2:
>   - Rename from meta (Toke, Andrii, Alexei)
>   - Reuse skb_scrub_packet (Stan)
>   - Remove IFF_META and use netdev_ops (Toke)
>   - Add comment to multicast handler (Toke)
>   - Remove silly version info (Toke)
>   - Fix attach_type_name (Quentin)
>   - Rework libbpf link attach api to be similar
>     as tcx (Andrii)
>   - Move flags last for bpf_netkit_opts (Andrii)
>   - Rebased to bpf_mprog query api changes
>   - Folded link support patch into main one
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/7] netkit, bpf: Add bpf programmable net device
    https://git.kernel.org/bpf/bpf-next/c/35dfaad7188c
  - [bpf-next,v4,2/7] tools: Sync if_link uapi header
    https://git.kernel.org/bpf/bpf-next/c/5c1b994de4be
  - [bpf-next,v4,3/7] libbpf: Add link-based API for netkit
    https://git.kernel.org/bpf/bpf-next/c/05c31b4ab205
  - [bpf-next,v4,4/7] bpftool: Implement link show support for netkit
    https://git.kernel.org/bpf/bpf-next/c/92a85e18ad47
  - [bpf-next,v4,5/7] bpftool: Extend net dump with netkit progs
    https://git.kernel.org/bpf/bpf-next/c/bec981a4add6
  - [bpf-next,v4,6/7] selftests/bpf: Add netlink helper library
    https://git.kernel.org/bpf/bpf-next/c/51f1892b5289
  - [bpf-next,v4,7/7] selftests/bpf: Add selftests for netkit
    https://git.kernel.org/bpf/bpf-next/c/ace15f91e569

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



