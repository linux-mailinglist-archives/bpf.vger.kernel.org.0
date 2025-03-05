Return-Path: <bpf+bounces-53304-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 209B4A4FBD9
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 11:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 392711888A4B
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 10:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E619A2063D2;
	Wed,  5 Mar 2025 10:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JZne7VvX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="I9qsyjbZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JZne7VvX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="I9qsyjbZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA992063EC
	for <bpf@vger.kernel.org>; Wed,  5 Mar 2025 10:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741170384; cv=none; b=nrFoeY3O+U5T8hUwHZmhUO+Sc9WEL73sjaiOgPZl+OkaPTQp7uI8M2B5a4oe1u1wOObekPtyXIm5ay98pwPVI0clGj3YD8D4R8eyx9acP60kMRAhTpfS3xtr8yeIpRvbxb8UOL3LMlpZ3ZmJVq4Pj/xZa2FwlrPyWzaTdfOTsbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741170384; c=relaxed/simple;
	bh=fL2x/cCMV7wEOQyMRFdQVMPDIXSyxxSsjlSy5LCvPLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dyBWd41Cp7FgXZsKhAb30uAo0q0nSm8euXGG12csIpBN5ZsH9L6FPK0aEKJn9NFi7TdizA2XqeP+fObB47FpfPVJHn1inbSm4g63aWYS1jjrFWgR+26yFQzq5kS+pkAKzU8MpFgHe1kQMXkFc3boNwSaL+7RmJpEkgBA0CHSphI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JZne7VvX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=I9qsyjbZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JZne7VvX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=I9qsyjbZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 036E31F393;
	Wed,  5 Mar 2025 10:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741170381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fx3Hs2ab/mDkBUFq/ZI1BouZLIEyP0T4le/acD61ke0=;
	b=JZne7VvXRZNHpUSWy/pZXn9rwx+1MlyhL4ZGRDWbW4KgEvTb1ITTMNQbjg3ju50ivyr4s8
	r66gPbEDx0ysstFIjChbtYlKjAJj9dGsQO7xBxao6o1ieGBdyjEk8nElbbpeMY50GP84bF
	H6HS8hc6glCDqLzC4lSbhCNYJ8hQ1C8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741170381;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fx3Hs2ab/mDkBUFq/ZI1BouZLIEyP0T4le/acD61ke0=;
	b=I9qsyjbZDhnAF3q1+Wl5HGuomEfeILiImg6J33lbsTlcgV6xs6Ea/yoXmrcHyKu1fbeoLh
	/NOXuZfiESm9LsDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741170381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fx3Hs2ab/mDkBUFq/ZI1BouZLIEyP0T4le/acD61ke0=;
	b=JZne7VvXRZNHpUSWy/pZXn9rwx+1MlyhL4ZGRDWbW4KgEvTb1ITTMNQbjg3ju50ivyr4s8
	r66gPbEDx0ysstFIjChbtYlKjAJj9dGsQO7xBxao6o1ieGBdyjEk8nElbbpeMY50GP84bF
	H6HS8hc6glCDqLzC4lSbhCNYJ8hQ1C8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741170381;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fx3Hs2ab/mDkBUFq/ZI1BouZLIEyP0T4le/acD61ke0=;
	b=I9qsyjbZDhnAF3q1+Wl5HGuomEfeILiImg6J33lbsTlcgV6xs6Ea/yoXmrcHyKu1fbeoLh
	/NOXuZfiESm9LsDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DFDE11366F;
	Wed,  5 Mar 2025 10:26:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FlMkNswmyGcnfwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 05 Mar 2025 10:26:20 +0000
Message-ID: <b7723e7c-7422-4b68-af39-6a4f77c7d52c@suse.cz>
Date: Wed, 5 Mar 2025 11:26:20 +0100
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
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
 bpf <bpf@vger.kernel.org>, David Rientjes <rientjes@google.com>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Kees Cook <keescook@chromium.org>
References: <14422cf1-4a63-4115-87cb-92685e7dd91b@suse.cz>
 <ddcf9941-80c5-f2bd-1ef6-1336fe43272c@gentwo.org>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <ddcf9941-80c5-f2bd-1ef6-1336fe43272c@gentwo.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux-foundation.org,kvack.org,vger.kernel.org,google.com,gmail.com,kernel.org,chromium.org];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

On 2/26/25 01:17, Christoph Lameter (Ampere) wrote:
> 
> Let me just express my general concern. SLUB was written because SLAB
> became a Byzantine mess with layer upon layer of debugging and queues

I don't recall it having much debugging. IIRC it was behind some config that
nobody enabled. SLUB's debugging that can be dynamically enabled on boot is
so much better.

> here and there and with "maintenance" for these queues going on every 2
> seconds staggered on all processors. This caused a degree of OS noise that
> caused HPC jobs (and today we see similar issues with AI jobs) to not be
> able to accomplish a deterministic rendezvous. On some large machines

Yeah, I don't want to reintroduce this, hence sheaves intentionally don't
support NUMA restricted allocations so none of the flushed alien arrays are
necessary.

> we had ~10% of the whole memory vanish into one of the other queue on boot
> up with  the customers being a bit upset were all the expensive memory
> went.
> 
> It seems that were have nearly recreated the old nightmare again.

I don't see it that bleak.

> I would suggest rewriting the whole allocator once again trying to
> simplify things as much as possible and isolating specialized allocator
> functionality needed for some subsystems into different APIs.

Any specific suggestions? Some things are hard to isolate i.e. make them
work on top of the core allocator because not interacting with the internals
would not allow some useful functionality, or efficiency.

> The main allocation / free path needs to be as simple and as efficient as
> possible. It may not be possible to accomplish something like that given
> all the special casing that we have been pushing into it. Also consider the

I see some possibilities for simplification in not trying to support KASAN
together with slab_debug anymore. KASAN should be superior for that purpose
(of course you pay the extra cost) and it's tricky to not have it step on
each other's toes with slab_debug.

> runtime security measures and verification stuff that is on by default at
> runtime as well.

Yeah more and more hardening seems to be the current trend. But also not
realistically possible to isolate away from the core. I at least tried to
always compile all of it away completely when the respective CONFIG is not
enabled. OTOH I'd like to see some of that to support boot parameters (via
static keys etc) so it can be compiled in but not enabled. That would not
completely eliminate the overhead of passing e.g. the bucket parameter or
performing kmalloc random index evaluation, but would not allocate the
separate caches if not enabled, so the memory overhead of that would not be
imposed.

