Return-Path: <bpf+bounces-20650-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E49E8418BA
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 03:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 368791F22F2F
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 02:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9FC364A5;
	Tue, 30 Jan 2024 02:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iy3vxZ56"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4914F33CD0
	for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 02:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706580025; cv=none; b=DAGsuew1ziwtS/08XZ/YtAusfCynMbcp+vS8V9KYMtFZZGHygHs9iTWJSSu8ScpkWPHJTA0bSzlF8ElEMYOnAXsAh28sKmmPIbkAb9rOlZBdoBEsiaFNE67upcj4WiLJTZX5vymFA15iauKRXYWc1kMWwHWYHoDy9cQoRUDJ17c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706580025; c=relaxed/simple;
	bh=l5cCnJcCPT/wcfjGnZ6Qyb3ayGyqxSOeKk+Bwlzc8pE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=f7HlOOluBmrU530aPNVq/EOCtXp0XCAIjkSQu+syaMxg5CSz1uM6BuXpHr4ygYrC3lxVYpz0/PxXoknmkGTYLTQ5AqfiiP4aKeJ+BX6WzcAPwHt1L4kt9PsDhWuwEM5r/kTQNRFe4tojRaVVt9HNCUH/JtYB4uzIVFDK/f37KG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iy3vxZ56; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C6B69C43390;
	Tue, 30 Jan 2024 02:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706580024;
	bh=l5cCnJcCPT/wcfjGnZ6Qyb3ayGyqxSOeKk+Bwlzc8pE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Iy3vxZ56EfBXkjn+qNBfxq8J8FKl54dkVjNZMugTDUUN4sK4J6WGC5XXmZdZVzQ9u
	 +UpIH6Jg4YqwvnaMG8w6PZAk7qV9ieh1GX8necUiyQNoTukjVv+EDZuC7Ygi+wASl9
	 IzlsNXD5/NPxGTpF/q9EChZPRGKfzK+I+pZB87mN3IJQpb9aELg5yyaXd4AafrGnmj
	 gJJio/7I0ET15yyxAyqvaMIBhegR8+nOzUmdPCexaSOW4O8BJBCAnHOWenYscqB+h8
	 mjGSjgBNJUYvn6WIiDxZLmqeh67j/U5hhkyZCEZcM5yJi9NoBN7Y4LJG3urnSbiMa3
	 l0SxVrQM37BnA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AF85BC43153;
	Tue, 30 Jan 2024 02:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: generate const static pointers for kernel helpers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170658002471.10245.3725937330436462463.git-patchwork-notify@kernel.org>
Date: Tue, 30 Jan 2024 02:00:24 +0000
References: <20240127185031.29854-1-jose.marchesi@oracle.com>
In-Reply-To: <20240127185031.29854-1-jose.marchesi@oracle.com>
To: Jose E. Marchesi <jose.marchesi@oracle.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com,
 yonghong.song@linux.dev, eddyz87@gmail.com, cupertino.miranda@oracle.com,
 david.faust@oracle.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Sat, 27 Jan 2024 19:50:31 +0100 you wrote:
> The generated bpf_helper_defs.h file currently contains definitions
> like this for the kernel helpers, which are static objects:
> 
>   static void *(*bpf_map_lookup_elem)(void *map, const void *key) = (void *) 1;
> 
> These work well in both clang and GCC because both compilers do
> constant propagation with -O1 and higher optimization, resulting in
> `call 1' BPF instructions being generated, which are calls to kernel
> helpers.
> 
> [...]

Here is the summary with links:
  - bpf: generate const static pointers for kernel helpers
    https://git.kernel.org/bpf/bpf-next/c/ff2071a7b7fd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



