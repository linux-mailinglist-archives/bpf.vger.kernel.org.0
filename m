Return-Path: <bpf+bounces-68383-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD805B5787F
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 13:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BAFC16F490
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 11:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBB0302CAA;
	Mon, 15 Sep 2025 11:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FOcXWYOJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FE1302776
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 11:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757935807; cv=none; b=o86UDP+jPW5WvVnMZQRMQdrY4RGK2eEaKy5I52fKnqQQqOJYtkRwCylaZdGKSA0sfdHzu/4ySJDAhwYzykh1A+CuCFdyMR8DEddDg5MHRqg6eE7ZMdx5s2zfQcoLH394s6SjeevKtK2+JF4lSDeawXGkm5T6A+G4hqMmFM5DExQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757935807; c=relaxed/simple;
	bh=EofV7MWcaoULPmVM3l1hDLo0abjEMWXWU4I9ukTS6To=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KelyI/c3YHV+r6pMERWSqa2uiBOw3ck4HW3sqaQtN7dHy4xEIE64T5X19PPqdoaaGx9BMZ8ey/ul+6uGBbDPgvD8hsoi/JATPfbd453aot/0dudv0J8BdYcYeuHJsk0ynUpUWuL4wfr0f+k9wgYzx8Xe50PBMb7tOwEWsFthYss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FOcXWYOJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33520C4CEF1;
	Mon, 15 Sep 2025 11:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757935807;
	bh=EofV7MWcaoULPmVM3l1hDLo0abjEMWXWU4I9ukTS6To=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FOcXWYOJ8EjmejDdgpDhB4wkSxch2Y6F7LoCXMgPP5veK4zNJ4f/sjr/QT2I78Sky
	 Dr1kZ2xj5KC9LRe/pCZAIqd+obanlmYpnsspxB/1KeClM4JxraNwt+McR+ZmQrbWAZ
	 soM8Sydd6ZyiRCKd3llOj/rTrk4WhkP9NMMs9+bN73K3CXzWQWW11kTeEU8fCpNoHF
	 bzfzlBm5j58wh6ZHPpiCziGQEjNRD/Oaqxr3376IvXcOuEHL8N0Tm5bdgwU72xFgxs
	 uFHrOVsPzn2TW2lXPRrWwEsgZCWc1nbZA9zMlAg9tJdVsU1uDd/C8nnsKqZXdsWR1C
	 8wWjGEQxDM3gg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC44383BF6C;
	Mon, 15 Sep 2025 11:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] riscv,
 bpf: Sign extend struct ops return values properly
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175793580854.4119003.9326711065064953061.git-patchwork-notify@kernel.org>
Date: Mon, 15 Sep 2025 11:30:08 +0000
References: <20250908012448.1695-1-hengqi.chen@gmail.com>
In-Reply-To: <20250908012448.1695-1-hengqi.chen@gmail.com>
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, bjorn@kernel.org, pulehui@huawei.com,
 puranjay@kernel.org, bpf@vger.kernel.org, linux-riscv@lists.infradead.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon,  8 Sep 2025 01:24:48 +0000 you wrote:
> The ns_bpf_qdisc selftest triggers a kernel panic:
> 
>     Unable to handle kernel paging request at virtual address ffffffffa38dbf58
>     Current test_progs pgtable: 4K pagesize, 57-bit VAs, pgdp=0x00000001109cc000
>     [ffffffffa38dbf58] pgd=000000011fffd801, p4d=000000011fffd401, pud=000000011fffd001, pmd=0000000000000000
>     Oops [#1]
>     Modules linked in: bpf_testmod(OE) xt_conntrack nls_iso8859_1 dm_mod drm drm_panel_orientation_quirks configfs backlight btrfs blake2b_generic xor lzo_compress zlib_deflate raid6_pq efivarfs [last unloaded: bpf_testmod(OE)]
>     CPU: 1 UID: 0 PID: 23584 Comm: test_progs Tainted: G        W  OE       6.17.0-rc1-g2465bb83e0b4 #1 NONE
>     Tainted: [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
>     Hardware name: Unknown Unknown Product/Unknown Product, BIOS 2024.01+dfsg-1ubuntu5.1 01/01/2024
>     epc : __qdisc_run+0x82/0x6f0
>      ra : __qdisc_run+0x6e/0x6f0
>     epc : ffffffff80bd5c7a ra : ffffffff80bd5c66 sp : ff2000000eecb550
>      gp : ffffffff82472098 tp : ff60000096895940 t0 : ffffffff8001f180
>      t1 : ffffffff801e1664 t2 : 0000000000000000 s0 : ff2000000eecb5d0
>      s1 : ff60000093a6a600 a0 : ffffffffa38dbee8 a1 : 0000000000000001
>      a2 : ff2000000eecb510 a3 : 0000000000000001 a4 : 0000000000000000
>      a5 : 0000000000000010 a6 : 0000000000000000 a7 : 0000000000735049
>      s2 : ffffffffa38dbee8 s3 : 0000000000000040 s4 : ff6000008bcda000
>      s5 : 0000000000000008 s6 : ff60000093a6a680 s7 : ff60000093a6a6f0
>      s8 : ff60000093a6a6ac s9 : ff60000093140000 s10: 0000000000000000
>      s11: ff2000000eecb9d0 t3 : 0000000000000000 t4 : 0000000000ff0000
>      t5 : 0000000000000000 t6 : ff60000093a6a8b6
>     status: 0000000200000120 badaddr: ffffffffa38dbf58 cause: 000000000000000d
>     [<ffffffff80bd5c7a>] __qdisc_run+0x82/0x6f0
>     [<ffffffff80b6fe58>] __dev_queue_xmit+0x4c0/0x1128
>     [<ffffffff80b80ae0>] neigh_resolve_output+0xd0/0x170
>     [<ffffffff80d2daf6>] ip6_finish_output2+0x226/0x6c8
>     [<ffffffff80d31254>] ip6_finish_output+0x10c/0x2a0
>     [<ffffffff80d31446>] ip6_output+0x5e/0x178
>     [<ffffffff80d2e232>] ip6_xmit+0x29a/0x608
>     [<ffffffff80d6f4c6>] inet6_csk_xmit+0xe6/0x140
>     [<ffffffff80c985e4>] __tcp_transmit_skb+0x45c/0xaa8
>     [<ffffffff80c995fe>] tcp_connect+0x9ce/0xd10
>     [<ffffffff80d66524>] tcp_v6_connect+0x4ac/0x5e8
>     [<ffffffff80cc19b8>] __inet_stream_connect+0xd8/0x318
>     [<ffffffff80cc1c36>] inet_stream_connect+0x3e/0x68
>     [<ffffffff80b42b20>] __sys_connect_file+0x50/0x88
>     [<ffffffff80b42bee>] __sys_connect+0x96/0xc8
>     [<ffffffff80b42c40>] __riscv_sys_connect+0x20/0x30
>     [<ffffffff80e5bcae>] do_trap_ecall_u+0x256/0x378
>     [<ffffffff80e69af2>] handle_exception+0x14a/0x156
>     Code: 892a 0363 1205 489c 8bc1 c7e5 2d03 084a 2703 080a (2783) 0709
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] riscv, bpf: Sign extend struct ops return values properly
    https://git.kernel.org/bpf/bpf-next/c/fd2e08128944

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



