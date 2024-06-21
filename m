Return-Path: <bpf+bounces-32777-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFA0913013
	for <lists+bpf@lfdr.de>; Sat, 22 Jun 2024 00:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7494A286F8A
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 22:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E2417A93C;
	Fri, 21 Jun 2024 22:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rwAOzWHz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A9F38FB9
	for <bpf@vger.kernel.org>; Fri, 21 Jun 2024 22:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719007832; cv=none; b=hCrj8fMi+ObLPVyBP3Idy3vgaqXvQf+LVPmNgIFHAex7rJWL5iRFyr56mz/XCFZ8JMQg97pelItTzlhYFkWwC1kepHkOldDGyLYK34S0DHjnmeqK3riRtaI0rfH8HZi+Yy7ztngVj/dz7OidA7JhJxeVYLjrOtV2dU3Bh+7VNkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719007832; c=relaxed/simple;
	bh=gXy1wKqfHgjMmpv0mM0NZsuLvzwrNUUDJv5VirMu6kA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YZHrwPYmZ9XCe7uDINDEhkVgO0r5i64K5tv/5okYUEJbGb9whA/0e4GzGx5G2QJaXTzdh7y9+23agTYNFGRD6YZVfxKZDLB2A5VCdkxp9dWXu1KKDu8dqmaX4Yhf52pIYE3LcbUka/BP9Y/QgvvzScnJBskJrJ7+cl5h2kewZwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rwAOzWHz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 87E83C4AF07;
	Fri, 21 Jun 2024 22:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719007831;
	bh=gXy1wKqfHgjMmpv0mM0NZsuLvzwrNUUDJv5VirMu6kA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rwAOzWHz45hlFnli1SvVa+YxxtuBbJ5s4FyEFuAKyQrsgCJfoSWSwNs1dpp8Xt3v1
	 B6V8mtkH3g7LugYBQblvDkBh2ZIaawPuSElcJZSWVJCkEKP+OEjY+XvwlvotdhPxre
	 iwMt98ybe4oUi7I+R9oTQjSyRXwJYccjBWYJJXgBD5lICu8b9qgjXhnqasvnvm8h/L
	 3pspzyEqmiwIerkx/bCwp3KY5c8NVJJ4rDRNkXKVQVZT/LdzvjrxVY6zkgbuzeN6Wm
	 DbLNS27ASJYYkRXcrykwQTVnj6y7XDJ0gXJsh+dXUfoTWq4Ga8Fd4xz/5X2eFwQktb
	 pcaV7prAwTs4Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 72D6FCF3B95;
	Fri, 21 Jun 2024 22:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 0/6] bpf: resilient split BTF followups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171900783146.8103.14964230406713262563.git-patchwork-notify@kernel.org>
Date: Fri, 21 Jun 2024 22:10:31 +0000
References: <20240620091733.1967885-1-alan.maguire@oracle.com>
In-Reply-To: <20240620091733.1967885-1-alan.maguire@oracle.com>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, acme@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, jolsa@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, mcgrof@kernel.org,
 masahiroy@kernel.org, nathan@kernel.org, mykolal@fb.com,
 thinker.li@gmail.com, bentiss@kernel.org, tanggeliang@kylinos.cn,
 bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 20 Jun 2024 10:17:27 +0100 you wrote:
> Follow-up to resilient split BTF series [1],
> 
> - cleaning up libbpf relocation code (patch 1);
> - adding 'struct module' support for base BTF data (patch 2);
> - splitting out field iteration code into separate file (patch 3);
> - sharing libbpf relocation code with the kernel (patch 4);
> - adding a kbuild --btf_features flag to generate distilled base
>   BTF in the module-specific case where KBUILD_EXTMOD is true
>   (patch 5); and
> - adding test coverage for module-based kfunc dtor (patch 6)
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/6] libbpf: BTF relocation followup fixing naming, loop logic
    https://git.kernel.org/bpf/bpf-next/c/d1cf840854bb
  - [v2,bpf-next,2/6] module, bpf: store BTF base pointer in struct module
    https://git.kernel.org/bpf/bpf-next/c/d4e48e3dd450
  - [v2,bpf-next,3/6] libbpf: split field iter code into its own file kernel
    https://git.kernel.org/bpf/bpf-next/c/e7ac331b3055
  - [v2,bpf-next,4/6] libbpf,bpf: share BTF relocate-related code with kernel
    https://git.kernel.org/bpf/bpf-next/c/8646db238997
  - [v2,bpf-next,5/6] kbuild,bpf: add module-specific pahole flags for distilled base BTF
    https://git.kernel.org/bpf/bpf-next/c/46fb0b62ea29
  - [v2,bpf-next,6/6] selftests/bpf: add kfunc_call test for simple dtor in bpf_testmod
    https://git.kernel.org/bpf/bpf-next/c/47a8cf0c5b3f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



