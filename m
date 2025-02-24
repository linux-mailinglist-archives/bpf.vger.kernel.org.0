Return-Path: <bpf+bounces-52383-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F8AA4278A
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 17:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16F1F188952E
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 16:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899AC261384;
	Mon, 24 Feb 2025 16:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kvLo7Ju0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WMaatZ3j";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kvLo7Ju0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WMaatZ3j"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A911527B4
	for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 16:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740413609; cv=none; b=AHweRXlbldRjBCEyxtbyiOxZgbqnel1nAxq5Egk0KDQC9lxuqL9GRqoMpmY+Dw4M8iuVdTtAKiirKgbaYHfSqlBeR4hirHinWEtm+RTIXf/BzsJaym4gyKFcnFBWTIWICyIGI9isyDaF1Uf0dD0a+mzZdY2U8sVBZzfECE+0FYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740413609; c=relaxed/simple;
	bh=WBMdAWhxn/GChTyBeP5yPTqD8ZrGrZRdmO7dv1pf3ms=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=IqsdQ0yUwPhY7RWVHnaLCd1EJ61nf8d7h/hvEIWYQdAM9DN50CRSTrka0da6nN4VSvX42rnuYZVSN19NzVkVrPQr0j1XnItXxJzROI8lWDndH1ffBU8dH9Fe47kUPfW5DYsf+YPINP5ICaabVJZo8u35iXjCjyIzfKfFcWizfSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kvLo7Ju0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WMaatZ3j; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kvLo7Ju0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WMaatZ3j; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7E69D21179;
	Mon, 24 Feb 2025 16:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740413605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
	bh=WBMdAWhxn/GChTyBeP5yPTqD8ZrGrZRdmO7dv1pf3ms=;
	b=kvLo7Ju0r4EVLoI7PV1rwFhSNEylxeqw96eT39XTt8KRj9ETo8k4smLipMGl/dNOiT7MUP
	2v/dC4BzSvHFFOHXuGWuJ5b+2lYUFsrhfHvmCa32D4J8SWu5Y3/UjOZGAoo93sg7Ol4/BQ
	e61FOs5lEVJLqGo08YJIQa2W5mutx18=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740413605;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
	bh=WBMdAWhxn/GChTyBeP5yPTqD8ZrGrZRdmO7dv1pf3ms=;
	b=WMaatZ3jAGgIBbiN85mQ6WXXOt5yqUG56NVL11IquudoKOAm+uELTumQGBWKuKJuGrr1RR
	kazcfQFZOq5Mc8BA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=kvLo7Ju0;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=WMaatZ3j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740413605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
	bh=WBMdAWhxn/GChTyBeP5yPTqD8ZrGrZRdmO7dv1pf3ms=;
	b=kvLo7Ju0r4EVLoI7PV1rwFhSNEylxeqw96eT39XTt8KRj9ETo8k4smLipMGl/dNOiT7MUP
	2v/dC4BzSvHFFOHXuGWuJ5b+2lYUFsrhfHvmCa32D4J8SWu5Y3/UjOZGAoo93sg7Ol4/BQ
	e61FOs5lEVJLqGo08YJIQa2W5mutx18=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740413605;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
	bh=WBMdAWhxn/GChTyBeP5yPTqD8ZrGrZRdmO7dv1pf3ms=;
	b=WMaatZ3jAGgIBbiN85mQ6WXXOt5yqUG56NVL11IquudoKOAm+uELTumQGBWKuKJuGrr1RR
	kazcfQFZOq5Mc8BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6CB1C13707;
	Mon, 24 Feb 2025 16:13:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dyw8GqWavGdbagAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 24 Feb 2025 16:13:25 +0000
Message-ID: <14422cf1-4a63-4115-87cb-92685e7dd91b@suse.cz>
Date: Mon, 24 Feb 2025 17:13:25 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Vlastimil Babka <vbabka@suse.cz>
Subject: [LSF/MM/BPF TOPIC] SLUB allocator, mainly the sheaves caching layer
To: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
 bpf <bpf@vger.kernel.org>
Content-Language: en-US
Cc: Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 7E69D21179
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
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[linux.com,google.com,gmail.com,kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Hi,

I'd like to propose a session about the SLUB allocator.

Mainly I would like to discuss the addition of the sheaves caching layer,
the latest RFC posted at [1].

The goals of that work is to:

- Reduce fastpath overhead. The current freeing fastpath only can be used if
the same target slab is still the cpu slab, which can be only expected for a
very short term allocations. Further improvements should come from the new
local_trylock_t primitive.

- Improve efficiency of users such as like maple tree, thanks to more
efficient preallocations, and kfree_rcu batching/reusal

- Hopefully also facilitate further changes needed for bpf allocations, also
via local_trylock_t, that could possibly extend to the other parts of the
implementation as needed.

The controversial discussion points I expect about this approach are:

- Either sheaves will not support NUMA restrictions (as in current RFC), or
bring back the alien cache flushing issues of SLAB (or there's a better idea?)

- Will it be possible to eventually have sheaves enabled for every cache and
replace the current slub's fastpaths with it? Arguably these are also not
very efficient when NUMA-restricted allocations are requested for varying
NUMA nodes (cpu slab is flushed if it's from a wrong node, to load a slab
from the requested node).

Besides sheaves, I'd like to summarize recent kfree_rcu() changes and we
could discuss further improvements to that.

Also we can discuss what's needed to support bpf allocations. I've talked
about it last year, but then focused on other things, so Alexei has been
driving that recently (so far in the page allocator).

[1]
https://lore.kernel.org/all/20250214-slub-percpu-caches-v2-0-88592ee0966a@suse.cz/

Thanks,
Vlastimil

