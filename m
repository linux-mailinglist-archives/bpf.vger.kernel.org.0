Return-Path: <bpf+bounces-70292-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 12326BB6511
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 11:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6B66E344D06
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 09:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869D9286421;
	Fri,  3 Oct 2025 09:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfPbG431"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C243723D7FA
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 09:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759482431; cv=none; b=JCzXViZifHd6JPfczJhl+2TrM1k/S/AHxl54X+05Ss8D749FXCvWJCaCIjhkM0mZikKIVOkiuyEWAquUha9FZ6VthDIyklFxBxjA5BmVEGpuPVdF8CLr3BMy0SBOq6r3Ed1Dmnqt124+q2bVnTgUAymr7Kqy7GRgDFnQDicX52c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759482431; c=relaxed/simple;
	bh=g5Tay/CnkS6AWl+OqttcXZKo66UvTCuEYyx83hopf5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NwgU6yc4gWj5sO3UlyNXXeR6EIaNbdJCVIArUMwWsIAdDZCGFPw91fT3Z0eKWRLIWUlKUz7T9FDEPgwORg4UzoBcAwbD60Yfhd9oEN5LdoI9TL5t1RngkaKrIqC1vXM+SM2eVycoJHRjJynFbR/14FxBRh33qAcWsXcQyFJuCRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mfPbG431; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-46e3af7889fso11681235e9.2
        for <bpf@vger.kernel.org>; Fri, 03 Oct 2025 02:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759482427; x=1760087227; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gtqGEa0XKUsMkiVpuHfuc6WZIhxj0JVFF25GPHBS80k=;
        b=mfPbG43157PYE7BvuKE2iJG4kxQp1GBNXBajIKi6b+WM8GmcQukHljGZGzgw/Gm0HD
         C4MSmpr0j0gHvYEBx9nBoIs2SmP4eibDaD8ZlDRBusCFya0//CCRraterqS6erEJ6tJL
         G4JBQ4kO3l3yebn+7FIEQRvgxUWN5q6jPORtU9f+Mw8Kr0G9Eot0VQyGJyDybsBc1CCS
         RVnwA+B6vh54YnHfPA5BC67sM7/2p3qf7otFOUozEgMvJOjC4FwLFACZPIsGiyL5OAdy
         R3yYfrwuIEb1/oRjmgq6x+9cp2tCyRoBBCsKOJM2Pt4btBitWfX5DtUpcJ9L7GNuqDku
         dSSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759482427; x=1760087227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gtqGEa0XKUsMkiVpuHfuc6WZIhxj0JVFF25GPHBS80k=;
        b=enCnItFFD5+wmwUot2LD93guP4hR0P2UaKERgOoWL44c+qmzXLxHn90evKgjvui/jw
         OMlNl6MzBeF/fTtB6XoJRliW1DAE7bvtJ469SgAVTVN3fdbCU70lMBa6eDBSg4AiQ9MK
         xgRWN6EL3op7ZJ7cUM3R4wz5L72SO+D2YCssp5KbSYfJYp9+BZl2F2Sc9hlmaJYsc72b
         Lz3oeTUYHB8jCLdO1pCDzhQAxM4yXqjldilysAzByoW18yYnJqYc5jfn0m5BiXiTDDuf
         LnWa0fFXec5dfWx4E7hVVVQMVnSzA3b8V84voxP16dK7zWxbL0zhf7No1WTYnSkzZ9Pt
         4yew==
X-Gm-Message-State: AOJu0Yz45IAxFHwatmVhDlVLtUq/vmP9NAjx3I7QandZBqsVPR23uxhN
	whPbJo3e69Bdw/QDmh9ssaGrsuOJuEMkKGlcDyz4Ks3J9PbOQN8T1WYn
X-Gm-Gg: ASbGnctZYIXg1O6r0dkxSyrOAIn1PPwlZGRk8qcmapsvNmPFlDzLxjuxcmgBTsUSKzo
	znEKDL5YQ64HHrsXqD0yiz1eWO9VHiS9ldq0QH8QyiPt5KxhrXyJNITP+m0/NL7GzxDNAtHVlkh
	FOYhPN1XgX7M08qyVN0OLHIYUs9c94mhW/lSF8/tirJ7mN9lFdnmIElsUNmtLyZ8Rbs6CZRxOiB
	l4LlPh/tbug11m45Ae3kxUmLPcCp7U7NNBRKCcZkqv4DzqQx+X83JH35WK8URU1oOQXC9aE1El2
	5Ib0b786wUd6ckNRqVuVzCCs3NKLgYMHIJ/OzgBivIUOTy7Pg9d2PuZoHWdc/AytDn+P25WVaWm
	phsZfQ28zu6PLTImAdUinPG2Ef2e5E/g3v7bHq0BSJfOTJ3a2gPc4ffAw
X-Google-Smtp-Source: AGHT+IHLSStKavY4pwQp0ZOJoyA4qygQ+/rB/V5NwziIvxEgTkAM72XL+mDlYSYTgKDQvc/qr95EZg==
X-Received: by 2002:a05:600c:540c:b0:458:c094:8ba5 with SMTP id 5b1f17b1804b1-46e71124468mr17047195e9.12.1759482426873;
        Fri, 03 Oct 2025 02:07:06 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8ab909sm6990632f8f.19.2025.10.03.02.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 02:07:06 -0700 (PDT)
