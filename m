Return-Path: <bpf+bounces-31165-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 728698D7837
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 23:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 200C4B21263
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 21:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6E377115;
	Sun,  2 Jun 2024 21:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xAoIyPs2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aSXhDgJ9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xAoIyPs2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aSXhDgJ9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCC08493;
	Sun,  2 Jun 2024 21:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717362495; cv=none; b=kP6Whzf+TBZGLid+N7G3bLPBlM2MUdEJiDq6ljI4Ybv9SbFisiiNHRHz5KeFBc8lXAto5IVVCY5I89jdnNBlASpfwYzi1tMoLFbcV8Ny8jAzLGrY9Gk/Y3AMBOt3IqvMZM3tv+hdMTDL4QDyANs5aEmsW3zdrC90Wlu7hdRxNug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717362495; c=relaxed/simple;
	bh=QASph2uY1fq4HnU0wZtjG1pIF1jvY+VFOelBy4FoHog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZaU6w+j8dZjZMm4tEq5w/b1pyHkIs2PfN5U3AntJQTm2u8xPue2YQIbQD6nRjNZICuBr4XojqrIJN7WRC0YByTpMhqRJhLwmGan19eMlzDkaLx4ykyKhKo1vwd1RnXKgYsV1Fov4VvJIHynFoIqZMH80diRIsKcyPBTVpb0KvW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xAoIyPs2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aSXhDgJ9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xAoIyPs2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aSXhDgJ9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2501022134;
	Sun,  2 Jun 2024 21:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717362491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tQZEL/vbM6wKuOYcR4luQQldeA8eAyr6eXnPVohUWho=;
	b=xAoIyPs2nTlPuXCvTy9BLDzkeK3XIxu4KrdpEnjl8vEwe1c5tZwUZwxCH9m1GJS3l8kOEo
	q6cU7KRkvTGXBdt/ZklFK4Y/pIKfOXxsRxWGpFj5LYVdvOUaJpsqyDz6m+mVa3Dyc6pJUO
	NMEI8sToe2CKOO3/KmRsV2aQCeEaKYc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717362491;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tQZEL/vbM6wKuOYcR4luQQldeA8eAyr6eXnPVohUWho=;
	b=aSXhDgJ9nCrdqhhFTzYHoMz8jOuP0qkmQxZazYXkE/ROGrigeg61nXgB+kMyfXujAaFchM
	piBSnd/cL+qA+FAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=xAoIyPs2;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=aSXhDgJ9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717362491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tQZEL/vbM6wKuOYcR4luQQldeA8eAyr6eXnPVohUWho=;
	b=xAoIyPs2nTlPuXCvTy9BLDzkeK3XIxu4KrdpEnjl8vEwe1c5tZwUZwxCH9m1GJS3l8kOEo
	q6cU7KRkvTGXBdt/ZklFK4Y/pIKfOXxsRxWGpFj5LYVdvOUaJpsqyDz6m+mVa3Dyc6pJUO
	NMEI8sToe2CKOO3/KmRsV2aQCeEaKYc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717362491;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tQZEL/vbM6wKuOYcR4luQQldeA8eAyr6eXnPVohUWho=;
	b=aSXhDgJ9nCrdqhhFTzYHoMz8jOuP0qkmQxZazYXkE/ROGrigeg61nXgB+kMyfXujAaFchM
	piBSnd/cL+qA+FAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ECED713A97;
	Sun,  2 Jun 2024 21:08:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZW4ROTrfXGbvOQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Sun, 02 Jun 2024 21:08:10 +0000
Message-ID: <f21161e9-1da6-4015-907d-e419ec5056da@suse.cz>
Date: Sun, 2 Jun 2024 23:08:10 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/4] static key support for error injection functions
To: David Rientjes <rientjes@google.com>
Cc: Akinobu Mita <akinobu.mita@gmail.com>, Christoph Lameter <cl@linux.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
 "David S. Miller" <davem@davemloft.net>,
 Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Mark Rutland <mark.rutland@arm.com>,
 Jiri Olsa <jolsa@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20240531-fault-injection-statickeys-v1-0-a513fd0a9614@suse.cz>
 <71ebaa45-dbd0-b39d-4b33-88da3f497297@google.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <71ebaa45-dbd0-b39d-4b33-88da3f497297@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,linux.com,kernel.org,iogearbox.net,linux.ibm.com,intel.com,davemloft.net,goodmis.org,arm.com,linux.dev,vger.kernel.org,kvack.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 2501022134
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.00

