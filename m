Return-Path: <bpf+bounces-34963-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C091393435E
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 22:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68BBE1F223F7
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 20:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7951849F3;
	Wed, 17 Jul 2024 20:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UoFC2rt+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4403733997
	for <bpf@vger.kernel.org>; Wed, 17 Jul 2024 20:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721249434; cv=none; b=lPaZcl3BgIpwiTHPTBs0h+K9H7dBhQKedFGdS4WvArbQlAtLW9lxy1PGS3yaGIV8zdGOj9kCMuLDZSNrwyavfBvjbYzkuMWCCmLbpAyq3E4vkRWLNfuPhfD9wS15NNOF9QmQAHzrsbN6oEUsHuZrUPbircO8gcU5R0qYOFaqn1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721249434; c=relaxed/simple;
	bh=WzfGuLRaG42cec5Xyl5YrHp8fkiUwQ9vorhCIDs7NRk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lwKVSxYD9BfjipzhDQ14RZ1t8LpxNqBZ+08/UnOZhRxsqZ66MBe/2QPP7IRSGHQWxL33T46528a1aBYaQh1OuIjAfV+ZII/+xJL2EOnbYOoMB/MS32q1zzdG00Blke0tO22lRfTg2EJyqocs7v97PdT3amOEx4jEWYxIuPbeu8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UoFC2rt+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C1DD5C4AF0D;
	Wed, 17 Jul 2024 20:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721249433;
	bh=WzfGuLRaG42cec5Xyl5YrHp8fkiUwQ9vorhCIDs7NRk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UoFC2rt+mpoopAwsk2sZ9XhKHfs1sXw+y5CvPqESrHtI8WAsF7d/xHrs9I5NZ5UcE
	 +GQXZtnaSq+OENAyCqgjUCKcnIKjcZRIwxjsaG20GnC3HxLXxPMdhNf8oWftIo2YSk
	 VN7cCtU4DSeP3DEkMfqmvVLmUPUuZMbELF73rTOipZcNlsNeHRp7a41hKl/3belfxV
	 TQ5OXGJX3VaNtAYoEPZ93bbaBfkFybG22fjgui6yREOmtKcYVuN+wufYsxwjqwyrsg
	 4RrIwpBvE1p4AoWQj5Z0jETm8eiUZOhZrDR0glXphBrRpAy2fOpS8sPzgIoKTcAV9G
	 sKHzB6Q43hK3A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AD8F8C4332D;
	Wed, 17 Jul 2024 20:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: fix no-args func prototype BTF dumping
 syntax
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172124943370.32411.8824112107790062695.git-patchwork-notify@kernel.org>
Date: Wed, 17 Jul 2024 20:50:33 +0000
References: <20240712224442.282823-1-andrii@kernel.org>
In-Reply-To: <20240712224442.282823-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com, tj@kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri, 12 Jul 2024 15:44:42 -0700 you wrote:
> For all these years libbpf's BTF dumper has been emitting not strictly
> valid syntax for function prototypes that have no input arguments.
> 
> Instead of `int (*blah)()` we should emit `int (*blah)(void)`.
> 
> This is not normally a problem, but it manifests when we get kfuncs in
> vmlinux.h that have no input arguments. Due to compiler internal
> specifics, we get no BTF information for such kfuncs, if they are not
> declared with proper `(void)`.
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: fix no-args func prototype BTF dumping syntax
    https://git.kernel.org/bpf/bpf/c/189f1a976e42

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



