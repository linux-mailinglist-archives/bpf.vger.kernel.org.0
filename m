Return-Path: <bpf+bounces-48255-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F2CA05FA9
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 16:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D060C166341
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 15:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D641FCFF2;
	Wed,  8 Jan 2025 15:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwgWJUvO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09F7B644
	for <bpf@vger.kernel.org>; Wed,  8 Jan 2025 15:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736349015; cv=none; b=M3FdaGKFPHAuO94MdRROjr2GV31q0oaok8wRmK8fudXQpy6OozzEX9CGsqclGAIn7xY4KyPVsnEVHVNzqLr9QdwZUtsB/Mxzobym6PmXzn0n73X0/9jQaOMybyMyPkPtWHBtaPPi6fPDYL5PjhVZa5LSXOi7ftl/BXu5EE61mBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736349015; c=relaxed/simple;
	bh=lCptKdVf8zGkceUQ2X8yWNjI/9pWtK8N8W4U/EMRj68=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=N1p++3Dd9E/VIFsBjbuLf6NbfwtRVcMocIVjzglZwhsvQwlkyr/utxo1quwhrmH7+pYtADjqjlvm+q3jItpvogKmfc22uFPfeCYI4kvjjg33aspwXOR/tmnnlJ3l70vmno+gIU/a8rX6D9HiEkIqVFLpvJ1kV9hoUMMgptzFYmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwgWJUvO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF6BEC4CED3;
	Wed,  8 Jan 2025 15:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736349014;
	bh=lCptKdVf8zGkceUQ2X8yWNjI/9pWtK8N8W4U/EMRj68=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hwgWJUvOiFIOC2mJYMclACp1rfRfanYyGBY3iPjxQKZIDwu8EA4y7+7PC/gxt4rxt
	 0glbcqDUzLIqpFE/V5K87DHixs/hZ6L3ng2iJYP2a2mn/SDrRKOgPXhXLaVmYvM/94
	 fJuVDTrP5Xs1akxyoWXRFvidTSAdujXsvLztyUNC+hurNFMSuR8zhZUgAoW+aqCmL6
	 BsqjzA0cCXROKCZZbwpydGJzNGISdmqz4SnLPnvhtQaNFGvO2r/t0fsaS5Ws1Lhpbt
	 O0eBxvjx8+K5v9RthBsi+SIr4EiXDHwS0fFibwHz0MhROVRnZ+UokBN8twxYmKjQtb
	 2VrNm0BAgAAYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DF5380A965;
	Wed,  8 Jan 2025 15:10:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: handle prog/attach type comparison in
 veristat
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173634903627.678126.16435272239965563207.git-patchwork-notify@kernel.org>
Date: Wed, 08 Jan 2025 15:10:36 +0000
References: <20250106144321.32337-1-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250106144321.32337-1-mykyta.yatsenko5@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, yatsenko@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon,  6 Jan 2025 14:43:21 +0000 you wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> Implemented handling of prog type and attach type stats comparison in
> veristat.
> To test this change:
> ```
> ./veristat pyperf600.bpf.o -o csv > base1.csv
> ./veristat pyperf600.bpf.o -o csv > base2.csv
> ./veristat -C base2.csv base1.csv -o csv
> ...,raw_tracepoint,raw_tracepoint,MATCH,
> ...,cgroup_inet_ingress,cgroup_inet_ingress,MATCH
> ```
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: handle prog/attach type comparison in veristat
    https://git.kernel.org/bpf/bpf-next/c/46c61cbeb82f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



