Return-Path: <bpf+bounces-68214-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB539B543B3
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 09:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89B526838DC
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 07:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F040B2BE62D;
	Fri, 12 Sep 2025 07:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCubkohk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0084C28EA56
	for <bpf@vger.kernel.org>; Fri, 12 Sep 2025 07:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757661677; cv=none; b=l0kWLfmbC9LNnQY9WnBzV2DAShUvw26KbbzcIAORXO6GjOiKwIS35hfortNVhcSGWhiBpDRT+JihqCCFsvXmWuJsRd4Y41UkYSlCT/se1X2eGMiNf0OWCFvD2heO8wdD/16gg4kOVWukTVHN5Rxs6Cd102+bB3pkJAnU2T7S2RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757661677; c=relaxed/simple;
	bh=pCyaf0fnEuGHeX6relXxQqNPQoSNU9R3Zr35j6S1eSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hVhgldFkixCGGbvCMq/jQkNF6TR+lnTgxxb8VuQNIbgmKtEfLtx09+gCNYsuBjcg7EWsvmDgan/UiOc4g52+CHdZtyfIO86qSTBm4McUDzy87jRNX7D2+svn7LLq32G7haeyT3P1AKYBDKcpGb7ML/mL9vDKtE9XAFWzs03lQJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WCubkohk; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-726e7449186so17569216d6.0
        for <bpf@vger.kernel.org>; Fri, 12 Sep 2025 00:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757661675; x=1758266475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ev88jTA6HEsYj4nljikru/jXK/dK5yGz72SO2ZtSDEk=;
        b=WCubkohk6kvQf86O4D+gssYE0/o8ZwkvbyB3QHLF1KxrngJiP5DRZ/mx1UIAbfcfx6
         jWl68+4fNvzou5ru2lKbTbeevDFFV6DVA2ClQa44VRah7CRvyRurqZWLyJ236BA0Vcxl
         ArEzp+obEDWSkjOyglHUSX4ZE25bATMnUzH3IifhRHvT0SymLKsTg8IDGIfCB61fvWVg
         Q26sJXYHTXZPtcHAlVBtOtQF2k4QqFmjpZVZKTplaXlVspmc/JPkQlALLhMIkn5A5423
         KYvw2Pipv8SAx5s2ZPtp0tkL40xt+6lUt9yWBPeDK60PjUZfXb/kF9t8fljg5A+46rsY
         QGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757661675; x=1758266475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ev88jTA6HEsYj4nljikru/jXK/dK5yGz72SO2ZtSDEk=;
        b=ClFIWzcKJ7CYUgdiBEQvZYRaLJqFtVUeCrZiGqRlDUzuDqwwckziro6OetQnle7qas
         FiUpDS5ad+isxu3B/stNHAjiQqGQdFbYSTZGMyl38q5PcudeQ1/d/XZdpSjuBkaQ1FfI
         WhD+FsbroPdIlJO1Z+DNOA+Md25Z8AxTSWKbeqqdNCbi6ZFvql2D+a1jpVh+JgEvKV2D
         Zp8hXOLhzqN5ApOmDoWvuMH1NxB7w4WAlqa/IuHqhM6gaBdMcKd+Z1/g/wJKCsgmt+6+
         2j/f60gGrfyxNAXSRyFpukydajTnY2s6xaa9vS5HPyiOKOmb6d2n5qtLg7LZCS9+cDLa
         fEFw==
X-Forwarded-Encrypted: i=1; AJvYcCUoY2bkJG0pV+rL2+UeiUjR2gi/LzhlYldvr44L/B75gnhm+3/5WE5aOkqNvPnT+pF1x6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YywIG//UkUY5necSFi2iLJkliPBUbbzrPqqah2BRTrA5gK8wrnp
	je0cTnPqWc6a2avltI08J4iXTkkYx23IrNBFw8ypZSsNC+UtfybYP+r8tEaPVkZzIiLJMyr5v6d
	2ewXHFgCkRBPtrLa62w5XJH/tS49z92I=
