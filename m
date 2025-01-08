Return-Path: <bpf+bounces-48268-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CD0A06392
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 18:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B46016366B
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 17:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B12200BBF;
	Wed,  8 Jan 2025 17:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ad9IQULC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B80619B586;
	Wed,  8 Jan 2025 17:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736358015; cv=none; b=iUnK0gcnlPoQtxKFgX2Q6j5makdBZj8nDH1CEadynpYQ8iHNidFSK86w7vrROYSQyfo7hHmaD7uJ75oa9OOHoub0wh+05P/hTxnq0GUnf39qeGz5F5aVAUS0jO2PKgzxkuVt/0TB80FtbtCe0SNkZXvKc4DawZmDO7ncPpShVt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736358015; c=relaxed/simple;
	bh=CUWq9iF7AhcYo3zNuJrUNQkSUigetrHToP/2uBJWbkc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BFTeGQb8me3/REPihQkfAf+BiLPp0TYJbXu5A0R8NV/ImU+hdVLCwYYgh62VPijyolFcvuvkDdUxeZ8F/TUwcQpUY7VdEUtxe2x2fCaV/N0oton4pL5V00Nfc8JwRg/8kWgi6gS+TeWYIOn4+92Gb9x12eJGVJa0IezwGzn0doE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ad9IQULC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEEDFC4CED3;
	Wed,  8 Jan 2025 17:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736358014;
	bh=CUWq9iF7AhcYo3zNuJrUNQkSUigetrHToP/2uBJWbkc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ad9IQULCddLkxrMeYeo7cQk/+X46JfBR/6itQU6rEo6I2J8o7yKJKvOxn7VNszgc6
	 C2esF+K4QGsRV56rHOzfsrE4/aMpZeMMVD85P8hOBy8jeG5DCfnWB+OUcskJLJ3uDx
	 B7J2e2vkYxbYNZaGjGLFw4x4OHIIXu6mT67Sm7pC1QCtSp+5+/BIZlalWC6EENZ0K9
	 pCe0ihwotoljfTt0cmoNPwbqWCkdJQJm81j+Fggl2CEhcKWIinC+YEJ3lXHPkwfhoj
	 p+Xa5wR+ucU+2JbKiRL5rQPAjLEjj5tqEPuJitv3G3DqKldKwII7xbLdmyzTTMwJjc
	 I5zmSSBSbHnIA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE054380A965;
	Wed,  8 Jan 2025 17:40:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: fix range_tree_set error handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173635803549.725872.18070598717663737982.git-patchwork-notify@kernel.org>
Date: Wed, 08 Jan 2025 17:40:35 +0000
References: <20250106231536.52856-1-soma.nakata@somane.sakura.ne.jp>
In-Reply-To: <20250106231536.52856-1-soma.nakata@somane.sakura.ne.jp>
To: Soma Nakata <soma.nakata@somane.sakura.ne.jp>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  7 Jan 2025 08:15:35 +0900 you wrote:
> `range_tree_set` might fail and return -ENOMEM,
> causing subsequent `bpf_arena_alloc_pages` to fail.
> Added the error handling.
> 
> Signed-off-by: Soma Nakata <soma.nakata@somane.sakura.ne.jp>
> ---
>  kernel/bpf/arena.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Here is the summary with links:
  - bpf: fix range_tree_set error handling
    https://git.kernel.org/bpf/bpf-next/c/b8b1e3001626

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



