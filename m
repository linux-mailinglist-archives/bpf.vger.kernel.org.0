Return-Path: <bpf+bounces-19714-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E228830252
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 10:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEA3428661D
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 09:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5F713FFA;
	Wed, 17 Jan 2024 09:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OwDBPmtk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC54B13FEB
	for <bpf@vger.kernel.org>; Wed, 17 Jan 2024 09:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705483824; cv=none; b=jw8YhHBpI1Ok8BrFIFCU4rwFxZ0FgvyzavZ1RhsZBglghirIQXorZTJ2RFLVD5WPpOVklnYwSVlTXZRSjnyx9GXt/6lb0DJjbTxrMFoKb8PRS4rVCrVIRw08B3mHmtnRRzk1GlRYJJlGrJrXO0E8uWTSmFNt+V/2TpwXwpSAIQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705483824; c=relaxed/simple;
	bh=bi5kHH3uNJitKZ2twRisHFVZSvSEYXv4KDeNBWvtyhs=;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Z+BzRG1pXC5w2NZ5zerxtmJVWPOgnFZ81j7DVXz+Zt/4rwJHge9niZcfanDgEGyDWk6677J3XORZrRWB7uGHXHj2qKicw2hwl+28I/JwmTvDVLnmvtkbJO82X3yey0dD/yBm+hZavgl9mml2kidzawMQ+khV5hTlC/eopbhIFpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OwDBPmtk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79576C43390;
	Wed, 17 Jan 2024 09:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705483824;
	bh=bi5kHH3uNJitKZ2twRisHFVZSvSEYXv4KDeNBWvtyhs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OwDBPmtk3dUPrf60lIl4NQ5rxgPrTHwt2sWIQka/PZuyfJEmIWM3ybTHig9uRpggU
	 JKYAkvsxX1+mqk0UFkkTsWgGWSqXvJRh5uswPyp30dUgNC5oLSyobnJ0Ks6M6I98Ff
	 RfOuFNzC9oeiLhVSNHDW7NC+DmqJ1Bv+dgZLeUWiuc+/1FXg6UY2EQ+MuVE0QubmHa
	 fHYE0OcGqefyp0JaIt2/vVIvLYwS7dVCFXz1HSF0boInH8nFWxn/T6VSyV8srlO4v2
	 /Kyoczyh+BdI36TY72s2OaG9PcOldKJNx9wbkz2xk2a3ZJdPckDWpNmWLvs/UJCGhb
	 d2JP5WL0xVllg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 61E86D8C96C;
	Wed, 17 Jan 2024 09:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] fix bpf_redirect_peer header doc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170548382439.26855.7775028080477717698.git-patchwork-notify@kernel.org>
Date: Wed, 17 Jan 2024 09:30:24 +0000
References: <20240116202952.241009-1-v@nametag.social>
In-Reply-To: <20240116202952.241009-1-v@nametag.social>
To: Victor Stewart <v@nametag.social>
Cc: borkmann@iogearbox.net, bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 16 Jan 2024 20:29:52 +0000 you wrote:
> ammend bpf_redirect_peer header doc to mention tcx and netkit
> 
> ---
>  include/uapi/linux/bpf.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Here is the summary with links:
  - fix bpf_redirect_peer header doc
    https://git.kernel.org/bpf/bpf-next/c/985b8ea9ec7e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



