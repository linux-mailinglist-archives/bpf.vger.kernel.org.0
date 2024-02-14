Return-Path: <bpf+bounces-21946-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D5F8541AC
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 04:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 115E61C24508
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 03:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CAE8BFA;
	Wed, 14 Feb 2024 03:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FV+y6E14"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C408467
	for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 03:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707879631; cv=none; b=Mb7NwO0ASQXK6QkEGwHIMKK/po8fwAcPMgGhfJh09r6Z4yfrEKEGWgM2DnhRxXLAtv7lAPKbzYQIdONT6eCE44U0DViq6p7j67+xo1rVdCXr9YgniqNhbd2mPuPA9AxeXCe3GNwmakQHL3P7o0jjfyLTuOHJusQiqVfnyiEMOD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707879631; c=relaxed/simple;
	bh=dYUwCy4oMibr9nvntCYv7YYJxXy4sqXv9NgSYenmT5g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sX46tDbGqU+DIWw/eWFAcjp4oSJXV83/lSL0JTckD5xNV+bKkkzm7/BAigKX4qc88eSkjuDhBG7N+PPRTbSCYOu37QgOzSAnIxlql1zErQmBYVqCN4iILk+DTOkrimVSMOBvjrBrsE/tx0XhIO9dA3iSPngeO5xZS/854mcHSmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FV+y6E14; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 502FAC43394;
	Wed, 14 Feb 2024 03:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707879630;
	bh=dYUwCy4oMibr9nvntCYv7YYJxXy4sqXv9NgSYenmT5g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FV+y6E14+hGeEN1Y0WQEW0VXappLohegc22t4rleEbaqAEuaV5wyFlhAWeEbMU/xz
	 7MOWNBN8tCOXhk1Xke8ZuGp2v4KxSkg9ASldydIdRPJXJkfgDfkR+TS9fC0k6j54D9
	 8mkuvnsrYuJOW9YOemafB+xke/uq2Q1Wlfh7fyCAcIXbj/4+maXajNCa/g5OilOpmM
	 PDn6ZTatzUdrUC7z4SwBeDYe4m8cpqS/GaxZ38l3w0vD4hWcmrBG+j7V9DFUV9pZee
	 zPWw8SJ2KG9MzKN8ujJCjlh8fNmYSfjj7RoTn7SZlsxgUoPoxyydwTURrmAItEImLy
	 q1QUx+mMDyFdQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 32882C1614E;
	Wed, 14 Feb 2024 03:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next] bpf: emit source code file name and line number
 in verifier log
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170787963020.17924.4049337524637501794.git-patchwork-notify@kernel.org>
Date: Wed, 14 Feb 2024 03:00:30 +0000
References: <20240212235944.2816107-1-andrii@kernel.org>
In-Reply-To: <20240212235944.2816107-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 12 Feb 2024 15:59:44 -0800 you wrote:
> As BPF applications grow in size and complexity and are separated into
> multiple .bpf.c files that are statically linked together, it becomes
> harder and harder to match verifier's BPF assembly level output to
> original C code. While often annotated C source code is unique enough to
> be able to identify the file it belongs to, quite often this is actually
> problematic as parts of source code can be quite generic.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next] bpf: emit source code file name and line number in verifier log
    https://git.kernel.org/bpf/bpf-next/c/7cc13adbd057

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



