Return-Path: <bpf+bounces-57493-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C55E8AABD2F
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 10:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DC993AEA70
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 08:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEB824EABD;
	Tue,  6 May 2025 08:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="A52Jxgql";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aTJeXxFf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YpjU4dHF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="r5dJzAgz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C5F24C66E
	for <bpf@vger.kernel.org>; Tue,  6 May 2025 08:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746520018; cv=none; b=QL6A2AFu+c+frEFApv3m2wz5ldruP9TPjhvyU+aTVg9KC05Zn7CVJ64xhKf4JLfzLvFe3GEgWPSoGbBdFydwldAdiM4Mot9vR/6vzoymuwh6vXlCUtQlcTPQMQfp1PPoE46q/XJ/3MMg8VnDi5NEb4/fUXkQ5OmHztzCZMoG5Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746520018; c=relaxed/simple;
	bh=k6oBjqj7WnjFui+IKQMKYhb8W9nZoZLtJ3Rm9sIqC2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kRz3JYXG3JFnkK1WN7KRpb2dSEaKx2WeCX6FQ2gBTNLrsmlY9f9S63rnTpaTxIOCLAkgbLzPJ35eD7+0glkSKInmF/mojcwj/PNmeT62Yf2qdNxmeQvjX5pZw089Fmm9oucV0cg1h5CU+kl/m1rjPO5rbIz7SP1X/+RV+8FfTzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=A52Jxgql; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aTJeXxFf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YpjU4dHF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=r5dJzAgz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 82D4521221;
	Tue,  6 May 2025 08:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746520014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MugKZ+75dZsPHAbDDgCr7LvgOAIdAFacOpFX79qTvDo=;
	b=A52JxgqleDEndIOXZrzRVfciKS7nw5m+BKjG00lviTmw/XBLvap8Q2luVzhfNzOcCBAGPf
	Rf9RLD+gwFK7OdyewUAr37d6Upe90hQGsHybkQ+bpro0QTS/amGDI63eupSqgYNOdZP55N
	O3Wc59uqApq5UECaX/Ymmi4z/L4Uog8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746520014;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MugKZ+75dZsPHAbDDgCr7LvgOAIdAFacOpFX79qTvDo=;
	b=aTJeXxFfEN5MAA+BpY5h/kqWUp0b3nXD17I/oRpK4BuXuSg77Tl1cCSsFLf59LzkVoUjas
	GA48o7yYnq+HbCBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746520013; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MugKZ+75dZsPHAbDDgCr7LvgOAIdAFacOpFX79qTvDo=;
	b=YpjU4dHFhtMmIdJp/m0NyHTmQ4U+rP1LThtr6D5JD0oNpBl86uKvgVvxpILFc0dE4mvxjX
	+51A47nYqpvp7TgzrjBUogLY+ZZgf3aqbMilGW7Td73O4ezLo6HFgMNxEhnRKy5ZlcHs6Q
	YCPsl8GtWjSDU5eu5pWikYa5wDnxcmw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746520013;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MugKZ+75dZsPHAbDDgCr7LvgOAIdAFacOpFX79qTvDo=;
	b=r5dJzAgzCHEU0G0KR4J84x5g/9S1gZrp19EsnFk3s9SXQf+9BWpJqU4+d/QV1h1LWhlZrP
	y0RocCvBe/DmPLDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6714B13687;
	Tue,  6 May 2025 08:26:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id y9N+GM3HGWivWgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 06 May 2025 08:26:53 +0000
Message-ID: <441a3e7d-2000-47d2-ba13-6841eb392fe1@suse.cz>
Date: Tue, 6 May 2025 10:26:53 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] mm: Rename try_alloc_pages() to alloc_pages_nolock()
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
 linux-mm@kvack.org
Cc: harry.yoo@oracle.com, shakeel.butt@linux.dev, mhocko@suse.com,
 bigeasy@linutronix.de, andrii@kernel.org, memxor@gmail.com,
 akpm@linux-foundation.org, peterz@infradead.org, rostedt@goodmis.org,
 hannes@cmpxchg.org, willy@infradead.org
References: <20250501032718.65476-1-alexei.starovoitov@gmail.com>
 <20250501032718.65476-2-alexei.starovoitov@gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20250501032718.65476-2-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,kvack.org];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[oracle.com,linux.dev,suse.com,linutronix.de,kernel.org,gmail.com,linux-foundation.org,infradead.org,goodmis.org,cmpxchg.org];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -2.80
X-Spam-Flag: NO

On 5/1/25 05:27, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> The "try_" prefix is confusing, since it made people believe
> that try_alloc_pages() is analogous to spin_trylock() and
> NULL return means EAGAIN. This is not the case. If it returns
> NULL there is no reason to call it again. It will most likely
> return NULL again. Hence rename it to alloc_pages_nolock()
> to make it symmetrical to free_pages_nolock() and document that
> NULL means ENOMEM.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> @@ -7378,20 +7378,21 @@ static bool __free_unaccepted(struct page *page)
>  #endif /* CONFIG_UNACCEPTED_MEMORY */
>  
>  /**
> - * try_alloc_pages - opportunistic reentrant allocation from any context
> + * alloc_pages_nolock - opportunistic reentrant allocation from any context
>   * @nid: node to allocate from
>   * @order: allocation order size
>   *
>   * Allocates pages of a given order from the given node. This is safe to
>   * call from any context (from atomic, NMI, and also reentrant
> - * allocator -> tracepoint -> try_alloc_pages_noprof).
> + * allocator -> tracepoint -> alloc_pages_nolock_noprof).
>   * Allocation is best effort and to be expected to fail easily so nobody should
>   * rely on the success. Failures are not reported via warn_alloc().
>   * See always fail conditions below.
>   *
> - * Return: allocated page or NULL on failure.
> + * Return: allocated page or NULL on failure. NULL does not mean EBUSY or EAGAIN.
> + * It means ENOMEM. There is no reason to call it again and expect !NULL.

Should we explain that the "ENOMEM" doesn't necessarily mean the system is
out of memory, but also that the calling context might be simply unlucky
(preempted someone with the lock) and retrying in the same context can't
help it?


