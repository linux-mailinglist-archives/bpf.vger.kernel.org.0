Return-Path: <bpf+bounces-21138-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF9E848843
	for <lists+bpf@lfdr.de>; Sat,  3 Feb 2024 19:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C0031C216FC
	for <lists+bpf@lfdr.de>; Sat,  3 Feb 2024 18:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F785F568;
	Sat,  3 Feb 2024 18:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZOdjjVj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868B45F867
	for <bpf@vger.kernel.org>; Sat,  3 Feb 2024 18:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706986145; cv=none; b=qARdsMYz0S0KNXWAWZLrnLs5EOOBuf/jDDav/8NrsxgDeGGOVDHHRHQgcbkBzG74s4yOpxrsc6w6D3oL48vc39NnlEaJGOG21xT9SrlqqqF4L57q/mmwrgqif/L3c17R/bG83EGWspGX7hX97sVlmmAXq92DBU9jjIxNsLifgX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706986145; c=relaxed/simple;
	bh=Qu/e8tuHAHrFlFKDhbMPATk8BOPff9A9BKVfkskJ8AY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u1Gb7V1OSDG628lkIv5iZa4lzqn7AwG/2NlgKi/YDAKbFxGYXghIrFDwr6rUwlfghyr2DviRr26Mtec1srLrLbMb3AEbLI6x2vbV8k3/qlWNPV6fH8JazRrjP9P3stHBiG4N9c15wlVtIJOEh50Kd3k9dVYh7jJQfso6R8c0wE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZOdjjVj; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5ceb3fe708eso2513618a12.3
        for <bpf@vger.kernel.org>; Sat, 03 Feb 2024 10:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706986143; x=1707590943; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7S6HO7T4fWy15DcLUkCuWi6GbSIXbicNbyaVDYUXo5U=;
        b=VZOdjjVjYMQkaqATABs9TISQiAnt4CSj5YyE+dUdRdKEUgPNrvyzwOji7dNFFauMfc
         1w05746RsswuPaGQvDoJoXvzXoIQRmLOG5EkrOkRXKHmDeX8P0LyvELSPDao7ZoqKW9f
         RbP718e1xC0Zx9zb5e+bWzM8SfzUzbDMM/rIBxbh8Et0Wgrv9LqseAiToCgy3LbIGCqu
         l2DEvC9yE21vvH4Qzn3QQe+59Iy6tCnWncFDCQQgEStoRCbdZXZKkFMczwVLHOCvnan9
         EEjIrC07nNGimncRXAc8oDpHClE4xMeYSJeSeS2Ue+Y70tUo25OgHuh5ciQaiXKo221r
         xpIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706986143; x=1707590943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7S6HO7T4fWy15DcLUkCuWi6GbSIXbicNbyaVDYUXo5U=;
        b=av2kMGydRLGGNbxt14DGLH2tMNrP+I+DgWyLRwxpja3QDLd3TTjj64HsTJYvwWCwx5
         lKqj+hlG+ezFWmhFBZMMXGMZaCPXUBUZiWp19WsHX3NyCu00fVsfYgl5BAaQuKRLEudx
         VZwEczhjHf5dRcEr0P8CpuJM0Qf1p0FMmduJDgu57ZRBjj018IZJu1UvNiNHUyDxpUOZ
         fGjTWBkXRGSGktJjb5i4L4gtupIGMDwziuPk7ZlpyTBLC2bfHkRnoDEZm31xXj6hvVym
         C5khzcs72hz8hu8PghP9DOuZHnn+DSv1aibR93/WuNOjCBDXjMzrPGIPlpQZnueQ5Va1
         1nog==
X-Gm-Message-State: AOJu0YwWQDqQ1kMIMPPf+QFkBWZPHB/0cz07fhxGRLgywVck66H8gqEY
	zdVrgVKnr7ap3+jxtnwGv0raB1x+tNNcmdCg3VtZbcKMyxXOu9lT
X-Google-Smtp-Source: AGHT+IFKZHdmaJcIyKkW5e5AgZF1pic+ofRQGGGGreK/lsDhr42QsV7JZ6Pf+NTREIPv1c8HpvmJPg==
X-Received: by 2002:a17:902:6b05:b0:1d9:4851:fb99 with SMTP id o5-20020a1709026b0500b001d94851fb99mr8605641plk.26.1706986142595;
        Sat, 03 Feb 2024 10:49:02 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVqij8oKScUBUi12CZWC7F9UcWoeUX+dJ657tCXXluD80TbZlo7DVjMqh+bQ4RdcoyJh7s4e+DxNqqtT7AUb2sq3Yh7xs+/9OvqO/csKbYEhkURm8g3m+op97PrHqLUCayHLE9HNxXEhD70ROze5AAP8GLMlH33+IFOHcPuHw5WPpmSSJGSDKzoTc5psMymrl3B1ReDSA3I7qn6+bntK0Qlt2DZkS8pXXCq6Amc3QzrTVzzUOBN7xM4qTSS376DOzHHLvi3578JuSifUtuiPi0MUkDbPVkhquSEu9h2FUbPUOiBrHS+Fprtob2ANdtimzF3TdetQHefKr7lf5vpTOetiMXFR0i8HrpVmr8PYt+U2QYRfiKRaV4b+t4cPUiSTJ8spPuamKfC28gMHvFbmp5LipQ5HqfYKdn9KYF6xDsO12nx+PPR0fCyqjP2+6MECHcD0GbDEcZIXYNxut266U0W3hjclLl3ECBKnpYmTxxzBCaZZZ8=
