Return-Path: <bpf+bounces-72195-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4390FC09DF4
	for <lists+bpf@lfdr.de>; Sat, 25 Oct 2025 19:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C12913BE575
	for <lists+bpf@lfdr.de>; Sat, 25 Oct 2025 17:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF382F656F;
	Sat, 25 Oct 2025 17:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbBxC3H3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AE62F99BC
	for <bpf@vger.kernel.org>; Sat, 25 Oct 2025 17:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761413593; cv=none; b=PFfMpKAaJXGQpqZWJC7b6ehlOjBwoL630fMyWzPW6MvMLn4hPx/N47ZssYqXgpVuSoEhhol3LZCRRtDFeI9USE2lC9cW0DJ8cef0lCgtDZGOqjL6HOdnlGlD3Sd1+20dVyQkRNcTEm18NWmcOyGA4iLKIQzThW8SrTmxm/ZYTk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761413593; c=relaxed/simple;
	bh=O++OuxACJ9yOD/LcvpNM5q+keNyT34PLBznMpf+bS+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AO1I2feZjmE/kRZm9NePrtK563NEtbboHaDa2WUyeka/wwlR/ssYPq0Yf+/KoNxpadOd6fsmB+1+g0pjqiuInItl5gjoDH+SFrlbSbnDXDr8rFT7rBqiTDvKBAgB0/iCIssndz01J//fLMENM8jhlY+/BgSLKBYP/eQAsWHiJpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NbBxC3H3; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so18134425e9.0
        for <bpf@vger.kernel.org>; Sat, 25 Oct 2025 10:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761413589; x=1762018389; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hER1EO0Ammi3FMse7lNAFlgxjn728ejmaORrs3S7WBs=;
        b=NbBxC3H3pGIOTQqFZlKFZ19H+2G3//B/x06FzyFRcaFAlfGxUw0oaJrEqrfO9U/ZbD
         hrrdKWMrhQ4hbemXB28zz4yhJgX3N1pxSp3tsB6nS1EppTYP7NtnEARVZBGo4atD6s2+
         E3uFXmibhOaltQwWcya989n+U0iqbe2fYgZL9xEh8U6+U/NGunHx9iN8Ehv/oHl7CoaC
         qBw7jP49oWrz6pVpCOWa+vvM4Y8tRXQoQAlFMYyvuiISv+eCTeJBBzP1IADnNkfIRp5x
         RLaqpWHobrisSqQ7/rfD8H1N+5FDfaghnzQxLcFwNGfNfU4u4oWF9TVRMQHde/5Uoc1d
         r5Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761413589; x=1762018389;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hER1EO0Ammi3FMse7lNAFlgxjn728ejmaORrs3S7WBs=;
        b=PE/h+5HygIChkEHy85t7aQii0zX+IUuPjgLo0xSjpI+zfY7sbt5PuCkMUm83oM/VQg
         SRA/eVqxz+UbqwdKaUUjiJcyXqKzwRRq6gwhmajPtRr2knTSZ+wV/UlgR0X2MiJK8oLb
         pcJUeH3B/d3DA5LhxoaUdF9uIs9kN1NTO4e9NkWpnCsdU2f/oCOMNLVyBsuwrBmSLg8P
         MAW0qvzvL3IYtf+p7Y0h28gL2+fCrkBJKCdMevvCfKo0JIHOxlc8uPQz5lRiwNVQ1sik
         gjLQXeqglwd9++IU6RNafCNcfpZcTtaqBj4IjsJqwF7EN5mye0NJ7LxOj0KD1aM0DaUG
         FEoA==
X-Gm-Message-State: AOJu0YwP5Sa2a65iuKuNbuC2/vqjjbljVPs1mne1nQjvnTWR19oYGnEg
	fTyVqjorUsI7q9qcwvgCofYSRRatyHbVAQtOtHImQS2fSuCEXi2aLWEs
X-Gm-Gg: ASbGncvB0WKAG4elY+s8RtcCDjlOA/Pr0sJHCaa737Q/bbwqNWB1phq3WmkFC41MX8Q
	y5ar22BjdbFzQgzPr/Gb6id8KtYXtQ9kSumIi3jpDbo86boZlGf48jxLDMwTKxWNpH9qZE0oIjr
	renwb+1uNLbPU9XKAazFGnIRv/IhjhCaiFH0J1DzD7u7s9bM03judVYt1IAvn24/gfoC/jBSlhw
	gSstcXZlbjwr0NPgeWu8e5VpQQIGrKkz+9UvN/vV6ZnogauawjNwPqg0d4oNdtOfNxN3mU8FURt
	iECUqRldGoIJ3xOtTi7ltAt3KdxSLNKj6fGp97dAKc4p4Tnbnt2EBL965okQnyqGv/4TPE/0Wj8
	8OLOZLWlHYWOhdYwt1I9+fPgsPJNPIRyRKh3pdsLKbRpCYrug6QLEnBNVEFHs/ffhj6FAOivFN9
	nT1g/SzWzFB6z/Ml6et8OE
