Return-Path: <bpf+bounces-44951-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6177B9CDFA8
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 14:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B11BEB23426
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 13:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43211BDA99;
	Fri, 15 Nov 2024 13:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YKcvbYW/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F222F1B85F0;
	Fri, 15 Nov 2024 13:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731676382; cv=none; b=VByMV58dozskjVaNmsw7r0hJheNUbzOow5gy4ZkwHefxG5+uMcGk1H8f0RcNSkruKVeSmcPSpSYHOxDE+9ZW3bmr2U+eKYKiGj2B+AC2Bk4qkvuiuKsctKzlOCfgi5nxoheJYGzaBNtpPc4GOYuG4afXAyJGEZNtBPMEl/JMHpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731676382; c=relaxed/simple;
	bh=G5QZQ1AhxAgj20DWSm76n/XJ45IMxUtQpj1ePyESAIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pLBGRfrV2LHGeHYYp1y1xrtn1QG++75llaHFhSQ795yFs4SLnM/KA/Nzqz4/hR7ZxFzaStC9NBMKncra6aik+2hzzF6FzpeqJApklMhlENFjvmNhM3S9sctW6n20o3rhjf0gT9dIMi9xFLrux5/ZEwo3k9xyz8tEOCqdRKHncck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YKcvbYW/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB85BC4CECF;
	Fri, 15 Nov 2024 13:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731676381;
	bh=G5QZQ1AhxAgj20DWSm76n/XJ45IMxUtQpj1ePyESAIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YKcvbYW/o3DdAouGiODL5yskG6Q3oJw0fQN2rV8YaFhhVwNAW3D7ShkaKo7JFNVsp
	 KART63cqZZaSd/fmGgK8jRadTLLXlz+ZTQOPBAPM1Xe15st3sJYvoqhpEVbkl47i0F
	 rA9LRoVTsJxRWH9xPJqRfufI/mMnX8trH+zbB8Eg=
Date: Fri, 15 Nov 2024 14:12:57 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, netdev@vger.kernel.org,
	magnus.karlsson@intel.com, bjorn@kernel.org, jordyzomer@google.com,
	security@kernel.org
Subject: Re: [PATCH bpf 1/2] xsk: fix OOB map writes when deleting elements
Message-ID: <2024111544-grinning-daydream-e118@gregkh>
References: <20241115125348.654145-1-maciej.fijalkowski@intel.com>
 <20241115125348.654145-2-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115125348.654145-2-maciej.fijalkowski@intel.com>

