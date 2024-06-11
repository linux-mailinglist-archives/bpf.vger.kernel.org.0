Return-Path: <bpf+bounces-31870-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC94A904402
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 20:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 919E51F2160D
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 18:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D75A824B3;
	Tue, 11 Jun 2024 18:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APXFUpKc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B1085642
	for <bpf@vger.kernel.org>; Tue, 11 Jun 2024 18:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718131830; cv=none; b=hlKDJ5uKtmk+rw/c4NUta5w3USFc4dguEYKfmLG10iHeSHGXR97EHBQYci2x4s4hwMr+CatQRf3JSsjZM1eok80Qb7jIs0ej0Y6Ro2yl4B3CoW29LW67lKgf/UOgK9z7nVfR+HUqcga0yZQEXyFckE5islIciGjRDGJODZjXzBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718131830; c=relaxed/simple;
	bh=iCpqB4MznPLwRGNevwc6K6bt9SyzV13UbM8lIgq2CYg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j37LfrFSjZOw0t+flANX8GO5aTftAL526HEjjmV+3NtcPummhcuZcxQQPdQOJ3qZsvvWefoCWKhJB8GM286zLkWOYpKOoyFJy18kFROuOJM9eVy5kbLnoHKI/7HUuOpqhNCUDL5UAwgjlUeqcoCXk33rMJTOXstywv0clVaLQpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APXFUpKc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 498CEC4AF52;
	Tue, 11 Jun 2024 18:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718131830;
	bh=iCpqB4MznPLwRGNevwc6K6bt9SyzV13UbM8lIgq2CYg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=APXFUpKcbFNLTSYx1EaRTBK0i/x6fOIXGy+DKcs/Om4HuJWuU545vAbh5NRji/ahr
	 apML4IymEeWpoxDkF+Zt8GZQn9Mn/XshQOAwFtFWZbWv1cEjDhJikPfVpOeLALaads
	 WVGA5heHG4QXIDG/wCjLXJ8kIzXJW6sCpb+9kExQwq0k77eVsvKlLGu32oEN1Sj9rf
	 9iGxW+B6af21pYtRAY3pjeDkIYdv4ydOBPL2oNffpHBg/T4oWYu37NF4Vz1hA8kqKn
	 6tNjfXuTaiMkGhO47s3FYu2r95gRtpy3Pq1iVDL1zLQ2Y0LmdfCrYUpj7nTS3gY96E
	 PTBxIdFjRvvaA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 34EBFC595C0;
	Tue, 11 Jun 2024 18:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] bpftool: Query only cgroup-related attach types
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171813183021.12628.8466090486604386484.git-patchwork-notify@kernel.org>
Date: Tue, 11 Jun 2024 18:50:30 +0000
References: <20240607111704.6716-1-tadakentaso@gmail.com>
In-Reply-To: <20240607111704.6716-1-tadakentaso@gmail.com>
To: Kenta Tada <tadakentaso@gmail.com>
Cc: bpf@vger.kernel.org, qmo@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  7 Jun 2024 20:17:04 +0900 you wrote:
> When CONFIG_NETKIT=y,
> bpftool-cgroup shows error even if the cgroup's path is correct:
> 
> $ bpftool cgroup tree /sys/fs/cgroup
> CgroupPath
> ID       AttachType      AttachFlags     Name
> Error: can't query bpf programs attached to /sys/fs/cgroup: No such device or address
> 
> [...]

Here is the summary with links:
  - [v3] bpftool: Query only cgroup-related attach types
    https://git.kernel.org/bpf/bpf-next/c/98b303c9bf05

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



