Return-Path: <bpf+bounces-41236-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 394A69944F7
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 12:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2D6B1F22540
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 10:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1EB18CBF1;
	Tue,  8 Oct 2024 10:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NwE+r5Ej";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Cu9em5JV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1n3pQQQB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UAKXMz7g"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D9C78276;
	Tue,  8 Oct 2024 10:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728381676; cv=none; b=m15osFq34H/3SOvw9l0g9I01HJFkXJEH5rrbrlRWNYfaLlffGwwuU3CkNgxMHpYC695VqniUpp0/7N3zzJkyFc6N2122AQo5WFQuXdByF5NA4uCDApESWpoP8NV4Bvet/Mr6798Buf7iwmy6v1Q3O/gM6tk/dLs2VptCh6XSGFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728381676; c=relaxed/simple;
	bh=+0FDQuRcCQaBOYQeUSn0bsdncp8GJcXLugOJUkCRPqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Elejz5zaveGarX8fzDh7dj4zaeLM767AVzSyHZXw9nGYAQUqLe8icvQ79EGwNew4ZgMkFPOy073FGzmyqdWl5ZGYYquN3XXQCnlhFZv1KtZ1+AA2n5sKVS4gip9x/Vgn+N7JTr2oniqdIk5D1r5W5XYO0DslUaRx5dA8hUUsoRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NwE+r5Ej; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Cu9em5JV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1n3pQQQB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UAKXMz7g; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B2C921F7A5;
	Tue,  8 Oct 2024 10:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728381672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=auDmFYal75sChbZaknVCwko3uWEWFwGgE/swGMkMKss=;
	b=NwE+r5EjBxB+AfwgzBXoo80gUna92I+6hi7l3iIlzheBdyIsoA95hPzU2Q4S3sQVMOADR1
	7WphlHaaylHqMBIliH9Io9YrfpqZPgmpHLs/mKxAIYOjyvVnKzmTel43NO2n5blhcxOPZe
	5qkYOozm/OT74fsG+StZt0kXhJZEBY4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728381672;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=auDmFYal75sChbZaknVCwko3uWEWFwGgE/swGMkMKss=;
	b=Cu9em5JVyrikwe5Fpak2RC1oyXfCCG3ilTkK4QIToJwZyGgEka+4HEoNOKMtzP5gIodEyj
	r1PnlZHJPJD2slDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728381671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=auDmFYal75sChbZaknVCwko3uWEWFwGgE/swGMkMKss=;
	b=1n3pQQQBIVlz5pT2Y/rlj0w2ZVpiqXWOqlrwCDEBeWPg3IWgXxwyYQsag/NfNWQ7/Aezob
	lG3X5bvQ1v3vQOGD/LhftDGT55nxlQ0meoWr5ve5sJ6ZeKzMesyfSCXWWLZuaCOy3eg6Kp
	k+iD1qnprwdou404o2fVhWF2Axtt2AE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728381671;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=auDmFYal75sChbZaknVCwko3uWEWFwGgE/swGMkMKss=;
	b=UAKXMz7gytFoNFQdOEVoVxSznCm/DngyjMEVxA+GetC8V2RKytygMOIdvBIxm9Ons5lqaM
	NHsFMpyldFUwnDDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7D82B1340C;
	Tue,  8 Oct 2024 10:01:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RrwGHucCBWfnQgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 08 Oct 2024 10:01:11 +0000
Message-ID: <7d785f59-7c5a-45e6-b508-8814537a1522@suse.cz>
Date: Tue, 8 Oct 2024 12:01:11 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [bpf?] WARNING in push_jmp_history
Content-Language: en-US
To: Eduard Zingerman <eddyz87@gmail.com>, feng.tang@intel.com
Cc: syzbot <syzbot+7e46cdef14bf496a3ab4@syzkaller.appspotmail.com>,
 42.hyeyoo@gmail.com, akpm@linux-foundation.org, andrii@kernel.org,
 ast@kernel.org, bpf@vger.kernel.org, cl@linux.com, daniel@iogearbox.net,
 haoluo@google.com, iamjoonsoo.kim@lge.com, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, martin.lau@linux.dev, penberg@kernel.org,
 rientjes@google.com, roman.gushchin@linux.dev, sdf@fomichev.me,
 song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
