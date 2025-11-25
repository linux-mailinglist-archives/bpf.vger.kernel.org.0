Return-Path: <bpf+bounces-75442-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9CCC84C6D
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 12:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 60C6D4E97D2
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 11:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8212B31A7E2;
	Tue, 25 Nov 2025 11:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TfjVzikk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MUzArxIT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TfjVzikk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MUzArxIT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035FD315776
	for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 11:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764070859; cv=none; b=B8J92vC5XztvDQllJMUyBcCQLw0yWXdN/Rm90D7HkX0P1mf7SoAxkUuA/bg86F8y1DZ60NOK/CGOsFBAf9RU8C48JKncnasP3FvF4UNm0hOoupk6mQBeRfoZACbOq2IyrzKd/GmPdbz6wOz1yji/7DhKGAUXdeseUnX7K7IoXfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764070859; c=relaxed/simple;
	bh=A8B9HwgzTGzkMAxCiLd0An8l/9lEOiA7nO5uNyinpCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cmrO8fAhNFisb/BFP+Aby1BAS4OCxJAt3Iw8EN//ponooPUQPkBDshurFabh5L9v78Tr4fbFb43nzW1Uy/u9XkLhQRmDTUlVRTuEa60zHVTSKfTm+kuZHJxRJPs2oH8OOQGinmSApeONoSW0X8NgahdCVrMnH67ADR3KAO9+mZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TfjVzikk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MUzArxIT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TfjVzikk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MUzArxIT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 204B7227CD;
	Tue, 25 Nov 2025 11:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764070855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pTcqT3HGjPxaavxWGploLrx5S6tE9aabBkwHdsWjic0=;
	b=TfjVzikkxR06KrE8E7CGppgQ6BQ/AoI7YB7Ma1qna5+d/TrtfCN709bJF0IwVx/DjTt2Mo
	Ev3gIsYooN2gNKNd2HqS4rpsHKK1TcczVn5nL6Fuf2tNq3SiwYs6OjaseIcjFwPERF4j3a
	Yf0MjCukoXlw24k1IErkfkYRGzbYXb4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764070855;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pTcqT3HGjPxaavxWGploLrx5S6tE9aabBkwHdsWjic0=;
	b=MUzArxITzlQOjGszDUGqknK3E3lH84Hpz2n4w4OVcwrK4uRZCELUrRH2+3RaKCsxTbt3bh
	dJpadNA4LdcZyKDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764070855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pTcqT3HGjPxaavxWGploLrx5S6tE9aabBkwHdsWjic0=;
	b=TfjVzikkxR06KrE8E7CGppgQ6BQ/AoI7YB7Ma1qna5+d/TrtfCN709bJF0IwVx/DjTt2Mo
	Ev3gIsYooN2gNKNd2HqS4rpsHKK1TcczVn5nL6Fuf2tNq3SiwYs6OjaseIcjFwPERF4j3a
	Yf0MjCukoXlw24k1IErkfkYRGzbYXb4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764070855;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pTcqT3HGjPxaavxWGploLrx5S6tE9aabBkwHdsWjic0=;
	b=MUzArxITzlQOjGszDUGqknK3E3lH84Hpz2n4w4OVcwrK4uRZCELUrRH2+3RaKCsxTbt3bh
	dJpadNA4LdcZyKDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3B9A23EA63;
	Tue, 25 Nov 2025 11:40:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QG23C8aVJWnUQAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 25 Nov 2025 11:40:54 +0000
Message-ID: <955e2de1-32f6-42e3-8358-b8574188ce62@suse.de>
Date: Tue, 25 Nov 2025 12:40:49 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v6] xsk: avoid data corruption on cq descriptor number
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: netdev@vger.kernel.org, csmate@nop.hu, maciej.fijalkowski@intel.com,
 bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, sdf@fomichev.me,
 hawk@kernel.org, daniel@iogearbox.net, ast@kernel.org,
 john.fastabend@gmail.com, magnus.karlsson@intel.com
References: <20251124171409.3845-1-fmancera@suse.de>
 <CAL+tcoBKMfVnTtkwBRk9JBGbJtahyJVt4g8swsYRUk1b97LgHQ@mail.gmail.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <CAL+tcoBKMfVnTtkwBRk9JBGbJtahyJVt4g8swsYRUk1b97LgHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,nop.hu,intel.com,davemloft.net,google.com,kernel.org,redhat.com,fomichev.me,iogearbox.net,gmail.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

On 11/25/25 12:41 AM, Jason Xing wrote:
> On Tue, Nov 25, 2025 at 1:14 AM Fernando Fernandez Mancera
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
> Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
> 
> Could you also post a patch on top of net-next as it has diverged from
> the net tree?
> 

I think that is handled by maintainers when merging the branches. A 
repost would be wrong because linux-next.git and linux.git will have a 
different variant of the same commit..

Please, let me know if I am wrong here.

Thanks,
Fernando.

