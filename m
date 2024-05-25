Return-Path: <bpf+bounces-30598-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 136A68CF097
	for <lists+bpf@lfdr.de>; Sat, 25 May 2024 19:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71725B21038
	for <lists+bpf@lfdr.de>; Sat, 25 May 2024 17:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD852127B5D;
	Sat, 25 May 2024 17:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZR+KwhMD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B0785934
	for <bpf@vger.kernel.org>; Sat, 25 May 2024 17:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716659433; cv=none; b=mbtxbvblPiAxHtstDzjqKU5xRNc0W3CVz6HVoOENvur4xlyRWY/hpxygwfi2b+tisHbZ46x1/qsGPxYFSGbMVYqD4kV2WsF8RI7kp73Xqn8ug2TjuxCHZRrAXT4RsxorzxjTJbyTc2NZFwAinWLdEla3NT70MemZI2N5kaecAM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716659433; c=relaxed/simple;
	bh=32QLelv8yzilak+j4uyV4LbtZCysDbTv41Hg9OGUGAQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lLH4ZityY3IJ0u2BmCfC+nqJgm+Yb0XPePzj1rMQ2aVo8aL3FRNBWfrodM4XRWQcorsf5m+KSKs1oFkZpgn4dX8kT7ggWz+4OMj8H8oudFDEgJDY2QMGyx4dmJgPHdIpefHHPtLYZN8d86jmRs5lDVdVD3fZibZZfTxlR/IzS/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZR+KwhMD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46A01C4AF0F;
	Sat, 25 May 2024 17:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716659433;
	bh=32QLelv8yzilak+j4uyV4LbtZCysDbTv41Hg9OGUGAQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZR+KwhMDdYFuK+CrrmQ3xsJeKc7Mom5siy7/QgFrfthEvSRpmdSVU0L0qIjzM8wnI
	 sUUKFezZA6pc37/gfq+L0eik9mmVw08zEscN5G/bW1vEBMTJgDHeZwsb2+AlNiUvLy
	 cTmKtGtzsmbe2AOMAeCnKeVjVVBpVxKQ1p5O0m8Gj3jSgGYr+5TWiNj6EWKltQDmmb
	 ixZUlLqdnEc3+8xTrO4M8cupzFkiHfTAhJlCl+xnx5Hd9GCbHkpP4HOoavTIaBRU/0
	 6/SoBfqvOM162A/2AqYXs8/qdxu2XxrJn+aVETqlyY3/zGL1UxT047W1O3sRcanu7H
	 RoSnhTf0JgZ0Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3D952C54BB3;
	Sat, 25 May 2024 17:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf,
 docs: Move sentence about returning R0 to abi.rst
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171665943324.11416.4855633319322642851.git-patchwork-notify@kernel.org>
Date: Sat, 25 May 2024 17:50:33 +0000
References: <20240517153445.3914-1-dthaler1968@gmail.com>
In-Reply-To: <20240517153445.3914-1-dthaler1968@gmail.com>
To: Dave Thaler <dthaler1968@googlemail.com>
Cc: bpf@vger.kernel.org, bpf@ietf.org, dthaler1968@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 17 May 2024 08:34:45 -0700 you wrote:
> As discussed at LSF/MM/BPF, the sentence about using R0 for returning
> values from calls is part of the calling convention and belongs in
> abi.rst.  Any further additions or clarifications to this text are left
> for future patches on abi.rst.  The current patch is simply to unblock
> progression of instruction-set.rst to a standard.
> 
> In contrast, the restriction of register numbers to the range 0-10
> is untouched, left in the instruction-set.rst definition of the
> src_reg and dst_reg fields.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf, docs: Move sentence about returning R0 to abi.rst
    https://git.kernel.org/bpf/bpf-next/c/4652072e7b9d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