Received: from surya ([70.134.61.176])
        by smtp.gmail.com with ESMTPSA id y3-20020a170902ed4300b001d94126da45sm3524687plb.180.2024.02.03.10.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 10:49:02 -0800 (PST)
Date: Sat, 3 Feb 2024 10:48:59 -0800
From: Manu Bretelle <chantr4@gmail.com>
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: Viktor Malik <vmalik@redhat.com>, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] tools/resolve_btfids: fix
 cross-compilation to non-host endianness
Message-ID: <Zb6Km769Hh6BZF8e@surya>
References: <cover.1706717857.git.vmalik@redhat.com>
 <64f6372c75a44d5c8d00db5c5b7ca21aa3b8bd77.1706717857.git.vmalik@redhat.com>
 <vjbvcxsbtz7mrwevvcb3i4sf7hv5ah6iyjyzg7awr4iuiimryv@wjkglqsk6wee>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vjbvcxsbtz7mrwevvcb3i4sf7hv5ah6iyjyzg7awr4iuiimryv@wjkglqsk6wee>

On Fri, Feb 02, 2024 at 06:38:18PM -0700, Daniel Xu wrote:
> Hi Viktor,
> 
> On Wed, Jan 31, 2024 at 05:24:09PM +0100, Viktor Malik wrote:
> > The .BTF_ids section is pre-filled with zeroed BTF ID entries during the
> > build and afterwards patched by resolve_btfids with correct values.
> > Since resolve_btfids always writes in host-native endianness, it relies
> > on libelf to do the translation when the target ELF is cross-compiled to
> > a different endianness (this was introduced in commit 61e8aeda9398
> > ("bpf: Fix libelf endian handling in resolv_btfids")).
> > 
> > Unfortunately, the translation will corrupt the flags fields of SET8
> > entries because these were written during vmlinux compilation and are in
> > the correct endianness already. This will lead to numerous selftests
> > failures such as:
> > 
> >     $ sudo ./test_verifier 502 502
> >     #502/p sleepable fentry accept FAIL
> >     Failed to load prog 'Invalid argument'!
> >     bpf_fentry_test1 is not sleepable
> >     verification time 34 usec
> >     stack depth 0
> >     processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
> >     Summary: 0 PASSED, 0 SKIPPED, 1 FAILED
> > 
> > Since it's not possible to instruct libelf to translate just certain
> > values, let's manually bswap the flags in resolve_btfids when needed, so
> > that libelf then translates everything correctly.
> > 
> > Fixes: ef2c6f370a63 ("tools/resolve_btfids: Add support for 8-byte BTF sets")
> > Signed-off-by: Viktor Malik <vmalik@redhat.com>
> > ---
> >  tools/bpf/resolve_btfids/main.c | 27 ++++++++++++++++++++++++++-
> >  1 file changed, 26 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
> > index 7badf1557e5c..d01603ef6283 100644
> > --- a/tools/bpf/resolve_btfids/main.c
> > +++ b/tools/bpf/resolve_btfids/main.c
> > @@ -652,13 +652,23 @@ static int sets_patch(struct object *obj)
> >  	Elf_Data *data = obj->efile.idlist;
> >  	int *ptr = data->d_buf;
> >  	struct rb_node *next;
> > +	GElf_Ehdr ehdr;
> > +	int need_bswap;
> > +
> > +	if (gelf_getehdr(obj->efile.elf, &ehdr) == NULL) {
> > +		pr_err("FAILED cannot get ELF header: %s\n",
> > +			elf_errmsg(-1));
> > +		return -1;
> > +	}
> > +	need_bswap = (__BYTE_ORDER == __LITTLE_ENDIAN) !=
> > +		     (ehdr.e_ident[EI_DATA] == ELFDATA2LSB);
> >  
> >  	next = rb_first(&obj->sets);
> >  	while (next) {
> >  		unsigned long addr, idx;
> >  		struct btf_id *id;
> >  		void *base;
> > -		int cnt, size;
> > +		int cnt, size, i;
> >  
> >  		id   = rb_entry(next, struct btf_id, rb_node);
> >  		addr = id->addr[0];
> > @@ -686,6 +696,21 @@ static int sets_patch(struct object *obj)
> >  			base = set8->pairs;
> >  			cnt = set8->cnt;
> >  			size = sizeof(set8->pairs[0]);
> > +
> > +			/*
> > +			 * When ELF endianness does not match endianness of the
> > +			 * host, libelf will do the translation when updating
> > +			 * the ELF. This, however, corrupts SET8 flags which are
> > +			 * already in the target endianness. So, let's bswap
> > +			 * them to the host endianness and libelf will then
> > +			 * correctly translate everything.
> > +			 */
> > +			if (need_bswap) {
> > +				for (i = 0; i < cnt; i++) {
> > +					set8->pairs[i].flags =
> > +						bswap_32(set8->pairs[i].flags);
> > +				}
> 
> Do we need this for btf_id_set8:flags as well? Didn't get a chance to
> look too deeply yet.
> 
> Thanks,
> Daniel

I ran some test and tried and validated Jiri's patch in
https://lore.kernel.org/bpf/Zb6Jt30bNcNhM6zR@surya/

Manu

