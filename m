Return-Path: <bpf+bounces-16715-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BF5804C81
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 09:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4142F1F21502
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 08:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD823C689;
	Tue,  5 Dec 2023 08:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWk68OgC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EF03D970;
	Tue,  5 Dec 2023 08:34:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A38ACC433C7;
	Tue,  5 Dec 2023 08:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701765260;
	bh=S+jEnDi0DYvRicPHFkbDYYg7tscTh0rePei/TRXtL1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EWk68OgCMcIzQjusJMpMiQc3iNYpt50iIcoH/RrCoIZbjt3/+l1WgSM3adTU/TmpY
	 1hEiyxDCKdpY7832J6k5NtCdAxmB5v7DYOvN7cyl9uaidtbZSZN1lGJy1t/KxfzgoZ
	 IH+j8nykya/tFwzt7alyVVg/gZpRPzgC2SuZp4R8rfUFIwhtimVYrl49oTe99rqmZa
	 9y8jMGeOaudT9pN4rYTo+MezQsy/bQvq5Az3dhJp6hVR5dqCQpZvI+PBqokSqbfPcX
	 Afm5EYzneVJNQzhUDyS40vN8y5SGGkwm3iFBEhqmQTa1xPVIZZfrvyx8Q+n6JlWrbu
	 EhftncYt8TjOw==
Date: Tue, 5 Dec 2023 08:34:15 +0000
From: Simon Horman <horms@kernel.org>
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de, dxu@dxuuu.xyz,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, coreteam@netfilter.org,
	netfilter-devel@vger.kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	ast@kernel.org
Subject: Re: [PATCH net] net/netfilter: bpf: fix bad registration on nf_defrag
Message-ID: <20231205083415.GQ50400@kernel.org>
References: <1701329003-14564-1-git-send-email-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1701329003-14564-1-git-send-email-alibuda@linux.alibaba.com>

On Thu, Nov 30, 2023 at 03:23:23PM +0800, D. Wythe wrote:
> From: "D. Wythe" <alibuda@linux.alibaba.com>
> 
> We should pass a pointer to global_hook to the get_proto_defrag_hook()
> instead of its value, since the passed value won't be updated even if
> the request module was loaded successfully.
> 
> Log:
> 
> [   54.915713] nf_defrag_ipv4 has bad registration
> [   54.915779] WARNING: CPU: 3 PID: 6323 at net/netfilter/nf_bpf_link.c:62 get_proto_defrag_hook+0x137/0x160
> [   54.915835] CPU: 3 PID: 6323 Comm: fentry Kdump: loaded Tainted: G            E      6.7.0-rc2+ #35
> [   54.915839] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
> [   54.915841] RIP: 0010:get_proto_defrag_hook+0x137/0x160
> [   54.915844] Code: 4f 8c e8 2c cf 68 ff 80 3d db 83 9a 01 00 0f 85 74 ff ff ff 48 89 ee 48 c7 c7 8f 12 4f 8c c6 05 c4 83 9a 01 01 e8 09 ee 5f ff <0f> 0b e9 57 ff ff ff 49 8b 3c 24 4c 63 e5 e8 36 28 6c ff 4c 89 e0
> [   54.915849] RSP: 0018:ffffb676003fbdb0 EFLAGS: 00010286
> [   54.915852] RAX: 0000000000000023 RBX: ffff9596503d5600 RCX: ffff95996fce08c8
> [   54.915854] RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff95996fce08c0
> [   54.915855] RBP: ffffffff8c4f12de R08: 0000000000000000 R09: 00000000fffeffff
> [   54.915859] R10: ffffb676003fbc70 R11: ffffffff8d363ae8 R12: 0000000000000000
> [   54.915861] R13: ffffffff8e1f75c0 R14: ffffb676003c9000 R15: 00007ffd15e78ef0
> [   54.915864] FS:  00007fb6e9cab740(0000) GS:ffff95996fcc0000(0000) knlGS:0000000000000000
> [   54.915867] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   54.915868] CR2: 00007ffd15e75c40 CR3: 0000000101e62006 CR4: 0000000000360ef0
> [   54.915870] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   54.915871] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   54.915873] Call Trace:
> [   54.915891]  <TASK>
> [   54.915894]  ? __warn+0x84/0x140
> [   54.915905]  ? get_proto_defrag_hook+0x137/0x160
> [   54.915908]  ? __report_bug+0xea/0x100
> [   54.915925]  ? report_bug+0x2b/0x80
> [   54.915928]  ? handle_bug+0x3c/0x70
> [   54.915939]  ? exc_invalid_op+0x18/0x70
> [   54.915942]  ? asm_exc_invalid_op+0x1a/0x20
> [   54.915948]  ? get_proto_defrag_hook+0x137/0x160
> [   54.915950]  bpf_nf_link_attach+0x1eb/0x240
> [   54.915953]  link_create+0x173/0x290
> [   54.915969]  __sys_bpf+0x588/0x8f0
> [   54.915974]  __x64_sys_bpf+0x20/0x30
> [   54.915977]  do_syscall_64+0x45/0xf0
> [   54.915989]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
> [   54.915998] RIP: 0033:0x7fb6e9daa51d
> [   54.916001] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 2b 89 0c 00 f7 d8 64 89 01 48
> [   54.916003] RSP: 002b:00007ffd15e78ed8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> [   54.916006] RAX: ffffffffffffffda RBX: 00007ffd15e78fc0 RCX: 00007fb6e9daa51d
> [   54.916007] RDX: 0000000000000040 RSI: 00007ffd15e78ef0 RDI: 000000000000001c
> [   54.916009] RBP: 000000000000002d R08: 00007fb6e9e73a60 R09: 0000000000000001
> [   54.916010] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000006
> [   54.916012] R13: 0000000000000006 R14: 0000000000000000 R15: 0000000000000000
> [   54.916014]  </TASK>
> [   54.916015] ---[ end trace 0000000000000000 ]---
> 
> Fixes: 91721c2d02d3 ("netfilter: bpf: Support BPF_F_NETFILTER_IP_DEFRAG in netfilter link")
> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>

Reviewed-by: Simon Horman <horms@kernel.org>


