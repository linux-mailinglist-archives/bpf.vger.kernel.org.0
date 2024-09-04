Return-Path: <bpf+bounces-38916-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 810DD96C6FC
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 21:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36A351F223B4
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 19:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6ECA13BC1B;
	Wed,  4 Sep 2024 19:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JW38SbH6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BEED528;
	Wed,  4 Sep 2024 19:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725476435; cv=none; b=hquiEDgnVnPJkHNjKdAwEnFBsveTcskwHL6Db9m6TrIce/VYOHfoTT0N3v4OVnEH403SDgg6MZVdpXkOiutUsKsiVOnR0xWBIU8tKf+RkacCbW76avR4zt+r2o7mPvhKog0ntr6WHc6n6ymYSon827Dg/v+aefGEMipaGnKAkLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725476435; c=relaxed/simple;
	bh=fU8ozOd0J+gtSi1U6sKz+68q0zI7lHPuFD1Qnt7bq7Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iOY60oZCL3Ihze3yihqRzRZvhs5VK9Rwj5fCPLsMRKXlyJOCC8eTDkGYXHxx1rW+Mtaie5pjZ2eewwRPZj1FqLDLNhb8F6XCfg4cxtVTLFm1i7v7xkZLt3d+1EkqUwS1ol6926RQ4eYH3GAE/Lbk+kaoZntFaHdtx6dBVl/BLMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JW38SbH6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB4E4C4CEC2;
	Wed,  4 Sep 2024 19:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725476435;
	bh=fU8ozOd0J+gtSi1U6sKz+68q0zI7lHPuFD1Qnt7bq7Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JW38SbH6sm28GUgPw+d6QY5D1/7xCRq6Oy5mbqS32jfaO+xW0zsCNZZDhNv62IGXO
	 Ri5T9v/y8zh1LxmR3yow3FaniRLmPzyJf9qrJtMBpvY83VSDAUFvEvue5e1DB4//4I
	 BHVWWCpAH2tLWAHG8URn7Gx+u4m+kzuqx/qCz0IJx+9Hm5anFHCkJUpr2XKs/2jeWt
	 Wlel5Px4/4pmkqOQIaOUcMsUrpHHbk88IbIrNeCmrCMuYJT7vJuK5P77utat2b2+tl
	 TT+Fkg79R/6b+0ACk+BKu2vki2GH4h3nR1NMvinEraQa+vuFuPtDIlZCO96T4iaX84
	 rCD0oz6H+hlqA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB84D3822D30;
	Wed,  4 Sep 2024 19:00:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] samples/bpf: Remove sample tracex2
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172547643549.1133672.7645467399313819714.git-patchwork-notify@kernel.org>
Date: Wed, 04 Sep 2024 19:00:35 +0000
References: <tencent_30ADAC88CB2915CA57E9512D4460035BA107@qq.com>
In-Reply-To: <tencent_30ADAC88CB2915CA57E9512D4460035BA107@qq.com>
To: Rong Tao <rtoax@foxmail.com>
Cc: andrii.nakryiko@gmail.com, andrii@kernel.org, ast@kernel.org,
 bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
 haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org,
 kpsingh@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev,
 rongtao@cestc.cn, sdf@fomichev.me, song@kernel.org, yonghong.song@linux.dev

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 31 Aug 2024 08:03:38 +0800 you wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> In commit ba8de796baf4 ("net: introduce sk_skb_reason_drop function")
> kfree_skb_reason() becomes an inline function and cannot be traced.
> 
> samples/bpf is abandonware by now, and we should slowly but surely
> convert whatever makes sense into BPF selftests under
> tools/testing/selftests/bpf and just get rid of the rest.
> 
> [...]

Here is the summary with links:
  - [bpf-next] samples/bpf: Remove sample tracex2
    https://git.kernel.org/bpf/bpf-next/c/46f4ea04e053

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



