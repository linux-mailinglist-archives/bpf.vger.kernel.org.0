Return-Path: <bpf+bounces-17783-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 361E28126CE
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 06:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69A931C214FC
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 05:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456E66116;
	Thu, 14 Dec 2023 05:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nX7sVh6q"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905D763A0
	for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 05:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0E007C433C7;
	Thu, 14 Dec 2023 05:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702530626;
	bh=kisNplcyw91Mk92n8f6EKBuYK0//DnEBkHg9IkfYd2M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nX7sVh6qbqKJgHB+6p4Q5ZSGUX3FKmSSdl/trqu1p24PSk5+Ji8l+l4NxqkaecNtM
	 gZXWZizAwbAKd9ST+cIgEPjqT5/Cje2y/A9sbRF1DgKHR1DDy5yY1kZsCIlyeqfBSZ
	 6uYrq/15+D16/PMVyCQpxRXFBIN/z5T/HOQwcXpcqYbAoCJzkRMqZqCyKHIC5rDgXd
	 TI9+wT5+mJ1apiu+8nCQzeIzrLe+Fa1XIKDg5wmeOKilq8WNNlcLF/iPbf3w75pEeE
	 qs2ZEZ1qO80ccPMxZPpTJ/AeIaXBdF14IM4u6dCJnkFxfj9fO3k3pXLctFPOTstxly
	 tgkgTONBcqXLA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E77AEDFC906;
	Thu, 14 Dec 2023 05:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/2] bpf: Use GFP_KERNEL in bpf_event_entry_gen()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170253062594.9483.485230140941788020.git-patchwork-notify@kernel.org>
Date: Thu, 14 Dec 2023 05:10:25 +0000
References: <20231214043010.3458072-1-houtao@huaweicloud.com>
In-Reply-To: <20231214043010.3458072-1-houtao@huaweicloud.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, alexei.starovoitov@gmail.com,
 andrii@kernel.org, song@kernel.org, haoluo@google.com,
 yonghong.song@linux.dev, daniel@iogearbox.net, kpsingh@kernel.org,
 sdf@google.com, jolsa@kernel.org, john.fastabend@gmail.com,
 xrivendell7@gmail.com, houtao1@huawei.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 14 Dec 2023 12:30:08 +0800 you wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Hi,
> 
> The simple patch set aims to replace GFP_ATOMIC by GFP_KERNEL in
> bpf_event_entry_gen(). These two patches in the patch set were
> preparatory patches in "Fix the release of inner map" patchset [1] and
> are not needed for v2, so re-post it to bpf-next tree.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/2] bpf: Reduce the scope of rcu_read_lock when updating fd map
    https://git.kernel.org/bpf/bpf-next/c/8f82583f9527
  - [bpf-next,v3,2/2] bpf: Use GFP_KERNEL in bpf_event_entry_gen()
    https://git.kernel.org/bpf/bpf-next/c/dc68540913ac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



