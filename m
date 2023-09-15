Return-Path: <bpf+bounces-10180-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B9A7A2717
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 21:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5520B1C20948
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 19:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E935A19BCB;
	Fri, 15 Sep 2023 19:20:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF53830CE6
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 19:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 07966C433C9;
	Fri, 15 Sep 2023 19:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694805625;
	bh=Nya/vGEpGacZXI0PKtqiUcoJHMn8ulwkFADTobpKNE8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JJ8K1EvVKO7py2rFAyOp+hElydv7eoeM8xCDkvWUO7Wr/+ZkmFfM1pHXxLgJvaZUp
	 wUt4AmYhSIfo0yl8q4z0XtjddA2C3v1BzBufuJ/w+DuiALUTQ/2Lzv1XjTXzrwWnaq
	 R7eRqjkw7dFBKlBl2E71u/TH7CndzY5SdU1TMwhDXtQfYoT90s/LFCqQUy62EiSwhA
	 lLxylV7qUFbMb9IcTrLj6vqzyr10tqLMP4nwbd/Ya/imzIAd9SKy5SzU5i7c4558qU
	 89G03hld8uo1BMQs03l9/EiM8sV0X3yjs+sgLpcoTOMZLXtsSzdNV0NjVt/7qvZSLI
	 WyITE3lkPHaoA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DB6AAE22AF2;
	Fri, 15 Sep 2023 19:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v3 0/2] link to v1:
 https://lore.kernel.org/bpf/20230915103228.1196234-1-jolsa@kernel.org/
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169480562489.6917.8701447661026303948.git-patchwork-notify@kernel.org>
Date: Fri, 15 Sep 2023 19:20:24 +0000
References: <20230915-bpf_collision-v3-0-263fc519c21f@google.com>
In-Reply-To: <20230915-bpf_collision-v3-0-263fc519c21f@google.com>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, jolsa@kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@chromium.org, sdf@google.com,
 haoluo@google.com, stable@vger.kernel.org, quic_satyap@quicinc.com,
 m.seyfarth@gmail.com, nathan@kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 15 Sep 2023 10:34:26 -0700 you wrote:
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
> Changes in v3:
> - combine v1 and v2 into a series; I didn't recognize that this macro
>   appeared twice in the kernel sources.
> - Use __PASTE twice.
> - Link to v2: https://lore.kernel.org/r/20230915-bpf_collision-v2-1-027670d38bdf@google.com
> 
> [...]

Here is the summary with links:
  - [bpf,v3,1/2] bpf: Fix BTF_ID symbol generation collision
    https://git.kernel.org/bpf/bpf/c/8f908db77782
  - [bpf,v3,2/2] bpf: Fix BTF_ID symbol generation collision in tools/
    https://git.kernel.org/bpf/bpf/c/c0bb9fb0e52a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



