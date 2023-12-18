Return-Path: <bpf+bounces-18225-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7CE817889
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 18:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEB4B284E98
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 17:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F005A868;
	Mon, 18 Dec 2023 17:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PnZzbX7n"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957E75BFB4
	for <bpf@vger.kernel.org>; Mon, 18 Dec 2023 17:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 174D6C433CA;
	Mon, 18 Dec 2023 17:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702920024;
	bh=NOh2f7djPTmE6/3G4+bngPaEatwW74jKI7x0fiQgsqs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PnZzbX7nEoGclP1yv0MgfrJz2W+0k1UaL3KsZWUj21Se+UCuNMWKriKgX7B/e4k3O
	 XheTqjnWSC3CqEKkfbMLhg5EimnLCsoIL/mn9w3G3IZjDx0FwS2en+L9GkQLGV0xoJ
	 mzZUBg6R48GFz9SbXXe5DDpVwNIH48jwGQJA1e2DUarUGbAadydS0D1KRvcPxpCpIa
	 7QemKuzAhn8NBm8aBcg86jQn8VprlTohjjhQDnlVWuu+RisDinOQt9KdGufjMVNCAw
	 bCpDMR2Gn/qMWotDjp4CpeF3C2i0mEUwtRIzMn/PKjrVgISNjpDQgZhKqMZZAEJtRq
	 WxzbHG0G8Q2SQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F2C18D8C98B;
	Mon, 18 Dec 2023 17:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND bpf-next v2] selftests/bpf: Test the release of map btf
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170292002399.23499.16986697641977609818.git-patchwork-notify@kernel.org>
Date: Mon, 18 Dec 2023 17:20:23 +0000
References: <20231216035510.4030605-1-houtao@huaweicloud.com>
In-Reply-To: <20231216035510.4030605-1-houtao@huaweicloud.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, alexei.starovoitov@gmail.com,
 andrii@kernel.org, song@kernel.org, haoluo@google.com,
 yonghong.song@linux.dev, daniel@iogearbox.net, kpsingh@kernel.org,
 sdf@google.com, jolsa@kernel.org, john.fastabend@gmail.com,
 houtao1@huawei.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Sat, 16 Dec 2023 11:55:10 +0800 you wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> When there is bpf_list_head or bpf_rb_root field in map value, the free
> of map btf and the free of map value may run concurrently and there may
> be use-after-free problem, so add two test cases to demonstrate it. And
> the use-after-free problem can been easily reproduced by using bpf_next
> tree and a KASAN-enabled kernel.
> 
> [...]

Here is the summary with links:
  - [RESEND,bpf-next,v2] selftests/bpf: Test the release of map btf
    https://git.kernel.org/bpf/bpf-next/c/e58aac1a9a17

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



