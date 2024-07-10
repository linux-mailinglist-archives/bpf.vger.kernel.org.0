Return-Path: <bpf+bounces-34444-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5A192D89B
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 20:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECE78281F25
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 18:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF0119412D;
	Wed, 10 Jul 2024 18:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJ40j7OA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A243BBED
	for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 18:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720637434; cv=none; b=sSGoLpwtKWJyhhlgladuSROEldQCsg96F99f9M0hqvKaDsZHT5IxiP1RlrPyxi+0Yy7mOjZ8bSsh633PvaxpZ3x7i5yfpFYjTxIcZAwA1vHjxod04Ds8w5YGwTRu4WDFz5ep7PJJ26n5k2KGTj4Pm9rqkpM/fe7gZ0AJVHFLS0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720637434; c=relaxed/simple;
	bh=EEkoVBAlUEN/KdzvTJM1L9aSz+dTogKrsjWNjErgK/s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WDgMmOr4oWZ4cdz+q5hTzMMBXZI778GJCKXRNGz1rC2UDlHsbLv+btetYsxfTB0+KZHV46dTyoJcXksIHbPuYzV75GHa6gChp0F9LAnNNzMGquiGd47LWvyOFwtx48OZpRfS/pCEZcEhsluWVCVJGWHfv+CVx7awr0tOwQfW7jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJ40j7OA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3A426C4AF07;
	Wed, 10 Jul 2024 18:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720637434;
	bh=EEkoVBAlUEN/KdzvTJM1L9aSz+dTogKrsjWNjErgK/s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GJ40j7OAtzXCgD0CQiFyLtetc34Pp4Cg9i3DeZolLlNbyBlBk8SVe7uO42QKF/w05
	 T8HAgM5wpQ4Fq9lra8wRoqhywau6OggZni8AtxEALJEtkyVR4YwfoLrDXfGQu9sCmv
	 iHwIPXIPrg6Q2lwfyBEJZyM+ZD7S23tlR9dMBDrGZloaOGC015mFbPyHLoin8abWga
	 Yz/9EkaRiC6whypFECpkDDCGxTTMuG4Lkzg0zaxVp1TG1oUrau+hpjcb4Zduvu8yE9
	 0zM6oFfTb7H8Q9v+bPC9gmH/Yk/8p0BqOp2tLYGv8hPc3JrSY0c9NwxHMY2JbUB2+Y
	 PRLNUSPNBL/JQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1FCF2C433E9;
	Wed, 10 Jul 2024 18:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: fix compilation failure when
 CONFIG_NF_FLOW_TABLE=m
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172063743412.10999.4019076923568507729.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jul 2024 18:50:34 +0000
References: <20240710150051.192598-1-alan.maguire@oracle.com>
In-Reply-To: <20240710150051.192598-1-alan.maguire@oracle.com>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com,
 andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, lorenzo@kernel.org,
 bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 10 Jul 2024 16:00:51 +0100 you wrote:
> In many cases, kernel netfilter functionality is built as modules.
> If CONFIG_NF_FLOW_TABLE=m in particular, progs/xdp_flowtable.c
> (and hence selftests) will fail to compile, so add a ___local
> version of "struct flow_ports".
> 
> Fixes: c77e572d3a8c ("selftests/bpf: Add selftest for bpf_xdp_flow_lookup kfunc")
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: fix compilation failure when CONFIG_NF_FLOW_TABLE=m
    https://git.kernel.org/bpf/bpf-next/c/eeb23b54e447

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



