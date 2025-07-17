Return-Path: <bpf+bounces-63537-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE00B08286
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 03:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F3DD3B3615
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 01:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE3F1E3769;
	Thu, 17 Jul 2025 01:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDDHRFZX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0070E1D5CC7
	for <bpf@vger.kernel.org>; Thu, 17 Jul 2025 01:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752716401; cv=none; b=tJG4hMrxsffMKpbjc6xgqcbuHq5UCsKQP10i6wEQtzksXCwsXXsuvCdhQo9kecQ6VRBiDh0FMKpxlUORgHMIx22p3vPPl0NQfi+hbCZUlLWK3kqtiFnFRfJFp2l5YhBe2QPHI+3P9pTO8xwxLofegTm3/cSMa3cRsuSJBax5jGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752716401; c=relaxed/simple;
	bh=YWa5g1anUE97UnciWgpVASGKaJWrPOQSQznQqJR/6jY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jo0COD9rjlNF+5PeryepNSlHuLxW6u7kQ0rQYS63wGKXbBAVtrCQhiluelGPsCz+aFuiwA+mX9SzhMkn909PD4IKAGwpJKAoNZp2y2LCPlkHmCqBGAHmfqhM3HWcpR7r0k0EHSQK0ZtyHa9CwctLy85fSPSC6yHwunaYK5wXep4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDDHRFZX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FAD3C4CEE7;
	Thu, 17 Jul 2025 01:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752716400;
	bh=YWa5g1anUE97UnciWgpVASGKaJWrPOQSQznQqJR/6jY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EDDHRFZXmX8V5BSrvxDRQMO5Voq2rAX8iyabBE9DBrOUJe2usOYlETRqJPY1UXyQh
	 cTGMXZudyLTIpzDb72s87V9Bulb9MioGtDnCPkfR7XXdZt2aJRxbZXYLyZNn3rgyQA
	 I2hh/uq95bGn4db5SMhhtrrU0d29Ty0ob0YkrQh+ttbtOhnpUgkLxSQHvZRpa1oT6g
	 hJYi3wMWPr59SP9IG9F4hNBJTjhTqYnSBGdaOgLj+wQxIebnw3kTJTHnWzZRiVXPwA
	 7A+4nQYmhVWl9PHa6RbPZqQkjiLNoXGTSEpNrJitOOl2x1BjBsr5MEc3H5l5JskbZg
	 wEQSKixhSp4jA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEDD383BA38;
	Thu, 17 Jul 2025 01:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: start v1.7 dev cycle
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175271642024.1391969.16720379650196101634.git-patchwork-notify@kernel.org>
Date: Thu, 17 Jul 2025 01:40:20 +0000
References: <20250716175936.2343013-1-andrii@kernel.org>
In-Reply-To: <20250716175936.2343013-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 16 Jul 2025 10:59:36 -0700 you wrote:
> With libbpf 1.6.0 released, adjust libbpf.map and libbpf_version.h to
> start v1.7 development cycles.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/lib/bpf/libbpf.map       | 3 +++
>  tools/lib/bpf/libbpf_version.h | 2 +-
>  2 files changed, 4 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [bpf-next] libbpf: start v1.7 dev cycle
    https://git.kernel.org/bpf/bpf-next/c/8080500cba05

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



