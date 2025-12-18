Return-Path: <bpf+bounces-76962-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60243CCAB95
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 08:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CB49F302285C
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 07:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2488C2DFF1D;
	Thu, 18 Dec 2025 07:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xGswW9mm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="12xfeIIr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xGswW9mm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="12xfeIIr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3B71D6195
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 07:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766044068; cv=none; b=kqJc3NR9q16wbtibPpJ/iIZVntFTOaqF/JMuDwTA2V+jYHg5dY7VTF8nucvkxKY5rSausRfPBXEWMgPmrgsUk/lCkFN4cP3PHBS6XfONuv1MyzH8YkNP3jxkV9xu9jWB4MkTSFWjyIKH5A3m/qC7nuF7QE9caj1IX94uXHObSGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766044068; c=relaxed/simple;
	bh=wmQ7vEP1PE0L/cKNh93jn2cAhRr2WL13ibxMSXvSHkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LrtnmMcgmFqRuHlEJS9LS3iSGSDElQrV86bQkYthqLPispG1g/9NW88SK0wd/csqtnj6rztGyx6g3FWNvxpytDYiRpnLUC+rG+aeLL5rbgDa+Yw2TsbXgRM/Y/OkOgiNbkRSCb7pz17Lr05KVfnaGuj5xGQS3wMd3LZNkBT6mBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xGswW9mm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=12xfeIIr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xGswW9mm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=12xfeIIr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1608E336E3;
	Thu, 18 Dec 2025 07:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766044065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pSlq6nuapXlPZtqsKEQ7mS1ImZ01jhm7Caka7wJ5hO8=;
	b=xGswW9mmEdYxve8qWfUjRzkM0alEkhjtKTJql2b1uFo3KxBid93Ccp2YT5lW/tnR2/aq83
	GnVwshDLCQ9OEARRJ+blcWw5Wl7RurDK7UmOcEhlE2Z2F4SfrzBbvbhYAVHXE9j6R5t4Lp
	2PMhlBjHPhxgTYbOSHjVGtxyJ/yuGyQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766044065;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pSlq6nuapXlPZtqsKEQ7mS1ImZ01jhm7Caka7wJ5hO8=;
	b=12xfeIIr0TEtg0oz9K8ds5m3lHbkuGcVBzuNqIxhI3qsl8sqFDjbH9XpqfCu6RFoILRFqv
	lhZYgT/Cb4LCAyBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766044065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pSlq6nuapXlPZtqsKEQ7mS1ImZ01jhm7Caka7wJ5hO8=;
	b=xGswW9mmEdYxve8qWfUjRzkM0alEkhjtKTJql2b1uFo3KxBid93Ccp2YT5lW/tnR2/aq83
	GnVwshDLCQ9OEARRJ+blcWw5Wl7RurDK7UmOcEhlE2Z2F4SfrzBbvbhYAVHXE9j6R5t4Lp
	2PMhlBjHPhxgTYbOSHjVGtxyJ/yuGyQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766044065;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pSlq6nuapXlPZtqsKEQ7mS1ImZ01jhm7Caka7wJ5hO8=;
	b=12xfeIIr0TEtg0oz9K8ds5m3lHbkuGcVBzuNqIxhI3qsl8sqFDjbH9XpqfCu6RFoILRFqv
	lhZYgT/Cb4LCAyBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BE9853EA63;
	Thu, 18 Dec 2025 07:47:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fLIwLqCxQ2nnCwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 18 Dec 2025 07:47:44 +0000
Message-ID: <7b2673cb-1f0e-4a5a-84e3-0ae10437308d@suse.cz>
Date: Thu, 18 Dec 2025 08:47:44 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] introduce pagetable_alloc_nolock()
To: Brendan Jackman <jackmanb@google.com>, Yeoreum Yun <yeoreum.yun@arm.com>,
 Ryan Roberts <ryan.roberts@arm.com>
Cc: akpm@linux-foundation.org, david@kernel.org, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, hannes@cmpxchg.org,
 ziy@nvidia.com, bigeasy@linutronix.de, clrkwllms@kernel.org,
 rostedt@goodmis.org, catalin.marinas@arm.com, will@kernel.org,
 kevin.brodsky@arm.com, dev.jain@arm.com, yang@os.amperecomputing.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, linux-arm-kernel@lists.infradead.org
