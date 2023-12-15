Return-Path: <bpf+bounces-17930-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B87D6813F73
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 02:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 762CF283E07
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 01:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCB67FC;
	Fri, 15 Dec 2023 01:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUSifCeR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A633210EC
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 01:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E979C433C9;
	Fri, 15 Dec 2023 01:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702605025;
	bh=VNRRY1iBGy4YRt/lSDepRAusbFbYA6zNMOWisSEbB9k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IUSifCeRYzQhZSWoy9QxlXN8CcQ0U4ACYNkmZ8CWv5Pyk+iMlN7/vPyt8IYObFJAp
	 rJZhdyy5Yu57iFaW18eY+brmY2RehdWhC3FOgxoYEI3M5MRC27DdxaSW7OwAg7Zw2V
	 JZKzjRFWSynPBnxei4Ap4lyARrxcoTy3fk57LfDspkwaEdyRbdnUQCfbgSQQ7aahe4
	 5JjWZYVkgDQkYfUK65ZcOVXh3EUBsvzrSRP4Vo1x0260+iG85pAK1/OQa/jA65yYMy
	 jFfRmEzbTNFu/4u9ssEQZimIl+BOaii3Lj/Uzo/pGrUmYWuuCUqzf1UJEz7jqkt0zU
	 jfFJWugKQMbxA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 05752DD4EFC;
	Fri, 15 Dec 2023 01:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 0/2] BPF FS mount options parsing follow ups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170260502501.25370.17229244525326916553.git-patchwork-notify@kernel.org>
Date: Fri, 15 Dec 2023 01:50:25 +0000
References: <20231214225016.1209867-1-andrii@kernel.org>
In-Reply-To: <20231214225016.1209867-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 14 Dec 2023 14:50:14 -0800 you wrote:
> Original BPF token patch set ([0]) added delegate_xxx mount options which
> supported only special "any" value and hexadecimal bitmask. This patch set
> attempts to make specifying and inspecting these mount options more
> human-friendly by supporting string constants matching corresponding bpf_cmd,
> bpf_map_type, bpf_prog_type, and bpf_attach_type enumerators.
> 
> This implementation relies on BTF information to find all supported symbolic
> names. If kernel wasn't built with BTF, BPF FS will still support "any" and
> hex-based mask.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/2] bpf: support symbolic BPF FS delegation mount options
    https://git.kernel.org/bpf/bpf-next/c/c5707b2146d2
  - [v2,bpf-next,2/2] selftests/bpf: utilize string values for delegate_xxx mount options
    https://git.kernel.org/bpf/bpf-next/c/f2d0ffee1f03

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



