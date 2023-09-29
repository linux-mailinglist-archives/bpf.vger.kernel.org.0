Return-Path: <bpf+bounces-11144-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C44C67B3CC4
	for <lists+bpf@lfdr.de>; Sat, 30 Sep 2023 00:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 1DC502827AC
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 22:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83846521B1;
	Fri, 29 Sep 2023 22:50:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E359347C1
	for <bpf@vger.kernel.org>; Fri, 29 Sep 2023 22:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 77DBEC433C8;
	Fri, 29 Sep 2023 22:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696027824;
	bh=NB+z5hXG04Qy3fH/L/xBbjOzdqPER4YO3hLsXzxCN2Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EAsqPjHntlAPMsSXp16oveeEEUos7KzVVJQdWXLOsCpp5eFyzwymF4w+0yzBeOihc
	 OWgAtHTehra+4ShToC+KBl//8zmnyqt/DOpAL8BDVq8vWUxPBmL9UqUWgMQT6IcvAU
	 ravs+FJ+0d7D396KUqqw5EkcAZVErtek7D8r21BFCNwDN00Rmbv+qiNAhEOlxOlPOD
	 B4DM/+PAyklxacnm1HTFXO5f/8SGwjuut+F0lbZmMXB4/MnKqcvZvMMCecPyhzTITG
	 WL5h0ifX2D6rJN0wMH3atXJOy+InAgkDHd2nP7VeblpGHf69EhrYftP695SEaiykUa
	 VsefzZAtG32TA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5BF05C395C8;
	Fri, 29 Sep 2023 22:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] libbpf: Allow Golang symbols in uprobe secdef
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169602782436.32717.11851217001971719983.git-patchwork-notify@kernel.org>
Date: Fri, 29 Sep 2023 22:50:24 +0000
References: <20230929155954.92448-1-hengqi.chen@gmail.com>
In-Reply-To: <20230929155954.92448-1-hengqi.chen@gmail.com>
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, olsajiri@gmail.com, acme@redhat.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 29 Sep 2023 15:59:54 +0000 you wrote:
> Golang symbols in ELF files are different from C/C++
> which contains special characters like '*', '(' and ')'.
> With generics, things get more complicated, there are
> symbols like:
> 
>   github.com/cilium/ebpf/internal.(*Deque[go.shape.interface { Format(fm
>   t.State, int32); TypeName() string;github.com/cilium/ebpf/btf.copy() g
>   ithub.com/cilium/ebpf/btf.Type}]).Grow
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] libbpf: Allow Golang symbols in uprobe secdef
    https://git.kernel.org/bpf/bpf-next/c/2147c8d07e1a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



