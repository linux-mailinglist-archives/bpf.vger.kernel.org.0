Return-Path: <bpf+bounces-61994-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB27DAF03F7
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 21:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 984E24443F6
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 19:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D814127EFFF;
	Tue,  1 Jul 2025 19:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PnRxjP8q"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620B74690
	for <bpf@vger.kernel.org>; Tue,  1 Jul 2025 19:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751398785; cv=none; b=MB7qiIjJkrt7YP7/S9igwOdyAy1oUaTP3XH1ENZVizSTRtHZPUNk5+W95iLrUWnObGHYcWOIgAUiar141Heh9Gb/0q2eT8K0z++9tnL2sfiGGsKS08oPJ/dT+8X+6p8z2n2cxkoyQEr0QZ3tv6z+Jxi6ekBaEPuFt0CgHp2BkUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751398785; c=relaxed/simple;
	bh=36sEzcbgqorMu4VHtS8FICH1sZaknYLwEs83gwqYRNk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OQQuVZMMXCyOyjTUFn+H+6QAghtjpOlkdaY+KIgDM+N2hCQ5ZR1YY++O5yJnDXnH61Z2geO6RHcTyV23SL+QNcuBYUWe6FjJr/O5LD2wftRirXirhEbOqGtMNKPRbv9Z/qeKImTbS564cmFqyVEYFQluIHDgtLoQed6edojL3jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PnRxjP8q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF12C4CEEB;
	Tue,  1 Jul 2025 19:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751398784;
	bh=36sEzcbgqorMu4VHtS8FICH1sZaknYLwEs83gwqYRNk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PnRxjP8qoQsIdg06fMbCMhxuqFmKMM57jtMAhOQDS6LqdOAjCkKUs4m3pOYTS52Ov
	 KjaM17G0Zew+0MJ6asRl0n5uQ+h4WhUwRjvP+CS6zRjjq7bmMkFHkqsBkAncxvnykV
	 wunnf4XJjPqsLGGoSHSP5inwjKpfiRYyHX/xm5wRVqDTmZH6kgxIEyuLD5Fv2IT71h
	 +Yurgu81gnX0rL7P6etNcDJFB/t1yydgMAylEMeaSefumFnVlYutDV+5TQyqWO6wh9
	 9t+1nOVSf9p81eHKmWm/yjjHlIo7m+yIb3lEJQcrgq5PJq35SO2kt0nL71H6ggz17k
	 c41eQIjcxFa1g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB22E383B273;
	Tue,  1 Jul 2025 19:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/2] s390/bpf: Describe the frame using a struct
 instead of constants
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175139880976.96566.10786130017975344416.git-patchwork-notify@kernel.org>
Date: Tue, 01 Jul 2025 19:40:09 +0000
References: <20250624121501.50536-1-iii@linux.ibm.com>
In-Reply-To: <20250624121501.50536-1-iii@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 24 Jun 2025 14:04:26 +0200 you wrote:
> Hi,
> 
> This series contains two small refactorings without functional changes.
> 
> The first one removes the code duplication around calculating the
> distance from %r15 to the stack frame.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] s390/bpf: Centralize frame offset calculations
    https://git.kernel.org/bpf/bpf-next/c/b2268d550d20
  - [bpf-next,2/2] s390/bpf: Describe the frame using a struct instead of constants
    https://git.kernel.org/bpf/bpf-next/c/e26d523edf2a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



