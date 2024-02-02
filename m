Return-Path: <bpf+bounces-21082-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B171B847970
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 20:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E38B289E07
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 19:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0865812F39F;
	Fri,  2 Feb 2024 19:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qfdpx4EU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7840812C7F7;
	Fri,  2 Feb 2024 19:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706901028; cv=none; b=jnlg55Kdfa5K7CFVc2f67pjM3oQYzav9EtONb8lWfwlBBtOqprtJP8B2wT8lq7u9tlrm65vRjbDen2yw+i1wgGle/JDa3d44i6uC3U1ifoO5BnRJG4PyFa/0/lJxfCt5jivEXTZAS/xMePDLPjZE95EyHsRsS1NgpJi/Xos7FQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706901028; c=relaxed/simple;
	bh=iJn7ks39CQmQhgEd4wtOZ6UX0hQLi95z7T6yi3mqIGo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OB+uB2P/mKOOvX28UQsCLygk0sJksaGR0iHEg0Z/NnHjlttmKWVFSuzWK1RJM+RhK7Ak9b9xWhPJzB6FEDGNAVfBft+R7oL41JoGl7gBbdAGE/psUlUyaLxAdoV/GdxYH1+dSkHhTEqa139oV/BHFJTtkvlmyD30WebPKwzL6v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qfdpx4EU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39EFAC4E662;
	Fri,  2 Feb 2024 19:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706901028;
	bh=iJn7ks39CQmQhgEd4wtOZ6UX0hQLi95z7T6yi3mqIGo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Qfdpx4EUmTQzqKwHc8Z7+cLOPWxpG8WHSAIfi/DbKggrlx4mQ8BhYnhgQj9wmWzKY
	 MqJJSm0dE5QqFtuj1TWO/lwO97AmRLnxk98Idvz4akFoQCvhxr8/3UOKrZQ6i39GS0
	 EYwpNGe///bob55O0R1DwhqolnadTsqLjbGzbcJiqO4JHUCFZXGpED1sGXfu9sXNnu
	 t9t4OXnrPv3iA5II0ZysporrAHUh8ZGArmdJgZqfc/HDq0kj1TJTiPyI7tpZcBKIdv
	 rIyHHsAoWdx9HW7PTwzxtWNE+10gzL3ECI0vLXLrvQNFBhn9whn4mJQMLvUqpgA/24
	 3RuAmVzCcpUnA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1E88ED8C978;
	Fri,  2 Feb 2024 19:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 0/4] net/sched: Load modules via alias
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170690102811.13805.7780804677680827549.git-patchwork-notify@kernel.org>
Date: Fri, 02 Feb 2024 19:10:28 +0000
References: <20240201130943.19536-1-mkoutny@suse.com>
In-Reply-To: <20240201130943.19536-1-mkoutny@suse.com>
To: =?utf-8?b?TWljaGFsIEtvdXRuw70gPG1rb3V0bnlAc3VzZS5jb20+?=@codeaurora.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 cake@lists.bufferbloat.net, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, toke@toke.dk, vinicius.gomes@intel.com,
 stephen@networkplumber.org, horms@kernel.org, pctammela@mojatatu.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  1 Feb 2024 14:09:39 +0100 you wrote:
> These modules may be loaded lazily without user's awareness and
> control. Add respective aliases to modules and request them under these
> aliases so that modprobe's blacklisting mechanism (through aliases)
> works for them. (The same pattern exists e.g. for filesystem
> modules.)
> 
> For example (before the change):
>   $ tc filter add dev lo parent 10: protocol ip prio 10 handle 1: cgroup
>   # cls_cgroup module is loaded despite a `blacklist cls_cgroup` entry
>   # in /etc/modprobe.d/*.conf
> 
> [...]

Here is the summary with links:
  - [v5,1/4] net/sched: Add helper macros with module names
    https://git.kernel.org/netdev/net-next/c/b26577001af4
  - [v5,2/4] net/sched: Add module aliases for cls_,sch_,act_ modules
    https://git.kernel.org/netdev/net-next/c/241a94abcf46
  - [v5,3/4] net/sched: Load modules via their alias
    https://git.kernel.org/netdev/net-next/c/2c15a5aee2f3
  - [v5,4/4] net/sched: Remove alias of sch_clsact
    https://git.kernel.org/netdev/net-next/c/6cff01581789

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



