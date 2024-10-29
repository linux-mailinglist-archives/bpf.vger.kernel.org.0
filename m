Return-Path: <bpf+bounces-43396-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F619B4FBB
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 17:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 731B5280F14
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 16:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE36919995A;
	Tue, 29 Oct 2024 16:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kDAMLL5U";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zOyf1ZQg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kDAMLL5U";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zOyf1ZQg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C09F7DA81;
	Tue, 29 Oct 2024 16:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730220526; cv=none; b=Cs/DsF8SVRYeLAbVDfjT7T0iMjfpmMhrPg0hwhjTy4RwW84gKa3HIRL7R4IIlAm+yCnjwF8Zfv/iK+sBumAghohnb1uSdKsFFYHheCT2mLtjNljjvmj6TWklCfOBpRmb1EN0BF5ABHr3jhToot61a4+NK5gBmlCbqFlQYA8itCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730220526; c=relaxed/simple;
	bh=abCjQ9sTcXYoApKfPsysi9jmUHdl89cU/VkNgGlaBpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FeNP28sw8AIJO3kw0Rb1DjTiv4DCetnHd2+Tzbwta+YK0v8yFLoSaXGk21d/KceRPJAq8dB+vBvd1bKS684BGE0xCGHwhK4iHrhJ9oLZvz0lp3SnTH1l2m91vRXu991bNz+0ow+I6fP2NIIBsF9BaIwzPRT762nQW9O9xqNRg/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kDAMLL5U; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zOyf1ZQg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kDAMLL5U; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zOyf1ZQg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9C89E1FDF3;
	Tue, 29 Oct 2024 16:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730220521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wMtih/JfshDEE/Jc8JTNUYdJycairy8oF4UI8O3/Rn4=;
	b=kDAMLL5UFtDxJauIcaQSNGIEtFL+x/tELEP8I2kSeuKPrWArjzRP9VODhA8L3Ar1O6Dquk
	SAHftLds5ZqXi7K+4W1zvh1UAjEKzKnpMGf//qrXKMiN4gEQh+iXKoSvGRwWMdAoZQviIL
	WTmFj1HJeMOUOCxz5TRCuvA9db18rYI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730220521;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wMtih/JfshDEE/Jc8JTNUYdJycairy8oF4UI8O3/Rn4=;
	b=zOyf1ZQgJBH2Wd9QN5YBb8aHU6emyEiYo+Swy61v+TbC6PHk17i4WPpadWh756aTNbTwsH
	8lmDRtXjBn0FMaDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=kDAMLL5U;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=zOyf1ZQg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730220521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wMtih/JfshDEE/Jc8JTNUYdJycairy8oF4UI8O3/Rn4=;
	b=kDAMLL5UFtDxJauIcaQSNGIEtFL+x/tELEP8I2kSeuKPrWArjzRP9VODhA8L3Ar1O6Dquk
	SAHftLds5ZqXi7K+4W1zvh1UAjEKzKnpMGf//qrXKMiN4gEQh+iXKoSvGRwWMdAoZQviIL
	WTmFj1HJeMOUOCxz5TRCuvA9db18rYI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730220521;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wMtih/JfshDEE/Jc8JTNUYdJycairy8oF4UI8O3/Rn4=;
	b=zOyf1ZQgJBH2Wd9QN5YBb8aHU6emyEiYo+Swy61v+TbC6PHk17i4WPpadWh756aTNbTwsH
	8lmDRtXjBn0FMaDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 64617136A5;
	Tue, 29 Oct 2024 16:48:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0FgyGOkRIWeiKwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 29 Oct 2024 16:48:41 +0000
Message-ID: <3febb57e-e805-4cb9-8929-e47b957192a6@suse.cz>
Date: Tue, 29 Oct 2024 17:48:41 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 tip/perf/core 2/4] mm: Introduce
 mmap_lock_speculation_{begin|end}
Content-Language: en-US
To: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org, akpm@linux-foundation.org, peterz@infradead.org
Cc: oleg@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org,
 paulmck@kernel.org, willy@infradead.org, surenb@google.com,
 mjguzik@gmail.com, brauner@kernel.org, jannh@google.com, mhocko@kernel.org,
 shakeel.butt@linux.dev, hannes@cmpxchg.org, Liam.Howlett@oracle.com,
 lorenzo.stoakes@oracle.com, david@redhat.com, arnd@arndb.de,
 richard.weiyang@gmail.com, zhangpeng.00@bytedance.com, linmiaohe@huawei.com,
 viro@zeniv.linux.org.uk, hca@linux.ibm.com
References: <20241028010818.2487581-1-andrii@kernel.org>
 <20241028010818.2487581-3-andrii@kernel.org>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20241028010818.2487581-3-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9C89E1FDF3
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[redhat.com,goodmis.org,kernel.org,vger.kernel.org,infradead.org,google.com,gmail.com,linux.dev,cmpxchg.org,oracle.com,arndb.de,bytedance.com,huawei.com,zeniv.linux.org.uk,linux.ibm.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL9sdddhhbu1oo5wyhn6sr3k5b)];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.cz:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

On 10/28/24 02:08, Andrii Nakryiko wrote:
> From: Suren Baghdasaryan <surenb@google.com>
> 
> Add helper functions to speculatively perform operations without
> read-locking mmap_lock, expecting that mmap_lock will not be
> write-locked and mm is not modified from under us.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  include/linux/mmap_lock.h | 29 +++++++++++++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> index 6b3272686860..58dde2e35f7e 100644
> --- a/include/linux/mmap_lock.h
> +++ b/include/linux/mmap_lock.h
> @@ -71,6 +71,7 @@ static inline void mmap_assert_write_locked(const struct mm_struct *mm)
>  }
>  
>  #ifdef CONFIG_PER_VMA_LOCK
> +
>  static inline void mm_lock_seqcount_init(struct mm_struct *mm)
>  {
>  	seqcount_init(&mm->mm_lock_seq);
> @@ -86,11 +87,35 @@ static inline void mm_lock_seqcount_end(struct mm_struct *mm)
>  	do_raw_write_seqcount_end(&mm->mm_lock_seq);
>  }
>  
> -#else
> +static inline bool mmap_lock_speculation_begin(struct mm_struct *mm, unsigned int *seq)
> +{
> +	*seq = raw_read_seqcount(&mm->mm_lock_seq);
> +	/* Allow speculation if mmap_lock is not write-locked */
> +	return (*seq & 1) == 0;
> +}
> +
> +static inline bool mmap_lock_speculation_end(struct mm_struct *mm, unsigned int seq)
> +{
> +	return !do_read_seqcount_retry(&mm->mm_lock_seq, seq);
> +}
> +
> +#else /* CONFIG_PER_VMA_LOCK */
> +
>  static inline void mm_lock_seqcount_init(struct mm_struct *mm) {}
>  static inline void mm_lock_seqcount_begin(struct mm_struct *mm) {}
>  static inline void mm_lock_seqcount_end(struct mm_struct *mm) {}
> -#endif
> +
> +static inline bool mmap_lock_speculation_begin(struct mm_struct *mm, unsigned int *seq)
> +{
> +	return false;
> +}
> +
> +static inline bool mmap_lock_speculation_end(struct mm_struct *mm, unsigned int seq)
> +{
> +	return false;
> +}
> +
> +#endif /* CONFIG_PER_VMA_LOCK */
>  
>  static inline void mmap_init_lock(struct mm_struct *mm)
>  {


