Return-Path: <bpf+bounces-61160-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98213AE1977
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 13:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 085BB4A5A4B
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 11:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879AA28A40D;
	Fri, 20 Jun 2025 11:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="m4/rRFXe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="keuZXPJL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="m4/rRFXe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="keuZXPJL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44A4283FDA
	for <bpf@vger.kernel.org>; Fri, 20 Jun 2025 11:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750417328; cv=none; b=nx+29GMZXGVV/UeJVFj0LkPtMXIK1Q4nKHEzYn40kpkkFbKnHVxL1oZqEPCdDTvSAYkBFE6PpFF9ofTqko2eNFQix/RTuHOh4wVTHNczKhfCdnqUDIDuyFxbxaurzho5XC2i+FFNMVtboqxyBpBB2NuNmmMyntg+p4m+/dylYLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750417328; c=relaxed/simple;
	bh=krPL8SLPhNETObWiuCZmMldIFn+Ebw+ujtbHN7uw5eE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CI/4HxP65mnCD748NII0zsOZGGmcsEMk/bdZ4M8ukX7NhtDBnT8M3uNcELjyxp1I0ne89+B8n4TMGTRM+AaIkfBiF7HHWjT7y1okdmrHn0QrOVqw4+RR58FftEsqXRCCQbapLNDCqKAktN7+HyS3ije0jaUngjL+fZhNZnLd5ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=m4/rRFXe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=keuZXPJL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=m4/rRFXe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=keuZXPJL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 85E2021196;
	Fri, 20 Jun 2025 11:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750417317; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FV7U65hwaJMIq06afxPOVK3sa5XbOzLmrtQ8epTLQOs=;
	b=m4/rRFXeVJcz/rzXZ/0ZjOqVqdNyRjvRMJ8tG3W6wmKXEoh9qEshHdhlJGLbbF246/NELa
	PbWO5gqZwR3u4pn+Gl3ummg1cC2ghKweZfMvA3T9/1w8yt1n6C+mJdp0XKEvXTpTExHwX2
	gC8bt0/kwOfomD7teBS5UQvsrk8X4eA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750417317;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FV7U65hwaJMIq06afxPOVK3sa5XbOzLmrtQ8epTLQOs=;
	b=keuZXPJLtATHQ1Byl7NJbHhbYpz0MU72WZfwmi782Y3fr8pUhkgpdahoBgZ2GX6B9WEwKQ
	12rhn9hjT9WC9jAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="m4/rRFXe";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=keuZXPJL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750417317; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FV7U65hwaJMIq06afxPOVK3sa5XbOzLmrtQ8epTLQOs=;
	b=m4/rRFXeVJcz/rzXZ/0ZjOqVqdNyRjvRMJ8tG3W6wmKXEoh9qEshHdhlJGLbbF246/NELa
	PbWO5gqZwR3u4pn+Gl3ummg1cC2ghKweZfMvA3T9/1w8yt1n6C+mJdp0XKEvXTpTExHwX2
	gC8bt0/kwOfomD7teBS5UQvsrk8X4eA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750417317;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FV7U65hwaJMIq06afxPOVK3sa5XbOzLmrtQ8epTLQOs=;
	b=keuZXPJLtATHQ1Byl7NJbHhbYpz0MU72WZfwmi782Y3fr8pUhkgpdahoBgZ2GX6B9WEwKQ
	12rhn9hjT9WC9jAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB74F136BA;
	Fri, 20 Jun 2025 11:01:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jNd+NqM/VWg9DwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Fri, 20 Jun 2025 11:01:55 +0000
Date: Fri, 20 Jun 2025 12:01:54 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: sashal@kernel.org, 
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, Breno Leitao <leitao@debian.org>, 
	"David S. Miller" <davem@davemloft.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Horman <horms@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Mina Almasry <almasrymina@google.com>, 
	Yonglong Liu <liuyonglong@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, Matthew Wilcox <willy@infradead.org>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-rdma@vger.kernel.org, linux-mm@kvack.org, 
	Qiuling Ren <qren@redhat.com>, Yuying Ma <yuma@redhat.com>, gregkh@linuxfoundation.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH net-next v9 2/2] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
Message-ID: <5geg5wg36vsu6igy5yndfolgkhev5uuslr67s5ygfabgmxrfty@5iw3y24mmv57>
References: <20250409-page-pool-track-dma-v9-0-6a9ef2e0cba8@redhat.com>
 <20250409-page-pool-track-dma-v9-2-6a9ef2e0cba8@redhat.com>
 <aEmwYU/V/9/Ul04P@gmail.com>
 <20250611131241.6ff7cf5d@kernel.org>
 <87jz5hbevp.fsf@toke.dk>
 <20250612070518.69518466@kernel.org>
 <87zfecrq3d.fsf@toke.dk>
 <20250613080202.28d25763@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250613080202.28d25763@kernel.org>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 85E2021196
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,debian.org,davemloft.net,nvidia.com,lunn.ch,google.com,linaro.org,linux-foundation.org,huawei.com,gmail.com,infradead.org,vger.kernel.org,kvack.org,linuxfoundation.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	R_RATELIMIT(0.00)[to_ip_from(RLc7d9qgwtzysrasug3x86bmuu)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -2.51
X-Spam-Level: 

On Fri, Jun 13, 2025 at 08:02:02AM -0700, Jakub Kicinski wrote:
> On Fri, 13 Jun 2025 10:41:10 +0200 Toke Høiland-Jørgensen wrote:
> > Jakub Kicinski <kuba@kernel.org> writes:
> > 
> > > On Thu, 12 Jun 2025 09:25:30 +0200 Toke Høiland-Jørgensen wrote:  
> > >> Hmm, okay, guess we should ask Sasha to drop these, then?
> > >> 
> > >> https://lore.kernel.org/r/20250610122811.1567780-1-sashal@kernel.org
> > >> https://lore.kernel.org/r/20250610120306.1543986-1-sashal@kernel.org  
> > >
> > > These links don't work for me?  
> > 
> > Oh, sorry, didn't realise the stable notifications are not archived on
> > lore. Here are the patches in the stable queue:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/queue-6.12/page_pool-move-pp_magic-check-into-helper-functions.patch
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/queue-6.12/page_pool-track-dma-mapped-pages-and-unmap-them-when.patch
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/queue-6.15/page_pool-move-pp_magic-check-into-helper-functions.patch
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/queue-6.15/page_pool-track-dma-mapped-pages-and-unmap-them-when.patch
> 
> Thanks!
> 
> Sasha, could we drop these please? They need more mileage before we
> send them to LTS.

FYI: The patches made it into 6.15.3 and 6.12.34.

-- 
Pedro

