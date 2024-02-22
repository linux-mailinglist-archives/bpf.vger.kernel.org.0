Return-Path: <bpf+bounces-22518-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B34008601A5
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 19:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A11B1F2730A
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 18:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0114A46557;
	Thu, 22 Feb 2024 18:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fzO2ztnq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6001EB3A
	for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 18:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708626631; cv=none; b=MdAngf6gtp8XeG4OzrUxnOxBWfmJmq76A8gC+DHFRIAV1BoxWmSoJ80/71qljZMqwUXGAD5uzT3WCWTenjH4uTJtKQlBQUsCC77ID1ZKHS+kQofSJ1wtUqYB6M8Rv/K/0fOaMDQnbHeoaPN6wBzOrMEOqXIaetfbEgZLNlI5t1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708626631; c=relaxed/simple;
	bh=dTtIg4xUbIZ7m368yaeHaY6iKBpyaobzKn/doSBU9Pg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SNNiyamsvDm5a0yfuetx4WyKRPNW/R6KOFG7Q7d6RlOe0FQVA9ozkylsor4BLq1bfFPHyyMxnmuFb7/bBYs/kD/eSgHgQjfjFB5kq1B7upl1OZAFsag/OJsnqilmYwGTtiFhKWRO0/y48ysBvbVs9ZzpXXra+oNcWvBZ1E/d590=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fzO2ztnq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 37A3FC43394;
	Thu, 22 Feb 2024 18:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708626630;
	bh=dTtIg4xUbIZ7m368yaeHaY6iKBpyaobzKn/doSBU9Pg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fzO2ztnqoO2D+GDfi7Bmigy4Y0WjgNOCH1e/3fDzZkiYr80aLZQli6hvp9WNmAqxU
	 Sua1sBWJx2B3UwLo4F7sc0XuDk2bM5a62r4qEvYmHUiaXHux1YBUtySYjvvhSp2WRd
	 DDFVKFOYktEaDYbzMudLkRHCExqhmeIxshKyB2q8X4gv25lOKOtdwMN2DWU45tMiE2
	 LrVW4Uso3NIfG4MMs86Yhrs+BgmXIlvt+CeVL6awLEo4xeHdP7jJVGvRaXiH1hQcfq
	 CbKhBCqKrTRtCIet5ywndn/bh82ERFvzZotgb3lmbv/SBU624ZAVf13x0tvQAyShbU
	 iLxUCDjQgHKoA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 19897D84BBB;
	Thu, 22 Feb 2024 18:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpf: clarify batch lookup semantics
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170862663009.28435.7069104375034642135.git-patchwork-notify@kernel.org>
Date: Thu, 22 Feb 2024 18:30:30 +0000
References: <20240221211838.1241578-1-martin.kelly@crowdstrike.com>
In-Reply-To: <20240221211838.1241578-1-martin.kelly@crowdstrike.com>
To: Martin Kelly <martin.kelly@crowdstrike.com>
Cc: bpf@vger.kernel.org, yonghong.song@linux.dev, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Wed, 21 Feb 2024 13:18:38 -0800 you wrote:
> The batch lookup and lookup_and_delete APIs have two parameters,
> in_batch and out_batch, to facilitate iterative
> lookup/lookup_and_deletion operations for supported maps. Except NULL
> for in_batch at the start of these two batch operations, both parameters
> need to point to memory equal or larger than the respective map key
> size, except for various hashmaps (hash, percpu_hash, lru_hash,
> lru_percpu_hash) where the in_batch/out_batch memory size should be
> at least 4 bytes.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf: clarify batch lookup semantics
    https://git.kernel.org/bpf/bpf-next/c/58fd62e0aa50

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



