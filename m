Return-Path: <bpf+bounces-58022-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A61AB3B94
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 17:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BA923AB58B
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 15:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D46134D4;
	Mon, 12 May 2025 15:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GP3ljgIv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mWg1lQ6V";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GP3ljgIv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mWg1lQ6V"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBAE4C80
	for <bpf@vger.kernel.org>; Mon, 12 May 2025 15:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747062119; cv=none; b=tJcv7yKtCbyXWDlg8ylYFO94fL9TjdPz+ovValRPgzhis2HH+70qb8UeLkPdp1QgcmChvmh7Jh1pnp67u+ipGUKyuSDJlhmiicgeEmU2bSvPBvaPwuya88hmbKPYlwYSOIQzUsO1fNEdpxx9B6LVGbKtcO87Awv2F4sfSaD5+yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747062119; c=relaxed/simple;
	bh=/zXKpJHXDjp3vlCiyTgZDgn1xmDvj+iCX3lpcFJxgrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W/OdjqcieBvaH3H2VsGLwuWVFP3JF+i7Y26RdC4PC/BVpdCG0l0AUglmqc9CFXdC1Mpe3Ux4+bUECVDUQewC2soI56uLWDziLzlqJrwVERm1qUG7/lHdc39rw068N3aFxtZOVV3+CmC9J+OYrFkBEhduehxvw5tWXiNaC/IBlnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GP3ljgIv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mWg1lQ6V; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GP3ljgIv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mWg1lQ6V; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 04F7F2120E;
	Mon, 12 May 2025 15:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747062116; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z+jY5KN8CzrMEF4lIZPKa3xcJF27rsMzAOY3MhSK37s=;
	b=GP3ljgIvQS79LkmAxmgp1dX3TqskOm2yM8hFImuRtN+kXxtB6eb3dmaXnWNNgQy5AgcKW+
	+pXRoh0mgPjFT2zAeBoJdcuAlYkHwCqVr3wZDXFeVhzPFpmV5xoe8gZj/Beyb6HFPZAHV1
	27r0sQy/XL/6FFmjt+d4HMkW1AFM0co=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747062116;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z+jY5KN8CzrMEF4lIZPKa3xcJF27rsMzAOY3MhSK37s=;
	b=mWg1lQ6VnhDs+sYrgbWP1S77sAw5AtOHwP61Dn+IVzLvV1OPvHeUrzSRpP8pijkBs683Xc
	GwYO7YRGWN3H/uDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=GP3ljgIv;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=mWg1lQ6V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747062116; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z+jY5KN8CzrMEF4lIZPKa3xcJF27rsMzAOY3MhSK37s=;
	b=GP3ljgIvQS79LkmAxmgp1dX3TqskOm2yM8hFImuRtN+kXxtB6eb3dmaXnWNNgQy5AgcKW+
	+pXRoh0mgPjFT2zAeBoJdcuAlYkHwCqVr3wZDXFeVhzPFpmV5xoe8gZj/Beyb6HFPZAHV1
	27r0sQy/XL/6FFmjt+d4HMkW1AFM0co=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747062116;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z+jY5KN8CzrMEF4lIZPKa3xcJF27rsMzAOY3MhSK37s=;
	b=mWg1lQ6VnhDs+sYrgbWP1S77sAw5AtOHwP61Dn+IVzLvV1OPvHeUrzSRpP8pijkBs683Xc
	GwYO7YRGWN3H/uDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE2FF137D2;
	Mon, 12 May 2025 15:01:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6u3uNWMNImiHSAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 12 May 2025 15:01:55 +0000
Message-ID: <1c9bbd31-10f1-41b6-b2b9-745ab4e9e2ad@suse.cz>
Date: Mon, 12 May 2025 17:01:55 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] locking/local_lock: Introduce local_lock_is_locked().
Content-Language: en-US
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, harry.yoo@oracle.com,
 shakeel.butt@linux.dev, mhocko@suse.com, andrii@kernel.org,
 memxor@gmail.com, akpm@linux-foundation.org, peterz@infradead.org,
 rostedt@goodmis.org, hannes@cmpxchg.org, willy@infradead.org
References: <20250501032718.65476-1-alexei.starovoitov@gmail.com>
 <20250501032718.65476-4-alexei.starovoitov@gmail.com>
 <20250512145613.eD3DUEa8@linutronix.de>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20250512145613.eD3DUEa8@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 04F7F2120E
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[linutronix.de,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,oracle.com,linux.dev,suse.com,kernel.org,gmail.com,linux-foundation.org,infradead.org,goodmis.org,cmpxchg.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:mid,suse.cz:dkim]
X-Spam-Score: -3.01

On 5/12/25 16:56, Sebastian Andrzej Siewior wrote:
> On 2025-04-30 20:27:15 [-0700], Alexei Starovoitov wrote:
>> --- a/include/linux/local_lock_internal.h
>> +++ b/include/linux/local_lock_internal.h
>> @@ -285,4 +288,9 @@ do {								\
>>  		__local_trylock(lock);				\
>>  	})
>>  
>> +/* migration must be disabled before calling __local_lock_is_locked */
>> +#include "../../kernel/locking/rtmutex_common.h"
>> +#define __local_lock_is_locked(__lock)					\
>> +	(rt_mutex_owner(&this_cpu_ptr(__lock)->lock) == current)
> 
> So I've been looking if we really need rt_mutex_owner() or if
> rt_mutex_base_is_locked() could do the job. Judging from the slub-free
> case, the rt_mutex_base_is_locked() would be just fine. The alloc case
> on the other hand probably not so much. On the other hand since we don't
> accept allocations from hardirq or NMI the "caller == owner" case should
> never be observed. Unless buggy & debugging and this should then also be
> observed by lockdep. Right?

AFAIU my same line of thought was debunked by Alexei here:

https://lore.kernel.org/all/CAADnVQLO9YX2_0wEZshHbwXoJY2-wv3OgVGvN-hgf6mK0_ipxw@mail.gmail.com/

e.g. you could have the lock and then due to kprobe or tracing in the slab
allocator code re-enter it.

> If there is another case where recursion can be observed and need to be
> addressed I would prefer to move the function (+define) to
> include/linux/rtmutex.h. instead of doing this "../../ include".
> 
>>  #endif /* CONFIG_PREEMPT_RT */
> 
> Sebastian


