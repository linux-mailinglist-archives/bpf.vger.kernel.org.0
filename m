Return-Path: <bpf+bounces-26570-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 575AD8A1E81
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 20:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CDB21F28F8A
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 18:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A238D139CE3;
	Thu, 11 Apr 2024 18:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MYhpbGsW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2572E139593;
	Thu, 11 Apr 2024 18:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712859030; cv=none; b=gEW2iU0HlVTEU5Jny/qdGiPlkERQhvIUyWxijiQEKJIz2kb8Pn08PzyTxbo5s5FMKasHfxxuT/2DSu24NXjbMqOxr5VsY2N8k6XDP+2pxnVND34jBx2B3HO5Nx8+B3fPjGjv6T9AoycYfrw8JWDf76+8Z+rvOjr5RFq/lzqHPyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712859030; c=relaxed/simple;
	bh=FHgYM6W0kq4aN5t27ef7FWGli8iUkqAXM6j1qlBhw7o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RpInSfiAvJpBMH2Y4RvQgSW7787W0UV3VAt0LDIBWApsaIucMb+Zv5ApN3j3JKuXNeVAQ2ANxHuhbLLk1/1MWaOZ2qD68IDcmERYb3rBe9KWrc96lB1b4qV7tbk0i8b4X/QLanHvm9m97ayWS68LtCS0gTbvhq2wtHjL7rcBsLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MYhpbGsW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 78430C072AA;
	Thu, 11 Apr 2024 18:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712859029;
	bh=FHgYM6W0kq4aN5t27ef7FWGli8iUkqAXM6j1qlBhw7o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MYhpbGsWIP0Iwyz0Bml7Hp0bqLi0rV4j4ms3Na7sN1rh894x4vkp9nhkn7wLAnYjb
	 vvHITyXR8z56aHUW3/PX/4DtAJZuRPfBwkM0dBPifNHp4IlBspBaX9Nggo5QinQk8U
	 GjHNSDiWvKy8DkUly3yAFimC54qyFIrYMNif+6Oojp1biGuoEIDEUd0WOY9chfans7
	 RWZPPoYpiMXjDTq+FWyVrEYwbtswElXy/oCeNmxxvB/IS3ZwZl6LwfL4MYFb2m+ISx
	 HStHu9w8hvTiWVPK0ZYMn1ierznAty8dCv7R6GMCY8d3ezswWpMXFOMmRqNJW5x2fE
	 e/VoYA9Q0phjw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 62537C4339F;
	Thu, 11 Apr 2024 18:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v4 0/2] Two fixes for test_sockmap
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171285902939.2178.1171272108619447378.git-patchwork-notify@kernel.org>
Date: Thu, 11 Apr 2024 18:10:29 +0000
References: <cover.1712639568.git.tanggeliang@kylinos.cn>
In-Reply-To: <cover.1712639568.git.tanggeliang@kylinos.cn>
To: Geliang Tang <geliang@kernel.org>
Cc: andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 jakub@cloudflare.com, tanggeliang@kylinos.cn, bpf@vger.kernel.org,
 mptcp@lists.linux.dev

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Tue,  9 Apr 2024 13:18:38 +0800 you wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> v4:
>  - address Martin's comments for v3. (thanks.)
>  - add Yonghong's "Acked-by" tags. (thanks.)
>  - update subject-prefix from "bpf-next" to "bpf".
> 
> [...]

Here is the summary with links:
  - [bpf,v4,1/2] selftests/bpf: Add F_SETFL for fcntl in test_sockmap
    (no matching commit)
  - [bpf,v4,2/2] selftests/bpf: Fix umount cgroup2 error in test_sockmap
    https://git.kernel.org/bpf/bpf-next/c/d75142dbeb2b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



