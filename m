Return-Path: <bpf+bounces-68212-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4171AB542B0
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 08:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9BF73BF0FA
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 06:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09AEF27146D;
	Fri, 12 Sep 2025 06:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVAgIj2K"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062F61DF270
	for <bpf@vger.kernel.org>; Fri, 12 Sep 2025 06:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757658124; cv=none; b=VopXwdAMqpsoCr9zYBlIQ5p9hExMVab67qmgRgg1ZIqHObgSL2ODQ+gK9PSVg9ZBc5Ph22Mf8VuQvTijibKkXuaps/IjIsizgdGq/iMFgc9PWvWMdrcyJCX7YOR4W8/mcnEJUZS0939kbfJTwsrWkp7BDHQ+D7mTqvjsVIkZ8kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757658124; c=relaxed/simple;
	bh=iFA1PL117TE7pLK94s5Ck1gK2qPMScvoT+lQyzR5I2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CrKvLFBjdNPpKeRwFraxpIuEIyS8tzwyDzjKgiB+uSuapjIhuO4katww3hejeeP6TDEPMuY97Ven0pQJrNgFhhLBVLlID8rRRlGu3BkRBKd4CBKqIBQIt5fuwb2qtYfp3GF3LKqE0p5Ql0r0e77UwMJ41Vb6EuEmv0E/kBgRnq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mVAgIj2K; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-75512f5a75cso12947006d6.2
        for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 23:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757658122; x=1758262922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=13UhwBOCgZAJG+PHaCo5zun9R1eUs+koRa2xLgL1H/E=;
        b=mVAgIj2Knf9vAcwbFSQOrGq3Fp5aAUNiuQDwgzNtk4vs2Uqrod6ZB90QNOOc1khGsr
         /AND5Rfa+Ivr6ViFNgi6oLW6RyPsYVfizNuhsGr9/rxtSbxGJVtxXnNTNyQHxdtIUn9d
         yQSXH1wKa8yf0+5/X/gCw0Cccywmquxh+K6RVX8Tuc5+9gzYSRxb8CBkDX3rzcgvGQBE
         FyB6BgDgTCAsL7x/k9B6Ew5HxhtXiW8yFsqdoBY757ORoJ+IIF8Q2Z9R65CCKFPred7r
         hpxADpkDjMrfPrKnVdM/eK+HrvlprjedkqoVpao+GEo2GAixqcJ7nAnsfU8gsXfFXjAU
         LraQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757658122; x=1758262922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=13UhwBOCgZAJG+PHaCo5zun9R1eUs+koRa2xLgL1H/E=;
        b=SL0aK/vgdFonYNwrtw6HL3fMpyvrEDdSrKaKtuBbbG1TRJWhozeKbTmCfeFCA7lOWX
         SxXaxFVn8mUeekzE/vHuUsT0nYAm+MGAupWnQ3PO5lDsNDmxXszbAwQ3UKeLEvXJ6JE4
         eoL6yNMfIXubB3RmIY0+mkjQ5xa8Wnr8RsTJ0K9poSY7iNQl5g/sIExo113b4mi5Hq+j
         u0EN2oQQhShIEu01PQoxH4z2eVbXEYitjleldg7bkVJlTmbQX+zAVB0x6RuyH5kqSVeY
         scpLDFm4sx3uz5cTB1Om/+9+AgJsAlRIg/s6cSUqJ49sxroxHp5JSuuq/0WrnEiMLjbK
         siWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMv9Pt0u6YgVYUA9iHEQkseDUfZ7Vk6jspPrzZwaAgfpsTd7ATaP1ALMUghXdQxRNTp/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSj05qPQMTQfx9MV8Zp8109GExOaAXpZTFAyiImou13TZfLyHv
	zixLw3lgpxqDZ5NdDApkqYbw/RbqHe4+8uTyLpeIe117i9ItixNq2oKGtHruvf4P/O40TaoAYVF
	PK7+po/OMryiE2ymp+pfFZHMvobgFS3I=
X-Gm-Gg: ASbGncsMKizfMsiN4nFrC/XL6oc2av0LWJPPPsuQnKQr5gHP+KgZVuOxrDMfzjnpPY5
	A/dBS5mHfkVMgTFVSV4jbfdkTz+r38+2FY0iu7Q9qMOySBON9D9CUa00/h/PbHWs++lWayvlJza
	g4ttegpaZaGH9VBPHW+PjZjV+ogUskYVJ25e7G9exByJCe5aD/sDnnju0woKdKQBUsUdhsxASJ3
	mUPpnw9+MO+MUGiguAoVyUAp6pghlRDgHYL10XEfzxq7J0MzQQ=
