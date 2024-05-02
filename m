Return-Path: <bpf+bounces-28427-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB308B95FC
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 10:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F13341F22561
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 08:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB702575B;
	Thu,  2 May 2024 07:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OCfJTmIN";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OCfJTmIN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342BA22F00
	for <bpf@vger.kernel.org>; Thu,  2 May 2024 07:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714636798; cv=none; b=ReiLIHs1jWqbkmwZReRiNghomAAw2/Ls7PUGVMkkhUkN7epasi+NtOjtNNXwvmVF2BqFJkWlf36pQulQqmmKrFbePr5LVrH8x9te7UchBb7owRayiE8HxpYoITpCq7DIaJMcclKcA1mk8FTJSOR8RJZTqUoDQL5/tZDoFJ/VGRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714636798; c=relaxed/simple;
	bh=9B+2TmTVP1i04rXUCRbYj07g/tdiApnT6mJNCpaQ+vY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJ6LE74Y2Y6KsfBqWuCbtu9/JIgqKMb+xwAgepTaFpUCPMVkwH+seh55xWyHp04JVbaVcFsLYayQC3xnsPjwbbkEywqNnPT0aRj/60kGHcPR0aFqG5lRWmDbW8NVHG62RsTgsErpiUHbHHwmesf1r0GxWv5ypJ2iFYELgc7EZWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OCfJTmIN; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OCfJTmIN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 526CE350C7;
	Thu,  2 May 2024 07:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714636795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jwMXEhuqwtOAvaIoD03YuDzdsGEFsjaWp6fUquJMkxg=;
	b=OCfJTmINt3WDycBW5M7CQlWJR2l8g6c++aCLHxCaQLn8iGxJ8ZrYkyYFvmvHKRJKaZUP2L
	4q5iwipvd5QzWAX//nmADpGHhewpLJtvASBVQjGHOzmGIwS6dc2xcSVWONe1Ks0VvpVlHs
	iBBF77xAJlN/mq/4O6pBp0YIDIJNN9g=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=OCfJTmIN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714636795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jwMXEhuqwtOAvaIoD03YuDzdsGEFsjaWp6fUquJMkxg=;
	b=OCfJTmINt3WDycBW5M7CQlWJR2l8g6c++aCLHxCaQLn8iGxJ8ZrYkyYFvmvHKRJKaZUP2L
	4q5iwipvd5QzWAX//nmADpGHhewpLJtvASBVQjGHOzmGIwS6dc2xcSVWONe1Ks0VvpVlHs
	iBBF77xAJlN/mq/4O6pBp0YIDIJNN9g=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 39D0113957;
	Thu,  2 May 2024 07:59:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id obG8C/tHM2aCWAAAD6G6ig
	(envelope-from <mhocko@suse.com>); Thu, 02 May 2024 07:59:55 +0000
Date: Thu, 2 May 2024 09:59:50 +0200
From: Michal Hocko <mhocko@suse.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	bpf <bpf@vger.kernel.org>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] SLUB: what's next?
Message-ID: <ZjNH9oerqOyxDokU@tiehlicka>
References: <b929d5fb-8e88-4f23-8ec7-6bdaf61f84f9@suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b929d5fb-8e88-4f23-8ec7-6bdaf61f84f9@suse.cz>
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 526CE350C7
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	SUBJECT_ENDS_QUESTION(1.00)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	DKIM_TRACE(0.00)[suse.com:+]

On Tue 30-04-24 17:42:18, Vlastimil Babka wrote:
> Hi,
> 
> I'd like to propose a session about the next steps for SLUB. This is
> different from the BOF about sheaves that Matthew suggested, which would be
> not suitable for the whole group due to being not fleshed out enough yet.
> But the session could be scheduled after the BOF so if we do brainstorm
> something promising there, the result could be discussed as part of the full
> session.
> 
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

Thanks a lot Vlastimi. This is quite a list. Do you think this is a fit
into a single time slot or would that benefit from splitting into 2
slots?
-- 
Michal Hocko
SUSE Labs