X-Google-Smtp-Source: AGHT+IFufwaAHYiZDrBApIK1QTGrXTbOit2IqfHIfKNPEyXzuIvh4CE07JI0Rod57yiXFMNIIcp/WQ==
X-Received: by 2002:a05:600c:a02:b0:46e:477a:f3dd with SMTP id 5b1f17b1804b1-475cb064926mr74063075e9.36.1761413589126;
        Sat, 25 Oct 2025 10:33:09 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952de5f9sm4757570f8f.38.2025.10.25.10.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 10:33:08 -0700 (PDT)
Date: Sat, 25 Oct 2025 17:39:51 +0000
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
Message-ID: <aP0LZxQU2ww0pRBQ@mail.gmail.com>
References: <20251019202145.3944697-1-a.s.protopopov@gmail.com>
 <20251019202145.3944697-15-a.s.protopopov@gmail.com>
 <10f8fe24770eb663ea849f133b4474d2cbd0b513.camel@gmail.com>
 <aPt2jVEBji43u+6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPt2jVEBji43u+6Q@mail.gmail.com>

On 25/10/24 12:52PM, Anton Protopopov wrote:
> On 25/10/21 03:18PM, Eduard Zingerman wrote:
> > On Sun, 2025-10-19 at 20:21 +0000, Anton Protopopov wrote:
> > 
> > [...]
> > 
> > > ---
> > >  tools/lib/bpf/libbpf.c        | 240 +++++++++++++++++++++++++++++++++-
> > >  tools/lib/bpf/libbpf_probes.c |   4 +
> > >  tools/lib/bpf/linker.c        |  10 +-
> > >  3 files changed, 251 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > index b90574f39d1c..ee44bc49a3ba 100644
> > > --- a/tools/lib/bpf/libbpf.c
> > > +++ b/tools/lib/bpf/libbpf.c
> > 
> > [...]
> > 
> > > +/*
> > > + * In LLVM the .jumptables section contains jump tables entries relative to the
> > > + * section start. The BPF kernel-side code expects jump table offsets relative
> > > + * to the beginning of the program (passed in bpf(BPF_PROG_LOAD)). This helper
> > > + * computes a delta to be added when creating a map.
> > > + */
> > > +static int jt_adjust_off(struct bpf_program *prog, int insn_idx)
> > > +{
> > > +	int i;
> > > +
> > > +	for (i = prog->subprog_cnt - 1; i >= 0; i--) {
> > > +		if (insn_idx >= prog->subprogs[i].sub_insn_off)
> > 
> > Sorry, I'm still confused about what happens here.
> > The `insn_idx` is comes from relocation, meaning that it is a value
> > recorded relative to section start, right?  On the other hand,
> > `.sub_insn_off` is an offset of a subprogram within a concatenated
> > program, about to be loaded.  These values should not be compared
> > directly.
> > 
> > I think, that my suggestion from v5 [1] should be easier to understand:
> 
> Well, if you insist :) (I saw the next e-mail as well, thanks.)
> 
> >    > Or rename this thing to find_subprog_idx(), pass relo object into
> >    > create_jt_map(), call find_subprog_idx() there, and do the following:
> >    >
> >    >   xlated_off = jt[i] / sizeof(struct bpf_insn);
> >    >   /* make xlated_off relative to subprogram start */
> >    >   xlated_off -= prog->subprogs[subprog_idx].sec_insn_off;
> >    >   /* make xlated_off relative to main subprogram start */
> >    >   xlated_off += prog->subprogs[subprog_idx].sub_insn_off;
> > 
> > [1] https://lore.kernel.org/bpf/b5fd31c3e703c8c84c6710f5536510fbce04b36f.camel@gmail.com/
> > 
> > > +			return prog->subprogs[i].sub_insn_off - prog->subprogs[i].sec_insn_off;
> > > +	}
> > > +
> > > +	return -prog->sec_insn_off;
> > > +}
> > > +
> > > +
> > >  /* Relocate data references within program code:
> > >   *  - map references;
> > >   *  - global variable references;
> > > @@ -6235,6 +6422,21 @@ bpf_object__relocate_data(struct bpf_object *obj, struct bpf_program *prog)
> > >  		case RELO_CORE:
> > >  			/* will be handled by bpf_program_record_relos() */
> > >  			break;
> > > +		case RELO_INSN_ARRAY: {
> > > +			int map_fd;
> > > +
> > > +			map_fd = create_jt_map(obj, prog, relo->sym_off, relo->sym_size,
> > > +					       jt_adjust_off(prog, relo->insn_idx));
> > > +			if (map_fd < 0) {
> > > +				pr_warn("prog '%s': relo #%d: can't create jump table: sym_off %u\n",
> > > +						prog->name, i, relo->sym_off);
> > > +				return map_fd;
> > > +			}
> > > +			insn[0].src_reg = BPF_PSEUDO_MAP_VALUE;
> > > +			insn->imm = map_fd;
> > > +			insn->off = 0;
> > > +		}
> > > +			break;
> > >  		default:
> > >  			pr_warn("prog '%s': relo #%d: bad relo type %d\n",
> > >  				prog->name, i, relo->type);
> > 
> > [...]
> > 
> > > @@ -9228,6 +9457,15 @@ void bpf_object__close(struct bpf_object *obj)
> > >  
> > >  	zfree(&obj->arena_data);
> > >  
> > > +	zfree(&obj->jumptables_data);
> > > +	obj->jumptables_data_sz = 0;
> > > +
> > > +	if (obj->jumptable_maps && obj->jumptable_map_cnt) {
> > 
> > Nit: outer 'if' seems unnecessary.
> 
> I suspect this was a check for if obj->jumptable_maps is null or not.
> I think this should never happen that jumptable_map_cnt && !jumptable_map,
> so I will remove the if.
> 
> > > +		for (i = 0; i < obj->jumptable_map_cnt; i++)
> > > +			close(obj->jumptable_maps[i].fd);
> > > +	}
> > > +	zfree(&obj->jumptable_maps);
> > > +
> > >  	free(obj);
> > >  }
> > 
> > [...]
> > 
> > > diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
> > > index 56ae77047bc3..3defd4bc9154 100644
> > > --- a/tools/lib/bpf/linker.c
> > > +++ b/tools/lib/bpf/linker.c
> > > @@ -27,6 +27,8 @@
> > >  #include "strset.h"
> > >  
> > >  #define BTF_EXTERN_SEC ".extern"
> > > +#define JUMPTABLES_SEC ".jumptables"
> > > +#define JUMPTABLES_REL_SEC ".rel.jumptables"
> > 
> > Nit: maybe avoid duplicating JUMPTABLES_SEC by moving all *_SEC macro
> >      to libbpf_internal.h?
> 
> Yes, ok.
> 
> > >  
> > >  struct src_sec {
> > >  	const char *sec_name;
> > > @@ -2025,6 +2027,9 @@ static int linker_append_elf_sym(struct bpf_linker *linker, struct src_obj *obj,
> > >  			obj->sym_map[src_sym_idx] = dst_sec->sec_sym_idx;
> > >  			return 0;
> > >  		}
> > > +
> > > +		if (strcmp(src_sec->sec_name, JUMPTABLES_SEC) == 0)
> > > +			goto add_sym;
> > >  	}
> > >  
> > >  	if (sym_bind == STB_LOCAL)
> > > @@ -2271,8 +2276,9 @@ static int linker_append_elf_relos(struct bpf_linker *linker, struct src_obj *ob
> > >  						insn->imm += sec->dst_off / sizeof(struct bpf_insn);
> > >  					else
> > >  						insn->imm += sec->dst_off;
> > > -				} else {
> > > -					pr_warn("relocation against STT_SECTION in non-exec section is not supported!\n");
> > > +				} else if (strcmp(src_sec->sec_name, JUMPTABLES_REL_SEC) != 0) {
> > > +					pr_warn("relocation against STT_SECTION in section %s is not supported!\n",
> > > +						src_sec->sec_name);
> > 
> > Sorry, I missed this on a previous iteration.
> > LLVM generates section relative offsets for jump table contents, so it
> > seems that relocations inside jump table section should not occur.
> > Is this a leftover, or am I confused?
> 
> I think this is a leftover in LLVM, so I have to keep it here.
> I will check again with the latest LLVM.

Yes, the latest LLVM I've built (llvmorg-22-init-12400-g09eea2256e53)
does generate it:

    $ llvm-readelf -S bpf_gotox.bpf.o | grep jumptables
      [ 8] .jumptables       PROGBITS        ...
      [ 9] .rel.jumptables   REL             ...

> > >  					return -EINVAL;
> > >  				}
> > >  			}

