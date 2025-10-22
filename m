Return-Path: <bpf+bounces-71837-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE39DBFDD0A
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 20:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 849EC18C6EE2
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 18:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1A972629;
	Wed, 22 Oct 2025 18:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IEQcAg6u";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oaikgD6H";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iSRKPkya";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ctXcTiKz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367D733DECE
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 18:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761157533; cv=none; b=rWaiAL6Ut3SP7SRs+Tni7x9MmjrtOwa7D/kqNwu0hrhQrcq73q4fdH/e3ItxAIeoyT6A/efwsUAWVI+8fuRoP1ztPtXUMoRT23RDFUrQzkhEU6yQHi1lCHjoFbsSB+t54Ogjhi+svFNgwU1daX78A3hkWQM7FCJDYf5X3Qveu/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761157533; c=relaxed/simple;
	bh=XbD7dw98fNoWEVrr2LFnAlDmr2SnP1gkippzM6piiEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e/4GzvrWFOMVbZvoj4Gnv9IUbVkSgd/9B2BNeOUL+2/hMnv4egmHvZDn5sR9S6to+nor1MprLy7Eo9spEbi6InfMuCHf+dsLSsIfi4+W4q8zW6nDbHXArqOPKh+YD6hv9g7iUBIN4xg2Dk+gi6qnrO/DwxgHO7A3cGGebK6wNOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IEQcAg6u; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oaikgD6H; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iSRKPkya; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ctXcTiKz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1EC241F395;
	Wed, 22 Oct 2025 18:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761157525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x2wjTx12vkWJdcIYkIG0o1d7T1MHz7dILrXhb+x09qw=;
	b=IEQcAg6u2cksyvRJOy1ZPR2pbf4nb7eacwqcAxgBxHOxoIT4ShIco8Vq4bBGJA2EWwHDj6
	TVsrUCjJxnWcqi/WVdIJtu8GcJkeXmXk3jfcyVN6+s5FhxES33Ec8m+Yanfs11DQokdOTb
	8MCnO6n6ELKX4gS8DAgwRzDdgSUakl0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761157525;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x2wjTx12vkWJdcIYkIG0o1d7T1MHz7dILrXhb+x09qw=;
	b=oaikgD6HKdRheoaJZfBGpLezgEWNISXZJ3Vg1aN+rd3hsj4QHwKDNCut/eiTK9PJLtAx3u
	r+dRWtE8GoALqbCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761157521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x2wjTx12vkWJdcIYkIG0o1d7T1MHz7dILrXhb+x09qw=;
	b=iSRKPkyayPAiB4UeKYmArJD5+QEg9i2G2S8WyQTLK3lSbnX8GbP/QiHm7DRwnkEFyBao/N
	/IxV1NzKnJvPsq+3/R+WWQ72XkzXXFmImbB4L3pFLs2TpDJ1iXhpH4jFNvt/nYHxUXCpQk
	4uHr4hR9ei7VMLRCeLbf6I2rTaTah1U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761157521;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x2wjTx12vkWJdcIYkIG0o1d7T1MHz7dILrXhb+x09qw=;
	b=ctXcTiKzKOYDVAsEzTBW1Gg1856fT2ZsWM/G3dM+loePtNTiCzzO6wBRuOummSPwVMsS16
	Cg1DJh7hsaqJ+dBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 92EA11339F;
	Wed, 22 Oct 2025 18:25:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id h6CKIJAh+Wj/BAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 22 Oct 2025 18:25:20 +0000
Message-ID: <a0b39fda-4aca-44e3-a178-4bad431243c5@suse.de>
Date: Wed, 22 Oct 2025 20:24:58 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] xsk: avoid data corruption on cq descriptor number
To: netdev@vger.kernel.org
Cc: csmate@nop.hu, kerneljasonxing@gmail.com, maciej.fijalkowski@intel.com,
 bjorn@kernel.org, sdf@fomichev.me, jonathan.lemon@gmail.com,
 bpf@vger.kernel.org
