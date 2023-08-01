Return-Path: <bpf+bounces-6600-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C6476BBDB
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 20:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 947172819A9
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 18:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC34235A8;
	Tue,  1 Aug 2023 18:00:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACEC22EF0
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 18:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 15F1BC433C9;
	Tue,  1 Aug 2023 18:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690912822;
	bh=u9FpdArcNk/F1Q+Oz6t+YUcdlcWvmLPwbTPeX9a6olg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kguER79h8yvEPD5C3XSVXjBazf5QMjcgHnLtZmwN3s+ozOqI7VuvoUayKWHFtIoJ4
	 A1ocVoaM/QPXFLBtNoI9T6kaZy9Li7qgQ5Puta/Poa+r4F6wUy2NaKHjU9icqBvylV
	 lPOCZK26SxE0/LWljfvfqUKRNVpw3juNMic0AHJyizPf2yWTF1tfYSxLg98Q52+KU7
	 TRPFPs90CTD961htAw/2u69EW0PZKXx2o2YSBrfzTH6lzi/LYLXD3zVhdDbb2ddsD4
	 ggPw+Ldm7b2FX/eGoYltoskYlqxMe23cGwsgsdjbExCXYa1lb71TwYkgUQ3/zycU43
	 EI2BqIAxVM5yQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DB8B9C691E4;
	Tue,  1 Aug 2023 18:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] tracing: perf_call_bpf: use struct trace_entry in
 struct syscall_tp_t
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169091282189.14438.17356882361712917762.git-patchwork-notify@kernel.org>
Date: Tue, 01 Aug 2023 18:00:21 +0000
References: <20230801075222.7717-1-ykaliuta@redhat.com>
In-Reply-To: <20230801075222.7717-1-ykaliuta@redhat.com>
To: Yauheni Kaliuta <ykaliuta@redhat.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
 yonghong.song@linux.dev

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  1 Aug 2023 10:52:22 +0300 you wrote:
> bpf tracepoint program uses struct trace_event_raw_sys_enter as
> argument where trace_entry is the first field. Use the same instead
> of unsigned long long since if it's amended (for example by RT
> patch) it accesses data with wrong offset.
> 
> Signed-off-by: Yauheni Kaliuta <ykaliuta@redhat.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] tracing: perf_call_bpf: use struct trace_entry in struct syscall_tp_t
    https://git.kernel.org/bpf/bpf-next/c/d3c4db86c711

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



