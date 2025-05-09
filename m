Return-Path: <bpf+bounces-57904-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C280AB1C10
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 20:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A97D1541AC1
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 18:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BC623CEE5;
	Fri,  9 May 2025 18:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FUjpqbbF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A00022B8C5;
	Fri,  9 May 2025 18:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746814193; cv=none; b=rgeN0iMjgh/RX7I4H47QQtrw93rbAwYjTWxxsuoh+/TLMvm8JizG0CAMEeodLbaM7SXPIMgy+Zx3Gs4YSLSHg3KKxhocWAy/H+vibkaNtoAS256wNmFPZgfRirhnhO00FCqcFVRhp/V0bxK6r4Ux/973cWKLRNlxfT+JHUvltLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746814193; c=relaxed/simple;
	bh=fDzciSBzJ9oWWmkY1tCDRVGmRWNKQ+dk5VcIIEfRcrE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SiPfl8JBOvzpTI/vy12TmovcduvGPYssds9M20gucxTMcYYRUd1qJsAjA9pOSe5LIsjTDvU6vx9g2lL+FVHUHStD0j+hUs2cAH05w7BkpSf4PxCv+1cDsdv0VGC6cIWPnnOrvH4694YsDYYmMWkCFFTn1Tf2J7CvYqSxkwyHzT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FUjpqbbF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9905C4CEE4;
	Fri,  9 May 2025 18:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746814192;
	bh=fDzciSBzJ9oWWmkY1tCDRVGmRWNKQ+dk5VcIIEfRcrE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FUjpqbbFRIoJvQnBaU7m8YiPBY1xIyksWKNRGZgUZcguSIQt26qXHv9CrL4xTNlNM
	 qimf/lJAyQje9Qb4sFnVY7mfasY/r+YfjWpWhMMGKcbzetfM8fh2j1e8s7rTHmzxze
	 FW721gDwtwWAn9zfjH+Dweu2ZOVmmPBb1hAtwZ4dnbhc91aK63uZcyNZKKxal7d4BW
	 fheZ+epGzERt7UO8P0PzEDHsQ+IOfgCMSI2T7wqup/si/T+S6iHrrYuAg1YIG6f6xC
	 DqkiHNTlD3MVgEoynWTpqmMb1OdP24alrdUwHhx++KoeQ+WM7f1AHpIGx+uNw13vR7
	 rPmu9BcAw2BCg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F09380DBCB;
	Fri,  9 May 2025 18:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 bpf-next 0/2] bpf: Allow some trace helpers for all prog
 types
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174681423125.3706849.17756143734628096783.git-patchwork-notify@kernel.org>
Date: Fri, 09 May 2025 18:10:31 +0000
References: <20250506061434.94277-1-yangfeng59949@163.com>
In-Reply-To: <20250506061434.94277-1-yangfeng59949@163.com>
To: Feng Yang <yangfeng59949@163.com>
Cc: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 mattbobrowski@google.com, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, davem@davemloft.net, tj@kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue,  6 May 2025 14:14:32 +0800 you wrote:
> From: Feng Yang <yangfeng@kylinos.cn>
> 
> This series allow some trace helpers for all prog types.
> 
> if it works under NMI and doesn't use any context-dependent things,
> should be fine for any program type. The detailed discussion is in [1].
> 
> [...]

Here is the summary with links:
  - [v3,bpf-next,1/2] bpf: Allow some trace helpers for all prog types
    https://git.kernel.org/bpf/bpf-next/c/ee971630f20f
  - [v3,sched_ext,2/2] sched_ext: Remove bpf_scx_get_func_proto
    https://git.kernel.org/bpf/bpf-next/c/8c112a428b94

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



