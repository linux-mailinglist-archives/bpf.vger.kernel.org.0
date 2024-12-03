Return-Path: <bpf+bounces-45985-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB169E10FF
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 03:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5251B282B81
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 02:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1166922F1C;
	Tue,  3 Dec 2024 02:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+BnplJQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3BA2500B6
	for <bpf@vger.kernel.org>; Tue,  3 Dec 2024 02:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733191217; cv=none; b=bdrgJQ4XbXKzLNpFuhIy+E1zuOGtQv2WLsIeQ27gF+bZhkvPsBDv8a+kJ8T1ewQd88oLHPbJakpJBG/d9fpCcg8K0GALQkVZ5jSXprIsQiU7utObiL4k8DmutjZwj/EKEF+pdFmzFOJC4JIwpxpK2fdOU/0CVJ0fHLSPRl4dQhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733191217; c=relaxed/simple;
	bh=RZxalZQlULAd9GSO2gaaeYo4mkeUEYZGF2lopT2wdss=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ks0RV+4xPYnThhU96TEH2mCaia6LN4ZDt+6syahNkzeZcjSJwQ5rBBX2HJwj8Lt9xk64Csn/W6LQ4g7BOa286iiZgbtrJrkTwLjzIlpf3gKPrGvN4OmtjR9FPJf8Z4noxO1acw5HeRPg1yotaTfABtQK/lEWYeqL2WMNsRQmF9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+BnplJQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16078C4CED1;
	Tue,  3 Dec 2024 02:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733191217;
	bh=RZxalZQlULAd9GSO2gaaeYo4mkeUEYZGF2lopT2wdss=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=C+BnplJQH+YZELOGdtwsPhG0Br1MNePkz9v1pOsMjw+aWfPZnTFvqlUNdysrpri+r
	 npNdZ39g/6SsgdAp7kZe26C8e6S1tVfDfqv+lq70keC5p+uLGQc/TZ/yPunc/N9blW
	 nR+ZhTYAat9nrDtv622Mp54tp4UUL/V1qv+Z8Ab5AARpFLdrS42hs06S9WqrDH02xt
	 pELDMs8+jVetKSF5BPxdvJ6VuHz8r1wP+ct3lTSJnGO24uUzup/DBl8BPesy11DgGd
	 tN7uDW2kvRelH1wJn9Iw9AzrDxngGqDUgmyde9P955Udi5+uNhOIeDBk+RS5a0l6zw
	 ckuALMg7h8sIQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CDD3806656;
	Tue,  3 Dec 2024 02:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2 0/2] Fix missing process_iter_arg type check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173319123125.3988014.7609729180568995451.git-patchwork-notify@kernel.org>
Date: Tue, 03 Dec 2024 02:00:31 +0000
References: <20241203000238.3602922-1-memxor@gmail.com>
In-Reply-To: <20241203000238.3602922-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, kkd@meta.com, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
 tao.lyu@epfl.ch, mathias.payer@nebelwelt.net, meng.xu.cs@uwaterloo.ca,
 sanidhya.kashyap@epfl.ch, kernel-team@fb.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon,  2 Dec 2024 16:02:36 -0800 you wrote:
> I am taking over Tao's earlier patch set that can be found at [0], after
> an offline discussion. The bug reported in that thread is that
> process_iter_arg missed a reg->type == PTR_TO_STACK check. Fix this by
> adding it in, and also address comments from Andrii on the earlier
> attempt. Include more selftests to ensure the error is caught.
> 
>   [0]: https://lore.kernel.org/bpf/20241107214736.347630-1-tao.lyu@epfl.ch
> 
> [...]

Here is the summary with links:
  - [bpf,v2,1/2] bpf: Ensure reg is PTR_TO_STACK in process_iter_arg
    https://git.kernel.org/bpf/bpf/c/12659d28615d
  - [bpf,v2,2/2] selftests/bpf: Add tests for iter arg check
    https://git.kernel.org/bpf/bpf/c/7f71197001e3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



