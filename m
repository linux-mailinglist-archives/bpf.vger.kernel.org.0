Return-Path: <bpf+bounces-7633-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EB9779D07
	for <lists+bpf@lfdr.de>; Sat, 12 Aug 2023 05:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA7D2281D45
	for <lists+bpf@lfdr.de>; Sat, 12 Aug 2023 03:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F47815CE;
	Sat, 12 Aug 2023 03:50:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E8415B6
	for <bpf@vger.kernel.org>; Sat, 12 Aug 2023 03:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E251BC433C9;
	Sat, 12 Aug 2023 03:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691812222;
	bh=Qt8OBRnQQJ5N+2baQp8lwDdto5j0cvU0C9DKfSVvmTo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nJy0gqUsCpaRDLVBl5B5swmEb/y33KEVN2iN14Z5REWY7BZW3dgVouLjEWCI6MwGg
	 TiQyCB/TCV/xYMd7furPiqW2UAgOiwL9NPSRc4qEHehQY1FNBdd183gfE1vzKepZjV
	 Q2XlmY8LLRy1cgDQopcjaIcTB7QIpR+6CB8rW+d+5rips8b9OmRMXvWFQG6qfTndfs
	 xjMYB544n5fFothOU7q3CBKM79rMJbC7ACCjtg2B8eF7XHlZhNs8UXRjXAKId73PdK
	 pbAFA2OFKIVGLyRaPpawAA3KTPEbsOm4nX1mOMOZVjgPDvwqcIWj4r3MFCAkENcBWN
	 835jRnOoypDbA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CC5C5C64459;
	Sat, 12 Aug 2023 03:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Remove unused declaration bpf_link_new_file()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169181222183.25755.10055441835548144317.git-patchwork-notify@kernel.org>
Date: Sat, 12 Aug 2023 03:50:21 +0000
References: <20230809140556.45836-1-yuehaibing@huawei.com>
In-Reply-To: <20230809140556.45836-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Wed, 9 Aug 2023 22:05:56 +0800 you wrote:
> Commit a3b80e107894 ("bpf: Allocate ID for bpf_link")
> removed the implementation but not the declaration.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  include/linux/bpf.h | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [bpf-next] bpf: Remove unused declaration bpf_link_new_file()
    https://git.kernel.org/bpf/bpf-next/c/01b853965563

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



