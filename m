Return-Path: <bpf+bounces-18059-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 517B78155A6
	for <lists+bpf@lfdr.de>; Sat, 16 Dec 2023 01:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 837891C21822
	for <lists+bpf@lfdr.de>; Sat, 16 Dec 2023 00:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31237110B;
	Sat, 16 Dec 2023 00:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="acYw0KfB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB6F10FE
	for <bpf@vger.kernel.org>; Sat, 16 Dec 2023 00:40:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08671C433C7;
	Sat, 16 Dec 2023 00:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702687229;
	bh=K3HnFN20b9pXGyojmPSA3QELr7TE1+JG3w32ruzvpEk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=acYw0KfBEYrAybaL2BcdF2IdetwuKVjEuj1QMMm0HysyyXZeHUVXa3F+736LnmGPm
	 e0JsWvEgY56iPQV92Y14EoYcKkygkf1xxYjkmLOjVx2tSmHckJSSHALxbLNwNDz3lp
	 YyRP0E8DR3/iftSaOOdcRvcdhs3gIDqyjbL+aW9K7deQAHLYTF+WkCHvVz8gHMrViN
	 o91jr7taWYQPiahmiyjmLFkZlSqACwyl9jTssefvwO3pQSIqQxTFFkr/XEIuhErXV9
	 MJKmV6ilxJ8clXo6S+PyVXueMyb67UA/mOENc0koNVpTxeQtWVu1QFwSCK6ZuyLfRj
	 0JijjDxnjjG1g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E3FE8DD4EF1;
	Sat, 16 Dec 2023 00:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2 bpf] bpf: Add missing BPF_LINK_TYPE invocations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170268722893.21788.7835905632986379631.git-patchwork-notify@kernel.org>
Date: Sat, 16 Dec 2023 00:40:28 +0000
References: <20231215230502.2769743-1-jolsa@kernel.org>
In-Reply-To: <20231215230502.2769743-1-jolsa@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 pengfei.xu@intel.com, houtao1@huawei.com, bpf@vger.kernel.org, kafai@fb.com,
 songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@chromium.org, sdf@google.com, haoluo@google.com,
 houtao@huaweicloud.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Sat, 16 Dec 2023 00:05:02 +0100 you wrote:
> Pengfei Xu reported [1] Syzkaller/KASAN issue found in bpf_link_show_fdinfo.
> 
> The reason is missing BPF_LINK_TYPE invocation for uprobe multi
> link and for several other links, adding that.
> 
> [1] https://lore.kernel.org/bpf/ZXptoKRSLspnk2ie@xpf.sh.intel.com/
> 
> [...]

Here is the summary with links:
  - [PATCHv2,bpf] bpf: Add missing BPF_LINK_TYPE invocations
    https://git.kernel.org/bpf/bpf/c/117211aa739a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



