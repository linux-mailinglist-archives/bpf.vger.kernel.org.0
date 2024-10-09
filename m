Return-Path: <bpf+bounces-41398-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7E6996A2F
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 14:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B7171C221DB
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 12:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE19194AE6;
	Wed,  9 Oct 2024 12:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bsHUdwj5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="35nDAW5f";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bsHUdwj5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="35nDAW5f"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795EC1922E5
	for <bpf@vger.kernel.org>; Wed,  9 Oct 2024 12:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728477488; cv=none; b=AgLT+jm52sWYUlupGpblpH08qU9FysReqqzrQJOzUBPVIns4A1XyI0DHLid0Sfs+9r3n4Cy0qzKe97vdNuvnduBe8L5e7314M/AwPbWQNgLm4F7m5LCDTmWtw+zlwJrJvp5/cz5qo31RhaZeFDDnIcuaOo/8xj0KUCAcCExsNs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728477488; c=relaxed/simple;
	bh=3q3Nbbg0Iac6Xb0jwfjOv85Zmgm1KXwjzZK5h0dDzyA=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=PimivNiQjVpK50+WOb89nYzI9c/9keNLVOgOL0I+QkuFoS8vf7qPNSZTpLDbhZqAOr7ExDPpcX4tzCVk1zcA8ysfF8QBQlI6iCb4jFVpYTT/sGaczAU9we/brNrF6vAuzdmj/MaJFafleMHRS8P3U4VlkrLch/kzNg7cojyg2Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bsHUdwj5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=35nDAW5f; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bsHUdwj5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=35nDAW5f; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 648A921B3B;
	Wed,  9 Oct 2024 12:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728477484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
	bh=3q3Nbbg0Iac6Xb0jwfjOv85Zmgm1KXwjzZK5h0dDzyA=;
	b=bsHUdwj5GcLcIVse3c0xpTNVrQYMcZoUBcJHpNmwVzuLASs/VcamY5DWbPW202j4kPPzNG
	VYde79AiB0nUVwKplcCB1gniG5I+sJB//wMkzlVg35dNe2KMMU6Q6OW01KUu1Eh46rbd0j
	GMP6SutuaPPwy2dOCSyz2X93HPl8/zA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728477484;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
	bh=3q3Nbbg0Iac6Xb0jwfjOv85Zmgm1KXwjzZK5h0dDzyA=;
	b=35nDAW5fzWwXbrhtedq9ZUh7F9wMCeDGPpQCfcEwEl1KN1Ai5y8ynma1ISEop62Z25ttQv
	aLs6I1Dp9doxY0Cw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=bsHUdwj5;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=35nDAW5f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728477484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
	bh=3q3Nbbg0Iac6Xb0jwfjOv85Zmgm1KXwjzZK5h0dDzyA=;
	b=bsHUdwj5GcLcIVse3c0xpTNVrQYMcZoUBcJHpNmwVzuLASs/VcamY5DWbPW202j4kPPzNG
	VYde79AiB0nUVwKplcCB1gniG5I+sJB//wMkzlVg35dNe2KMMU6Q6OW01KUu1Eh46rbd0j
	GMP6SutuaPPwy2dOCSyz2X93HPl8/zA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728477484;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
	bh=3q3Nbbg0Iac6Xb0jwfjOv85Zmgm1KXwjzZK5h0dDzyA=;
	b=35nDAW5fzWwXbrhtedq9ZUh7F9wMCeDGPpQCfcEwEl1KN1Ai5y8ynma1ISEop62Z25ttQv
	aLs6I1Dp9doxY0Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 48F77136BA;
	Wed,  9 Oct 2024 12:38:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YbUuESx5BmdMHwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 09 Oct 2024 12:38:04 +0000
Message-ID: <0947ed02-9713-4974-af68-1aacedc97782@suse.cz>
Date: Wed, 9 Oct 2024 14:38:04 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
To: Kees Cook <kees@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Christoph Lameter
 <cl@linux.com>, David Rientjes <rientjes@google.com>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 Christian Brauner <brauner@kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>
