Return-Path: <bpf+bounces-34627-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C3A92F614
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 09:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2CC21F23083
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 07:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7284E13D8B4;
	Fri, 12 Jul 2024 07:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="H/FZ2Ife";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WhHCvUeW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="H/FZ2Ife";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WhHCvUeW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A6D12B71;
	Fri, 12 Jul 2024 07:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720768756; cv=none; b=bkVqOW2PmV/bHXISWPXLbwf+5ap9pmn3rRo8dIzhB764Bo4u0Mk3u3S6eoBIxLT40Id+GkmzVsIPbefwC2SBietXfk5mvYOm1xRgS9eM1UsbB3+KbObuZUTHjD3l17WQrQVw8rhjNTBrdwWG0WYjPrFaQAYa++KkKPePBAdqtGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720768756; c=relaxed/simple;
	bh=26lLeiM6GiYZ5haWRsGy8i6tfemQol9dvlNiDqEH/b4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jMmIwTe7WhPr6DOC6E6oqElSn9NmZOJMemOmPYqF3Ctd09j0sMSUHDs/vYPeCHoFahOPRDDUTAPBEbELTz14m2hK7leca855lu0LM70q0ckDwK2FM3akMpUwId8GkYVKnap8aFgN8xNeqWewq/Hxc9L1ZkS+NqfWOHw/HnuxD8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=H/FZ2Ife; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WhHCvUeW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=H/FZ2Ife; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WhHCvUeW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A361021A6B;
	Fri, 12 Jul 2024 07:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1720768751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RuHZaNfs0B/pJ/ZeNafqjRmHAxZYpg5VtQWcT7YZfSE=;
	b=H/FZ2IfesevQNbOz3q4eFDvr51gusQDpmSPkhCq+JxPwpCySRcmJ0eq8Nt2vTPp8QZISqo
	G6w1zflEpWWh5hHZ8maf9IZSLUP4+IVl5JWcbsPOEOam+B9t5MuWaOI1MWs3aNUzxAiIOJ
	r+Ok6QJ8FRW5ykUyLxCU8RaJqeFbouA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1720768751;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RuHZaNfs0B/pJ/ZeNafqjRmHAxZYpg5VtQWcT7YZfSE=;
	b=WhHCvUeWOIfX4iTh4R7BWiJ0xcw+76ihnAQzH6/NPz3ZWJtfIdrhQ39VIzbI//f5DR8S2r
	UbaG83r9934FejBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1720768751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RuHZaNfs0B/pJ/ZeNafqjRmHAxZYpg5VtQWcT7YZfSE=;
	b=H/FZ2IfesevQNbOz3q4eFDvr51gusQDpmSPkhCq+JxPwpCySRcmJ0eq8Nt2vTPp8QZISqo
	G6w1zflEpWWh5hHZ8maf9IZSLUP4+IVl5JWcbsPOEOam+B9t5MuWaOI1MWs3aNUzxAiIOJ
	r+Ok6QJ8FRW5ykUyLxCU8RaJqeFbouA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1720768751;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RuHZaNfs0B/pJ/ZeNafqjRmHAxZYpg5VtQWcT7YZfSE=;
	b=WhHCvUeWOIfX4iTh4R7BWiJ0xcw+76ihnAQzH6/NPz3ZWJtfIdrhQ39VIzbI//f5DR8S2r
	UbaG83r9934FejBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 72E1513686;
	Fri, 12 Jul 2024 07:19:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8oyjG+/YkGZHbwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 12 Jul 2024 07:19:11 +0000
Message-ID: <bc10f1fb-22e5-462b-b27c-f1e463d95a21@suse.cz>
Date: Fri, 12 Jul 2024 09:19:11 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] revert unconditional slab and page allocator fault
 injection calls
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, Akinobu Mita <akinobu.mita@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-mm@kvack.org
References: <20240711-b4-fault-injection-reverts-v1-0-9e2651945d68@suse.cz>
 <20240711123637.508e81d2b25ac8e0c9b726c0@linux-foundation.org>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20240711123637.508e81d2b25ac8e0c9b726c0@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: 1.21
X-Spamd-Result: default: False [1.21 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,iogearbox.net,linux.dev,fomichev.me,google.com,linux.com,vger.kernel.org,kvack.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: *

On 7/11/24 9:36 PM, Andrew Morton wrote:
> On Thu, 11 Jul 2024 18:35:29 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:
> 
>> These two patches largely revert commits that added function call
>> overhead into slab and page allocation hotpaths and that cannot be
>> currently disabled even though related CONFIG_ options do exist.
> 
> Five years ago.  I assume the overall overhead is small?

Well, what made me look into this in the first place was seeing
should_failslab() in perf profiles at 1-2% even though it was an empty
function that just immediately returned.
In [1] I posted some measurements that was not even a microbenchmark:

    To demonstrate the reduced overhead of calling an empty
    should_failslab() function, a kernel build with
    CONFIG_FUNCTION_ERROR_INJECTION enabled but CONFIG_FAILSLAB disabled,
    and CPU mitigations enabled, was used in a qemu-kvm (virtme-ng) on AMD
    Ryzen 7 2700 machine, and execution of a program trying to open() a
    non-existent file was measured 3 times:

        for (int i = 0; i < 10000000; i++) {
            open("non_existent", O_RDONLY);
        }

    After this patch, the measured real time was 4.3% smaller. Using perf
    profiling it was verified that should_failslab was gone from the
    profile.

Later I found that this CPU mitigations were really important here as
function calls are more expensive. With them disabled that benchmark was in
a noise, so I wasn't sure about claiming that number in the patch itself.
But I assume a microbenchmark would still demonstrate some overhead. Yet
ultimately I think the overhead is just plain unnecessary to pay when error
injection is not being performed, and also CPU mitigations enabled are
usually the default, so it's best get rid of it.

[1]
https://lore.kernel.org/all/20240620-fault-injection-statickeys-v2-0-e23947d3d84b@suse.cz/#t

