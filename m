Return-Path: <bpf+bounces-52140-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E0BA3EADF
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 03:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6405519C5CBF
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 02:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5E41D54D8;
	Fri, 21 Feb 2025 02:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NercvORM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDB833EA
	for <bpf@vger.kernel.org>; Fri, 21 Feb 2025 02:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740106207; cv=none; b=dnVPgF+Di3drWkpFtU0jjdtRdkB1emrQcISyRi5BFzFhB9iPcZwhwjMej9G9QGpok7WuN2AYtYgAhVReA3oEGVyfK27lf3OvlYh3lwYCZCOWb5g3sPwbf1UmsA0kTqP375tk5JCtUoynFD7iT8fqbXz/VwT51POw3SlCEwkaH7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740106207; c=relaxed/simple;
	bh=XT8+xhKfD4jAExWKNYnB9StmJDq0EmHCgtk8x3sM8eA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=laaHkrmI6amNmQymKrPQnD1vdu3yHh/HVtf/vcKOOQrt5LolU6vvqTqaxldjLR+btyVdwgHAO3alYKO1JP6iacf/r3dl4Ew8SsFD9k4Ufd7gD3F40lW+z/6L7FuDIEftx2bFJEwTYNpqO97Ek5qm5b4kE1txRQqXIOGcMd8gOmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NercvORM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66DD7C4CED1;
	Fri, 21 Feb 2025 02:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740106206;
	bh=XT8+xhKfD4jAExWKNYnB9StmJDq0EmHCgtk8x3sM8eA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NercvORMuejlPw5DZcMR4Jq0LcNIKLw6Iw4+fga1PIZ2DpUZOFbkmxnoRAv/z5jIR
	 L73JFutX1PFLk1ZVvTNVWgMGLeAsImmWZZjqW0bzKiWwWNZmlNyXOdz9gGlBTDpDfU
	 scoGoR9baHLaisQiLGwFR1nJqRsbLvBOyjfe/yA9xnSpMxPme/BlqL494OJBxnF9a3
	 RJrDXGjyaIjZ3EpZUbFFqQ6Eqi4DucvqbqH8RErkutZcEDhWN59y5ITWL3WYRNP1ef
	 6PFSNReFWA/WCZIjaC4j4iE80EsyGggTQgxhrHPCJ8z4ctoOpLuzBzOeLOzPrdSYTC
	 mupbY7b+5NmDg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C6F3806641;
	Fri, 21 Feb 2025 02:50:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: fix hypothetical STT_SECTION extern NULL
 deref case
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174010623724.1561130.4152072107672496366.git-patchwork-notify@kernel.org>
Date: Fri, 21 Feb 2025 02:50:37 +0000
References: <20250220002821.834400-1-andrii@kernel.org>
In-Reply-To: <20250220002821.834400-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 19 Feb 2025 16:28:21 -0800 you wrote:
> Fix theoretical NULL dereference in linker when resolving *extern*
> STT_SECTION symbol against not-yet-existing ELF section. Not sure if
> it's possible in practice for valid ELF object files (this would require
> embedded assembly manipulations, at which point BTF will be missing),
> but fix the s/dst_sym/dst_sec/ typo guarding this condition anyways.
> 
> Fixes: faf6ed321cf6 ("libbpf: Add BPF static linker APIs")
> Fixes: a46349227cd8 ("libbpf: Add linker extern resolution support for functions and global variables")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: fix hypothetical STT_SECTION extern NULL deref case
    https://git.kernel.org/bpf/bpf-next/c/e0525cd72b59

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



