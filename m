Return-Path: <bpf+bounces-43174-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5D99B09B0
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 18:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC08C1C24A6C
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 16:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58CD18595F;
	Fri, 25 Oct 2024 16:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u4QMp5Yd"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24655170854
	for <bpf@vger.kernel.org>; Fri, 25 Oct 2024 16:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729873231; cv=none; b=KN59ln7+hr1JfxPmzq2589rxMCSB2jYyXbpRUT6CWpd3slZbLdzHng3H0vNJdaP6kVc/PV8I/jiplzrZHVNvSer6ulUcz+f1KIjg+PuCjFXhy7+amGHQoOjCyQG6nlkqkLdgkvwhCmymAWzQspsv2eLJ4Q8F0yIY0rD1lk+jtt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729873231; c=relaxed/simple;
	bh=A8cJWDTKeDzMBB3/niFbneNYQpYnEubMzQuD5Qt6Q6A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eeM4GWDLLrx6g2xK2lqyXuBAloBF0lkV69eRuTrf6+8J+5V/KXSxj+3boLXCdjnh932eLrWVC/YEp7EFNGsrq7uEWMSpMTnfc/aJsNICOdA3tChiIDNgLWd4Mfrg/kjWlv/cBGZAvLqnI4TtLsCHEljFHytWAdnFq1glR2zwPGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u4QMp5Yd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CB6CC4CEC3;
	Fri, 25 Oct 2024 16:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729873230;
	bh=A8cJWDTKeDzMBB3/niFbneNYQpYnEubMzQuD5Qt6Q6A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=u4QMp5Yd0KmGqDImk6OBOYiS3Fd9UqAfV2qDJjNdkdEZawUEBocach0mxBV0LFhhC
	 FlMVpSaCGnh7DeYZ3r1UlLIskVHIZxiEDKqVeMy2E0xLCCKYQQFMXxsiRE4rV5YWTX
	 xX7RRRVcjvjKq8XP4dtnyNVgt+6z5HIn23n3KKS7G2PM880kXeutK7q9mhkajTmJWk
	 y3LLgmEpAhYS8r9/k35tP2qcC84Zdz+nBK4mCx2PqzoS/+Dm/OBm7X8Lj7nteNAHTH
	 G5ckK/bsA/f0Djv86GxEnfYkkbAYbJXromIKAkJj+qx8k6U589oOK49jB0Z8Q82/K4
	 zgU9WngACDptw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E643809A8A;
	Fri, 25 Oct 2024 16:20:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpf,
 arm64: Remove garbage frame for struct_ops trampoline
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172987323726.2962335.8875079535119173363.git-patchwork-notify@kernel.org>
Date: Fri, 25 Oct 2024 16:20:37 +0000
References: <20241025085220.533949-1-xukuohai@huaweicloud.com>
In-Reply-To: <20241025085220.533949-1-xukuohai@huaweicloud.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ast@kernel.org,
 daniel@iogearbox.net, puranjay@kernel.org, catalin.marinas@arm.com,
 will@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 25 Oct 2024 16:52:20 +0800 you wrote:
> From: Xu Kuohai <xukuohai@huawei.com>
> 
> The callsite layout for arm64 fentry is:
> 
> mov x9, lr
> nop
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf, arm64: Remove garbage frame for struct_ops trampoline
    https://git.kernel.org/bpf/bpf-next/c/87cb58aebdf7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



