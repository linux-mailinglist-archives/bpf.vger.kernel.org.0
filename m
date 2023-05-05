Return-Path: <bpf+bounces-125-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 217D56F8600
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 17:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BDA71C218E2
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 15:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F957C2C8;
	Fri,  5 May 2023 15:40:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58CE5383
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 15:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81BDAC433EF;
	Fri,  5 May 2023 15:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683301220;
	bh=roYzDCp8m5ofIL5OVs+nweqi4LgU1eara4cVhEEpOH0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TQOg7q9/+MNT4Ki/l9aF9yOZLqKQFjttO+0BolRlrBGw3SUhaxo2IwIqXUntXx4j5
	 Lw1WasiGvgUZVi/B/W6CmSnTVhxJZosmIF9aKyAMwlT2bQaMMnL0p9Bb9y2hiY4HMb
	 d2+sbIgrvl0Y13qYaYKVrdWhlrMRzEOe1e59ZtyohXd+gHPJncxZyPG1dXM/sEPDaI
	 N3CqBxheKCO/fHzkKjSZGvJzVYchdbG5tDAOUeXMhVc3sXEHG2WdmV8po0G2Udu4KQ
	 9AndICBzGTnsVoB3igzPoXBXwxjfltjAYbqm6xsRzTAuxPdrvLjRyKqRtrC3DBrQF3
	 Z3cUuL6Pld67g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 64FC0C73FF3;
	Fri,  5 May 2023 15:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] samples/bpf: Fix buffer overflow in tcp_basertt
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168330122040.23709.16592214516733472619.git-patchwork-notify@kernel.org>
Date: Fri, 05 May 2023 15:40:20 +0000
References: <1683276658-2860-1-git-send-email-yangpc@wangsu.com>
In-Reply-To: <1683276658-2860-1-git-send-email-yangpc@wangsu.com>
To: Pengcheng Yang <yangpc@wangsu.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, song@kernel.org,
 yhs@fb.com, brakmo@fb.com, bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  5 May 2023 16:50:58 +0800 you wrote:
> Using sizeof(nv) or strlen(nv)+1 is correct.
> 
> Fixes: c890063e4404 ("bpf: sample BPF_SOCKET_OPS_BASE_RTT program")
> Signed-off-by: Pengcheng Yang <yangpc@wangsu.com>
> ---
>  samples/bpf/tcp_basertt_kern.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [bpf] samples/bpf: Fix buffer overflow in tcp_basertt
    https://git.kernel.org/bpf/bpf-next/c/f4dea9689c5f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



