Return-Path: <bpf+bounces-47484-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8002B9F9CB3
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 23:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A278E7A26DA
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 22:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12AE227567;
	Fri, 20 Dec 2024 22:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9CYA8TQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEE4155342;
	Fri, 20 Dec 2024 22:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734733216; cv=none; b=U/jF+ipBwG23PcTtVrRbv3e7DLEI7PcrLrCGDsa4d1pPzlgDFDMn5LrZthS3F2w39BejYHTsxD4dQDYF2ILQiwTsYLNpe2KJLhHpTfMAA1+aYSeA2RyC6rXU8sIYGvXO6/xG6r52r7ipGqtM+bKLgaKSPm/KXEI4WqMl0D0ciHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734733216; c=relaxed/simple;
	bh=SRrrMI3Ve0fnBt8s85Tlk4Gjw+jfFYv0pPQ/7O2oxD8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mw+PuKz1wpq0b8bsvkR9sGj6+3gmlw95r2EBj0MvUywDJFcUqcUgzjVkmdzt9x8tlqKv04ecJP041DmzoHfn1TDNOgSG0XP5d60mZWtKUXCbM7IDKVTghU4n9T5NDqbQeVpNMlFCQX8Xh41ebb10lQszmCZUpetjWyzpWv69aNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9CYA8TQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8159C4CECD;
	Fri, 20 Dec 2024 22:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734733215;
	bh=SRrrMI3Ve0fnBt8s85Tlk4Gjw+jfFYv0pPQ/7O2oxD8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k9CYA8TQtF/hoEuGL96h9QZVQzCsmV7r+PX7FHVt098nsyXtMB3Anuxf3MIEivaHP
	 TjmPb2HmVJtnTGSXP5tb7kl0qOEqyLprmQS/r+751Wls/KEZ0nZiekJAQIC+SG2hwa
	 5/pHpD/Y0ZW/q9j5EbBOen8mnZ8z+Jhyh7/ykvo9LcakHfYt9TaESxDLRXf1pvyKAi
	 55s37wh2aG1UjRULP/w1S5t4bZyKrBVFjRJjnQE6osXDjTRnux/16PqyxDXZfDStmh
	 nsbUlfn5KBfM1iCapPMuOp6SG9e7PbbqZDzkeYmB+0FSjmL9thZLc69L785SqOqUtZ
	 OMrxuhcDcWh+A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE283806656;
	Fri, 20 Dec 2024 22:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] Fix NPE discovered by running bpf kselftest
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173473323379.3037384.4089610194127923528.git-patchwork-notify@kernel.org>
Date: Fri, 20 Dec 2024 22:20:33 +0000
References: <20241130-tcp-bpf-sendmsg-v1-0-bae583d014f3@outlook.com>
In-Reply-To: <20241130-tcp-bpf-sendmsg-v1-0-bae583d014f3@outlook.com>
To: Levi Zim via B4 Relay <devnull+rsworktech.outlook.com@kernel.org>
Cc: john.fastabend@gmail.com, jakub@cloudflare.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 dsahern@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, rsworktech@outlook.com

Hello:

This series was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Sat, 30 Nov 2024 21:38:21 +0800 you wrote:
> I found that bpf kselftest sockhash::test_txmsg_cork_hangs in
> test_sockmap.c triggers a kernel NULL pointer dereference:
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000008
>  ? __die_body+0x6e/0xb0
>  ? __die+0x8b/0xa0
>  ? page_fault_oops+0x358/0x3c0
>  ? local_clock+0x19/0x30
>  ? lock_release+0x11b/0x440
>  ? kernelmode_fixup_or_oops+0x54/0x60
>  ? __bad_area_nosemaphore+0x4f/0x210
>  ? mmap_read_unlock+0x13/0x30
>  ? bad_area_nosemaphore+0x16/0x20
>  ? do_user_addr_fault+0x6fd/0x740
>  ? prb_read_valid+0x1d/0x30
>  ? exc_page_fault+0x55/0xd0
>  ? asm_exc_page_fault+0x2b/0x30
>  ? splice_to_socket+0x52e/0x630
>  ? shmem_file_splice_read+0x2b1/0x310
>  direct_splice_actor+0x47/0x70
>  splice_direct_to_actor+0x133/0x300
>  ? do_splice_direct+0x90/0x90
>  do_splice_direct+0x64/0x90
>  ? __ia32_sys_tee+0x30/0x30
>  do_sendfile+0x214/0x300
>  __se_sys_sendfile64+0x8e/0xb0
>  __x64_sys_sendfile64+0x25/0x30
>  x64_sys_call+0xb82/0x2840
>  do_syscall_64+0x75/0x110
>  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> 
> [...]

Here is the summary with links:
  - [net,1/2] skmsg: return copied bytes in sk_msg_memcopy_from_iter
    https://git.kernel.org/bpf/bpf/c/fdf478d236dc
  - [net,2/2] tcp_bpf: fix copied value in tcp_bpf_sendmsg
    https://git.kernel.org/bpf/bpf/c/5153a75ef34b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



