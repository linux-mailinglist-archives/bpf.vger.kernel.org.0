Return-Path: <bpf+bounces-28214-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 114678B666F
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 01:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D332B2338A
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 23:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451CE194C90;
	Mon, 29 Apr 2024 23:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RuTE298J"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE11194C6B;
	Mon, 29 Apr 2024 23:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714434029; cv=none; b=UTi5wWEzeNEuTNPuyd/3NiZ7RbUbDwMBAg7k7KwiMH/6OOqMpqVP0JCaaUpG2JJkH3BkO+7uW7p61XK9wmERXxeITuwTdlFbK8p0U7xMiDtToWqrg9VFM25b70624xZp9AT9mFHKB1F3S09GmkQ6Nml00DbW6Q890yossveRStc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714434029; c=relaxed/simple;
	bh=gUPva0KZ1bj3hcLSMjpCy0JRDgsPk6D22JAPPqxw/yQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=d/0EqvKOlROyvqa3GwdxFHuDrOJq8KtZ4TQfM4ffMcl6bNlFVCWvPIf+nBlzb/LPLkbHCjedHMqu58vCQ/Yr1STbHJfNJXFarktnB7SCAAd90o43SfwthyACP0t3hP5tUGxwfnrgPM6md5Sof42y+1lxenZ1LN62J1Ov9Opuygs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RuTE298J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36343C4AF18;
	Mon, 29 Apr 2024 23:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714434029;
	bh=gUPva0KZ1bj3hcLSMjpCy0JRDgsPk6D22JAPPqxw/yQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RuTE298J8ZpvWmruPnUBzwgK5qlJa5tJK1sMMEWFZtpYmvb39XGycPdcwWtkSw1sW
	 a/KXlMdjqvS3PrvXTYu7pgGg33F6x8CF6L/HNnSh4RXCITmqbidbhz7k7PFhNdYqK8
	 eYhH/M22SootWteMovGEIL0o0eoI2DvxtTFCsN0dvne0tozJ2sAKdmSquS1UtSIfvM
	 MNr/oI8E6HiBM03A/1jMk/FO6YpRvBsUZ+LoG8/cmALhl5Tp21x/oXvDS1o+TO6eWa
	 EAnqOu5OLDeBrXrAD95FOi6J0YMptx7pOpSzRCsnNPI1TtjGiImV3qnChsH7xvcJHN
	 gf31xGqrb+0AQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 23D9BE2D48A;
	Mon, 29 Apr 2024 23:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] bpf: btf: include linux/types.h for u32
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171443402914.12141.3176528838601718128.git-patchwork-notify@kernel.org>
Date: Mon, 29 Apr 2024 23:40:29 +0000
References: <20240420042457.3198883-1-dmitrii.bundin.a@gmail.com>
In-Reply-To: <20240420042457.3198883-1-dmitrii.bundin.a@gmail.com>
To: Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
Cc: olsajiri@gmail.com, andrii@kernel.org, ast@kernel.org,
 bpf@vger.kernel.org, daniel@iogearbox.net, dxu@dxuuu.xyz, eddyz87@gmail.com,
 haoluo@google.com, john.fastabend@gmail.com, khazhy@chromium.org,
 kpsingh@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev,
 ncopa@alpinelinux.org, ndesaulniers@google.com, sdf@google.com,
 song@kernel.org, vmalik@redhat.com, yonghong.song@linux.dev

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Sat, 20 Apr 2024 07:24:57 +0300 you wrote:
> Inclusion of the header linux/btf_ids.h relies on indirect inclusion of
> the header linux/types.h. Including it directly on the top level helps
> to avoid potential problems if linux/types.h hasn't been included
> before.
> 
> The main motiviation to introduce this it is to avoid similar problems that
> was shown up in the bpf tool where GNU libc indirectly pulls
> linux/types.h causing compile error of the form:
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] bpf: btf: include linux/types.h for u32
    https://git.kernel.org/bpf/bpf-next/c/cfd3bfe9507b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



