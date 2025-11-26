Return-Path: <bpf+bounces-75579-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 621E7C89AF8
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 13:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B34A93A9A25
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 12:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEE93271F6;
	Wed, 26 Nov 2025 12:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="anZ5xh38";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dKNkGqBT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="anZ5xh38";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dKNkGqBT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9C2326924
	for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 12:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764158730; cv=none; b=Nb5/qYdvjB+IRPxkY2BFfeebQIhS0L1XsbK1HeK7yGM7iaKt28bEQHcZGk3EDMsLJwmC3R7/xfOUVIy/6lsGranJkCbq1SONn7CID2a6uZTl5J7vGv2zww9NxS6XkUzuBkC1oVJEnt+7czEw5Ssoz6m4QlsQzDLuarJxqp2JAYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764158730; c=relaxed/simple;
	bh=C5Frugqy02QmuDJSt8VSlTD0GIPHiDqwoTpkYo0+0dE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ETh3mpVtFhv/GJW3qLBWK3AUvI42n00nFc+ibVFWsGNceRsWjWIXEpxETyfqv4K6p50s0g1O1Bwh7liICsBISNdLRQg2pDGi12MTGpE2pSrHTjxtBDDc5MXgpkfkenATPqz9p0gKlAy0rA9eLRKWxNbpW5LybOtDyL6DiC4bLwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=anZ5xh38; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dKNkGqBT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=anZ5xh38; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dKNkGqBT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D62D15BD47;
	Wed, 26 Nov 2025 12:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764158719; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SeR7soQdA1oM2t1XQoG7bViLW9fmA7IakSOUAL6Qdbk=;
	b=anZ5xh380iqWSid4uuDu2wgw6swj2mRmfjBaD+1A9WjcYV/373TNDiQdzeMXjM2O6AbYW8
	FS1hwguEhaFQCt7mONWAneIKFXh6sZ1i3+eeB2UNgPxziyR5U6SurW3qkD26Wk9sj1pdMi
	n6Ld34eEzHHP/KjhElGh+nQKFnCPJE8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764158719;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SeR7soQdA1oM2t1XQoG7bViLW9fmA7IakSOUAL6Qdbk=;
	b=dKNkGqBTusPVcopEQBjB1Yn+dv8ZtMPRkfuZz+cv3pBvlBO0kdw6ZSiNnmC9h02WowWUCZ
	m6osjGfkORMZsrDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=anZ5xh38;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=dKNkGqBT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764158719; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SeR7soQdA1oM2t1XQoG7bViLW9fmA7IakSOUAL6Qdbk=;
	b=anZ5xh380iqWSid4uuDu2wgw6swj2mRmfjBaD+1A9WjcYV/373TNDiQdzeMXjM2O6AbYW8
	FS1hwguEhaFQCt7mONWAneIKFXh6sZ1i3+eeB2UNgPxziyR5U6SurW3qkD26Wk9sj1pdMi
	n6Ld34eEzHHP/KjhElGh+nQKFnCPJE8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764158719;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SeR7soQdA1oM2t1XQoG7bViLW9fmA7IakSOUAL6Qdbk=;
	b=dKNkGqBTusPVcopEQBjB1Yn+dv8ZtMPRkfuZz+cv3pBvlBO0kdw6ZSiNnmC9h02WowWUCZ
	m6osjGfkORMZsrDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D2F053EA63;
	Wed, 26 Nov 2025 12:05:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qQGWMP7sJmkLMQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 26 Nov 2025 12:05:18 +0000
Message-ID: <9c4924d3-a2af-4343-ac3d-f4851eaa9a01@suse.de>
Date: Wed, 26 Nov 2025 13:05:18 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v6] xsk: avoid data corruption on cq descriptor
 number: manual merge
To: Matthieu Baerts <matttbe@kernel.org>, netdev@vger.kernel.org
Cc: csmate@nop.hu, kerneljasonxing@gmail.com, maciej.fijalkowski@intel.com,
 bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, sdf@fomichev.me,
 hawk@kernel.org, daniel@iogearbox.net, ast@kernel.org,
 john.fastabend@gmail.com, magnus.karlsson@intel.com,
 Stephen Rothwell <sfr@canb.auug.org.au>, Mark Brown <broonie@kernel.org>
References: <20251124171409.3845-1-fmancera@suse.de>
 <eb4eee14-7e24-4d1b-b312-e9ea738fefee@kernel.org>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <eb4eee14-7e24-4d1b-b312-e9ea738fefee@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: D62D15BD47
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[nop.hu,gmail.com,intel.com,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,fomichev.me,iogearbox.net,canb.auug.org.au];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.01



On 11/26/25 12:42 PM, Matthieu Baerts wrote:
> Hello,
> 
> On 24/11/2025 18:14, Fernando Fernandez Mancera wrote:
>> Since commit 30f241fcf52a ("xsk: Fix immature cq descriptor
>> production"), the descriptor number is stored in skb control block and
>> xsk_cq_submit_addr_locked() relies on it to put the umem addrs onto
>> pool's completion queue.
>>
>> skb control block shouldn't be used for this purpose as after transmit
>> xsk doesn't have control over it and other subsystems could use it. This
>> leads to the following kernel panic due to a NULL pointer dereference.
> 
> FYI, and as predicted by Jason, we got a small conflict when merging
> 'net' in 'net-next' in the MPTCP tree due to this patch applied in 'net':
> 
>    0ebc27a4c67d ("xsk: avoid data corruption on cq descriptor number")
> 
> and this one from 'net-next':
> 
>    8da7bea7db69 ("xsk: add indirect call for xsk_destruct_skb")
> 
> ----- Generic Message -----
> The best is to avoid conflicts between 'net' and 'net-next' trees but if
> they cannot be avoided when preparing patches, a note about how to fix
> them is much appreciated.
> 
> The conflict has been resolved on our side [1] and the resolution we
> suggest is attached to this email. Please report any issues linked to
> this conflict resolution as it might be used by others. If you worked on
> the mentioned patches, don't hesitate to ACK this conflict resolution.
> ---------------------------
> 

Noted, thank you!

> Regarding this conflict, the patch from 'net' removed two functions
> above one that has been applied in 'net-next'. I then combined the two
> modifications by removing the two functions and keeping the new
> attributes set to xsk_destruct_skb().
> 
> Rerere cache is available in [2].
> 

Acked-by: Fernando Fernandez Mancera <fmancera@suse.de>

> Cheers,
> Matt
> 
> 1: https://github.com/multipath-tcp/mptcp_net-next/commit/1caa6b15d784
> 2: https://github.com/multipath-tcp/mptcp-upstream-rr-cache/commit/265e1


