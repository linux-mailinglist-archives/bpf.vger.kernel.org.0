Return-Path: <bpf+bounces-23094-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7020A86D6DE
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 23:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09D9A28736F
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 22:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8839F200BA;
	Thu, 29 Feb 2024 22:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovGOefvc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB7A1E884
	for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 22:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709245836; cv=none; b=tWIGe4cTqZfAW80vxrH2UlqfZrNbc/rt7JOLjMNI0mh71fWBwAu28pKkux1kejt2waEroOk89K9mmYBwgOvUQldLPBwyuygXeNGxlqdefT2SXtVpDu/5zN1I5Vh8XnStdUg3b1IGFJfpsaQtF8mBPgQV/JjYWDRHAiYIZSwcQxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709245836; c=relaxed/simple;
	bh=kaR+upzxYE3hAMZWVpK90XWQycLSExEkiq+KsZ3r7iM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XckEH7LEayS2QobySE3Vv7XxIYkx91bhRXqFPKhSKmHP3qOtDgRw9da+FWOmmjV9O5ulaNqbJqFu4kyU6NECuem0i1uqhRWlwC94lbLgpqHHbq3fkhC1rVOGF/W/W/RAvG/POQgrGNLcZXRhOyTfRPe/GrKhYK5/tqVn/k9PUgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovGOefvc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9479AC433F1;
	Thu, 29 Feb 2024 22:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709245835;
	bh=kaR+upzxYE3hAMZWVpK90XWQycLSExEkiq+KsZ3r7iM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ovGOefvcESNJ6/EKNOu9EqDh+eBqStX5Ei5y80QZZVbvdukxS86DwC5sPmYYpnHiA
	 0SNKtBIDViwt0IP2pllY9FY/q0nCtczxutpklMiHCa7bFSzBXZS61KWW5DgXokmxNk
	 VEvUwhXrtcZ/HSexjOyQMUVMML4d9Ofv/poZItmFOLi6FuOS12zXWiQo4rEsK8//lO
	 jMorWB41bY16A7Eqq13DeML/mPDhaRrA8/BnqsNLxA92AIFPRSOEqHSqOmF+GLICV0
	 H2T0QmSQo0J4TmcNAksYAcYzv5rGjnihWTryMqirQmZYAZMZxTIn/+PvzgThyJ9aG/
	 5R09DIlAjx2mQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 78899C595C4;
	Thu, 29 Feb 2024 22:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v6 0/5] Create shadow types for struct_ops maps in
 skeletons
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170924583548.25842.11605612957276937344.git-patchwork-notify@kernel.org>
Date: Thu, 29 Feb 2024 22:30:35 +0000
References: <20240229064523.2091270-1-thinker.li@gmail.com>
In-Reply-To: <20240229064523.2091270-1-thinker.li@gmail.com>
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 quentin@isovalent.com, sinquersw@gmail.com, kuifeng@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 28 Feb 2024 22:45:18 -0800 you wrote:
> This patchset allows skeleton users to change the values of the fields
> in struct_ops maps at runtime. It will create a shadow type pointer in
> a skeleton for each struct_ops map, allowing users to access the
> values of fields through these pointers. For instance, if there is an
> integer field named "FOO" in a struct_ops map called "testmap", you
> can access the value of "FOO" in this way.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v6,1/5] libbpf: set btf_value_type_id of struct bpf_map for struct_ops.
    https://git.kernel.org/bpf/bpf-next/c/3644d285462a
  - [bpf-next,v6,2/5] libbpf: Convert st_ops->data to shadow type.
    https://git.kernel.org/bpf/bpf-next/c/69e4a9d2b3f5
  - [bpf-next,v6,3/5] bpftool: generated shadow variables for struct_ops maps.
    https://git.kernel.org/bpf/bpf-next/c/a7b0fa352eaf
  - [bpf-next,v6,4/5] bpftool: Add an example for struct_ops map and shadow type.
    https://git.kernel.org/bpf/bpf-next/c/f2e81192e07e
  - [bpf-next,v6,5/5] selftests/bpf: Test if shadow types work correctly.
    https://git.kernel.org/bpf/bpf-next/c/0623e7331794

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



