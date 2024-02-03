Return-Path: <bpf+bounces-21139-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8AE8488AC
	for <lists+bpf@lfdr.de>; Sat,  3 Feb 2024 21:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEDCF281F29
	for <lists+bpf@lfdr.de>; Sat,  3 Feb 2024 20:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1985FDC3;
	Sat,  3 Feb 2024 20:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGm8yJpI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9378B5FB86
	for <bpf@vger.kernel.org>; Sat,  3 Feb 2024 20:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706991441; cv=none; b=GqGW2EK/MhDegb631c4GLAaSaHYPB3n/LefFO6/JkggHSAjLMcileP+s/lz6VY73WJK2+KtThOyLrcl4WyXajGx2xD1yJPiWbujDms29Oqiyf0ZPafgiPdG1dPgt5U5L/5m9j2FBDsxqY7K3j5/889d+nagPHwO5BMziUTUNctA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706991441; c=relaxed/simple;
	bh=waItzEd/xVl0qbKub0DrHtT5NFFIjhRQtU/OZ59sAiw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TYaI14BXnwgsRPXlrgPW+MenbqsNO4fLjIgors0RkZGbwxdy2ODHIBHCCt4+JwOjCwSNAxKpgK/J1gNbkzgDRqMBOVifpaoblXCBxpWvpQ2T73r+5HRVAFtD59vyeJ8gTXaMvXMuBR971o7TQAT/cMZEzA5uJ9PrX69NINOKMwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGm8yJpI; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33b35323341so156958f8f.3
        for <bpf@vger.kernel.org>; Sat, 03 Feb 2024 12:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706991438; x=1707596238; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=clf4wHSZ0Qq/I4cmTuKARSAKizAZQi92DUGSx7wQfPo=;
        b=eGm8yJpID9YddAvNSxUvPlkdZSdfYzbWQ9vmyMMriwA11g2qLizoOiM8yXbjJazDxH
         vgKnLkjBpI1q/T1H3ReZy6IcyI3yfUUk0GgVzX/NG4N1+cm7GhlFPHiE8vuW/SVZw0CK
         caPj88Oq1DuVSjTse6cp4hIBY4SRiCBpSYPn5BpxZd6lXGyC5DM7d2CSPYhz3eo8Sa3p
         K3wSSRtZ83LV3v2FXb0R5ohJV7baYyFPtcZ3fd296gJ2GxS9AYuGB8RdBTnLxH7trpw3
         JiV3n6m/wo5Me/Muz3nBCoHcOy73fz432GTqIp+dCPKsra/y5qkbOOWNYVxVl6ESmElt
         1lsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706991438; x=1707596238;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=clf4wHSZ0Qq/I4cmTuKARSAKizAZQi92DUGSx7wQfPo=;
        b=HkNk4wSZVVFvgXU1hBLv/+G+A3uliYSOpsU2lgxkG2cwbBY7ZwtZhQLZqjWtahSIor
         dk7o+NJNGWQ8eiXp8X0O0oXYGMl4u9priESz4nXOw8sIxPe7ERUkMCIOpAEFSZYCFHVo
         QrehPBIW2JZx40HhK9gh9G1j4oc+5Dg7bmnfxEXPwRPEvNawJZvG1ChWk59vWEbd/Ctn
         nJmDajJRVIeQaB8rSMZfLDaBhonUsLG8IWGoyLkF8eUhSWKGpAXWrQ9FbmZzcRQSxHu2
         uKGUhySOYyItblJ3rY70e5mwN1o9/wscrXN155n9rzVUUml3es8h1yRGi1MtlspJnaMs
         GPSQ==
X-Gm-Message-State: AOJu0YzyOsttVs5c8Rrt8j994i3oBYJA4de/6S5wltoRbjr1K+EMJFm/
	2LsE5AniIr4YkSqQ6sizijEhHAoQX5yWRIBe+Iuf4iWRY3nHsiqe
X-Google-Smtp-Source: AGHT+IGDkoVKPk3IifjU864hMvoYK3LQYy/DgjASO/RF2viqIKPPp5ghMN4VOQcJyT9+x/WAdOHnyA==
X-Received: by 2002:a5d:4603:0:b0:33b:2516:727d with SMTP id t3-20020a5d4603000000b0033b2516727dmr2496278wrq.35.1706991437410;
        Sat, 03 Feb 2024 12:17:17 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUlfUZFK91zotqnATsz3ZA2wqKaWFMGYKJQLw0g4kBoesj5zdMs5eqdgER8CjxB/vJVCv9feNwvNKrVYg7eOtddSM7R8nqfCiDmnYd65i9b5qEbvg4+qWN6js7SDXSU4xEReJoa5YddxzRwoJAvs+Tw+yeAA667p2Up2z6ZCk1OWgAUC9MIgPWvMYZiVp13d5ixFFnMnAmi0bds6UaT/l/g/6QHjlyqFo3w+D3mmgB/mGA8AkaIJBG9paW4gNedkgW09bs0ymkVqjsqCIALDhwG9KcHCcAEoMcrlN9QIQUgJFhOq+nSNPwsV5ZaT2hrTNe3Ly5XRDOUqQ6RR0Y/XBjx4SsdRvpEsloH4ME7RBESbeGmlHzeTKA08aX0gqeXVlzFye9HQPx94NGPl0tPu76YBCOUNgrhMWSmvQe/GE5KOUYyxwCCbq0WGIaVI0kSM3sVLY4D+EWqqCpSXbqAxzh48bw=
Received: from krava ([83.240.62.96])
        by smtp.gmail.com with ESMTPSA id o23-20020a056402039700b00560003cfd70sm1509991edv.82.2024.02.03.12.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 12:17:16 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 3 Feb 2024 21:17:14 +0100
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
	Hao Luo <haoluo@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] tools/resolve_btfids: fix
 cross-compilation to non-host endianness
Message-ID: <Zb6fSielrjHy2nnt@krava>
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

ah did not this, right, looks like we need that

jirka

