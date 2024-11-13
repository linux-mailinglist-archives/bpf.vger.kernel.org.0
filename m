Return-Path: <bpf+bounces-44703-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7051C9C6695
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 02:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2129D1F23B0C
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 01:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF2881ADA;
	Wed, 13 Nov 2024 01:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvb3bV44"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC90762EF;
	Wed, 13 Nov 2024 01:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731460821; cv=none; b=rh6nsYcWffaU8PDiXMJHXyo39RoBendHNQw1XNkcuUjxS8ucfKwllVCsSzNRusQfbdwFVdmZfVmbjt/eeSHL/CrYr4VRxBKo0d474oTwq9m3X1ldjkqxyK979RnkoJf0JE7r+ZdBUx+1le8znkaGUB5dKMv4X9/N3TIwWseHP+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731460821; c=relaxed/simple;
	bh=ckzoOOGoP1ftBLkv5EcJHIvh7Ox55OIL+k6bfhcGSSE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sPzaTx9DhLCp8QPFu24hgXXYAuuK09wNGTUPfxI6ejkYYCOEDc1x6vdM6j/VGaUbZfTR6TtyGeshKaNdb6TfhdYyu2bJQoKK9wd9q+7w7Hocw9DdrNx/4MYFn3r8F6P52ZRrq4N/Q/2rnnjyGRvXmvUU2/MBOqOPNPNVGXl+tlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hvb3bV44; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02B95C4CECD;
	Wed, 13 Nov 2024 01:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731460821;
	bh=ckzoOOGoP1ftBLkv5EcJHIvh7Ox55OIL+k6bfhcGSSE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hvb3bV44keb1ZQHtxGkqRPwIFOucQ3yHujeXJBcHHIxfAh3XFjLQmYeiskDUnAcvr
	 oDU5bED7Gj4a8zn1c3q1XSrfEtcrG4qxTfzKhPwRNPToLmcvvaAEuq68TD/zv4lty2
	 Evc7HK/bZJHXS+Q3xmyNfZO7pavlZ+11KVaoJs//iZGyFsB/7An5J3toqSQmHcSeg6
	 QRuhxc+hVItfgePEc2Xivu2LkOhjPV0SKRBJC6hFtqZIAnWQ2nmFt+wMbU5442t55K
	 Oi0zZ9Zb/4Y8EL8MxXMUSSt1YyRxVy+/PY6d7DvLf2ooU2/DqeP6tZN2xHV05d+Sii
	 vXyP6DRPPpFOA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710C83809A80;
	Wed, 13 Nov 2024 01:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/3] Add kernel symbol for struct_ops trampoline
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173146083125.741480.1473724826831955288.git-patchwork-notify@kernel.org>
Date: Wed, 13 Nov 2024 01:20:31 +0000
References: <20241112145849.3436772-1-xukuohai@huaweicloud.com>
In-Reply-To: <20241112145849.3436772-1-xukuohai@huaweicloud.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, yonghong.song@linux.dev, thinker.li@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 12 Nov 2024 22:58:46 +0800 you wrote:
> Add kernel symbol for struct_ops trampoline.
> 
> Without kernel symbol for struct_ops trampoline, the unwinder may
> produce unexpected stacktraces. For example, the x86 ORC and FP
> unwinder stops stacktrace on a struct_ops trampoline address since
> there is no kernel symbol for the address.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/3] bpf: Remove unused member rcu from bpf_struct_ops_map
    https://git.kernel.org/bpf/bpf-next/c/bd9d9b48eb18
  - [bpf-next,v4,2/3] bpf: Use function pointers count as struct_ops links count
    https://git.kernel.org/bpf/bpf-next/c/821a3fa32bbe
  - [bpf-next,v4,3/3] bpf: Add kernel symbol for struct_ops trampoline
    https://git.kernel.org/bpf/bpf-next/c/7c8ce4ffb684

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