References: <6704f097.050a0220.1e4d62.0087.GAE@google.com>
 <fc6396c21f8a9fa83166fd4ccaee7c2c5069f0b2.camel@gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <fc6396c21f8a9fa83166fd4ccaee7c2c5069f0b2.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=94f9caf16c0af42d];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_TO(0.00)[gmail.com,intel.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[syzkaller.appspotmail.com,gmail.com,linux-foundation.org,kernel.org,vger.kernel.org,linux.com,iogearbox.net,google.com,lge.com,kvack.org,linux.dev,fomichev.me,googlegroups.com];
	SUBJECT_HAS_QUESTION(0.00)[];
	TAGGED_RCPT(0.00)[7e46cdef14bf496a3ab4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email]
X-Spam-Score: -1.80
X-Spam-Flag: NO

On 10/8/24 11:41, Eduard Zingerman wrote:
> On Tue, 2024-10-08 at 01:43 -0700, syzbot wrote:
>> syzbot has bisected this issue to:
>> 
>> commit d0a38fad51cc70ab3dd3c59b54d8079ac19220b9
>> Author: Feng Tang <feng.tang@intel.com>
>> Date:   Wed Sep 11 06:45:34 2024 +0000
>> 
>>     mm/slub: Improve redzone check and zeroing for krealloc()
>> 
>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11ddbb80580000
>> start commit:   c02d24a5af66 Add linux-next specific files for 20241003
>> git tree:       linux-next
>> final oops:     https://syzkaller.appspot.com/x/report.txt?x=13ddbb80580000
>> console output: https://syzkaller.appspot.com/x/log.txt?x=15ddbb80580000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=94f9caf16c0af42d
>> dashboard link: https://syzkaller.appspot.com/bug?extid=7e46cdef14bf496a3ab4
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10b82707980000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16f4c327980000
>> 
>> Reported-by: syzbot+7e46cdef14bf496a3ab4@syzkaller.appspotmail.com
>> Fixes: d0a38fad51cc ("mm/slub: Improve redzone check and zeroing for krealloc()")
>> 
>> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 
> There are two issues demonstrated by this repro:
> - one is mm/slub related;
> - another one is verification taking forever.
> 
> About the mm/slub related. Applying the following patch with
> additional logging on top of commit d0a38fad51cc identified by syzbot:

The slab one is known from other reports and the problematic commit was
removed from -next since then.

> 
> ------- 8< ------------------------------------------------------------
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 9a7ed527e47e..c1582a6d1d33 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3494,7 +3494,9 @@ static int push_jmp_history(struct bpf_verifier_env *env, struct bpf_verifier_st
>  
>         cnt++;
>         alloc_size = kmalloc_size_roundup(size_mul(cnt, sizeof(*p)));
> +       printk("push_jmp_history: #1 cur->jmp_history=%p\n", cur->jmp_history);
>         p = krealloc(cur->jmp_history, alloc_size, GFP_USER);
> +       printk("push_jmp_history: #2 cur->jmp_history=%p\n", p);
>         if (!p)
>                 return -ENOMEM;
>         cur->jmp_history = p;
> diff --git a/mm/slub.c b/mm/slub.c
> index e0fb0a26c796..3f5b080ac1f5 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4627,7 +4627,7 @@ static inline struct kmem_cache *virt_to_cache(const void *obj)
>         struct slab *slab;
>  
>         slab = virt_to_slab(obj);
> -       if (WARN_ONCE(!slab, "%s: Object is not a Slab page!\n", __func__))
> +       if (WARN_ONCE(!slab, "%s: Object %p is not a Slab page!\n", __func__, obj))
>                 return NULL;
>         return slab->slab_cache;
>  }
> ------------------------------------------------------------ >8 -------
> 
> Produces the following log:
> 
>  l1: [    2.942120] push_jmp_history: #2 cur->jmp_history=00000000a0f6f503
>  l2: [    2.944445] push_jmp_history: #1 cur->jmp_history=00000000a0f6f503
>  l3: [    2.944560] ------------[ cut here ]------------
>  l4: [    2.944647] virt_to_cache: Object 00000000a0f6f503 is not a Slab page!
>  l5: [    2.944765] WARNING: CPU: 0 PID: 145 at mm/slub.c:4630 krealloc_noprof (mm/slub.c:4630 mm/slub.c:4728 mm/slub.c:4813) 
>  l6: [    2.944906] Modules linked in:
>  l7: [    2.945134] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-2.fc40 04/01/2014
>  l8: [    2.945285] RIP: 0010:krealloc_noprof (mm/slub.c:4630 mm/slub.c:4728 mm/slub.c:4813) 
>                ...
> l9:  [    2.952088] BUG: kernel NULL pointer dereference, address: 000000000000001c
> l10: [    2.952171] #PF: supervisor read access in kernel mode
> l11: [    2.952240] #PF: error_code(0x0000) - not-present page
> l12: [    2.952309] PGD 105d51067 P4D 105d51067 PUD 1013d0067 PMD 0 
> l13: [    2.952402] Oops: Oops: 0000 [#1] PREEMPT SMP KASAN NOPTI
> l14: [    2.952611] Tainted: [W]=WARN
> l15: [    2.952664] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-2.fc40 04/01/2014
> l16: [    2.952794] RIP: 0010:krealloc_noprof (mm/slub.c:0 mm/slub.c:4729 mm/slub.c:4813) 
> 
> Lines l{1,2,4} show that address 0xa0f6f503 was first allocated by
> krealloc and then krealloc failed to recognize it as such.
> 
> The warning at l3 is reported by virt_to_cache() called from
> __do_krealloc():
> 
> 
>    4715 static __always_inline __realloc_size(2) void *
>    4716 __do_krealloc(const void *p, size_t new_size, gfp_t flags)
>    4717 {
>    4718         void *ret;
>    4719         size_t ks;
>    4720         int orig_size = 0;
>    4721         struct kmem_cache *s;
>    4722 
>    4723         /* Check for double-free. */
>    4724         if (likely(!ZERO_OR_NULL_PTR(p))) {
>    4725                 if (!kasan_check_byte(p))
>    4726                         return NULL;
>    4727 
>    4728                 s = virt_to_cache(p);
>    4729                 orig_size = get_orig_size(s, (void *)p);
>    4730                 ks = s->object_size;
> 
> When virt_to_cache() reports the warning it returns NULL.
> Hence variable 's' at line 4728 is NULL and this causes null pointer
> dereference at line 4730, reported at l9.
> 
> Lines 4725-4730 were changed by commit d0a38fad51cc identified by syzbot,
> previously 'ks' was identified using other means.
> 
> Feng, this issue seem unrelated to BPF verifier, could you please take a look?
> 
> Best regards,
> Eduard
> 


