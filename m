Return-Path: <bpf+bounces-74532-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C846C5EB46
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 19:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2678C3C643C
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 17:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2FE28A704;
	Fri, 14 Nov 2025 17:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7adpCz5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4C632A3D8;
	Fri, 14 Nov 2025 17:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763140350; cv=none; b=oZ8IxxsePAxiQ+x8Vd807lFFObkD1BA0glX8/ddymAqEPRBKVN18HmyxCGhQPe6MM9yDibmw8Dr42vyjxfjX/7VDGPqvJ2X06JHa3qa0lqtAjH3JQNcrOcxvJ4WFnhdFT5NaZ9VBirAkjE1dOCN4mQqj2q7GIVB9CbPy79ZpmEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763140350; c=relaxed/simple;
	bh=9ITbYM0wOomqZyJzEoKV5L4gvbymEyxm24AJEqTWAMQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=E8Hh2UjgBhp2bS3HnDrZhgAOqOZfnsiRXDGzj60wtuEetdL93qCO0uomrwgC9NRUzbFHybCkZPY1XFOH58fDFjze2iQZyVmWRmbXfHiHatvbMt8LTvE8C4psPwDVZ6Gcj10FXBNBp/XP9znEDdVjgQRRaQ9sj/J4gucK9T0ry1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c7adpCz5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5072C4CEFB;
	Fri, 14 Nov 2025 17:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763140349;
	bh=9ITbYM0wOomqZyJzEoKV5L4gvbymEyxm24AJEqTWAMQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=c7adpCz5ELKvyvMGDuIxWhiuep6KvY/OKRt+c/AQ1l2r2z85hLHBEPGjtEKEuIe1I
	 LYuVEn6VqKxP4/epuCWDDM4+XkA2NryN6GU4ThA36fgIG6X3clagX+4l9aRmKQVf7d
	 wVI+YjxO+thx7cLpVzXL7yXja8mcpUrdt6foz4I+ADamHXsoGNhwt3GFz64u+jr/2H
	 VrSdgYBtCV0kfjaIdFqWavVTCyHs3NjLT5wR3gL4jmxXwH7PfqY+qCfN0N+vcjizRQ
	 pzNhjxgDt/4ucG5uBqJzNc/CYfTYf959CxBI4qjPe78T8ud8wH9kxbAQPCk6YbyAoc
	 fxbXkd51/7LoQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E763A7859C;
	Fri, 14 Nov 2025 17:11:59 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net/bpf] bpf: add bpf_prog_run_data_pointers()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176314031800.1740925.6385057833740804551.git-patchwork-notify@kernel.org>
Date: Fri, 14 Nov 2025 17:11:58 +0000
References: <20251112125516.1563021-1-edumazet@google.com>
In-Reply-To: <20251112125516.1563021-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, bpf@vger.kernel.org, horms@kernel.org,
 jhs@mojatatu.com, victor@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, toke@redhat.com, eric.dumazet@gmail.com,
 syzkaller@googlegroups.com, paulb@nvidia.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Wed, 12 Nov 2025 12:55:16 +0000 you wrote:
> syzbot found that cls_bpf_classify() is able to change
> tc_skb_cb(skb)->drop_reason triggering a warning in sk_skb_reason_drop().
> 
> WARNING: CPU: 0 PID: 5965 at net/core/skbuff.c:1192 __sk_skb_reason_drop net/core/skbuff.c:1189 [inline]
> WARNING: CPU: 0 PID: 5965 at net/core/skbuff.c:1192 sk_skb_reason_drop+0x76/0x170 net/core/skbuff.c:1214
> 
> struct tc_skb_cb has been added in commit ec624fe740b4 ("net/sched:
> Extend qdisc control block with tc control block"), which added a wrong
> interaction with db58ba459202 ("bpf: wire in data and data_end for
> cls_act_bpf").
> 
> [...]

Here is the summary with links:
  - [net/bpf] bpf: add bpf_prog_run_data_pointers()
    https://git.kernel.org/bpf/bpf/c/4ef927436258

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



