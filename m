Return-Path: <bpf+bounces-53927-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53394A5E86A
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 00:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E0C03AF25A
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 23:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C5F1F2C5B;
	Wed, 12 Mar 2025 23:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PS57DJT3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CCA1F2C34
	for <bpf@vger.kernel.org>; Wed, 12 Mar 2025 23:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741822198; cv=none; b=VFt2FcxBrSgWLDDJUTiWwfT0uD9x5J/MmnTAimAv45TbBVCCLed/S+6+eQMp8Kl6fh04N8sbZNkEw+DNHji1g/f2i0SKqFgvXtGRWJNFejbf4iYp2nXW1sc3gp+MvHHYWTlBZAid2jy6xs89SaCvJkOisVZYWGKlzWdifCsddZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741822198; c=relaxed/simple;
	bh=/caeDQIHtR78mBlmxvnAByrf4owyr4YVIxOuGixGcUI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Be0xwS84ohGRXMduwlQG9sR4P9iRfx+ZXsbwMIRfxOh1pnhtYK5arzJgCnJskePgqZDMC2qL3QeVaUMu8nw1wbiJMl11CRSdk0+MzV1MPCIhVRavPLJtJV22obVt8OdE+pLcW4sMS/wvFV56mD1Lqx0Q4h0I+ccbHTjpGO5mGQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PS57DJT3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A189C4CEE3;
	Wed, 12 Mar 2025 23:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741822198;
	bh=/caeDQIHtR78mBlmxvnAByrf4owyr4YVIxOuGixGcUI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PS57DJT3gIyx196OYfbUDMI9w0ozrQdD0wN2tdYP2q2FCG79NsaEa+jWpkE0mV8N7
	 sqZbxk+qAqxnbrOn+sADRDXWIPq0yTyV6ruFAzF9ryAkhvsqU+QGh8qhWJaikKnNUF
	 kQQdrIQXvNbqlSXudbjoKrJdTEllcbY0ytUBhsTkPlCycdvCXCFhUSjkZ27JLNop35
	 gjDP1A6YIEAl9/mAP9u+tHJCJznFV5pIXs4Q3W8PtMgLJumf/fY9YwtUbeBlnThtk3
	 gVH6priVzTcdTLMr8H0OKFRAF/hBR4vv0Md3bi4vm+pDIFT0Mk/e8e12/2KyvqOknL
	 djKAd1CjFFyeg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE09380DBDF;
	Wed, 12 Mar 2025 23:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1] selftests/bpf: Fix arena_spin_lock compilation on
 PowerPC
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174182223277.971369.9314488046918159353.git-patchwork-notify@kernel.org>
Date: Wed, 12 Mar 2025 23:30:32 +0000
References: <20250311154244.3775505-1-memxor@gmail.com>
In-Reply-To: <20250311154244.3775505-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, venkat88@linux.ibm.com, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
 eddyz87@gmail.com, kkd@meta.com, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 11 Mar 2025 08:42:44 -0700 you wrote:
> Venkat reported a compilation error for BPF selftests on PowerPC [0].
> The crux of the error is the following message:
>   In file included from progs/arena_spin_lock.c:7:
>   /root/bpf-next/tools/testing/selftests/bpf/bpf_arena_spin_lock.h:122:8:
>   error: member reference base type '__attribute__((address_space(1)))
>   u32' (aka '__attribute__((address_space(1))) unsigned int') is not a
>   structure or union
>      122 |         old = atomic_read(&lock->val);
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1] selftests/bpf: Fix arena_spin_lock compilation on PowerPC
    https://git.kernel.org/bpf/bpf-next/c/46d38f489ef0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



