Return-Path: <bpf+bounces-44952-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E703E9CDFAB
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 14:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 281C51F243AD
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 13:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5222C1BDAAA;
	Fri, 15 Nov 2024 13:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lNnqCHSW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3A1192D8B;
	Fri, 15 Nov 2024 13:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731676395; cv=none; b=q8hP/WBLZr9gPEDbzeIVOQQt0JcS8aRNsfmBrF63q0VSCiNrgdl4jXhyUmgNprKci9nIIFDhUdT12xBGkS+eJfDkJLTmgwNruVFxNlux1WFM+dOvTDeUHiIb0T2PzCoXTymsl5fX9n0zy9PcoLvq/ZAUmYC8fciClraOBaaNn9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731676395; c=relaxed/simple;
	bh=ozD32IK5xa55e4YX1jnrRjLeqAhNIL3ofxjLF3f0V0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vDbq972GQfuy2GA/c1s5UoWfN0ZQ/UTQz6mBqThnIKxXuNaBawXFh9kXzgTaODLLVN1+Dixz1Um0JEV/uMnJiTzVFROkPYx3gcH9Wr0x+gAR4plRaW74PZXSWdL0tbf8gM4gNTJ022bhKvRu2X4iq4OOVDSFhRiGgP9UVsajubo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lNnqCHSW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA5BBC4CED4;
	Fri, 15 Nov 2024 13:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731676395;
	bh=ozD32IK5xa55e4YX1jnrRjLeqAhNIL3ofxjLF3f0V0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lNnqCHSW0sUbyXz4U7F5PV2MhttsFCQW6/+/+c3SV/K4Y7YiWv12Qznljvl6AtLHa
	 1bCDwY7uBQAWR+nQgPk0vQ7E84jsvoL+nYYFreWvftfwKv7Mjka3dgwQD1RbwaWA4Y
	 9VwNHx5KXnopPnuDAdkqAy/m1X9ENzdYAZkZaBAw=
Date: Fri, 15 Nov 2024 14:13:12 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, netdev@vger.kernel.org,
	magnus.karlsson@intel.com, bjorn@kernel.org, jordyzomer@google.com,
	security@kernel.org
Subject: Re: [PATCH bpf 2/2] bpf: fix OOB devmap writes when deleting elements
Message-ID: <2024111559-busily-bucktooth-d9a2@gregkh>
References: <20241115125348.654145-1-maciej.fijalkowski@intel.com>
 <20241115125348.654145-3-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115125348.654145-3-maciej.fijalkowski@intel.com>

