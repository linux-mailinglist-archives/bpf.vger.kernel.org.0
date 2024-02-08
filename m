Return-Path: <bpf+bounces-21536-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58ADD84E925
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 20:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F045A28DB4A
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 19:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91379381D2;
	Thu,  8 Feb 2024 19:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s0zaWu/I"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F63B381C7;
	Thu,  8 Feb 2024 19:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707421829; cv=none; b=UM6iXk2dK0wr2u8T8SLz3OVCYhp6YJ/jkiv3BORx77zKx8h98lNXt2IpchIEMymN0xRih8im7r4LpYUEAcv61eKqY2IMukz84FUw/dXEVfD0aNeNAaXVVh9w1SdqYQMrA5BFbPjQamUyaDIjqhPtAOU6YjDSDeUdfLN4ABoaYh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707421829; c=relaxed/simple;
	bh=frozsszrvAOEaAV/4bkI6S+zBmgdBvsN0xUUW/uZv6Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EWxARKc8lRWcSws+8yMlW7aF0RKW/5NQIcsMmPd+Qav7s1VEKvllaCaqBpKoaRomNb/Rrah8o8aPL1ynE64LFoxgajBG9KlSUppxHcQxEk6xvKaxqn0Vq4iq+FEQrys6a6/+rUM+3DIyRFnf8RCP6VD8PYOlnB+6Tftbm3pe/RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s0zaWu/I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70FA2C43390;
	Thu,  8 Feb 2024 19:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707421828;
	bh=frozsszrvAOEaAV/4bkI6S+zBmgdBvsN0xUUW/uZv6Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=s0zaWu/IW9gEAhhnxgTY5/NQM6IcDACdPJQW/iB6dDuidFvldGFtknNUHs3UKspeX
	 DSdONTGDklISh8uOsjbNV1vcEp5MHOEYGSPHqNgcV4UtMifg0RDJ+Dw/HWvwdyhhW/
	 EHNNqX94Zu3n7e4bDUSp1Cx+ECExrehIGhxHd2KH40jM3OWs7C2oLWGpN75w7R3pKN
	 1y6dI7LLlSOL81pER13PYBnE6P9aCdnHE5DqIzI5FbdR9DIUm5/ESDIlDOone4Lvb6
	 umcFran2uqKWCcDzxqoV/9aThwz/l9zc0rNE9BAslVWWM7Uaa/5v8zgiUfnkO63CVL
	 anFkSYYTxoGqw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 521CAC395F1;
	Thu,  8 Feb 2024 19:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 0/3] bpf,
 btf: Add DEBUG_INFO_BTF checks for __register_bpf_struct_ops
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170742182833.20515.8846700383224206855.git-patchwork-notify@kernel.org>
Date: Thu, 08 Feb 2024 19:50:28 +0000
References: <cover.1707373307.git.tanggeliang@kylinos.cn>
In-Reply-To: <cover.1707373307.git.tanggeliang@kylinos.cn>
To: Geliang Tang <geliang@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 matttbe@kernel.org, eddyz87@gmail.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 tanggeliang@kylinos.cn, bpf@vger.kernel.org, mptcp@lists.linux.dev,
 lkp@intel.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Thu,  8 Feb 2024 14:24:20 +0800 you wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> v5:
>  - drop CONFIG_MODULE_ALLOW_BTF_MISMATCH check as Martin suggested.
> 
> v4:
>  - add a new patch to fix error checks for btf_get_module_btf.
>  - rename the helper to check_btf_kconfigs.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,1/3] bpf, btf: Fix return value of register_btf_id_dtor_kfuncs
    https://git.kernel.org/bpf/bpf-next/c/b9a395f0f7af
  - [bpf-next,v5,2/3] bpf, btf: Add check_btf_kconfigs helper
    https://git.kernel.org/bpf/bpf-next/c/9e60b0e02550
  - [bpf-next,v5,3/3] bpf, btf: Check btf for register_bpf_struct_ops
    https://git.kernel.org/bpf/bpf-next/c/947e56f82fd7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



