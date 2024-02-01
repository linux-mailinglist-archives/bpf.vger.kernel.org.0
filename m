Return-Path: <bpf+bounces-20935-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25612845555
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 11:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5198288CD9
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 10:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3850A3A1BB;
	Thu,  1 Feb 2024 10:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UXcsuLsG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B384F12FF7A
	for <bpf@vger.kernel.org>; Thu,  1 Feb 2024 10:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706783424; cv=none; b=HfONVqLKeonIh2/c9Q21Qcd5kKb8Sy3O2pziEH+Wsp3norsJlGEXyB1ICQPj3oKO/Rpw4RyAf6Yu/WRS4C/FO+b9l2NxyRSIfXiQjgAhuMAbeDILhzSwNuXNh6mKh/zi5M3DbUPMPRzHLWJs3uNDa2C+JyTbURfNJdNt3K8vtyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706783424; c=relaxed/simple;
	bh=9U/kTicoJlbnYKC6Vm21VrAQvjRV28XWo0bd49uSdvM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VP7VVS04SITZrqcrgOASmpUKp1fimDF0owxMU+UXvJTm28sWvkrHYFosbYHyzPbjrOX6eY7leZUvjVVDlbw5yhP0uaTo1KgcmHKgsDGkFDVUXFCh5SMfqasB4Cma1Y/VEUVzWVyitJsDdOzg2FZci8l7uI0g7DA6CUv8qy3YcWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UXcsuLsG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1F3DCC43394;
	Thu,  1 Feb 2024 10:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706783424;
	bh=9U/kTicoJlbnYKC6Vm21VrAQvjRV28XWo0bd49uSdvM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UXcsuLsGsXwRj9VrLE+MGCF3CYJK6PsgIBHvNJI8W1GFRu3KQqNbrZcroeghqQFa4
	 p6R/P92+9oSB8iYsfpKqHMCmBzw4SG5cZj2l0H9mvu74NWLc+C7Fh/3+eEjUIV/Eak
	 Z4FbnNY0VsyGZI7hKnGTC2E+wS7F7s8nOA1BhK253JR1p3E2nPxqop4clB9Z3pAGo3
	 MHn8gW04lf7oenob/v2TQM2xTluGYxzgkxldai46sJFEHiA1Tb1hFrPseQvku+jsLK
	 +pBFuTZ144AGFGqeCsNO3U7VADGW9gEDevMsAkQD7y5fCeoR9F/9H4SjtsfgfWS/Ba
	 CGeNggSNIeRzg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EED9AC0C40E;
	Thu,  1 Feb 2024 10:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] [libbpf] remove unnecessary null check in
 kernel_supports()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170678342397.6867.12756440929745509833.git-patchwork-notify@kernel.org>
Date: Thu, 01 Feb 2024 10:30:23 +0000
References: <20240131212615.20112-1-eddyz87@gmail.com>
In-Reply-To: <20240131212615.20112-1-eddyz87@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 31 Jan 2024 23:26:15 +0200 you wrote:
> After recent changes, Coverity complained about inconsistent null
> checks in kernel_supports() function:
> 
>     kernel_supports(const struct bpf_object *obj, ...)
>     ...
>     // var_compare_op: Comparing obj to null implies that obj might be null
>     if (obj && obj->gen_loader)
>         return true;
> 
> [...]

Here is the summary with links:
  - [bpf-next,libbpf] remove unnecessary null check in kernel_supports()
    https://git.kernel.org/bpf/bpf-next/c/8263b3382d8c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



