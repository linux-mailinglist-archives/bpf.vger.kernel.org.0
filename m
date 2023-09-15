Return-Path: <bpf+bounces-10174-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D77417A24FF
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 19:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C80741C20358
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 17:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0494A15EBF;
	Fri, 15 Sep 2023 17:40:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44681D26A
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 17:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C36CDC433C9;
	Fri, 15 Sep 2023 17:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694799624;
	bh=vNs6vIoPDRpiFt2O6Ga6Zi3kuJVO3kVGehXX2BuD4xA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DlZ27RdSAbovydn8keqAPM9DU5+oUnscL4U1Y4cVKCm/KSjsIKhqpcjI1cGBcQxgK
	 HJ/dfQotWeMhHZ23UPQI7Z1OSC44aK2lA9hQh3dGsQd9ZwfxiAdP8zTncr9JT1HM9N
	 +y5chIwPpEXzaS+85ZRPpIC29S1Fye5bb5z6XNnijnzBpr1U5V/cbYsYPHsrbu1VKJ
	 7vZxn+5o8IsqoFaDK9sPtpKj9K35EE8z7ESdzMfVIT9sSXVZR/nVmBbJQ8swTgwuL9
	 q3/ihuGXZes9dtRFWlViNjjZkli725gWVHyZyYKyez4N81hX1tf9wdNW5MH7Skfn2E
	 79kyHer9/qzmg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A81D1E22AF2;
	Fri, 15 Sep 2023 17:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: Fix uprobe_multi get_pid_task error path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169479962468.14368.9573538452488348285.git-patchwork-notify@kernel.org>
Date: Fri, 15 Sep 2023 17:40:24 +0000
References: <20230915101420.1193800-1-jolsa@kernel.org>
In-Reply-To: <20230915101420.1193800-1-jolsa@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 dan.carpenter@linaro.org, bpf@vger.kernel.org, kafai@fb.com,
 songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@chromium.org, sdf@google.com, haoluo@google.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 15 Sep 2023 12:14:20 +0200 you wrote:
> Dan reported Smatch static checker warning due to missing error
> value set in uprobe multi link's get_pid_task error path.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/bpf/c5ffa7c0-6b06-40d5-aca2-63833b5cd9af@moroto.mountain/
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: Fix uprobe_multi get_pid_task error path
    https://git.kernel.org/bpf/bpf/c/57eb5e1c5c57

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



