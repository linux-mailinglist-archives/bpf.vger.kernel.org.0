Return-Path: <bpf+bounces-8192-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3AC57835CE
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 00:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3FB01C209F0
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 22:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A861ADF8;
	Mon, 21 Aug 2023 22:30:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2561ADF3;
	Mon, 21 Aug 2023 22:30:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F1D42C433C7;
	Mon, 21 Aug 2023 22:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692657031;
	bh=JuzWKM04WvvwJzsCZxA8NyL/TOpkWzygeeHbFVmv2M0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VXfI5ry0YyirDt/XNkhHFqFRREsxZsPXRqscgALaFbt6zAP6m3+qR+TVaNNtfpdm1
	 n/O22NgUGFlN21nCcHzoo+8AC9sQMQRN0DzPuTJLLdAmQ+ridtvkl3CeaTeNnK+iUw
	 uoBaPRhE6TAp8KXJqCGuImk8jNjLwRsy1y8Ewb9g1kgvylx+FRMPsaObXxRS7HUOsj
	 /++I0Yes90RytBb68bDYO/Wbo3Cj9JaKEjnNrCzmOxMEQxdj5R4R2sR97vpA/TPN4+
	 +QNLWkiphPOtQqd9GgNChEQYsKKGHhDutOqYBU/M3lM8QbNTxACcVnpRxBV12Dr3x0
	 FI7Djuneyb1ug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D2625E4EAFB;
	Mon, 21 Aug 2023 22:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/2] Remove unnecessary synchronizations in cpumap
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169265703085.7836.3332435824917514335.git-patchwork-notify@kernel.org>
Date: Mon, 21 Aug 2023 22:30:30 +0000
References: <20230816045959.358059-1-houtao@huaweicloud.com>
In-Reply-To: <20230816045959.358059-1-houtao@huaweicloud.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, toke@redhat.com,
 davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, bjorn.topel@gmail.com, martin.lau@linux.dev,
 alexei.starovoitov@gmail.com, andrii@kernel.org, song@kernel.org,
 haoluo@google.com, yonghong.song@linux.dev, daniel@iogearbox.net,
 kpsingh@kernel.org, sdf@google.com, jolsa@kernel.org, houtao1@huawei.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 16 Aug 2023 12:59:56 +0800 you wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Hi,
> 
> This is the formal patchset to remove unnecessary synchronizations in
> cpu-map after address comments and collect Rvb tags from Toke
> Høiland-Jørgensen (Big thanks to Toke). Patch #1 removes the unnecessary
> rcu_barrier() when freeing bpf_cpu_map_entry and replaces it by
> queue_rcu_work(). Patch #2 removes the unnecessary call_rcu() and
> queue_work() when destroying cpu-map and does the freeing directly.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf, cpumap: Use queue_rcu_work() to remove unnecessary rcu_barrier()
    https://git.kernel.org/bpf/bpf-next/c/8f8500a247c9
  - [bpf-next,2/2] bpf, cpumask: Clean up bpf_cpu_map_entry directly in cpu_map_free
    https://git.kernel.org/bpf/bpf-next/c/c2e42ddf26ca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



