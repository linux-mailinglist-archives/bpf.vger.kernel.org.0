Return-Path: <bpf+bounces-79238-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 085D8D30657
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 12:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6CBF309C384
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 11:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5F7374197;
	Fri, 16 Jan 2026 11:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="biNtuGN7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ypZtmz1k";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="biNtuGN7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ypZtmz1k"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87050344058
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 11:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768562701; cv=none; b=TIPbZE8qovidi8KcqUjlImVfejazb9l/KQmFiQtHDKNqvK79U1LJRha8CDP6AiG2SyvF/H1J7NjTTDt2WtlIA4KspBUrT1LoqRQSBHHsFttRs/yjARmEYGJUlCOXqOal5441uBMp4jOidaVHIkJbB5I2phb4IbLz+8J24GPlB00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768562701; c=relaxed/simple;
	bh=p32T3GWEbmB0Vb0/4I77lqtRmjREX5T0ysJ4XqW8w5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hcqqyKSuDkX0kjq5rj4Pew5A1CP4s2tQqeA7y8jZPWJuwhKWRfvLlr2/hdtnbPEkoY4ETTjM8CYBvGgX+1y8RbBJ3wg+VipNVwn7zyP73ly+nX1VEwJIw5kYPzxC81ULm1wq7i/GlJPHIX1n5iTJT/MBGdZRfi2djQ1wqJbVPiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=biNtuGN7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ypZtmz1k; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=biNtuGN7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ypZtmz1k; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0C47D336A7;
	Fri, 16 Jan 2026 11:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768562696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EPxWoGREDJBDCfaaqNFnAl/rLl9XxuU79MPtOoauRfg=;
	b=biNtuGN7QWxMfL9DRBGYDCAGWEbHE54eFrVw/zIaCQnltNU8jvFnBsUe38ntDoHY8ktEnh
	EfVw57ewHwcclwsAbF5Pa0AFmSHnKXf3mnvKRxtEdlPvcuuI+y/pApYsFGx5vBXXje0o0r
	xzSRQJjS63dG+h/swU8kZ48Ihar8eM4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768562696;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EPxWoGREDJBDCfaaqNFnAl/rLl9XxuU79MPtOoauRfg=;
	b=ypZtmz1kT5RKMaAeLMUJmN/BwWs7hH5IOndqlaoX4481tMZ14YtbulHcekPA6MFce6FNEZ
	UCZEjeRP5XnQygDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768562696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EPxWoGREDJBDCfaaqNFnAl/rLl9XxuU79MPtOoauRfg=;
	b=biNtuGN7QWxMfL9DRBGYDCAGWEbHE54eFrVw/zIaCQnltNU8jvFnBsUe38ntDoHY8ktEnh
	EfVw57ewHwcclwsAbF5Pa0AFmSHnKXf3mnvKRxtEdlPvcuuI+y/pApYsFGx5vBXXje0o0r
	xzSRQJjS63dG+h/swU8kZ48Ihar8eM4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768562696;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EPxWoGREDJBDCfaaqNFnAl/rLl9XxuU79MPtOoauRfg=;
	b=ypZtmz1kT5RKMaAeLMUJmN/BwWs7hH5IOndqlaoX4481tMZ14YtbulHcekPA6MFce6FNEZ
	UCZEjeRP5XnQygDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D44ED3EA63;
	Fri, 16 Jan 2026 11:24:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 45r3MQcgamlWMQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 16 Jan 2026 11:24:55 +0000
