Return-Path: <bpf+bounces-51518-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD82A355A8
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 05:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44840188B66C
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 04:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B9E158D96;
	Fri, 14 Feb 2025 04:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o/tJ+hDh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F151519AD;
	Fri, 14 Feb 2025 04:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739506803; cv=none; b=VvLjPc1Ggz5RMZiu6wTZZGsB7W+VWyD2Xse9UzfjFqiarlwS9oHVVZEu+u2MKNl2bfoclYg28l/uTmT44CPw6orDKglzlulCopXXYx+hU5Xbcg60Ry7d52jP00Ah2c+bR1sTiQZkwutznAvFe/pajTAh1jRn95dsQMygh7ly8/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739506803; c=relaxed/simple;
	bh=FoPjJkfL7X9Rh7ODzsW+HRh9ATfja8Yk/cPLvx2dtIs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fv1YOOxdctA2kGV5uhSVLEZDM2SG/QobAgm2zXASQWV70daaSzAUnnbYxflYfw/m7wqq6Iq5Eg3E+/m8A9FxKytg6jc1MtwfEhfJVVwevFL5p8MJmm3Zxt2lEVT2ZpIBAe9YIwJ5mSkysjzep+ZtezPy50tBL2LjFnZFaCftwKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o/tJ+hDh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D4DAC4CED1;
	Fri, 14 Feb 2025 04:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739506802;
	bh=FoPjJkfL7X9Rh7ODzsW+HRh9ATfja8Yk/cPLvx2dtIs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=o/tJ+hDhFtpZyaDH6HC5mSDa+owgmlT0EpEGM0UhWbP+oinBSfK/n7gMEH1nk74U+
	 IM5G+lXkQL/oqa5SyVtEbsU8rckwtzRFyeeL+XnrDO0KSOWHEYrmJeaRN/xWwxgonp
	 klaDuNvR17rHbk7ktecX+bqOsWKcFEs++TDR7rGB8Pq1cyOfw6DgtYkqu+v03JbSMA
	 GTQjqctwysMzk7uVfHCPP0ZLIrjXNUD6lpnLB9hNUNNfqSmE6t02Yn0NHblbuJfW8s
	 T6iAfDcuF98UfTkeYZu0whjarcBdghCI/U2iQFIevqcy+KyERR2T1EraITcHO2bu6b
	 gfxUtUkBxscQw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB2A8380CEF8;
	Fri, 14 Feb 2025 04:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4] bpftool: Check map name length when map create
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173950683178.1495644.6163687376224607710.git-patchwork-notify@kernel.org>
Date: Fri, 14 Feb 2025 04:20:31 +0000
References: <tencent_B44B3A95F0D7C2512DC40D831DA1FA2C9907@qq.com>
In-Reply-To: <tencent_B44B3A95F0D7C2512DC40D831DA1FA2C9907@qq.com>
To: Rong Tao <rtoax@foxmail.com>
Cc: andrii@kernel.org, qmo@kernel.org, ast@kernel.org, rongtao@cestc.cn,
 daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 12 Feb 2025 20:45:52 +0800 you wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> The size of struct bpf_map::name is BPF_OBJ_NAME_LEN (16).
> 
> bpf(2) {
>   map_create() {
>     bpf_obj_name_cpy(map->name, attr->map_name, sizeof(attr->map_name));
>   }
> }
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4] bpftool: Check map name length when map create
    https://git.kernel.org/bpf/bpf-next/c/a4585442ade5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



