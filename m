Return-Path: <bpf+bounces-74635-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD498C5FEE2
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 03:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E23E53BF472
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 02:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EE721A95D;
	Sat, 15 Nov 2025 02:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gfShCk5O"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5720917A300;
	Sat, 15 Nov 2025 02:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763175039; cv=none; b=Ij7x6svWRmcDLq4/hHptDWoJFF0AVDjzEQJ99UncXkWujuUi1uC7NlPDWdCI0RRFY59QbeS6LKzuHkVKx+xudBtR+56tEKBrdkwdSSteIwZY4lthU09OiBbpPh2VtElWz3dAMYTJUDGqrft5u8VsbDSYQUQzZDp2pfnXmCVDyP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763175039; c=relaxed/simple;
	bh=lqlikqc6upKV4nc1GVwY2mIKnTu9RyjWOKut9sHDbQw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=B3UZTuPi7axJ25PBVZlKyfIqWETbly4ChEZUo16u2LfUVzFmscjaI1fioqnC/aCqID2OOvbugeGd2ZSjM08yyWJ5fB4ZeHtuZJQ8FjI+bUDoQzWNiezfcBOnOPyKfivwSz+PSuMDqY+jemoct4XcKjCZ8qHDpUrTb+1ZM4me3q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gfShCk5O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDDCFC4CEF1;
	Sat, 15 Nov 2025 02:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763175038;
	bh=lqlikqc6upKV4nc1GVwY2mIKnTu9RyjWOKut9sHDbQw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gfShCk5O27sbcv69fGiW7yIHXtgiXtDnrmCSqZbfyIm403OHoCoGqG72gyZNIa9tz
	 megzMajp8uGGn1Cug2ZmPlGkcWDHrrJe5QANR2CKvHywf/QZ+A+5Wo8HDSyucPG7ua
	 oxHPZwQpt3h07O2pw1WSm2buZLVu9g/QuLBMNQHXnE9ZpwsUU3bEJIHoEmPrKKEr1w
	 N17eWolz6r0WeJUu6hzAUmenDvdqp1kM5sCoO54Qt8qey6YfU9dy16aPFEICXvlZAx
	 S8EuUR5wZFlB8XDslOTCfUm673GVcmRrsSkSq+DCEfyiwVYioWAw87zaK+5aeofWkS
	 2H91VYg2eDnmg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D4A3A78A62;
	Sat, 15 Nov 2025 02:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/2] bpf: Check skb->transport_header is set in
 bpf_skb_check_mtu
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176317500727.1918140.1454108210011393739.git-patchwork-notify@kernel.org>
Date: Sat, 15 Nov 2025 02:50:07 +0000
References: <20251112232331.1566074-1-martin.lau@linux.dev>
In-Reply-To: <20251112232331.1566074-1-martin.lau@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, netdev@vger.kernel.org, hawk@kernel.org,
 M202472210@hust.edu.cn, dddddd@hust.edu.cn

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 12 Nov 2025 15:23:30 -0800 you wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
> 
> The bpf_skb_check_mtu helper needs to use skb->transport_header when
> the BPF_MTU_CHK_SEGS flag is used:
> 
> 	bpf_skb_check_mtu(skb, ifindex, &mtu_len, 0, BPF_MTU_CHK_SEGS)
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf: Check skb->transport_header is set in bpf_skb_check_mtu
    https://git.kernel.org/bpf/bpf-next/c/d946f3c98328
  - [bpf-next,2/2] selftests/bpf: Test bpf_skb_check_mtu(BPF_MTU_CHK_SEGS) when transport_header is not set
    https://git.kernel.org/bpf/bpf-next/c/6cc73f35406c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



