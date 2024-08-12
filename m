Return-Path: <bpf+bounces-36904-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 812EF94F51E
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 18:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3E701C20ECB
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 16:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B06318754D;
	Mon, 12 Aug 2024 16:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YETtedG5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IxWXqqqh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="er+Tr6s6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yPvPl9r9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291B0130E27;
	Mon, 12 Aug 2024 16:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723480946; cv=none; b=ssC8s4tHb6UELXT2rUxlUDpmtVng90B9hRwA3hTMbkcK4ZaG/ivaHivyJui4rT2pAdk53plX1cNyT2OVLtupKOPn7aQS5eqHOTxwLzuWWVZ8iRskndzPg/9V0rrpOjrKI69mzCGOTXK3SV+bZv0JPYDlHa64sL4hKaAK/BysQcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723480946; c=relaxed/simple;
	bh=UXNyY0Y/XATpxaSUkI5vJ9WXxIozB3dji+bgRcnlncA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GeDvdE5LAbbWMe8Nv8PtTLAIWuB4+gpJn4QrcuT85ud6NtClFMAaTowPvpfaNh5TSN9s6W88sqCmuW79BpcODBgCLieRcSpsXfzcjfvtqZ6UgAWhI8InL3+ovEL15Uod1C6MA3S7GuYG+Ysf3AMGLQ2lppFkKLAUoDsNsR9s/aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YETtedG5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IxWXqqqh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=er+Tr6s6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yPvPl9r9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 00187202A2;
	Mon, 12 Aug 2024 16:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723480943;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UXNyY0Y/XATpxaSUkI5vJ9WXxIozB3dji+bgRcnlncA=;
	b=YETtedG52dxzzQKoc5UNo+STUbiZMzUJ5uknGtzgsLUZhHJdUTaQCrdFBdAGlTAl4iVvQy
	BvA0lc4UHOjMyGgoDGCXDsSGI/jnp5QEi4xP9F9Lifw+7TwL3zTg596SeVs1YmGAykDHEh
	7Bis2NhhpDZPSn+/fOL7mnF+q2B2hbE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723480943;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UXNyY0Y/XATpxaSUkI5vJ9WXxIozB3dji+bgRcnlncA=;
	b=IxWXqqqhFp7St3AwPza3ffJytGxZxnAOHbQt41wIuRSQKFuhibbCvTMjk6QEi0J+xIcFff
	MvFHW5vh1cH/MiAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723480942;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UXNyY0Y/XATpxaSUkI5vJ9WXxIozB3dji+bgRcnlncA=;
	b=er+Tr6s6jwipCg415x7OaHlTKmwxPvKl5Ix4lKVvvwnT30cfYarXAvhMka2P/uBkBg0oZW
	GFIoyoE5dqH97HgyHp66kanzH3wMoc2O5TVPx5Xz5gc4j66X1SIF09XoGgDbcDku6CA3ty
	QCPHeY8hohh6QEBTxCFCAiwzh2qnTUQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723480942;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UXNyY0Y/XATpxaSUkI5vJ9WXxIozB3dji+bgRcnlncA=;
	b=yPvPl9r9MCkiehrPXLpy6BlgXj0u6j7Bv17+GaDukJm/XzaonoTaKOI2FkAn6tcTOSS+/i
	YtsH1RVHKXmABBBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CD00113A23;
	Mon, 12 Aug 2024 16:42:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qz3OMW07umaiPAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 12 Aug 2024 16:42:21 +0000
Date: Mon, 12 Aug 2024 18:42:20 +0200
From: David Sterba <dsterba@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] btrfs: update target inode's ctime on unlink
Message-ID: <20240812164220.GK25962@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240812-btrfs-unlink-v1-1-ee5c2ef538eb@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812-btrfs-unlink-v1-1-ee5c2ef538eb@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,opengroup.org:url,suse.com:email,suse.cz:replyto]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, Aug 12, 2024 at 12:30:52PM -0400, Jeff Layton wrote:
> Unlink changes the link count on the target inode. POSIX mandates that
> the ctime must also change when this occurs.

Right, thanks. According to https://pubs.opengroup.org/onlinepubs/9699919799/functions/unlink.html:

Upon successful completion, unlink() shall mark for update the last data
modification and last file status change timestamps of the parent
directory. Also, if the file's link count is not 0, the last file status
change timestamp of the file shall be marked for update.


> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Reviewed-by: David Sterba <dsterba@suse.com>

