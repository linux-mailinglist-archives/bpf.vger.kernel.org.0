Return-Path: <bpf+bounces-54077-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB98A61DA9
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 22:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 326AB883A5B
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 21:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368511ACED3;
	Fri, 14 Mar 2025 21:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="D4VBLGE/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="v89pk9nj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="D4VBLGE/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="v89pk9nj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B44B1C84B4
	for <bpf@vger.kernel.org>; Fri, 14 Mar 2025 21:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741986540; cv=none; b=sBSUK3Yj/qapU0pjF5ykMkZXcFTcjY0BJ/bVaQsvbNugdZ6qXkb3sjFePouyEf5fEyHFna4Xtoxbz9+PBIa8/oxJVJLQ+o91iagpVVXF55wLtYsz7HFEuY0PVcB5S6MffsUE5IzXo/UHlKhmtRcinPH6HaRr8fCoEsaz3aEMcQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741986540; c=relaxed/simple;
	bh=OgvIqheGMKvd86lF4jN3r/+BZQAJNHZQwdlBtvg+iIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bkQNEynOzdL2imOqSVeITMj5Zc5F8YGaC2X7ageqhITsJy/+pKJ0X9QXTqTX9WJPDmKc/c89GPcKEZmG4aKC3v7MPhR7eNiMRcxaBXcoAJ0ZPI20xB2H9VLCPMftcJ5a56D/MPXfuCmKnxrMVp8Pr83PHnT5alHnzXy70YXYljE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=D4VBLGE/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=v89pk9nj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=D4VBLGE/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=v89pk9nj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 25BA11F388;
	Fri, 14 Mar 2025 21:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741986537; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O6wfHsQo0ZYkdzpGTxYRDGaE8/5Y2KZvoIpObBOqUiE=;
	b=D4VBLGE/Mfac5LEywrVWLpTsc6m+LvZXjxxzVlVjGO3TqVKuom8zUqJm0pqh5HuDay79cD
	S9HYe0R2UeiGYWoTzcSKV/vv/TN0rV538MOf+7Fufkav6KBfnCKX2Yw0Aqr6thKNW9rsYV
	m8n7Fzf0BFH4QTv81B3lhVzxQY+2UEk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741986537;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O6wfHsQo0ZYkdzpGTxYRDGaE8/5Y2KZvoIpObBOqUiE=;
	b=v89pk9njhkQCN1FVkO4jHhqcnWSbARAV6M9UIXAFNFwJc798EVSdBJqOA1n+qUT31s+nnd
	lYh8LpiDRIWK2jAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741986537; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O6wfHsQo0ZYkdzpGTxYRDGaE8/5Y2KZvoIpObBOqUiE=;
	b=D4VBLGE/Mfac5LEywrVWLpTsc6m+LvZXjxxzVlVjGO3TqVKuom8zUqJm0pqh5HuDay79cD
	S9HYe0R2UeiGYWoTzcSKV/vv/TN0rV538MOf+7Fufkav6KBfnCKX2Yw0Aqr6thKNW9rsYV
	m8n7Fzf0BFH4QTv81B3lhVzxQY+2UEk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741986537;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O6wfHsQo0ZYkdzpGTxYRDGaE8/5Y2KZvoIpObBOqUiE=;
	b=v89pk9njhkQCN1FVkO4jHhqcnWSbARAV6M9UIXAFNFwJc798EVSdBJqOA1n+qUT31s+nnd
	lYh8LpiDRIWK2jAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED7F4132DD;
	Fri, 14 Mar 2025 21:08:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wTxLOeia1GcRJwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 14 Mar 2025 21:08:56 +0000
Message-ID: <c2a6bd1b-bfe2-4716-96e0-1026d4080de2@suse.cz>
Date: Fri, 14 Mar 2025 22:08:56 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v9 1/6] locking/local_lock: Introduce
 localtry_lock_t
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, bpf
 <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>,
 Hou Tao <houtao1@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, Michal Hocko <mhocko@suse.com>,
 Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jann Horn <jannh@google.com>, Tejun Heo <tj@kernel.org>,
 linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
References: <20250222024427.30294-1-alexei.starovoitov@gmail.com>
 <20250222024427.30294-2-alexei.starovoitov@gmail.com>
 <oswrb2f2mx36l6f624hqjvx4lkjdi26xwfwux2wi2mlzmdmmf2@dpaodu372ldv>
 <20250311162059.BunTzxde@linutronix.de>
 <CAGudoHEaGXwS1OQT_Af5YA=uw_zmUYy_csQ3nqYA_np+SbQ-cQ@mail.gmail.com>
 <b428858a-e985-4acc-95f4-4203afcb500a@suse.cz>
 <CAADnVQKP-oMrCyC2VPCEEXMxEO6+E2qknY8URLtCNySxwu8h0g@mail.gmail.com>
 <496ff0d2-97ac-41f5-a776-455025fb72db@suse.cz>
 <CAADnVQJnZB52jvQDhA8XbhM3nd7O6PCms1jBKXx+F0jn+HA6fg@mail.gmail.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAADnVQJnZB52jvQDhA8XbhM3nd7O6PCms1jBKXx+F0jn+HA6fg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linutronix.de,vger.kernel.org,kernel.org,linux-foundation.org,infradead.org,goodmis.org,huawei.com,cmpxchg.org,linux.dev,suse.com,google.com,kvack.org,fb.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -2.80
X-Spam-Flag: NO

On 3/14/25 22:05, Alexei Starovoitov wrote:
> On Wed, Mar 12, 2025 at 1:29 AM Vlastimil Babka <vbabka@suse.cz> wrote:
> 
> That's correct.
> 
>> An if we e.g. have a pointer to memcg_stock_pcp through which we access the
>> stock_lock an the other (protected) fields and that pointer doesn't change
>> between that, I imagine gcc can reliably determine these can't alias?
> 
> Though my last gcc commit was very long ago here is a simple example
> where compiler can reorder/combine stores:
> struct s {
>    short a, b;
> } *p;
> p->a = 1;
> p->b = 2;
> The compiler can keep them as-is, combine or reorder even with
> -fno-strict-aliasing, because it can determine that a and b don't alias.
> 
> But after re-reading gcc doc on volatiles again it's clear that
> extra barriers are not necessary.
> The main part:
> "The minimum requirement is that at a sequence point all previous
> accesses to volatile objects have stabilized"
> 
> So anything after WRITE_ONCE(lt->acquired, 1); will not be hoisted up
> and that's what we care about here.

OK, is there similar guarantee for the unlock side? No write will be moved
after WRITE_ONCE(lt->acquired, 0); there?

