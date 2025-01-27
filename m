Return-Path: <bpf+bounces-49895-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E95DEA2008D
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 23:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45DAF3A4015
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 22:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC101B6CE3;
	Mon, 27 Jan 2025 22:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i9Uj7ihw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6B91DB34C
	for <bpf@vger.kernel.org>; Mon, 27 Jan 2025 22:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738017007; cv=none; b=g5V+sH1ZJug5JDpMDfmfN1LOOPkzJJ15PeRe25iZ0Jwsnd8+VrKfHMUpacOYjcjXvUDr1x8sWDJQzUcU2Vba5Hzq2/GkZkkMsm7CPBRKu+Y1Bgj3V5zotwttpZbTgY5ZPVsZdh/ROi9319dPV25nuYXc/C9Ipyp136MEoYEfHF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738017007; c=relaxed/simple;
	bh=IJPXHXHLJV5MOHMP9F00QqZSc3e/Qswax4Z8uQzQT00=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pP8nYSMeHzmbay1Tw3HfU+8gH0st287BFOZ2pO4bN98io2g+xvwI+5BQFFs8DGSm2gsoN1iPIhjPx9XzyId5BMrvR7TJF5MFQAvNw4H8pQWb9iR8+ISVcmB5xEnbTgEw79t5FmfrAYs0fKowgZpG8LGpZTTLhwcCca1VSxOwzHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i9Uj7ihw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C9ECC4CED2;
	Mon, 27 Jan 2025 22:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738017006;
	bh=IJPXHXHLJV5MOHMP9F00QqZSc3e/Qswax4Z8uQzQT00=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=i9Uj7ihwJiRN0k4ol23z/zxj1Lpf/jMBL3tYnKw2c0S/G9shVHk5ysY+ENEcV9jZJ
	 v+v2LohuTNyyeEScxjPCgTvyKnun7a0+MxGqdP02ADhYwc5Qh9u9keRfTq0hu5mFD7
	 5CWjSodTfEAZJg5Elb6u88DhUqYO7xiLARYDwGBz1y+zWsvmUvcSA/cVoTfBqL4NJq
	 BrGpdtuxK3Z3OGSnYQRsdbhMUaY6FOxmY+9J+nqgwnbvGfy01cr/7Cd9tF9srRJtct
	 jIigN1a/5LSuc41jewfqsujRZHPaLsCc4UAedkNXhR0T9n2J7qTepts4u1smDlz3vT
	 zZdNHKG0KNUyg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB483380AA63;
	Mon, 27 Jan 2025 22:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v1] libbpf: fix accessing BTF.ext core_relo header
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173801703177.3242514.15771856422421899394.git-patchwork-notify@kernel.org>
Date: Mon, 27 Jan 2025 22:30:31 +0000
References: <20250125065236.2603346-1-itugrok@yahoo.com>
In-Reply-To: <20250125065236.2603346-1-itugrok@yahoo.com>
To: Tony Ambardar <tony.ambardar@gmail.com>
Cc: shivam.tiwari00021@gmail.com, andrii@kernel.org, eddyz87@gmail.com,
 ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 24 Jan 2025 22:52:36 -0800 you wrote:
> From: Tony Ambardar <tony.ambardar@gmail.com>
> 
> Update btf_ext_parse_info() to ensure the core_relo header is present
> before reading its fields. This avoids a potential buffer read overflow
> reported by the OSS Fuzz project.
> 
> Fixes: cf579164e9ea ("libbpf: Support BTF.ext loading and output in either endianness")
> Link: https://issues.oss-fuzz.com/issues/388905046
> Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> 
> [...]

Here is the summary with links:
  - [bpf,v1] libbpf: fix accessing BTF.ext core_relo header
    https://git.kernel.org/bpf/bpf-next/c/0fc5dddb9409

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