X-Google-Smtp-Source: AGHT+IFjPHWXtmC2N2XMC4kkjOR+ZHCdE67Dx4ptP+o4Gr0YwDr6+Gpi3AO9G8ouJBTJcBcxrEKztnxzkezUahDPmaE=
X-Received: by 2002:ad4:5fc7:0:b0:72c:3676:cfde with SMTP id
 6a1803df08f44-767bb87f286mr22196826d6.9.1757658121862; Thu, 11 Sep 2025
 23:22:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910024447.64788-1-laoar.shao@gmail.com> <20250910024447.64788-5-laoar.shao@gmail.com>
 <CABzRoyZQMDodwBEJwNOoJNASJBP50xMhLdvo+kKENyDKWcRAfw@mail.gmail.com>
In-Reply-To: <CABzRoyZQMDodwBEJwNOoJNASJBP50xMhLdvo+kKENyDKWcRAfw@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 12 Sep 2025 14:21:25 +0800
X-Gm-Features: AS18NWDgNlviB90497XwhehyjdnC0mbss2uvTJ6B4snySt0rWu9vzBh6IpQFiW4
Message-ID: <CALOAHbDUYYunZObchkpr1L78dhfP-dmVNgKz3mBf3xAi+cDOCg@mail.gmail.com>
Subject: Re: [PATCH v7 mm-new 04/10] mm: thp: enable THP allocation
 exclusively through khugepaged
To: Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, hannes@cmpxchg.org, usamaarif642@gmail.com, 
	gutierrez.asier@huawei-partners.com, willy@infradead.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, ameryhung@gmail.com, 
	rientjes@google.com, corbet@lwn.net, 21cnbao@gmail.com, 
	shakeel.butt@linux.dev, bpf@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 11:54=E2=80=AFPM Lance Yang <lance.yang@linux.dev> =
wrote:
>
> On Wed, Sep 10, 2025 at 11:00=E2=80=AFAM Yafang Shao <laoar.shao@gmail.co=
m> wrote:
> >
> > Currently, THP allocation cannot be restricted to khugepaged alone whil=
e
> > being disabled in the page fault path. This limitation exists because
> > disabling THP allocation during page faults also prevents the execution=
 of
> > khugepaged_enter_vma() in that path.
> >
> > With the introduction of BPF, we can now implement THP policies based o=
n
> > different TVA types. This patch adjusts the logic to support this new
> > capability.
> >
> > While we could also extend prtcl() to utilize this new policy, such a
> > change would require a uAPI modification.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  mm/huge_memory.c |  1 -
> >  mm/memory.c      | 13 ++++++++-----
> >  2 files changed, 8 insertions(+), 6 deletions(-)
> >
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 523153d21a41..1e9e7b32e2cf 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -1346,7 +1346,6 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_f=
ault *vmf)
> >         ret =3D vmf_anon_prepare(vmf);
> >         if (ret)
> >                 return ret;
> > -       khugepaged_enter_vma(vma, vma->vm_flags);
> >
> >         if (!(vmf->flags & FAULT_FLAG_WRITE) &&
> >                         !mm_forbids_zeropage(vma->vm_mm) &&
> > diff --git a/mm/memory.c b/mm/memory.c
> > index d8819cac7930..d0609dc1e371 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -6289,11 +6289,14 @@ static vm_fault_t __handle_mm_fault(struct vm_a=
rea_struct *vma,
> >         if (pud_trans_unstable(vmf.pud))
> >                 goto retry_pud;
> >
> > -       if (pmd_none(*vmf.pmd) &&
> > -           thp_vma_allowable_order(vma, vm_flags, TVA_PAGEFAULT, PMD_O=
RDER)) {
> > -               ret =3D create_huge_pmd(&vmf);
> > -               if (!(ret & VM_FAULT_FALLBACK))
> > -                       return ret;
> > +       if (pmd_none(*vmf.pmd)) {
> > +               if (vma_is_anonymous(vma))
> > +                       khugepaged_enter_vma(vma, vm_flags);
>
> Hmm... I'm a bit confused about the different conditions for calling
> khugepaged_enter_vma(). It's sometimes called for anonymous VMAs, other
> times ONLY for non-anonymous, and sometimes unconditionally ;)

Right, it is really confusing.

>
> Anyway, this isn't a blocker, just something I noticed. I might try to
> simplify that down the road.

please do it when you have a moment.

>
> Acked-by: Lance Yang <lance.yang@linux.dev>

Thanks for the review.

--=20
Regards
Yafang

