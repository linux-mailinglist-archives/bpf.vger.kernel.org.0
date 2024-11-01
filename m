Return-Path: <bpf+bounces-43778-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 425C69B98F6
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 20:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 095C02826A6
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 19:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6231D0F50;
	Fri,  1 Nov 2024 19:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JCfc8Jfr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1376156880
	for <bpf@vger.kernel.org>; Fri,  1 Nov 2024 19:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730490622; cv=none; b=gAXRNGVBNraXMlNj5XLKYf+DPtL3AW7vt/kSpUzwjCbaQh3LK/IeZup91oFiea0Skmk9WMDJCrWiwP1nepFwLu/qmfJN8qtbP6Z303dO0zJz2a/hiHe2B0IdfXuLBbOAsmsckAuDF+axb3BxbZIX01e9c2hyRWh3C6B4uP/QsMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730490622; c=relaxed/simple;
	bh=EZwD5IPBhamnraR0XjdrUNqeXuqRWkmc/T6svylhfYs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=riX8SJGDtX4rEkhi+hBO3lbIZ5vrjPyZi11S+WChWst7YwJe23t4BpvjCNi+Rqb+8BRGfv5fo6gX2HbmCAKvSgryEonimqT2fvZJbwipEfZ/PQg258p4r594d8xg/s+Uwq/OK/6gr02qYXKQq0urfIPHZfxjpGByyHKNWDzN9Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JCfc8Jfr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5972CC4CECD;
	Fri,  1 Nov 2024 19:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730490622;
	bh=EZwD5IPBhamnraR0XjdrUNqeXuqRWkmc/T6svylhfYs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JCfc8JfrUVzExl8UEFyKMZhSTOYPK1auHtd0zkDlS4+nlfQfMX7Ow7RSRzUJ2DjSc
	 zFi2cDdlcQV6YDUYOrtlDgMMMIEZWMw6N+Xe08zK6zYDrGJ5dbx59f87qhtSRw2M8r
	 Y29t1jE3/TlO9V64CFMA0HkXyeD+fWYn9jongZhbvP4jWMZ4jHYUPE2PdQi83aNafM
	 r/OMu6dNQnsMFYYxvqJBbwqkbpMpHzG5Eha03WliOPVjIfNoEbJrfhjVJI8Al1A15x
	 EZDpVpFeSoyg/vtgbqL0jaHlAgvv48Z1W6oOxksevsQX5LV+uDavSXXYCMydxBXePX
	 hIahpFsaPgIbQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD293AB8A96;
	Fri,  1 Nov 2024 19:50:31 +0000 (UTC)
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
 <173049063051.2829606.8885445746674871122.git-patchwork-notify@kernel.org>
Date: Fri, 01 Nov 2024 19:50:30 +0000
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
    (no matching commit)
  - [bpf-next,v3,2/3] bpftool: Prevent setting duplicate _GNU_SOURCE in Makefile
    https://git.kernel.org/bpf/bpf-next/c/0513eeee86d6
  - [bpf-next,v3,3/3] selftests/bpf: Disable warnings on unused flags for Clang builds
    https://git.kernel.org/bpf/bpf-next/c/77017b9c4682

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



