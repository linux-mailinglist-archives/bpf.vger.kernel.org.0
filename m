Return-Path: <bpf+bounces-72197-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 00936C09E41
	for <lists+bpf@lfdr.de>; Sat, 25 Oct 2025 20:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 47BA24E48B8
	for <lists+bpf@lfdr.de>; Sat, 25 Oct 2025 18:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0701C2C234E;
	Sat, 25 Oct 2025 18:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bUOkB++1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qR+RTbk6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bUOkB++1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qR+RTbk6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4CD259CBD
	for <bpf@vger.kernel.org>; Sat, 25 Oct 2025 18:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761416308; cv=none; b=DiDuTw68DkUT5ZqXUHPP3YgOYC3hN5LzLByPqxHFOB+ZAMS7mCaqF2KRTfdbxnoTwedh1qR2S2VZEFjjerattt2PAQvzadd6QXC9q0JXthKvOQ7da0q/RHqjHMdLtCGvSAwm27plb+frRPM5wo3z1Wcrhd7iGSeCrKljr09H/Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761416308; c=relaxed/simple;
	bh=MgTkyjzbbWGtf4QXTLlrunC8tf3D+dtlWXUNAaUc0MY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=udmBdjkQ4GjIRVR57quWiaxoqj5N9PJ+U0Z0+y+hIzDs/8kVVFdRjUbhv8SEzbhaXa4KwVqbeHgQjegWeySuxDm0JRwcfUJpfLZSPik84KF+9YCtLk7NWAT8In2MHrAHeLoaI+HaDvCFvmWddi7un2DLE5n9Ms7K0tEFkQC/Oyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bUOkB++1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qR+RTbk6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bUOkB++1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qR+RTbk6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BEBFC1F44E;
	Sat, 25 Oct 2025 18:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761416298; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=167V8NKcDcZXJggUPgmp3qs3XOBKPwVKuVpBeOQ6GaE=;
	b=bUOkB++1w8QEAfZMO3Y7RrhMCXtKQvcoyxXJ+SRZLZwbtm61SuzTL+0Ty42NSx28YEImTY
	SUPK3K5ABgbDEgNYGvXBTTIvfIE3hKF4aXGOiY/2eE2u/dc3egYMFEoVWVaLFnae/UOfqb
	Ctp2aOpLl9gy7FqhQ8wUi5ZcqoO0Fus=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761416298;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=167V8NKcDcZXJggUPgmp3qs3XOBKPwVKuVpBeOQ6GaE=;
	b=qR+RTbk6sFkpBHXBqfnRlZSrUM1DFENVxlkeb6vhKDgEnxKRBD/lZpTCzooNIcsoL+73HJ
	s8Ubf3edJxH4VWBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761416298; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=167V8NKcDcZXJggUPgmp3qs3XOBKPwVKuVpBeOQ6GaE=;
	b=bUOkB++1w8QEAfZMO3Y7RrhMCXtKQvcoyxXJ+SRZLZwbtm61SuzTL+0Ty42NSx28YEImTY
	SUPK3K5ABgbDEgNYGvXBTTIvfIE3hKF4aXGOiY/2eE2u/dc3egYMFEoVWVaLFnae/UOfqb
	Ctp2aOpLl9gy7FqhQ8wUi5ZcqoO0Fus=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761416298;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=167V8NKcDcZXJggUPgmp3qs3XOBKPwVKuVpBeOQ6GaE=;
	b=qR+RTbk6sFkpBHXBqfnRlZSrUM1DFENVxlkeb6vhKDgEnxKRBD/lZpTCzooNIcsoL+73HJ
	s8Ubf3edJxH4VWBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0293A1377F;
	Sat, 25 Oct 2025 18:18:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FU3aOGkU/WhgTQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Sat, 25 Oct 2025 18:18:17 +0000
Message-ID: <4723fa89-17d3-4204-b490-979df9182454@suse.de>
Date: Sat, 25 Oct 2025 20:18:17 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] xsk: avoid data corruption on cq descriptor number
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, csmate@nop.hu, kerneljasonxing@gmail.com,
 bjorn@kernel.org, sdf@fomichev.me, jonathan.lemon@gmail.com,
 bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
References: <20251024104049.20902-1-fmancera@suse.de> <aPu0WdUqZCB3xQgb@boxer>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <aPu0WdUqZCB3xQgb@boxer>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,nop.hu,gmail.com,kernel.org,fomichev.me,davemloft.net,google.com,redhat.com];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -2.80



On 10/24/25 7:16 PM, Maciej Fijalkowski wrote:
> On Fri, Oct 24, 2025 at 12:40:49PM +0200, Fernando Fernandez Mancera wrote:
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
>> The approach proposed stores the first address also in the xsk_addr_node
>> along with the number of descriptors. The head xsk_addr_node is
>> referenced in skb_shinfo(skb)->destructor_arg. The rest of the fragments
>> store the address on the list.
>>
>> This is less efficient as 4 bytes are wasted when storing each address.
> 
> Hi Fernando,
> it's not about 4 bytes being wasted but rather memory allocation that you
> introduce here. I tried hard to avoid hurting non-fragmented traffic,
> below you can find impact reported by Jason from similar approach as
> yours:
> https://lore.kernel.org/bpf/CAL+tcoD=Gn6ZmJ+_Y48vPRyHVHmP-7irsx=fRVRnyhDrpTrEtQ@mail.gmail.com/
> 
> I assume this patch will yield a similar performance degradation...
> 

It does, thank you for explaining Maciej. I have been thinking about 
possible solutions and remembered skb extensions. If I am not wrong, it 
shouldn't yield a performance degratation or at least it should be a 
much less severe one. Although, XDP_SOCKETS Kconfig would require 
"select SKB_EXTENSIONS".

What do you think about this approach? I could draft a series for 
net-next.. I am just looking for different options other than using skb 
control block because I believe similar issues will arise in the future 
even if we fix the current one on ip_rcv..

Thanks,
Fernando.

