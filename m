Return-Path: <bpf+bounces-19015-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A46823D34
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 09:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B8691C22845
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 08:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE622031B;
	Thu,  4 Jan 2024 08:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tozmjm2A"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4462720310
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 08:13:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A7109C433CB;
	Thu,  4 Jan 2024 08:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704355982;
	bh=fcrR/KSZyMFbwnAA9iu83w9bw0uW0qjWYTJEjI3GT7M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Tozmjm2AHqfyG1md5wYE2AJQfx4lt2GWZ6QBGA0mKgS77FKw6yARh7WWkrbwALABE
	 odVUX06u4Twoc4cLIZuL5RL+QDk9ilTDQ0rN7NRKX93wLzfIZ9nl44zjhxzxbe/qX+
	 lYyVnyKXp+wkzXdp+qkwz/PBXAkMincgUp093IOBciOf09i5Jid5/pgCH3cXXJyDAV
	 nhzKqzVHno8c6iW6gwnxLSHw9kxM9z4nUr3LZkRNyIzj2WBRuqtBL/WAXGbkvSWeiF
	 nkTVZ6vJBuAcPIZLdPROXJkA9GUJq6p0jTDZ0IXjoKUEZYDWwWp2vl0uTGImaywSKi
	 XytJB065RrOSA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8E157DCB6FB;
	Thu,  4 Jan 2024 08:13:02 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 bpf-next 0/9] Libbpf-side __arg_ctx fallback support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170435598257.4004.10969640471288058081.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jan 2024 08:13:02 +0000
References: <20240104013847.3875810-1-andrii@kernel.org>
In-Reply-To: <20240104013847.3875810-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 3 Jan 2024 17:38:38 -0800 you wrote:
> Support __arg_ctx global function argument tag semantics even on older kernels
> that don't natively support it through btf_decl_tag("arg:ctx").
> 
> Patches #2-#6 are preparatory work to allow to postpone BTF loading into the
> kernel until after all the BPF program relocations (including global func
> appending to main programs) are done. Patch #4 is perhaps the most important
> and establishes pre-created stable placeholder FDs, so that relocations can
> embed valid map FDs into ldimm64 instructions.
> 
> [...]

Here is the summary with links:
  - [v3,bpf-next,1/9] libbpf: make uniform use of btf__fd() accessor inside libbpf
    https://git.kernel.org/bpf/bpf-next/c/df7c3f7d3a3d
  - [v3,bpf-next,2/9] libbpf: use explicit map reuse flag to skip map creation steps
    https://git.kernel.org/bpf/bpf-next/c/fa98b54bff39
  - [v3,bpf-next,3/9] libbpf: don't rely on map->fd as an indicator of map being created
    https://git.kernel.org/bpf/bpf-next/c/f08c18e083ad
  - [v3,bpf-next,4/9] libbpf: use stable map placeholder FDs
    https://git.kernel.org/bpf/bpf-next/c/dac645b950ea
  - [v3,bpf-next,5/9] libbpf: move exception callbacks assignment logic into relocation step
    https://git.kernel.org/bpf/bpf-next/c/fb03be7c4a27
  - [v3,bpf-next,6/9] libbpf: move BTF loading step after relocation step
    https://git.kernel.org/bpf/bpf-next/c/1004742d7ff0
  - [v3,bpf-next,7/9] libbpf: implement __arg_ctx fallback logic
    https://git.kernel.org/bpf/bpf-next/c/2f38fe689470
  - [v3,bpf-next,8/9] selftests/bpf: add arg:ctx cases to test_global_funcs tests
    https://git.kernel.org/bpf/bpf-next/c/67fe459144dd
  - [v3,bpf-next,9/9] selftests/bpf: add __arg_ctx BTF rewrite test
    https://git.kernel.org/bpf/bpf-next/c/95226f5a3669

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



