Return-Path: <bpf+bounces-46034-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5359E2EF5
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 23:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52A8D162701
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 22:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F071FA825;
	Tue,  3 Dec 2024 22:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tdPauJ9p"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B443319CCF9
	for <bpf@vger.kernel.org>; Tue,  3 Dec 2024 22:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733264416; cv=none; b=D8GLgTea9SIAGhZ79+mLd/tScgSASXX2GPcuHcKQIBGKR7YkdIYEXr+fTEG8x8Lfpevkr/56MlT33vdh9atMq9zEmKiLiqDJnNEPtaFqSATIjvaAVoG2u89mrUmeyylHD4Nr+w/VKAcotPNfZ2i7/gmzBXd6LSEgNLFT1gpXH04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733264416; c=relaxed/simple;
	bh=NIhTfQnEpTmQOUgxNrz8TBaETLNqE2fldOFNYc7XljU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qB/pu2MYvmzJq6D3NYMTAvApvJ/QIJn6JyHZ/NJ3w1LxXLy1GNkjgPO5ntHznb9AzZFVAJ9zXZQRpK0v4wzSlKix6oYtEIhAUMhmpz/VUR96N5IhUKkx23zJmuYv5D1m/UMLWXj5fJNNwVkJV3sfkkDbfa691o1Zll61kw3nn6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tdPauJ9p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA38C4CEDC;
	Tue,  3 Dec 2024 22:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733264416;
	bh=NIhTfQnEpTmQOUgxNrz8TBaETLNqE2fldOFNYc7XljU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tdPauJ9poWODaE2zk19z0+8Cl7hkW6Bq1teEu3wj4/2qkj9QtE2yCeO3veMARJXXl
	 xyBTts/FEB+2SXMIku1QEPLpVSJU8cbAV+disFephHMdbIgUCFVZ3xZGQggd74EkAs
	 UWkR+R8FJMvGXA4DmrnHWBEIsWDWcpq2VFjhNIrWwCUb/l/NPx4k9RE65HUXfGUL9E
	 ziWeLVBY/lM2nzEKjX65slP9N6KDS/hDCXFCq/Hx7a+5vcHl5EzYnyD5/Gx0I6VOA+
	 whuvh7+ZFoO4eIuazkbKlCZTwxfu8OjzsFaahSc9AxG+5e9sb4OewVPcr6xz/INJbW
	 u+YxTux/IS08w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE1F93806656;
	Tue,  3 Dec 2024 22:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v3] samples/bpf: remove unnecessary -I flags from libbpf
 EXTRA_CFLAGS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173326443030.283880.11574146958380866981.git-patchwork-notify@kernel.org>
Date: Tue, 03 Dec 2024 22:20:30 +0000
References: <20241203182222.3915763-1-eddyz87@gmail.com>
In-Reply-To: <20241203182222.3915763-1-eddyz87@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, masahiroy@kernel.org, sdf@fomichev.me

Hello:

This patch was applied to bpf/bpf.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue,  3 Dec 2024 10:22:22 -0800 you wrote:
> Commit [0] breaks samples/bpf build:
> 
>     $ make M=samples/bpf
>     ...
>     make -C /path/to/kernel/samples/bpf/../../tools/lib/bpf \
>      ...
>      EXTRA_CFLAGS=" \
>      ...
>      -fsanitize=bounds \
>      -I/path/to/kernel/usr/include \
>      ...
>     	/path/to/kernel/samples/bpf/libbpf/libbpf.a install_headers
>       CC      /path/to/kernel/samples/bpf/libbpf/staticobjs/libbpf.o
>     In file included from libbpf.c:29:
>     /path/to/kernel/tools/include/linux/err.h:35:8: error: 'inline' can only appear on functions
>        35 | static inline void * __must_check ERR_PTR(long error_)
>           |        ^
> 
> [...]

Here is the summary with links:
  - [bpf,v3] samples/bpf: remove unnecessary -I flags from libbpf EXTRA_CFLAGS
    https://git.kernel.org/bpf/bpf/c/5a6ea7022ff4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



