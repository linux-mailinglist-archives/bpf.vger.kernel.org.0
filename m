Return-Path: <bpf+bounces-44589-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC2F9C4DB7
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 05:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9209C28771E
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 04:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294F2208223;
	Tue, 12 Nov 2024 04:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tGjbAkqb"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35C616CD29;
	Tue, 12 Nov 2024 04:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731385220; cv=none; b=iD/VZvsazfeiZiFV3R13RFyWJg8/m+YbGJMKzIVtWJMtKEYsVvU2zjkL94zexnvVUwxRdX8bg6MS8+01Ftl54UJb4mqmWOJ0gh2hzN7eFV6gtwoQ/So1mISobj1debuykXfP66WB6gT9WfLCiepM9iMJTdYV6qtuHFioBR+tfqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731385220; c=relaxed/simple;
	bh=mxwbaNawZGtcG+XxsvPRjOQp5G0t2rcv8lhX48c7XEo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OqK+3zi1UnReMUm27ynHQt+s64+OHs0OvohoflDcALf6QslDftKEBUouOV5gx5k8WbyNPL8k4uZpAFGNvvWOOoeIV3x6rqi07nX5rQ5B7c6cegkXDlojp4jXZVJd3ZLOT/e34NBDNjX4lb0hyiusddcj8VezMiAEl4jW+iXlvCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tGjbAkqb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C58C4CECD;
	Tue, 12 Nov 2024 04:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731385219;
	bh=mxwbaNawZGtcG+XxsvPRjOQp5G0t2rcv8lhX48c7XEo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tGjbAkqbTvVh/D1eRCbgo20zc9NbDuwch2/k7vuZezh5bWEHyn04zSIKsxf3ux3SH
	 /MVzC//gb1ADlDgCzCeXSzcZTWwBQkl/Ofh9FkrW/Q6dS0cbR1ni0Iu2d8LWK4ccXN
	 TnBiUxPm7jeZsqEf27lpqh5vN0Oe08SIk1oEomea3ezOTMtxVusZ0XaYgt6O75b9id
	 mwn++UxG1p6LaBZ3NP8pvuHAJ7HNbCimeoXJpOaZw6OKuhq2pRJuWrZFfZwi5v4PNJ
	 7FJN/ZSujrnKYdomlHdZeC6Jcm40cJMZq89EvSNokso9uY/JvBuL2gOBqOdEVQuKOG
	 Iz6mvUCl52ZGg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 715BF3809A80;
	Tue, 12 Nov 2024 04:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: replace the document for PTR_TO_BTF_ID_OR_NULL
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173138522926.78749.16727839517005198165.git-patchwork-notify@kernel.org>
Date: Tue, 12 Nov 2024 04:20:29 +0000
References: <20241111124911.1436911-1-dongml2@chinatelecom.cn>
In-Reply-To: <20241111124911.1436911-1-dongml2@chinatelecom.cn>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, dongml2@chinatelecom.cn

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 11 Nov 2024 20:49:11 +0800 you wrote:
> Commit c25b2ae13603 ("bpf: Replace PTR_TO_XXX_OR_NULL with PTR_TO_XXX |
> PTR_MAYBE_NULL") moved the fields around and misplaced the
> documentation for "PTR_TO_BTF_ID_OR_NULL". So, let's replace it in the
> proper place.
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: replace the document for PTR_TO_BTF_ID_OR_NULL
    https://git.kernel.org/bpf/bpf-next/c/213a695297e1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