On 6/2/24 10:47 PM, David Rientjes wrote:
> On Fri, 31 May 2024, Vlastimil Babka wrote:
> 
>> Patches 3 and 4 implement the static keys for the two mm fault injection
>> sites in slab and page allocators. For a quick demonstration I've run a
>> VM and the simple test from [1] that stresses the slab allocator and got
>> this time before the series:
>> 
>> real    0m8.349s
>> user    0m0.694s
>> sys     0m7.648s
>> 
>> with perf showing
>> 
>>    0.61%  nonexistent  [kernel.kallsyms]  [k] should_failslab.constprop.0
>>    0.00%  nonexistent  [kernel.kallsyms]  [k] should_fail_alloc_page                                                                                                                                                                                        ▒
>> 
>> And after the series
>> 
>> real    0m7.924s
>> user    0m0.727s
>> sys     0m7.191s
>> 
>> and the functions gone from perf report.
>> 
> 
> Impressive results that will no doubt be a win for kernels that enable 
> these options.

Oh, I should have been more clear about it. This was done with both of these
options disabled. It's measuring just removing the overhead of calling the
empty noninline function, otherwise the difference would be larger. CPU
mitigations (defaults) were enabled though, which affects the cost of
function calls (this was in KVM guest on Ryzen 2700).

> Both CONFIG_FAILSLAB and CONFIG_FAIL_PAGE_ALLOC go out of their way to 
> have no overhead, both in performance and kernel text overhead, when the 
> .config options are disabled.

Except the unavoidable function call overhead since commits 4f6923fbb352 and
af3b854492f3.

> Do we have any insight into the distros or users that enable either of 
> these options and are expecting optimal performance?  I would have assumed 
> that while CONFIG_FAULT_INJECTION may be enabled that any users who would 
> care deeply about this would have disabled both of these debug options.

Eliminating the empty function call overhead, which is currently not
possible to configure out in any way, was my primary goal. For our distro we
disable the options and they are enabled only in a debug kernel option. So
the additional benefit of the static key is we could enable them with no
cost, and have them available for when needed, without the need to change
kernel. This is great for debugging functionality in general
(debug_pagealloc, page_owner), maybe this would be less likely to be useful,
but one never knows.

>> There might be other such fault injection callsites in hotpaths of other
>> subsystems but I didn't search for them at this point.
>> 
>> [1] https://lore.kernel.org/all/6d5bb852-8703-4abf-a52b-90816bccbd7f@suse.cz/
>> [2] https://lore.kernel.org/all/3j5d3p22ssv7xoaghzraa7crcfih3h2qqjlhmjppbp6f42pg2t@kg7qoicog5ye/
>> 
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>> ---
>> Vlastimil Babka (4):
>>       fault-inject: add support for static keys around fault injection sites
>>       error-injection: support static keys around injectable functions
>>       mm, slab: add static key for should_failslab()
>>       mm, page_alloc: add static key for should_fail_alloc_page()
>> 
>>  include/asm-generic/error-injection.h | 13 ++++++++++-
>>  include/asm-generic/vmlinux.lds.h     |  2 +-
>>  include/linux/error-injection.h       |  9 +++++---
>>  include/linux/fault-inject.h          |  7 +++++-
>>  kernel/fail_function.c                | 22 +++++++++++++++---
>>  lib/error-inject.c                    |  6 ++++-
>>  lib/fault-inject.c                    | 43 ++++++++++++++++++++++++++++++++++-
>>  mm/fail_page_alloc.c                  |  3 ++-
>>  mm/failslab.c                         |  2 +-
>>  mm/internal.h                         |  2 ++
>>  mm/page_alloc.c                       | 11 ++++++---
>>  mm/slab.h                             |  3 +++
>>  mm/slub.c                             | 10 +++++---
>>  13 files changed, 114 insertions(+), 19 deletions(-)
>> ---
>> base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
>> change-id: 20240530-fault-injection-statickeys-66b7222e91b7
>> 
>> Best regards,
>> -- 
>> Vlastimil Babka <vbabka@suse.cz>
>> 
>> 


