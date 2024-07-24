Return-Path: <bpf+bounces-35460-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4AB93AB47
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 04:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48013B22CC2
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 02:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FE017C6A;
	Wed, 24 Jul 2024 02:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uD2K0RG4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1E62595
	for <bpf@vger.kernel.org>; Wed, 24 Jul 2024 02:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721788831; cv=none; b=QD/uEpRgjo1vXBfCx/OP/1mOR4mgvIl5kKSHl+wOwJf4BUpeOHDj4gsIhD/+kjC5LfEPGgByDFgwkuZ8aOdnDFQHnWbz9ppS8yXPFGZPsWwzyhAonYI0ysyRRcDwelc4ef6cW6LIpUTjAa9TxhDdtToQq0gqykKFV41RA/boSMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721788831; c=relaxed/simple;
	bh=hf+PqmVa6X9Wl7SeLaVtmXLOp330Cxun4R2b/SjC2mI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IKsX44m7Vv8msQZgatdWtXy2h3esG2iv+T4Tgr8Pb383ZFyFwIwsLjlJFL+Weg7YDAiIRju9Sjf48DthaRsG7AjLwDjk9Fr+8Zv84sUqze3DDodPilQIq7ShNiUdRa67A0ju9XVrPRPsmihC0KZI3kORK9l3VljZc3oHkbXqOq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uD2K0RG4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B0DDFC4AF0C;
	Wed, 24 Jul 2024 02:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721788830;
	bh=hf+PqmVa6X9Wl7SeLaVtmXLOp330Cxun4R2b/SjC2mI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uD2K0RG4Nt5wCfbqTs1U/fwGRTnO15Gom33F5LDFVK6h+4cnL3F9EsE0JfX+8woSF
	 hxZ64Cph+US6qhzCPv1IVbhcbYNyrXWniC31jY23ZzoWIX3md7fy2NQczSER3NbTx/
	 eWBMaI8r76RAxJThl/xH3PPDLDWbHAENGvtfoVd5bxdujUQuEqXa62KDHJWQKJhydM
	 WPo5PLxV3vyI97F+G8u/hQ6vcqWQ5/yBKO6e6CSMD9jkNqoC/LhOMSSDjZ4vIGv163
	 rH7T0Z2TQw7EdQ8gFDL9L0QXWnPu5JVBxo+pCuFHfaKswEXGWJd88savTvKgcM9Yiu
	 OHp8u6kCw/x9A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 98A5AC43443;
	Wed, 24 Jul 2024 02:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Fail verification for sign-extension of
 packet data/data_end/data_meta
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172178883062.19741.15730473419481345218.git-patchwork-notify@kernel.org>
Date: Wed, 24 Jul 2024 02:40:30 +0000
References: <20240723153439.2429035-1-yonghong.song@linux.dev>
In-Reply-To: <20240723153439.2429035-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org,
 syzbot+ad9ec60c8eaf69e6f99c@syzkaller.appspotmail.com, eddyz87@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 23 Jul 2024 08:34:39 -0700 you wrote:
> syzbot reported a kernel crash due to
>   commit 1f1e864b6555 ("bpf: Handle sign-extenstin ctx member accesses").
> The reason is due to sign-extension of 32-bit load for
> packet data/data_end/data_meta uapi field.
> 
> The original code looks like:
>         r2 = *(s32 *)(r1 + 76) /* load __sk_buff->data */
>         r3 = *(u32 *)(r1 + 80) /* load __sk_buff->data_end */
>         r0 = r2
>         r0 += 8
>         if r3 > r0 goto +1
>         ...
> Note that __sk_buff->data load has 32-bit sign extension.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/2] bpf: Fail verification for sign-extension of packet data/data_end/data_meta
    https://git.kernel.org/bpf/bpf-next/c/8924c0a1d51b
  - [bpf-next,v3,2/2] selftests/bpf: Add tests for ldsx of pkt data/data_end/data_meta accesses
    https://git.kernel.org/bpf/bpf-next/c/eb1b55c4875a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



