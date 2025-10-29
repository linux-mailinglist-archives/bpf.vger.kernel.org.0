Return-Path: <bpf+bounces-72848-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8881DC1CC8E
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 19:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C7EB3B4642
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 18:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738643559EB;
	Wed, 29 Oct 2025 18:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdQMf4Wg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676E82877F4
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 18:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761762748; cv=none; b=fFm4r9Iy22xrVOXuPMTKwhpeKmwDD6BTz7AfJBdGMgCnRIg/kYjyUCrWFxGtGw7J6N/klffPZIm5tsBb7S1b2KzujChN+EChNfb5xPmpyVAlGhD3d7re+R/Xr5lwkuSUkiHug08dtC7mKVFMPPxBWYUPIDra4Gg7jyR7oggOKO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761762748; c=relaxed/simple;
	bh=lVgP1YX6Ez8wdnWu7zeQ2AjHNaKQ+Qdt4ZqP5Qt6GG4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p5jdEA+2D6OBnMViXGAT3SkAWZNAKg6YWYxpXybpvwSrerAwSB6Yp6K83iTn9IoXxD7pPstznHrsvAXdqxZifhu9FshXkDUEKv6x9vug7M6onkKQUMe8cakvuLqH2e7jhE0zC9LVJWaCbisL0GbReJ6RKlG6Ls08I9zOASTJuNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZdQMf4Wg; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-33ba5d8f3bfso265197a91.3
        for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 11:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761762746; x=1762367546; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dEv8+xZLPsmLuII5IQyR1uNdWCsqRAkRwQ9iOGmOcVA=;
        b=ZdQMf4Wg9UmuVglMq/XbHm6LGJCkeuNBbtvbXhasEqoZsg4k2vuMJo2r2bdJyTvJD8
         SeiU7QY3vEg77CzASD4svrBa6Gflh4eSpCxzXl8GUkY4Sa2/O9P1bCXnIcnHre8hzzi9
         QKW4BjUKCIn+EHx32B7BBsONMPGEzMWtkpT3YcRuDr9MyXLV+OzgPjLJdZemYDl/FTlm
         dUmuaB5XFzl5/fjyqeb2ab0PwDUxl/At5oB7LNouyFpfII9XCS1KTpf3PxJPkBAFIvY+
         FFKkSFvux4Cd+tz0YnbSrXVUjIHAvbT6+HYvdCFySmuFDcTDGtrRsWd351uux4Lko5PU
         5fZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761762746; x=1762367546;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dEv8+xZLPsmLuII5IQyR1uNdWCsqRAkRwQ9iOGmOcVA=;
        b=MiMaOTpaDjMGDizEFc1mczUZfgD+j1qzIlIrClHEN7EXOvN9mICRqoQ8uNXEc+FAw9
         Ug8+wwD8f5xQMHMazmbhN8sYHBz9RZuBNdsh5Uf76DnlT57TCalkDkv7cCHctKli6r8s
         gpoQ5FPmC2U+JL7k3u1h7jg97qesU8DAR+WRTmJDMc6LWbBfADQWUlgBeVpuR97ROo/5
         8I9M8c0Am6PdT9wNjFufhH3XqfDQn/Cpgn6AIkIRdoiKkQ4g69gVvsQk+BBNdho5ADuN
         zZqAW8WdC1yNRWArwZTlf/gHsPBdi9zETYP8K1QsD965p5u9dD5h3VJlBx265v7So7n2
         DOMg==
X-Forwarded-Encrypted: i=1; AJvYcCXJbPIXwnwbCxEwpnSgA4NFvkTzojbbD3kHqc5wEgi8LoWuP8Z0bkO7Tn+VnbBYyld7ROw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/mwGDbqo1Qc9VG6OaKUVQA2ugmJ8f4hRta2f7apFQEc4JCSTc
	NT/nXiNXXF1WyPlu7V/W1wJzf03MW+yJVSlSUI+8rMyq6eG31e9DgbOU1lpGyPQpxtg=