References: <20251021150656.6704-1-fmancera@suse.de>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20251021150656.6704-1-fmancera@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[8];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[nop.hu,gmail.com,intel.com,kernel.org,fomichev.me,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.80



On 10/21/25 5:06 PM, Fernando Fernandez Mancera wrote:
> Since commit 30f241fcf52a ("xsk: Fix immature cq descriptor
> production"), the descriptor number is store in skb control block and
> xsk_cq_submit_addr_locked() relies on it to put the umem addrs onto
> pool's completion queue.
> 
> skb control block shouldn't be used for this purpose as after transmit
> xsk doesn't have control over it and other subsystems could use it. This
> leads to the following kernel panic due to a NULL pointer dereference.
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   PGD 0 P4D 0
>   Oops: Oops: 0000 [#1] SMP NOPTI
>   CPU: 2 UID: 1 PID: 927 Comm: p4xsk.bin Not tainted 6.16.12+deb14-cloud-amd64 #1 PREEMPT(lazy)  Debian 6.16.12-1
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
>   RIP: 0010:xsk_destruct_skb+0xd0/0x180
>   [...]
>   Call Trace:
>    <IRQ>
>    ? napi_complete_done+0x7a/0x1a0
>    ip_rcv_core+0x1bb/0x340
>    ip_rcv+0x30/0x1f0
>    __netif_receive_skb_one_core+0x85/0xa0
>    process_backlog+0x87/0x130
>    __napi_poll+0x28/0x180
>    net_rx_action+0x339/0x420
>    handle_softirqs+0xdc/0x320
>    ? handle_edge_irq+0x90/0x1e0
>    do_softirq.part.0+0x3b/0x60
>    </IRQ>
>    <TASK>
>    __local_bh_enable_ip+0x60/0x70
>    __dev_direct_xmit+0x14e/0x1f0
>    __xsk_generic_xmit+0x482/0xb70
>    ? __remove_hrtimer+0x41/0xa0
>    ? __xsk_generic_xmit+0x51/0xb70
>    ? _raw_spin_unlock_irqrestore+0xe/0x40
>    xsk_sendmsg+0xda/0x1c0
>    __sys_sendto+0x1ee/0x200
>    __x64_sys_sendto+0x24/0x30
>    do_syscall_64+0x84/0x2f0
>    ? __pfx_pollwake+0x10/0x10
>    ? __rseq_handle_notify_resume+0xad/0x4c0
>    ? restore_fpregs_from_fpstate+0x3c/0x90
>    ? switch_fpu_return+0x5b/0xe0
>    ? do_syscall_64+0x204/0x2f0
>    ? do_syscall_64+0x204/0x2f0
>    ? do_syscall_64+0x204/0x2f0
>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>    </TASK>
>   [...]
>   Kernel panic - not syncing: Fatal exception in interrupt
>   Kernel Offset: 0x1c000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> 
> The approach proposed store the first address also in the xsk_addr_node
> along with the number of descriptors. The head xsk_addr_node is
> referenced by skb_shinfo(skb)->destructor_arg. The rest of the fragments
> store the address on the list.
> 
> This is less efficient as the kmem_cache must be initialized even if a
> single fragment is received and also 4 bytes are wasted when storing
> each address.
> 
> Fixes: 30f241fcf52a ("xsk: Fix immature cq descriptor production")
> Closes: https://lore.kernel.org/netdev/0435b904-f44f-48f8-afb0-68868474bf1c@nop.hu/
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> ---
> Note: Please notice I am not an XDP expert so I cannot tell if this
> would cause a performance regression, advice is welcomed.
> ---
>   net/xdp/xsk.c | 57 ++++++++++++++++++++++++++++++---------------------
>   1 file changed, 34 insertions(+), 23 deletions(-)
> 
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 7b0c68a70888..203934aeade6 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -37,18 +37,14 @@
>   #define MAX_PER_SOCKET_BUDGET 32
>   
>   struct xsk_addr_node {
> +	u32 num_descs;
>   	u64 addr;
>   	struct list_head addr_node;
>   };
>   
> -struct xsk_addr_head {
> -	u32 num_descs;
> -	struct list_head addrs_list;
> -};
> -
>   static struct kmem_cache *xsk_tx_generic_cache;
>   

FWIW, if the 4 bytes wasted for each umem address other than the initial 
one is too much, we can add another kmem_cache for just the xsk_addr_head..

