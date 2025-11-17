Return-Path: <bpf+bounces-74754-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD17C6511B
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 17:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 40D903652B8
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 16:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739682C08BC;
	Mon, 17 Nov 2025 16:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Km6+Fm08";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JKnh4CN4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Km6+Fm08";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JKnh4CN4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4271D61BC
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 16:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763395919; cv=none; b=PvrrcMpr1QEb8XOwAIIutqgv9W8SJ2sp1L/1ytrMh3nFn5B2S0oYCiXrbE4brQZnH10T6ibhaYT6IrHTal9Q7kBNI6GB47N2tY/xVDHkwIztDjdgJ0rhvzadVinW+zZtBGFpCq72Hid0O1V93DrCjFYBHH/r5JMSX7zw7DnGE4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763395919; c=relaxed/simple;
	bh=ot8gjWm1bgwLw+5eMeJ/IER6zzTWkz2LXpbS4mcWXQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VdanLpf0rYAtaofbSIq9Iq3VPQDX/rREmTCE7WgsN2XQjVpqTDH4xU1dBKQ4UiH26vD48cofsvY+QvRkCOg53t/7h6y/NzEhzYnLXkj3Hj98LABs2NfvMLJu5aJtS3CkSN9w+MKKV63Zo20Z7eCs8WHZYLPaeiWXYa4H3qIq4Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Km6+Fm08; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JKnh4CN4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Km6+Fm08; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JKnh4CN4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 615411F7B4;
	Mon, 17 Nov 2025 16:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763395915; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mBUBnaTIzsm0SlnbQPCeTBjXpAcWxSMAN7X2xrq3Ku0=;
	b=Km6+Fm08CJbPSGJJRSwsUeprWBfb41+VzR5/8vTwC+Pw66bFiLYxAZVu5yoM0tbYk/Xb0J
	hZf5LezDbcQHsY1767JQj+Tk0w26P+QyGbYuM6fOSjOpuFL4nB2hnEWvE5q7m4J3kibq+t
	0aMUEBvLt3a641InUixHn1ujV6v7Gz8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763395915;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mBUBnaTIzsm0SlnbQPCeTBjXpAcWxSMAN7X2xrq3Ku0=;
	b=JKnh4CN4ISrbverMx5dO9YV7cgGUAb4CvPTzB7yyf9mhhioZQvx/7d/Qsg71FXiK89hYeL
	HGHtGOu4cqoSvcAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Km6+Fm08;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=JKnh4CN4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763395915; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mBUBnaTIzsm0SlnbQPCeTBjXpAcWxSMAN7X2xrq3Ku0=;
	b=Km6+Fm08CJbPSGJJRSwsUeprWBfb41+VzR5/8vTwC+Pw66bFiLYxAZVu5yoM0tbYk/Xb0J
	hZf5LezDbcQHsY1767JQj+Tk0w26P+QyGbYuM6fOSjOpuFL4nB2hnEWvE5q7m4J3kibq+t
	0aMUEBvLt3a641InUixHn1ujV6v7Gz8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763395915;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mBUBnaTIzsm0SlnbQPCeTBjXpAcWxSMAN7X2xrq3Ku0=;
	b=JKnh4CN4ISrbverMx5dO9YV7cgGUAb4CvPTzB7yyf9mhhioZQvx/7d/Qsg71FXiK89hYeL
	HGHtGOu4cqoSvcAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A4D513EA61;
	Mon, 17 Nov 2025 16:11:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 85pXJUpJG2meFAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 17 Nov 2025 16:11:54 +0000
Message-ID: <4cf22f51-c3d4-4c02-b5b6-0cb38985d0f8@suse.de>
Date: Mon, 17 Nov 2025 17:11:48 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] xsk: avoid data corruption on cq descriptor number
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, csmate@nop.hu, kerneljasonxing@gmail.com,
 bjorn@kernel.org, sdf@fomichev.me, jonathan.lemon@gmail.com,
 bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
References: <20251030140355.4059-1-fmancera@suse.de> <aRtIiIvfVwJCmcn1@boxer>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <aRtIiIvfVwJCmcn1@boxer>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 615411F7B4
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,nop.hu,gmail.com,kernel.org,fomichev.me,davemloft.net,google.com,redhat.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,intel.com:email,suse.de:email,suse.de:mid,suse.de:dkim]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 



On 11/17/25 5:08 PM, Maciej Fijalkowski wrote:
> On Thu, Oct 30, 2025 at 03:03:55PM +0100, Fernando Fernandez Mancera wrote:
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
> Tested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> 
> Fernando thanks for stepping in and providing this fix!
> And thanks Jakub for ptr tagging trick.
> 
> @BPF maintainers, please apply this patch.
> 

Thank you, please note that if rebasing is needed I can send a rebased 
version. Just let me know.

Thanks,
Fernando.