X-Gm-Gg: ASbGncsygFuV1U/Ax9az+adI8VC0cjU0LdXNYCKV8vz/gEQ9JWgNjGsCtTTS+sZMbPP
	RbFPvFx1EqGCq3B+eoxzDXhJHuPagRBxSeViSdv0btihGhiVhJrnmKRQoro6JZE0XdKPQLcGtsW
	nUE+J+1cNCL9ZEFE+eTBedo2dMGwVo+Rurt7RMhv6yX0lAvda/1K4w6MVcbbr+8dejXct6Lp7JV
	ryre25DsDwZWsFm7xFJc96uRpcmpJetSpk+JNSfDEceniGCoxwve7f9Yirp7A+KDuH9efYiqDD4
	cO2Ci92jvydIlecVQKeJ/rwF/jC9kV7vYHhmgAPI/9HYFMbjR8XQXQFdMDH6uvCxWsWVKeeW8im
	S6SYDFT9wDd5ZSXlYsveVDFgHcXWEqGGgVq3jUgi45lJ4rJNJbLGGf6HG9inzoGezDT/yS1x9C2
	S7ooYpXLuZirJde2YjDliw5EODqINH2rVuVxH6
X-Google-Smtp-Source: AGHT+IHusyp4BYgA8wTsOwLuQa1kystXGyuNVWnK7/z+PepMhZu3/nRgJ4wcKSUKrnX4U8Pk42Kv6g==
X-Received: by 2002:a17:90b:514f:b0:32e:7c34:70cf with SMTP id 98e67ed59e1d1-3403a30364cmr4342371a91.36.1761762745474;
        Wed, 29 Oct 2025 11:32:25 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:3086:7e8a:8b32:fa24? ([2620:10d:c090:500::5:6b34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed835e26sm16297749a91.20.2025.10.29.11.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 11:32:25 -0700 (PDT)
Message-ID: <9bb6431321c4fb91602e5260ef0b5989ec6e1ee8.camel@gmail.com>
Subject: Re: [RFC dwarves 3/5] dwarf_loader: Collect inline expansion
 location information
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, dwarves@vger.kernel.org
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, 	acme@kernel.org, ttreyer@meta.com,
 yonghong.song@linux.dev, song@kernel.org, 	john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, 	jolsa@kernel.org,
 qmo@kernel.org, ihor.solodrai@linux.dev, david.faust@oracle.com, 
	jose.marchesi@oracle.com, bpf@vger.kernel.org
Date: Wed, 29 Oct 2025 11:32:22 -0700
In-Reply-To: <1a8cc336-f6e6-4908-aae1-ed3189219ec4@oracle.com>
References: <20251024073328.370457-1-alan.maguire@oracle.com>
	 <20251024073328.370457-4-alan.maguire@oracle.com>
	 <6558dc0590b174174321899af9981053db76845c.camel@gmail.com>
	 <1a8cc336-f6e6-4908-aae1-ed3189219ec4@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-29 at 17:40 +0000, Alan Maguire wrote:

[...]

> > > -/* For DW_AT_location 'attr':
> > > - * - if first location is DW_OP_regXX with expected number, return t=
he register;
> > > - *   otherwise save the register for later return
> > > - * - if location DW_OP_entry_value(DW_OP_regXX) with expected number=
 is in the
> > > - *   list, return the register; otherwise save register for later re=
turn
> > > - * - otherwise if no register was found for locations, return -1.
> > > +/* Retrieve location information for parameter; focus on simple loca=
tions
> > > + * like constants and register values.  Support multiple registers a=
s
> > > + * it is possible for a value (struct) to be passed via multiple reg=
isters.
> > > + * Handle edge cases like multiple instances of same location value,=
 but
> > > + * avoid cases with large (>1 size) expressions to keep things simpl=
e.
> > > + * This covers the vast majority of cases.  The only unhandled atom =
is
> > > + * DW_OP_GNU_parameter_ref; future work could add that and improve
> > > + * location handling.  In practice the below supports the majority
> > > + * of parameter locations.
> > >   */
> > > -static int parameter__reg(Dwarf_Attribute *attr, int expected_reg)
> > > +static int parameter__locs(Dwarf_Die *die, Dwarf_Attribute *attr, st=
ruct parameter *parm)
> > >  {
> > > -	Dwarf_Addr base, start, end;
> > > -	Dwarf_Op *expr, *entry_ops;
> > > -	Dwarf_Attribute entry_attr;
> > > -	size_t exprlen, entry_len;
> > > +	Dwarf_Addr base, start, end, first =3D -1;
> > > +	Dwarf_Attribute next_attr;
> > >  	ptrdiff_t offset =3D 0;
> > > -	int loc_num =3D -1;
> > > +	Dwarf_Op *expr;
> > > +	size_t exprlen;
> > >  	int ret =3D -1;
> > >
> > > +	/* parameter__locs() can be called recursively, but at toplevel
> > > +	 * die is non-NULL signalling we need to look up loc/const attrs.
> > > +	 */
> > > +	if (die) {
> > > +		if (dwarf_attr(die, DW_AT_const_value, attr) !=3D NULL) {
> > > +			parm->has_loc =3D 1;
> > > +			parm->optimized =3D 1;
> > > +			parm->locs[0].is_const =3D 1;
> > > +			parm->nlocs =3D 1;
> > > +			parm->locs[0].size =3D 8;
> > > +			parm->locs[0].value =3D attr_numeric(die, DW_AT_const_value);
> > > +			return 0;
> > > +		}
> > > +		if (dwarf_attr(die, DW_AT_location, attr) =3D=3D NULL)
> > > +			return 0;
> > > +	}
> > > +
> > >  	/* use libdw__lock as dwarf_getlocation(s) has concurrency issues
> > >  	 * when libdw is not compiled with experimental --enable-thread-saf=
ety
> > >  	 */
> > >  	pthread_mutex_lock(&libdw__lock);
> > >  	while ((offset =3D __dwarf_getlocations(attr, offset, &base, &start=
, &end, &expr, &exprlen)) > 0) {
> > > -		loc_num++;
> > > +		/* We only want location info referring to start of function;
> > > +		 * assumes we get location info in address order; empirically
> > > +		 * this is the case.  Only exception is DW_OP_*entry_value
> > > +		 * location info which always refers to the value on entry.
> > > +		 */
> > > +		if (first =3D=3D -1)
> >
> > <moving comments from github>
> >
> > Note: an alternative is to check that address range associated with
> > location corresponds to the starting address of the inline expansion,
> > e.g. like in [1]. I think it is a more correct approach.
> >
> > [1] https://github.com/eddyz87/inline-address-printer/blob/master/main.=
c#L184
> >
>
> thanks for this; I'll try tweaking it to work like this. The only thing
> I was worried about missing was DW_OP_entry_value exprs since they can I
> think be referred to from later location addresses within the function.

(I needed a few iterations to get the base address calculation right)

>
> > > +			first =3D start;
> > >
> > >  		/* Convert expression list (XX DW_OP_stack_value) -> (XX).
> > >  		 * DW_OP_stack_value instructs interpreter to pop current value fr=
om
> > > @@ -1216,33 +1241,154 @@ static int parameter__reg(Dwarf_Attribute *a=
ttr, int expected_reg)
> > >  		if (exprlen > 1 && expr[exprlen - 1].atom =3D=3D DW_OP_stack_value=
)
> > >  			exprlen--;
> > >
> > > -		if (exprlen !=3D 1)
> > > -			continue;
> > > +		if (exprlen > 1) {
> > > +			/* ignore complex exprs not at start of function,
> > > +			 * but bail if we hit a complex loc expr at the start.
> > > +			 */
> > > +			if (start !=3D first)
> > > +				continue;
> > > +			ret =3D -1;
> > > +			goto out;
> > > +		}
> > >
> > >  		switch (expr->atom) {
> > > -		/* match DW_OP_regXX at first location */
> > > +		case DW_OP_deref:
> > > +			if (parm->nlocs > 0)
> > > +				parm->locs[parm->nlocs - 1].is_deref =3D 1;
> > > +			else
> > > +				ret =3D -1;
> > > +			break;
> > >  		case DW_OP_reg0 ... DW_OP_reg31:
> > > -			if (loc_num !=3D 0)
> > > +			if (start !=3D first || parm->nlocs > 1)
> > > +				break;
> > > +			/* avoid duplicate location value */
> > > +			if (parm->nlocs > 0 && parm->locs[parm->nlocs - 1].reg =3D=3D
> > > +					       (expr->atom - DW_OP_reg0))
> > > +				break;
> > > +			parm->locs[parm->nlocs].reg =3D expr->atom - DW_OP_reg0;
> > > +			parm->locs[parm->nlocs].is_deref =3D 0;
> > > +			parm->locs[parm->nlocs].size =3D 8;
> > > +			parm->locs[parm->nlocs++].offset =3D 0;
> > > +			ret =3D 0;
> > > +			break;
> > > +		case DW_OP_fbreg:
> > > +		case DW_OP_breg0 ... DW_OP_breg31:
> > > +			if (start !=3D first || parm->nlocs > 1)
> > >  				break;
> > > -			ret =3D expr->atom;
> > > -			if (ret =3D=3D expected_reg)
> > > -				goto out;
> > > +			/* avoid duplicate location value */
> > > +			if (parm->nlocs > 0 && parm->locs[parm->nlocs - 1].reg =3D=3D
> > > +					       (expr->atom - DW_OP_breg0)) {
> > > +				if (parm->locs[parm->nlocs - 1].offset !=3D expr->offset)
> > > +					ret =3D -1;
> > > +				break;
> > > +			}
> > > +			parm->locs[parm->nlocs].reg =3D expr->atom - DW_OP_breg0;
> > > +			parm->locs[parm->nlocs].is_deref =3D 1;
> > > +			parm->locs[parm->nlocs].size =3D 8;
> > > +			parm->locs[parm->nlocs++].offset =3D expr->offset;
> >
> > I think this should be `expr->number`:
> >
>
> Hmm, I thought the bregN values signified register + offset
> dereferences? Or are you saying the offset is stored in expr->number?

The way I read docstrings in libdw.h:

  /* One operation in a DWARF location expression.
     A location expression is an array of these.  */
  typedef struct
  {
    uint8_t atom;                 /* Operation */
    Dwarf_Word number;            /* Operand */
    Dwarf_Word number2;           /* Possible second operand */
    Dwarf_Word offset;            /* Offset in location expression */
  } Dwarf_Op;

Is that `offset` is within location expression in DWARF, and is about
format bookkeeping, not the underlying program.

Double checking this with my tool, modified to print offsets:

./include/trace/events/initcall.h:trace_initcall_start                     =
       0xffffffff81257f15 rsp+8
  die 0x19a62 origin 0x195d1
    formal 'func'       location (breg7 0x8 (off 0x0))

Here is llvm-dwarfdump result:

0x00019a62:     DW_TAG_inlined_subroutine
                  DW_AT_abstract_origin (0x000195d1 "trace_initcall_start")
                  DW_AT_ranges  (indexed (0x22) rangelist =3D 0x000002ec
                     [0xffffffff81257f15, 0xffffffff81257f58)
                     [0xffffffff812580bb, 0xffffffff812580d5)
                     [0xffffffff812580f4, 0xffffffff8125817e))
                  DW_AT_call_file       ("/home/ezingerman/bpf-next/init/ma=
in.c")
                  DW_AT_call_line       (1282)
                  DW_AT_call_column     (2)

So these seem to agree.

