Return-Path: <bpf+bounces-38591-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC683966893
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 20:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1969F1C23BFA
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 18:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019AE1BB688;
	Fri, 30 Aug 2024 18:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBaJWAoT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8116F46B91
	for <bpf@vger.kernel.org>; Fri, 30 Aug 2024 18:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725040827; cv=none; b=PuLBrRAcqpoZy+WNnV6fFUr154MKiI4fyNnypsJlQVLDY9bfFDtM7xORStzjUPziiMTL/XZefrN6hIzPs9b2WjTrgPw0yrLYVDwmL/JtmsXzvAcDJJ9vUrnm2CtXJcgoUknr+xsMiPlwVBX8FyGx33RGGwUztLMnrt8RiooxBQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725040827; c=relaxed/simple;
	bh=1p3B0rH/hyC0oMFn8xqSBvEEH91iBSIfjL8FVq6TAFA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JZuN2HvBIjvPPVbZnTKlHlGT1NAB3sfSA3xWX9dWknX8Nnjok+vvZeB/KwuJyHRLjMFDrNyHuik7LlSmZfQkJ8QDlRjIdkaZVsxlDYbBIkSzo38HpL6rVwjUhBqrKQyqLBfdwmMxozv6wytLTwJcvXTHFDLBv3HB2U80M81AEL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HBaJWAoT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 283E9C4CEC4;
	Fri, 30 Aug 2024 18:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725040827;
	bh=1p3B0rH/hyC0oMFn8xqSBvEEH91iBSIfjL8FVq6TAFA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HBaJWAoTVkiC0RIstnOMX+0Yb3rdySPuRZcm+LIWFtF3WSrDhWj7qmcToMbxoteGw
	 NKNaRuIrD8I9QUZHHiTuGMxSFWqU7EpkUI16bVevNnENK5LHq2MFDPQ+TVbAI33Xhj
	 LqTJlyBsMf7LEdndRM8kZUbLgwr+hkqrnspgatO2VDsl9bSDn3+gitLGrTwG49xB2t
	 dX3VGY3daOHIOvd6eQYbZCWDis5ZtkeybTbLxfqEWysgiiO9ZlooWIm+/2+MS6Zqm/
	 T0YQcHP4PiXxLnLvHXBeNqVk/KRMaxTtpTdLWdcL3m3YYNHEeJOSSngGTERrvuXSSk
	 5gErCM1MCnGTQ==
Received: from ip-10-30-226-235.us-west-2.compute.internal (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BE3733809A81;
	Fri, 30 Aug 2024 18:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: check if distilled base inherits
 source endianness
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172504082877.2672459.17186170323678789822.git-patchwork-notify@kernel.org>
Date: Fri, 30 Aug 2024 18:00:28 +0000
References: <20240830173406.1581007-1-eddyz87@gmail.com>
In-Reply-To: <20240830173406.1581007-1-eddyz87@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, tony.ambardar@gmail.com, alan.maguire@oracle.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 30 Aug 2024 10:34:06 -0700 you wrote:
> Create a BTF with endianness different from host, make a distilled
> base/split BTF pair from it, dump as raw bytes, import again and
> verify that endianness is preserved.
> 
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/btf_distill.c    | 73 +++++++++++++++++++
>  1 file changed, 73 insertions(+)

Here is the summary with links:
  - [bpf-next] selftests/bpf: check if distilled base inherits source endianness
    https://git.kernel.org/bpf/bpf-next/c/217c4dfec4a6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