On Fri, Nov 15, 2024 at 01:53:47PM +0100, Maciej Fijalkowski wrote:
> Jordy says:
> 
> "
> In the xsk_map_delete_elem function an unsigned integer
> (map->max_entries) is compared with a user-controlled signed integer
> (k). Due to implicit type conversion, a large unsigned value for
> map->max_entries can bypass the intended bounds check:
> 
> 	if (k >= map->max_entries)
> 		return -EINVAL;
> 
> This allows k to hold a negative value (between -2147483648 and -2),
> which is then used as an array index in m->xsk_map[k], which results
> in an out-of-bounds access.
> 
> 	spin_lock_bh(&m->lock);
> 	map_entry = &m->xsk_map[k]; // Out-of-bounds map_entry
> 	old_xs = unrcu_pointer(xchg(map_entry, NULL));  // Oob write
> 	if (old_xs)
> 		xsk_map_sock_delete(old_xs, map_entry);
> 	spin_unlock_bh(&m->lock);
> 
> The xchg operation can then be used to cause an out-of-bounds write.
> Moreover, the invalid map_entry passed to xsk_map_sock_delete can lead
> to further memory corruption.
> "
> 
> It indeed results in following splat:
> 
> [76612.897343] BUG: unable to handle page fault for address: ffffc8fc2e461108
> [76612.904330] #PF: supervisor write access in kernel mode
> [76612.909639] #PF: error_code(0x0002) - not-present page
> [76612.914855] PGD 0 P4D 0
> [76612.917431] Oops: Oops: 0002 [#1] PREEMPT SMP
> [76612.921859] CPU: 11 UID: 0 PID: 10318 Comm: a.out Not tainted 6.12.0-rc1+ #470
> [76612.929189] Hardware name: Intel Corporation S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0008.031920191559 03/19/2019
> [76612.939781] RIP: 0010:xsk_map_delete_elem+0x2d/0x60
> [76612.944738] Code: 00 00 41 54 55 53 48 63 2e 3b 6f 24 73 38 4c 8d a7 f8 00 00 00 48 89 fb 4c 89 e7 e8 2d bf 05 00 48 8d b4 eb 00 01 00 00 31 ff <48> 87 3e 48 85 ff 74 05 e8 16 ff ff ff 4c 89 e7 e8 3e bc 05 00 31
> [76612.963774] RSP: 0018:ffffc9002e407df8 EFLAGS: 00010246
> [76612.969079] RAX: 0000000000000000 RBX: ffffc9002e461000 RCX: 0000000000000000
> [76612.976323] RDX: 0000000000000001 RSI: ffffc8fc2e461108 RDI: 0000000000000000
> [76612.983569] RBP: ffffffff80000001 R08: 0000000000000000 R09: 0000000000000007
> [76612.990812] R10: ffffc9002e407e18 R11: ffff888108a38858 R12: ffffc9002e4610f8
> [76612.998060] R13: ffff888108a38858 R14: 00007ffd1ae0ac78 R15: ffffc9002e4610c0
> [76613.005303] FS:  00007f80b6f59740(0000) GS:ffff8897e0ec0000(0000) knlGS:0000000000000000
> [76613.013517] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [76613.019349] CR2: ffffc8fc2e461108 CR3: 000000011e3ef001 CR4: 00000000007726f0
> [76613.026595] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [76613.033841] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [76613.041086] PKRU: 55555554
> [76613.043842] Call Trace:
> [76613.046331]  <TASK>
> [76613.048468]  ? __die+0x20/0x60
> [76613.051581]  ? page_fault_oops+0x15a/0x450
> [76613.055747]  ? search_extable+0x22/0x30
> [76613.059649]  ? search_bpf_extables+0x5f/0x80
> [76613.063988]  ? exc_page_fault+0xa9/0x140
> [76613.067975]  ? asm_exc_page_fault+0x22/0x30
> [76613.072229]  ? xsk_map_delete_elem+0x2d/0x60
> [76613.076573]  ? xsk_map_delete_elem+0x23/0x60
> [76613.080914]  __sys_bpf+0x19b7/0x23c0
> [76613.084555]  __x64_sys_bpf+0x1a/0x20
> [76613.088194]  do_syscall_64+0x37/0xb0
> [76613.091832]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> [76613.096962] RIP: 0033:0x7f80b6d1e88d
> [76613.100592] Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 73 b5 0f 00 f7 d8 64 89 01 48
> [76613.119631] RSP: 002b:00007ffd1ae0ac68 EFLAGS: 00000206 ORIG_RAX: 0000000000000141
> [76613.131330] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f80b6d1e88d
> [76613.142632] RDX: 0000000000000098 RSI: 00007ffd1ae0ad20 RDI: 0000000000000003
> [76613.153967] RBP: 00007ffd1ae0adc0 R08: 0000000000000000 R09: 0000000000000000
> [76613.166030] R10: 00007f80b6f77040 R11: 0000000000000206 R12: 00007ffd1ae0aed8
> [76613.177130] R13: 000055ddf42ce1e9 R14: 000055ddf42d0d98 R15: 00007f80b6fab040
> [76613.188129]  </TASK>
> 
> Fix this by simply changing key type from int to u32.
> 
> Fixes: fbfc504a24f5 ("bpf: introduce new bpf AF_XDP map type BPF_MAP_TYPE_XSKMAP")
> Reported-by: Jordy Zomer <jordyzomer@google.com>
> Suggested-by: Jordy Zomer <jordyzomer@google.com>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  net/xdp/xskmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

