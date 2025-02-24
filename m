Return-Path: <bpf+bounces-52405-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BE2A42AF5
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 19:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16E573B801D
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 18:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E1D263C8A;
	Mon, 24 Feb 2025 18:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Li+7Oa/n";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0yGRLsnO";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="k/xS/ekK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hwADte08"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E557214012
	for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 18:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740421130; cv=none; b=rZ7CiyXB9JWV/8auMOKcq5dUXbHAg3Yupw7xwwJ2FoQUWsUmEzgtT5FEHmZeWZW3R5CR7+wAYkaKtSz4ZzvXqyIxekRQSFQ/yjR14FAXN5T/YGyTCpq0VW5EPj/L2sQzE77u9PsjrFaSR9MZ4Hpazmi4rDSCMLZkwNHXfJp2Uj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740421130; c=relaxed/simple;
	bh=F3c+kWqnGwQ1D+TAQtfGfyYR4esHq9k/RPQE/IMNOyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nrg550JANeuwG3wTKP/TlXK3iH34ERKNqiI/BjFNa1RtUI+NxbIdsp7aVl1h9rbpMwUKor+tIx8sicew4uwMYQ5zmrvJfaHRYC2TVc8t46VmMTsvgIu54tupQ+x/We9Ut89cpkbFGUKKjBXE4n4r0OMImGN7Hi9RwoLbxfgdR+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Li+7Oa/n; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0yGRLsnO; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=k/xS/ekK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hwADte08; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3D7FC1F449;
	Mon, 24 Feb 2025 18:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740420918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=M3Ef04I0Xna9Ma2aqsawRhgvFUFn8LFOS7cvkTxcg5w=;
	b=Li+7Oa/ngGPYp6ATBEO0/IcG3Z494t0kRvp1P24RV6v4C7JGLkeeEgncwPSZBVGhnCPG8X
	9xx9X8IRE2Og8+kD5vCQZeWfQXKaZaADV9lYWdRXklQ57vSfaCoHVZg/jCTWp+PW3TSGsw
	+XmuWHqamxVzSdpyzu7YAL27b31QdDU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740420918;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=M3Ef04I0Xna9Ma2aqsawRhgvFUFn8LFOS7cvkTxcg5w=;
	b=0yGRLsnOu99CO21ds0vhmyffNA2oPayH2JHp/dNIyYNWRvaIXV3gVqDvyLMwhDvFaviXEw
	RGtkgTY+0GYhbSBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="k/xS/ekK";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=hwADte08
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740420917; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=M3Ef04I0Xna9Ma2aqsawRhgvFUFn8LFOS7cvkTxcg5w=;
	b=k/xS/ekKFcyPN6TVmKeANcHwWrAmq6D6CaOfNHxRli4DWZzM3B5Q8YM1MqfGNd0rGs0b5J
	7TrshSpEPreH07F8LzPpl3usyg+/e66CJiXJ0GbrKtwTRnpnqA/fLHSLmhCR/poVtGDaoj
	Zqqsfba1a4ponLXCRBZMjVbKiW0qJ8w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740420917;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=M3Ef04I0Xna9Ma2aqsawRhgvFUFn8LFOS7cvkTxcg5w=;
	b=hwADte08Ngot5RBluIGTqFYA+GmOn4VpZwlzAT/m+xBAVdc6Jc2dWRzyFr55q78J/vTGrI
	xvCy4A0EEI8GLCCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 20DE113707;
	Mon, 24 Feb 2025 18:15:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id j6TwBjW3vGdEEgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 24 Feb 2025 18:15:17 +0000
Message-ID: <704ba4a7-37ec-4c6b-9de4-0c662e5c5ce1@suse.cz>
Date: Mon, 24 Feb 2025 19:15:16 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] SLUB allocator, mainly the sheaves caching
 layer
Content-Language: en-US
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
 bpf <bpf@vger.kernel.org>, Christoph Lameter <cl@linux.com>,
 David Rientjes <rientjes@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>
References: <14422cf1-4a63-4115-87cb-92685e7dd91b@suse.cz>
 <e2fz26kcbni37rp2rdqvac7mljvrglvtzmkivfpsnibubu3g3t@blz27xo4honn>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <e2fz26kcbni37rp2rdqvac7mljvrglvtzmkivfpsnibubu3g3t@blz27xo4honn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 3D7FC1F449
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux-foundation.org,kvack.org,vger.kernel.org,linux.com,google.com,gmail.com,kernel.org];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

On 2/24/25 19:02, Shakeel Butt wrote:
> On Mon, Feb 24, 2025 at 05:13:25PM +0100, Vlastimil Babka wrote:
>> Hi,
>> 
>> I'd like to propose a session about the SLUB allocator.
>> 
>> Mainly I would like to discuss the addition of the sheaves caching layer,
>> the latest RFC posted at [1].
>> 
>> The goals of that work is to:
>> 
>> - Reduce fastpath overhead. The current freeing fastpath only can be used if
>> the same target slab is still the cpu slab, which can be only expected for a
>> very short term allocations. Further improvements should come from the new
>> local_trylock_t primitive.
>> 
>> - Improve efficiency of users such as like maple tree, thanks to more
>> efficient preallocations, and kfree_rcu batching/reusal
>> 
>> - Hopefully also facilitate further changes needed for bpf allocations, also
>> via local_trylock_t, that could possibly extend to the other parts of the
>> implementation as needed.
>> 
>> The controversial discussion points I expect about this approach are:
>> 
>> - Either sheaves will not support NUMA restrictions (as in current RFC), or
>> bring back the alien cache flushing issues of SLAB (or there's a better idea?)
>> 
>> - Will it be possible to eventually have sheaves enabled for every cache and
>> replace the current slub's fastpaths with it? Arguably these are also not
>> very efficient when NUMA-restricted allocations are requested for varying
>> NUMA nodes (cpu slab is flushed if it's from a wrong node, to load a slab
>> from the requested node).
>> 
>> Besides sheaves, I'd like to summarize recent kfree_rcu() changes and we
>> could discuss further improvements to that.
>> 
>> Also we can discuss what's needed to support bpf allocations. I've talked
>> about it last year, but then focused on other things, so Alexei has been
>> driving that recently (so far in the page allocator).
> 
> What about pre-memcg-charged sheaves? We had to disable memcg charging
> of some kernel allocations

You mean due to bad performance? Which ones for example? Was the overhead
due to accounting of how much is charged, or due to the associating memcgs
with objects?

> and I think sheaves can help in reenabling
> it.

You mean by mean having separate sheaves per memcg? Wouldn't that mean
risking that too many objects could be cached in them, we'd have to flush
eventually e.g. the least recently used ones, etc? Or do you mean some other
scheme?

Thanks, Vlastimil

