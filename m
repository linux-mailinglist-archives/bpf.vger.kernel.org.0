Return-Path: <bpf+bounces-54506-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2FAA6B1ED
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 01:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BEE88A5ADF
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 00:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909A72F43;
	Fri, 21 Mar 2025 00:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlE1NHF9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1425A7E1;
	Fri, 21 Mar 2025 00:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742515799; cv=none; b=pFrYh1cuG0TDfgyvbv6yKTMGydwJbxKggdUo2wVnlsBmY7AGYoa5vBfXb0xPem3EzZCqbc5IwAGszLF1tDwJ4emouszYqSbddFfimTXn2bSxNYZ2hZxGrPbOGChFJxP/psa2OqwoPTVV70hWR4X0ch908Zix0HxYkdDBQDbw+xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742515799; c=relaxed/simple;
	bh=sJWpoDXprhcX1DWcQTdQ2reJHBcdrtaspGScP5GwX2Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=amZ2pBK3ZKSeABOpqYpi9rPxja+lfCzXM3huzuFUIZKHLGg7spub8/Z6uwB4aiYj5+gVSx9VpQIALIZyaOT6XLLU5z+TqfV5p4sr6DGUHKihNIg+Gtu8cfdmbKxYxsm729Fj3vxwgPEBi2pXjCBexVZCKKiZwdcWT6wWsXZBkNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlE1NHF9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B54CC4CEDD;
	Fri, 21 Mar 2025 00:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742515797;
	bh=sJWpoDXprhcX1DWcQTdQ2reJHBcdrtaspGScP5GwX2Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nlE1NHF9VKGRL5E2z0YqOzgK1hgYRtQjKKC+4I1x7Fm6TkdhXXhC8pvbs2B+EqSLr
	 THnmIDXXGmHIuOtdH5Us/BgWXZIoQjRZPRKSMo/RBaSs6c5TGUlGTyx508QrThZ0iX
	 9pMrpY5C8d7EAeq0eV95yJD5KJE2HVy1WpxftsMXEttXlNNBgcEeBhAgiiH/kzVbYx
	 B+Gw7HenXbkD/NfIETA1pVey8cD6g3X8yiDaO/0ETAErE29v1qGrm2K9I1djCviZI0
	 U6VElNBTOI/RxTHvYCYmOvC3QhqBv0ewzHW1Lag8BpMLHv8yAlhGFzywHHfUHbnta6
	 aJZLwQvKA19Uw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E083806654;
	Fri, 21 Mar 2025 00:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v6 00/11] bpf qdisc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174251583328.1959664.8463944336307893002.git-patchwork-notify@kernel.org>
Date: Fri, 21 Mar 2025 00:10:33 +0000
References: <20250319215358.2287371-1-ameryhung@gmail.com>
In-Reply-To: <20250319215358.2287371-1-ameryhung@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, alexei.starovoitov@gmail.com, martin.lau@kernel.org,
 kuba@kernel.org, edumazet@google.com, xiyou.wangcong@gmail.com,
 jhs@mojatatu.com, sinquersw@gmail.com, toke@redhat.com,
 juntong.deng@outlook.com, jiri@resnulli.us, stfomichev@gmail.com,
 ekarani.silvestre@ccc.ufcg.edu.br, yangpeihao@sjtu.edu.cn,
 yepeilin.cs@gmail.com, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Wed, 19 Mar 2025 14:53:47 -0700 you wrote:
> Hi all,
> 
> This patchset aims to support implementing qdisc using bpf struct_ops.
> This version takes a step back and only implements the minimum support
> for bpf qdisc. 1) support of adding skb to bpf_list and bpf_rbtree
> directly and 2) classful qdisc are deferred to future patchsets. In
> addition, we only allow attaching bpf qdisc to root or mq for now.
> This is to prevent accidentally breaking exisiting classful qdiscs
> that rely on data in a child qdisc. This limit may be lifted in the
> future after careful inspection.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v6,01/11] bpf: Add struct_ops context information to struct bpf_prog_aux
    https://git.kernel.org/bpf/bpf-next/c/51d65049cd7e
  - [bpf-next,v6,02/11] bpf: Prepare to reuse get_ctx_arg_idx
    (no matching commit)
  - [bpf-next,v6,03/11] bpf: net_sched: Support implementation of Qdisc_ops in bpf
    (no matching commit)
  - [bpf-next,v6,04/11] bpf: net_sched: Add basic bpf qdisc kfuncs
    (no matching commit)
  - [bpf-next,v6,05/11] bpf: net_sched: Add a qdisc watchdog timer
    (no matching commit)
  - [bpf-next,v6,06/11] bpf: net_sched: Support updating bstats
    (no matching commit)
  - [bpf-next,v6,07/11] bpf: net_sched: Disable attaching bpf qdisc to non root
    (no matching commit)
  - [bpf-next,v6,08/11] libbpf: Support creating and destroying qdisc
    (no matching commit)
  - [bpf-next,v6,09/11] selftests/bpf: Add a basic fifo qdisc test
    (no matching commit)
  - [bpf-next,v6,10/11] selftests/bpf: Add a bpf fq qdisc to selftest
    (no matching commit)
  - [bpf-next,v6,11/11] selftests/bpf: Test attaching bpf qdisc to mq and non root
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