Date: Fri, 3 Oct 2025 09:13:25 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v5 bpf-next 04/15] bpf, x86: add new map type:
 instructions array
Message-ID: <aN+TtaajMJ9uPgN3@mail.gmail.com>
References: <20250930125111.1269861-1-a.s.protopopov@gmail.com>
 <20250930125111.1269861-5-a.s.protopopov@gmail.com>
 <7f2e28c4cee292fb6eb5785830d5e572b7bd59c2.camel@gmail.com>
 <aN99rP7iS2O0kJMN@mail.gmail.com>
 <83421daaf2db3319b12ab95bc5406b4d5fc7c076.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83421daaf2db3319b12ab95bc5406b4d5fc7c076.camel@gmail.com>

On 25/10/03 01:48AM, Eduard Zingerman wrote:
> On Fri, 2025-10-03 at 07:39 +0000, Anton Protopopov wrote:
> > On 25/10/02 05:50PM, Eduard Zingerman wrote:
> > > On Tue, 2025-09-30 at 12:51 +0000, Anton Protopopov wrote:
> > >
> > > Overall I think this patch is fine.
> > > We discussed this some time ago, but I can't find the previous discussion:
> > > would it be possible to make this map element a tuple of three elements
> > > (orig_off, xlated_off, jitted_off)?
> > > Visible to user as well.
> >
> > See https://lore.kernel.org/bpf/8ff2059d38afbd49eccb4bb3fd5ba741fefc5b57.camel@gmail.com/
> >
> > In short, this will make the map element to be of different size
> > from userspace and kernel (BPF) perspective.
> 
> But why does map element size has to be different between kernel and user?
> For internal use there is an `ips` array and that has to be 64-bit.
> For external use, it appears that any structure can be used.
> I probably don't understand something.

I think that map->value_size is expected to be  between
user space and kernel code (verifier). For this map we
use PTR_TO_MAP_VALUE, etc.

But before diving deeper into this topic, what is missing, really?
The orig->xlated mapping is easy to keep from userspace, if needed,
why is this not sufficient?

> > (Userspace can build the orig_off -> xlated_off mapping easily, if needed,
> > just keep a copy of the map before the load.)
> 
> [...]
> 
> > > > +#define MAX_INSN_ARRAY_ENTRIES 256
> > >
> > > Hm, did not notice this before.  We probably need an option limiting
> > > max number of jump table alternatives.
> 
> (I meant LLVM option, but you probably inferred)
> 
> > >
> > > Yonghong, wdyt?
> >
> > This one comes from the fact I've mentioned in the other place: need
> > to optimize the lookup from jit (not it is brute force). Then this
> > limitation will go away.
> >
> > But also curious, what LLVM thinks about this. Will it,
> > theoretically, create say 65K tables or so?
> 
> This generates a 4K jump table for me:
> 
>   $ cat gen-foo.py
>   import random as r
> 
>   print('int foo(int i) {')
>   print('  switch(i) {')
>   for c in r.sample(range(0, 4096), 1024):
>       print(f'  case {c}: return {r.randint(-10000, 10000)};')
>   print('  }')
>   print('  return 0;')
>   print('}')
> 
>   $ python3 gen-foo.py | clang -xc -O2 -S -o - - | grep '.quad' | wc -l
>   4093

Thanks for the example.

> [...]
> 
> > > > +void bpf_prog_update_insn_ptr(struct bpf_prog *prog,
> > > > +			      u32 xlated_off,
> > > > +			      u32 jitted_off,
> > > > +			      void *jitted_ip)
> > > > +{
> > > > +	struct bpf_insn_array *insn_array;
> > > > +	struct bpf_map *map;
> > > > +	int i, j;
> > > > +
> > > > +	for (i = 0; i < prog->aux->used_map_cnt; i++) {
> > > > +		map = prog->aux->used_maps[i];
> > > > +		if (!is_insn_array(map))
> > > > +			continue;
> > > > +
> > > > +		insn_array = cast_insn_array(map);
> > > > +		for (j = 0; j < map->max_entries; j++) {
> > > > +			if (insn_array->ptrs[j].user_value.xlated_off == xlated_off) {
> > >
> > > If this would check for `insn_array->ptrs[j].orig_xlated_off == xlated_off`
> > > there would be no need in `user_value.xlated_off = orig_xlated_off`
> > > in the `bpf_insn_array_init()`, right?
> >
> > The copy of the original offset is kept inside the map for the
> > following reason.  When the map is first loaded, it is frozen. Thus
> > user can't update it anymore.  During load some of xlated_off are
> > changed (together with program code). If the program load fails, it
> > is common to reload it with a log buffer. If map was changed, it now
> > will point to incorrect instructions. So in this case the map should
> > be seen as the original one, and the orig_xlated_off is used to reset
> > it.
> 
> Missed this part:
> 
> > 'If map was changed, it now will point to incorrect instructions.'
> 
> Makes sense, thank you for explaining.
> 
> [...]

