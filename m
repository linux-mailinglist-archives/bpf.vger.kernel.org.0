Return-Path: <bpf+bounces-70149-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3950BBB1C86
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 23:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46AB67A75B1
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 21:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C7130F946;
	Wed,  1 Oct 2025 21:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LAkaecVE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB11A30F804;
	Wed,  1 Oct 2025 21:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759353019; cv=none; b=q+68C0X9Y7H4u+lWwal+zsdthmJYc1YS4VHHCAJFCF1gkPlcRJJuNEqcrFbonHwLYPzBeB3hS+ST5L1iReIoCiQXvpMwsBsceb/mIxPy+3efleXQTK/mK1W0V3RzzbIXKtZ/yIv3LrHLIzONPSccFAlU1kpemSZd879FW8ulI0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759353019; c=relaxed/simple;
	bh=/9zMh5hjSDQpOvrpxTnoqBN60UtJurO1W77TGHHl22g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XbUuY1EiussPkDb5wnpc5yLGDCmEVJL3zLuEApuTjCVmUr1bofGrcEtsu4ybjdy+l2ONKRtGSH3kvkBkCgfzTjvuBaCONU4Y6wkl9gt2LYz4MynUoGXzXkC7SaWqQOI6UWZwtfyjhQHA3LzjECYb9XAu8R3AKqEo9grKEF/XkfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LAkaecVE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D8EFC4CEF4;
	Wed,  1 Oct 2025 21:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759353018;
	bh=/9zMh5hjSDQpOvrpxTnoqBN60UtJurO1W77TGHHl22g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LAkaecVECqmIZa+/uTld3Ty5zxDBHw8od3GGiSntr+hkY/PxThcydP1ZWJAh85zM6
	 UAfJs3rPMBkHEwnFUzfXUMpk2Gz9LoTqHOK1sarKT1ezYmzFd2FSxd1HvXmQy8YO4P
	 mOsqTgRgGNGygoH8zV1VqWnx4wxCF50gT/3T+foGF67PWDLtRcmDq4DU6cqx72czAe
	 xzWbkuEMW8X4boRRYu6B7xkXTI71hzeyJd2piPH5CrF5TuW2tj/N3pE0OMouxAqzko
	 E0JkVXjJwsrGCK1Tn6TgFcMAQXrx521m4Jv4NRt6ff0q0e2Xewzq9sivCHxbnCzXJ+
	 G9TW4PjKj1JKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB91239D0C3F;
	Wed,  1 Oct 2025 21:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 1/2] bpf: Skip scalar adjustment for BPF_NEG if dst is
 a
 pointer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175935301050.2619259.17892458478308442429.git-patchwork-notify@kernel.org>
Date: Wed, 01 Oct 2025 21:10:10 +0000
References: <20251001192859.2343567-2-listout@listout.xyz>
In-Reply-To: <20251001192859.2343567-2-listout@listout.xyz>
To: Brahmajit Das <listout@listout.xyz>
Cc: syzbot+d36d5ae81e1b0a53ef58@syzkaller.appspotmail.com, andrii@kernel.org,
 ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
 haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org,
 kpsingh@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev,
 sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com,
 yonghong.song@linux.dev, kafai.wan@linux.dev

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu,  2 Oct 2025 00:58:58 +0530 you wrote:
> In check_alu_op(), the verifier currently calls check_reg_arg() and
> adjust_scalar_min_max_vals() unconditionally for BPF_NEG operations.
> However, if the destination register holds a pointer, these scalar
> adjustments are unnecessary and potentially incorrect.
> 
> This patch adds a check to skip the adjustment logic when the destination
> register contains a pointer.
> 
> [...]

Here is the summary with links:
  - [v4,1/2] bpf: Skip scalar adjustment for BPF_NEG if dst is a pointer
    https://git.kernel.org/bpf/bpf/c/34904582b502
  - [v4,2/2] selftests/bpf: Add test for BPF_NEG alu on CONST_PTR_TO_MAP
    https://git.kernel.org/bpf/bpf/c/8709c1685220

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



