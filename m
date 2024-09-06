Return-Path: <bpf+bounces-39169-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F0496FD38
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 23:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64D2228694D
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 21:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2A4158520;
	Fri,  6 Sep 2024 21:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+EsXzuq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00300146588;
	Fri,  6 Sep 2024 21:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725657630; cv=none; b=B5Q41bht95GIlF5g1wFlCxVOcDb0FMcPX6bqG4htdjAYkt9Rd/GQ4iwVrBz3jTezPi77KboE868y5f952qNiWYi9RRLAIdvDOmtRajGkaqLZ+Efs3ZcOha1RLFcN86HAABU1rfyyiRqGX3+JB0Ru6IWVaER+yPMWsGTV2XjRuQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725657630; c=relaxed/simple;
	bh=Ss8ItuwkM8boM/5GeaPrpAUbJsSTEjwOc0EIQndqWiU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=C8OPTlJDI335nfNFbUUvZ6IK0CUTVC/xAeSe0cyz63TWnTN2spfgjX1QLADNXp4mlJDCZzZdrlgaCmJzsHluWptGxKGRcDshDMajrH/CNNDoFSjMOESI2tjmlsnY/G/DvmVtBBwrHuKI+E8wM+Fq5AU/OkaQdEJWh/hnH2z9OUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+EsXzuq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A95DC4CEC4;
	Fri,  6 Sep 2024 21:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725657629;
	bh=Ss8ItuwkM8boM/5GeaPrpAUbJsSTEjwOc0EIQndqWiU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=U+EsXzuqNJg2vJ8mjLVEhPIACK7pIf856gMbQEPFRafZkyByAakBVhKXyk+XjOms2
	 Q7E01VqWd65E16XwI0i/mCR+DHeJa+vtg4dAzzOKEjG89pdK5Eh1CDLyyS5jGw4e/W
	 ccDeltHDW+7RkNdvrAKe66siboN4rQqiFS5GhfBz0qn7hMwYq86lE200VOYKu7uOz2
	 GjeDjkWatC1GWf9iwyAhh7w82AzAsVcTvjG9kmo+ZuNEEo45GuNzOBGf+XQoos6qmv
	 pUOr1eyE8mrQWDAKDKUlxfgGNj1ernSAMF9bL2fpSHVr/kas81V0+eFwr+W4c88Y8P
	 0N8EwIdm0rZ/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEAE3806644;
	Fri,  6 Sep 2024 21:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] libbpf: workaround (another) -Wmaybe-uninitialized false
 positive
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172565763053.2526156.9088578633898489528.git-patchwork-notify@kernel.org>
Date: Fri, 06 Sep 2024 21:20:30 +0000
References: <f6962729197ae7cdf4f6d1512625bd92f2322d31.1725630494.git.sam@gentoo.org>
In-Reply-To: <f6962729197ae7cdf4f6d1512625bd92f2322d31.1725630494.git.sam@gentoo.org>
To: Sam James <sam@gentoo.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri,  6 Sep 2024 14:48:14 +0100 you wrote:
> We get this with GCC 15 -O3 (at least):
> ```
> libbpf.c: In function ‘bpf_map__init_kern_struct_ops’:
> libbpf.c:1109:18: error: ‘mod_btf’ may be used uninitialized [-Werror=maybe-uninitialized]
>  1109 |         kern_btf = mod_btf ? mod_btf->btf : obj->btf_vmlinux;
>       |         ~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> libbpf.c:1094:28: note: ‘mod_btf’ was declared here
>  1094 |         struct module_btf *mod_btf;
>       |                            ^~~~~~~
> In function ‘find_struct_ops_kern_types’,
>     inlined from ‘bpf_map__init_kern_struct_ops’ at libbpf.c:1102:8:
> libbpf.c:982:21: error: ‘btf’ may be used uninitialized [-Werror=maybe-uninitialized]
>   982 |         kern_type = btf__type_by_id(btf, kern_type_id);
>       |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> libbpf.c: In function ‘bpf_map__init_kern_struct_ops’:
> libbpf.c:967:21: note: ‘btf’ was declared here
>   967 |         struct btf *btf;
>       |                     ^~~
> ```
> 
> [...]

Here is the summary with links:
  - libbpf: workaround (another) -Wmaybe-uninitialized false positive
    https://git.kernel.org/bpf/bpf-next/c/8a3f14bb1e94

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



