Return-Path: <bpf+bounces-49678-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1CAA1BA55
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 17:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B707A18906E0
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 16:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD2918E047;
	Fri, 24 Jan 2025 16:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FL+N7i2Q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CbclmFWT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iKhvBg4n";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4HVt/Qyh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9AB156649
	for <bpf@vger.kernel.org>; Fri, 24 Jan 2025 16:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737736095; cv=none; b=RDteCUap3sBikasvyg/EOLlCZY8kSR1XMsS0Hx7ZY7SaeV6chawojtgiTCFXYEKVtzwlkvKpyiUeiraNMQ7WCE5NoI1ZL5dQm4MJo/n5zU7HdwYu1LTZevAznO5trKzEHiEFphRYQsQrxclc3gAi8E+z+mi50Fte0tiEviohV5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737736095; c=relaxed/simple;
	bh=qDc8psAVrWQGzHF82ALRNnCzyKs7MCCZ9yxHTbk0gU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ENQETaWo1HB9U6EFQZCl65QWhWRKNWl+DHCv+EVHJfURH+R8E/ccFcAOhLkDaD35RnNFtIv25C2JqdPZR2OD+LkBeqcVFQXOH4lMXa9alT4/tsjXE3GYq7OCICx7xJPWpo1T1a1XiH/x2Gbrxr2EcQGVL7R1xoDx//K8/h64Zx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FL+N7i2Q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CbclmFWT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iKhvBg4n; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4HVt/Qyh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D473F21181;
	Fri, 24 Jan 2025 16:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737736092; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1qvogUCSmK1UXpmHJsGfb4G7BL990z4+3Y0+irgMM0k=;
	b=FL+N7i2QDlnwrLOqV8rWxCZwrBsOZIr3/M82RfsPvxVTdKixbrbURkwDh9L/RSgccj8S3m
	8+Qw0VRe8Y970s/IbeHlsH1HdST4XnHYNdjnZ4ugCE7P+l/lm1V1PUAQhgRSqdxLLy9LH0
	d1aFRkT6n+kDr+9EFy/magY8Z1dkMP8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737736092;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1qvogUCSmK1UXpmHJsGfb4G7BL990z4+3Y0+irgMM0k=;
	b=CbclmFWTPkeq0iPs3BtxKC79xuEOtp74zLsAYMl7nK0T5CfyLDi/jBEWAU4P8DWkjq8XH9
	VLsvwJSRqxaHqHAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737736091; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1qvogUCSmK1UXpmHJsGfb4G7BL990z4+3Y0+irgMM0k=;
	b=iKhvBg4nMJDw7d01RI6QpH7DzPk9MVBiP0dgsKI5w3KECV/tD/GOxgHuzFH3MbZfBqGodE
	SelZvug2Jlvm4aDUTVRKnVa2v1nPAqeVagFBZM5cubv/76QWiVpczaSK+AwDYlTh4gwyM/
	2C2mBQ+7tWQ6xTh0HYQ84A7F9R8UucA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737736091;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1qvogUCSmK1UXpmHJsGfb4G7BL990z4+3Y0+irgMM0k=;
	b=4HVt/QyhjmsF57taCCsOnN/11eT5p/XSSJXjiBmy81nUUPoEVssGV2SRwkcp8ol8e8D6fP
	YLh/VMLxnFPRXAAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A7BEB13999;
	Fri, 24 Jan 2025 16:28:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3HFyKJu/k2f8EQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 24 Jan 2025 16:28:11 +0000
Message-ID: <2b2e6e04-b91d-4d9d-9cf9-5c690abe6746@suse.cz>
Date: Fri, 24 Jan 2025 17:28:11 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 0/6] bpf, mm: Introduce try_alloc_pages()
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, bpf <bpf@vger.kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Sebastian Sewior <bigeasy@linutronix.de>,
 Steven Rostedt <rostedt@goodmis.org>, Hou Tao <houtao1@huawei.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 Michal Hocko <mhocko@suse.com>, Thomas Gleixner <tglx@linutronix.de>,
 Jann Horn <jannh@google.com>, Tejun Heo <tj@kernel.org>,
 linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>,
 Marco Elver <elver@google.com>, Andrey Konovalov <andreyknvl@gmail.com>,
 Oscar Salvador <osalvador@suse.de>
References: <20250124035655.78899-1-alexei.starovoitov@gmail.com>
 <Z5OgvePdlqRoKMyx@casper.infradead.org>
 <e5c1eed1-3ea2-4452-a871-3308c90e932b@suse.cz>
 <CAADnVQJhU3EYp3fWYcTFtZobJUAaWRQmjjBSw5te9OpUaM8TNw@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <CAADnVQJhU3EYp3fWYcTFtZobJUAaWRQmjjBSw5te9OpUaM8TNw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,vger.kernel.org,kernel.org,gmail.com,linux-foundation.org,linutronix.de,goodmis.org,huawei.com,cmpxchg.org,linux.dev,suse.com,google.com,kvack.org,fb.com,suse.de];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On 1/24/25 17:19, Alexei Starovoitov wrote:
> On Fri, Jan 24, 2025 at 6:19 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> On 1/24/25 15:16, Matthew Wilcox wrote:
>> > On Thu, Jan 23, 2025 at 07:56:49PM -0800, Alexei Starovoitov wrote:
>> >> - Considered using __GFP_COMP in try_alloc_pages to simplify
>> >>   free_pages_nolock a bit, but then decided to make it work
>> >>   for all types of pages, since free_pages_nolock() is used by
>> >>   stackdepot and currently it's using non-compound order 2.
>> >>   I felt it's best to leave it as-is and make free_pages_nolock()
>> >>   support all pages.
>> >
>> > We're trying to eliminate non-use of __GFP_COMP.  Because people don't
>> > use __GFP_COMP, there's a security check that we can't turn on.  Would
>> > you reconsider this change you made?
>>
>> This means changing stackdepot to use __GFP_COMP. Which would be a good
>> thing on its own. But if you consider if off-topic to your series, I can
>> look at it.
> 
> Ohh. I wasn't aware of that.
> I can certainly add __GFP_COMP to try_alloc_pages() and

Yeah IIRC I suggested that previously.

> will check stackdepot too.

Great, thanks.

> I spotted this line:
> VM_BUG_ON_PAGE(compound && compound_order(page) != order, page);
> that line alone was a good enough reason to use __GFP_COMP,
> but since it's debug only I could only guess where the future lies.
> 
> Should it be something like:
> 
> if (WARN_ON(compound && compound_order(page) != order))
>  order = compound_order(page);
> 
> since proceeding with the wrong order is certain to crash.
> ?

That's the common question, should we be paranoid and add overhead to fast
paths in production. Here we do only for DEBUG_VM, which is meant for easier
debugging during development of new code.

I think it's not worth adding this overhead in normal configs, as the
(increasing) majority of order > 0 parameters should come here from
compound_order() anyway (i.e. put_folio()) As said we're trying to eliminate
the other cases so we don't need to cater for them more.

