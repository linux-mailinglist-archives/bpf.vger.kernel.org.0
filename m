Return-Path: <bpf+bounces-54888-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DD5A75669
	for <lists+bpf@lfdr.de>; Sat, 29 Mar 2025 14:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AA297A6537
	for <lists+bpf@lfdr.de>; Sat, 29 Mar 2025 13:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AA01BC099;
	Sat, 29 Mar 2025 13:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="bJLTZAmz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAE51EEF9
	for <bpf@vger.kernel.org>; Sat, 29 Mar 2025 13:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743255215; cv=none; b=TLmncjU6lEUZXD2vt9ljx6rDpm2MllWzz6i/WB4CnlZlE7JtIY39nODuhMMPcz8pc3DDiuG+MxPbdnRyUDkss8jNWDcdX1fYbEbHgyFilaMwQqKEH29O0i5Kcob21lJzON8Xk99+IgL3Bb4frLF0627n+gFizmjnJoyu9dgJl0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743255215; c=relaxed/simple;
	bh=traPnDmBBgstosMofE77qqrK5eUe5RtFfZgByBuC8Rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLe2709wxVgIRGi3mr0dOzuUUKHms11Flov3qysOh0qJMy9olCJND83ug3IVNI+RrNlmVVrJGh7z/FT8cAXc7Wu/Aihdt1TJm10XsnZ9esAifWQkGYg/3Imcsx9Xsv3fpAwFjodWKlwShl66Q98Y9mnAK+QWaAFc/VjeGQtA35w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=bJLTZAmz; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3913d129c1aso2243290f8f.0
        for <bpf@vger.kernel.org>; Sat, 29 Mar 2025 06:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1743255212; x=1743860012; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R7AELxOR+mGnKVwnz92mJp+sgxNwiGmPZUQJMniiM0c=;
        b=bJLTZAmzf3+Ni4d1NltE5FBbnc1dLASa7DxViAg83jFfuHi80X8hqld014nHimvZID
         8GUTfOCo2f/iKCyRHfjeksEtb7Cwqf/gQ3SLsceKxglxNEUnhT0pqnRQZwC5tbrE8bxF
         pfqUg6DxhIJGR3PEdz1qPYJUhrEZhGSqSST/EXLRkjI8Slx+SnvwqxGGFpRk7UHJmbXc
         OHN7al5ibNUES1Sy9DWBzYXR1s0i4M5oAM12RfjoIcS6Bv+N4z9rksNJw2HAVmyuHZSs
         IcBvTkG2WkeX7EPh4lKWurRgRpnoQfeRS95RFQt97C97iPl5alQAFBiwkfHBI2RCe+Wk
         g06Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743255212; x=1743860012;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R7AELxOR+mGnKVwnz92mJp+sgxNwiGmPZUQJMniiM0c=;
        b=xGXO9Rd3Y+UKDF6qK7Y26OVLxz6AODaSWSgZhSLHnWWcIOx6bC2BxFeKpaRNj/G46r
         CZU9AAsI81nB8ITUaSso9lxXuIr6A69HL381TEGAuQgrvsZ+EqbQAPiqT7eo+8CGMve5
         at5Arz+B2kDZanOq6AS2LZDvquPPjJOfFls7HHApr+KEuBwiYMx0+q4sohT4v2xS19C5
         BnMgtariSLDtSTtFS6HMymhoe/TMllg1KZepWeMDHWCrynQ5lqRl+nw5BjuevQDg3FrK
         7miuBjfTYSJo7jYRnK36fiGTctVBo9UBircbrHvN2/jByn5fkVqSuReCxbfW+GJkfbaI
         W3KA==
X-Gm-Message-State: AOJu0Yw4Aa9CExW27Tpe5zLHZ6cFB2Kt+jHsJZHETzn81awA9Mj78S1n
	sxcc/YLrgn05KdNU0SSUNhFWaZV2EKC1/aiS4zOD1UiLxuBGnaJbrOrUAx6H+So=
X-Gm-Gg: ASbGncuwZyaOajrO0KhHQCFZaf89nIKMC8oEBLSk63LcAxX76D5TQHDFawnJBFFcYcZ
	U3mfLFbHAFeia7DNXtaF7vUTsUUGcZevYoyOgYfpvCUyp0U9xxPfIvtcVhvnFJGiPF6XTMyWLB7
	+MAXjaLWDmKt6+isc4kdgqF/NZuB08KJ7Qd1yY1zHf96p7T1/HeLKEGyBvU7mxnbGep7qJZsmGd
	dB2EBVneQjTTbCIOoRQQXuMDTcWgk0If3s6w/LMxiIlkomQT29mwn7DvogSWPrqL/yA3vocPw5E
	qKnucVbS7tKOBkieg5LWtktVAy1eXGwqWlMMro3EfNMfc1xG
X-Google-Smtp-Source: AGHT+IE5hq+8grly39Mn0NQKzb5o5IVk6EvzQmxnUrcNK3K/bWx5YvvNhjvAure8Azjd43dJeDG+hQ==
X-Received: by 2002:a05:6000:1449:b0:38a:4184:14ec with SMTP id ffacd0b85a97d-39c11b765b8mr2732540f8f.1.1743255211834;
        Sat, 29 Mar 2025 06:33:31 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b79e3b0sm5708897f8f.74.2025.03.29.06.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Mar 2025 06:33:31 -0700 (PDT)
Date: Sat, 29 Mar 2025 13:38:04 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>
Subject: Re: [RFC PATCH bpf-next 10/14] libbpf: add likely/unlikely macros
Message-ID: <Z+f3vJ4Q2LWSJ8sr@mail.gmail.com>
References: <20250318143318.656785-1-aspsk@isovalent.com>
 <20250318143318.656785-11-aspsk@isovalent.com>
 <CAEf4BzZSfzDEMk5uSZ6+QhzGrNpzM7PpPiJ+Ga9yg1rFqMU2SA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZSfzDEMk5uSZ6+QhzGrNpzM7PpPiJ+Ga9yg1rFqMU2SA@mail.gmail.com>

On 25/03/28 01:57PM, Andrii Nakryiko wrote:
> On Tue, Mar 18, 2025 at 7:30 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> >
> > A few selftests and, more importantly, a consequent changes to the
> > bpf_helpers.h file use likely/unlikely macros. So define them here.
> >
> > Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> > ---
> >  tools/lib/bpf/bpf_helpers.h | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
> > index 686824b8b413..a50773d4616e 100644
> > --- a/tools/lib/bpf/bpf_helpers.h
> > +++ b/tools/lib/bpf/bpf_helpers.h
> > @@ -15,6 +15,14 @@
> >  #define __array(name, val) typeof(val) *name[]
> >  #define __ulong(name, val) enum { ___bpf_concat(__unique_value, __COUNTER__) = val } name
> >
> > +#ifndef likely
> > +#define likely(x)      (__builtin_expect(!!(x), 1))
> > +#endif
> > +
> > +#ifndef unlikely
> > +#define unlikely(x)    (__builtin_expect(!!(x), 0))
> > +#endif
> > +
> 
> this seems useful, maybe send this as a separate patch? I'd roll your
> BPF selftests manipulation into the same patch to avoid unnecessary
> code churn

Yes, let me send it separately (+ a comment fix from the patch 01). 

The reason I've done this in three patches is 1) every separate patch
should build 2) I thought that libbpf patches should be separate from
selftest changes? (= how libbpf changes are pulled to github version of
libvirt?)

> >  /*
> >   * Helper macro to place programs, maps, license in
> >   * different sections in elf_bpf file. Section names
> > --
> > 2.34.1
> >

