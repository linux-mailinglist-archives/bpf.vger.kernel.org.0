Return-Path: <bpf+bounces-32351-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 188EE90BD35
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 00:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B612D1F222DD
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 22:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DE318FC80;
	Mon, 17 Jun 2024 22:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FdHoumG5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A82C7492
	for <bpf@vger.kernel.org>; Mon, 17 Jun 2024 22:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718661632; cv=none; b=gyxq8gJ0Il8AGMopEy2QptWCOSFFKfUmKGdBqSZqGg/bRRR79KJ7HMvzCuPw9m/NH74INDUUz3uhSlSZSzXEOPlISCwbNk53SP6JLBjJe4JeYD2HHPHovba22Rg1M+ecvggA3yr+6MdFjWe4BV+R6y4KE6hG4POsrKhsy8h+8QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718661632; c=relaxed/simple;
	bh=nS+kOL2lF4Njo2C3uqTZ36Xyrpf9ebX3cfPMHGdqJU4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=H2ETXzyZ3YewRaLNVdbZXxRm+b8mwbAVmowA8X69Xw1zRzr6EzNeCPek2n0mlXAozOo8LmVjmrW5oeboGWBXEC2+OggIi6MIlIQ0IFIpzwTL6wJCuACv//oNtuXS3PSTwYbQl8gxtc9voETM6EQhZ6eAW2pvHwAHcUHNE1y8oVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FdHoumG5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8AE8DC4AF1A;
	Mon, 17 Jun 2024 22:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718661631;
	bh=nS+kOL2lF4Njo2C3uqTZ36Xyrpf9ebX3cfPMHGdqJU4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FdHoumG5uesWaVLOAq0RaUdlM93rShkmslaXc6XjXr2I7HJEw+6nS6PHFQm4PvMbn
	 rmPv4MM/qKI+WN5EyKcRm8BrrN0paP6SVTQkm9dp9mmJtBxkbyOa3myYKyzLdlwInT
	 vxCdmRNp98yI8LarA+x66xE8z/VuGM+w0yFUWORYJWRFnH+jTeQq7R3XqM52Fod6ZS
	 km8mbppK7H4xeHl2rX0+QTxjk5gps/5QCvB0ii5E9yEINfyZ81xcv9GJJ3a1qgaX9r
	 sZVOtD4Y9veIfupkr8mMi5Tk6B/n1BU+xLbELOYTPEauiGrrAw/86AJp77h9hQQi0i
	 byESEjj05ErTg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6DCA9D2D0F8;
	Mon, 17 Jun 2024 22:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 bpf-next 0/9] bpf: support resilient split BTF
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171866163144.18503.8187989801903069674.git-patchwork-notify@kernel.org>
Date: Mon, 17 Jun 2024 22:00:31 +0000
References: <20240613095014.357981-1-alan.maguire@oracle.com>
In-Reply-To: <20240613095014.357981-1-alan.maguire@oracle.com>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, mcgrof@kernel.org,
 masahiroy@kernel.org, nathan@kernel.org, mykolal@fb.com, dxu@dxuuu.xyz,
 bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 13 Jun 2024 10:50:05 +0100 you wrote:
> Split BPF Type Format (BTF) provides huge advantages in that kernel
> modules only have to provide type information for types that they do not
> share with the core kernel; for core kernel types, split BTF refers to
> core kernel BTF type ids.  So for a STRUCT sk_buff, a module that
> uses that structure (or a pointer to it) simply needs to refer to the
> core kernel type id, saving the need to define the structure and its many
> dependents.  This cuts down on duplication and makes BTF as compact
> as possible.
> 
> [...]

Here is the summary with links:
  - [v6,bpf-next,1/9] libbpf: add btf__distill_base() creating split BTF with distilled base BTF
    https://git.kernel.org/bpf/bpf-next/c/58e185a0dc35
  - [v6,bpf-next,2/9] selftests/bpf: test distilled base, split BTF generation
    https://git.kernel.org/bpf/bpf-next/c/eb20e727c434
  - [v6,bpf-next,3/9] libbpf: split BTF relocation
    https://git.kernel.org/bpf/bpf-next/c/19e00c897d50
  - [v6,bpf-next,4/9] selftests/bpf: extend distilled BTF tests to cover BTF relocation
    https://git.kernel.org/bpf/bpf-next/c/affdeb50616b
  - [v6,bpf-next,5/9] libbpf: make btf_parse_elf process .BTF.base transparently
    https://git.kernel.org/bpf/bpf-next/c/c86f180ffc99
  - [v6,bpf-next,6/9] resolve_btfids: handle presence of .BTF.base section
    https://git.kernel.org/bpf/bpf-next/c/6ba77385f386
  - [v6,bpf-next,7/9] module, bpf: store BTF base pointer in struct module
    (no matching commit)
  - [v6,bpf-next,8/9] libbpf,bpf: share BTF relocate-related code with kernel
    (no matching commit)
  - [v6,bpf-next,9/9] kbuild,bpf: add module-specific pahole flags for distilled base BTF
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



