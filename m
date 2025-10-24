Return-Path: <bpf+bounces-72089-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 570E6C064E1
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 14:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 120D13BE08C
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 12:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3582330E0C5;
	Fri, 24 Oct 2025 12:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGZYVclc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021211C701F
	for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 12:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761309951; cv=none; b=SsB3QxcF6JNt36xzPjZbGSR2m505LzqadvKht93h8oNqgee7m24vykFjsnzmIDCqn56Itv7uCwvRDHo7xPuQNUzOeu3MUiS8AOaQmDb92xAt2NX6iaij6FVa39m9qSQEnWqfDXRC99aoAftRsi82FZ+hx05p88T1pAXo0Iz2vCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761309951; c=relaxed/simple;
	bh=1dnf+DhQkjoQBs98zzIs+s6upHw+Bspf/ZC1tk5nF7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rtm/xQJlymVfO47gkRdW7bkZfHxf74KYgiRi3d9cflWNGMK09NrKvFUuBWULTtHaRRH7GyjCby3Nbj7a0qCoDMhCQs5tJn0guOazrxDn65hUYWTcrCRhC5fpRfrOIRSNIBpx/Gu27Ry3UWikEdbycF15DfvDCGlGrK3oOTSDcJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dGZYVclc; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47112a73785so13215225e9.3
        for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 05:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761309948; x=1761914748; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cWzv5eYtg1GAMmNHDy5CtMwKkGkAdN/y5k6ZJlsYyvU=;
        b=dGZYVclcLqPS2dTc0E54U3pRsZlT9jcg5fXLzpOVOprdd6aHtReDp9C5M/my9XgxrF
         /GesFvx1MoTa8N8WQD8k9wT4yLIPOlis+DbQOChPLrYTXRuk9ceevkA5rdfrDSLnDLKj
         dVh4ROOzG794G7jFYEAQezJ687pWA41+Y3/X66DWeidnzcjWHnx0qJr6nFjgqgS4x0X7
         vCpHe9f7kLm4+w7RMLuJrkWlI0+lPOdm7+699ujkkv0CUMAgiLi0eVDheNV310ufqR1h
         +8Do9vGy5DJmSByNaS6/JlYpJw02VthzQAq+zvQColVXAJzMud8W3ZX0AHeBiYO2vTda
         RSEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761309948; x=1761914748;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cWzv5eYtg1GAMmNHDy5CtMwKkGkAdN/y5k6ZJlsYyvU=;
        b=Grmcpiov4bC9eqyj7yI/QZuVEzs7gq/Mab3A/CTQ5jVn10Tgt3RIB7Z4toQ84jBntH
         z3hmFauvDEQSivJFU7VHGKXenMW2Y+bFrJhAgymaGuEGDozCqfY+3bRUYE25vgMHQoJm
         yfmrTwbAJtUBgC/Rt9sdi871dAR86J06c/P65iv6VQyvf/xI6dxBQEfkoAhmGAzOSPjx
         6iikygMmP60US8YpgVomOZ2tme2kmJBVHA5IAXB2duPwZJdmJcAoi8ZlwU5AVgr09bMN
         J/QMYNbURBtdzEKIpmMDt87T7ZYbBIAdG9FrFvOpliQ8imoB+lLGoKEfRW9U851fZbPy
         sA/Q==
X-Gm-Message-State: AOJu0YwRSfs9quySsIJB+pWSSErq8ye/n3KdsSzZw6PQ0BmD4gokH+71
	TJJq2Vl5t88SHUp0sSslazkWXAyt8UfCPZS+A5bX8cHvAhRcF9xPdjjP
X-Gm-Gg: ASbGnctJ/oVce0FNbVQbSPA3QTXcqv82T35dLOOHFAu7/rVZBgGHjtjNvbqZzW9zEmF
	AZ2a9U6WHtV7F6V6AJkXSYSMIbYdwoL4rZ0nDRCZCjGWb8ewlVTEzKV3rm2C8e1m42o5jXwg3el
	811Z4DIB6A8Nflk3u0eOGVaOmfH88oTz2Y8EwjhekqbhZJl4x88ws62KI17VU4YSAqPQeKLMC4V
	ilReq9atVxVIc3R+iydmIYp7OvRtIrUF9hvliRMGihoDikUTzmtyWkct1zryzeXcHk7/IyniXuF
	00tFLrt59QGQqwKTi2CC5uyCwEhA/CxhogJXOJ5gWasT6HoEdVvyxFLZ+Y+DGdacxEh54YASzO5
	6BPcJmGI92q9vRnb6BxNAymzjhHE6wvusWypbgtFoqyMZCa0ugTHys10PjKufufd79hF/05xHqY
	yzTA7kUjQonA==
