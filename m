Return-Path: <bpf+bounces-45023-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 287F29D009A
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 20:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0342286F9E
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 19:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82646194C77;
	Sat, 16 Nov 2024 19:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="izhK2+jp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AF818E361;
	Sat, 16 Nov 2024 19:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731784219; cv=none; b=cauXiqu33WMGEmJ7+D4ZG/Z8QoGtSgijOUYIRS36bNCBzjPis7lC98672B+PsxeNCDpPNnEMYSJaBA1xXjnEr9v67Pdnn645uc1bpxYh/vukIY8EEGMiv1+P2PZNSTD6fb9VS3XABvO+6hjPPxNJC/oJEnw8MapBx43MTBxCBLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731784219; c=relaxed/simple;
	bh=hb0BtxQfSKLwtGoEe9IqH1yWl6HwZtBzF6p7BZGZ9LQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cgY216eYhfAMLhwQyaSldjbcYSejsJK0XrEfCzZR0UsuXfE8yT1ARW/QPCA5VWsR5CRvrI421TYjO85nBDe2FldwFe/OWKSKfP13GDcpJA5SurDhrTaIeWuq0rtJiupBd8V8W/MdV/oz3AEZnNwFXA6nau6IAR76ostCzi7c4xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=izhK2+jp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BB51C4CEC3;
	Sat, 16 Nov 2024 19:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731784217;
	bh=hb0BtxQfSKLwtGoEe9IqH1yWl6HwZtBzF6p7BZGZ9LQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=izhK2+jpyDwZ6YBfbYb40Ke3tk0KyZceCMu/MmT/BXcman1ZyLK+P6khMgdhtAF+R
	 ro2c1kwIO+4Ik/DvFv3CArJ1ZN+sDFCz7RZukqNxtPgwbBWhFulxNsmx9FziR6LNr6
	 tZwrK8KrO7StRSQI1HE7DrTHP7tNAPQ9AW4h2SM617ixSFxQNmmRm1m0tkAI8cb9wl
	 0C0i5RriNiGG20g/oD2I6uyb20FEJ/ER2AmwNU8en6idFP/wK5cbfFvRG6nuudoEC0
	 PiFU2aCJ0XDeVi1YEzMpoU8R89Ihd6jMSbDb+HnUReXbBjUARjRGfj+LTxT3APPShc
	 a6D2aE6R9yYOg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD1E3809A80;
	Sat, 16 Nov 2024 19:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] libbpf: Change hash_combine parameters from long to unsigned
 long
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173178422850.2975805.12239084632087642111.git-patchwork-notify@kernel.org>
Date: Sat, 16 Nov 2024 19:10:28 +0000
References: <20241116081054.65195-1-sidong.yang@furiosa.ai>
In-Reply-To: <20241116081054.65195-1-sidong.yang@furiosa.ai>
To: Sidong Yang <sidong.yang@furiosa.ai>
Cc: martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 andrii.nakryiko@gmail.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 16 Nov 2024 17:10:52 +0900 you wrote:
> The hash_combine() could be trapped when compiled with sanitizer like "zig cc"
> or clang with signed-integer-overflow option. This patch parameters and return
> type to unsigned long to remove the potential overflow.
> 
> Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
> ---
>  tools/lib/bpf/btf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - libbpf: Change hash_combine parameters from long to unsigned long
    https://git.kernel.org/bpf/bpf-next/c/2c8b09ac2537

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



