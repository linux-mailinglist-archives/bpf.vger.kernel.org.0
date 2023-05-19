Return-Path: <bpf+bounces-968-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D18B9709D91
	for <lists+bpf@lfdr.de>; Fri, 19 May 2023 19:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 979A6281D48
	for <lists+bpf@lfdr.de>; Fri, 19 May 2023 17:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D84125D0;
	Fri, 19 May 2023 17:10:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4387E10942
	for <bpf@vger.kernel.org>; Fri, 19 May 2023 17:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0FC03C4339B;
	Fri, 19 May 2023 17:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684516221;
	bh=8PZXCQoBjEiSR5OAucQjzOdg5gSTtWLdfKXW8fEtmPM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WpU1/SIt0zW1YnW1ZRcnl9RYDlYwlC4kXcPk6hT41S4MFt3XLYthOdjEHfHgZXIlI
	 snw+9frTAivXIvPVHTlqAEsdxYvKvWi0tOzK9sebJUKwP3a365AN5qdmDCTmOTU+5r
	 5vtaADOuV7AQkxM49H+ysihtfvh/DrWe5OO8RuQCynWBhx6oBRqu0OQ144GokVQyqM
	 lsxbLVxpP7P8HA5E4HStm+C35/GTAuaduRPRhuTYgh3o0ZE2oCRiH763Dr1fSDjOf9
	 JrELw5uFqaHe8JeaQJFNAKq1XJ5hmwplEvNkyC0N1RpvIWTxzexnrvzSukjKn0EWAh
	 E6tuIaot0OD5A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E84A2E21ED3;
	Fri, 19 May 2023 17:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/2] bpf: Show target_{obj,btf}_id for tracing
 link
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168451622094.12348.14815375169290598503.git-patchwork-notify@kernel.org>
Date: Fri, 19 May 2023 17:10:20 +0000
References: <20230517103126.68372-1-laoar.shao@gmail.com>
In-Reply-To: <20230517103126.68372-1-laoar.shao@gmail.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: quentin@isovalent.com, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 17 May 2023 10:31:24 +0000 you wrote:
> The target_btf_id can help us understand which kernel function is
> linked by a tracing prog. The target_btf_id and target_obj_id have
> already been exposed to userspace, so we just need to show them.
> 
> For some other link types like perf_event and kprobe_multi, it is not
> easy to find which functions are attached either. We may support
> ->fill_link_info for them in the future.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] bpf: Show target_{obj,btf}_id in tracing link fdinfo
    https://git.kernel.org/bpf/bpf-next/c/e859e429511a
  - [bpf-next,v2,2/2] bpftool: Show target_{obj,btf}_id in tracing link info
    https://git.kernel.org/bpf/bpf-next/c/d7e45eb4802b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



