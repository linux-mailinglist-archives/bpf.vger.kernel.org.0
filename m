Return-Path: <bpf+bounces-57535-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2CDAAC8CC
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 16:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74B034C5823
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 14:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC09628368E;
	Tue,  6 May 2025 14:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FFGbL98B";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DzGu3LkY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wT8GUlkA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RnCdUdUt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5AC283151
	for <bpf@vger.kernel.org>; Tue,  6 May 2025 14:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746543362; cv=none; b=LddO2BSRN0Cgeu5s9urYaTueGKm5WfN7bdiqmjtVLQfpnRmUM0JmJFTZc8OYEt6LCJnp6oeC0PgEFg0lb9FkbRz5Skt+9jC7lz/8A7EqjWkDsSqt+i+LmhrOcGZfnsOjAvF/BOMU7bVengdHbMb8cCw7WinNIlrSVvTJ6fBQ9H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746543362; c=relaxed/simple;
	bh=UbZOIo9vv7p/HpNVJWG6RQABrcJe7PpsYPzdosDpeYg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GaegXMoPPH4B8PQT4au1yNXUGVGCxk6AG0z3y3qbJg3dXOyxxoQrP/HKJaZZg3M/Jl9yULMPBkTrKNxUmEOSph/wtJAHLaiaUflHtO3UqIPFp1hjU9hr+AOCzHHS+Leeta/0u1nclvJXXCVnOWbbW+fCVHccai15DagOcT4kiWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FFGbL98B; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DzGu3LkY; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wT8GUlkA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RnCdUdUt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D3AB41F766;
	Tue,  6 May 2025 14:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746543359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EEQfV+3wmi7AV5sOArF/T9auBfpveeBoeG9+bSpJuRU=;
	b=FFGbL98BL8cLzlfgUFZibgsyealrzFKcAQdhtU+HYBd1rgbyGrhoIQzePRdkBT1/auFr3J
	6dig35rKUL3VBuG9F/sH9J461FCsRE1pPzzyydUUbh7eo31Xokszu+CvE8zJUUitlqRsTo
	zFWe7JEBknpzSb5IvgnfGB8jB17lEnU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746543359;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EEQfV+3wmi7AV5sOArF/T9auBfpveeBoeG9+bSpJuRU=;
	b=DzGu3LkYXsrKpM6jmq0G1PjCb3SL+JAKaKoqBlktUXL44pxN5bxKBdg5AlqSOtZGYEHanA
	vISh9LIpNyJmkBCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=wT8GUlkA;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=RnCdUdUt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746543358; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EEQfV+3wmi7AV5sOArF/T9auBfpveeBoeG9+bSpJuRU=;
	b=wT8GUlkARbxhM9WYS2E88HV7QzMibgF4klJOLaxTod2Z38n6yGSoHx/0iGsdpUXX5R5ibm
	aM90+msQOAxDDmkNlpQObLTZRaiXf9wffLSayF8ZbChBqgmvP4D+2zMYKJeq7pkURyHs45
	0EuyMevpwgqI/UeNHC0LKNrjETvQ78k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746543358;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EEQfV+3wmi7AV5sOArF/T9auBfpveeBoeG9+bSpJuRU=;
	b=RnCdUdUt8JXb9ua2uzl7hM5/6UBVbGSB3DbVLzShGTNM0w0kXou5OhddPodN1S7Ll6wNe1
	tdl77vTN3LW4IKAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A7AB713687;
	Tue,  6 May 2025 14:55:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dyEvJ/4iGmh2WQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 06 May 2025 14:55:58 +0000
Message-ID: <1fd89e00-2d26-4f84-b8a3-5add508608c8@suse.cz>
Date: Tue, 6 May 2025 16:55:58 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] locking/local_lock: Expose dep_map in
 local_trylock_t.
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
 linux-mm@kvack.org
Cc: harry.yoo@oracle.com, shakeel.butt@linux.dev, mhocko@suse.com,
 bigeasy@linutronix.de, andrii@kernel.org, memxor@gmail.com,
 akpm@linux-foundation.org, peterz@infradead.org, rostedt@goodmis.org,
 hannes@cmpxchg.org, willy@infradead.org
References: <20250501032718.65476-1-alexei.starovoitov@gmail.com>
 <20250501032718.65476-3-alexei.starovoitov@gmail.com>
 <9e19b706-4c3c-4d62-b7f2-5936ca842060@suse.cz>
In-Reply-To: <9e19b706-4c3c-4d62-b7f2-5936ca842060@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D3AB41F766
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,kvack.org];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,linux.dev,suse.com,linutronix.de,kernel.org,gmail.com,linux-foundation.org,infradead.org,goodmis.org,cmpxchg.org];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

On 5/6/25 14:56, Vlastimil Babka wrote:
> On 5/1/25 05:27, Alexei Starovoitov wrote:
>> @@ -81,7 +84,7 @@ do {								\
>>  	local_lock_debug_init(lock);				\
>>  } while (0)
>>  
>> -#define __local_trylock_init(lock) __local_lock_init(lock.llock)
>> +#define __local_trylock_init(lock) __local_lock_init((local_lock_t *)lock)
> 
> This cast seems unnecessary. Better not hide mistakes when using the
> local_trylock_init() macro.

Nevermind, tested the wrong config, it's necessary. Sigh.

>>  
>>  #define __spinlock_nested_bh_init(lock)				\
>>  do {								\
> 


