Return-Path: <bpf+bounces-30052-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2884F8CA384
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 22:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C9411F2186D
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 20:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A612713792E;
	Mon, 20 May 2024 20:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eCNbh19L";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NUEAlKfI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eCNbh19L";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NUEAlKfI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6916F168BD
	for <bpf@vger.kernel.org>; Mon, 20 May 2024 20:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716238364; cv=none; b=ZJVOPa9c5cp40zNeWm2zVrRep9KQRN4FZ9vPgT4cpJmw7ZdoYoTlZikem7gJRgINajycPlWSMUSWre1sv8wHzT90JkgM9NoOa8pIGtVuWGW6D1o5VgzjVnWxOlojgT1ZDjDxOH6hjcvg7gKTn2vuBKM+NlZm6T0GfnYoPsi98ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716238364; c=relaxed/simple;
	bh=5CJuPt6GLa/h1XSh0sNWDduKSC4Pp9ew6rggrnD1/Zw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=RMa95/y2Svv3FxF9LTixXkansk5drkBo5tkqqsMNH8aMnJxT6lTmCKjk6p1d8a8NGssTVcsumhnWGJWIfvj2v8CWaoycfCmDDjcJhjPoL1/tYsXOX0/nkoSYO2fza/eSQuALNCG1gNEVQeMPK1JlwSr6G5RTEMyKsMODTEqQaJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eCNbh19L; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NUEAlKfI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eCNbh19L; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NUEAlKfI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7987820FCB;
	Mon, 20 May 2024 20:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716238359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mdDd3iLatj32+PqtXVazKgReKeFS9+tFkIGylHdwi1k=;
	b=eCNbh19Lh8Bs3ktu1QSuERHhHUDtO//qlmwBaCQ6ZnFsoq50v0Fckhh0QXAswB7G2xSXiX
	PVYuILxlEdHdw0y/doI+Z3h6fx0p5NAoKpNvFJtKOllxNazwLngwIGRcevIZBG+eSf7uie
	gJDJ4qZPb8LA/aYqAifS+rkkF1bSBrY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716238359;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mdDd3iLatj32+PqtXVazKgReKeFS9+tFkIGylHdwi1k=;
	b=NUEAlKfILcHjESWoRdGJJS3+RWhwb874K1p4QB7AjZoW8zARi5IJ+4gizgUUMv1lT/6iz+
	4t8wo29eae/yQvAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716238359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mdDd3iLatj32+PqtXVazKgReKeFS9+tFkIGylHdwi1k=;
	b=eCNbh19Lh8Bs3ktu1QSuERHhHUDtO//qlmwBaCQ6ZnFsoq50v0Fckhh0QXAswB7G2xSXiX
	PVYuILxlEdHdw0y/doI+Z3h6fx0p5NAoKpNvFJtKOllxNazwLngwIGRcevIZBG+eSf7uie
	gJDJ4qZPb8LA/aYqAifS+rkkF1bSBrY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716238359;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mdDd3iLatj32+PqtXVazKgReKeFS9+tFkIGylHdwi1k=;
	b=NUEAlKfILcHjESWoRdGJJS3+RWhwb874K1p4QB7AjZoW8zARi5IJ+4gizgUUMv1lT/6iz+
	4t8wo29eae/yQvAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 60E9E13A21;
	Mon, 20 May 2024 20:52:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6BJSFxe4S2aJKAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 20 May 2024 20:52:39 +0000
Message-ID: <f177782d-2bdf-42cd-8763-ce373b216ddb@suse.cz>
Date: Mon, 20 May 2024 22:52:39 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] SLUB: what's next?
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
To: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
 bpf <bpf@vger.kernel.org>
References: <b929d5fb-8e88-4f23-8ec7-6bdaf61f84f9@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <b929d5fb-8e88-4f23-8ec7-6bdaf61f84f9@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.22 / 50.00];
	BAYES_HAM(-2.93)[99.69%];
	SUBJECT_ENDS_QUESTION(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.22
X-Spam-Flag: NO

On 4/30/24 5:42 PM, Vlastimil Babka wrote:
> Hi,
> 
> I'd like to propose a session about the next steps for SLUB. This is
> different from the BOF about sheaves that Matthew suggested, which would be
> not suitable for the whole group due to being not fleshed out enough yet.
> But the session could be scheduled after the BOF so if we do brainstorm
> something promising there, the result could be discussed as part of the full
> session.

Since I've been asked if the slides could be shared, here goes:
https://drive.google.com/file/d/1fHozm2y97Biceh19e_aL5PrHLAZFntZW/view

> Aside from that my preliminary plan is to discuss:
> 
> - what was made possible by reducing the slab allocators implementations to
> a single one, and what else could be done now with a single implementation
> 
> - the work-in-progress work (for now in the context of maple tree) on SLUB
> per-cpu array caches and preallocation
> 
> - what functionality would SLUB need to gain so the extra caching done by
> bpf allocator on top wouldn't be necessary? (kernel/bpf/memalloc.c)
> 
> - similar wrt lib/objpool.c (did you even noticed it was added? :)
> 
> - maybe the mempool functionality could be better integrated as well?
> 
> - are there more cases where people have invented layers outside mm and that
> could be integrated with some effort? IIRC io_uring also has some caching on
> top currently...
> 
> - better/more efficient memcg integration?
> 
> - any other features people would like SLUB to have?
> 
> Thanks,
> Vlastimil


