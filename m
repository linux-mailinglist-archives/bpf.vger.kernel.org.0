Return-Path: <bpf+bounces-5207-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0707A758A17
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 02:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3787E1C20C2F
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 00:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CBA17E1;
	Wed, 19 Jul 2023 00:30:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEA017D1
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 00:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1B9F3C433CA;
	Wed, 19 Jul 2023 00:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689726623;
	bh=ZUWCZ+GVZr3OC9mFjhPEqR3AZR02O8jnm9Irz0Ph/Fg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Wm3LPh5EP7nYKW2L8AVtVh7wleN3VhVKnqJ/v3k2okcZ1kIcGECcv40BLawenGdvY
	 yq3uSbsaIhU560JU12E3AiTB3b4NmCfhPc7ZUmtn+IbBE189QrD7gpn0O5X8TakvCw
	 x4vhJ3M5dU+jDfcrk/a1QEfc//14bl2wncJEQ8cttUX/GEFRUHLyxb0skpfCFp+y6D
	 P3/1z15nkpK46zM277UKpl1OOqLttVWByGgN+44BlkYjaIyNh95bo4//i+PjAxyhrz
	 8HOj1Ve6xrTEMjlqBZZdIpZjEd0kQiemB35vJYpH5sjuvAjCegXo/2wJjVWGpJnrKQ
	 2ubaDNW9dPCog==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F3493E22AE6;
	Wed, 19 Jul 2023 00:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] samples/bpf: README: Update build dependencies required
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168972662299.5728.14295244638929023303.git-patchwork-notify@kernel.org>
Date: Wed, 19 Jul 2023 00:30:22 +0000
References: <aecaf7a2-9100-cd5b-5cf4-91e5dbb2c90d@gmail.com>
In-Reply-To: <aecaf7a2-9100-cd5b-5cf4-91e5dbb2c90d@gmail.com>
To: Anh Tuan Phan <tuananhlfc@gmail.com>
Cc: sdf@google.com, khalid.masum.92@gmail.com, sanganaka@siddh.me,
 daniel@iogearbox.net, andrii@kernel.org, ast@kernel.org,
 martin.lau@linux.dev, bpf@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sun, 16 Jul 2023 23:13:51 +0700 you wrote:
> Update samples/bpf/README.rst to add pahole to the build dependencies
> list. Add the reference to "Documentation/process/changes.rst" for
> minimum version required so that the version required will not be
> outdated in the future.
> 
> Signed-off-by: Anh Tuan Phan <tuananhlfc@gmail.com>
> 
> [...]

Here is the summary with links:
  - [v3] samples/bpf: README: Update build dependencies required
    https://git.kernel.org/bpf/bpf-next/c/89dc4037dda1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



