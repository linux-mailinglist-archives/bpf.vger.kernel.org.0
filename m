Return-Path: <bpf+bounces-37027-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD519505D4
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 15:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE77FB295E8
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 13:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FC919ADA8;
	Tue, 13 Aug 2024 13:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GCuyQ07K";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eP/3ivR+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GCuyQ07K";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eP/3ivR+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFD81E498;
	Tue, 13 Aug 2024 13:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723554037; cv=none; b=PUdeR6RLm1A/3vB+5SdvxDL7tIk4D25CtrnZEYVh7JT2fU7jShTkNC0oBjuFuaobO9gaO+M7yh5F7hNGpbHjcJHcru3heabiLkI91MYuwRZBeZzZme4pflvzIgrRZmmJ5jGvCp5C6XTl7b1lf55nBrFzDtZjvNzBP4AkRhdTu1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723554037; c=relaxed/simple;
	bh=Gc1BnjO0Wwo/2nh/UA+H+KfqU7zrEJ8jtdMe05JLOLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jxMgH5X/nouvrGQqeieXb2Axw40ix525fyrfyFWMME2nX9h8e7FyHtYRS97xBncX1PrpyVlDqRZjjCwZRTI7k7Q0Omj+YEfj5VM1ooVhjmapZzhVUjdIKd9aQNPdDV1goufdkjq8/KlpVAdQutVL8Kup8nQMbM8tMdNdAi62qXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GCuyQ07K; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eP/3ivR+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GCuyQ07K; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eP/3ivR+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 941E5227DC;
	Tue, 13 Aug 2024 13:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723554033;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6YkXeoMGTz6M/0wDSQnaVaGxaaJPy/Eq5C66ovHhFZI=;
	b=GCuyQ07K0pyBOSXvqnMU0+YbPATXJyVal5YGyO8v0q01Ywxvzn1iGEG1GmH/3IMAxdZhRs
	kocDUCwvfIqY9XSKIXYjD5so24N32vtHmAgV+3TyMkPaDs+Lci9JMiTiA6AGssQ6AiRCRb
	Y2yFbU3XYSg4qli5JH0oukwQ+ZVmU84=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723554033;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6YkXeoMGTz6M/0wDSQnaVaGxaaJPy/Eq5C66ovHhFZI=;
	b=eP/3ivR+/jvbM1ehvYxZQ41CHMk621sGpDkhEaBDBbgjuTbd7W6Vh4H/v2aB2QDimb0Zp7
	c2amhO78zP6j6aAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723554033;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6YkXeoMGTz6M/0wDSQnaVaGxaaJPy/Eq5C66ovHhFZI=;
	b=GCuyQ07K0pyBOSXvqnMU0+YbPATXJyVal5YGyO8v0q01Ywxvzn1iGEG1GmH/3IMAxdZhRs
	kocDUCwvfIqY9XSKIXYjD5so24N32vtHmAgV+3TyMkPaDs+Lci9JMiTiA6AGssQ6AiRCRb
	Y2yFbU3XYSg4qli5JH0oukwQ+ZVmU84=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723554033;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6YkXeoMGTz6M/0wDSQnaVaGxaaJPy/Eq5C66ovHhFZI=;
	b=eP/3ivR+/jvbM1ehvYxZQ41CHMk621sGpDkhEaBDBbgjuTbd7W6Vh4H/v2aB2QDimb0Zp7
	c2amhO78zP6j6aAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A59313983;
	Tue, 13 Aug 2024 13:00:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id b66VHfFYu2ZoDAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 13 Aug 2024 13:00:33 +0000
Date: Tue, 13 Aug 2024 15:00:24 +0200
From: David Sterba <dsterba@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: dsterba@suse.cz, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH] btrfs: update target inode's ctime on unlink
Message-ID: <20240813130024.GP25962@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240812-btrfs-unlink-v1-1-ee5c2ef538eb@kernel.org>
 <20240812164220.GK25962@twin.jikos.cz>
 <c0a0266cbb46694318e5eeb5248216779cb68442.camel@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0a0266cbb46694318e5eeb5248216779cb68442.camel@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,twin.jikos.cz:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, Aug 12, 2024 at 12:51:21PM -0400, Jeff Layton wrote:
> On Mon, 2024-08-12 at 18:42 +0200, David Sterba wrote:
> > On Mon, Aug 12, 2024 at 12:30:52PM -0400, Jeff Layton wrote:
> > > Unlink changes the link count on the target inode. POSIX mandates that
> > > the ctime must also change when this occurs.
> > 
> > Right, thanks. According to https://pubs.opengroup.org/onlinepubs/9699919799/functions/unlink.html:
> > 
> > Upon successful completion, unlink() shall mark for update the last data
> > modification and last file status change timestamps of the parent
> > directory. Also, if the file's link count is not 0, the last file status
> > change timestamp of the file shall be marked for update.
> > 
> 
> Weird way to phrase to that. IMO, we still want to stamp the inode's
> ctime even if the link count goes to 0. That's what Linux generally
> does, anyway. Oh well..
>  
> > 
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > 
> > Reviewed-by: David Sterba <dsterba@suse.com>
> 
> 
> FWIW, this should probably go in via the btrfs tree. 

Yes, we'll take it.

