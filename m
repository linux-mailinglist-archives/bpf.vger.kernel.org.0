Return-Path: <bpf+bounces-31075-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 568BE8D6C1E
	for <lists+bpf@lfdr.de>; Sat,  1 Jun 2024 00:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87D3D1C245FA
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 22:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D3281726;
	Fri, 31 May 2024 22:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKO+59dW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF487FBC8
	for <bpf@vger.kernel.org>; Fri, 31 May 2024 22:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717192880; cv=none; b=itUYLVP5kqK3Fm3c15hBjLAmbsnv4AjRirLosDh6rs4kqIBX7WlqmpI+2wudRZ/I42bJU+HfnzOaywzJmLX7HcgEK2974hk+DSWG2z+jZnHpR7ZYCuAC/+KI1REScgKpdvyNXkaI3akHveqKJ3DwsAd/u3tNfQA8/taOVI/RPOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717192880; c=relaxed/simple;
	bh=PuFu3270iN29C5bnZFslnrAbVkZrQ7dnyEF/ws9ckNE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TLU/xqA4W5KFEeTiingtfIvTeP8IYV02qZWAfpvyY/dR2V6W4CV6gHOfeScVRTVGl9yQI018c6hL6ssmD5AawccFSdTT9YVl3qAqetvefJ01Hx6DLCWfILOMyhfJ6HrNq6sNRHt66sRnfaye5UkRwX+g5QumtvWYjFSZL3xpLnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKO+59dW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0283FC4AF08;
	Fri, 31 May 2024 22:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717192880;
	bh=PuFu3270iN29C5bnZFslnrAbVkZrQ7dnyEF/ws9ckNE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dKO+59dWJyEwwHokEGmI4p+PyQLHGhK7QAIiXYdl5BwKGkxtXhUDlR7U2scxzQlvC
	 C5PXJozDQiQk/FQrmBr6XfDoyKUEOAHyyQ7nPmhcw5CKPXih2mz5hfkd+6hazgNGH4
	 SEfvxpXQOBf92gVsX3FW6foeX50LMp7IHFmIpUi22Rbdhi15SfNvJRmn726hb5xfJt
	 uLbahkrM1/v/eEQDa2ruvuDOEWFxQNxfdQGXzv7srF2luwrR+NBwNOeZYL9oE/kkhB
	 RpDV5grM09gza9AtFhy/eiLAuq72tQzUiX2+ucxEWjyzDZouDQplaYW+yPm9/LzxY4
	 30jlwdv4b4Ifw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D0BD8DEA714;
	Fri, 31 May 2024 22:01:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: Fix bpf_session_cookie BTF_ID in special_kfunc_set
 list
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171719287984.16477.9732800707745773298.git-patchwork-notify@kernel.org>
Date: Fri, 31 May 2024 22:01:19 +0000
References: <20240531194500.2967187-1-jolsa@kernel.org>
In-Reply-To: <20240531194500.2967187-1-jolsa@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bigeasy@linutronix.de, bpf@vger.kernel.org, kafai@fb.com,
 songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@chromium.org, sdf@google.com, haoluo@google.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 31 May 2024 21:45:00 +0200 you wrote:
> The bpf_session_cookie is unavailable for !CONFIG_FPROBE as reported
> by Sebastian [1].
> 
> To fix that we remove CONFIG_FPROBE ifdef for session kfuncs, which
> is fine, because there's filter for session programs.
> 
> Then based on bpf_trace.o dependency:
>   obj-$(CONFIG_BPF_EVENTS) += bpf_trace.o
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: Fix bpf_session_cookie BTF_ID in special_kfunc_set list
    https://git.kernel.org/bpf/bpf/c/aeb8fe0283d4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



