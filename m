Return-Path: <bpf+bounces-38582-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3012D966832
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 19:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF7D11F23B4B
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 17:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E3E1BB68D;
	Fri, 30 Aug 2024 17:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lq2V/TtO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0190716C68F
	for <bpf@vger.kernel.org>; Fri, 30 Aug 2024 17:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725039627; cv=none; b=t/wKVkPib3MwYWglxnBVajv6r04PgRclnfQIickx7qIeTMz8bNvbhy6XNXt21KLxUC0+xEhWp7yWt/2oVhAE2B8oas2ehCMn9Vn1KzRC0JX0KE3emC6z1RgpNHr1IJDxPy/T4+X/j4/gEBcIAhlIpTAjjHC6+IjwAvsCh1np7kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725039627; c=relaxed/simple;
	bh=r72q7fPj6sbTmYypf4vu4fkH9H3Advnxky7ll2lb6RE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gVI3ljPSs3hqHnl0a8aIXyeVvw7iCTJDNjHlrZDOmuC5FkKLqzpwa4fcOrAMnMzgd4Um9EeNge1Dqx5uOQ4DfM01ftZ0fij3KWfzLIdBbmMGo9I6Vu2TiDFHjOm74ld40OXKoIPKhWOYveJg0/2/sz95VveVBE5FdJocjyD9r54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lq2V/TtO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 832CDC4CEC4;
	Fri, 30 Aug 2024 17:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725039626;
	bh=r72q7fPj6sbTmYypf4vu4fkH9H3Advnxky7ll2lb6RE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Lq2V/TtOZiH6Jk5Sk3vxYYX9/pxviLzkWarqH2WCDhrjjUaFL1vLrl7+z2IXEWNB1
	 JGihYUHP7IvRzugcZD64exECS1DocmKr1zhG6X3Cj3f3ClAc/VWSFHEJ35yVV+0oCB
	 PZDYhfSjudehuEpa/R0F3mCGOKO9CuIeyX/LngtR+ZhI7skpt/i7pvCf7T997U7E/g
	 vWK7AO+PruZugAXWnvPDL6DVYXhcHeDtrKIECBiJMU7OR9flIbE5Fh125VnRr1+++8
	 Xx6jtw0T/MM5uwVrrxADmR2OSA0BHmdsnw5Ast9T8UFMhf86gNkae3F4qlPLzVRKRJ
	 jpdrcjQj5cTHw==
Received: from ip-10-30-226-235.us-west-2.compute.internal (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19CF63809A81;
	Fri, 30 Aug 2024 17:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: Fix a crash when btf_parse_base() returns an error
 pointer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172503962809.2667215.14579806318905923450.git-patchwork-notify@kernel.org>
Date: Fri, 30 Aug 2024 17:40:28 +0000
References: <20240830012214.1646005-1-martin.lau@linux.dev>
In-Reply-To: <20240830012214.1646005-1-martin.lau@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@meta.com, alan.maguire@oracle.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 29 Aug 2024 18:22:14 -0700 you wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
> 
> The pointer returned by btf_parse_base could be an error pointer.
> IS_ERR() check is needed before calling btf_free(base_btf).
> 
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Fixes: 8646db238997 ("libbpf,bpf: Share BTF relocate-related code with kernel")
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: Fix a crash when btf_parse_base() returns an error pointer
    https://git.kernel.org/bpf/bpf/c/b408473ea01b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