Subject: extend usage of KMEM_CACHE() for cache creation?
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
 AQIXgBYhBKlA1DSZLC6OmRA9UCJPp+fMgqZkBQJkBREIBQkRadznAAoJECJPp+fMgqZkNxIQ
 ALZRqwdUGzqL2aeSavbum/VF/+td+nZfuH0xeWiO2w8mG0+nPd5j9ujYeHcUP1edE7uQrjOC
 Gs9sm8+W1xYnbClMJTsXiAV88D2btFUdU1mCXURAL9wWZ8Jsmz5ZH2V6AUszvNezsS/VIT87
 AmTtj31TLDGwdxaZTSYLwAOOOtyqafOEq+gJB30RxTRE3h3G1zpO7OM9K6ysLdAlwAGYWgJJ
 V4JqGsQ/lyEtxxFpUCjb5Pztp7cQxhlkil0oBYHkudiG8j1U3DG8iC6rnB4yJaLphKx57NuQ
 PIY0Bccg+r9gIQ4XeSK2PQhdXdy3UWBr913ZQ9AI2usid3s5vabo4iBvpJNFLgUmxFnr73SJ
 KsRh/2OBsg1XXF/wRQGBO9vRuJUAbnaIVcmGOUogdBVS9Sun/Sy4GNA++KtFZK95U7J417/J
 Hub2xV6Ehc7UGW6fIvIQmzJ3zaTEfuriU1P8ayfddrAgZb25JnOW7L1zdYL8rXiezOyYZ8Fm
 ZyXjzWdO0RpxcUEp6GsJr11Bc4F3aae9OZtwtLL/jxc7y6pUugB00PodgnQ6CMcfR/HjXlae
 h2VS3zl9+tQWHu6s1R58t5BuMS2FNA58wU/IazImc/ZQA+slDBfhRDGYlExjg19UXWe/gMcl
 De3P1kxYPgZdGE2eZpRLIbt+rYnqQKy8UxlszsBNBFsZNTUBCACfQfpSsWJZyi+SHoRdVyX5
 J6rI7okc4+b571a7RXD5UhS9dlVRVVAtrU9ANSLqPTQKGVxHrqD39XSw8hxK61pw8p90pg4G
 /N3iuWEvyt+t0SxDDkClnGsDyRhlUyEWYFEoBrrCizbmahOUwqkJbNMfzj5Y7n7OIJOxNRkB
 IBOjPdF26dMP69BwePQao1M8Acrrex9sAHYjQGyVmReRjVEtv9iG4DoTsnIR3amKVk6si4Ea
 X/mrapJqSCcBUVYUFH8M7bsm4CSxier5ofy8jTEa/CfvkqpKThTMCQPNZKY7hke5qEq1CBk2
 wxhX48ZrJEFf1v3NuV3OimgsF2odzieNABEBAAHCwXwEGAEKACYCGwwWIQSpQNQ0mSwujpkQ
 PVAiT6fnzIKmZAUCZAUSmwUJDK5EZgAKCRAiT6fnzIKmZOJGEACOKABgo9wJXsbWhGWYO7mD
 8R8mUyJHqbvaz+yTLnvRwfe/VwafFfDMx5GYVYzMY9TWpA8psFTKTUIIQmx2scYsRBUwm5VI
 EurRWKqENcDRjyo+ol59j0FViYysjQQeobXBDDE31t5SBg++veI6tXfpco/UiKEsDswL1WAr
 tEAZaruo7254TyH+gydURl2wJuzo/aZ7Y7PpqaODbYv727Dvm5eX64HCyyAH0s6sOCyGF5/p
 eIhrOn24oBf67KtdAN3H9JoFNUVTYJc1VJU3R1JtVdgwEdr+NEciEfYl0O19VpLE/PZxP4wX
 PWnhf5WjdoNI1Xec+RcJ5p/pSel0jnvBX8L2cmniYnmI883NhtGZsEWj++wyKiS4NranDFlA
 HdDM3b4lUth1pTtABKQ1YuTvehj7EfoWD3bv9kuGZGPrAeFNiHPdOT7DaXKeHpW9homgtBxj
 8aX/UkSvEGJKUEbFL9cVa5tzyialGkSiZJNkWgeHe+jEcfRT6pJZOJidSCdzvJpbdJmm+eED
 w9XOLH1IIWh7RURU7G1iOfEfmImFeC3cbbS73LQEFGe1urxvIH5K/7vX+FkNcr9ujwWuPE9b
 1C2o4i/yZPLXIVy387EjA6GZMqvQUFuSTs/GeBcv0NjIQi8867H3uLjz+mQy63fAitsDwLmR
 EP+ylKVEKb0Q2A==
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 648A921B3B
X-Spam-Score: -2.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	SUBJECT_ENDS_QUESTION(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,kvack.org,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Hi,

after Christian's recent refactoring, we have the following APIs to create
kmem caches:

kmem_cache_create() with new args parameter
(and the legacy variant of the same name)

kmem_cache_create_usercopy() - also legacy at this point

KMEM_CACHE() which takes the type, and has many users, but currently has no
support for args

KMEM_CACHE_USERCOPY() - like KMEM_CACHE() but with the usercopy parameters,
and only two users

I mentioned this at LPC when talking with Kees, and during Namhyung's talk.
I was only vaguely aware of KMEM_CACHE(), but during the refactoring I
became aware of if more. The reason it takes the struct type's name is
currently to automatically derive __alignof__ - and it could be an
interesting excercise to find out how many caches today exist for structures
with specific cache alignment defined for some fields, which then fails to
be satisfied because the caches are created by kmem_cache_create() without
the proper alignment...

Today we might have additionally interest to know the type for security
hardening, i.e. like kmalloc_obj does [1], and for perf to help more with
cache cpu optimizations [2]. Both got me wondering if it would help if we
converted everything to use KMEM_CACHE(), assuming that

- is there a way to store the type info somewhere (aside from using it for
__alignof__) so that perf can later get it back? I think [2] is currently
missing the step from knowing the kmem_cache's name to the type?

- could hardening benefit from this somehow, like it is supposed to benefit
for kmalloc() in [1] ?

So if these questions have positive answers, we could think about extending
KMEM_CACHE() to support the new args parameter, making it the primary cache
creation API and converting all users to that, while deprecating the other
variants.

Thanks,
Vlastimil

[1] https://lore.kernel.org/all/20240822231324.make.666-kees@kernel.org/
[2] https://lore.kernel.org/all/20241002180956.1781008-1-namhyung@kernel.org/

