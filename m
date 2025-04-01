Return-Path: <bpf+bounces-55046-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6857A775AB
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 09:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD50B188B8BD
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 07:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4AF1EA7D7;
	Tue,  1 Apr 2025 07:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JfOi/Eeq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="d1lFf7+I";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3F1F/xT4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ErmeEZId"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3B61EA7C2
	for <bpf@vger.kernel.org>; Tue,  1 Apr 2025 07:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743493991; cv=none; b=h2pLyxn/C9QocmdULpBqnX2WE86TANSYQmc4koUpHOUOtWVJdgRKF7h3qXwdSqizWaS/Fo/k/lQnZN3vk9VCqsZSje0TXquNl3LYYnkgTsPdSELNyDpxgTEmet2F4citMKB2M/tBcX5bmUZGYKPllI21vyK8pt6oOmmRD7LvPv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743493991; c=relaxed/simple;
	bh=dHVyVJeHsAIk82Ns04Tg/C3Ex2qOe5USrLtmpNoFqGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pf87l21zlWhE3KiLt9ylErIgKxm+gQJZG+nw+WoqsMkQxe+JSI9d+jMe++mL350oAOJ1rPjvyZl5Tg514NF99/F8kaLd4e193RC2GPMu968wywrD5fV8vgKrvTWROO8NXYfENv8xS3XY+SR6iNLhnnBqNJPwq204pbTmWkR4WZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JfOi/Eeq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=d1lFf7+I; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3F1F/xT4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ErmeEZId; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6213421174;
	Tue,  1 Apr 2025 07:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743493987; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZDs6f2RqNEJKjQpmeujYZRnkKQiNNSByIAH1zsTtCXU=;
	b=JfOi/EeqNXQp2XWILz0NA/vVmg8keTXV6WpsZfKAAFVCeqiSu1TbdwWdCYzlnMsDuIgg95
	L/b9qwZ0vmqO0JVPNuYO2ltOG5NgDvLlsiy74uWEHEhSwSMLJ/+wQ0TFpig8aXRuR8APaN
	lGwQR6ty/PXy7lTjHO8LdLXeiTDdq2Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743493987;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZDs6f2RqNEJKjQpmeujYZRnkKQiNNSByIAH1zsTtCXU=;
	b=d1lFf7+IRUZ6k0YRFqYPFZW3QF85pRFTsZua+/ANHFjuN8f3hL6VSlRnBmrYSga/hBc6Jx
	UNaWFsrLijQqF/CQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="3F1F/xT4";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ErmeEZId
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743493986; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZDs6f2RqNEJKjQpmeujYZRnkKQiNNSByIAH1zsTtCXU=;
	b=3F1F/xT40f6WKUiJf88N8/vrGP+b9916+hZJVvVLZBAwUfOUAjyyzlQ9uJHR66BD7DH8pB
	nYCAReZk0po/dRGL8TEZtlzTx8GsANjjL8xJeKGJvW6s1o0l3+kM6kN25JvZpkGGN6fDum
	2odfn1Vzxy/MfSnUYsAEjNuNgKoXeBQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743493986;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZDs6f2RqNEJKjQpmeujYZRnkKQiNNSByIAH1zsTtCXU=;
	b=ErmeEZIdbdMZzKX7dByHFtl2XxwcM7cpQ1a0fHc4U4FrbUymqvcl0X1M2CnLE2cGeDJKh4
	wVbgjuz1fa9p6nAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3DDC1138A5;
	Tue,  1 Apr 2025 07:53:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pnHCDmKb62dQXQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 01 Apr 2025 07:53:06 +0000
Message-ID: <ac5d6544-32cb-4ae1-a62a-7720b67b4042@suse.cz>
Date: Tue, 1 Apr 2025 09:53:05 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/page_alloc: Fix try_alloc_pages
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org, akpm@linux-foundation.org, peterz@infradead.org,
 bigeasy@linutronix.de, rostedt@goodmis.org, shakeel.butt@linux.dev,
 mhocko@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250401032336.39657-1-alexei.starovoitov@gmail.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20250401032336.39657-1-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6213421174
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com,linux-foundation.org];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.cz:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

On 4/1/25 05:23, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Fix an obvious bug. try_alloc_pages() should set_page_refcounted.
> 
> Fixes: 97769a53f117 ("mm, bpf: Introduce try_alloc_pages() for opportunistic page allocation")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Acked-by: Vlastimil BAbka <vbabka@suse.cz>

> ---
> 
> As soon as I fast forwarded and rerun the tests the bug was
> seen immediately.
> I'm completely baffled how I managed to lose this hunk.

I think the earlier versions were done on older base than v6.14-rc1 which
acquired efabfe1420f5 ("mm/page_alloc: move set_page_refcounted() to callers
of get_page_from_freelist()")

> I'm pretty sure I manually tested various code paths of
> trylock logic with CONFIG_DEBUG_VM=y.
> Pure incompetence :(
> Shame.
> ---
>  mm/page_alloc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index ffbb5678bc2f..c0bcfe9d0dd9 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7248,6 +7248,9 @@ struct page *try_alloc_pages_noprof(int nid, unsigned int order)
>  
>  	/* Unlike regular alloc_pages() there is no __alloc_pages_slowpath(). */
>  
> +	if (page)
> +		set_page_refcounted(page);

Note for the later try-kmalloc integration, slab uses frozen pages now, so
we'll need to split out a frozen variant of this API.

But this is ok as a bugfix for now.

> +
>  	if (memcg_kmem_online() && page &&
>  	    unlikely(__memcg_kmem_charge_page(page, alloc_gfp, order) != 0)) {
>  		free_pages_nolock(page, order);


