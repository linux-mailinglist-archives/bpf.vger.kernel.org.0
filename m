Return-Path: <bpf+bounces-30811-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7588D29ED
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 03:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21B231F27776
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 01:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB0D15ADB0;
	Wed, 29 May 2024 01:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rmYmxVQR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5320A15AADE
	for <bpf@vger.kernel.org>; Wed, 29 May 2024 01:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716945905; cv=none; b=plz5pfvoRJEGWh99F4TUo3Pvs0ItWebdW1D+BKRT5X6VbDjjDMty3maB/OmL+udbVYI/4BXp1GgfLPGytO7LaDo3Ggl8l8E1BIkUmDqY2idbOkt4wqV8+dgGA+M9GgVs3HWegsuqN3FkaTjo3HvFimrAEq+CFmjB0tA4qiNA13o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716945905; c=relaxed/simple;
	bh=zf8s5RHrZA8BEOuRcxEqi4aPDsDD+nIYBPFtOZfVC/g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DnHto7ZvmdRHpYv2GqZ9GWy+qFrL0rQ3y71hcFbQmQAuBp1Gx54+XlJoEnFJ2tYqxJ3Ar0v2qy9W4AtZDifxivFy55+WG49QETVdRVxd6Z7ICTplNYmjEsiJuao3YPCvjM228f05PyZaW8651eCOoSrNRi2lJMMYo4Fd0v1ZCf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rmYmxVQR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CBB74C3277B;
	Wed, 29 May 2024 01:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716945904;
	bh=zf8s5RHrZA8BEOuRcxEqi4aPDsDD+nIYBPFtOZfVC/g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rmYmxVQRcc0SOrKj4HRTTf1DLipqAkkdKpd+CH+elFu0wCEtJMnaBXvA1QvapZHdK
	 Vl1GzNwViWgvxWmly0Sc61Lhp44ZtKz1bFg2N7sqP7VPi4j/jVD3Oq5Lj/XNRgluis
	 6C78hYOmc+AGycX3KYSonpMYhOI9yfFbbCJv397st8DWwrVTpvwwo14HFg3Dfg3t8W
	 dPofaMLsM1k8KWclY8tnHoLl2q+0qUicx/HVewxQwqcpzpxsWUVVHOsTtipHouDSCB
	 p8+yISYoBO4r79aa4kcXJ5GyNdZbuk+OjxClwowpW7nx2XsV88cz5dy/8ArpsD0xXY
	 pmwocnUBNOonw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AC210D2D0E9;
	Wed, 29 May 2024 01:25:04 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: fix inet_csk_accept prototype in
 test_sk_storage_tracing.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171694590470.19217.3411263321012385916.git-patchwork-notify@kernel.org>
Date: Wed, 29 May 2024 01:25:04 +0000
References: <20240528223218.3445297-1-andrii@kernel.org>
In-Reply-To: <20240528223218.3445297-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 28 May 2024 15:32:18 -0700 you wrote:
> Recent kernel change ([0]) changed inet_csk_accept() prototype. Adapt
> progs/test_sk_storage_tracing.c to take that into account.
> 
>   [0] 92ef0fd55ac8 ("net: change proto and proto_ops accept type")
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: fix inet_csk_accept prototype in test_sk_storage_tracing.c
    https://git.kernel.org/bpf/bpf/c/9dfdb706e164

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