Message-ID: <d310d788-b6df-47dc-9557-643813351838@suse.cz>
Date: Fri, 16 Jan 2026 12:24:55 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 04/20] slab: add sheaves to most caches
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>
Cc: Harry Yoo <harry.yoo@oracle.com>, Petr Tesarik <ptesarik@suse.com>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 bpf@vger.kernel.org, kasan-dev@googlegroups.com
References: <20260112-sheaves-for-all-v2-0-98225cfb50cf@suse.cz>
 <20260112-sheaves-for-all-v2-4-98225cfb50cf@suse.cz>
 <CAJuCfpFKKtxB2mREuOSa4oQu=MBGkbQRQNYSSnubAAgPENcO-Q@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 xsFNBFZdmxYBEADsw/SiUSjB0dM+vSh95UkgcHjzEVBlby/Fg+g42O7LAEkCYXi/vvq31JTB
 KxRWDHX0R2tgpFDXHnzZcQywawu8eSq0LxzxFNYMvtB7sV1pxYwej2qx9B75qW2plBs+7+YB
 87tMFA+u+L4Z5xAzIimfLD5EKC56kJ1CsXlM8S/LHcmdD9Ctkn3trYDNnat0eoAcfPIP2OZ+
 9oe9IF/R28zmh0ifLXyJQQz5ofdj4bPf8ecEW0rhcqHfTD8k4yK0xxt3xW+6Exqp9n9bydiy
 tcSAw/TahjW6yrA+6JhSBv1v2tIm+itQc073zjSX8OFL51qQVzRFr7H2UQG33lw2QrvHRXqD
 Ot7ViKam7v0Ho9wEWiQOOZlHItOOXFphWb2yq3nzrKe45oWoSgkxKb97MVsQ+q2SYjJRBBH4
 8qKhphADYxkIP6yut/eaj9ImvRUZZRi0DTc8xfnvHGTjKbJzC2xpFcY0DQbZzuwsIZ8OPJCc
 LM4S7mT25NE5kUTG/TKQCk922vRdGVMoLA7dIQrgXnRXtyT61sg8PG4wcfOnuWf8577aXP1x
 6mzw3/jh3F+oSBHb/GcLC7mvWreJifUL2gEdssGfXhGWBo6zLS3qhgtwjay0Jl+kza1lo+Cv
 BB2T79D4WGdDuVa4eOrQ02TxqGN7G0Biz5ZLRSFzQSQwLn8fbwARAQABzSBWbGFzdGltaWwg
 QmFia2EgPHZiYWJrYUBzdXNlLmN6PsLBlAQTAQoAPgIbAwULCQgHAwUVCgkICwUWAgMBAAIe
 AQIXgBYhBKlA1DSZLC6OmRA9UCJPp+fMgqZkBQJnyBr8BQka0IFQAAoJECJPp+fMgqZkqmMQ
 AIbGN95ptUMUvo6aAdhxaOCHXp1DfIBuIOK/zpx8ylY4pOwu3GRe4dQ8u4XS9gaZ96Gj4bC+
 jwWcSmn+TjtKW3rH1dRKopvC07tSJIGGVyw7ieV/5cbFffA8NL0ILowzVg8w1ipnz1VTkWDr
 2zcfslxJsJ6vhXw5/npcY0ldeC1E8f6UUoa4eyoskd70vO0wOAoGd02ZkJoox3F5ODM0kjHu
 Y97VLOa3GG66lh+ZEelVZEujHfKceCw9G3PMvEzyLFbXvSOigZQMdKzQ8D/OChwqig8wFBmV
 QCPS4yDdmZP3oeDHRjJ9jvMUKoYODiNKsl2F+xXwyRM2qoKRqFlhCn4usVd1+wmv9iLV8nPs
 2Db1ZIa49fJet3Sk3PN4bV1rAPuWvtbuTBN39Q/6MgkLTYHb84HyFKw14Rqe5YorrBLbF3rl
 M51Dpf6Egu1yTJDHCTEwePWug4XI11FT8lK0LNnHNpbhTCYRjX73iWOnFraJNcURld1jL1nV
 r/LRD+/e2gNtSTPK0Qkon6HcOBZnxRoqtazTU6YQRmGlT0v+rukj/cn5sToYibWLn+RoV1CE
 Qj6tApOiHBkpEsCzHGu+iDQ1WT0Idtdynst738f/uCeCMkdRu4WMZjteQaqvARFwCy3P/jpK
 uvzMtves5HvZw33ZwOtMCgbpce00DaET4y/UzsBNBFsZNTUBCACfQfpSsWJZyi+SHoRdVyX5
 J6rI7okc4+b571a7RXD5UhS9dlVRVVAtrU9ANSLqPTQKGVxHrqD39XSw8hxK61pw8p90pg4G
 /N3iuWEvyt+t0SxDDkClnGsDyRhlUyEWYFEoBrrCizbmahOUwqkJbNMfzj5Y7n7OIJOxNRkB
 IBOjPdF26dMP69BwePQao1M8Acrrex9sAHYjQGyVmReRjVEtv9iG4DoTsnIR3amKVk6si4Ea
 X/mrapJqSCcBUVYUFH8M7bsm4CSxier5ofy8jTEa/CfvkqpKThTMCQPNZKY7hke5qEq1CBk2
 wxhX48ZrJEFf1v3NuV3OimgsF2odzieNABEBAAHCwXwEGAEKACYCGwwWIQSpQNQ0mSwujpkQ
 PVAiT6fnzIKmZAUCZ8gcVAUJFhTonwAKCRAiT6fnzIKmZLY8D/9uo3Ut9yi2YCuASWxr7QQZ
 lJCViArjymbxYB5NdOeC50/0gnhK4pgdHlE2MdwF6o34x7TPFGpjNFvycZqccSQPJ/gibwNA
 zx3q9vJT4Vw+YbiyS53iSBLXMweeVV1Jd9IjAoL+EqB0cbxoFXvnjkvP1foiiF5r73jCd4PR
 rD+GoX5BZ7AZmFYmuJYBm28STM2NA6LhT0X+2su16f/HtummENKcMwom0hNu3MBNPUOrujtW
 khQrWcJNAAsy4yMoJ2Lw51T/5X5Hc7jQ9da9fyqu+phqlVtn70qpPvgWy4HRhr25fCAEXZDp
 xG4RNmTm+pqorHOqhBkI7wA7P/nyPo7ZEc3L+ZkQ37u0nlOyrjbNUniPGxPxv1imVq8IyycG
 AN5FaFxtiELK22gvudghLJaDiRBhn8/AhXc642/Z/yIpizE2xG4KU4AXzb6C+o7LX/WmmsWP
 Ly6jamSg6tvrdo4/e87lUedEqCtrp2o1xpn5zongf6cQkaLZKQcBQnPmgHO5OG8+50u88D9I
 rywqgzTUhHFKKF6/9L/lYtrNcHU8Z6Y4Ju/MLUiNYkmtrGIMnkjKCiRqlRrZE/v5YFHbayRD
 dJKXobXTtCBYpLJM4ZYRpGZXne/FAtWNe4KbNJJqxMvrTOrnIatPj8NhBVI0RSJRsbilh6TE
 m6M14QORSWTLRg==
