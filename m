Return-Path: <bpf+bounces-73154-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8027CC2483B
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 11:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A12A21A62505
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 10:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DBB33FE39;
	Fri, 31 Oct 2025 10:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SSBXfTE1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IktV8Fuz";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SSBXfTE1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IktV8Fuz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41878334C29
	for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 10:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761907080; cv=none; b=o01X4qZE4JrawT1rd2NSyitEY6VcWiFdBy6Nhdb4f9+FPRWgUbaL4cuZOWsIGvIFzx/rSAqzzFdfrvLy+thohBPlSHGEGGlx8VD1n22zHwa8F9a2hwy0tKb8oKKts3+L3rv6oU5+wJXEs+frg80p9OP5O6X9OD8eU7oBJWpbVFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761907080; c=relaxed/simple;
	bh=YC95MTjQKOjAjhoCPVZbpofBlbnlbMSMbstOykyMgvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CTyfjMom0MuO8v2M7GrPN3heGmPgJ4JWoZS7188XHvuRm/rTAx6syO1govZ8K/P9e3yCZdaswMIQrbKTznzFP/lfqo3mZSCsf/beH0EZQ7lneLMTJ6vzz3Gk64EOvJokd6eHxzwAV40dndnOWxt7d8vyfmoNa+4ByMOlqrZDW3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SSBXfTE1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IktV8Fuz; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SSBXfTE1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IktV8Fuz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 783761F393;
	Fri, 31 Oct 2025 10:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761907077; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tq495MODQe4gihVp+3+M1ToOlyHgQrtkdzVZ3qho3M0=;
	b=SSBXfTE1Og4pZOuP1cd/efr+6aR+6/oyj1HT0ERhtMFHd35uIPgn0rXxr4AYukDLRqM6i3
	V7zDOJ/XZaHd6oVvX9TfkOdA+T3ctMzYMiwCf69jcguU0PydZw8cu+4+VWjw6iezq8Sy1m
	03C4y0G4Or4YEiUwI87JZS0QlWRn0zg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761907077;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tq495MODQe4gihVp+3+M1ToOlyHgQrtkdzVZ3qho3M0=;
	b=IktV8FuzGn3uhEIixk4Fi3xMNnzN+mmhWcPcAUdNRFB1rYNY4KAGey1jzAEqol2B+0WnNv
	ldmJQHdYDZO6xLCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761907077; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tq495MODQe4gihVp+3+M1ToOlyHgQrtkdzVZ3qho3M0=;
	b=SSBXfTE1Og4pZOuP1cd/efr+6aR+6/oyj1HT0ERhtMFHd35uIPgn0rXxr4AYukDLRqM6i3
	V7zDOJ/XZaHd6oVvX9TfkOdA+T3ctMzYMiwCf69jcguU0PydZw8cu+4+VWjw6iezq8Sy1m
	03C4y0G4Or4YEiUwI87JZS0QlWRn0zg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761907077;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tq495MODQe4gihVp+3+M1ToOlyHgQrtkdzVZ3qho3M0=;
	b=IktV8FuzGn3uhEIixk4Fi3xMNnzN+mmhWcPcAUdNRFB1rYNY4KAGey1jzAEqol2B+0WnNv
	ldmJQHdYDZO6xLCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C1B7613393;
	Fri, 31 Oct 2025 10:37:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3syCLISRBGkQIAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Fri, 31 Oct 2025 10:37:56 +0000
