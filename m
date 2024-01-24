Return-Path: <bpf+bounces-20153-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D54839D82
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 01:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 974411F27073
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 00:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258E2627;
	Wed, 24 Jan 2024 00:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivC63uL0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04C6160
	for <bpf@vger.kernel.org>; Wed, 24 Jan 2024 00:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706055044; cv=none; b=lCsqi/qoXaKXunzCHtbd8OUaIwoZv5UN0PYf40KIFsZlExfecAcFSB1r3RHyvVUnQ+BXa2nsINtR7L9ka3a2w/VGiEXifZmldd5o7Nr+p0tKQns/6Mmth3DvpODLexWMynJn/KjOHJE1Hw6P1uyQ+SSzkowWdvLWrroc9qlwQDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706055044; c=relaxed/simple;
	bh=6wqW0LrITwWFdkHttpJkB2aMnok6DGhWo5iuS5eBfY0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qtroirr726TMKRS7XGQKBwh/RR4M7uCvDJikB6debbWoZs6yHmSi/sTJgyKLFuQSmz6GG1vU0I4tw/11LZneGtYCLWxL5T4I6os8mRlLuI4SQAi9WahhX+DdwjkCgB1K9u0aW/Fpgze2K1yAp4HSRe5LJCPNMmuUQyMZ54N2CuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivC63uL0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1923EC433F1;
	Wed, 24 Jan 2024 00:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706055044;
	bh=6wqW0LrITwWFdkHttpJkB2aMnok6DGhWo5iuS5eBfY0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ivC63uL0T9NAxe6fUI/E90K14kCQ+wHYB3zAdhcIc++t1XRZyXJjTIhbOKVxbJQOI
	 AHriTfcssjQKuk0t2QRy/JrWNdZSYmxunkux+HhDKYYbi5XbUgFCHwiPdUfca8fJCX
	 gSeHH8zCtAK4GkKyhfzT6vGPvXU24zLqzm36jedAlu/BQ8KD73pRU6h1vFj9suBLwK
	 FZmiFYLsY5clUiqP/UC1bKrEIZbWJROUYxJiRNqK8JsGrpzJPYgTSrV0xfzjfYIrY4
	 KhS5k+hGLBGAr4NgW9FW+iNuw9/CtQlTFGN6jxkgh0ZaKNKxgvqsqbBi8x2191VyLN
	 5t7jL+sKWg1mw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 00915DFF767;
	Wed, 24 Jan 2024 00:10:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2 bpf-next 0/8] bpf: Add cookies retrieval for perf/kprobe
 multi links
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170605504399.8359.3993234259054241947.git-patchwork-notify@kernel.org>
Date: Wed, 24 Jan 2024 00:10:43 +0000
References: <20240119110505.400573-1-jolsa@kernel.org>
In-Reply-To: <20240119110505.400573-1-jolsa@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@chromium.org, sdf@google.com,
 haoluo@google.com, laoar.shao@gmail.com, quentin@isovalent.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 19 Jan 2024 12:04:57 +0100 you wrote:
> hi,
> this patchset adds support to retrieve cookies from existing tracing
> links that still did not support it plus changes to bpftool to display
> them. It's leftover we discussed some time ago [1].
> 
> thanks,
> jirka
> 
> [...]

Here is the summary with links:
  - [PATCHv2,bpf-next,1/8] bpf: Add cookie to perf_event bpf_link_info records
    https://git.kernel.org/bpf/bpf-next/c/d5c16492c66f
  - [PATCHv2,bpf-next,2/8] bpf: Store cookies in kprobe_multi bpf_link_info data
    https://git.kernel.org/bpf/bpf-next/c/9fd112b1f82b
  - [PATCHv2,bpf-next,3/8] bpftool: Fix wrong free call in do_show_link
    https://git.kernel.org/bpf/bpf-next/c/2adb2e0fcdf3
  - [PATCHv2,bpf-next,4/8] selftests/bpf: Add cookies check for kprobe_multi fill_link_info test
    https://git.kernel.org/bpf/bpf-next/c/59a89706c40c
  - [PATCHv2,bpf-next,5/8] selftests/bpf: Add cookies check for perf_event fill_link_info test
    https://git.kernel.org/bpf/bpf-next/c/d74179708473
  - [PATCHv2,bpf-next,6/8] selftests/bpf: Add fill_link_info test for perf event
    https://git.kernel.org/bpf/bpf-next/c/b7896486688a
  - [PATCHv2,bpf-next,7/8] bpftool: Display cookie for perf event link probes
    https://git.kernel.org/bpf/bpf-next/c/54258324b934
  - [PATCHv2,bpf-next,8/8] bpftool: Display cookie for kprobe multi link
    https://git.kernel.org/bpf/bpf-next/c/b0dc037399b1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



