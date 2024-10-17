Return-Path: <bpf+bounces-42328-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF1D9A2BC1
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 20:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 040641C23145
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 18:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2871E0B63;
	Thu, 17 Oct 2024 18:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S88CSMxW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696211E04AD
	for <bpf@vger.kernel.org>; Thu, 17 Oct 2024 18:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729188627; cv=none; b=lnLMAsw2N74j3H/laWYvUwIII6nEAZSQuuRTbntkp+3NZFFA2dorWH+cPp7gc0exKKx68ujMvd2F0rlwY3lieM0kTt2RNGtOGjuLhwr925TEdQfQl3M+OkwYzFVrochVXGgIkklb5+ciH5109I3s0C6DyFlUkR2ykhmvUhiATPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729188627; c=relaxed/simple;
	bh=jxGdwpyyI6EahZBgSIXb3wPyYz8FxxXVYgt85RwPwvU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IU48WpEfuZdGZeJK+YIEhNX+Z8PERvv1+z8zmqWG22xBR+6zghvCIqeEQApo24zFPTTPwObGHmpqLuIj9Cht8U5BwJ/z1YShEpIUTmoU5eJ3XGo18oLSsnhgR5CpMdJ/kw9UsnEMjfFAWycIYWdvARMONyUkiygT1diJ/J2o/sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S88CSMxW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 431F4C4CEC3;
	Thu, 17 Oct 2024 18:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729188627;
	bh=jxGdwpyyI6EahZBgSIXb3wPyYz8FxxXVYgt85RwPwvU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S88CSMxWP5uC/GiKI+4r69u9JRXL96eFOEOcX6YxcVdytKHJHyB2XsJdU2TLYGhCy
	 YYf9oSAlJ+QStRcLxPn6CqJG6YaN4eGAEFS3zP+CEl0OoUL+uxdfr3QgCZIcO1irR0
	 AUYGBJl8Z1gpTkCkR5G0sIonr7PEN/BT+oCeXN4r4OExCQoMqMb5fPvOnz96x4qzei
	 o7D8BjQDMT30YMHifU/6LJS7O1oi+ODsxpuC1AOEpoI5J/m1MONkT5hd7rm2epyXW/
	 4ZJn0TIN3zEqYbvsFz5DDauyQVn9qAgSZCIIMDva8wyPHoKn5fUIprTFnuI33gAfhB
	 nU2mwEWVnTWlA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1953809A8A;
	Thu, 17 Oct 2024 18:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2 1/2] bpf: Fix iter/task tid filtering
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172918863250.2561819.3090541901248976576.git-patchwork-notify@kernel.org>
Date: Thu, 17 Oct 2024 18:10:32 +0000
References: <20241016210048.1213935-1-linux@jordanrome.com>
In-Reply-To: <20241016210048.1213935-1-linux@jordanrome.com>
To: Jordan Rome <linux@jordanrome.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@kernel.org, kernel-team@fb.com

Hello:

This series was applied to bpf/bpf.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 16 Oct 2024 14:00:47 -0700 you wrote:
> In userspace, you can add a tid filter by setting
> the "task.tid" field for "bpf_iter_link_info".
> However, `get_pid_task` when called for the
> `BPF_TASK_ITER_TID` type should have been using
> `PIDTYPE_PID` (tid) instead of `PIDTYPE_TGID` (pid).
> 
> Fixes: f0d74c4da1f0 ("bpf: Parameterize task iterators.")
> Signed-off-by: Jordan Rome <linux@jordanrome.com>
> 
> [...]

Here is the summary with links:
  - [bpf,v2,1/2] bpf: Fix iter/task tid filtering
    https://git.kernel.org/bpf/bpf/c/9495a5b731fc
  - [bpf,v2,2/2] bpf: properly test iter/task tid filtering
    https://git.kernel.org/bpf/bpf/c/ee8c7c6c3f8c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



