Return-Path: <bpf+bounces-28378-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 439EB8B8EAA
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 19:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 442231C20D3C
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 17:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FF1134BD;
	Wed,  1 May 2024 17:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRryIEcC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D224B8BE5
	for <bpf@vger.kernel.org>; Wed,  1 May 2024 17:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714582832; cv=none; b=ZhXO8zE2Orv1f8prN9Y6z4/cf9ctPD/QW6vryyF7MBJQAwCHr4Fjhot3V+2c7ZocpE7R4L/m4oDrL5chXGNee87YWAaKAN1r23bcEuHKap3EZ4MKYFurS8SnrVFdBKoDseecO312zan2cF1goZiOpNhFYUKD8YqmrwAKClUQkjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714582832; c=relaxed/simple;
	bh=V9N7Y/kddvv+g80sYyesbK1XK8zadXvuF0VGziWLpi4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Jo0a+JBhQUVerLsLi81HnZoqhCxNsLjKAZVlzjKShTP/c7ehfn7CP/+h4jp/rEBTVMXM49LYwj2heSJ2qHuCkvyUhZFW8EpOa0IW+ddjiyS1TTc1Pn9eR6nwY733ACrVlnPYAKLjd6KqguUG/58z60QOp7JcwCTCT4sOCLiMOc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRryIEcC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 40E88C4AF14;
	Wed,  1 May 2024 17:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714582832;
	bh=V9N7Y/kddvv+g80sYyesbK1XK8zadXvuF0VGziWLpi4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gRryIEcCZslBHvrrnsC2PyCcXwUyxPP3VNWFxMJln7/7I7QhVR6cVplqOFdARTGOC
	 YUgVSRpvCI9/3f8042P3dqDfI7DojAziq+mnx+eoCaSUas97kNDxzLVxTosvS9w938
	 QKg3T3GuOaVlz2Ixy1oHstyvEpI2B1WF4Pt2Q/FiVI6StoBwyj3sC+OTbatiC2azNT
	 oSBUjOjw5zESxq6o8EzFKsPF4Li8C0aLUOudcvlS4Tj60e/F3SPnW/cdg5+2dXhexg
	 55lS7q8Q9j2EajRPXpkcghPQbsBngF5l0xad7DpJoi5n1E4dz6cvq/c2aLcO/+4K7o
	 gf9b4i6Cc9C+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 29690C43440;
	Wed,  1 May 2024 17:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/2] libbpf: support "module:function" syntax for
 tracing programs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171458283216.4721.15658966910162414185.git-patchwork-notify@kernel.org>
Date: Wed, 01 May 2024 17:00:32 +0000
References: <cover.1714469650.git.vmalik@redhat.com>
In-Reply-To: <cover.1714469650.git.vmalik@redhat.com>
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 30 Apr 2024 11:38:05 +0200 you wrote:
> In some situations, it is useful to explicitly specify a kernel module
> to search for a tracing program target (e.g. when a function of the same
> name exists in multiple modules or in vmlinux).
> 
> This change enables that by allowing the "module:function" syntax for
> the find_kernel_btf_id function. Thanks to this, the syntax can be used
> both from a SEC macro (i.e. `SEC(fentry/module:function)`) and via the
> bpf_program__set_attach_target API call.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] libbpf: support "module:function" syntax for tracing programs
    https://git.kernel.org/bpf/bpf-next/c/8f8a024272f3
  - [bpf-next,v2,2/2] selftests/bpf: add tests for the "module:function" syntax
    https://git.kernel.org/bpf/bpf-next/c/960635887c96

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



