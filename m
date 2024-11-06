Return-Path: <bpf+bounces-44157-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 547189BF81A
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 21:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A2EC2843AC
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 20:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CEC20C47D;
	Wed,  6 Nov 2024 20:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZCiiB9A"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A603520C486
	for <bpf@vger.kernel.org>; Wed,  6 Nov 2024 20:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730925620; cv=none; b=L3+s9xWF2K5pt2MRifJSbfekcnSMns7axJnBQDBsDQYQcLlNGuHZxnJEMq3FPUPkO9V73s0jb8hjlqdpSA0TWpJkpOTmwtfff73Tbc3+D5zs/Em1BEjPWLtV7awsvXIW7AiVXZd3kOeBL/0Z7Jjoxwljid55XBDZlT2qHKaSMcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730925620; c=relaxed/simple;
	bh=DFN/vhQ2fzvdwg6XHvOVYO64ICZIgtCz0tvq8YHNNXY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BI9KU7jR86LxQ/mux3bFpiPddkFVJHApdF00PdmjUFrzSd9TdkvE60cktVIFaxJdi+3gSYTu3Dcz9zv3x+T4Dksl3hD+X0rkGTDIPh4XIdK4sXfoWLNjDy60EoNj42SF5zTyIys0K+ACNnEVYsq1krVCH4/8VjIX9D+r466Ru6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZCiiB9A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D3D8C4CEC6;
	Wed,  6 Nov 2024 20:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730925620;
	bh=DFN/vhQ2fzvdwg6XHvOVYO64ICZIgtCz0tvq8YHNNXY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OZCiiB9A8WTEInKu3cbnHYvQxayXMa8yrExM4MwKloR8ZWQLHbqlCrYYFW12zSTd5
	 iWVGH6EPPYt0p+C/+8DQfZKcwDbVBO1ACTplKGFbRcKKToxEaSyGkPEGi6i9CQ4zIJ
	 qXjJqvVG0e3RGLgWOODKqMIl5+sASo1JpMyQPjgepbWb96m3UIpowcqUakgMey6mmV
	 TKGJP5voM75QQyd8T0qhx0K5EG2vrzlA49SKOQI8ljS3n2hf82bplb9+4b/61q3ewB
	 v6BMKqXYTrah0p9me2rucAFZlpEVvBkJA/1LkA3c29DRYS4gLLnMqiVTkPCdzsyJik
	 Hiin2OkYclpIg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D4A3809A80;
	Wed,  6 Nov 2024 20:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/3] selftests/bpf: Improve building with extra
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173092562925.1412738.4922093056744693162.git-patchwork-notify@kernel.org>
Date: Wed, 06 Nov 2024 20:40:29 +0000
References: <cover.1730449390.git.vmalik@redhat.com>
In-Reply-To: <cover.1730449390.git.vmalik@redhat.com>
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com,
 ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 nathan@kernel.org, ndesaulniers@google.com, morbo@google.com,
 justinstitt@google.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri,  1 Nov 2024 09:27:10 +0100 you wrote:
> When trying to build BPF selftests with additional compiler and linker
> flags, we're running into multiple problems. This series addresses all
> of them:
> 
> - CFLAGS are not passed to sub-makes of bpftool and libbpf. This is a
>   problem when compiling with PIE as libbpf.a ends up being non-PIE and
>   cannot be linked with other binaries (patch #1).
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/3] selftests/bpf: Allow building with extra flags
    https://git.kernel.org/bpf/bpf-next/c/9a28559932d2
  - [bpf-next,v3,2/3] bpftool: Prevent setting duplicate _GNU_SOURCE in Makefile
    (no matching commit)
  - [bpf-next,v3,3/3] selftests/bpf: Disable warnings on unused flags for Clang builds
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



