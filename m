Return-Path: <bpf+bounces-72600-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EA8C162CB
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 18:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAC713BE21A
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 17:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9217934DCDF;
	Tue, 28 Oct 2025 17:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MjiuDSyJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975CB27FD44;
	Tue, 28 Oct 2025 17:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761672630; cv=none; b=JZDDWN5ouLS7Dc3vPkGDrveGKKqbnPuFsd/Sv9cqkokWeva/d1oYIW+LNDFvNWkVIV7YM3FSTgP1Tgi8dabsEGhWb8eqeqFk94HAcE/3is1h7kxIjKkWJhUvXHqk3c9Ncf3ROcRPBfAaCkA+isRFjPfJe+Xamnk5OgWEyDubIY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761672630; c=relaxed/simple;
	bh=vPNJqnSrDFmqPL/bM0GI9gC9avySOild+xvw4GcK7bs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Hxp9VseSAJ8Hbbbe9n5QaT65KFfd0ZNOkJQkXTLL6cA6bBMCEAK+cNJoImdhaBU75+dOMWP9zHjRQs9OWQzTsXPbfyUfLNWbC/iN68Y0pz6UVAUXe8eg7fFMqL+o2xfl1x1rPkEk8qB/hNbI0SPFCiy86yqWBDUqcaEgYmYWrDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MjiuDSyJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0823BC4CEE7;
	Tue, 28 Oct 2025 17:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761672630;
	bh=vPNJqnSrDFmqPL/bM0GI9gC9avySOild+xvw4GcK7bs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MjiuDSyJVhT+mA0Y8fsf4wpQ9OKzeEtyd/mOAJupNJr2ARlb3f8PlwY43YNANUTWW
	 S81IHfdZgqySVjr8bRUZuRE+t5Ycr/CltDnci8Nq8cQxM2n7O+Adp7Pk+kFni48Cga
	 wacr19MmF1wA3vzAW4LxKfIuBghyASaHoSQz/X+PJsY/9mlApPDor4/LX1L3ved9A2
	 xkSLFFjFQCl1qmdYAMhJo7CI3fytk+Q9/T/miMWjH+UaxP/dJ04Xy3bUdOwL605BNv
	 vePjTiwwU5qQUdlWqc/7RAVOFeU+btauv0mPSkJeLuWlNysvJdAZtGHr07Cm1Wy8+W
	 xxJxdKhxhktbw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF1339EF942;
	Tue, 28 Oct 2025 17:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] libbpf: fix the incorrect reference to the memlock_rlim
 variable in the comment.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176167260776.2322783.18424488316564504145.git-patchwork-notify@kernel.org>
Date: Tue, 28 Oct 2025 17:30:07 +0000
References: <20251027032008.738944-1-jianyungao89@gmail.com>
In-Reply-To: <20251027032008.738944-1-jianyungao89@gmail.com>
To: Jianyun Gao <jianyungao89@gmail.com>
Cc: linux-kernel@vger.kernel.org, andrii@kernel.org, eddyz87@gmail.com,
 ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 27 Oct 2025 11:20:08 +0800 you wrote:
> The variable "memlock_rlim_max" referenced in the comment does not exist.
> I think that the author probably meant the variable "memlock_rlim". So,
> correct it.
> 
> Signed-off-by: Jianyun Gao <jianyungao89@gmail.com>
> ---
>  tools/lib/bpf/bpf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - libbpf: fix the incorrect reference to the memlock_rlim variable in the comment.
    https://git.kernel.org/bpf/bpf-next/c/54c134f379ee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



