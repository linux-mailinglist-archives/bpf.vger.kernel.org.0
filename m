Return-Path: <bpf+bounces-51367-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0ECA337A4
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 07:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E21A1887B39
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 06:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2E9207644;
	Thu, 13 Feb 2025 06:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDjeT/2c"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062291D86E6
	for <bpf@vger.kernel.org>; Thu, 13 Feb 2025 06:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739426412; cv=none; b=BIEdjh48kP6emNCeK9yqUvt5b55Sxt+7IhJowdewvveOyO1oGFYAmGq8DU1xSCfG/Egte02TGAKTQvP9ogkgBeE8WiNUhlSanLumyN1hg9lcvNtoUDwuZlEPfCgC87O+MvKY/zQVm2FfL6jy9AcrV2zOHGp07kXGTSH+Gv/xags=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739426412; c=relaxed/simple;
	bh=EaXcrwrsVa+p4/goNjtQBv7er7ykLxqI1QCKPpNDJNE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q2+P1BG+Zgd2py/Mj58wDvVdhYlcbxlx5bQiKnGoKJMzPCjwByam3LFa3Psa5KwBSBLqi5KBoQgKu/pWKgutuXl9UsdV8xuWPArYdLoNq1zg8jzR1maPWxNxDKAYB3FqnCKIYnHAybu/9FaHnwTTjYpCjZf3vjLTYHsdQlUX9C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDjeT/2c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62C2DC4CED1;
	Thu, 13 Feb 2025 06:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739426411;
	bh=EaXcrwrsVa+p4/goNjtQBv7er7ykLxqI1QCKPpNDJNE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cDjeT/2cc8+sS3X4ABz8951uhzjQ5o4ctNnItR89WdMdf5BpHWx8ISQLFiXjAaRn4
	 WQ8pVmiI2u3eyIXqpiB4FM0o9BTUVu8XZ+VOtxWvJRUH8tfgplwmlG3qcxFhmaf8Zz
	 1iUv0mgNdjrM0FLlqdEry8OS9Tc73n6gi8nmY51KrEIZPxVy2P4wEUvzB31ZneHddH
	 LYaIDjo6j7VzI9dfSZRGs7SaZXrzjuvMMRP4xB4qXfYRYEYqw7yb9ff0EZWw+fNYsm
	 +ft4bEBnWGygOYCXPYT+a74p+cSbxfvK4GEqPlSkJdbTYuTKomo4y6ST/YnLEIeX05
	 dbZDl+KE0FWbw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE8C5380CEE8;
	Thu, 13 Feb 2025 06:00:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Sync uapi bpf.h header for the tooling infra
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173942644053.779151.14574806891419089181.git-patchwork-notify@kernel.org>
Date: Thu, 13 Feb 2025 06:00:40 +0000
References: <20250213050427.2788837-1-yonghong.song@linux.dev>
In-Reply-To: <20250213050427.2788837-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 12 Feb 2025 21:04:27 -0800 you wrote:
> Commit 0abff462d802 ("bpf: Add comment about helper freeze") missed the
> tooling header sync. Fix it.
> 
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  tools/include/uapi/linux/bpf.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [bpf-next] bpf: Sync uapi bpf.h header for the tooling infra
    https://git.kernel.org/bpf/bpf-next/c/f18169c89ea7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



