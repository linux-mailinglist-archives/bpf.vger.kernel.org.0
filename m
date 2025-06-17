Return-Path: <bpf+bounces-60854-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5D0ADDD39
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 22:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 432F3189FF41
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 20:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0BC2EF9C8;
	Tue, 17 Jun 2025 20:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvT320zT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D869E2EBBB6
	for <bpf@vger.kernel.org>; Tue, 17 Jun 2025 20:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750192206; cv=none; b=ZLFy+rb6wIKCS+sLsuL2ZH/IkMDurKZwRWGeLawGeDJ3N/4sOKbO3a3THUYAluCRf1kboioZw12Nsxud0EltcO5Ral05PV/td/8jz4lJf0mLE5TdCAtW/Fsx2k6wGKjM+Rm6RgAtnNGFA0O7RakDbSYBZhzEPpm9Xbd/g65QQ74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750192206; c=relaxed/simple;
	bh=SmD1vWJEzZrVaFh3eAafpZXnXQ9tBivyjGQPyRARPv4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mIA2e6dvllXdrESCJ2ncuyt/8N2PaL98oJfuV9k6rFyeFSdPNsnQjqe2/dG1aWWAIVIzuxSG/LcqmwmC2aiiCxmiqntK/KgLRbK7ixkp0XpmEdxH/ej5Oq8s1yNbNPpb3Bl1TPog6bO9BekGWFAIxQpV/+WN16ZLODsUYCDc7dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvT320zT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB04C4CEE3;
	Tue, 17 Jun 2025 20:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750192206;
	bh=SmD1vWJEzZrVaFh3eAafpZXnXQ9tBivyjGQPyRARPv4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TvT320zTuR613MIG8rbn4XOTW16Ez+EsdUvgRoIMpKlTXGfissYf/BWfdsdbqnM+F
	 7EQpL3GxSLhGjDarIC0TI/T3kiMCoIgN/A/ffiYI0W57NasfBKhI/4nOcNf83TPSQc
	 NupCqfxVW4eTWUqyJXWBPHGJ8sCDjKlIcPISM+ISb/2BnZ3V+rvPKYURVt0huykqE2
	 t3dtUCZ1/MvDIwe3Bp0qwlhkn3ycnsppX32tkAiIxDUGc7+QPRL8uQEwMY7aVcmBeL
	 V+MdlzJ77kPPbg4ToTikGTMZcqF0ys0qRcYHIjF7E3CAREcid/IFVGCjNOPJ+J7CK/
	 ufOJxxfbx5wGQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CDF38111DD;
	Tue, 17 Jun 2025 20:30:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: fix unintentional switch case
 fall
 through
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175019223524.3686091.17037412831949371950.git-patchwork-notify@kernel.org>
Date: Tue, 17 Jun 2025 20:30:35 +0000
References: <20250617121536.1320074-1-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250617121536.1320074-1-mykyta.yatsenko5@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, yatsenko@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 17 Jun 2025 13:15:36 +0100 you wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> Break from switch expression after parsing -n CLI argument in veristat,
> instead of falling through and enabling comparison mode.
> Fixes: a5c57f81eb2b ("veristat: add ability to set BPF_F_TEST_SANITY_STRICT flag with -r flag")
> 
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: fix unintentional switch case fall through
    https://git.kernel.org/bpf/bpf-next/c/66ab68c9de89

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



