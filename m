Return-Path: <bpf+bounces-73150-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEE7C2458D
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 11:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2F26B34FD49
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 10:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B793346BC;
	Fri, 31 Oct 2025 10:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="c/38MvuB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/RLGaen5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="b1GpNx/E";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5nAKdXbL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B190334363
	for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 10:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761905130; cv=none; b=nA5XSTHnX3Qk1y3BeWBPVIMwmTp1lsENuZHiQ4eD9OfKVV9T7Phr5h/PzzCDkctoOZ/i25BFz9s9kzY0eTyak5tSOywDaUo2XiehNGnP7ysP6JaMRofvekepq3Ykg4ADP2oK+8j5VJxHPYGZC7/YL0uLw25fKTKbht24v7h4+dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761905130; c=relaxed/simple;
	bh=QLFX3eaXUzzXFRkR0BlefJnB4jzJ00sAiea2giBoQFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lub5zIDfrA6WjTCyqf+iigNVBow6Ad/OYGrFylrMqNKrEOpJZGUmTqxUy0jHDTd0wpWDHDrdWvHo1GNgMja1jV4onsat8oOQz/Fm/bFbUMsbGP+BbTRbdZbRpKKMuSZLs70+xpDTbzbNc8P4g7k7JxSk+00lWOI0rl73vMm7XN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=c/38MvuB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/RLGaen5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=b1GpNx/E; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5nAKdXbL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F021422A28;
	Fri, 31 Oct 2025 10:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761905125; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R9v75Y/I2jKSpzwI504rV+CZQOg4mQBUktiuB5VRVBc=;
	b=c/38MvuBTxSSTfyglmey1ffP9EIqA1W8WDiWybmrhSu4ogwkJtJzTt/mv4AYoxYXtVI2sJ
	mfQP7OiOJzRVoIsN9zc1OOBu8xw1ze+8Xx7+dVz/bip4D/53pvwr1H2LJl7Llk1o201580
	bTpHONgXPvJ9hciO+UspON/IDe6BiI0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761905125;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R9v75Y/I2jKSpzwI504rV+CZQOg4mQBUktiuB5VRVBc=;
	b=/RLGaen5sEqOs3P2kzrc/xVSzaagP2DIBjU5tDxmFulv0BL5txG+TSfu0CyQR9q55G2M1l
	YyaS8BG4Pqp2GQBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="b1GpNx/E";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=5nAKdXbL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761905124; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R9v75Y/I2jKSpzwI504rV+CZQOg4mQBUktiuB5VRVBc=;
	b=b1GpNx/EgVB5B1JZDEcYXuV0druey20EHMRkdGuRM/wI3BZ18KdaEnDZUqvDGeeBdHt6fF
	JuQh0oWzzpvQPxwkwiQZgSnPAXMJq8WGdFcHWVtR9do889jRgyAjCF0F9xjNNOi7ebz663
	EHRWP7OdicviHBk4qJwA/bLVzAQIM6o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761905124;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R9v75Y/I2jKSpzwI504rV+CZQOg4mQBUktiuB5VRVBc=;
	b=5nAKdXbLeL7Y9pfAQ9MjEGBUom/DLzUeuy+Y3W/Z1zmMH+g/CBoezYwrlzh15ckz1xZSqG
	DcPr1APTREivWTBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3B53B13991;
	Fri, 31 Oct 2025 10:05:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wuaiC+SJBGlBfgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Fri, 31 Oct 2025 10:05:24 +0000
Message-ID: <9fa46203-cafb-4def-9c09-e589491f9f65@suse.de>
Date: Fri, 31 Oct 2025 11:05:18 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] xsk: avoid data corruption on cq descriptor number
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: netdev@vger.kernel.org, csmate@nop.hu, maciej.fijalkowski@intel.com,
 bjorn@kernel.org, sdf@fomichev.me, jonathan.lemon@gmail.com,
 bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
