Return-Path: <bpf+bounces-46735-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D629EFCC4
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 20:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11D6C28A257
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 19:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D38E19E971;
	Thu, 12 Dec 2024 19:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aEz7gZ7J"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65731422D4
	for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 19:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734033017; cv=none; b=KIRjcoEasjE3apynjmf12E1XstpO6Oa2+gH/DilpXYFAo3+yDkIcwaqZjYv/1PUH+EdH8rRNoQw+zC3i8lKbwTRnfYnYoDqmXvHzr910Qz3uJhahnUqCnrenI0AwjoXTcLc402hGQ4sHb0O/2Jiq6EiSou7NkL9EDxnyF1m48+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734033017; c=relaxed/simple;
	bh=i8PcR05BpBIGDsjeIio5Rl0eBkGk/FzkJcotWNtNsCQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XfmwLkogdS3CVKfq2hPBzoPgfaX06tx4kwjxaRKu34FzJrc4QT5kNTXjUGVSO29BA86KWiNyFmDaqeg24O6ZErJq3/m+GkAMuQfYQg7MdWjEoGhhMgbDOiBRy7y6Try8vZ23OSpgfuQOouVwUhqg+bZzaYZIOprRBYjQ0G/o6Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aEz7gZ7J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7076DC4CED0;
	Thu, 12 Dec 2024 19:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734033016;
	bh=i8PcR05BpBIGDsjeIio5Rl0eBkGk/FzkJcotWNtNsCQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aEz7gZ7J8Dx2ebC9UzCDvfauKRQju8r55N1/a6jfMtFO26FMWskwYjwnexnif3e2J
	 +Ano83vjVTrnrR5psodCE6GDvNQnEpzLQPN4RlDRAnpMVE8KXdE6jKEndJ+J4KJSoJ
	 G0co7bNwVzJ+n4+eURi1s/k0HvSjuHmICRzGbhrOklnN06/yDUjY4I2dkfkAzW9mPl
	 GrQho0ySwxddT3JmsM5hNF1K+H4+Is58DctKbQQjQ9Ksh/6KJ+Sx2FGzRopxr1Y1+s
	 B+XGpMFydTIf4yltgzqQr06tLNZfNlJjo2naNlknw23/zhaYVzVnuQT6aLcS8Bbi1b
	 HJ2KYlDKMMs9Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id E011F380A959;
	Thu, 12 Dec 2024 19:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v1 0/2] Add missing size check for BTF-based ctx access
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173403303274.2422426.17572912895456567597.git-patchwork-notify@kernel.org>
Date: Thu, 12 Dec 2024 19:50:32 +0000
References: <20241212092050.3204165-1-memxor@gmail.com>
In-Reply-To: <20241212092050.3204165-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, kkd@meta.com, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com, rtm@mit.edu,
 kernel-team@fb.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 12 Dec 2024 01:20:48 -0800 you wrote:
> This set fixes a issue reported for tracing and struct ops programs
> using btf_ctx_access for ctx checks, where loading a pointer argument
> from the ctx doesn't enforce a BPF_DW access size check. The original
> report is at link [0]. Also add a regression test along with the fix.
> 
>   [0]: https://lore.kernel.org/bpf/51338.1732985814@localhost
> 
> [...]

Here is the summary with links:
  - [bpf,v1,1/2] bpf: Check size for BTF-based ctx access of pointer members
    https://git.kernel.org/bpf/bpf/c/659b9ba7cb2d
  - [bpf,v1,2/2] selftests/bpf: Add test for narrow ctx load for pointer args
    https://git.kernel.org/bpf/bpf/c/8025731c28be

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



