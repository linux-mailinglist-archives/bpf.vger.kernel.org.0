Return-Path: <bpf+bounces-1880-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 403C172326B
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 23:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F037D281432
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 21:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B30BE59;
	Mon,  5 Jun 2023 21:40:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C92627202
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 21:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2A0EC433EF;
	Mon,  5 Jun 2023 21:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686001220;
	bh=A9OcsADokwb+SeoE0+3x1nsXSxcqDXKTkvN54zzAlEM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VGFW9zFEs6Sq7BJre6omPTGFVbWfCJN0gVaAl95xNwdmFNsXUxbUMrYoCfJSQjQhx
	 gbc8yixtGFgCmGa6vVcqy6rPk7k/oicqSORZrcvBDJ62+SXIM4OPuEOUBgXpQnFNTD
	 4vwgteK9bGq/3tolAswvNdEXqzGOm1IU0/aiFPYiHGh0xDwOcpRAQSV4TyRUhXRws2
	 kLt7pTniVLpS/MUMgP55lkouxiXyNXiV65j1XmpX/AlKtTxcOmy5Ub2WrqbaK8Vcf3
	 Bb3cjh0Ys/g41RQOmrS74eaCvyDe00Dkukce4j78pT7y/MzqlMR3CXuB2dYLDyCiYZ
	 LnHzpqRNKLJxA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B5205E4F0A8;
	Mon,  5 Jun 2023 21:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/2] bpf: Teach verifier that trusted PTR_TO_BTF_ID
 pointers are non-NULL
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168600122073.24826.11603138027046134322.git-patchwork-notify@kernel.org>
Date: Mon, 05 Jun 2023 21:40:20 +0000
References: <20230602150112.1494194-1-void@manifault.com>
In-Reply-To: <20230602150112.1494194-1-void@manifault.com>
To: David Vernet <void@manifault.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  2 Jun 2023 10:01:11 -0500 you wrote:
> In reg_type_not_null(), we currently assume that a pointer may be NULL
> if it has the PTR_MAYBE_NULL modifier, or if it doesn't belong to one of
> several base type of pointers that are never NULL-able. For example,
> PTR_TO_CTX, PTR_TO_MAP_VALUE, etc.
> 
> It turns out that in some cases, PTR_TO_BTF_ID can never be NULL as
> well, though we currently don't specify it. For example, if you had the
> following program:
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf: Teach verifier that trusted PTR_TO_BTF_ID pointers are non-NULL
    https://git.kernel.org/bpf/bpf-next/c/51302c951c8f
  - [bpf-next,2/2] selftests/bpf: Add test for non-NULLable PTR_TO_BTF_IDs
    https://git.kernel.org/bpf/bpf-next/c/f904c67876c4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