On Fri, Nov 15, 2024 at 01:53:48PM +0100, Maciej Fijalkowski wrote:
> Jordy reported issue against XSKMAP which also applies to DEVMAP - the
> index used for accessing map entry, due to being a signed integer,
> causes the OOB writes. Fix is simple as changing the type from int to
> u32, however, when compared to XSKMAP case, one more thing needs to be
> addressed.
> 
> When map is released from system via dev_map_free(), we iterate through
> all of the entries and an iterator variable is also an int, which
> implies OOB accesses. Again, change it to be u32.
> 
> Example splat below:
> 
> [  160.724676] BUG: unable to handle page fault for address: ffffc8fc2c001000
> [  160.731662] #PF: supervisor read access in kernel mode
> [  160.736876] #PF: error_code(0x0000) - not-present page
> [  160.742095] PGD 0 P4D 0
> [  160.744678] Oops: Oops: 0000 [#1] PREEMPT SMP
> [  160.749106] CPU: 1 UID: 0 PID: 520 Comm: kworker/u145:12 Not tainted 6.12.0-rc1+ #487
> [  160.757050] Hardware name: Intel Corporation S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0008.031920191559 03/19/2019
> [  160.767642] Workqueue: events_unbound bpf_map_free_deferred
> [  160.773308] RIP: 0010:dev_map_free+0x77/0x170
> [  160.777735] Code: 00 e8 fd 91 ed ff e8 b8 73 ed ff 41 83 7d 18 19 74 6e 41 8b 45 24 49 8b bd f8 00 00 00 31 db 85 c0 74 48 48 63 c3 48 8d 04 c7 <48> 8b 28 48 85 ed 74 30 48 8b 7d 18 48 85 ff 74 05 e8 b3 52 fa ff
> [  160.796777] RSP: 0018:ffffc9000ee1fe38 EFLAGS: 00010202
> [  160.802086] RAX: ffffc8fc2c001000 RBX: 0000000080000000 RCX: 0000000000000024
> [  160.809331] RDX: 0000000000000000 RSI: 0000000000000024 RDI: ffffc9002c001000
> [  160.816576] RBP: 0000000000000000 R08: 0000000000000023 R09: 0000000000000001
> [  160.823823] R10: 0000000000000001 R11: 00000000000ee6b2 R12: dead000000000122
> [  160.831066] R13: ffff88810c928e00 R14: ffff8881002df405 R15: 0000000000000000
> [  160.838310] FS:  0000000000000000(0000) GS:ffff8897e0c40000(0000) knlGS:0000000000000000
> [  160.846528] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  160.852357] CR2: ffffc8fc2c001000 CR3: 0000000005c32006 CR4: 00000000007726f0
> [  160.859604] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  160.866847] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  160.874092] PKRU: 55555554
> [  160.876847] Call Trace:
> [  160.879338]  <TASK>
> [  160.881477]  ? __die+0x20/0x60
> [  160.884586]  ? page_fault_oops+0x15a/0x450
> [  160.888746]  ? search_extable+0x22/0x30
> [  160.892647]  ? search_bpf_extables+0x5f/0x80
> [  160.896988]  ? exc_page_fault+0xa9/0x140
> [  160.900973]  ? asm_exc_page_fault+0x22/0x30
> [  160.905232]  ? dev_map_free+0x77/0x170
> [  160.909043]  ? dev_map_free+0x58/0x170
> [  160.912857]  bpf_map_free_deferred+0x51/0x90
> [  160.917196]  process_one_work+0x142/0x370
> [  160.921272]  worker_thread+0x29e/0x3b0
> [  160.925082]  ? rescuer_thread+0x4b0/0x4b0
> [  160.929157]  kthread+0xd4/0x110
> [  160.932355]  ? kthread_park+0x80/0x80
> [  160.936079]  ret_from_fork+0x2d/0x50
> [  160.943396]  ? kthread_park+0x80/0x80
> [  160.950803]  ret_from_fork_asm+0x11/0x20
> [  160.958482]  </TASK>
> 
> Fixes: 546ac1ffb70d ("bpf: add devmap, a map for storing net device references")
> Reported-by: Jordy Zomer <jordyzomer@google.com>
> Suggested-by: Jordy Zomer <jordyzomer@google.com>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  kernel/bpf/devmap.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> index 7878be18e9d2..3aa002a47a96 100644
> --- a/kernel/bpf/devmap.c
> +++ b/kernel/bpf/devmap.c
> @@ -184,7 +184,7 @@ static struct bpf_map *dev_map_alloc(union bpf_attr *attr)
>  static void dev_map_free(struct bpf_map *map)
>  {
>  	struct bpf_dtab *dtab = container_of(map, struct bpf_dtab, map);
> -	int i;
> +	u32 i;
>  
>  	/* At this point bpf_prog->aux->refcnt == 0 and this map->refcnt == 0,
>  	 * so the programs (can be more than one that used this map) were
> @@ -821,7 +821,7 @@ static long dev_map_delete_elem(struct bpf_map *map, void *key)
>  {
>  	struct bpf_dtab *dtab = container_of(map, struct bpf_dtab, map);
>  	struct bpf_dtab_netdev *old_dev;
> -	int k = *(u32 *)key;
> +	u32 k = *(u32 *)key;
>  
>  	if (k >= map->max_entries)
>  		return -EINVAL;
> @@ -838,7 +838,7 @@ static long dev_map_hash_delete_elem(struct bpf_map *map, void *key)
>  {
>  	struct bpf_dtab *dtab = container_of(map, struct bpf_dtab, map);
>  	struct bpf_dtab_netdev *old_dev;
> -	int k = *(u32 *)key;
> +	u32 k = *(u32 *)key;
>  	unsigned long flags;
>  	int ret = -ENOENT;
>  
> -- 
> 2.34.1
> 
> 


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

