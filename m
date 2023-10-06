Return-Path: <bpf+bounces-11514-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8097A7BB140
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 07:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52A6D1C209E4
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 05:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194864C98;
	Fri,  6 Oct 2023 05:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MAEX3Bp/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E867EA1
	for <bpf@vger.kernel.org>; Fri,  6 Oct 2023 05:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A65DFC433C9;
	Fri,  6 Oct 2023 05:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696570823;
	bh=i0vWmFm1rNMbqmdH6aUvaNH/rlt5gbDd1KUTPusN3G4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MAEX3Bp/uW1+WDUINavoQnIQUOAWvhzEU0s3t3yTdVc5FYPFav4vNwFGBkQrHM2PA
	 ogGDA78M/otmKi1W0BwL4HXjBjS3YPbEkXP+Lrjb4PhljD3VTkiGOg4SYMQdPYvUjc
	 BeuLqFg/P6ITAMLavMP2SV63Zh72ZmKL6EjQ9BqOhQ8XM9wKzi8kNc5mTqt7enaEH8
	 gtOhydo4txddSplNvrNslndglLZ5y0RDdVT/l2PxYksc9ruaOzH9D9tOUdzhjg2V2p
	 gwKKn04bwj4waGOSpGXtj+4pU0F7FpMQMSXAkhrjhAHD0XVK9zsovu9xQsR/o5cbBF
	 X8hWke5jxG7lA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8B60EC595CB;
	Fri,  6 Oct 2023 05:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: Fix the comment for bpf_restore_data_end()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169657082356.32138.7846294704221528255.git-patchwork-notify@kernel.org>
Date: Fri, 06 Oct 2023 05:40:23 +0000
References: <20231005072137.29870-1-akihiko.odaki@daynix.com>
In-Reply-To: <20231005072137.29870-1-akihiko.odaki@daynix.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Thu,  5 Oct 2023 16:21:36 +0900 you wrote:
> The comment used to say:
> > Restore data saved by bpf_compute_data_pointers().
> 
> But bpf_compute_data_pointers() does not save the data;
> bpf_compute_and_save_data_end() does.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
> [...]

Here is the summary with links:
  - bpf: Fix the comment for bpf_restore_data_end()
    https://git.kernel.org/bpf/bpf-next/c/9c8c3fa3a52b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



