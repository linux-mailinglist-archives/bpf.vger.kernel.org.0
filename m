Return-Path: <bpf+bounces-75747-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A60C934A7
	for <lists+bpf@lfdr.de>; Sat, 29 Nov 2025 00:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BC27F4E2A54
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 23:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F199F2F1FC1;
	Fri, 28 Nov 2025 23:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="arE1hNLo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781512F0C66
	for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 23:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764372196; cv=none; b=DfKT69hBfY07TZCXHlmPhtVcleDDATo0XLnrv3xa9CwaizLNSRDRBf2j/qUJD7oL4BFJuww9tYkC0HGqlqEIt4rsDS1B2Ptaacm9zKQNHqSGy7F7ACLMmCckZ+cYj9hvx3DnTYdubLcCl5wWEw36/869DaB/G7gDYlCd0qcZoSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764372196; c=relaxed/simple;
	bh=N5ViFgG3CTZDg/CBR9pFF/QkgtQGbuggRPlI3TYJfpU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IeJB95kS+Ywk7jpR93VY/rTR+jL3Tj0YO/0qsQs5czG5YEuvxWIbiS+5hFHwv0sCfnjLFhbgW7HHR6AIIkMtVH5DN+YrpOGX51w6/D1EjP57FAWFeepNc4nFMY+o1Xj7hO75dUSSZ993Q6wdzanh/ZTMwAzDjNwVhNoLSmigemI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=arE1hNLo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F01AC4CEF1;
	Fri, 28 Nov 2025 23:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764372196;
	bh=N5ViFgG3CTZDg/CBR9pFF/QkgtQGbuggRPlI3TYJfpU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=arE1hNLo8V43FBL9/N4yhgJewgaI5Ogo0cwu6kwmVSR9UIlKK+iyUXMBIcjWGjceG
	 heMB4ZXLxSf0Mx3ecpr5Llp+E6WdC5Sn6zbmuQrGzFU1K2VKHgEloIF/fS6jrKJ1fB
	 OCkwOdwzh+lP0RQEIZeO31pvuTfV2dc++ZLHuwi3J4vtSBRIUpBfArGsPJf5IDwq65
	 q+u00QxnkKjuMHdnHBbAtsxwPeA3UD1OVEYbQV4QlZVVv2K85A/KpG3XweCXXTCBDh
	 4nnYeMIPYOv2HpItjLYC6M5RHvmqYipiepRg0KKNnkmAuNGufrNnrhPjam7B+Aa7PR
	 or+yKR/XlP0Hw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2A74380692B;
	Fri, 28 Nov 2025 23:20:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/2] A pair of follow ups for indirect jumps
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176437201779.828244.16468414801366441428.git-patchwork-notify@kernel.org>
Date: Fri, 28 Nov 2025 23:20:17 +0000
References: <20251128063224.1305482-1-a.s.protopopov@gmail.com>
In-Reply-To: <20251128063224.1305482-1-a.s.protopopov@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 28 Nov 2025 06:32:22 +0000 you wrote:
> Two fixes suggested by Alexei in [1]. Resending as a series,
> as the second patch depends on the first.
> 
>   [1] https://lore.kernel.org/bpf/CAADnVQK3piReoo1ja=9hgz7aJ60Y_Jjur_JMOaYV8-Mn_VyE4A@mail.gmail.com/#R
> 
> Anton Protopopov (2):
>   bpf: force BPF_F_RDONLY_PROG on insn array creation
>   bpf: check for insn arrays in check_ptr_alignment
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf: force BPF_F_RDONLY_PROG on insn array creation
    https://git.kernel.org/bpf/bpf-next/c/7feff23cdf2e
  - [bpf-next,2/2] bpf: check for insn arrays in check_ptr_alignment
    https://git.kernel.org/bpf/bpf-next/c/e3ea26add687

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