X-Google-Smtp-Source: AGHT+IE+7hYRBEMEn7jQHng/PduGDRxQVXE5pmf51W21z9Wy800HkN7ZMXk45qg2PZz4sFlwGtrh+g==
X-Received: by 2002:a05:600c:1d9b:b0:45d:d353:a491 with SMTP id 5b1f17b1804b1-47117875e7amr177547875e9.1.1761309948147;
        Fri, 24 Oct 2025 05:45:48 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c4369b5esm173638645e9.15.2025.10.24.05.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 05:45:47 -0700 (PDT)
Date: Fri, 24 Oct 2025 12:52:29 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v6 bpf-next 14/17] libbpf: support llvm-generated
 indirect jumps
Message-ID: <aPt2jVEBji43u+6Q@mail.gmail.com>
References: <20251019202145.3944697-1-a.s.protopopov@gmail.com>
 <20251019202145.3944697-15-a.s.protopopov@gmail.com>
 <10f8fe24770eb663ea849f133b4474d2cbd0b513.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10f8fe24770eb663ea849f133b4474d2cbd0b513.camel@gmail.com>

On 25/10/21 03:18PM, Eduard Zingerman wrote:
> On Sun, 2025-10-19 at 20:21 +0000, Anton Protopopov wrote:
> 
> [...]
> 
> > ---
> >  tools/lib/bpf/libbpf.c        | 240 +++++++++++++++++++++++++++++++++-
> >  tools/lib/bpf/libbpf_probes.c |   4 +
> >  tools/lib/bpf/linker.c        |  10 +-
> >  3 files changed, 251 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index b90574f39d1c..ee44bc49a3ba 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> 
> [...]
> 
> > +/*
> > + * In LLVM the .jumptables section contains jump tables entries relative to the
> > + * section start. The BPF kernel-side code expects jump table offsets relative
> > + * to the beginning of the program (passed in bpf(BPF_PROG_LOAD)). This helper
> > + * computes a delta to be added when creating a map.
> > + */
> > +static int jt_adjust_off(struct bpf_program *prog, int insn_idx)
> > +{
> > +	int i;
> > +
> > +	for (i = prog->subprog_cnt - 1; i >= 0; i--) {
> > +		if (insn_idx >= prog->subprogs[i].sub_insn_off)
> 
> Sorry, I'm still confused about what happens here.
> The `insn_idx` is comes from relocation, meaning that it is a value
> recorded relative to section start, right?  On the other hand,
> `.sub_insn_off` is an offset of a subprogram within a concatenated
> program, about to be loaded.  These values should not be compared
> directly.
> 
> I think, that my suggestion from v5 [1] should be easier to understand:

Well, if you insist :) (I saw the next e-mail as well, thanks.)

>    > Or rename this thing to find_subprog_idx(), pass relo object into
>    > create_jt_map(), call find_subprog_idx() there, and do the following:
>    >
>    >   xlated_off = jt[i] / sizeof(struct bpf_insn);
>    >   /* make xlated_off relative to subprogram start */
>    >   xlated_off -= prog->subprogs[subprog_idx].sec_insn_off;
>    >   /* make xlated_off relative to main subprogram start */
>    >   xlated_off += prog->subprogs[subprog_idx].sub_insn_off;
> 
> [1] https://lore.kernel.org/bpf/b5fd31c3e703c8c84c6710f5536510fbce04b36f.camel@gmail.com/
> 
> > +			return prog->subprogs[i].sub_insn_off - prog->subprogs[i].sec_insn_off;
> > +	}
> > +
> > +	return -prog->sec_insn_off;
> > +}
> > +
> > +
> >  /* Relocate data references within program code:
> >   *  - map references;
> >   *  - global variable references;
> > @@ -6235,6 +6422,21 @@ bpf_object__relocate_data(struct bpf_object *obj, struct bpf_program *prog)
> >  		case RELO_CORE:
> >  			/* will be handled by bpf_program_record_relos() */
> >  			break;
> > +		case RELO_INSN_ARRAY: {
> > +			int map_fd;
> > +
> > +			map_fd = create_jt_map(obj, prog, relo->sym_off, relo->sym_size,
> > +					       jt_adjust_off(prog, relo->insn_idx));
> > +			if (map_fd < 0) {
> > +				pr_warn("prog '%s': relo #%d: can't create jump table: sym_off %u\n",
> > +						prog->name, i, relo->sym_off);
> > +				return map_fd;
> > +			}
> > +			insn[0].src_reg = BPF_PSEUDO_MAP_VALUE;
> > +			insn->imm = map_fd;
> > +			insn->off = 0;
> > +		}
> > +			break;
> >  		default:
> >  			pr_warn("prog '%s': relo #%d: bad relo type %d\n",
> >  				prog->name, i, relo->type);
> 
> [...]
> 
> > @@ -9228,6 +9457,15 @@ void bpf_object__close(struct bpf_object *obj)
> >  
> >  	zfree(&obj->arena_data);
> >  
> > +	zfree(&obj->jumptables_data);
> > +	obj->jumptables_data_sz = 0;
> > +
> > +	if (obj->jumptable_maps && obj->jumptable_map_cnt) {
> 
> Nit: outer 'if' seems unnecessary.

I suspect this was a check for if obj->jumptable_maps is null or not.
I think this should never happen that jumptable_map_cnt && !jumptable_map,
so I will remove the if.

> > +		for (i = 0; i < obj->jumptable_map_cnt; i++)
> > +			close(obj->jumptable_maps[i].fd);
> > +	}
> > +	zfree(&obj->jumptable_maps);
> > +
> >  	free(obj);
> >  }
> 
> [...]
> 
> > diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
> > index 56ae77047bc3..3defd4bc9154 100644
> > --- a/tools/lib/bpf/linker.c
> > +++ b/tools/lib/bpf/linker.c
> > @@ -27,6 +27,8 @@
> >  #include "strset.h"
> >  
> >  #define BTF_EXTERN_SEC ".extern"
> > +#define JUMPTABLES_SEC ".jumptables"
> > +#define JUMPTABLES_REL_SEC ".rel.jumptables"
> 
> Nit: maybe avoid duplicating JUMPTABLES_SEC by moving all *_SEC macro
>      to libbpf_internal.h?

