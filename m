Return-Path: <bpf+bounces-30601-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D766A8CF098
	for <lists+bpf@lfdr.de>; Sat, 25 May 2024 19:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91994281A42
	for <lists+bpf@lfdr.de>; Sat, 25 May 2024 17:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9B9127B7D;
	Sat, 25 May 2024 17:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjZb1VeX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894931272CB
	for <bpf@vger.kernel.org>; Sat, 25 May 2024 17:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716659433; cv=none; b=mMT1SAKyEjt41wISd8z4kYaOO9G/ih0zv9bXa08f/OIJaYL7+tePUZnqqFvP7Cpk8RUqCPSB3w6ojtbcokYDIuAzr5bwNH1HW7G/d+2y1oraQjmY3ARA8hlsaED6slLA9RWy1fj2ZKjXNJJnthODfl2RPLhPoLa3p52KmYQdqG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716659433; c=relaxed/simple;
	bh=oNRLdFHqNN3hXcsc+3U3NayPpmJIBQnfpLy5sKmUxWk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=neB/nuvYitdLigJpQiKPpR0DK8g5WNcCoiXr43PIxtDckdlOErA9uSKqyHNyMc1ce9Wb28Rxo5PGX7nSVWvlfeeI1VIIoFBBUuhYL5bOmIIpGkp+kTOKullcxjEAoUlHjPVK9/zoAHCi28ch8ghpozTIRfVCOzlBZVrN2crrPOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjZb1VeX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E38EC4AF08;
	Sat, 25 May 2024 17:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716659433;
	bh=oNRLdFHqNN3hXcsc+3U3NayPpmJIBQnfpLy5sKmUxWk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hjZb1VeXizhzkUGsI1CqCXQLs52BoOC4ilrX50iB2V1QnNi8Zpu8zTPLjtra89lRo
	 LSaB0rCSwJV4ESkpCKvKWWCqUw+WJThkUcVPWQghSo9vkPmsOANJSxzY6K9L1reG8S
	 G+KnXwLITxlZOzSjVYqIRobhC+sgnCVrWMPTJ1iw+6ufxhvR3l283aIscrc0nu2w7h
	 xW6rrqszYLCsszm90u/3JccoLapF5iouEMBB+yECcXZ6QjPqnFYyHhcrm5vKP3xmeh
	 qkZ58SnY8a32HElVwVP+saB2b93Ks8V/x9Bg5Soi7e8HlVVILCq9ygdu3Z3lo/TEsh
	 3C/1DzCPuB9pA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 14C33C54BB3;
	Sat, 25 May 2024 17:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpf,
 docs: clarify sign extension of 64-bit use of 32-bit imm
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171665943308.11416.14212142886335831788.git-patchwork-notify@kernel.org>
Date: Sat, 25 May 2024 17:50:33 +0000
References: <20240520215255.10595-1-dthaler1968@gmail.com>
In-Reply-To: <20240520215255.10595-1-dthaler1968@gmail.com>
To: Dave Thaler <dthaler1968@googlemail.com>
Cc: bpf@vger.kernel.org, bpf@ietf.org, dthaler1968@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 20 May 2024 14:52:55 -0700 you wrote:
> imm is defined as a 32-bit signed integer.
> 
> {MOV, K, ALU64} says it does "dst = src" (where src is 'imm') and it
> does do dst = (s64)imm, which in that sense does sign extend imm. The MOVSX
> instruction is explained as sign extending, so added the example of
> {MOV, K, ALU64} to make this more clear.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf, docs: clarify sign extension of 64-bit use of 32-bit imm
    https://git.kernel.org/bpf/bpf-next/c/4e1215d9a190

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



