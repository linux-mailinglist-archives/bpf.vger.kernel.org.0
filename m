Return-Path: <bpf+bounces-20374-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EE883D3DC
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 06:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B30442875B4
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 05:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E19BE7D;
	Fri, 26 Jan 2024 05:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6xWtiz/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC87DBE65
	for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 05:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706245825; cv=none; b=csXcwC3GkqgEaVe4OiFLCPdNsdYeZqNzXb77PqC1xCHgIm2AP7SOedjC2aaMqJltzACRNuPIc+/CGqm5xeP31N8gfzFV7Aq7Y8hpHgX+f74Y4BRwn3JwcivHfjN45MOxbBH3ylIzbkDrREvgrf+qKdbADe38ZBIrw5rpoNIUg2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706245825; c=relaxed/simple;
	bh=B73X4JGB8PX4r9P7dYFRnVA377hiy6r3bE2jKuqvsSc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q4w3XMSyqX05m7gl64EsoVlwl4FN+yrQwOKtJjVa+2VpqKAOkl1kkz2wi0uCjXFy+wL9xgD+4cX3MecYhRM7Z3vCwEPr/jENoYS2AMfkAOr4GRiG/XtxFCS21GL8XO6Aq6wBUY1+qYtaEuQBYAvb28RCxvv4nCKyd4xSgQSB5cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6xWtiz/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2275EC433F1;
	Fri, 26 Jan 2024 05:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706245825;
	bh=B73X4JGB8PX4r9P7dYFRnVA377hiy6r3bE2jKuqvsSc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=H6xWtiz/Xga+XJCmq5V/n15bfZbuzs70ohz1IKAFPd+p0GSq1tXE5ia/UUchB5B/c
	 BM+zhPDqoUZHP7vW5Rg2AYATkvd9SgFE6XRLK4/EscR/H+R97HXV9nBZlbeb75yAFi
	 IHyqsPtWgaTT8zSMKt3n9bbNw7O6Wfvv0qjEIdLbHvPtawfh/bnszrHegst9xNFmG7
	 Kt6omQJBLoETW8sO6We3bKaYrfIQAuq74CA6wGLfSDuBF8ji8eRggld6lDK/xPJJZm
	 VMjJDCArPiUcPYBKRmNyYIC+C4rhrS9AxTC5yjCQ4CcUxbhvu+crX2RayZtBlnHcui
	 i/26+37P3HczQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 09B0FD8C961;
	Fri, 26 Jan 2024 05:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpf: Fix error checks against
 bpf_get_btf_vmlinux().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170624582503.12691.10460466496481678509.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jan 2024 05:10:25 +0000
References: <20240126023113.1379504-1-thinker.li@gmail.com>
In-Reply-To: <20240126023113.1379504-1-thinker.li@gmail.com>
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 sinquersw@gmail.com, kuifeng@meta.com,
 syzbot+88f0aafe5f950d7489d7@syzkaller.appspotmail.com,
 syzbot+1336f3d4b10bcda75b89@syzkaller.appspotmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Thu, 25 Jan 2024 18:31:13 -0800 you wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> Check whether the returned pointer is NULL. Previously, it was assumed that
> an error code would be returned if BTF is not available or fails to
> parse. However, it actually returns NULL if BTF is disabled.
> 
> In the function check_struct_ops_btf_id(), we have stopped using
> btf_vmlinux as a backup because attach_btf is never null when attach_btf_id
> is set. However, the function test_libbpf_probe_prog_types() in
> libbpf_probes.c does not set both attach_btf_obj_fd and attach_btf_id,
> resulting in attach_btf being null, and it expects ENOTSUPP as a
> result. So, if attach_btf_id is not set, it will return ENOTSUPP.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf: Fix error checks against bpf_get_btf_vmlinux().
    https://git.kernel.org/bpf/bpf-next/c/e6be8cd5d3cf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



