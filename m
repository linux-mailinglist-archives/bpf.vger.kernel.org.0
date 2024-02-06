Return-Path: <bpf+bounces-21302-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FB384B3FB
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 12:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2A021F22AA4
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 11:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9144131744;
	Tue,  6 Feb 2024 11:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHcMggIW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816C2131739
	for <bpf@vger.kernel.org>; Tue,  6 Feb 2024 11:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707219242; cv=none; b=rO4Uf2RR0dfbvUxJKiRsX8pKEGOUYmc6tH+/qvRHxzyDbocjsj5jpwX2RJ3/s9jCOaabOMIF6s1yfDN8ACyXfgRTSggoRsk7lI3Kc5PRhL2imsYCZ8rM1yTehbMqHxWYdBdFx8Gi7nEfDfyntiHmCe8iSqAcPixaKUBRSAPTmMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707219242; c=relaxed/simple;
	bh=k5YPd5FUU5irWG3w/vocvBQ8HVDW5poi/aUYHyWsqC4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EMfEg0P7EbZQKNaNbZ2WYmN2MFGxdgljAtUBuMWfESzpu6/02Cv+2FtMwYkrFZNBXZfjtazmofsRcbGEl3VtmHY7jE3W08MAoZ/AOZaorzyHC5uIHEr3PC4w5YAwpOsmlktxhLSd1tIwgl64PemPzMaa2fhNaB4hW04af4IA0Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BHcMggIW; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a36126ee41eso694145366b.2
        for <bpf@vger.kernel.org>; Tue, 06 Feb 2024 03:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707219238; x=1707824038; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3v+gLfYC+ds52HYkoPgG8OYuqZYZp4xX/X98EoJTnq8=;
        b=BHcMggIWmPiWEDr0OmJPhL5hiNbjIwaHcpdyHWI04WyAd7p5+ioEI0rrKNImpUX2IT
         B2su8HK5i2UFuMXfLm+q5FKRYEbWCSRGn7/DHciv+n/Imew5jND9X0YXOp1J+4uVSSkP
         hLeL8JJGV44rITL89iDZLAtKtAA5Zc5A1oF/7JYhQxOXkGtXqcSswEe6tpr1WTPAARq6
         KofvD1LyqbD0AB9fbfjS7/+MV2FjWYqLLRKpv6nfYHnY/OfvJXg9ea/MNnxMkXSlauWC
         xfeFb7p2nk4PjhLwc457opdjodKgwWBeh/1BTdeOArAJrvY2F5P4NM/LWkfebjPs4jCc
         ussA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707219238; x=1707824038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3v+gLfYC+ds52HYkoPgG8OYuqZYZp4xX/X98EoJTnq8=;
        b=fTDQD53/lW/QFJJa0to/uevUDBYG7BqlrkGduM6lSSppR1KVJ2K1koHLXSgtKsCpKT
         X26jk7n1L6lWVCTWW5gd+wakbXNAVgZsrqh+3km/DnIBq+QhAUPzW+JJS2PdMraUIut5
         cR9FdlTeRPllaUeD7Yceen3uHtyzrGSYgJ0013PPzSMXx+HqDJxFgvxuEaFdR5zSA8NO
         aO9e94+8k8vM8wZA7b0JXhEGNQVOIacJf5oJg7pjp9DX/qgrh7bEZuO/OdHKmaPTs59Y
         B1NHymaHcSoH5sF0m7coVhGfWRJG0aEZ+bbKgMU04W74VujrgzHX/+nEy8JcKU0VLi9y
         vTSA==
X-Gm-Message-State: AOJu0YxjOX3+hLiXaGsnkGxC4FcjjVZaQ8Wjy/NUK/LJAsiYeVvWgpzK
	N80FF1bsx+ELyKFwQTZLtuQrFVgZ5mHG/ZCivcdN5aGE1QGYH80S
X-Google-Smtp-Source: AGHT+IGUgZ45X5qOzNBRNfwYru+j4CimFxO/irWrAxzr6WxrFrJd2cWoNioBr0UoZDZVtVmwRZ/MAg==
X-Received: by 2002:a17:906:a457:b0:a37:2576:79f9 with SMTP id cb23-20020a170906a45700b00a37257679f9mr1368667ejb.2.1707219238352;
        Tue, 06 Feb 2024 03:33:58 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV31msvEOk7t6BFVoN7rIHybs03ggFYlTj3VpEfnKiT6CkwsOtNCO7cXFgO0k3N4rZ2oFZFP/uG19wL1Bz4Nl5fzLNvZB/Rq6PsjL/ie228pH+4As83FPYGm/kGZATkHQyEM7adYWqEgofvQnJawFVvi1BuARUr1eKRES5qhffIdeyfMTegGRbDMoR9qzb9thjPfcXeeh2xq4Ua41XPNkXz69qPrs7TTKIyI1unRSNwRGdp0A5+iUsNNWr9zN3YJCENQykxVInBLKuirhzK6Th+AuMl8XvnId7aH4Bs1tKpVmoP1gZ8fNjQLvk4gI02ZD1Mqd+Q9RkXz4trHY5bDJkQyTnz/saXF065w3omSIzQBM6WftxRg43k8Sms01pue6WvijYCOtR+niAsmq+i92Z5O2hTFMGcuHgsfPT0yq15q9Pj4jCywNjlAhhPqhn33v1bU+LdfTmApdQ/enbs4Fcy9N4+ewvhYfPka+H3GSSai6WVvJim
