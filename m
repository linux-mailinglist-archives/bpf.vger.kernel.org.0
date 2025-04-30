Return-Path: <bpf+bounces-57064-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0048EAA5139
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 18:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D45F16EBA0
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 16:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99912620C1;
	Wed, 30 Apr 2025 16:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3s7TY+2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC5D261588
	for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 16:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746029438; cv=none; b=XV5nw/BiNmQHRtXmlQOe0W/RvDUavAmzNRR00lzQNJArw5GCaC4pnLNehxpW1mbGlml99xUo2ELJmYbRoUB5YL4x4EMfGmYK9YOUZjKQ1c+rJOb6YrAL9zprMtvog6Gr/etEUGfB25lLRGmDCaeJbdIjjAxFXugGcMPVNnQEjxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746029438; c=relaxed/simple;
	bh=/B+Cp3M6o5U+poAsK2bqS+4uXhqhLx1iKik7G71EAOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S3sIhDsEXPjAr+fs30uMq0Cwy7TZRYshxUQNj5chLqYYWjqopTjr8dB5heQyON4UTWCYUc0m2gwVnfdqulQq3OmYB1CthS9Le0N7dqi2odw5cu7dVgCPw/poKBFH0e58IJc0TDhD0TjGYam7vBjHzLsUf24evfGxEDZkkbdmiHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y3s7TY+2; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5f6214f189bso68018a12.2
        for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 09:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746029434; x=1746634234; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yQFiNZCxV/6Ha9HzfgOvrcN687pnMHvrt99bjBy3bQc=;
        b=Y3s7TY+2UQ7cIyVkUOJpLut76t3wMBiVl2AWE87FlKfPJb0x6Mnh0R8AgpYMeAC6Ub
         OMQPtYba7H//gKGv5lEnZZrnSRY86TeJ7C/svyYjvXpbJvNV9/roTb5sayjQHIP7unFo
         eCaBNj+RKglLRMJ7ElJKFRN81P2qAKD8M9Q6JOHxclxSv6eC3pnfmxqF267E0sjIoGc5
         lGb7sPev+h78r9O9cFqnPW23e2uVF7pDuiiRtVtdC99zZaCk9MdH8QPbcwv16NTJ4Ny4
         PlcnfSm0hrLoysHETNKDRpP7yHjxezxBpJhVqh3TWTD4GEQO330bhWvgPeISoS2JmKs3
         eq+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746029434; x=1746634234;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yQFiNZCxV/6Ha9HzfgOvrcN687pnMHvrt99bjBy3bQc=;
        b=gvjmKja3CZDKnpm7V9WjC+GovtkntzXx3s2W+183858NtNa9jJzGqdn7gQ9iSNluZ3
         25csCcb2aqRRXyZpxLYQdJhvf2ziEy80H0gxwLuLd+kwPB830zszKerYPRBdxw6ueLJR
         fRitz0cvcla6hLPvUSzhlXaPi6qQy9z67KCfE2z6iHcgRyhpiTgnhToQxWjHYMZ90h51
         V9da+FitiyTiglnrBmBxnDaxkX+myoQK18NG3qX9BgzcvY1nj4vZVkMjFVMd9n6qkDl3
         FMPZZj4spd6PfknKjFMmX3q4RbU9InNcpRT06kPlzI34w49G7VIc43teZscKJol4/9om
         Nj6Q==
X-Gm-Message-State: AOJu0Yw4T74+TScIYyg0PvODVYKjWazZQRN0ufA54zf5Ix1PXjc/wGMy
	nrhnpbFCIRqJLoq8BhqgbMTAE7xRSRgbLErc3IhqOBD/P9NMyytVqpGq7Q==
