Return-Path: <bpf+bounces-37873-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9615B95BAAD
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 17:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEEDAB24C72
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 15:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149E01CCB50;
	Thu, 22 Aug 2024 15:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BjHCGI8Z"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9383F1CC8A3
	for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 15:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724341242; cv=none; b=on+owZsjt7KPnNijo6p5W7/oTEPNhmhsfz3LdNhIC9J9VNoghDv4u+IFWPIzjSdROG2JcRxs+HYTtViDsle4IMmpfJp1wuq0h76J0FzMSy+LtozT11SF2HTUxcG4SaDkrej7d372sR7b6JcJWdTijZCRJTOA+6xyDfhD8pwcEoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724341242; c=relaxed/simple;
	bh=YZdNrlOWhpJP9YOO8v9HTGaUgiSf8cJLQp1QwNqKy7k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pJsd/O0sODlLoZMBgLCbsZafKlJD7cnl+0WokMfRjfOxD5J6DM2VmrFoQ9FtDts/dHoecn0+Lx9RQABbizRDocn5j0uGpksdHBqw6fBsBVGb0+lYZogdkAwXv4eJnG95PH/pLAiNiX/xws/7XVbSAzgfAJp1mXDg/3ZDChXml1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BjHCGI8Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F6D0C32782;
	Thu, 22 Aug 2024 15:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724341242;
	bh=YZdNrlOWhpJP9YOO8v9HTGaUgiSf8cJLQp1QwNqKy7k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BjHCGI8ZpQcuBaCdaHl/3cNBAIdZ2JRCbqWsCE/l+4Kxuu58u9++FbUqlx7gbqL8D
	 5+5J030Gd/9sl9brrXFZGflefeQsNRVZNxZdgLL9n94zDxDPdFHtf30xNO+ugN2vVb
	 zsbB7UDiHQfhRdM1UJh/HqJk31CbxvakYPI50MtpCr7gnG/i6gW2bdOxUrsNpONPAz
	 TGlqHu06MXeCH8qcUfAu09ZVHydzxqAyeBBF8WOhTCtwkVjvspho09o53wws4S0S2t
	 y9WRxPIcM2Zc6KqNwux8+fZFZDkXA417lZNbtt99FajUVpTNMq7bSKdFkNc4C6DkDJ
	 dh/HvmXdEXg7g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB7483809A80;
	Thu, 22 Aug 2024 15:40:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/6] support bpf_fastcall patterns for calls to
 kfuncs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172434124150.2363434.3255650666548464904.git-patchwork-notify@kernel.org>
Date: Thu, 22 Aug 2024 15:40:41 +0000
References: <20240822084112.3257995-1-eddyz87@gmail.com>
In-Reply-To: <20240822084112.3257995-1-eddyz87@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 22 Aug 2024 01:41:06 -0700 you wrote:
> As an extension of [1], allow bpf_fastcall patterns for kfuncs:
> - pattern rules are the same as for helpers;
> - spill/fill removal is allowed only for kfuncs listed in the
>   is_fastcall_kfunc_call (under assumption that such kfuncs would
>   always be members of special_kfunc_list).
> 
> Allow bpf_fastcall rewrite for bpf_cast_to_kern_ctx() and
> bpf_rdonly_cast() in order to conjure selftests for this feature.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/6] bpf: rename nocsr -> bpf_fastcall in verifier
    https://git.kernel.org/bpf/bpf-next/c/ae010757a55b
  - [bpf-next,v3,2/6] selftests/bpf: rename nocsr -> bpf_fastcall in selftests
    https://git.kernel.org/bpf/bpf-next/c/adec67d372fe
  - [bpf-next,v3,3/6] bpf: support bpf_fastcall patterns for kfuncs
    https://git.kernel.org/bpf/bpf-next/c/b2ee6d27e9c6
  - [bpf-next,v3,4/6] bpf: allow bpf_fastcall for bpf_cast_to_kern_ctx and bpf_rdonly_cast
    https://git.kernel.org/bpf/bpf-next/c/40609093247b
  - [bpf-next,v3,5/6] selftests/bpf: by default use arch mask allowing all archs
    https://git.kernel.org/bpf/bpf-next/c/f406026fefa7
  - [bpf-next,v3,6/6] selftests/bpf: check if bpf_fastcall is recognized for kfuncs
    https://git.kernel.org/bpf/bpf-next/c/8c2e043daada

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



