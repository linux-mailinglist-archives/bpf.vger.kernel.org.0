Return-Path: <bpf+bounces-41119-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EF6992C6A
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 14:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E92671F2355F
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 12:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48EF1D2B0E;
	Mon,  7 Oct 2024 12:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VvvE12xu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XFPwfYxx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VvvE12xu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XFPwfYxx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CC61BB6B8;
	Mon,  7 Oct 2024 12:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728305834; cv=none; b=bD49VRASw0h1DazQuQPD22LUaYr8KQLGce2TiNvNLZW7DNlQBww4mx892fewfVR07Wpqz503Jkb1hqcun9Eo/jrzenKgleBxIA7i8akSZ7cqhjtkwV83xzlg/SDWciJsqyY0mpZq4fXVN6/gfh1UEqnxQJSFZha2rtmKZcH3HSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728305834; c=relaxed/simple;
	bh=VaQZWkMjmfFxgRSm0Ys24qwf6QABhKKJgJtPaW0Hm9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sRSIxDcDchQSPds9KOdXqn6r21Kd+0AuljowdxtwXrcwrXiUqCXrMp1MJaMNre5Xwjre6l4QXfty3/1DLCwn17GSjTVp0XYueMSAILydoGxSX04noRbrAw9Snk+y+IEy/UdnYUV+i225yysV1j/X0AfF5DdsceoWy9C7AGqhziY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VvvE12xu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XFPwfYxx; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VvvE12xu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XFPwfYxx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BDBEC1FB49;
	Mon,  7 Oct 2024 12:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728305830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DCnkUNp48eqK7B4xRBkDW7Ln7yGp8HpKJQU9fGxdJ6M=;
	b=VvvE12xuoQF29aUeR/WqkgFw7joefpiN+oVKlr3KLVPmZ5F1UPn+030vk8h5DgEpCH8qDQ
	4RZYZpaMb2z13fcvJJv+sxjtF20HxzXK80f4OSo6yrSYY0VJEdiO2Uxu3a2Fy0bpT/HFOB
	EIiT1LDC/UTNsX4HVdMjupqjmivOUVs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728305830;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DCnkUNp48eqK7B4xRBkDW7Ln7yGp8HpKJQU9fGxdJ6M=;
	b=XFPwfYxxe1FsIcdwEyO8koKE0Rsq030fD8y4jvtTO3ehKoYqCdCXJS4QPVaihU3EAK+d/p
	IXvNaCwcnqQazMDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728305830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DCnkUNp48eqK7B4xRBkDW7Ln7yGp8HpKJQU9fGxdJ6M=;
	b=VvvE12xuoQF29aUeR/WqkgFw7joefpiN+oVKlr3KLVPmZ5F1UPn+030vk8h5DgEpCH8qDQ
	4RZYZpaMb2z13fcvJJv+sxjtF20HxzXK80f4OSo6yrSYY0VJEdiO2Uxu3a2Fy0bpT/HFOB
	EIiT1LDC/UTNsX4HVdMjupqjmivOUVs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728305830;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DCnkUNp48eqK7B4xRBkDW7Ln7yGp8HpKJQU9fGxdJ6M=;
	b=XFPwfYxxe1FsIcdwEyO8koKE0Rsq030fD8y4jvtTO3ehKoYqCdCXJS4QPVaihU3EAK+d/p
	IXvNaCwcnqQazMDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 85669132BD;
	Mon,  7 Oct 2024 12:57:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fTc4IKbaA2c/WwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 07 Oct 2024 12:57:10 +0000
Message-ID: <37ca3072-4a0b-470f-b5b2-9828a2b708e5@suse.cz>
Date: Mon, 7 Oct 2024 14:57:08 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 bpf-next 2/3] mm/bpf: Add bpf_get_kmem_cache() kfunc
To: Roman Gushchin <roman.gushchin@linux.dev>, Song Liu <song@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 bpf@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Kees Cook <kees@kernel.org>
References: <20241002180956.1781008-1-namhyung@kernel.org>
 <20241002180956.1781008-3-namhyung@kernel.org>
 <CAPhsuW7Bh-ZXfM2aYB=Yj8WaJHFc==AKmv6LDRgBq-TfdQ3s8A@mail.gmail.com>
 <ZwBdS86yBtOWy3iD@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
