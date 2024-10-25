Return-Path: <bpf+bounces-43149-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9832A9AFF13
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 11:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56A52282935
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 09:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869C71D9324;
	Fri, 25 Oct 2024 09:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gpXn2BuV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZebhwUxo";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gpXn2BuV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZebhwUxo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9191D27A4;
	Fri, 25 Oct 2024 09:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729850079; cv=none; b=ImH9Q4CCQA7mgSgTFb6MhxW9ygy9E6rsth3thNxy9v4+tqya1TxovgCzpfw/gvMitCDyT5jXdP9lfGtoF0krqbJF73+6hrqdVy94vnDG9xyTnaOyI4yNKirReEP0nVkqUoZwPD3eTqM1EcDWiJ0YuWTp6PS60GwiCwPI3H/PGLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729850079; c=relaxed/simple;
	bh=WL0Ly9v55/r36cSvaE3Oe4pTifKoROEtq/SOEemQdw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V13uUPHzPwZHqDBy9rm4FaxGleIFe0MLHlkv61zIPI6y5U4/JQKAnrcEvpx02mcnJOoT4torcF7nb0gYMoVIWTzbkcIVc9bW0tdl3rf3B6f3jIgRwfs2zt41eF2tW+yw6gqLCUXKynS+FlnXSXamVAwF7emGVxWfIX4C7WIbbBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gpXn2BuV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZebhwUxo; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gpXn2BuV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZebhwUxo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7170321CFF;
	Fri, 25 Oct 2024 09:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729850074; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KvxWrZ41ZMAaqHl0Ak7ybPhkjv5DvveN4GYwuAGEno0=;
	b=gpXn2BuVYVMLgm4t7yH2ZA4ZX1OJQR64gQ9yLxoLsWJZDnjdzlsy9YeKe1MN1XGjd3Sl/M
	oXSxw9jMFPqlAdOamtxMyoKSq1QpUgh7f9/n1Z0dor5j6lCKuMgzqafTOp2SnoPLIpo3jX
	vy26ev1A4h44pDW76UAou4pPHV2Xu48=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729850074;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KvxWrZ41ZMAaqHl0Ak7ybPhkjv5DvveN4GYwuAGEno0=;
	b=ZebhwUxohutSY7l9zEUBEjwgvsezkggClO/9M4aApqv7LXW9mgQiwWk+MPyXE+XYH5HBd9
	4buH46vO3+9JsODg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=gpXn2BuV;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ZebhwUxo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729850074; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KvxWrZ41ZMAaqHl0Ak7ybPhkjv5DvveN4GYwuAGEno0=;
	b=gpXn2BuVYVMLgm4t7yH2ZA4ZX1OJQR64gQ9yLxoLsWJZDnjdzlsy9YeKe1MN1XGjd3Sl/M
	oXSxw9jMFPqlAdOamtxMyoKSq1QpUgh7f9/n1Z0dor5j6lCKuMgzqafTOp2SnoPLIpo3jX
	vy26ev1A4h44pDW76UAou4pPHV2Xu48=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729850074;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KvxWrZ41ZMAaqHl0Ak7ybPhkjv5DvveN4GYwuAGEno0=;
	b=ZebhwUxohutSY7l9zEUBEjwgvsezkggClO/9M4aApqv7LXW9mgQiwWk+MPyXE+XYH5HBd9
	4buH46vO3+9JsODg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4329E132D3;
	Fri, 25 Oct 2024 09:54:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ASkRENpqG2clfwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 25 Oct 2024 09:54:34 +0000
Message-ID: <e8fdbe1e-e267-41d7-ab5c-303d29ed3929@suse.cz>
Date: Fri, 25 Oct 2024 11:54:33 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: krealloc: Fix MTE false alarm in __do_krealloc
Content-Language: en-US
To: Qun-Wei Lin <qun-wei.lin@mediatek.com>, Christoph Lameter <cl@linux.com>,
 Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Danilo Krummrich <dakr@kernel.org>
