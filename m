Return-Path: <bpf+bounces-13910-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B19B07DECAD
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 07:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 504551F2259B
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 06:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11060569F;
	Thu,  2 Nov 2023 06:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="onOtjkPA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773EA5399
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 06:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E85C8C433C9;
	Thu,  2 Nov 2023 06:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698904825;
	bh=nuMnZu4y5I5ohkrfFCpZy2Z1BHRVa6FwQkzcYGm+GfI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=onOtjkPAWUqNBZH8BQ/g7gWHS3NyQTcZpD0CTIatuMewQS5KaB3m+0xase9R6K32L
	 OxQwuycuInhJkupozBnAOMAJNgDrjujouiiX85QFseK9oLy7A+ewUJoZo/EVPlqCK/
	 V6H6M6As/fSA5TGNnjPw7vgcmvIVVIHyr6kXJG3J/+/az9G9nfCVwkIxsdiA4Hn15v
	 XulRfqlTJK5+6bZ9avMNIq+/8Ny7RLnJ1JuDzh4sUoqkm4fE3bk5Vno/QHESU/EpPf
	 Eaj5m5S/3z9Pqtd1gd2SbzJFID87d32rp44jKA2Iptoy3JwInZV8cGuOdX8H81F5Pu
	 VPFLtk+X370vg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D0334EAB08B;
	Thu,  2 Nov 2023 06:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] selftests/bpf: fix test_bpffs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169890482484.9002.7064974144081814269.git-patchwork-notify@kernel.org>
Date: Thu, 02 Nov 2023 06:00:24 +0000
References: <20231031223606.2927976-1-chantr4@gmail.com>
In-Reply-To: <20231031223606.2927976-1-chantr4@gmail.com>
To: Manu Bretelle <chantr4@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 ast@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 shuah@kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 31 Oct 2023 15:36:06 -0700 you wrote:
> Currently this tests tries to umount /sys/kernel/debug (TDIR) but the
> system it is running on may have mounts below.
> 
> For example, danobi/vmtest [0] VMs have
>     mount -t tracefs tracefs /sys/kernel/debug/tracing
> as part of their init.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] selftests/bpf: fix test_bpffs
    https://git.kernel.org/bpf/bpf/c/cd60f410ddc0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