Message-ID: <809b5910-c5fe-436c-aa0f-74aa10d042ce@suse.de>
Date: Fri, 31 Oct 2025 11:37:52 +0100
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
 <9fa46203-cafb-4def-9c09-e589491f9f65@suse.de>
 <CAL+tcoBx88qdt5BXjEvRUh1bxW2-Q9PGMjRcEjotAEzw1=hkVQ@mail.gmail.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <CAL+tcoBx88qdt5BXjEvRUh1bxW2-Q9PGMjRcEjotAEzw1=hkVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,nop.hu,intel.com,kernel.org,fomichev.me,gmail.com,davemloft.net,google.com,redhat.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	URIBL_BLOCKED(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -2.80



On 10/31/25 11:23 AM, Jason Xing wrote:
> On Fri, Oct 31, 2025 at 6:05 PM Fernando Fernandez Mancera
> <fmancera@suse.de> wrote:
>>
>>
>>
>> On 10/31/25 10:51 AM, Jason Xing wrote:
>>> On Thu, Oct 30, 2025 at 10:04 PM Fernando Fernandez Mancera
>>> <fmancera@suse.de> wrote:
>>>>
>>>> Since commit 30f241fcf52a ("xsk: Fix immature cq descriptor
>>>> production"), the descriptor number is stored in skb control block and
>>>> xsk_cq_submit_addr_locked() relies on it to put the umem addrs onto
>>>> pool's completion queue.
>>>>
>>>> skb control block shouldn't be used for this purpose as after transmit
>>>> xsk doesn't have control over it and other subsystems could use it. This
>>>> leads to the following kernel panic due to a NULL pointer dereference.
>>>>
>>>>    BUG: kernel NULL pointer dereference, address: 0000000000000000
>>>>    #PF: supervisor read access in kernel mode
>>>>    #PF: error_code(0x0000) - not-present page
>>>>    PGD 0 P4D 0
>>>>    Oops: Oops: 0000 [#1] SMP NOPTI
>>>>    CPU: 2 UID: 1 PID: 927 Comm: p4xsk.bin Not tainted 6.16.12+deb14-cloud-amd64 #1 PREEMPT(lazy)  Debian 6.16.12-1
>>>>    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
>>>>    RIP: 0010:xsk_destruct_skb+0xd0/0x180
>>>>    [...]
>>>>    Call Trace:
>>>>     <IRQ>
>>>>     ? napi_complete_done+0x7a/0x1a0
>>>>     ip_rcv_core+0x1bb/0x340
>>>>     ip_rcv+0x30/0x1f0
>>>>     __netif_receive_skb_one_core+0x85/0xa0
>>>>     process_backlog+0x87/0x130
>>>>     __napi_poll+0x28/0x180
>>>>     net_rx_action+0x339/0x420
>>>>     handle_softirqs+0xdc/0x320
>>>>     ? handle_edge_irq+0x90/0x1e0
>>>>     do_softirq.part.0+0x3b/0x60
>>>>     </IRQ>
>>>>     <TASK>
>>>>     __local_bh_enable_ip+0x60/0x70
>>>>     __dev_direct_xmit+0x14e/0x1f0
>>>>     __xsk_generic_xmit+0x482/0xb70
>>>>     ? __remove_hrtimer+0x41/0xa0
>>>>     ? __xsk_generic_xmit+0x51/0xb70
>>>>     ? _raw_spin_unlock_irqrestore+0xe/0x40
>>>>     xsk_sendmsg+0xda/0x1c0
>>>>     __sys_sendto+0x1ee/0x200
>>>>     __x64_sys_sendto+0x24/0x30
>>>>     do_syscall_64+0x84/0x2f0
>>>>     ? __pfx_pollwake+0x10/0x10
>>>>     ? __rseq_handle_notify_resume+0xad/0x4c0
>>>>     ? restore_fpregs_from_fpstate+0x3c/0x90
>>>>     ? switch_fpu_return+0x5b/0xe0
>>>>     ? do_syscall_64+0x204/0x2f0
>>>>     ? do_syscall_64+0x204/0x2f0
>>>>     ? do_syscall_64+0x204/0x2f0
>>>>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>>     </TASK>
>>>>    [...]
>>>>    Kernel panic - not syncing: Fatal exception in interrupt
>>>>    Kernel Offset: 0x1c000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
>>>>
>>>> Instead use the skb destructor_arg pointer along with pointer tagging.
>>>> As pointers are always aligned to 8B, use the bottom bit to indicate
>>>> whether this a single address or an allocated struct containing several
>>>> addresses.
>>>>
>>>> Fixes: 30f241fcf52a ("xsk: Fix immature cq descriptor production")
>>>> Closes: https://lore.kernel.org/netdev/0435b904-f44f-48f8-afb0-68868474bf1c@nop.hu/
>>>> Suggested-by: Jakub Kicinski <kuba@kernel.org>
>>>> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
>>>
>>> I don't think we need this fix anymore if we can apply the series[1].
>>> The fix I just proposed doesn't use any new bits to store something so
>>> the problem will disappear.
>>>
>>> [1]: https://lore.kernel.org/all/20251031093230.82386-1-kerneljasonxing@gmail.com/
>>>
>>> Thanks,
>>> Jason
>>>
>>
>> Right. Then let's consider this patch dropped.
> 
> Only if we all agree on that new approach :P Any suggestions are welcome :)
> 

I think it makes sense. The address start + num fits there.. you reduce 
the memory allocations so it seems better from my point of view. If 
someone disagree then we can retake this :)

Thanks,
Fernando

