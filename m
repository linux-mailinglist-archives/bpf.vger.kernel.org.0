Return-Path: <bpf+bounces-35092-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD2A9379E8
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 17:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC9311F2195F
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 15:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1477145346;
	Fri, 19 Jul 2024 15:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cISoUJbZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557A64C6B;
	Fri, 19 Jul 2024 15:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721403032; cv=none; b=iILZIYUqIMQ3Hwer4NeDQPm6VcjfLTLFlN4DGRVbFEIUnKZ2+y8dtDbVDY74dNf4wWc+ORqqELFNhCZ2FTsLx1sbKUhQJJ+oawu4x5+JHKKps1cl6RTa/Breka82jEN403E3HB/NATbzIhh4NHVbrq00Bpf6Emg0jfDYO2dugwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721403032; c=relaxed/simple;
	bh=MbadzL5EtrAA0oCsedz5ecC3GGRHLQV2PFtJVOmWaIY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=G3dDf1JiKrm8elu9R/j1gDNfyTTDZVeiTHb7l17xeLuf51oLxgstVWX9+t9tQaJ+i2eRSFVQ/x4+ERA0IpGzZgJA/n3nEdB+eI5M4yWhdNUx1hc3BLzw+Ry4vWYloL9DSEg+BP0j0sRLP+TJO0GBiTxiZkXX9yfzVhnUuGubU8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cISoUJbZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D0815C4AF0A;
	Fri, 19 Jul 2024 15:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721403031;
	bh=MbadzL5EtrAA0oCsedz5ecC3GGRHLQV2PFtJVOmWaIY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cISoUJbZwrjIAUg2vHiLqoZkz+RBL+K2n/npvhOjMaBYHs+z0ucPt7AK8KwU7YwQW
	 65K6qqwNAORRxs+UCimtA+drt0jchP0rhsueC8oi1y3XsZGaPaLlarHsIyyv4hDKTH
	 rcY+55oY5WJIBsBaZsAPzF1yRN3OqMzg6Gl+VaPPD+FTDqyNFN4Dfua8LQ7ZDHUcaL
	 jys+zd/hcZto0vFNl582seeCHHK+NGm4H+92XbqW/pS5CW59gWx037LJLXGbYuXN4D
	 szMY7utYJsiOB/N7oKluQIVZ3xEnJNyE+9OvYIiFogUouIuqrPd/9/1+kzvJKSu1pq
	 wGLgcXZKu4Alg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BD72DC4332E;
	Fri, 19 Jul 2024 15:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] perf/bpf: Use prog to emit ksymbol event for main
 program
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172140303177.32586.15529889393395561019.git-patchwork-notify@kernel.org>
Date: Fri, 19 Jul 2024 15:30:31 +0000
References: <20240714065533.1112616-1-houtao@huaweicloud.com>
In-Reply-To: <20240714065533.1112616-1-houtao@huaweicloud.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org,
 jolsa@kernel.org, ast@kernel.org, yhs@fb.com, kjlx@templeofstupid.com,
 houtao1@huawei.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Sun, 14 Jul 2024 14:55:33 +0800 you wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Since commit 0108a4e9f358 ("bpf: ensure main program has an extable"),
> prog->aux->func[0]->kallsyms is left as uninitialized. For bpf program
> with subprogs, the symbol for the main program is missed just as shown
> in the output of perf script below:
> 
> [...]

Here is the summary with links:
  - [bpf-next] perf/bpf: Use prog to emit ksymbol event for main program
    https://git.kernel.org/bpf/bpf/c/0be9ae5486cd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



