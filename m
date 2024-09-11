Return-Path: <bpf+bounces-39637-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B51F975935
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 19:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3202A1F2788C
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 17:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220921B142E;
	Wed, 11 Sep 2024 17:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMl+7Y49"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B91864A8F;
	Wed, 11 Sep 2024 17:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726075227; cv=none; b=sTk/rRMNB7vTKYI0Gcy0OtsZCaIPGI1bj9ODufgoLjiAAGsqmC2mrAL/XhnDBMLPFHRA2KQa1dJK47zhNNdUyl9/fU8oWB2e7JtR8g0LfTzQOavvhBZ8zI6W30mI3tGylYFDQ2ZpPLntRkyYkGnMfgYfeT450sHjrH+BZnDwNKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726075227; c=relaxed/simple;
	bh=98ks5Fc3x0AX9dpZDV0U7Cl8fxZw0re0ZMXjyhxjlhI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aHSwu09UIt7wk4jm6KCV6/shX7hOJbnd3CJGHdR/B/xsvfHzwdBRVAtDlLDYY8HnFhzrhcqGILnLgAGvtPOLX+3uYeYRCI+HoR1AaAe9Ex7BrA63NaXKtRql5ReTVBOqTSbjRdKzcWm93lFXkEhVG5VF2MGue4/BjwyJK5Z8ROY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMl+7Y49; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23533C4CEC0;
	Wed, 11 Sep 2024 17:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726075227;
	bh=98ks5Fc3x0AX9dpZDV0U7Cl8fxZw0re0ZMXjyhxjlhI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RMl+7Y49VoU8fmOg+p/zvYTDJhIT1fKjVlYw6bYAFQ5RxUZNyH/c2UOvcTaEDABUa
	 WPzg6A0FmIro/QF8SjvxPJ2dQcrNQHFQTTC7BLkbrNuKseQypEaktwFx+hgXILQECL
	 K9T+FFOYIlKf+4nDJhpu01e230mrSWMoSWfsMnweAJwwIWTIJ/jXMyYNqvkx+IuXUq
	 TwiaXKXr5v7JA4KKtDoMJS1BC6X1kKBKfMyEUDvS3HaINaRuzPbwEJpKPNKVfArv8S
	 U3wQSqiZb1ZkIkVI1gE/CgGqUG7LOPR0B9K7uPIy/gWnzGZ0exoLS7DyaFkyrUqvGW
	 dJrLgKrEfPwUA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F913806656;
	Wed, 11 Sep 2024 17:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: lsm: Set bpf_lsm_blob_sizes.lbs_task to 0
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172607522827.991126.7838774747396022577.git-patchwork-notify@kernel.org>
Date: Wed, 11 Sep 2024 17:20:28 +0000
References: <20240911055508.9588-1-song@kernel.org>
In-Reply-To: <20240911055508.9588-1-song@kernel.org>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, kernel-team@meta.com, andrii@kernel.org,
 eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, stable@vger.kernel.org, kpsingh@kernel.org,
 mattbobrowski@google.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 10 Sep 2024 22:55:08 -0700 you wrote:
> bpf task local storage is now using task_struct->bpf_storage, so
> bpf_lsm_blob_sizes.lbs_task is no longer needed. Remove it to save some
> memory.
> 
> Fixes: a10787e6d58c ("bpf: Enable task local storage for tracing programs")
> Cc: stable@vger.kernel.org
> Cc: KP Singh <kpsingh@kernel.org>
> Cc: Matt Bobrowski <mattbobrowski@google.com>
> Signed-off-by: Song Liu <song@kernel.org>
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: lsm: Set bpf_lsm_blob_sizes.lbs_task to 0
    https://git.kernel.org/bpf/bpf-next/c/300a90b2cb5d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



