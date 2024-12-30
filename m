Return-Path: <bpf+bounces-47714-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 961A29FEB87
	for <lists+bpf@lfdr.de>; Tue, 31 Dec 2024 00:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BEFB3A2921
	for <lists+bpf@lfdr.de>; Mon, 30 Dec 2024 23:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FC619EED3;
	Mon, 30 Dec 2024 23:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JpI+l+eO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B129319D070
	for <bpf@vger.kernel.org>; Mon, 30 Dec 2024 23:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735599614; cv=none; b=Lrl+xFnNVq10kopmugpwQJBBkts9tHdL7egBcLHfUZdflmmvuYNV/ma1eW6IVMw0/XI5ma8bGv2e0bxmVgydPFdZJHCgP4/CLCSBrjDv5+PFAkpGnwKMM9tmlg3m/OVLwk/luUXkTcWz2ZpGd3q3einSkGag17tvwOcr0um7Kes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735599614; c=relaxed/simple;
	bh=8P7Jzxs6D9r7h8cTGReSs7ZygylmhHgCA0TeH+CwbNc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=c1uP7X2lt/l1BdrieamesmeuTrPaSyne9rKiDH+0jHX/+pQ/IFkIlLkYq5Ez9v2I1x4c73CL1CmknbhKptdpEfgn8Xgwp3WWc3qFRzVRbumBe04X73a7cvVnX/dPWA+YZPJYDF+GgbnTOG8O/TiWP6fiYxgWu7niG1MbgPoCT4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JpI+l+eO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB88C4CEDE;
	Mon, 30 Dec 2024 23:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735599614;
	bh=8P7Jzxs6D9r7h8cTGReSs7ZygylmhHgCA0TeH+CwbNc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JpI+l+eO9IHZz1lCkPKzCd3tCm0ZZWUpq72asOwre1iqMjuTWsvec12VsgT6dOlyN
	 JlIdnrAmfXmKVjPChLpz2m0JeUCr3e0grT/p8QgIlDsnrVz5DqHjUT+ZbiuCxdN057
	 oNH4dcNM6/L9CV6jE4q6dr6MeiSCT/I+2nLtlqUXFZkwGHsBBbPP2vQLOpj1LMM2Df
	 My+JoXfXfMTfJ6/qDT7xvp2iGAnNZxXxKTyk/servmntjiHy9WBuXIKQlhkNcdHCAw
	 TWf0Ro1WFBocnDXnRurWESa0BDkH1QeukjR6YWz1DkL5thCucupJduEduLHl5YEqqA
	 BRUYOCURv3vdQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C8D380A964;
	Mon, 30 Dec 2024 23:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: fix veristat comp mode with new stats
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173559963401.1460841.1791648471313982173.git-patchwork-notify@kernel.org>
Date: Mon, 30 Dec 2024 23:00:34 +0000
References: <20241220152218.28405-1-mahe.tardy@gmail.com>
In-Reply-To: <20241220152218.28405-1-mahe.tardy@gmail.com>
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, mykyta.yatsenko5@gmail.com,
 yatsenko@meta.com, daniel@iogearbox.net, john.fastabend@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 20 Dec 2024 15:22:18 +0000 you wrote:
> Commit 82c1f13de315 ("selftests/bpf: Add more stats into veristat")
> introduced new stats, added by default in the CSV output, that were not
> added to parse_stat_value, used in parse_stats_csv which is used in
> comparison mode. Thus it broke comparison mode altogether making it fail
> with "Unrecognized stat #7" and EINVAL.
> 
> One quirk is that PROG_TYPE and ATTACH_TYPE have been transformed to
> strings using libbpf_bpf_prog_type_str and libbpf_bpf_attach_type_str
> respectively. Since we might not want to compare those string values, we
> just skip the parsing in this patch. We might want to translate it back
> to the enum value or compare the string value directly.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: fix veristat comp mode with new stats
    https://git.kernel.org/bpf/bpf-next/c/9468f39ba478

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



