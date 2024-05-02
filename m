Return-Path: <bpf+bounces-28429-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D808B97AE
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 11:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D4791F27297
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 09:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDD155C08;
	Thu,  2 May 2024 09:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TT/Wwwi9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UilqB6lp";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MuldbubO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="i1uTn/e7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E6853E25
	for <bpf@vger.kernel.org>; Thu,  2 May 2024 09:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714641979; cv=none; b=dq5yHHMQg55JmNlIRRXr9gcqwExXi+MRQtgufxMJNxe0UHskdF04QbknRmMokjzJGADo9I09HRoJyX9Mu6cCZRLr+sV06lIeX+3f/AGNuKDc7d9Bth/zmLvdpAc65WCJ1YQXaChrhiOdes8NHegVvPE2z9HCEEL6zXccC/LZLnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714641979; c=relaxed/simple;
	bh=zG7t0JyGDB6KucP0tJIVFJQj6I85xwALMiGrsXUeg1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=By4B3qU5tGnqHjfbxK5yypVyhwBuFcZpWIIfs87Z2L+CTmvLIBVMHIrjPv7nbo9uscAd8HwBkQjekrBJbPKYR4MlcXug9t8w16thPraSZh5KlpHNqgJNkAKYWtS51O9Nu+9Gg+n5qfaK3oa2er8W4rSWi6SLe7vyL+vyt67vylo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TT/Wwwi9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UilqB6lp; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MuldbubO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=i1uTn/e7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4EABD1FBBF;
	Thu,  2 May 2024 09:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714641975; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VEky75BpmWHjz6K+3uYux2GVx3MS1Nz5gtcruObmVSY=;
	b=TT/Wwwi9CDfym82bm7Ayjk5TDxDYG3em4FyZpgulcOt2w/ZR4UVD2P0iTA3SpXkrU7QTRq
	yafGChYZK4SnwTHtBBooPbZJFARcNoQZpCUTUDVvzhRS9mT5s/DK1QH8v3l8nw6MgNWjHv
	O47Zstz2obo6bR9CIxCIYNqarpEsr+w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714641975;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VEky75BpmWHjz6K+3uYux2GVx3MS1Nz5gtcruObmVSY=;
	b=UilqB6lpdII7sl7YwL59lGxu709k310N35kXO7GMGipCk6YFDHh6kpkEDax/jeLxVedY1L
	HKVkTgDP+Br1bWDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=MuldbubO;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="i1uTn/e7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714641974; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VEky75BpmWHjz6K+3uYux2GVx3MS1Nz5gtcruObmVSY=;
	b=MuldbubONns1o7fXHsAWh49NujrZYapPN3/W1A9AuxKQTj0050HbiOH078LatDfpVtY/Yh
	Dc0w7z0t7Hu8MPxuquaxQIkjsGo4S7nPKe5SLNGwUgnNPBfq5Fh9KJCv3hIc0aUr3R99AV
	pJa1eOhx5t9J6q0Y84d9jTLrpVvttgw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714641974;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VEky75BpmWHjz6K+3uYux2GVx3MS1Nz5gtcruObmVSY=;
	b=i1uTn/e7tYAJoEAfVpJj/feWriys7KkxeS6K8kD22H8UxDAabmqB5PBMf+fsQ0I+RGMW34
	MPs8lRKiQMBhpDCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4228A13957;
	Thu,  2 May 2024 09:26:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id itG0DzZcM2YGdwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 02 May 2024 09:26:14 +0000
Message-ID: <67304905-57d7-47f5-937b-2c4fb95d13ba@suse.cz>
Date: Thu, 2 May 2024 11:26:34 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] SLUB: what's next?
To: Michal Hocko <mhocko@suse.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
 bpf <bpf@vger.kernel.org>
References: <b929d5fb-8e88-4f23-8ec7-6bdaf61f84f9@suse.cz>
 <ZjNH9oerqOyxDokU@tiehlicka>
From: Vlastimil Babka <vbabka@suse.cz>
Content-Language: en-US
In-Reply-To: <ZjNH9oerqOyxDokU@tiehlicka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -3.50
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 4EABD1FBBF
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUBJECT_ENDS_QUESTION(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]



On 5/2/24 09:59, Michal Hocko wrote:
> On Tue 30-04-24 17:42:18, Vlastimil Babka wrote:
>> Hi,
>>
>> I'd like to propose a session about the next steps for SLUB. This is
>> different from the BOF about sheaves that Matthew suggested, which would be
>> not suitable for the whole group due to being not fleshed out enough yet.
>> But the session could be scheduled after the BOF so if we do brainstorm
>> something promising there, the result could be discussed as part of the full
>> session.
>>
>> Aside from that my preliminary plan is to discuss:
>>
>> - what was made possible by reducing the slab allocators implementations to
>> a single one, and what else could be done now with a single implementation
>>
>> - the work-in-progress work (for now in the context of maple tree) on SLUB
>> per-cpu array caches and preallocation
>>
>> - what functionality would SLUB need to gain so the extra caching done by
>> bpf allocator on top wouldn't be necessary? (kernel/bpf/memalloc.c)
>>
>> - similar wrt lib/objpool.c (did you even noticed it was added? :)
>>
>> - maybe the mempool functionality could be better integrated as well?
>>
>> - are there more cases where people have invented layers outside mm and that
>> could be integrated with some effort? IIRC io_uring also has some caching on
>> top currently...
>>
>> - better/more efficient memcg integration?
>>
>> - any other features people would like SLUB to have?
> 
> Thanks a lot Vlastimi. This is quite a list. Do you think this is a fit
> into a single time slot or would that benefit from splitting into 2
> slots?

I think single slot is fine, could schedule another one later if we
don't fit?

