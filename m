Return-Path: <bpf+bounces-986-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 732D070A5D4
	for <lists+bpf@lfdr.de>; Sat, 20 May 2023 08:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27BC81C20A70
	for <lists+bpf@lfdr.de>; Sat, 20 May 2023 06:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E656881B;
	Sat, 20 May 2023 06:00:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF98653
	for <bpf@vger.kernel.org>; Sat, 20 May 2023 06:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5A7EC433D2;
	Sat, 20 May 2023 06:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684562422;
	bh=pjR1NBWJLzSsDG38lcdNBQoySMRgKbgLRBGF9ILzmbA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fjuQmKrzPc5KG41+ooFyPIIzHlanCaDNhE1Zia4WzDNvFa0tiS1yP/R2kW/9c6lI3
	 1fG4TuWb1bteQ9g1vGjDI2flSB8n8juloAE8RDG9rUQ1ynji8qEAx9fSMPtaD8q/bW
	 qbONykSRbebj9TbDVSIQRN7ZJvTXhlRa+lGhXbqfRTn9yIWIChjw/LvH62ffX6mfGw
	 qye2EAgJvwomlU6JJ5lwk9ccNRDE2FccfzAXsxGCAGAWKi1MVFO4/aCVJ7TGmEceYd
	 kMmu1FMkU+z7y2xY/l1A5V6W/sPstMPa67mwbfujUeteZYCd37UJNdfWfHYh5N/TNc
	 SIcGcPFvqo7qw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9C8CFC73FE2;
	Sat, 20 May 2023 06:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v9 bpf-next 0/9] bpf: Add socket destroy capability
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168456242263.5388.13008610099434399970.git-patchwork-notify@kernel.org>
Date: Sat, 20 May 2023 06:00:22 +0000
References: <20230519225157.760788-1-aditi.ghag@isovalent.com>
In-Reply-To: <20230519225157.760788-1-aditi.ghag@isovalent.com>
To: Aditi Ghag <aditi.ghag@isovalent.com>
Cc: bpf@vger.kernel.org, kafai@fb.com, sdf@google.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Fri, 19 May 2023 22:51:48 +0000 you wrote:
> This patch set adds the capability to destroy sockets in BPF. We plan to
> use the capability in Cilium to force client sockets to reconnect when
> their remote load-balancing backends are deleted. The other use case is
> on-the-fly policy enforcement where existing socket connections
> prevented by policies need to be terminated.
> 
> The use cases, and more details around
> the selected approach were presented at LPC 2022 -
> https://lpc.events/event/16/contributions/1358/.
> RFC discussion -
> https://lore.kernel.org/netdev/CABG=zsBEh-P4NXk23eBJw7eajB5YJeRS7oPXnTAzs=yob4EMoQ@mail.gmail.com/T/#u.
> v8 patch series -
> https://lore.kernel.org/bpf/20230517175359.527917-1-aditi.ghag@isovalent.com/
> 
> [...]

Here is the summary with links:
  - [v9,bpf-next,1/9] bpf: tcp: Avoid taking fast sock lock in iterator
    https://git.kernel.org/bpf/bpf-next/c/9378096e8a65
  - [v9,bpf-next,2/9] udp: seq_file: Helper function to match socket attributes
    https://git.kernel.org/bpf/bpf-next/c/f44b1c515833
  - [v9,bpf-next,3/9] bpf: udp: Encapsulate logic to get udp table
    https://git.kernel.org/bpf/bpf-next/c/7625d2e9741c
  - [v9,bpf-next,4/9] udp: seq_file: Remove bpf_seq_afinfo from udp_iter_state
    https://git.kernel.org/bpf/bpf-next/c/e4fe1bf13e09
  - [v9,bpf-next,5/9] bpf: udp: Implement batching for sockets iterator
    https://git.kernel.org/bpf/bpf-next/c/c96dac8d369f
  - [v9,bpf-next,6/9] bpf: Add kfunc filter function to 'struct btf_kfunc_id_set'
    https://git.kernel.org/bpf/bpf-next/c/e924e80ee6a3
  - [v9,bpf-next,7/9] bpf: Add bpf_sock_destroy kfunc
    https://git.kernel.org/bpf/bpf-next/c/4ddbcb886268
  - [v9,bpf-next,8/9] selftests/bpf: Add helper to get port using getsockname
    https://git.kernel.org/bpf/bpf-next/c/176ba657e6aa
  - [v9,bpf-next,9/9] selftests/bpf: Test bpf_sock_destroy
    https://git.kernel.org/bpf/bpf-next/c/1a8bc2299f40

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



