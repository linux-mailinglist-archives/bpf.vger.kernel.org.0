Return-Path: <bpf+bounces-73910-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 548FBC3DEDE
	for <lists+bpf@lfdr.de>; Fri, 07 Nov 2025 01:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D17C4E8B3D
	for <lists+bpf@lfdr.de>; Fri,  7 Nov 2025 00:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05222153FB;
	Fri,  7 Nov 2025 00:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZusQv152"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644FC249EB
	for <bpf@vger.kernel.org>; Fri,  7 Nov 2025 00:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762473659; cv=none; b=PyCWBFp+ocJv1+kmwxWYNAl+8iKvHioGDfgZFpHATuFrmu6UBBLhPmisvE7f1emQFMMXG45vao/EIf4QssSGVE7P9jV8t6j5dr+/Vh15d0LB/jOlX7YmcnlzVKD1KHBYmZIDfFhQ5D4OEjwK0qY+9DqOhMSq8bO5KKsui9TQhAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762473659; c=relaxed/simple;
	bh=2ECZl7ifTLuC/gBMHhFttHarIGem8iutFuQKLVV7um0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qm53RJP4XYtnyW/+ev9c3ZO5zzUjUdN9LEggfXIUqX+svJFqAPylVGplGDwt2WSoGh0yIqad4itTLdWRyBSaeAw7ptxDcDa2bnRaVEbxeBTrlQKvTZupUscVtrcLHpU6U3QPq7kFp7JlT7QUSLnX+3eON5UiTPon63Oo4op3W7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZusQv152; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E740C4CEF7;
	Fri,  7 Nov 2025 00:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762473659;
	bh=2ECZl7ifTLuC/gBMHhFttHarIGem8iutFuQKLVV7um0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZusQv152jJO5rzTSld29qo3LtLN+80CEBY4bwjP3NtpLG2S/LsdKhkiUUoT1zc27D
	 H3MnQBSmEbXHW9PxqA3jwC7+pcRixFrLaWDAGFVibMii5lRxKZsQO/2LgkF8KQObCy
	 r5X/2LijWuRrAq+zpISPAljHLx+GfHxyxqIP5BxPRPKUlDTTrhbCwYUNxveKlhrMlt
	 2IuY0VX35cE/uUGgCXWTl1nRnpoeOe4lcRE6kA/kAFXkbVJtvQ+RoXS0UJAiqStC3b
	 feeq0A6xjv5p93bjsvlego8+EjFutUUYA3+v5pwuJ4CeqfsSqxjiFYYIw3h5p8h0pO
	 f/eo7C+qdC/vA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D1B39EF974;
	Fri,  7 Nov 2025 00:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpf: Use kmalloc_nolock() in range tree
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176247363174.398561.3887499336535576319.git-patchwork-notify@kernel.org>
Date: Fri, 07 Nov 2025 00:00:31 +0000
References: <20251106170608.4800-1-puranjay@kernel.org>
In-Reply-To: <20251106170608.4800-1-puranjay@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, puranjay12@gmail.com, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu,  6 Nov 2025 17:06:07 +0000 you wrote:
> The range tree uses bpf_mem_alloc() that is safe to be called from all
> contexts and uses a pre-allocated pool of memory to serve these
> allocations.
> 
> Replace bpf_mem_alloc() with kmalloc_nolock() as it can be called safely
> from all contexts and is more scalable than bpf_mem_alloc().
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf: Use kmalloc_nolock() in range tree
    https://git.kernel.org/bpf/bpf-next/c/f8c67d8550ee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