Cc: catalin.marinas@arm.com, surenb@google.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, bpf@vger.kernel.org,
 Casper Li <casper.li@mediatek.com>,
 Chinwen Chang <chinwen.chang@mediatek.com>,
 Andrew Yang <andrew.yang@mediatek.com>, John Hsu <john.hsu@mediatek.com>,
 wsd_upstream@mediatek.com
References: <20241025085811.31310-1-qun-wei.lin@mediatek.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20241025085811.31310-1-qun-wei.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 7170321CFF
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[mediatek.com,linux.com,kernel.org,google.com,lge.com,linux-foundation.org,linux.dev,gmail.com,collabora.com];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,mediatek.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 10/25/24 10:58, Qun-Wei Lin wrote:
> This patch addresses an issue introduced by commit 1a83a716ec233 ("mm:
> krealloc: consider spare memory for __GFP_ZERO") which causes MTE
> (Memory Tagging Extension) to falsely report a slab-out-of-bounds error.
> 
> The problem occurs when zeroing out spare memory in __do_krealloc. The
> original code only considered software-based KASAN and did not account
> for MTE. It does not reset the KASAN tag before calling memset, leading
> to a mismatch between the pointer tag and the memory tag, resulting
> in a false positive.
> 
> Example of the error:
> ==================================================================
> swapper/0: BUG: KASAN: slab-out-of-bounds in __memset+0x84/0x188
> swapper/0: Write at addr f4ffff8005f0fdf0 by task swapper/0/1
> swapper/0: Pointer tag: [f4], memory tag: [fe]
> swapper/0:
> swapper/0: CPU: 4 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.
> swapper/0: Hardware name: MT6991(ENG) (DT)
> swapper/0: Call trace:
> swapper/0:  dump_backtrace+0xfc/0x17c
> swapper/0:  show_stack+0x18/0x28
> swapper/0:  dump_stack_lvl+0x40/0xa0
> swapper/0:  print_report+0x1b8/0x71c
> swapper/0:  kasan_report+0xec/0x14c
> swapper/0:  __do_kernel_fault+0x60/0x29c
> swapper/0:  do_bad_area+0x30/0xdc
> swapper/0:  do_tag_check_fault+0x20/0x34
> swapper/0:  do_mem_abort+0x58/0x104
> swapper/0:  el1_abort+0x3c/0x5c
> swapper/0:  el1h_64_sync_handler+0x80/0xcc
> swapper/0:  el1h_64_sync+0x68/0x6c
> swapper/0:  __memset+0x84/0x188
> swapper/0:  btf_populate_kfunc_set+0x280/0x3d8
> swapper/0:  __register_btf_kfunc_id_set+0x43c/0x468
> swapper/0:  register_btf_kfunc_id_set+0x48/0x60
> swapper/0:  register_nf_nat_bpf+0x1c/0x40
> swapper/0:  nf_nat_init+0xc0/0x128
> swapper/0:  do_one_initcall+0x184/0x464
> swapper/0:  do_initcall_level+0xdc/0x1b0
> swapper/0:  do_initcalls+0x70/0xc0
> swapper/0:  do_basic_setup+0x1c/0x28
> swapper/0:  kernel_init_freeable+0x144/0x1b8
> swapper/0:  kernel_init+0x20/0x1a8
> swapper/0:  ret_from_fork+0x10/0x20
> ==================================================================
> 
> Fixes: 1a83a716ec233 ("mm: krealloc: consider spare memory for
> __GFP_ZERO")
> Signed-off-by: Qun-Wei Lin <qun-wei.lin@mediatek.com>

Thanks, added to slab hotfixes for 6.12

> ---
>  mm/slab_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 3d26c257ed8b..3445f4500b54 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1209,7 +1209,7 @@ __do_krealloc(const void *p, size_t new_size, gfp_t flags)
>  		/* Zero out spare memory. */
>  		if (want_init_on_alloc(flags)) {
>  			kasan_disable_current();
> -			memset((void *)p + new_size, 0, ks - new_size);
> +			memset(kasan_reset_tag((void *)p + new_size), 0, ks - new_size);
>  			kasan_enable_current();
>  		}
>  


