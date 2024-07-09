Return-Path: <bpf+bounces-34251-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E24FC92BDF1
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 17:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A2E31C22802
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 15:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE1018EFD7;
	Tue,  9 Jul 2024 15:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lRZaociA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4xj2GpB7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ht9Pe9CQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4arC1bzl"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C55364AB;
	Tue,  9 Jul 2024 15:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720538049; cv=none; b=Zr0mt0drzMPxi25tfuRtM8TpBpSlYCAI8msYmlRzA+4KuhSkP806n9ezB/FX+PCPpvj1n7jHtD16iJEydmFJVz3KCloaZ6js81/WCgGcyNbRyi3Z72ng1FPJKPDAtMIyOh6njVp7gfAa/hYJSSOJHX8z1bDDpnSB5Xqee5LwSg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720538049; c=relaxed/simple;
	bh=JYz3AaDPCRTJHCNuh89fGaqlz5sXiB4BKMrQ3NS/lJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=phE/zDoRdnETKQWA4B15uHJaZCKA7SjBr7wfQfUpR7kn8TL2Gqq6fWtX/v+Aj/UNMUhVekeKgMen1VPT5ohiEbNscYqSQFlmm6etpA7QrhK940WmsevGX709QO5+Dgn+mL/EysvgPOFIBaebFR7JvEQlw0jlc10wEN008UwbRYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lRZaociA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4xj2GpB7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ht9Pe9CQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4arC1bzl; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7E381219A3;
	Tue,  9 Jul 2024 15:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1720538046; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WPuLd+YMay7WlvMNyPzhdyz/MBhPuJyZzzlVCWYmlgc=;
	b=lRZaociADIsnQ/tEyTrE5VGo8KIGIqmmk2iZJsItX0gAwGERakB1mopkdk/2VHa14oRgYD
	rrInSyjw139BHytOPs35QL7+yccryaVymjb83vxYXZ/oK4KEctLZQxSW6smxQ+94R1h1qy
	JGqUSifJY8lupIRFuuCGBaUrgGJFGb4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1720538046;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WPuLd+YMay7WlvMNyPzhdyz/MBhPuJyZzzlVCWYmlgc=;
	b=4xj2GpB7AUKs3XQeHN+Dn+0fa3LiFtYNafvBslbXxN9oiU1rvkjeCGyqoeXl7qMcsC5Aig
	jpnqup7+s/1eihDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1720538043; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WPuLd+YMay7WlvMNyPzhdyz/MBhPuJyZzzlVCWYmlgc=;
	b=ht9Pe9CQ/UKouD2ZKDNkNKd0we+091pU05yjOKMTapp3mjPckWdpF3mxulVoLRekFzFHvH
	uMLhojmxmX596uLPEMxJruzlzYLlsFwC4uDqqvCZy0ZxVU4A1q0/Z7LqAJuckrZwGtL69Y
	lid1G0lUwcgbE45lYIIT35TGhc3mMok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1720538043;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WPuLd+YMay7WlvMNyPzhdyz/MBhPuJyZzzlVCWYmlgc=;
	b=4arC1bzl1UhNhMYLr6DeBFoijvbdN2LnBV9fPYz8gEvvm/oYmdrEwDFFgDH7BE+vxMeUO2
	VHlpt1sVcmelhSCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4F04C1369A;
	Tue,  9 Jul 2024 15:14:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oy77ErtTjWZsLgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 09 Jul 2024 15:14:03 +0000
Message-ID: <2c9089c9-4314-4e4a-a7e2-2dd09716962f@suse.cz>
Date: Tue, 9 Jul 2024 17:14:02 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] bpf: fix order of args in call to bpf_map_kvcalloc
Content-Language: en-US
To: Linux regressions mailing list <regressions@lists.linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Christian Kujau <lists@nerdbynature.de>,
 =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@intel.com>,
 Lorenzo Stoakes <lstoakes@gmail.com>, Suren Baghdasaryan
 <surenb@google.com>, Kent Overstreet <kent.overstreet@linux.dev>
