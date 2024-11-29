Return-Path: <bpf+bounces-45887-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A006F9DEC6B
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 20:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61B4F281F07
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 19:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05FB1A256F;
	Fri, 29 Nov 2024 19:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P75pgmhw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F8C2C18C;
	Fri, 29 Nov 2024 19:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732908619; cv=none; b=llKjpX0StUQPH9gq2HguTHjx1rtgoFlqHMBIRcHO639dd6EH7mnfwDIcZZ8pGp/TJ6LrgUBKI/KpZGbwNs3KMvYoWuh5XDWydHSmjgCLXNtm+utXtahA1t9ECTG/IHWP5v9wBAwAPieS5YUGJRGzNqVcqN0Pw0gZoZ0Ipf0Ow58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732908619; c=relaxed/simple;
	bh=GesLReKmG/lbnI9/AeCxcZlM2HY6mKQ9eV48XapF0hI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TZ05LXLEBH5jNUVLnRHT8XWYE4NLXgchAn1E5HO5I/Bhv5QHtpZPWDY/YVZyKa0ubxTcBxpvcuSUscIiS1RK006W4vU0q9y0rnpn64HyPIz+ff8v1vWERZVMzAy/dayNBi9s23+1G3ZNjiY6+yEzh8xk/9Dy1RlZFzDiFcOYsUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P75pgmhw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C643FC4CECF;
	Fri, 29 Nov 2024 19:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732908618;
	bh=GesLReKmG/lbnI9/AeCxcZlM2HY6mKQ9eV48XapF0hI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P75pgmhwNY0q9EMFDstp15rZUsK8a3Flb+UtR+YaeDRTSY4Tv3lWXAmovjSFHpK6w
	 a5Cp3pV/l37Uu0TTXTG/EqtFXA13tkQU0VeLxdQ/mQyJ2vvOiYPn6FyyK2Ino8YwPi
	 D716d09ABO0MuywEBys+iER/an5NuowMP2Rk3bZaGApDYVwcHg3/6IzGnXRRZSAUFG
	 8+XBAp2ITWlqaTm4sZCoJ7T5HVsFGovmpbZuzNggxgwYLFpDUOhMfhsl8lLkZ07VtA
	 sNMuIaYhBMTVlJhKzPRxrwIx+m6mRg0EfRApkTXWKi8GqO2Zs7pDegXTcktIfGy46h
	 9hNqQWrXY1Fng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71473380A944;
	Fri, 29 Nov 2024 19:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 1/2] bpf: Remove bpf_probe_write_user() warning
 message
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173290863205.2157309.298524188267518158.git-patchwork-notify@kernel.org>
Date: Fri, 29 Nov 2024 19:30:32 +0000
References: <20241129090040.2690691-1-elver@google.com>
In-Reply-To: <20241129090040.2690691-1-elver@google.com>
To: Marco Elver <elver@google.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 nikola.grcevski@grafana.com, bpf@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 29 Nov 2024 09:59:33 +0100 you wrote:
> The warning message for bpf_probe_write_user() was introduced in
> 96ae52279594 ("bpf: Add bpf_probe_write_user BPF helper to be called in
> tracers"), with the following in the commit message:
> 
>     Given this feature is meant for experiments, and it has a risk of
>     crashing the system, and running programs, we print a warning on
>     when a proglet that attempts to use this helper is installed,
>     along with the pid and process name.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/2] bpf: Remove bpf_probe_write_user() warning message
    https://git.kernel.org/bpf/bpf-next/c/3389f8243a90
  - [bpf-next,v4,2/2] bpf: Refactor bpf_tracing_func_proto() and remove bpf_get_probe_write_proto()
    https://git.kernel.org/bpf/bpf-next/c/45e04eb4d9d8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



