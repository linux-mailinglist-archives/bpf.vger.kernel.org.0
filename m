Return-Path: <bpf+bounces-29787-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDD38C6B1D
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 18:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C058B21914
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 16:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA25757F3;
	Wed, 15 May 2024 16:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ujRFFUVL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13EE482DB;
	Wed, 15 May 2024 16:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715792292; cv=none; b=ZNPJqKnOJ5DDslx8lEtDNd0lIyik80s9K5p7q56VtKLmmgMR8j19/tMNSytutQAr420OKtKEtdgi1KA6QvgxSEKSETdN70p0cCt7IKiQn6HhuMDpRol6czYvmXaRy/HFNXZPsxIUN/2o7kGL7HaG+DgOFSoCHyhGRI50iuhJjkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715792292; c=relaxed/simple;
	bh=SLGJTmZ/6Fdf4e/gBCHc7aKNPKQaZTTyFRcj/nywmi8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mF3LtM5PuctwrOyZZUMTCAVSJXJPWUAkmTqdUyYvXcCk8l6eZVZf3pHxdiIQQLt9wEeI7bHBBSaMIr7xBp2pmWvH4qK1j8u0JjnXbbtM0mtl38pD133WRUe8YRqmWEX/4wDFeRp75Lnc+iS11LJFZQgarCsaHVxrHeqUpViNFcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ujRFFUVL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 38A21C4AF08;
	Wed, 15 May 2024 16:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715792292;
	bh=SLGJTmZ/6Fdf4e/gBCHc7aKNPKQaZTTyFRcj/nywmi8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ujRFFUVLopOlmxrneZm+NxDYxlabD2gPBNXR9bvxzdgmJwrITYlOfW546/pfuvRSF
	 PEM3IPJwljzkMw2rnoZyOsRtEClOVHCpoAe+8MZ3u6UAo31J64f+bbYG1t45Y1+9UG
	 i9mkISm/Hx+GM2Mnz3ottEM8+8WFPZ6bH4TU4IpEahR7mYJgvvYokX7T5o815hvchD
	 HNng6HNUSL40LQ1s1tHfTZ1RVn+kO1ZT0h6D9QOzqudJSGlt2XJgedqipsHG55+4SQ
	 suz9ZpZBvUCknyhBmU6/TUoBR0D8Kc/iSqlCF4MeBZO7o5ZFGZSw68/t5rrE7/+P9L
	 XvCoUnmXIXF3w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2CD4ACF21E3;
	Wed, 15 May 2024 16:58:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf,
 docs: Fix the description of 'src' in ALU instructions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171579229218.15564.16554458070344125415.git-patchwork-notify@kernel.org>
Date: Wed, 15 May 2024 16:58:12 +0000
References: <20240514130303.113607-1-puranjay@kernel.org>
In-Reply-To: <20240514130303.113607-1-puranjay@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: void@manifault.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, corbet@lwn.net,
 dthaler1968@googlemail.com, hawkinsw@obs.cr, bpf@vger.kernel.org,
 bpf@ietf.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 puranjay12@gmail.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 14 May 2024 13:03:03 +0000 you wrote:
> An ALU instruction's source operand can be the value in the source
> register or the 32-bit immediate value encoded in the instruction. This
> is controlled by the 's' bit of the 'opcode'.
> 
> The current description explicitly uses the phrase 'value of the source
> register' when defining the meaning of 'src'.
> 
> [...]

Here is the summary with links:
  - [bpf] bpf, docs: Fix the description of 'src' in ALU instructions
    https://git.kernel.org/bpf/bpf/c/7a8030057f67

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