References: <20251212161832.2067134-1-yeoreum.yun@arm.com>
 <916c17ba-22b1-456e-a184-cb3f60249af7@arm.com>
 <aUGOPd7gNRf1xHEc@e129823.arm.com>
 <100cc8da-b826-4fc2-a624-746bf6fb049d@arm.com>
 <aUKKZR0u22KOPfd7@e129823.arm.com>
 <d96ac977-222e-4e8d-9487-da1306198419@arm.com>
 <aUKnfU/3FREY13g1@e129823.arm.com>
 <d912480a-5229-4efe-9336-b31acded30f5@suse.cz>
 <DF0J58HOVLL4.2E16Q87D2UXRW@google.com>
 <d5354d96-6f28-41d7-9f66-64c254d9477b@suse.cz>
 <DF0NWLWKRKYI.3PLY78UGGG2PD@google.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <DF0NWLWKRKYI.3PLY78UGGG2PD@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[37];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLaoo9k1mcqc4e3ec8ywf517mf)];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,oracle.com,google.com,suse.com,iogearbox.net,linux.dev,gmail.com,fomichev.me,cmpxchg.org,nvidia.com,linutronix.de,goodmis.org,arm.com,os.amperecomputing.com,kvack.org,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

On 12/17/25 18:19, Brendan Jackman wrote:
>>> From 4c6b4d4cb08aee9559d02a348b9ecf799142c96f Mon Sep 17 00:00:00 2001
>>> From: Brendan Jackman <jackmanb@google.com>
>>> Date: Wed, 17 Dec 2025 13:26:28 +0000
>>> Subject: [PATCH] mm: clarify GFP_ATOMIC/GFP_NOWAIT doc-comment
>>> 
>>> The current description of contexts where it's invalid to make
>>> GFP_ATOMIC and GFP_NOWAIT calls is rather vague.
>>> 
>>> Replace this with a direct description of the actual contexts of concern
>>> and refer to the RT docs where this is explained more discursively.
>>> 
>>> While rejigging this prose, also move the documentation of GFP_NOWAIT to
>>> the GFP_NOWAIT section.
>>
>> There doesn't seem to be any move?
> 
> This is referring to [0] and [1].

Oh I missed [0]. Thanks!

>>> diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
>>> index 3de43b12209ee..07a378542caf2 100644
>>> --- a/include/linux/gfp_types.h
>>> +++ b/include/linux/gfp_types.h
>>> @@ -309,8 +309,10 @@ enum {
>>>   *
>>>   * %GFP_ATOMIC users can not sleep and need the allocation to succeed. A lower
>>>   * watermark is applied to allow access to "atomic reserves".
>>> - * The current implementation doesn't support NMI and few other strict
>>> - * non-preemptive contexts (e.g. raw_spin_lock). The same applies to %GFP_NOWAIT.
> [0]                                                   ^^^^^^^^^^^^^^^^^^^^^^^^^^
>>> + * The current implementation doesn't support NMI, nor contexts that disable
>>> + * preemption under PREEMPT_RT. This includes raw_spin_lock() and plain
>>> + * preempt_disable() - see Documentation/core-api/real-time/differences.rst for
>>> + * more info.
>>
>> Can we reference the "Memory allocation" section directly?
> 
> Yeah good point. I will send this as a standalone [PATCH] mail tomorrow.
> 
>>>   *
>>>   * %GFP_KERNEL is typical for kernel-internal allocations. The caller requires
>>>   * %ZONE_NORMAL or a lower zone for direct access but can direct reclaim.
>>> @@ -321,6 +323,7 @@ enum {
>>>   * %GFP_NOWAIT is for kernel allocations that should not stall for direct
>>>   * reclaim, start physical IO or use any filesystem callback.  It is very
>>>   * likely to fail to allocate memory, even for very small allocations.
>>> + * The same restrictions on calling contexts apply as for %GFP_ATOMIC.
> [1]     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 


