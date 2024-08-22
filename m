Return-Path: <bpf+bounces-37869-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C3295B96B
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 17:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AB51B2AC74
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 15:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE101CC8B6;
	Thu, 22 Aug 2024 15:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+EYSjFf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E7B1CB31B;
	Thu, 22 Aug 2024 15:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724339437; cv=none; b=HA2DOW0bMqRInjso6AugbCG/dzxIfkWRWUbvuUlr6aXVD+DSwHXNa7lQTEK9fMqjo8RnGSQmRF2NHSJt19AlW2TAJWbfPQqHHh4cSHPv+8X9WK4iUvC+dnhEz1vSj1C74sVzzRf5di/8Qt4G2El37rWVLiCmQHGbh7QPlsj5k4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724339437; c=relaxed/simple;
	bh=ibYRNDpxYQXol0jH8Nh5z8la8KqxCHWGjRfKy+KMCo8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iLonqzM4CTkPdYwGEXnyS0hKgIEysRSnW52iWEKSbPsgVaJrdikBb+NRs9v3sisdClA4Va1W2sJuuY4gKdyURXzct1EqKGI/Xr/tdKaelm5oKV3rQ+Ttq2XsQmxT0Z+A6GjvxrVi8g4S8msBFQnGkMHGsVVSQsWWUGkOj3JHgr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+EYSjFf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC090C4AF13;
	Thu, 22 Aug 2024 15:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724339436;
	bh=ibYRNDpxYQXol0jH8Nh5z8la8KqxCHWGjRfKy+KMCo8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P+EYSjFfCMAYTlE3Br1QWSwGiFJ0NTL/L8Ll5YPBzCqUmi4rcrTMz4t6z2f1eHKXd
	 UZbicQMJFJ0fryRaQi/FANEmt+z+tiS+cEV9Mfv07/ZwYaIa8dcFiLkC36aZmXrZ0M
	 DmELq92i+fnLJiyDCbcztt80A2DuMIvy4f92nwm/vh0dXoUkjaWpleaas5gfLOzqr6
	 mQ5V+yIQD6tNO9c70CJBlZw/Mxm0IRFDJE3QaXB36I7UsqJfV1DJryq1pkGOQp8h8K
	 i2FE2lHoEW+OY0FErDPUk/+Oh55s6Lg1yDvsV9oCybofvfBdTkW7F5RqxUfCEcTpOZ
	 4+OC5qbvZZbFQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE34E3809A80;
	Thu, 22 Aug 2024 15:10:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] bpf: Fix percpu address space issues
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172433943627.2352405.15302455595344864965.git-patchwork-notify@kernel.org>
Date: Thu, 22 Aug 2024 15:10:36 +0000
References: <20240811161414.56744-1-ubizjak@gmail.com>
In-Reply-To: <20240811161414.56744-1-ubizjak@gmail.com>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sun, 11 Aug 2024 18:13:33 +0200 you wrote:
> In arraymap.c:
> 
> In bpf_array_map_seq_start() and bpf_array_map_seq_next()
> cast return values from the __percpu address space to
> the generic address space via uintptr_t [1].
> 
> Correct the declaration of pptr pointer in __bpf_array_map_seq_show()
> to void __percpu * and cast the value from the generic address
> space to the __percpu address space via uintptr_t [1].
> 
> [...]

Here is the summary with links:
  - [v2] bpf: Fix percpu address space issues
    https://git.kernel.org/bpf/bpf-next/c/6d641ca50d7e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



