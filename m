Return-Path: <bpf+bounces-68685-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C3CB81574
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 20:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE3483AD130
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 18:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA9A34BA33;
	Wed, 17 Sep 2025 18:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CAktrUhl"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27CC2FFDF0
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 18:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758133808; cv=none; b=uYJ7g6t3RnY1EwmWwKKUlPaMzbEDZYJMMezwZOyofb1VZ8X9nwGrtxMZkqVWiVf5KqZE2RLg8tPNXNfq/nxl396PcjE21s2y4JLm5S1CHNVQmKIKrmqyqeL1A8jRw7lChBRf9ZgbfXCI2A1x1dzr+oGWcgIERuDuZ53S2sPhd6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758133808; c=relaxed/simple;
	bh=qW+dUbjsqz8qEcvJUAz6sfHrJh0Ld4dF098AKCYzSjY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kpO0Tj9bvZIZhIQAV6D2ki0/LfutZky6r6jZyVDwGO7fJiCInraFCvZUXkdfAHCa/ifHF6Pgpc2OtUMz+MwTWoNU1zoXPzP/X38lz9xrZs+QuZRKccOz0Xem8Ez3X3t0vsGKHoQkoPXB7RrNxnd0R5Zt9i/4g+ULeZ1ONHAg2R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CAktrUhl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97ACDC4CEE7;
	Wed, 17 Sep 2025 18:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758133807;
	bh=qW+dUbjsqz8qEcvJUAz6sfHrJh0Ld4dF098AKCYzSjY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CAktrUhlIS7CQXih3HrFtp9RNOwjAhlbMedqjJHsb0Tf3XD+EUmnyJAokJm45CHqf
	 H5O7AjQx/JpYGPIzn+bIzE3BzKYP4STUl9O7EcnmW9XBeBi4nuCTPUiRO/LBUv8uQM
	 nqRPF/nnWZW1VGRjx56c2FduOXGQjVa8INZ+yCHC1SJMnIhhsok3am0dQWIQvfymLo
	 WfpJrSQy7s22ocFcKFD3436Z+w3UqT+NJOOqCUhtImNsA77SL8G+9RAoOBG0RHMr+a
	 YMKEDuYfFpdPyAT7tpgbTlrza+SapfJrELjOJjS0Jm6nfuBJAz5NXaNvDgAlk52C96
	 LGXKczzuMB2cg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70FAF39D0C20;
	Wed, 17 Sep 2025 18:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1 1/2] bpf: dont report verifier bug for missing
 bpf_scc_visit on speculative path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175813380826.2100449.10870700077067174186.git-patchwork-notify@kernel.org>
Date: Wed, 17 Sep 2025 18:30:08 +0000
References: <20250916212251.3490455-1-eddyz87@gmail.com>
In-Reply-To: <20250916212251.3490455-1-eddyz87@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,
 syzbot+3afc814e8df1af64b653@syzkaller.appspotmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 16 Sep 2025 14:22:50 -0700 you wrote:
> Syzbot generated a program that triggers a verifier_bug() call in
> maybe_exit_scc(). maybe_exit_scc() assumes that, when called for a
> state with insn_idx in some SCC, there should be an instance of struct
> bpf_scc_visit allocated for that SCC. Turns out the assumption does
> not hold for speculative execution paths. See example in the next
> patch.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1,1/2] bpf: dont report verifier bug for missing bpf_scc_visit on speculative path
    https://git.kernel.org/bpf/bpf-next/c/a3c73d629ea1
  - [bpf-next,v1,2/2] selftests/bpf: trigger verifier.c:maybe_exit_scc() for a speculative state
    https://git.kernel.org/bpf/bpf-next/c/a24a2dda70fb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



