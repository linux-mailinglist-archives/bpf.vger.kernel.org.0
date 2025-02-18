Return-Path: <bpf+bounces-51791-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C222EA3910E
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 04:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA7DC188C8F8
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 03:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04DB156F20;
	Tue, 18 Feb 2025 03:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q7ichDQV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D85C14A4E0
	for <bpf@vger.kernel.org>; Tue, 18 Feb 2025 03:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739847603; cv=none; b=fZlUTBmuo+hJgVjEEh4dN+L2onz0ANOsNPXLrJMdYTtSbH10UM5ZVOj2i92NH/dZF34J8s6RgwcoEnAol2fMDHjuF0vukazXd/oN90caAm3kRoKJuiNDRUChFJYX3cJyiDJECwImTx8k+H1YXpF8jLR41m8nAAyXHjwdjFcffOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739847603; c=relaxed/simple;
	bh=xzTNzK3Mem99xThTpfqsy8fwQDIrMHzHYU1wSvHqyhk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=peWE+S+ZpzyRspGVgcwf0QTaSo1OQD29hGXQUux7dofnJbIw0Ahb4wJG4Qdv1Db754+YK+I87orFPm9kwPJjHGXJYEveD4eaCEffrqY8DPCMR7wu8tkaTVup8j7TbZM6wuv736o51mu8iTNj+1oEdhB0SSQ5JBAYBvUdCrZgEwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q7ichDQV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D06C4CED1;
	Tue, 18 Feb 2025 03:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739847602;
	bh=xzTNzK3Mem99xThTpfqsy8fwQDIrMHzHYU1wSvHqyhk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q7ichDQVzMh0AbB8PxQNAcN/UZGC+/7MBaiUqywGdW9CXAK6XxzbrLbAfg1sUv2aA
	 O+5B9MMp6VvcmD5FRympNZ8/a48J4Vpukk4o5dsjGd5+lRtYmF2mfKpF5ORCPZ/x0X
	 tJU39AvZPmeSdWR4ZrykzoHRFPFlD64WOnsOBSuG7I10geXSKNnsAXsZSTH57wfOx0
	 +C7i0RLAgt9IA9lFIP/EPLQZxnFLD6+HOYR/5uGBo6GMBqRzW9nkstjPtjBwhZJ6rt
	 4W3s8JN6PtfIZMe6FfRGHDz6vpuIso5C2r/igl5CcW30b5Ako4QwaDTIAEmFq6206k
	 qmdVehe5zFP1w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34275380AAD5;
	Tue, 18 Feb 2025 03:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/5] Extend struct_ops support for operators
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173984763304.3607479.11837878062190830835.git-patchwork-notify@kernel.org>
Date: Tue, 18 Feb 2025 03:00:33 +0000
References: <20250217190640.1748177-1-ameryhung@gmail.com>
In-Reply-To: <20250217190640.1748177-1-ameryhung@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 alexei.starovoitov@gmail.com, martin.lau@kernel.org, eddyz87@gmail.com,
 kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 17 Feb 2025 11:06:35 -0800 you wrote:
> Hi,
> 
> This patchset supports struct_ops operators that acquire kptrs through
> arguments and operators that return a kptr. A coming new struct_ops use
> case, bpf qdisc [0], has two operators that are not yet supported by
> current struct_ops infrastructure. Qdisc_ops::enqueue requires getting
> referenced skb kptr from the argument; Qdisc_ops::dequeue needs to return
> a referenced skb kptr. This patchset will allow bpf qdisc and other
> potential struct_ops implementers to do so.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/5] bpf: Make every prog keep a copy of ctx_arg_info
    https://git.kernel.org/bpf/bpf-next/c/432051806f61
  - [bpf-next,v2,2/5] bpf: Support getting referenced kptr from struct_ops argument
    https://git.kernel.org/bpf/bpf-next/c/a687df2008f6
  - [bpf-next,v2,3/5] selftests/bpf: Test referenced kptr arguments of struct_ops programs
    https://git.kernel.org/bpf/bpf-next/c/6991ec6beb26
  - [bpf-next,v2,4/5] bpf: Allow struct_ops prog to return referenced kptr
    https://git.kernel.org/bpf/bpf-next/c/8d9f547f74c7
  - [bpf-next,v2,5/5] selftests/bpf: Test returning referenced kptr from struct_ops programs
    https://git.kernel.org/bpf/bpf-next/c/af17bad9fb2a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



