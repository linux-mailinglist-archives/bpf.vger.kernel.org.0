Return-Path: <bpf+bounces-78789-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2322AD1BD1F
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 01:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CEA7A302F922
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 00:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F3B1EFF80;
	Wed, 14 Jan 2026 00:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LikvBXjM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9A41E1DEC;
	Wed, 14 Jan 2026 00:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768350825; cv=none; b=fqCrKIuX0eOdua5iq08IKZqJG0E8Q0ato8VlRjwh7eDyH111KKuJ1uk7xmiPdHGMIrjDNfeImhCCwq3fT7ZrH6fF9pWuEaYI/ig+0v851mgLm6vRGnjA6xpwjJ8c4+GD7wQL/D/B4+nSTMqldm4EbRMIDI9JVqvJlJ5fYFDggkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768350825; c=relaxed/simple;
	bh=VmhcC0cfWEco29a7wMuTl2Z5T6iNMuwXajlAEo+SkTg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KKHNCOsggaNP4umA5oqI1FXu992o7I0LtGjlchrSDfF8/lMjeja3vT6rrr9PF/sCIMHvl2CLTgAbMZnlHONb0jAHTHbYyxjCjScTI97H8RVVvEtYb0vq6XNi2/Caxotvy3AKkYVw7rT8Zij3uyQXf/qFhOggy/ZaUhh4eJXuALg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LikvBXjM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 156C7C116C6;
	Wed, 14 Jan 2026 00:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768350825;
	bh=VmhcC0cfWEco29a7wMuTl2Z5T6iNMuwXajlAEo+SkTg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LikvBXjMm3tyvMiUFwdJdsC4kZ88Cta0REpxb4xN5uCYjGS6h10hvq33fBrNifRYY
	 QO6DI7tr9apDN9Lu5BR56GWgQ0/fS7Y6i11Ngruxv5Zk/YqHr27L8x4unwurG7pV9H
	 AakN9vjGAiJ5RZKWoVHCKM35ZJw/qGHB/2C3aYL27ZO1hHz1Pq6mQaBKhUx68PpCRZ
	 2VrLh5B7nqit8ST1Sip1H/4h5lWhcVjW+gDUclqedVwEZrC5Lnd6SKBzBVeNe4o5Y+
	 WY3s8WoZWWq0/+ohc2mPntQAETlsT1ondCEqsjuG5XWDESii7ISrdVIRC+b1AIUyOh
	 Vy8duxxlwL2sQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78A213808200;
	Wed, 14 Jan 2026 00:30:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v12 00/11] Improve the performance of BTF type
 lookups with binary search
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176835061836.2531731.15663176561531446569.git-patchwork-notify@kernel.org>
Date: Wed, 14 Jan 2026 00:30:18 +0000
References: <20260109130003.3313716-1-dolinux.peng@gmail.com>
In-Reply-To: <20260109130003.3313716-1-dolinux.peng@gmail.com>
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: ast@kernel.org, andrii.nakryiko@gmail.com, eddyz87@gmail.com,
 zhangxiaoqin@xiaomi.com, ihor.solodrai@linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, pengdonglin@xiaomi.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri,  9 Jan 2026 20:59:52 +0800 you wrote:
> From: Donglin Peng <pengdonglin@xiaomi.com>
> 
> The series addresses the performance limitations of linear search in large
> BTFs by:
> 1. Adding BTF permutation support
> 2. Using resolve_btfids to sort BTF during the build phase
> 3. Checking BTF sorting
> 4. Using binary search when looking up types
> 
> [...]

Here is the summary with links:
  - [bpf-next,v12,01/11] libbpf: Add BTF permutation support for type reordering
    https://git.kernel.org/bpf/bpf-next/c/6fbf129c4990
  - [bpf-next,v12,02/11] selftests/bpf: Add test cases for btf__permute functionality
    https://git.kernel.org/bpf/bpf-next/c/a3acd7d43462
  - [bpf-next,v12,03/11] tools/resolve_btfids: Support BTF sorting feature
    https://git.kernel.org/bpf/bpf-next/c/230e7d7de5a8
  - [bpf-next,v12,04/11] libbpf: Optimize type lookup with binary search for sorted BTF
    (no matching commit)
  - [bpf-next,v12,05/11] libbpf: Verify BTF sorting
    https://git.kernel.org/bpf/bpf-next/c/33ecca574f1c
  - [bpf-next,v12,06/11] btf: Optimize type lookup with binary search
    (no matching commit)
  - [bpf-next,v12,07/11] btf: Verify BTF sorting
    (no matching commit)
  - [bpf-next,v12,08/11] bpf: Skip anonymous types in type lookup for performance
    https://git.kernel.org/bpf/bpf-next/c/dc893cfa390a
  - [bpf-next,v12,09/11] bpf: Optimize the performance of find_bpffs_btf_enums
    https://git.kernel.org/bpf/bpf-next/c/434bcbc837a6
  - [bpf-next,v12,10/11] libbpf: Optimize the performance of determine_ptr_size
    (no matching commit)
  - [bpf-next,v12,11/11] btf: Refactor the code by calling str_is_empty
    https://git.kernel.org/bpf/bpf-next/c/9282a42a1fe1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



