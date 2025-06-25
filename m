Return-Path: <bpf+bounces-61594-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 787D6AE90F4
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 00:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A4E0189D492
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 22:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36642F3659;
	Wed, 25 Jun 2025 22:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6H7c+b6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E55D1F419B
	for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 22:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750889995; cv=none; b=MxApMs+wEDkurpIXD0hdrDtx+a0p8H4P0sei8opcdOy/m3nPNFWL7oeawU5fVLxVeb0WHfExDzRCDkcnogqFM3Ni4xDArdihX8bJk6Ge33hXSmLlSVq23BSNKQsIg6rlGBqG8BqqGo5mF7GdZJXahiIJafYy/O58inRKyJy6on8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750889995; c=relaxed/simple;
	bh=5HzPFb6TAgAVY+ouIEYfVBtngHa9KAxsz6tZGYnyyJQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nlK0Iy9ZSEjY2yIAIXPYglwB9x1GLsG9DP5p3edc2lSP/hDi8NdrSwd44Vh8uKGPpQIh0+LNnUhZg2zw9RIt/mSAdoh/1k0I4vQJ2RzSevDZvoyEowN7DBP0+po0jxowfiwnuIx8cylp6+jy0Qmhsaw+LpIKpoG8zaW2/q++jmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6H7c+b6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBD48C4CEEE;
	Wed, 25 Jun 2025 22:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750889995;
	bh=5HzPFb6TAgAVY+ouIEYfVBtngHa9KAxsz6tZGYnyyJQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=U6H7c+b6/dG+atnVqZh0bBFtXWeTIUWG+JXM/LW+Jpsy6XrxNAkwZetiHUVlXtlmi
	 6dYcWM2wxRViw3mzHUudoaM3vpsvbIHu6RVpu3/5jAF7o6Xy0/Aoi1FLM6o9oGb1uV
	 Z9umxogobjPu0J+vtJvpP9A7zHv4DQHCq/MjNYyQHAiaaIBOmvJYzeaJBZ0RgUX7er
	 Vc1mO7apc8Vv1Sgrv35A9g7iUFa/o36H5sUFsD6z2ikszdVB/jKvOQd72HfIk92kON
	 NW1k+FdGriamVkiTB4K4oSxXXPqQsG/RDtTciDYVA3I15zD+N8JpIo3AHuSwr+rvfV
	 UiKW76oH1Q7ZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD4E3A40FCB;
	Wed, 25 Jun 2025 22:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/3] bpf: allow void* cast using
 bpf_rdonly_cast()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175089002123.639228.3538490380200270447.git-patchwork-notify@kernel.org>
Date: Wed, 25 Jun 2025 22:20:21 +0000
References: <20250625182414.30659-1-eddyz87@gmail.com>
In-Reply-To: <20250625182414.30659-1-eddyz87@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 25 Jun 2025 11:24:11 -0700 you wrote:
> Currently, pointers returned by `bpf_rdonly_cast()` have a type of
> "pointer to btf id", and only casts to structure types are allowed.
> Access to memory pointed to by these pointers is done through
> `BPF_PROBE_{MEM,MEMSX}` instructions and does not produce errors on
> invalid memory access.
> 
> This patch set extends `bpf_rdonly_cast()` to allow casts to an
> equivalent of 'void *', effectively replacing
> `bpf_probe_read_kernel()` calls in situations where access to
> individual bytes or integers is necessary.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/3] bpf: add bpf_features enum
    https://git.kernel.org/bpf/bpf-next/c/b23e97ffc252
  - [bpf-next,v3,2/3] bpf: allow void* cast using bpf_rdonly_cast()
    https://git.kernel.org/bpf/bpf-next/c/f2362a57aeff
  - [bpf-next,v3,3/3] selftests/bpf: check operations on untrusted ro pointers to mem
    https://git.kernel.org/bpf/bpf-next/c/12ed81f82391

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



