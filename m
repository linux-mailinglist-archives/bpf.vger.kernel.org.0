Return-Path: <bpf+bounces-58627-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C7FABE809
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 01:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B28CC1BA62BA
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 23:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9FE25E810;
	Tue, 20 May 2025 23:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sKRKXhW9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71E3244690
	for <bpf@vger.kernel.org>; Tue, 20 May 2025 23:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747783798; cv=none; b=Xnlny0Gr9oBSxI1RzHYgUcw2Fe0j46OaBB4QTaP9rdVlU2e5s+94nfk9B0PVxmmdRJovuwvDz7Jsh27BWCL+XvYFdfz2B7ky4Hssrino0e+2E4oKlvhUZUy24FsGP1oIoObssznXzS9rOZT+xncxBdZ4GIX2/7a1I42DN0+Ktpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747783798; c=relaxed/simple;
	bh=JiS8d3/w9Zk5LH1mgy163XDPql2cY0Hhg+8tNmCE+1s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=K0iI14MCbojCjtV61rZyCUgH2D0AxB7j71a2fcIZ0ONkoxWMUfns+WxYaa+ZMFQfhuB3WjqLzbAvWV9T+C4uhff0K/VoK87BTiEUaZBdWZP9iMYvrmmkQ+mEG94SkN1HrayNIfW+UlUR3zppVwXvgx3czxhR2ZdLxAlpHMeV3Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sKRKXhW9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A4EFC4CEE9;
	Tue, 20 May 2025 23:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747783796;
	bh=JiS8d3/w9Zk5LH1mgy163XDPql2cY0Hhg+8tNmCE+1s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sKRKXhW9H2fGYKS6QVWPnOunZy7fRNUzdOtUR+Kh+jGjVIVjlaV5rf4kYQhA5Bl3W
	 STP3zNnKFj02iBpT9sL2yVrE+IY3OzVfERQW8IpD0nWilxQubMqFm5GQjteDSZNAaF
	 MUkbju9c8D4d3NADyOZhseAJpQjGTdV6VWb6vOP4RKZvYfa8xZSUbX81Mep3oMElD9
	 PPLKZSHbBeD+MxCxY4wmJBh832B6tAOQisHfhROB4QnmG1Y9xBv11H0E33BjudQSOa
	 DjlRgm2xvJdWMDrXCvgi/d1y7WtppDJ/DMKgS9Q4i8J1JB34oTwfjZqL+ACtE+GPHg
	 2A1lK9EpVZaIw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E82380AA70;
	Tue, 20 May 2025 23:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/2] libbpf: support multi-split BTF
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174778383225.1500689.4315334125352141767.git-patchwork-notify@kernel.org>
Date: Tue, 20 May 2025 23:30:32 +0000
References: <20250519165935.261614-1-alan.maguire@oracle.com>
In-Reply-To: <20250519165935.261614-1-alan.maguire@oracle.com>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, ast@kernel.org, ttreyer@meta.com, daniel@iogearbox.net,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 19 May 2025 17:59:33 +0100 you wrote:
> In discussing handling of inlines in BTF [1], one area which we may need
> support for in the future is multiple split BTF, where split BTF sits
> atop another split BTF which sits atop base BTF.  This two-patch series
> fixes one issue discovered when testing multi-split BTF and extends the
> split BTF test to cover multi-split BTF also.
> 
> [1] https://lore.kernel.org/dwarves/20250416-btf_inline-v1-0-e4bd2f8adae5@meta.com/
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] libbpf/btf: Fix string handling to support multi-split BTF
    https://git.kernel.org/bpf/bpf-next/c/4e29128a9ace
  - [bpf-next,2/2] selftests/bpf: Test multi-split BTF
    https://git.kernel.org/bpf/bpf-next/c/02f5e7c1f3ea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



