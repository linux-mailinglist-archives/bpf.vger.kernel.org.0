Return-Path: <bpf+bounces-28278-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0578B7E8C
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 19:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 655991F235FF
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 17:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656621802DC;
	Tue, 30 Apr 2024 17:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6ABGM4l"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E423717F39A
	for <bpf@vger.kernel.org>; Tue, 30 Apr 2024 17:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714498232; cv=none; b=SXcEi+ikNCx0gMnfxb2xnNksCOjnY1Q5/ULDn72pkMLpCTpAxkSES65GkIpVZr0lTybCl0G8h2s2tw9GoHTOY1zboaVsPcJyDW1SLZmV8vLEOR3IiATfJDz+9UZsM9vUssbL8zEsR5rgu1P9ckVYwQ21UjUeRRORG+b2Aht8/oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714498232; c=relaxed/simple;
	bh=vITD6W09HNrteVz3I6HOsZzJ9P1HoTS7jMpQApkeQHk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Mg3tO3/wTj4vmcphiYdS4NHSg57ukqy949a5nJVbpuQmD1CD/D7Pe3D1j7UaVTGXLFD6ZWHorUtGQNivfzF3HdSwy0w1ySCWODS2usnc9QQNoEZH7lKLKZ9z+vxwFXKZhjRQj9jghsxxfVdfIKA6xrMZlvd+UT1quWMDwwtfRVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6ABGM4l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 75CA1C4AF17;
	Tue, 30 Apr 2024 17:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714498231;
	bh=vITD6W09HNrteVz3I6HOsZzJ9P1HoTS7jMpQApkeQHk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=H6ABGM4lGfcxP/57H6AhiMofJ+RNQEnojC3j0d2A2Mq09AlRg1Vme+FbWTv31en/3
	 ZhKVwu8Ap0qTDfLIE89IUjknuaWv03DT/nMqJIpUL+92E9Gt8XqKvW0Hu6sUVpiRdd
	 ntaKL5xOZiNjSXuTaQlpRa5r3ZHOoAL2SxiWV9yK+5iEWtmxo4iDuXikpiacgIAvIp
	 GmyUL9HM6NIey6K1pbcbMqdgU+hJRW0yOk6micPOeSLFeQtGVLGzYjaqXxJkLc4r0x
	 2AXN3xP8j5b9kwxQ/9r81nZiPp5cB6dY5HpxfOJQa6ajAGD5SaT9w0nGqMMRsTdXYP
	 Gg+cn8PKhSLNg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5FE3EC43616;
	Tue, 30 Apr 2024 17:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2 bpf-next 0/7] bpf: Introduce kprobe_multi session attach
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171449823138.11903.15103682425771878061.git-patchwork-notify@kernel.org>
Date: Tue, 30 Apr 2024 17:30:31 +0000
References: <20240430112830.1184228-1-jolsa@kernel.org>
In-Reply-To: <20240430112830.1184228-1-jolsa@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@chromium.org, sdf@google.com,
 haoluo@google.com, vmalik@redhat.com, mhiramat@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 30 Apr 2024 13:28:23 +0200 you wrote:
> hi,
> adding support to attach kprobe program through kprobe_multi link
> in a session mode, which means:
>   - program is attached to both function entry and return
>   - entry program can decided if the return program gets executed
>   - entry program can share u64 cookie value with return program
> 
> [...]

Here is the summary with links:
  - [PATCHv2,bpf-next,1/7] bpf: Add support for kprobe session attach
    https://git.kernel.org/bpf/bpf-next/c/535a3692ba72
  - [PATCHv2,bpf-next,2/7] bpf: Add support for kprobe session context
    https://git.kernel.org/bpf/bpf-next/c/adf46d88ae4b
  - [PATCHv2,bpf-next,3/7] bpf: Add support for kprobe session cookie
    https://git.kernel.org/bpf/bpf-next/c/5c919acef851
  - [PATCHv2,bpf-next,4/7] libbpf: Add support for kprobe session attach
    https://git.kernel.org/bpf/bpf-next/c/2ca178f02b2f
  - [PATCHv2,bpf-next,5/7] libbpf: Add kprobe session attach type name to attach_type_name
    https://git.kernel.org/bpf/bpf-next/c/7b94965429f2
  - [PATCHv2,bpf-next,6/7] selftests/bpf: Add kprobe session test
    https://git.kernel.org/bpf/bpf-next/c/0983b1697aef
  - [PATCHv2,bpf-next,7/7] selftests/bpf: Add kprobe session cookie test
    https://git.kernel.org/bpf/bpf-next/c/a3a5113393cc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



