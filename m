Return-Path: <bpf+bounces-26630-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E36088A33A4
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 18:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FC321C240BA
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 16:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4238914A62E;
	Fri, 12 Apr 2024 16:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpbeTX7b"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BFC14A605;
	Fri, 12 Apr 2024 16:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712938829; cv=none; b=n1TreVu5GRGYZPI14P3qOfw+CheBqi6ZWFUfUbFZ+PZvrmdMN9cK30IlQomjR/v2s5nUYgnDxG3d2wbBUJ8GdmsTDepVDaLDHKXXUwn4m7WAWTPb8Fd7a8o7/5zzWqPPd8squjDksoWVFN+NN4/7PtI2PjLrfS1Dj4joN/LktQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712938829; c=relaxed/simple;
	bh=alwUDIF6ctHhDHxQZLYPIRUS9AZtSdoiRdkxnjMqnIY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qwYN7QgBhofur8OoZi6cGByR0bXqIW1hG3sQW8C0QnIc6+8Qsr8yS+jGc74B7wnW/+Vb/hQEZYJwnEyWtpVLuG6clnQ+cUjLVrVMeJJprWW+KsIiYPbXDJ5aQ8LZp/l0g8WYb7dujliSfAr/64/JyXFvfldHYReqhF3VFOehjPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpbeTX7b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48746C113CC;
	Fri, 12 Apr 2024 16:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712938829;
	bh=alwUDIF6ctHhDHxQZLYPIRUS9AZtSdoiRdkxnjMqnIY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kpbeTX7bP4svgtkavv+0J7G79nBxpawr2r09uSfHo70GHIi5lnMOF2cd5ObxpmX7a
	 BGlhhRhzaWi/LaL32qs0u/dLBzcd92tc8iOsoRYu8XXX/D3q0S1JJmV1Q4mrhO6jzc
	 shJOG6n9c/f68Jy9N75OsW5cEnWFJl4YZFvqVAlexHoe8DVVmvZHEGGfZdk3CKa9lS
	 w7YNRu4i2spOKFM4SW6WdgRkUGrrk7rsu9tIvKuxrd/BAJFF4z7sT44/IRWfccUwTT
	 rrgNgIq02sNXR7t1vV4PliLOzAD4WMwq7CShYYLfkFE0vM2xQHH1q+XfTF/Anz82ZX
	 Uw3b9zTnW4Jow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2FE8CDF7858;
	Fri, 12 Apr 2024 16:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND PATCH] bpftool: Fix typo in error message
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171293882919.11586.5927187479654005381.git-patchwork-notify@kernel.org>
Date: Fri, 12 Apr 2024 16:20:29 +0000
References: <20240411164258.533063-3-thorsten.blum@toblux.com>
In-Reply-To: <20240411164258.533063-3-thorsten.blum@toblux.com>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: qmo@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 11 Apr 2024 18:43:00 +0200 you wrote:
> s/at at/at a/
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
> Resending this because I forgot to CC the mailing lists
> ---
>  tools/bpf/bpftool/prog.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [RESEND] bpftool: Fix typo in error message
    https://git.kernel.org/bpf/bpf-next/c/23cc4fe44f1d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



