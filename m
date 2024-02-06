Return-Path: <bpf+bounces-21275-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB3384AD6B
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 05:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A7AD1F25E8D
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 04:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703E174E1E;
	Tue,  6 Feb 2024 04:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1DfJQIL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED10274E06
	for <bpf@vger.kernel.org>; Tue,  6 Feb 2024 04:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707193227; cv=none; b=tqvzbZMX5n3TfaUww48AeuJMwy6SBJCukm1e4FFmvcSG5/AgmWZrK4eYEi5NKoVmgx8bG0EEZUiEDi6y5hz+3kzS+P5r19O4D+Fr6uLRjPR2bBdgA8U+jfE5VdU1JnsSzBP45dXuvQzE9JIb2llRgo6SKdtzlPDsaDj85b4WaSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707193227; c=relaxed/simple;
	bh=OtaOfToxZYCoO6HSkvA3n1EVPBHiKVjm5feDqAr6TOU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ggfns5KsLWT9WyeoGZMb4a5PH2iVonsq/W3VEQJzIRitgyhrkYI//uCWvkChDFbE1xeaRNyErpbqUEyh8cYGTZ4sWIRcoEBnGSaCAdWNpt34WE9TUNBoCiETGa6QYNivsbfsB462wSyHm3dB+FcwSnL/icwPsBOrYeHXDCv8R+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1DfJQIL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8E19EC433C7;
	Tue,  6 Feb 2024 04:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707193226;
	bh=OtaOfToxZYCoO6HSkvA3n1EVPBHiKVjm5feDqAr6TOU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=T1DfJQILj28kkAuzMuX39eBWdHtcMJL8+eb2hm5a+kdDLTHqeZBk7hRlMXOFEcy3u
	 t/5wfn7ZGpZnusG5OvhX3lIlnNL4EwD5vAL3DWi471omnwv7jRdi413SDB3vo+dwKu
	 LovncQuvGf+F/IIhUJ5Zu59gWczCQ2DhWBl4myDHT8m6eJL6M61soUZhODNmAUz9Uf
	 8/8WzG0qpvx5StI9Mxw4zxuF32S2tq9gmnpkbdbsup8BqKT63Rtar1o9glZyuTg6A4
	 3M0j5z2YX4jwL2eA2Q3C7fbs3BuLzmFViD5dS/AMvFjRodgDE67nCR5OEZI/IFSRp9
	 ICnu7/Bprikrw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 75050D8C982;
	Tue,  6 Feb 2024 04:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: mark dynptr kfuncs __weak to make
 them optional on old kernels
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170719322647.4467.7037327786814411698.git-patchwork-notify@kernel.org>
Date: Tue, 06 Feb 2024 04:20:26 +0000
References: <20240206004008.1541513-1-andrii@kernel.org>
In-Reply-To: <20240206004008.1541513-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon,  5 Feb 2024 16:40:08 -0800 you wrote:
> Mark dynptr kfuncs as __weak to allow
> verifier_global_subprogs/arg_ctx_{perf,kprobe,raw_tp} subtests to be
> loadable on old kernels. Because bpf_dynptr_from_xdp() kfunc is used
> from arg_tag_dynptr BPF program in progs/verifier_global_subprogs.c
> *and* is not marked as __weak, loading any subtest from
> verifier_global_subprogs fails on old kernels that don't have
> bpf_dynptr_from_xdp() kfunc defined. Even if arg_tag_dynptr program
> itself is not loaded, libbpf bails out on non-weak reference to
> bpf_dynptr_from_xdp (that can't be resolved), which shared across all
> programs in progs/verifier_global_subprogs.c.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: mark dynptr kfuncs __weak to make them optional on old kernels
    https://git.kernel.org/bpf/bpf-next/c/c7dcb6c9aa85

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



