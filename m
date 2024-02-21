Return-Path: <bpf+bounces-22432-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF9E85E363
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 17:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAD1B283E99
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 16:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9E67FBD2;
	Wed, 21 Feb 2024 16:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZN0HFzc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7354A36102
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 16:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708533032; cv=none; b=WQZmj2mbdbN8+0xwHIE/iUQQiL2V7Nzqm8Vn1jBV5szDG29D2GkSvx1ROV8sNp2TvjvtGgG9sz8R8s6NLCpfg2WYmQDtZWYQPsETusjRpw6jDum/qDxS+jqAIAFPLE1/Ue6RYCCI8B8Q0/5mQoK3Mos+BjfI3Hd65w5jWxTk+sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708533032; c=relaxed/simple;
	bh=UJk+H7R4b/fhb2eMsQ3xtClIcL5yshxKale5aEr2108=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e0OYgaMNZpRHRN+HmN4o5hd8DeBh6ti1lreFQBW6gRvIIRJP0cASHnN/JmBRKYx6+qipjHh4UMXhPmJaLDt21zM7sF7fFxh21adFvVRmVs8JrZKJzJXhF8FVrLmOHJIdyWe1DuqfyyWosbI32DhViBivGWoibgsFS46ZfljCRwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZN0HFzc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EE790C43399;
	Wed, 21 Feb 2024 16:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708533032;
	bh=UJk+H7R4b/fhb2eMsQ3xtClIcL5yshxKale5aEr2108=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CZN0HFzclvLqOTFQNKvoQOU4ZvXbZM+NrAuffIUUKt0Y761O8uOWLkov+p+Y57LQo
	 i1boNvBROJp+M+t5bJSTxatmJycckaFXX2QRWYSapAwUmDrTIjrH8nrEZMJQ3f+bq2
	 MbCJUgXWgJsJAXIc2YpFmf6t8fe1YfOlz9rJzV5xaBaXtHa+wOhkNxL1CSEJ4D5wK+
	 YgslbMhRDWhS7PRxG90CgXLNJO8/m0/TSF9M6i/biodXiIZyWx8rhcQqKodtk5HxND
	 unz/WVFPmf2AvSuFDZ9gkMnDlfIp7tsPZZYMHJc+nCGTdsVrEGEmWLsHjPwppxt+M8
	 TThzb1/e9q2Pg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D1924D84BB9;
	Wed, 21 Feb 2024 16:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Remove intermediate test files.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170853303184.4987.661613631213954336.git-patchwork-notify@kernel.org>
Date: Wed, 21 Feb 2024 16:30:31 +0000
References: <20240220231102.49090-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20240220231102.49090-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org, kernel-team@fb.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 20 Feb 2024 15:11:02 -0800 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> The test of linking process creates several intermediate files.
> Remove them once the build is over.
> This reduces the number of files in selftests/bpf/ directory
> from ~4400 to ~2600.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Remove intermediate test files.
    https://git.kernel.org/bpf/bpf-next/c/a48524a486f3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



