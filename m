Return-Path: <bpf+bounces-50584-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2E8A29E23
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 02:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3747B1888D69
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 01:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5948F433CB;
	Thu,  6 Feb 2025 01:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uc/+9+Zg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08FE3B192;
	Thu,  6 Feb 2025 01:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738803608; cv=none; b=n5vE93s2LjI+Q7n91Dz2JFixUOaXQ2bt29AW0708LBZA5JzCgQ6yACwt7k0SkOD8f3Ea+Y//5DiE9790OljmnJEg4dPqxgmUGEof1TJv4v4EoXswtXYNGjnNYL6e2xT4g6FV6BJlVaEsKxmM7k2XQsFCOzaF+/MYH3HGodBMgQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738803608; c=relaxed/simple;
	bh=JTV6l5lgez3qzu1s8JPV2AKKaABFFkEVLRwzj6agjKk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DKcGIY7Bm1uc8Shr2nrN4PGmK/V3EiWe8uQ9JgC9NqXQdOIReJ8SOHAsfnYwY091zmAL0i30BOvRdFXdM8WPKLWY/oeZGqj289Pzx+1gRsPYieIaQ9B9SwmIcki4I+mcWrQHLq9vjUyK69wWoZnXE4sT0Xj5EoiFpGHFDHkXehI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uc/+9+Zg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BB8CC4AF09;
	Thu,  6 Feb 2025 01:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738803608;
	bh=JTV6l5lgez3qzu1s8JPV2AKKaABFFkEVLRwzj6agjKk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Uc/+9+ZgTDejQ7URCCA6NsEjG0mZhT+4HRKfz5A3zr+jPFNCORTc7tX1c3bwddHuP
	 cL+igT3197COM6hLFjNbhNLybsiDAfxxIn+IMzwlPwrUuahAVqJbfRqc+0h1cFUXgD
	 KCYSRvccJuqIDAINWVWFe+1akSGlID0gyPeMaJcAEUYBDGWr3uxmdPTZKw1sMHYbM4
	 NVmHmGMNznbEs0yAvFEwyBCrkHQA6TMR2mmoffyam0EceTNBn3Ciqd5Z3oUUX3cChz
	 tN0rIOJPsmPOxjKqZyydm2T9R/aMxE2qE4LMaMnLTyaZDhSxPGQJGLPQQ9YoWqTpJV
	 ZJ1d7e2TnJWZg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF9E380AAD0;
	Thu,  6 Feb 2025 01:00:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/3] Makefile fixes for samples/{bpf,hid}
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173880363576.959069.2235034336278672667.git-patchwork-notify@kernel.org>
Date: Thu, 06 Feb 2025 01:00:35 +0000
References: <20250203085506.220297-1-jinghao7@illinois.edu>
In-Reply-To: <20250203085506.220297-1-jinghao7@illinois.edu>
To: Jinghao Jia <jinghao7@illinois.edu>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, jikos@kernel.org,
 bentiss@kernel.org, masahiroy@kernel.org, n.schier@avm.de, ruqin@redhat.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon,  3 Feb 2025 02:55:03 -0600 you wrote:
> Hi everyone,
> 
> Following commit 13b25489b6f8 ("kbuild: change working directory to
> external module directory with M="), the Makefiles for both bpf and hid
> samples are broken due to the use of the relative vmlinux path (i.e.,
> ./vmlinux) when generating vmlinux.h. Additionally, samples/hid experience
> the same problem that was fixed for samples/bpf in commit 5a6ea7022ff4
> ("samples/bpf: Remove unnecessary -I flags from libbpf EXTRA_CFLAGS").
> 
> [...]

Here is the summary with links:
  - [v3,1/3] samples/hid: remove unnecessary -I flags from libbpf EXTRA_CFLAGS
    (no matching commit)
  - [v3,2/3] samples/bpf: fix broken vmlinux path for VMLINUX_BTF
    https://git.kernel.org/bpf/bpf-next/c/94f53edc64e1
  - [v3,3/3] samples/hid: fix broken vmlinux path for VMLINUX_BTF
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



