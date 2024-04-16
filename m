Return-Path: <bpf+bounces-26991-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A118A70C8
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 18:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 716FF1C219B9
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 16:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616E9132C15;
	Tue, 16 Apr 2024 16:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MxmAKEAJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74EF131726
	for <bpf@vger.kernel.org>; Tue, 16 Apr 2024 16:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713283228; cv=none; b=hqA9OJVNKzmRSdkU5edqyQby5WRH/3igemro0EbABY2AbozK/e5z5ZiQDl/lqTi0EMx58v9LFX51hDCWu+vbgUHKLZP/+xcK/zcmQCA/XzKfND1yJ92KCUAuBuk4VaeSb0kWh7irO6LiRtitfDHyGoITHlBH/JFPrwCXATF44OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713283228; c=relaxed/simple;
	bh=6asgZ2K+BR03i2EP0rTEqwdJFd/BLeEfpX+kcY31enU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZFZzT4U5odRMi/ZKyn1ngD2shUP29tqQg7jbiOBBaAErmIHnsADBpbokiz4C2l3lHqVGWKSEEI8pJrr1SRokDpZJaDRMXxZ1wWDsM9KcFLgO0qfGdB2aaPed8rqAVMp0rps2Do/NNUVNWY0rZug5F7QDJ/3LVlR7JQuwtxBWzfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MxmAKEAJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5B972C2BD10;
	Tue, 16 Apr 2024 16:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713283228;
	bh=6asgZ2K+BR03i2EP0rTEqwdJFd/BLeEfpX+kcY31enU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MxmAKEAJSxtT7bxziN2bWCBJUhLTsKXfVWYySyLWug1RqmJW0H4c5sVhoMAJS7owz
	 hibTPuoRe4J8e7noEwpBlkvV65oTwz8XKlxLJXIo4IGsz28VH6L2pjMqJZDWq0Vckb
	 qPhhoZYBmQJyvsXS6HzNPp8C6hRNwzWrBq6gB1vKZ8go2FL/tHqBL0OEwzrB/A2FmZ
	 1mz8V04LE8gp0km3LaZzmLsgVxzs3gBxGRDI9kAmrLkIRcZrDYyQKnq4BOvW21P9oh
	 bQz57rgWlqt0dFwYIFJdHKjgVGAI3pI6bByG0ZGi4Pd9QiQkocDDMR7Q7Bo1BGkiJo
	 EVaWNryLts/8A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4B44AD4F15E;
	Tue, 16 Apr 2024 16:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/2] bpftool: Small fixes for documentation and bash
 completion
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171328322830.16684.12990677131123060007.git-patchwork-notify@kernel.org>
Date: Tue, 16 Apr 2024 16:00:28 +0000
References: <20240413011427.14402-1-qmo@kernel.org>
In-Reply-To: <20240413011427.14402-1-qmo@kernel.org>
To: Quentin Monnet <qmo@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Sat, 13 Apr 2024 02:14:25 +0100 you wrote:
> This small series contains two sets of fixes/clean-ups for bpftool's
> documentation and bash completion, respectively.
> 
> Quentin Monnet (2):
>   bpftool: Update documentation where progs/maps can be passed by name
>   bpftool: Address minor issues in bash completion
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpftool: Update documentation where progs/maps can be passed by name
    https://git.kernel.org/bpf/bpf-next/c/986e7663f98e
  - [bpf-next,2/2] bpftool: Address minor issues in bash completion
    https://git.kernel.org/bpf/bpf-next/c/ad2d22b617b7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



