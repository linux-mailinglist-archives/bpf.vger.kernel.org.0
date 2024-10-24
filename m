Return-Path: <bpf+bounces-43016-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 880519ADB5B
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 07:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E70A1F22B83
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 05:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14E01714CA;
	Thu, 24 Oct 2024 05:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rvBEFlWv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388F81662EF
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 05:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729747228; cv=none; b=Mv0R48zZ7tx4VPlbU8gqjKXHAfzAKZwNGiTnQxk6oUWyRNIaaz8BDNWzksV0t3alnbjpPO+3xi+Vcl5TvoUBWHROQLgfRHMh2+l/TKcb90lodaZCi9IcMDvMI7IWtxRKJjQk3Ofy9LA3rgSdmq4cklTwiLITlbgNrChNatpny6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729747228; c=relaxed/simple;
	bh=UKfl93WQYomc1Pa8Muacf9+1rnGvw/1uVzD73ZaFDCQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g75+O5EY3tTzm45tMiL9EXNJRkNkKZXlOmWu7HMlK+UhKN60Zp4jMWmLwunSo9/tC3XQ6aN9AqKA/IRdgf2W8ILWhj11WvE6bv8IjAXKUatDux72a24mTVAzGZI7TqZD7CLX9qnaHi+OKhLD8DgU0bfKZMnCMXXDB6ppTNIoKlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rvBEFlWv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB13C4CEC7;
	Thu, 24 Oct 2024 05:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729747227;
	bh=UKfl93WQYomc1Pa8Muacf9+1rnGvw/1uVzD73ZaFDCQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rvBEFlWvVWZ+0WW7tHzf4TSlSNFkxGM7CjK2H6T0Q+9pAcQ+0TIisryDTeZ4PJb+I
	 bICDAjvcwQfcjuV0rFHrnYslqcGqXmkoKBjer1yRvGPdHf4t+TOPQQrfH14bnAmM7a
	 E/vZKh0sYvhSU6x7NWYnmQE3cqFsjzM1cxB4sNGFQMOJ/n2PjdMQvJWhDDWfC8WH6t
	 qpHY8239keMgVahJNuDRyLgVlx+m0gBsPB6pAAGKRw9yGaB6cAMRIuYsz4qI5eBVJ6
	 hqGOsJZy0U2HCIJ9CIfQmsLLINQ4dnrXE673+K2aRBDFSMzfsl93AIVqj1V63sxrjE
	 V4jEcbAFqQN4A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EC33809A8A;
	Thu, 24 Oct 2024 05:20:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: fix do_misc_fixups() for bpf_get_branch_snapshot()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172974723428.1812236.6515281688627774382.git-patchwork-notify@kernel.org>
Date: Thu, 24 Oct 2024 05:20:34 +0000
References: <20241023161916.2896274-1-andrii@kernel.org>
In-Reply-To: <20241023161916.2896274-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com, shung-hsi.yu@suse.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 23 Oct 2024 09:19:16 -0700 you wrote:
> We need `goto next_insn;` at the end of patching instead of `continue;`.
> It currently works by accident by making verifier re-process patched
> instructions.
> 
> Reported-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> Fixes: 314a53623cd4 ("bpf: inline bpf_get_branch_snapshot() helper")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: fix do_misc_fixups() for bpf_get_branch_snapshot()
    https://git.kernel.org/bpf/bpf/c/9806f283140e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



