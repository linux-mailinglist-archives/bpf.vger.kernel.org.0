Return-Path: <bpf+bounces-43417-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C74F9B5478
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 21:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EB511C228B5
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 20:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2F6208227;
	Tue, 29 Oct 2024 20:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QdVQSPBC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB2420821A
	for <bpf@vger.kernel.org>; Tue, 29 Oct 2024 20:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730235025; cv=none; b=ENPpz+FbFYPGSBSpZ/NViLo6MRL36TuVuKOCEB5N2y16fThzzlnKQ7UdiyTmOe8yFWVEOq+kPj7lqV/2wGaVEyVCUQ/UiKkP3BYmbtrJ4kIjKTzbMf8cZWMy/TkPgILgtuNiyvpQWvQP43u0thTMP+rNOEbphOoCulFLHadT+Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730235025; c=relaxed/simple;
	bh=KZhmDjOa7a6Y95TD+MP8BGxcCOOH5iyX/mr4wmG5xmo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nvgizZ9YNBD2FbZnyOdJyexkwl65e735da7hyBQrH2iuX2f354Gzizl5dJJqzDgWsyOL28M0WRhml70P1Flcg2piDopXpdYlsMWGe/i4/U2Ng9avzdixIQLF7FMmZZkjoHIBgGoH4J/vIf3U+hbFnJYPCEmXH/G5Y6v7fcF01v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QdVQSPBC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28487C4CEE4;
	Tue, 29 Oct 2024 20:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730235025;
	bh=KZhmDjOa7a6Y95TD+MP8BGxcCOOH5iyX/mr4wmG5xmo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QdVQSPBCdrc5RrU0u1xY5W6gvyrJRkfC9FGsQnUihE7VNmz6Vv89WF6/9va1hCmc5
	 Uj4Pr8c/vL0FJWJZ2TlCaH+N3lbuPKrlhJENyXIT3HYwTg1c8zeEfr7PbViYACQ661
	 yMEYKQz7vMxYVBnHCUSi5ZQp0rsQ7K5PE5Y6W7Ay+ia+SxLeBHEbR4HhqyeLmCRBQy
	 ZkAq6UeJNUn8mpY/sPY2S8Ydw3BfiQvFqCrDSzvN3I/8Jix6PQ3UPuUFHu31H6a9fK
	 jBlfV8z3dGAjkm+RnrVG5FFIzVbicyjP6DBY2Ph3OC7MnltVkpQOxGSq1RkKTLKdsS
	 3lLkgFw0qYanw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB134380AC08;
	Tue, 29 Oct 2024 20:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: start v1.6 development cycle
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173023503249.818655.482062084870647256.git-patchwork-notify@kernel.org>
Date: Tue, 29 Oct 2024 20:50:32 +0000
References: <20241029184045.581537-1-andrii@kernel.org>
In-Reply-To: <20241029184045.581537-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 29 Oct 2024 11:40:45 -0700 you wrote:
> With libbpf v1.5.0 release out, start v1.6 dev cycle.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/lib/bpf/libbpf.map       | 3 +++
>  tools/lib/bpf/libbpf_version.h | 2 +-
>  2 files changed, 4 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [bpf-next] libbpf: start v1.6 development cycle
    https://git.kernel.org/bpf/bpf-next/c/74975e1303a3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



