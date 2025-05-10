Return-Path: <bpf+bounces-57983-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E288AB24F0
	for <lists+bpf@lfdr.de>; Sat, 10 May 2025 20:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF4C51BA0513
	for <lists+bpf@lfdr.de>; Sat, 10 May 2025 18:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8560D2750ED;
	Sat, 10 May 2025 18:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0sAH1Xr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFC819F419
	for <bpf@vger.kernel.org>; Sat, 10 May 2025 18:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746901433; cv=none; b=DA/lpjSSewi+vB2LxQz7osnEQpZCcrdWYRM07ysDo7K4YyiTyJLont+6EgmYaF8XMxjPH6w6fARZ2nyW93Btxb1w8wKTmrxrg9jzUspvb/CrNDS05uPjbU6UU3x9aifEzpakRhOfIm6oHfkr6dUHPSKXMooGwQ5pSguGRblObPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746901433; c=relaxed/simple;
	bh=XLesCVB6GTqITLPdw/kqrwTA9yIidiXmTz5dGqwoPwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1AGSATF82NWnIA6Q416WzIM9xT9RYAthE7IBgEMuvmFee5iYTVExHLbPsiZ5CeEV8OtEWUHpYGWS5gljGz4Mi2VpEo/tTVZhdg0eqly5pHtKTIJsn0KuCTFcHXiDzyvGuBBTjARu8sUYIrkZoTBoBDc4bC1bxMczOlgiRTlkXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c0sAH1Xr; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5fbf29d0ff1so4872922a12.0
        for <bpf@vger.kernel.org>; Sat, 10 May 2025 11:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746901429; x=1747506229; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EfoyEEer3zPvT8SIq2qSt5fxalLDGHJYs7P7w51urLU=;
        b=c0sAH1XruY6Ot0K20HZRPSq/piCYDFZbvwJfZhV9CjrWn4GtzG2M1lBdW1R0OKbXCe
         TCsp5bpANW+UZj+qRSZGEvx4lPd/h3YdVYfBCywP2FJsYjd2d+H+ya0g2+IQ+i6qlkVt
         FgvFoniqZldLxl/+ZDRAHkocmuZIRJiy1dnI+D3GvXc9inDGLdGJeyZ/upcXqdfABtyW
         NNgp3iNpm6org5l5PUglh/xCdCDuOeo9pJEl+2pf3bISLvMuESRiaW/JdBHpF3sY5sy/
         IolfGbazgpO7k5SJlIiyrUdil3XBlee5hKDT2z7o+yD/eJev2dkl21jPwgstmTqHK9dr
         MTPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746901429; x=1747506229;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EfoyEEer3zPvT8SIq2qSt5fxalLDGHJYs7P7w51urLU=;
        b=dY+rOQtA1nDVOGJW7k5wdXIXID7R9CAkn52pH2jOj/yxjceHz7hvkQozXipG7Inyis
         5BB21OXrAhxiWLeloM8Dhi4ZavfdZF658nskOw/uNQYkCKAsMAlTXlsRwpXYB1vWL3a5
         FcECJBGkPUPEyADp5HzszDKy9Mve55+dZ932A79za3rKHW3M65Rd4CPaKbAQ/a3KraUy
         wLl+aORJ8qsXe/dKDQmuBUBZODsivExDsH4vijLKDN8bAX3kHEOPwfaDtdTOli0u5M3P
         mvTFCeLM1VEorWmNWXgbQ2CWU1Jlf5WSsrei44at5NBlJkGWi0+yIB2e7cJxFGZcRz5I
         jQ0Q==
X-Gm-Message-State: AOJu0Yz1vodlBfZU2goGf3+8maOnvPhgJU2Yrg4AitwdSkHV9OYzib/x
	OfHBMEibCf7B+pe+Is8P/VjlVfRhEejEvMM65G75+5wJORTDx9OacuH1Vg==
X-Gm-Gg: ASbGncuGMGCBf3eLQ5LdAyIBUBHlFqEIeslJgFZOE1jhK5fmIzzGT4heBIQsBOYP/OS
	FHO/Zpp0UUMdcWi4wekGdXeB3p5m3y7Psy9Q/e/dV6azPtLw4bnjGZ7mLUx48tEUnwo1PtcVXp7
	4F8qk8NR6gVAHNZQnwL4ZviTVYdtsMYIU7Mz1KpGX7Np7zRyPKYpO48QIH3gQwI0O41rlcY7BbF
	H5uH4rZ+vDW84fnsWasmgLBK8ODAmhUfOpOdBgEgypOVQrbDOOt43dqEx7TGpzhTEeaSHAxFaHy
	muiv2iulxXmXBPl8+Qt/JZcFe4wAYYkBVjb4MaoMmj8Sr/7oibEf1ILaSxJlmw==
X-Google-Smtp-Source: AGHT+IEmThEwTL496ENxg/pL6d34Z+/9zBvfqsDzZyui9C/SN2cOGxZpkl6IznvkN7c+3Y3RaRUJxA==
X-Received: by 2002:a17:907:9710:b0:ad2:3fff:7bf with SMTP id a640c23a62f3a-ad23fff0965mr161800066b.37.1746901429363;
        Sat, 10 May 2025 11:23:49 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad2197bddbesm346056366b.134.2025.05.10.11.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 11:23:48 -0700 (PDT)
Date: Sat, 10 May 2025 18:28:06 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH v1 bpf] libbpf: use proper errno value in linker
Message-ID: <aB+atmcK/L53R40i@mail.gmail.com>
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
> 
> BTW, if you would be so kind, I think we have a similar issue with
> validate_nla() in nlattr.c, where -1 can be eventually returned as
> user-visible error code, it would be nice to fix this up like you did
> with linker APIs, thanks!

Sent it. It fixes the return value in validate_nla.  But just wanted
to add a note here, that I am not signing for fixing all the return
paths in nlattr.c and netlink.c :)

> >                 }
> >
> >                 /* shdr->sh_link points to SYMTAB */
> > --
> > 2.34.1
> >

