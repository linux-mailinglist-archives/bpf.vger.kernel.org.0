Return-Path: <bpf+bounces-78430-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBCBD0C98D
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 01:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 903613027E2A
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 00:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728C51CFBA;
	Sat, 10 Jan 2026 00:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3OebkuP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40624A07;
	Sat, 10 Jan 2026 00:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768003411; cv=none; b=rylecnEoBUsu6fFyBdR0wTNPZ1aNhDadAjmNBbQdtTwS2a99scuN+XHxVN77Qc57aoSY+MZ7X1DjZ0bptKTKch62zox0rZNCJOA84AokY3Pm5YNe3I9dUsrj19hgN0DR5+cZxTo0AiCEJSFYdrnmL/6Ga76Yu5V1d4kelj4VS8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768003411; c=relaxed/simple;
	bh=bF6LZUDeyRLYqaCvwEPUtJ8MSARL+bqamq9IhE6XQuw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XSVkmJgPHZs00SKcJ/r6yaVcPIWur+3VSBwAq+eZadeTOQZUlZnIVBBHHhWC1yooj1REwjNqCF7Az6rt3Ot4OfRyV8aHemHO2Kqu6eZ4d3ECXHY81Ock8/tO4v0xJS8oDYy3PYe+7recca9L4Imu12BrlyGl8ROT/yuAFbEQT+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3OebkuP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99F01C4CEF1;
	Sat, 10 Jan 2026 00:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768003410;
	bh=bF6LZUDeyRLYqaCvwEPUtJ8MSARL+bqamq9IhE6XQuw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q3OebkuPsBAkXCk8NJGV2CkamceONtoLOVM61erWXe7J00XEct1EmaTsjYtdYa9uB
	 6XQ6FGhfRmTdcr7IOM0iSlU3BoKr7o3yMC3ixCtkNL1XB3GzLQemgtSd4AFkua6Bl2
	 dx1Y3mieEyJ67BcnCna2yaUE8CEs1L7GB1fHojyTnXy9eGkFKpN/jaJdPJtopPRgOD
	 nxuRoe+fTi6SY8+2rboo6WWEepQ0JUssYXDtL2I6yMY1LVWV/ThwAD/7L1rhuzH1E/
	 9oa1pV2665HwJfk5JlviQh+K1M+jibOSHmuXjsqubRK9lCv3ljJRWxFL2ZOamqAHdP
	 2czq5rPqDISrQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78C9A3AA9A96;
	Sat, 10 Jan 2026 00:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] libbpf: Fix OOB read in btf_dump_get_bitfield_value
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176800320632.431515.385277926966372587.git-patchwork-notify@kernel.org>
Date: Sat, 10 Jan 2026 00:00:06 +0000
References: <20260106233527.163487-1-varunrmallya@gmail.com>
In-Reply-To: <20260106233527.163487-1-varunrmallya@gmail.com>
To: Varun R Mallya <varunrmallya@gmail.com>
Cc: andrii@kernel.org, alan.maguire@oracle.com, ast@kernel.org,
 daniel@iogearbox.net, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 harrisonmichaelgreen@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed,  7 Jan 2026 05:05:27 +0530 you wrote:
> When dumping bitfield data, btf_dump_get_bitfield_value() reads data
> based on the underlying type's size (t->size). However, it does not
> verify that the provided data buffer (data_sz) is large enough to
> contain these bytes.
> 
> If btf_dump__dump_type_data() is called with a buffer smaller than
> the type's size, this leads to an out-of-bounds read. This was
> confirmed by AddressSanitizer in the linked issue.
> 
> [...]

Here is the summary with links:
  - [bpf] libbpf: Fix OOB read in btf_dump_get_bitfield_value
    https://git.kernel.org/bpf/bpf-next/c/5714ca8cba5e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



