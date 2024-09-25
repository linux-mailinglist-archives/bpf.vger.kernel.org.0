Return-Path: <bpf+bounces-40287-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5E59856A4
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 11:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 239EDB230AA
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 09:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1542C1537DA;
	Wed, 25 Sep 2024 09:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uC7UaI4p"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E07213DDB9;
	Wed, 25 Sep 2024 09:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727257827; cv=none; b=WthpQgufiHu1s3BOWFtS2KrADvB1YtvxoXY3MIUCO3dA93Vc7inIefPNY/2wXcm4jIFPhxL8Z8+yR8KilgLop56ODLnHVn7tbYOFsK+UB2FcGZJjR94jBqSJjr1KYFtV9svm32LhfPv9ojESuGiBB8F2kSeZMgXL8SRC09X1kMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727257827; c=relaxed/simple;
	bh=jl4d46okrvrro63ScrKwf8P5GchqCKS3n/SXcH/iM/E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WwdypW6yXTAKt/jiddRCuBWevAU+oo/wY3DYCwv9t7O8vD9STrCa/OYVN/GfVWwiTs34iyfOcUR1e7zT5za9rtnHHKFfMbhxfm4QczsF9lzUBnSAjEvyRSumXBThzjlZ/xCaUOyUhPUUQ9qemtlUjphtk8EebsZrzCu9pW2Pnpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uC7UaI4p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16A32C4CEC3;
	Wed, 25 Sep 2024 09:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727257826;
	bh=jl4d46okrvrro63ScrKwf8P5GchqCKS3n/SXcH/iM/E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uC7UaI4pKWkq2DVqyGHjhuhG/+JQrKnSkA+EnboqnRYWSdqnOQkLHLsmbXh2cE1UQ
	 N0KNMY9u2S8DFm+ZopyhTcsv5xuMM54/RHFZLBqQ6QBGuC2L7aC/EXIepIjFotnRh3
	 uHZRHCEx7PhQAz8rA84NC18NXD2gqfLeMeyjCq3CqCQqBtWwB2t71gXEHEct6BW1Xl
	 Bdt5fg8ixp1irB4Ozz0qJqFR57M2FbhFe/St7RGpiEZnqxMeTMVzXbj9FTrOp78pnO
	 TJcz0FyF/sz0vzlwANmv1i/taF6ssI7A+9aPSST/BSc7okqo6pm8gy8LXArEmUHuae
	 u/nUz36EFBxwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE7DF3809A8F;
	Wed, 25 Sep 2024 09:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpftool: Remove llvm-strip from Makefile
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172725782851.519668.2924142510144708471.git-patchwork-notify@kernel.org>
Date: Wed, 25 Sep 2024 09:50:28 +0000
References: <20240924165202.1379930-1-chen.dylane@gmail.com>
In-Reply-To: <20240924165202.1379930-1-chen.dylane@gmail.com>
To: Tao Chen <chen.dylane@gmail.com>
Cc: qmo@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 25 Sep 2024 00:52:02 +0800 you wrote:
> As Quentin and Andrri said [0], bpftool gen object strips
> out DWARF already, so remove the repeat operation.
> 
> [0] https://github.com/libbpf/bpftool/issues/161
> 
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Suggested-by: Quentin Monnet <qmo@kernel.org>
> Signed-off-by: Tao Chen <chen.dylane@gmail.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpftool: Remove llvm-strip from Makefile
    https://git.kernel.org/bpf/bpf-next/c/25bfc6333e32

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