Yes, ok.

> >  
> >  struct src_sec {
> >  	const char *sec_name;
> > @@ -2025,6 +2027,9 @@ static int linker_append_elf_sym(struct bpf_linker *linker, struct src_obj *obj,
> >  			obj->sym_map[src_sym_idx] = dst_sec->sec_sym_idx;
> >  			return 0;
> >  		}
> > +
> > +		if (strcmp(src_sec->sec_name, JUMPTABLES_SEC) == 0)
> > +			goto add_sym;
> >  	}
> >  
> >  	if (sym_bind == STB_LOCAL)
> > @@ -2271,8 +2276,9 @@ static int linker_append_elf_relos(struct bpf_linker *linker, struct src_obj *ob
> >  						insn->imm += sec->dst_off / sizeof(struct bpf_insn);
> >  					else
> >  						insn->imm += sec->dst_off;
> > -				} else {
> > -					pr_warn("relocation against STT_SECTION in non-exec section is not supported!\n");
> > +				} else if (strcmp(src_sec->sec_name, JUMPTABLES_REL_SEC) != 0) {
> > +					pr_warn("relocation against STT_SECTION in section %s is not supported!\n",
> > +						src_sec->sec_name);
> 
> Sorry, I missed this on a previous iteration.
> LLVM generates section relative offsets for jump table contents, so it
> seems that relocations inside jump table section should not occur.
> Is this a leftover, or am I confused?

I think this is a leftover in LLVM, so I have to keep it here.
I will check again with the latest LLVM.

> >  					return -EINVAL;
> >  				}
> >  			}

