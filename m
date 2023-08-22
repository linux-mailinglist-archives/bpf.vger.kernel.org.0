Return-Path: <bpf+bounces-8316-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 637FC784D4A
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 01:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9471C1C20B95
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 23:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BD820EF2;
	Tue, 22 Aug 2023 23:20:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B795120EE0
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 23:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 22F5BC433C8;
	Tue, 22 Aug 2023 23:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692746423;
	bh=Jp/R5bM7feTSbJsWvncxf4LlSM/MdFEoyTlerPM3Tz0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nNXNYr9CCZM4gbYun5RcTE93UDFS+RmgwoquKKZmilK6t3905dFYQeIkJN7GNBj5t
	 R8cGEXwkxN2O6pNwy0H5ZN1hGTZd332vta1WxHKeGAKlM8NwXaOzQOzIZs28M43U4K
	 xn/UDwcbiCVdZz9iWGkaq5WL+ZfRulTQcRi9YkaC6gQQVGEKGX+GkTyGVbVu4hzgfE
	 N/woEcERRQVxd8168nhiXtoJsBRizZXVx28DvMvpQZe/3cLWv6/G5xFQV8yvj9SQr+
	 it88D9yu9M6sZIO+ZknqKM8KFOsWEmXOC0NImmdMoEd58eqKVzH62jA9Tf1iLte71v
	 Qr69JuJfXOGIw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0979EE21ED3;
	Tue, 22 Aug 2023 23:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: Free btf_vmlinux when closing bpf_object
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169274642302.20036.5459020650772319908.git-patchwork-notify@kernel.org>
Date: Tue, 22 Aug 2023 23:20:23 +0000
References: <20230822193840.1509809-1-haoluo@google.com>
In-Reply-To: <20230822193840.1509809-1-haoluo@google.com>
To: Hao Luo <haoluo@google.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, jolsa@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 22 Aug 2023 12:38:40 -0700 you wrote:
> I hit a memory leak when testing bpf_program__set_attach_target().
> Basically, set_attach_target() may allocate btf_vmlinux, for example,
> when setting attach target for bpf_iter programs. But btf_vmlinux
> is freed only in bpf_object_load(), which means if we only open
> bpf object but not load it, setting attach target may leak
> btf_vmlinux.
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: Free btf_vmlinux when closing bpf_object
    https://git.kernel.org/bpf/bpf-next/c/29d67fdebc42

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



