Return-Path: <bpf+bounces-4651-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F5574E17F
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 00:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FC5A280FC1
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 22:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FADF1642D;
	Mon, 10 Jul 2023 22:40:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3611E156E2
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 22:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 87EC1C433C9;
	Mon, 10 Jul 2023 22:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689028822;
	bh=0SWVlyJ8I/uaKuvgERrbFcCJsdMSx4WPfxHvZLNygjY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=D7qy5rxA84G+IrArIO6sorb7X/XnB9qC+VgIqTw7cdVwqsa0d30LFEg+9QB7C2axS
	 yWvmn8o7f7l8bx5MYQ/BliTBht/W2k/k50hn0C4M3m4peTTAhznX8Gehswx34olwAa
	 097TCrykVcnRKlIG8Ef7MKqud72GIYaWVlOpPO1C0cuEjsZN4m3fVBz75+94fc3ksT
	 +vgPLySmr3NJ3DD9cpxCz64iiJVJQcxtS1KmMcJhgbzmg4LS6AIKqx16qHcvPfllUA
	 nyQfn2/D5UPRo4uBmn1gv2FW4lRp44MLRmAiXe7jcjMeOdwo+KhgcmlBHRW8iYr1Xa
	 g2CuUDsflnGdQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 67DDAC0C40E;
	Mon, 10 Jul 2023 22:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/4] bpftool: Fix skeletons compilation for older
 kernels
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168902882242.25605.6497606191994518025.git-patchwork-notify@kernel.org>
Date: Mon, 10 Jul 2023 22:40:22 +0000
References: <20230707095425.168126-1-quentin@isovalent.com>
In-Reply-To: <20230707095425.168126-1-quentin@isovalent.com>
To: Quentin Monnet <quentin@isovalent.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 bpf@vger.kernel.org, aleksander.lobakin@intel.com, msuchanek@suse.de

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri,  7 Jul 2023 10:54:21 +0100 you wrote:
> At runtime, bpftool may run its own BPF programs to get the pids of
> processes referencing BPF programs, or to profile programs. The skeletons
> for these programs rely on a vmlinux.h header and may fail to compile when
> building bpftool on hosts running older kernels, where some structs or
> enums are not defined. In this set, we address this issue by using local
> definitions for struct perf_event, struct bpf_perf_link,
> BPF_LINK_TYPE_PERF_EVENT (pids.bpf.c) and struct bpf_perf_event_value
> (profiler.bpf.c).
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/4] bpftool: use a local copy of perf_event to fix accessing ::bpf_cookie
    https://git.kernel.org/bpf/bpf-next/c/4cbeeb0dc02f
  - [bpf-next,v2,2/4] bpftool: define a local bpf_perf_link to fix accessing its fields
    https://git.kernel.org/bpf/bpf-next/c/67a43462ee24
  - [bpf-next,v2,3/4] bpftool: Use a local copy of BPF_LINK_TYPE_PERF_EVENT in pid_iter.bpf.c
    https://git.kernel.org/bpf/bpf-next/c/44ba7b30e84f
  - [bpf-next,v2,4/4] bpftool: use a local bpf_perf_event_value to fix accessing its fields
    https://git.kernel.org/bpf/bpf-next/c/658ac0680131

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