References: <20240612-master-v1-1-a95f24339dab@gmail.com>
 <CAADnVQJLgo4zF5SVf-P5U_nOaiFW--mCe-zY6_Dec98z_QE24A@mail.gmail.com>
 <270804d4-b751-4ac9-99b2-80e364288c37@leemhuis.info>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <270804d4-b751-4ac9-99b2-80e364288c37@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.79
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.79 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[lists.linux.dev,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,kernel.org,iogearbox.net,gmail.com,google.com,vger.kernel.org,nerdbynature.de,intel.com];
	TO_DN_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

On 7/8/24 10:20 AM, Linux regression tracking (Thorsten Leemhuis) wrote:
> [CCing the regressions list and people mentioned below]
> 
> On 12.06.24 16:53, Alexei Starovoitov wrote:
>> On Wed, Jun 12, 2024 at 2:51 AM Mohammad Shehar Yaar Tausif
>> <sheharyaar48@gmail.com> wrote:
>>>
>>> The original function call passed size of smap->bucket before the number of
>>> buckets which raises the error 'calloc-transposed-args' on compilation.
>>>
>>> Fixes: 62827d612ae5 ("bpf: Remove __bpf_local_storage_map_alloc")
>>> Reviewed-by: Andrii Nakryiko <andrii@kernel.org>
>>> Signed-off-by: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
>>> ---
>>> - already merged in linux-next
>>> - [1] suggested sending as a fix for 6.10 cycle
>> 
>> No. It's not a fix.
> 
> If you have a minute, could you please explain why that is? From what I
> can see a quite a few people run into build problems with 6.10-rc
> recently that are fixed by the patch:
> 
> * Péter Ujfalusi
> https://lore.kernel.org/bpf/363ad8d1-a2d2-4fca-b66a-3d838eb5def9@intel.com/
> 
> * Christian Kujau
> https://lore.kernel.org/bpf/48360912-b239-51f2-8f25-07a46516dc76@nerdbynature.de/
> https://lore.kernel.org/lkml/d0dd2457-ab58-1b08-caa4-93eaa2de221e@nerdbynature.de/
> 
> * Lorenzo Stoakes
> https://fosstodon.org/@ljs@social.kernel.org/112734050799590482
> 
> At the same time I see that the culprit mentioned above is from 6.4-rc1,

IIUC the order was wrong even before, but see below.

> so I guess it there must be some other reason why a few people seem to
> tun into this now. Did some other change expose this problem? Or are
> updated compilers causing this?

I think it's because of 2c321f3f70bc ("mm: change inlined allocation helpers
to account at the call site"), which was added in 6.10-rc1 and thus makes
this technically a 6.10 regression after all. So what triggers the bug is
AFAICS the following together:

- gcc-14 (didn't see it with gcc-13)
- commit 2c321f3f70bc that makes bpf_map_kvcalloc a macro that does
kvcalloc() directly instead of static inline function wrapping it for
!CONFIG_MEMCG
- CONFIG_MEMCG=n in .config

The fix is so trivial, it's better to include it in 6.10 even this late.

> Ciao, Thorsten
> 
>>> [1] https://lore.kernel.org/all/363ad8d1-a2d2-4fca-b66a-3d838eb5def9@intel.com/
>>> ---
>>>  kernel/bpf/bpf_local_storage.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
>>> index 976cb258a0ed..c938dea5ddbf 100644
>>> --- a/kernel/bpf/bpf_local_storage.c
>>> +++ b/kernel/bpf/bpf_local_storage.c
>>> @@ -782,8 +782,8 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
>>>         nbuckets = max_t(u32, 2, nbuckets);
>>>         smap->bucket_log = ilog2(nbuckets);
>>>
>>> -       smap->buckets = bpf_map_kvcalloc(&smap->map, sizeof(*smap->buckets),
>>> -                                        nbuckets, GFP_USER | __GFP_NOWARN);
>>> +       smap->buckets = bpf_map_kvcalloc(&smap->map, nbuckets,
>>> +                                        sizeof(*smap->buckets), GFP_USER | __GFP_NOWARN);
>>>         if (!smap->buckets) {
>>>                 err = -ENOMEM;
>>>                 goto free_smap;
>>>
>>> ---
>>> base-commit: 2ef5971ff345d3c000873725db555085e0131961
>>> change-id: 20240612-master-fe9e63ab5c95
>>>
>>> Best regards,
>>> --
>>> Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
>>>


