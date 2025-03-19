Return-Path: <bpf+bounces-54356-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2701A68320
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 03:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AFED19C5DE9
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 02:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7C824E01F;
	Wed, 19 Mar 2025 02:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CVFodU/8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA521EFFAB
	for <bpf@vger.kernel.org>; Wed, 19 Mar 2025 02:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742350799; cv=none; b=Dj7OFwfCUYJIKpQY0mFpPYJuyhOMcPUK4BoIpzCjLX5jc9xBiRoWq8MHWsIjoOc9gP9VgoEqXRs+C7AqtEsgMmPrfWWHSzA2VEB33xmNeIxHTCs3upbysFNSC/SStxMMNJt8zzDkuqkQ6RWliPTd6QpN6AHoYpotK/RE+7nktFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742350799; c=relaxed/simple;
	bh=euOERcuQzALqBRsRgATnZQrNdaS5JANPeikdHvQB72U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Dkxfx/TcDlrKKm4dxHtTAJcDAz9GxsTNI3UxhhbvnTh0ciCQInZl+FypowFLxLL53OeI1o8azI8BQDzdw2nVuhoRzjFjs8yJp82EuiwFzxy5Zo/OsaV2RQigI1903x0CvB5e99dAA62kt5XxXrELfwzHsQq18bK5Rkw4u6Mj+aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CVFodU/8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29BEAC4CEDD;
	Wed, 19 Mar 2025 02:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742350799;
	bh=euOERcuQzALqBRsRgATnZQrNdaS5JANPeikdHvQB72U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CVFodU/8G1iSxfW41iOA7bD46zuLQifBH40mVXArMTrX25e+c2UGJAxhukY9XVI6m
	 Ag9zi//HZ16vY51o9FE4fYb2UFbVNXX+Xc3LmybW8AsjYtiO3LSd2N2QRCiuLHtjyJ
	 WElqcTZLrpraMW1COOYB97GZD54gLj1P+OQ7TnwABbxgPosgyub0rJIEmkzJpfPaAx
	 PRLfEYSi8jesCvNQfTNfkXCkLjZ55yh62ssOgSmG9/cVBnOnMEYhyZX3Bb3RvlI2fx
	 lBCLp5VxIEpR80YhdVmsX7x/5d2sJKosE2JJl6oxH3rwaeCo8cvRdE9aoyvQ6csiSS
	 QcjnzpdUKmTlw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC44380DBEE;
	Wed, 19 Mar 2025 02:20:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 0/2] bpf: Reject attaching fexit/fmod_ret to
 __noreturn functions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174235083449.538922.7268862639090608979.git-patchwork-notify@kernel.org>
Date: Wed, 19 Mar 2025 02:20:34 +0000
References: <20250318114447.75484-1-laoar.shao@gmail.com>
In-Reply-To: <20250318114447.75484-1-laoar.shao@gmail.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, jpoimboe@kernel.org,
 peterz@infradead.org, bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 18 Mar 2025 19:44:45 +0800 you wrote:
> Attaching fexit probes to functions marked with __noreturn may lead to
> unpredictable behavior. To avoid this, we will reject attaching probes to
> such functions. Currently, there is no ideal solution, so we will hardcode
> a check for all __noreturn functions.
> 
> Once a more robust solution is implemented, this workaround can be removed.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,1/2] bpf: Reject attaching fexit/fmod_ret to __noreturn functions
    https://git.kernel.org/bpf/bpf-next/c/cfe816d469dc
  - [bpf-next,v5,2/2] selftests/bpf: Add selftest for attaching fexit to __noreturn functions
    https://git.kernel.org/bpf/bpf-next/c/be16ddeaae96

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