Received: from krava ([144.178.231.99])
        by smtp.gmail.com with ESMTPSA id s19-20020a17090699d300b00a3808c7febdsm998201ejn.28.2024.02.06.03.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 03:33:58 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 6 Feb 2024 12:33:56 +0100
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
	Hao Luo <haoluo@google.com>, Alexey Dobriyan <adobriyan@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Manu Bretelle <chantr4@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] tools/resolve_btfids: Refactor set
 sorting with types from btf_ids.h
Message-ID: <ZcIZJEXOByuZLFsC@krava>
References: <cover.1707157553.git.vmalik@redhat.com>
 <8e84b14c36d2a855071edfb9121787e7f0f0ddca.1707157553.git.vmalik@redhat.com>
 <uk5wsboc2rfloizsah5d4vb3tid55diiejkutfgsvr6qn7u5vn@ka3u4e7usa3z>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <uk5wsboc2rfloizsah5d4vb3tid55diiejkutfgsvr6qn7u5vn@ka3u4e7usa3z>

On Mon, Feb 05, 2024 at 12:45:30PM -0700, Daniel Xu wrote:

SNIP

> > @@ -654,10 +655,10 @@ static int sets_patch(struct object *obj)
> >  
> >  	next = rb_first(&obj->sets);
> >  	while (next) {
> > +		struct btf_id_set8 *set8;
> > +		struct btf_id_set *set;
> >  		unsigned long addr, idx;
> >  		struct btf_id *id;
> > -		int *base;
> > -		int cnt;
> >  
> >  		id   = rb_entry(next, struct btf_id, rb_node);
> >  		addr = id->addr[0];
> > @@ -671,13 +672,21 @@ static int sets_patch(struct object *obj)
> >  		}
> >  
> >  		idx = idx / sizeof(int);
> > -		base = &ptr[idx] + (id->is_set8 ? 2 : 1);
> > -		cnt = ptr[idx];
> > +		if (id->is_set) {
> > +			set = (struct btf_id_set *)&ptr[idx];
> 
> Nit: should be able to simplify logic a bit like this:
> 
>         int off = addr - obj->efile.idlist_addr;
>         set8 = data->d_buf + off;
> 
> Don't think that `idx`, `ptr` or casts are necessary anymore.

+1 , otherwise it looks good to me

jirka

> 
> > +			qsort(set->ids, set->cnt, sizeof(set->ids[0]), cmp_id);
> > +		} else {
> > +			set8 = (struct btf_id_set8 *)&ptr[idx];
> > +			/*
> > +			 * Make sure id is at the beginning of the pairs
> > +			 * struct, otherwise the below qsort would not work.
> > +			 */
> > +			BUILD_BUG_ON(set8->pairs != &set8->pairs[0].id);
> > +			qsort(set8->pairs, set8->cnt, sizeof(set8->pairs[0]), cmp_id);
> > +		}
> >  
> >  		pr_debug("sorting  addr %5lu: cnt %6d [%s]\n",
> > -			 (idx + 1) * sizeof(int), cnt, id->name);
> > -
> > -		qsort(base, cnt, id->is_set8 ? sizeof(uint64_t) : sizeof(int), cmp_id);
> > +			 (idx + 1) * sizeof(int), id->is_set ? set->cnt : set8->cnt, id->name);
> >  
> >  		next = rb_next(next);
> >  	}
> > diff --git a/tools/include/linux/btf_ids.h b/tools/include/linux/btf_ids.h
> > index 2f882d5cb30f..72535f00572f 100644
> > --- a/tools/include/linux/btf_ids.h
> > +++ b/tools/include/linux/btf_ids.h
> > @@ -8,6 +8,15 @@ struct btf_id_set {
> >  	u32 ids[];
> >  };
> >  
> > +struct btf_id_set8 {
> > +	u32 cnt;
> > +	u32 flags;
> > +	struct {
> > +		u32 id;
> > +		u32 flags;
> > +	} pairs[];
> > +};
> > +
> >  #ifdef CONFIG_DEBUG_INFO_BTF
> >  
> >  #include <linux/compiler.h> /* for __PASTE */
> > -- 
> > 2.43.0
> > 