X-Gm-Gg: ASbGncu3NHZLMGk8wI+hXHHVn6Q82wt8TGB4R49sQ/2fnE+JkKgoxUY+mBlCqf52rVj
	brsSglMZ+X049v5tjoKFBza/MTOVzD+rX6Ruj0NoUzQhmPVmxSogNp0x8LPvPQsZtLWr0m/m2T9
	bNXrjTsWoP+Nrg/LNRJsE2HPEAhGss8EBnv23umti6Yjr2w7HGpaADJ61TncEt60Uo1DjPS5Vg4
	iro6sNA3ng3UuwaS6HzaUXNw9U89mimDUTUqBU3
X-Google-Smtp-Source: AGHT+IFmxWKlg9lTecPzrdzZLK0pJmBN7ltgoRVqWwQIeIm/S78B3/KreguC5TVAusVGlC2xM1N4WcQu5sVexX82BM8=
X-Received: by 2002:a05:6214:262d:b0:753:c7a0:8dbd with SMTP id
 6a1803df08f44-767c50647c1mr23734096d6.65.1757661674807; Fri, 12 Sep 2025
 00:21:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910024447.64788-1-laoar.shao@gmail.com> <20250910024447.64788-4-laoar.shao@gmail.com>
 <0aad915f-80b1-4c2f-adcd-4b4afe5b17dc@lucifer.local>
In-Reply-To: <0aad915f-80b1-4c2f-adcd-4b4afe5b17dc@lucifer.local>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 12 Sep 2025 15:20:38 +0800
X-Gm-Features: AS18NWAEu23WLC4-YzUUQ5p8sE8322qhir0Y_VCH3XGQPacrY3qmhSJ5JIg6_ao
Message-ID: <CALOAHbC1QDeqoS5Onkccsf+rMWEUbb1OEdeuLOaC9sLWhk-Amg@mail.gmail.com>
Subject: Re: [PATCH v7 mm-new 03/10] mm: thp: decouple THP allocation between
 swap and page fault paths
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, hannes@cmpxchg.org, 
	usamaarif642@gmail.com, gutierrez.asier@huawei-partners.com, 
	willy@infradead.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	ameryhung@gmail.com, rientjes@google.com, corbet@lwn.net, 21cnbao@gmail.com, 
	shakeel.butt@linux.dev, bpf@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 10:56=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Wed, Sep 10, 2025 at 10:44:40AM +0800, Yafang Shao wrote:
> > The new BPF capability enables finer-grained THP policy decisions by
> > introducing separate handling for swap faults versus normal page faults=
.
> >
> > As highlighted by Barry:
> >
> >   We=E2=80=99ve observed that swapping in large folios can lead to more
> >   swap thrashing for some workloads- e.g. kernel build. Consequently,
> >   some workloads might prefer swapping in smaller folios than those
> >   allocated by alloc_anon_folio().
> >
> > While prtcl() could potentially be extended to leverage this new policy=
,
> > doing so would require modifications to the uAPI.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
>
> Other than nits, these seems fine, so:
>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> > Cc: Barry Song <21cnbao@gmail.com>
> > ---
> >  include/linux/huge_mm.h | 3 ++-
> >  mm/huge_memory.c        | 2 +-
> >  mm/memory.c             | 2 +-
> >  3 files changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index f72a5fd04e4f..b9742453806f 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -97,9 +97,10 @@ extern struct kobj_attribute thpsize_shmem_enabled_a=
ttr;
> >
> >  enum tva_type {
> >       TVA_SMAPS,              /* Exposing "THPeligible:" in smaps. */
> > -     TVA_PAGEFAULT,          /* Serving a page fault. */
> > +     TVA_PAGEFAULT,          /* Serving a non-swap page fault. */
> >       TVA_KHUGEPAGED,         /* Khugepaged collapse. */
> >       TVA_FORCED_COLLAPSE,    /* Forced collapse (e.g. MADV_COLLAPSE). =
*/
> > +     TVA_SWAP,               /* Serving a swap */
>
> Serving a swap what? :) I think TVA_SWAP_PAGEFAULT would be better here r=
ight?
> And 'serving a swap page fault'.

will change it. Thanks for your suggestion.

--=20
Regards
Yafang