X-Gm-Gg: ASbGnctNz2U8b7kL0hugHeQJM3nEYfQ5A+gP9u2JeWkH604A/dQ3+tQSUAfnjoEu4Y1
	U4VfdoG6+0vWfRXl+af/K/6EmHvYc8QmavL5uLHVH7rxIIvr0Af0e3B2bu3TORJ3o0hpKEQ2vA5
	/rFi1lQ4b9B6e3/uwzSSzT93pTm2ykwTnlQ6c+pzjvMYETDIUc8eaidLtJ7w+mipnILlJ89tAip
	ZhmeHHXbU7kcz6d4nyUIA/88IlSkIH46eXc6rl3RZuABL2vaC19HvNCQRdaC6Tr+escbNlVETJ5
	1IPyadqCXa8OtZrUc4NSg2LmJzkGid4uGSs7b56eY3N7F3c3dRs=
X-Google-Smtp-Source: AGHT+IHVhWj49s1H0QVjE3uF4vREN8R//rqh5eazspQN0oqqNI1n2Hz+eSZS4GSdFVNY9rMjy11pXg==
X-Received: by 2002:a17:907:7da8:b0:acb:ac30:61f2 with SMTP id a640c23a62f3a-acedc5f047fmr411690366b.18.1746029433508;
        Wed, 30 Apr 2025 09:10:33 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6ecf782bsm955412266b.107.2025.04.30.09.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 09:10:33 -0700 (PDT)
Date: Wed, 30 Apr 2025 16:15:19 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH v1 bpf] libbpf: use proper errno value in linker
Message-ID: <aBJMl3waT68OcKYq@mail.gmail.com>
References: <20250430120820.2262053-1-a.s.protopopov@gmail.com>
 <CAEf4BzYmNyBS-xofAagQ6diVkSEn3iT46kcRrBSM-_14fAmgzg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYmNyBS-xofAagQ6diVkSEn3iT46kcRrBSM-_14fAmgzg@mail.gmail.com>

On 25/04/30 09:05AM, Andrii Nakryiko wrote:
> On Wed, Apr 30, 2025 at 5:03 AM Anton Protopopov
> <a.s.protopopov@gmail.com> wrote:
> >
> > Return values of the linker_append_sec_data() and the
> > linker_append_elf_relos() functions are propagated all the
> > way up to users of libbpf API. In some error cases these
> > functions return -1 which will be seen as -EPERM from user's
> > point of view. Instead, return a more reasonable -EINVAL.
> >
> > Fixes: faf6ed321cf6 ("libbpf: Add BPF static linker APIs")
> > Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> > ---
> >  tools/lib/bpf/linker.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
> > index 56f5068e2eba..a469e5d4fee7 100644
> > --- a/tools/lib/bpf/linker.c
> > +++ b/tools/lib/bpf/linker.c
> > @@ -1376,7 +1376,7 @@ static int linker_append_sec_data(struct bpf_linker *linker, struct src_obj *obj
> >                 } else {
> >                         if (!secs_match(dst_sec, src_sec)) {
> >                                 pr_warn("ELF sections %s are incompatible\n", src_sec->sec_name);
> > -                               return -1;
> > +                               return -EINVAL;
> >                         }
> >
> >                         /* "license" and "version" sections are deduped */
> > @@ -2223,7 +2223,7 @@ static int linker_append_elf_relos(struct bpf_linker *linker, struct src_obj *ob
> >                         }
> >                 } else if (!secs_match(dst_sec, src_sec)) {
> >                         pr_warn("sections %s are not compatible\n", src_sec->sec_name);
> > -                       return -1;
> > +                       return -EINVAL;
> 
> doh, not sure how that slipped through, thanks for the fix! I applied
> it to bpf-next.

At least, not bool or so :) I've found it, because I was copy/pasting this
particular piece of code.

> BTW, if you would be so kind, I think we have a similar issue with
> validate_nla() in nlattr.c, where -1 can be eventually returned as
> user-visible error code, it would be nice to fix this up like you did
> with linker APIs, thanks!

Ok, sure, I will take a look.

> 
> >                 }
> >
> >                 /* shdr->sh_link points to SYMTAB */
> > --
> > 2.34.1
> >

