Return-Path: <bpf+bounces-16947-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 153C8807BAB
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 23:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3E192824A8
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 22:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D30199D2;
	Wed,  6 Dec 2023 22:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+4HilAy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A87A70997
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 22:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0B23FC433C9;
	Wed,  6 Dec 2023 22:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701903024;
	bh=mqY/yBUnt8hpOJvmMWvkIqBo6BxKSQUWEtHva3xIg8g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=D+4HilAyatIw/a3hM/yzAYWwSMdWbXV6oTCUyY7GBEDfIZeyHcuFx/vmHz7/Z+6ts
	 Fv7+vivV8aWlntxDLrNst236oX6HZXWP4xczQ4z2rj5zyLIkNt5rZKVS1wWzieyF/4
	 dO3pe6YstvfqlQVGFOe9dpAHkoURP2d5PL9v5TL4zFhfy7boG4ULXy10Q907V1UdYh
	 XYwZe5n+ou1YOYkyHwRoXb0AcllZ5+HAmT0XqEc+B+V1QC4Be4ovmOFPutJhXg0Dlr
	 dhI0MiNEhvOlHc+NiZrToDZDweTaauA72npv0hI175oaxD9ZcHbAAIuF+tL1y/FRyi
	 pceJPAdy+NpMw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E5FD9C395DC;
	Wed,  6 Dec 2023 22:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: rename MAX_BPF_LINK_TYPE into
 __MAX_BPF_LINK_TYPE for consistency
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170190302393.7430.15697165786318986369.git-patchwork-notify@kernel.org>
Date: Wed, 06 Dec 2023 22:50:23 +0000
References: <20231206190920.1651226-1-andrii@kernel.org>
In-Reply-To: <20231206190920.1651226-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 6 Dec 2023 11:09:20 -0800 you wrote:
> To stay consistent with the naming pattern used for similar cases in BPF
> UAPI (__MAX_BPF_ATTACH_TYPE, etc), rename MAX_BPF_LINK_TYPE into
> __MAX_BPF_LINK_TYPE.
> 
> Also similar to MAX_BPF_ATTACH_TYPE and MAX_BPF_REG, add:
> 
>   #define MAX_BPF_LINK_TYPE __MAX_BPF_LINK_TYPE
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: rename MAX_BPF_LINK_TYPE into __MAX_BPF_LINK_TYPE for consistency
    https://git.kernel.org/bpf/bpf-next/c/7065eefb38f1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



