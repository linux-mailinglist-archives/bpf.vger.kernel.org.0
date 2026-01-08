Return-Path: <bpf+bounces-78190-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 93204D00D2F
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 04:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6040D3060586
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 03:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBD22C11C9;
	Thu,  8 Jan 2026 03:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dWfSEzSs"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F167287506;
	Thu,  8 Jan 2026 03:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767842010; cv=none; b=UdkTEsx+LkN8bZVNBR5aunH+TJzLyffy0802J+6CgeYnAASYMvSXvHOclJdoJ3ZouWq7Rqw7qAcmL4EV0ji9X1LRddS5OBSVJN61kWOwdJ8XOpPCXxmE7SIv275vn5CF25yWDBZkX/C7V5aTv9OakS1WFw055rDXtC0sbcIBdwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767842010; c=relaxed/simple;
	bh=lhfz2ATIBaRtAz4EYD6x2ZJyi89AUh0h1zoKUpPA7bs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=N0cfyVqNDUveR1E3np8w0UP/RbxPVfDPDVECjY5FWrZrfATAs8Xrc/VgbF9IvmYXN5LvoNUp892j9RP46XKUaYmBlvl87cL/FPpoMnKvxAcKD4fW/hglbLgQM8hxZ1/OPbl9abbPJh8ZC20yJZ2Z3lRCd1RHnMwEXTliSKC0SSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dWfSEzSs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA642C16AAE;
	Thu,  8 Jan 2026 03:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767842009;
	bh=lhfz2ATIBaRtAz4EYD6x2ZJyi89AUh0h1zoKUpPA7bs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dWfSEzSs+7BVi08I/6SDaoWXA9yFHHPh8k8DGhlDmn3czonqF1N2kEtCLlZgo3EoC
	 Ds0snEQ3ipV3rxfQ4gwvaI6UPo2WZ7KfHH/cY57EysLmutU8Cbt1o7ll5X+ylxE7Gz
	 hUphz6Gfskgxt4OKM70lpQ+OJs2pnAcG6aCTQAifqquQzApGLrMW5o9/iPo02SY31E
	 1+NvxnCi32yiHst5PHpEE7l/oLMwXw1zIJf7jJFn0RoSQWWgtJ9XI3o7RxebhcbBgD
	 4KxBkay/Fvdc92WZVVVKdJf2mssQbBfkp9i0qVfcONFrc8ozHfdvg45g/jDGx107Js
	 LFPwrvRxr1oXQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B595F3A4100C;
	Thu,  8 Jan 2026 03:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: Reject BPF_MAP_TYPE_INSN_ARRAY in
 check_reg_const_str()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176784180655.3106398.6242918844189045898.git-patchwork-notify@kernel.org>
Date: Thu, 08 Jan 2026 03:10:06 +0000
References: <20260107021037.289644-1-kartikey406@gmail.com>
In-Reply-To: <20260107021037.289644-1-kartikey406@gmail.com>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, a.s.protopopov@gmail.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+2c29addf92581b410079@syzkaller.appspotmail.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  7 Jan 2026 07:40:37 +0530 you wrote:
> BPF_MAP_TYPE_INSN_ARRAY maps store instruction pointers in their
> ips array, not string data. The map_direct_value_addr callback for
> this map type returns the address of the ips array, which is not
> suitable for use as a constant string argument.
> 
> When a BPF program passes a pointer to an insn_array map value as
> ARG_PTR_TO_CONST_STR (e.g., to bpf_snprintf), the verifier's
> null-termination check in check_reg_const_str() operates on the
> wrong memory region, and at runtime bpf_bprintf_prepare() can read
> out of bounds searching for a null terminator.
> 
> [...]

Here is the summary with links:
  - bpf: Reject BPF_MAP_TYPE_INSN_ARRAY in check_reg_const_str()
    https://git.kernel.org/bpf/bpf/c/9df5fad801c5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