In-Reply-To: <CAJuCfpFKKtxB2mREuOSa4oQu=MBGkbQRQNYSSnubAAgPENcO-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.994];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[oracle.com,suse.com,gentwo.org,google.com,linux.dev,linux-foundation.org,gmail.com,linutronix.de,kernel.org,kvack.org,vger.kernel.org,lists.linux.dev,googlegroups.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_EQ_ENVFROM(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO

On 1/16/26 06:45, Suren Baghdasaryan wrote:
> On Mon, Jan 12, 2026 at 3:17 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> In the first step to replace cpu (partial) slabs with sheaves, enable
>> sheaves for almost all caches. Treat args->sheaf_capacity as a minimum,
>> and calculate sheaf capacity with a formula that roughly follows the
>> formula for number of objects in cpu partial slabs in set_cpu_partial().
>>
>> This should achieve roughly similar contention on the barn spin lock as
>> there's currently for node list_lock without sheaves, to make
>> benchmarking results comparable. It can be further tuned later.
>>
>> Don't enable sheaves for bootstrap caches as that wouldn't work. In
>> order to recognize them by SLAB_NO_OBJ_EXT, make sure the flag exists
>> even for !CONFIG_SLAB_OBJ_EXT.
>>
>> This limitation will be lifted for kmalloc caches after the necessary
>> bootstrapping changes.
>>
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> 
> One nit but otherwise LGTM.
> 
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>

Thanks.

>> ---
>>  include/linux/slab.h |  6 ------
>>  mm/slub.c            | 51 +++++++++++++++++++++++++++++++++++++++++++++++----
>>  2 files changed, 47 insertions(+), 10 deletions(-)
>>
>> diff --git a/include/linux/slab.h b/include/linux/slab.h
>> index 2482992248dc..2682ee57ec90 100644
>> --- a/include/linux/slab.h
>> +++ b/include/linux/slab.h
>> @@ -57,9 +57,7 @@ enum _slab_flag_bits {
>>  #endif
>>         _SLAB_OBJECT_POISON,
>>         _SLAB_CMPXCHG_DOUBLE,
>> -#ifdef CONFIG_SLAB_OBJ_EXT
>>         _SLAB_NO_OBJ_EXT,
>> -#endif
>>         _SLAB_FLAGS_LAST_BIT
>>  };
>>
>> @@ -238,11 +236,7 @@ enum _slab_flag_bits {
>>  #define SLAB_TEMPORARY         SLAB_RECLAIM_ACCOUNT    /* Objects are short-lived */
>>
>>  /* Slab created using create_boot_cache */
>> -#ifdef CONFIG_SLAB_OBJ_EXT
>>  #define SLAB_NO_OBJ_EXT                __SLAB_FLAG_BIT(_SLAB_NO_OBJ_EXT)
>> -#else
>> -#define SLAB_NO_OBJ_EXT                __SLAB_FLAG_UNUSED
>> -#endif
>>
>>  /*
>>   * ZERO_SIZE_PTR will be returned for zero sized kmalloc requests.
>> diff --git a/mm/slub.c b/mm/slub.c
>> index 8ffeb3ab3228..6e05e3cc5c49 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -7857,6 +7857,48 @@ static void set_cpu_partial(struct kmem_cache *s)
>>  #endif
>>  }
>>
>> +static unsigned int calculate_sheaf_capacity(struct kmem_cache *s,
>> +                                            struct kmem_cache_args *args)
>> +
>> +{
>> +       unsigned int capacity;
>> +       size_t size;
>> +
>> +
>> +       if (IS_ENABLED(CONFIG_SLUB_TINY) || s->flags & SLAB_DEBUG_FLAGS)
>> +               return 0;
>> +
>> +       /* bootstrap caches can't have sheaves for now */
>> +       if (s->flags & SLAB_NO_OBJ_EXT)
>> +               return 0;
>> +
>> +       /*
>> +        * For now we use roughly similar formula (divided by two as there are
>> +        * two percpu sheaves) as what was used for percpu partial slabs, which
>> +        * should result in similar lock contention (barn or list_lock)
>> +        */
>> +       if (s->size >= PAGE_SIZE)
>> +               capacity = 4;
>> +       else if (s->size >= 1024)
>> +               capacity = 12;
>> +       else if (s->size >= 256)
>> +               capacity = 26;
>> +       else
>> +               capacity = 60;
>> +
>> +       /* Increment capacity to make sheaf exactly a kmalloc size bucket */
>> +       size = struct_size_t(struct slab_sheaf, objects, capacity);
>> +       size = kmalloc_size_roundup(size);
>> +       capacity = (size - struct_size_t(struct slab_sheaf, objects, 0)) / sizeof(void *);
>> +
>> +       /*
>> +        * Respect an explicit request for capacity that's typically motivated by
>> +        * expected maximum size of kmem_cache_prefill_sheaf() to not end up
>> +        * using low-performance oversize sheaves
>> +        */
>> +       return max(capacity, args->sheaf_capacity);
>> +}
>> +
>>  /*
>>   * calculate_sizes() determines the order and the distribution of data within
>>   * a slab object.
>> @@ -7991,6 +8033,10 @@ static int calculate_sizes(struct kmem_cache_args *args, struct kmem_cache *s)
>>         if (s->flags & SLAB_RECLAIM_ACCOUNT)
>>                 s->allocflags |= __GFP_RECLAIMABLE;
>>
>> +       /* kmalloc caches need extra care to support sheaves */
>> +       if (!is_kmalloc_cache(s))
> 
> nit: All the checks for the cases when sheaves should not be used
> (like SLAB_DEBUG_FLAGS and SLAB_NO_OBJ_EXT) are done inside
> calculate_sheaf_capacity(). Only this is_kmalloc_cache() one is here.
> It would be nice to have all of them in the same place but maybe you
> have a reason for keeping it here?

Yeah, in "slab: handle kmalloc sheaves bootstrap" we call
calculate_sheaf_capacity() from another place for kmalloc normal caches so
the check has to be outside.

>> +               s->sheaf_capacity = calculate_sheaf_capacity(s, args);
>> +
>>         /*
>>          * Determine the number of objects per slab
>>          */
>> @@ -8595,15 +8641,12 @@ int do_kmem_cache_create(struct kmem_cache *s, const char *name,
>>
>>         set_cpu_partial(s);
>>
>> -       if (args->sheaf_capacity && !IS_ENABLED(CONFIG_SLUB_TINY)
>> -                                       && !(s->flags & SLAB_DEBUG_FLAGS)) {
>> +       if (s->sheaf_capacity) {
>>                 s->cpu_sheaves = alloc_percpu(struct slub_percpu_sheaves);
>>                 if (!s->cpu_sheaves) {
>>                         err = -ENOMEM;
>>                         goto out;
>>                 }
>> -               // TODO: increase capacity to grow slab_sheaf up to next kmalloc size?
>> -               s->sheaf_capacity = args->sheaf_capacity;
>>         }
>>
>>  #ifdef CONFIG_NUMA
>>
>> --
>> 2.52.0
>>