References: <20251030140355.4059-1-fmancera@suse.de>
 <CAL+tcoB9AUGLafYF0rMs7-+wFJPrTUzf1cbwy4R_hc_7Zs9B3Q@mail.gmail.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <CAL+tcoB9AUGLafYF0rMs7-+wFJPrTUzf1cbwy4R_hc_7Zs9B3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F021422A28
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,nop.hu,intel.com,kernel.org,fomichev.me,gmail.com,davemloft.net,google.com,redhat.com];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,suse.de:dkim]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 



On 10/31/25 10:51 AM, Jason Xing wrote:
> On Thu, Oct 30, 2025 at 10:04 PM Fernando Fernandez Mancera
> <fmancera@suse.de> wrote:
>>
>> Since commit 30f241fcf52a ("xsk: Fix immature cq descriptor
>> production"), the descriptor number is stored in skb control block and
>> xsk_cq_submit_addr_locked() relies on it to put the umem addrs onto
>> pool's completion queue.
>>
>> skb control block shouldn't be used for this purpose as after transmit
>> xsk doesn't have control over it and other subsystems could use it. This
>> leads to the following kernel panic due to a NULL pointer dereference.
>>
>>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>>   #PF: supervisor read access in kernel mode
>>   #PF: error_code(0x0000) - not-present page
>>   PGD 0 P4D 0
>>   Oops: Oops: 0000 [#1] SMP NOPTI
>>   CPU: 2 UID: 1 PID: 927 Comm: p4xsk.bin Not tainted 6.16.12+deb14-cloud-amd64 #1 PREEMPT(lazy)  Debian 6.16.12-1
>>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
>>   RIP: 0010:xsk_destruct_skb+0xd0/0x180
>>   [...]
>>   Call Trace:
>>    <IRQ>
>>    ? napi_complete_done+0x7a/0x1a0
>>    ip_rcv_core+0x1bb/0x340
>>    ip_rcv+0x30/0x1f0
>>    __netif_receive_skb_one_core+0x85/0xa0
>>    process_backlog+0x87/0x130
>>    __napi_poll+0x28/0x180
>>    net_rx_action+0x339/0x420
>>    handle_softirqs+0xdc/0x320
>>    ? handle_edge_irq+0x90/0x1e0
>>    do_softirq.part.0+0x3b/0x60
>>    </IRQ>
>>    <TASK>
>>    __local_bh_enable_ip+0x60/0x70
>>    __dev_direct_xmit+0x14e/0x1f0
>>    __xsk_generic_xmit+0x482/0xb70
>>    ? __remove_hrtimer+0x41/0xa0
>>    ? __xsk_generic_xmit+0x51/0xb70
>>    ? _raw_spin_unlock_irqrestore+0xe/0x40
>>    xsk_sendmsg+0xda/0x1c0
>>    __sys_sendto+0x1ee/0x200
>>    __x64_sys_sendto+0x24/0x30
>>    do_syscall_64+0x84/0x2f0
>>    ? __pfx_pollwake+0x10/0x10
>>    ? __rseq_handle_notify_resume+0xad/0x4c0
>>    ? restore_fpregs_from_fpstate+0x3c/0x90
>>    ? switch_fpu_return+0x5b/0xe0
>>    ? do_syscall_64+0x204/0x2f0
>>    ? do_syscall_64+0x204/0x2f0
>>    ? do_syscall_64+0x204/0x2f0
>>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>    </TASK>
>>   [...]
>>   Kernel panic - not syncing: Fatal exception in interrupt
>>   Kernel Offset: 0x1c000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
>>
>> Instead use the skb destructor_arg pointer along with pointer tagging.
>> As pointers are always aligned to 8B, use the bottom bit to indicate
>> whether this a single address or an allocated struct containing several
>> addresses.
>>
>> Fixes: 30f241fcf52a ("xsk: Fix immature cq descriptor production")
>> Closes: https://lore.kernel.org/netdev/0435b904-f44f-48f8-afb0-68868474bf1c@nop.hu/
>> Suggested-by: Jakub Kicinski <kuba@kernel.org>
>> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> 
> I don't think we need this fix anymore if we can apply the series[1].
> The fix I just proposed doesn't use any new bits to store something so
> the problem will disappear.
> 
> [1]: https://lore.kernel.org/all/20251031093230.82386-1-kerneljasonxing@gmail.com/
> 
> Thanks,
> Jason
> 

Right. Then let's consider this patch dropped.

Thanks,
Fernando.

>> ---
>> v2: remove some leftovers on skb_build and simplify fragmented traffic
>> logic
>>
>> v3: drop skb extension approach, instead use pointer tagging in
>> destructor_arg to know whether we have a single address or an allocated
>> struct with multiple ones. Also, move from bpf to net as requested
>>
>> Note: tested with the crash reproducer and xdpsock tool
>> ---
>>   net/xdp/xsk.c | 130 ++++++++++++++++++++++++++++----------------------
>>   1 file changed, 74 insertions(+), 56 deletions(-)
>>
>> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
>> index 7b0c68a70888..d7354a3e2545 100644
>> --- a/net/xdp/xsk.c
>> +++ b/net/xdp/xsk.c
>> @@ -36,20 +36,13 @@
>>   #define TX_BATCH_SIZE 32
>>   #define MAX_PER_SOCKET_BUDGET 32
>>
>> -struct xsk_addr_node {
>> -       u64 addr;
>> -       struct list_head addr_node;
>> -};
>> -
>> -struct xsk_addr_head {
>> +struct xsk_addrs {
>>          u32 num_descs;
>> -       struct list_head addrs_list;
>> +       u64 addrs[MAX_SKB_FRAGS + 1];
>>   };
>>
>>   static struct kmem_cache *xsk_tx_generic_cache;
>>
>> -#define XSKCB(skb) ((struct xsk_addr_head *)((skb)->cb))
>> -
>>   void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool)
>>   {
>>          if (pool->cached_need_wakeup & XDP_WAKEUP_RX)
>> @@ -558,29 +551,53 @@ static int xsk_cq_reserve_locked(struct xsk_buff_pool *pool)
>>          return ret;
>>   }
>>
>> +static bool xsk_skb_destructor_is_addr(struct sk_buff *skb)
>> +{
>> +       return (uintptr_t)skb_shinfo(skb)->destructor_arg & 0x1UL;
>> +}
>> +
>> +static u64 xsk_skb_destructor_get_addr(struct sk_buff *skb)
>> +{
>> +       return (u64)((uintptr_t)skb_shinfo(skb)->destructor_arg & ~0x1UL);
>> +}
>> +
>> +static u32 xsk_get_num_desc(struct sk_buff *skb)
>> +{
>> +       struct xsk_addrs *xsk_addr;
>> +
>> +       if (xsk_skb_destructor_is_addr(skb))
>> +               return 1;
>> +
>> +       xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
>> +
>> +       return xsk_addr->num_descs;
>> +}
>> +
>>   static void xsk_cq_submit_addr_locked(struct xsk_buff_pool *pool,
>>                                        struct sk_buff *skb)
>>   {
>> -       struct xsk_addr_node *pos, *tmp;
>> +       u32 num_descs = xsk_get_num_desc(skb);
>> +       struct xsk_addrs *xsk_addr;
>>          u32 descs_processed = 0;
>>          unsigned long flags;
>> -       u32 idx;
>> +       u32 idx, i;
>>
>>          spin_lock_irqsave(&pool->cq_lock, flags);
>>          idx = xskq_get_prod(pool->cq);
>>
>> -       xskq_prod_write_addr(pool->cq, idx,
>> -                            (u64)(uintptr_t)skb_shinfo(skb)->destructor_arg);
>> -       descs_processed++;
>> +       if (unlikely(num_descs > 1)) {
>> +               xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
>>
>> -       if (unlikely(XSKCB(skb)->num_descs > 1)) {
>> -               list_for_each_entry_safe(pos, tmp, &XSKCB(skb)->addrs_list, addr_node) {
>> +               for (i = 0; i < num_descs; i++) {
>>                          xskq_prod_write_addr(pool->cq, idx + descs_processed,
>> -                                            pos->addr);
>> +                                            xsk_addr->addrs[i]);
>>                          descs_processed++;
>> -                       list_del(&pos->addr_node);
>> -                       kmem_cache_free(xsk_tx_generic_cache, pos);
>>                  }
>> +               kmem_cache_free(xsk_tx_generic_cache, xsk_addr);
>> +       } else {
>> +               xskq_prod_write_addr(pool->cq, idx,
>> +                                    xsk_skb_destructor_get_addr(skb));
>> +               descs_processed++;
>>          }
>>          xskq_prod_submit_n(pool->cq, descs_processed);
>>          spin_unlock_irqrestore(&pool->cq_lock, flags);
>> @@ -595,16 +612,6 @@ static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
>>          spin_unlock_irqrestore(&pool->cq_lock, flags);
>>   }
>>
>> -static void xsk_inc_num_desc(struct sk_buff *skb)
>> -{
>> -       XSKCB(skb)->num_descs++;
>> -}
>> -
>> -static u32 xsk_get_num_desc(struct sk_buff *skb)
>> -{
>> -       return XSKCB(skb)->num_descs;
>> -}
>> -
>>   static void xsk_destruct_skb(struct sk_buff *skb)
>>   {
>>          struct xsk_tx_metadata_compl *compl = &skb_shinfo(skb)->xsk_meta;
>> @@ -621,27 +628,22 @@ static void xsk_destruct_skb(struct sk_buff *skb)
>>   static void xsk_skb_init_misc(struct sk_buff *skb, struct xdp_sock *xs,
>>                                u64 addr)
>>   {
>> -       BUILD_BUG_ON(sizeof(struct xsk_addr_head) > sizeof(skb->cb));
>> -       INIT_LIST_HEAD(&XSKCB(skb)->addrs_list);
>>          skb->dev = xs->dev;
>>          skb->priority = READ_ONCE(xs->sk.sk_priority);
>>          skb->mark = READ_ONCE(xs->sk.sk_mark);
>> -       XSKCB(skb)->num_descs = 0;
>>          skb->destructor = xsk_destruct_skb;
>> -       skb_shinfo(skb)->destructor_arg = (void *)(uintptr_t)addr;
>> +       skb_shinfo(skb)->destructor_arg = (void *)((uintptr_t)addr | 0x1UL);
>>   }
>>
>>   static void xsk_consume_skb(struct sk_buff *skb)
>>   {
>>          struct xdp_sock *xs = xdp_sk(skb->sk);
>>          u32 num_descs = xsk_get_num_desc(skb);
>> -       struct xsk_addr_node *pos, *tmp;
>> +       struct xsk_addrs *xsk_addr;
>>
>>          if (unlikely(num_descs > 1)) {
>> -               list_for_each_entry_safe(pos, tmp, &XSKCB(skb)->addrs_list, addr_node) {
>> -                       list_del(&pos->addr_node);
>> -                       kmem_cache_free(xsk_tx_generic_cache, pos);
>> -               }
>> +               xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
>> +               kmem_cache_free(xsk_tx_generic_cache, xsk_addr);
>>          }
>>
>>          skb->destructor = sock_wfree;
>> @@ -701,7 +703,6 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
>>   {
>>          struct xsk_buff_pool *pool = xs->pool;
>>          u32 hr, len, ts, offset, copy, copied;
>> -       struct xsk_addr_node *xsk_addr;
>>          struct sk_buff *skb = xs->skb;
>>          struct page *page;
>>          void *buffer;
>> @@ -727,16 +728,27 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
>>                                  return ERR_PTR(err);
>>                  }
>>          } else {
>> -               xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache, GFP_KERNEL);
>> -               if (!xsk_addr)
>> -                       return ERR_PTR(-ENOMEM);
>> +               struct xsk_addrs *xsk_addr;
>> +
>> +               if (xsk_skb_destructor_is_addr(skb)) {
>> +                       xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache,
>> +                                                    GFP_KERNEL);
>> +                       if (!xsk_addr)
>> +                               return ERR_PTR(-ENOMEM);
>> +
>> +                       xsk_addr->num_descs = 1;
>> +                       xsk_addr->addrs[0] = xsk_skb_destructor_get_addr(skb);
>> +                       skb_shinfo(skb)->destructor_arg = (void *)xsk_addr;
>> +               } else {
>> +                       xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
>> +               }
>>
>>                  /* in case of -EOVERFLOW that could happen below,
>>                   * xsk_consume_skb() will release this node as whole skb
>>                   * would be dropped, which implies freeing all list elements
>>                   */
>> -               xsk_addr->addr = desc->addr;
>> -               list_add_tail(&xsk_addr->addr_node, &XSKCB(skb)->addrs_list);
>> +               xsk_addr->addrs[xsk_addr->num_descs] = desc->addr;
>> +               xsk_addr->num_descs++;
>>          }
>>
>>          len = desc->len;
>> @@ -813,7 +825,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>>                          }
>>                  } else {
>>                          int nr_frags = skb_shinfo(skb)->nr_frags;
>> -                       struct xsk_addr_node *xsk_addr;
>> +                       struct xsk_addrs *xsk_addr;
>>                          struct page *page;
>>                          u8 *vaddr;
>>
>> @@ -828,11 +840,20 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>>                                  goto free_err;
>>                          }
>>
>> -                       xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache, GFP_KERNEL);
>> -                       if (!xsk_addr) {
>> -                               __free_page(page);
>> -                               err = -ENOMEM;
>> -                               goto free_err;
>> +                       if (xsk_skb_destructor_is_addr(skb)) {
>> +                               xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache,
>> +                                                            GFP_KERNEL);
>> +                               if (!xsk_addr) {
>> +                                       __free_page(page);
>> +                                       err = -ENOMEM;
>> +                                       goto free_err;
>> +                               }
>> +
>> +                               xsk_addr->num_descs = 1;
>> +                               xsk_addr->addrs[0] = xsk_skb_destructor_get_addr(skb);
>> +                               skb_shinfo(skb)->destructor_arg = (void *)xsk_addr;
>> +                       } else {
>> +                               xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
>>                          }
>>
>>                          vaddr = kmap_local_page(page);
>> @@ -842,13 +863,11 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>>                          skb_add_rx_frag(skb, nr_frags, page, 0, len, PAGE_SIZE);
>>                          refcount_add(PAGE_SIZE, &xs->sk.sk_wmem_alloc);
>>
>> -                       xsk_addr->addr = desc->addr;
>> -                       list_add_tail(&xsk_addr->addr_node, &XSKCB(skb)->addrs_list);
>> +                       xsk_addr->addrs[xsk_addr->num_descs] = desc->addr;
>> +                       xsk_addr->num_descs++;
>>                  }
>>          }
>>
>> -       xsk_inc_num_desc(skb);
>> -
>>          return skb;
>>
>>   free_err:
>> @@ -857,7 +876,6 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>>
>>          if (err == -EOVERFLOW) {
>>                  /* Drop the packet */
>> -               xsk_inc_num_desc(xs->skb);
>>                  xsk_drop_skb(xs->skb);
>>                  xskq_cons_release(xs->tx);
>>          } else {
>> @@ -1904,7 +1922,7 @@ static int __init xsk_init(void)
>>                  goto out_pernet;
>>
>>          xsk_tx_generic_cache = kmem_cache_create("xsk_generic_xmit_cache",
>> -                                                sizeof(struct xsk_addr_node),
>> +                                                sizeof(struct xsk_addrs),
>>                                                   0, SLAB_HWCACHE_ALIGN, NULL);
>>          if (!xsk_tx_generic_cache) {
>>                  err = -ENOMEM;
>> --
>> 2.51.0
>>


