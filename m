Return-Path: <bpf+bounces-15098-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6FC7EC805
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 17:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E989B20C26
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 16:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F19A31725;
	Wed, 15 Nov 2023 16:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="laFL3KSq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89DB433D7
	for <bpf@vger.kernel.org>; Wed, 15 Nov 2023 16:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 249A7C433CA;
	Wed, 15 Nov 2023 16:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700064024;
	bh=y1TRGvJRsTZFkuNRfXuZylsqHYuk2QJrszT8bEd4m+M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=laFL3KSqlEpdiD+70vE1v8wEe5K26pTpnCGM8chbbiZHJrzvd72fGCww5dM1MzHGU
	 pvbITAYT0Zi0Q2l4G08ao7qpXd6lMY6wqhBbTw0YYZXIqJcx7kfb/8q1K+EZBQ6GIK
	 mPuFO983EhwrhbwiLIbV3r5QIdj183JvzksBDcS3k1b2EOuT8DtKL/5zqKgU4Evy8h
	 o7hqU1z11DNcTH1f8WDXnU3D2RLaeid0RXclJd0ESHP1muGV5zrsyqSQ+DNwUGiDCo
	 0wO6uhJapFOg6QDmEtjTkwMbIH+aa+5OPNiRrdzZ4B8rD116bVxSv/krCKAcuN4dVl
	 ns9QyIocm3MPA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 03CABE1F66E;
	Wed, 15 Nov 2023 16:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] bpf: Do not allocate percpu memory at init stage
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170006402400.6377.8116008282517410601.git-patchwork-notify@kernel.org>
Date: Wed, 15 Nov 2023 16:00:24 +0000
References: <20231111013928.948838-1-yonghong.song@linux.dev>
In-Reply-To: <20231111013928.948838-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org,
 kirill.shutemov@linux.intel.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 10 Nov 2023 17:39:28 -0800 you wrote:
> Kirill Shutemov reported significant percpu memory consumption increase after
> booting in 288-cpu VM ([1]) due to commit 41a5db8d8161 ("bpf: Add support for
> non-fix-size percpu mem allocation"). The percpu memory consumption is
> increased from 111MB to 969MB. The number is from /proc/meminfo.
> 
> I tried to reproduce the issue with my local VM which at most supports upto
> 255 cpus. With 252 cpus, without the above commit, the percpu memory
> consumption immediately after boot is 57MB while with the above commit the
> percpu memory consumption is 231MB.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] bpf: Do not allocate percpu memory at init stage
    https://git.kernel.org/bpf/bpf/c/1fda5bb66ad8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



