Return-Path: <bpf+bounces-11740-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0496D7BE6F6
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 18:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A9A4281AC3
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 16:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E611A733;
	Mon,  9 Oct 2023 16:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYxAPRRi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747AB18043
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 16:50:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB8F7C433CA;
	Mon,  9 Oct 2023 16:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696870231;
	bh=AJkot5FBCm4lPSoreEelc8js7+6JtqmXG87A7jEJW8g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PYxAPRRifbyBtor5MJp1SjG98sEY3Ie+v74dm79AvAwHgrgVfJYnwbxUQmL/CgoPi
	 kBA0bYDa13OUGIM47APeprLgaQY2A8WuGAH58jlIC1i7C0W2ceoVG2T1XIycMiSeJn
	 27CaiXxz63OeDwwySHuUnIv7VwVpee72P+stYWqZM6hkbm+d6vqNOZoEqtJWMc/7B8
	 vajXCXz2HyQV0N+H84c5Z/NXxA47rdHpUFWIcUzM+LKc3AlucMKg3Zt1JtadHs9Yfx
	 Y3L6hhpX00eHYh+dt7wj09wyJ0Ub7NAx7vXOcGXwWKScRFVrLJlfr0EdZN3kSXljE6
	 7eGsQ9hCPw+cw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D155DE0009C;
	Mon,  9 Oct 2023 16:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 1/2] bpftool: Align output skeleton ELF code
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169687023085.4743.8248369412311953528.git-patchwork-notify@kernel.org>
Date: Mon, 09 Oct 2023 16:50:30 +0000
References: <20231007044439.25171-1-irogers@google.com>
In-Reply-To: <20231007044439.25171-1-irogers@google.com>
To: Ian Rogers <irogers@google.com>
Cc: quentin@isovalent.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, alastorze@fb.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, alan.maguire@oracle.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri,  6 Oct 2023 21:44:38 -0700 you wrote:
> libbpf accesses the ELF data requiring at least 8 byte alignment,
> however, the data is generated into a C string that doesn't guarantee
> alignment. Fix this by assigning to an aligned char array. Use sizeof
> on the array, less one for the \0 terminator, rather than generating a
> constant.
> 
> Fixes: a6cc6b34b93e ("bpftool: Provide a helper method for accessing skeleton's embedded ELF data")
> Signed-off-by: Ian Rogers <irogers@google.com>
> Acked-by: Quentin Monnet <quentin@isovalent.com>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> 
> [...]

Here is the summary with links:
  - [v6,1/2] bpftool: Align output skeleton ELF code
    https://git.kernel.org/bpf/bpf-next/c/23671f4dfd10
  - [v6,2/2] bpftool: Align bpf_load_and_run_opts insns and data
    https://git.kernel.org/bpf/bpf-next/c/1be84ca53ca0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