Content-Language: en-US
In-Reply-To: <ZwBdS86yBtOWy3iD@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,vger.kernel.org,linux-foundation.org,linux.com,lge.com,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[25];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On 10/4/24 11:25 PM, Roman Gushchin wrote:
> On Fri, Oct 04, 2024 at 01:10:58PM -0700, Song Liu wrote:
>> On Wed, Oct 2, 2024 at 11:10 AM Namhyung Kim <namhyung@kernel.org> wrote:
>>>
>>> The bpf_get_kmem_cache() is to get a slab cache information from a
>>> virtual address like virt_to_cache().  If the address is a pointer
>>> to a slab object, it'd return a valid kmem_cache pointer, otherwise
>>> NULL is returned.
>>>
>>> It doesn't grab a reference count of the kmem_cache so the caller is
>>> responsible to manage the access.  The intended use case for now is to
>>> symbolize locks in slab objects from the lock contention tracepoints.
>>>
>>> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
>>> Acked-by: Roman Gushchin <roman.gushchin@linux.dev> (mm/*)
>>> Acked-by: Vlastimil Babka <vbabka@suse.cz> #mm/slab
>>> Signed-off-by: Namhyung Kim <namhyung@kernel.org>


So IIRC from our discussions with Namhyung and Arnaldo at LSF/MM I
thought the perf use case was:

- at the beginning it iterates the kmem caches and stores anything of
possible interest in bpf maps or somewhere - hence we have the iterator
- during profiling, from object it gets to a cache, but doesn't need to
access the cache - just store the kmem_cache address in the perf record
- after profiling itself, use the information in the maps from the first
step together with cache pointers from the second step to calculate
whatever is necessary

So at no point it should be necessary to take refcount to a kmem_cache?

But maybe "bpf_get_kmem_cache()" is implemented here as too generic
given the above use case and it should be implemented in a way that the
pointer it returns cannot be used to access anything (which could be
unsafe), but only as a bpf map key - so it should return e.g. an
unsigned long instead?

>>> ---
>>>  kernel/bpf/helpers.c |  1 +
>>>  mm/slab_common.c     | 19 +++++++++++++++++++
>>>  2 files changed, 20 insertions(+)
>>>
>>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>>> index 4053f279ed4cc7ab..3709fb14288105c6 100644
>>> --- a/kernel/bpf/helpers.c
>>> +++ b/kernel/bpf/helpers.c
>>> @@ -3090,6 +3090,7 @@ BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_NEW)
>>>  BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)
>>>  BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
>>>  BTF_ID_FLAGS(func, bpf_copy_from_user_str, KF_SLEEPABLE)
>>> +BTF_ID_FLAGS(func, bpf_get_kmem_cache, KF_RET_NULL)
>>>  BTF_KFUNCS_END(common_btf_ids)
>>>
>>>  static const struct btf_kfunc_id_set common_kfunc_set = {
>>> diff --git a/mm/slab_common.c b/mm/slab_common.c
>>> index 7443244656150325..5484e1cd812f698e 100644
>>> --- a/mm/slab_common.c
>>> +++ b/mm/slab_common.c
>>> @@ -1322,6 +1322,25 @@ size_t ksize(const void *objp)
>>>  }
>>>  EXPORT_SYMBOL(ksize);
>>>
>>> +#ifdef CONFIG_BPF_SYSCALL
>>> +#include <linux/btf.h>
>>> +
>>> +__bpf_kfunc_start_defs();
>>> +
>>> +__bpf_kfunc struct kmem_cache *bpf_get_kmem_cache(u64 addr)
>>> +{
>>> +       struct slab *slab;
>>> +
>>> +       if (!virt_addr_valid(addr))
>>> +               return NULL;
>>> +
>>> +       slab = virt_to_slab((void *)(long)addr);
>>> +       return slab ? slab->slab_cache : NULL;
>>> +}
>>
>> Do we need to hold a refcount to the slab_cache? Given
>> we make this kfunc available everywhere, including
>> sleepable contexts, I think it is necessary.
> 
> It's a really good question.
> 
> If the callee somehow owns the slab object, as in the example
> provided in the series (current task), it's not necessarily.
> 
> If a user can pass a random address, you're right, we need to
> grab the slab_cache's refcnt. But then we also can't guarantee
> that the object still belongs to the same slab_cache, the
> function becomes racy by the definition.

