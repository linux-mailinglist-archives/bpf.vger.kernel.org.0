Return-Path: <bpf+bounces-21519-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C1784E786
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 19:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B0231F23AF7
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 18:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9602285C58;
	Thu,  8 Feb 2024 18:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8ha/thR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03DF83CAB
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 18:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707416179; cv=none; b=jC53S8va6sNqoaadQUrCmzWRiZA7FPMxM0S3/fGG/OQ5cozpkHSTABEA/RcSu9PuE51Q27ZE60XwI0R5IJKLA4JZ8jxm7u+iOxLcfX7Ic7ab3A1JvHzMlHlbnJCFN8T3XkA30UctcPtLMvE/bIsk5LW5pVqocce36om2cwKyJ60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707416179; c=relaxed/simple;
	bh=cnDiLDu9MZNgorIDQfQF21dr/gmoqSPuTUIc2Jq1WGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b2DqjhPGkFhkKscfLnBkzSJFLd5Hzwi8yLtcw5vFKDWEGyvKJLluw3SQPlM0SxX9FIkFwtUT/1D3BnO97tbbDsgXt/8gH7xWpPJ/LUZAJ2Qt65IzPFzZCwpQOV5pBiQ4BDNc5OSGEltKR8VGjI5b54QU078+myx/hSNFKs9aIUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R8ha/thR; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-296a02b7104so86604a91.2
        for <bpf@vger.kernel.org>; Thu, 08 Feb 2024 10:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707416177; x=1708020977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ljpBnK+8wOzJ7+Xn5YzIBHCj5S2R/t4SlRbJ1rxOd9Q=;
        b=R8ha/thRXgnZYRZqvDwA901UeJpr815YixZgqizS3i+mw3x7q5kK6vLf6KJalu+ox0
         Bkbz62Rzll68jQ7UgMF/MShwrWCTPBT3zj1WytKQD5cobVbl8+qn/nM6IOXm1iawBHYi
         Jn0UpJruue1MdbQHk+JYrgHYxiGLz25E+JqUKiaIc00LRlJUr9QBwj2AXQyl37QIXiB6
         iGVXsrQ7kO+FfHWAk6n8GHW7J6cZq94Yl6pnDz2+I0qmS0aGVcS4cFJ06t5O2NufP4it
         AwwPLg+JEIq+qeRMiVTji9FF2UozFEdiQnpz+O9mnTJjvRjJKVDs0Jq4+RPvHnS/Ea8l
         r/YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707416177; x=1708020977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ljpBnK+8wOzJ7+Xn5YzIBHCj5S2R/t4SlRbJ1rxOd9Q=;
        b=LK1PIZA1E6eP30Hy2aYoeAg+M0rPW1TuadoiCcbvOCPljbspB/EkWye9P48ewJmv6y
         PpXBwE3VpXMeifD0tZJFhYbvMLhYBIxbnEOs0sSqWhdYondVHpbF3ZwoyhE/D+ZAV1U0
         WYUVQ6jGzN/0KBjUuAEOfmryikk/hZJj3YHvJEB8It5LuOtfpsxzI+MKGjGc9GfEhuNP
         y8iwrv9lIUBELhupjj4IOtR6GxG+WkeF2HQqIRRz9/Ezh1pzLwvDgUNw4vWMFkJURGhA
         NErKdJTuyTny000P1juhxdgQ34d5Dukz2eev8MYGMmEKxR9xbIzwXDWTGMJBmzh/3Xi6
         V0xQ==
X-Gm-Message-State: AOJu0YwBy3/hjSpz2UHQ2NEutnj7/NmQE6QAwfvB1M2yxmjF8NfLgwQQ
	Cyui6KtTp0dfcOBeO8IAOF6LJUhqW1HQQvw1VHcl+/k1tK1XUG5UuL0mCbgYENlcGV8UNx8xlCE
	0oHopXukOHW1S+dRIVJQluiSXhjA=
X-Google-Smtp-Source: AGHT+IEruEjlYUY5Sd25qriV9Hc1A/32+Nqy+mQedfdwn26Q0AM6HrhIiPhbsPwcXoFmJFBrC3w0lKaLSX3m246FCVc=
X-Received: by 2002:a17:90b:117:b0:296:2035:a3c2 with SMTP id
 p23-20020a17090b011700b002962035a3c2mr22913pjz.36.1707416177005; Thu, 08 Feb
 2024 10:16:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206220441.38311-1-alexei.starovoitov@gmail.com>
 <20240206220441.38311-13-alexei.starovoitov@gmail.com> <CAEf4BzbAj=zU+iAc6KFsCscKKYZBKmCtNvtW1e9u=TJ+LpUG7A@mail.gmail.com>
 <CAADnVQL9ctDPTOLMHp=4EURUODrReCk5KuRVZN1stwhuwP1t_g@mail.gmail.com>
In-Reply-To: <CAADnVQL9ctDPTOLMHp=4EURUODrReCk5KuRVZN1stwhuwP1t_g@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 8 Feb 2024 10:16:05 -0800
Message-ID: <CAEf4BzYMoe9ATtEBDwiTAn1E99R0yDCVF-ixKRu4h95mb=5JUA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 12/16] libbpf: Allow specifying 64-bit integers
 in map BTF.
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eddy Z <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>, 
	Barret Rhoden <brho@google.com>, Johannes Weiner <hannes@cmpxchg.org>, linux-mm <linux-mm@kvack.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 5:59=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Feb 7, 2024 at 5:17=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, Feb 6, 2024 at 2:05=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > From: Alexei Starovoitov <ast@kernel.org>
> > >
> > > __uint() macro that is used to specify map attributes like:
> > >   __uint(type, BPF_MAP_TYPE_ARRAY);
> > >   __uint(map_flags, BPF_F_MMAPABLE);
> > > is limited to 32-bit, since BTF_KIND_ARRAY has u32 "number of element=
s" field.
> > >
> > > Introduce __ulong() macro that allows specifying values bigger than 3=
2-bit.
> > > In map definition "map_extra" is the only u64 field.
> > >
> > > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > > ---
> > >  tools/lib/bpf/bpf_helpers.h |  1 +
> > >  tools/lib/bpf/libbpf.c      | 44 ++++++++++++++++++++++++++++++++++-=
--
> > >  2 files changed, 42 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.=
h
> > > index 9c777c21da28..fb909fc6866d 100644
> > > --- a/tools/lib/bpf/bpf_helpers.h
> > > +++ b/tools/lib/bpf/bpf_helpers.h
> > > @@ -13,6 +13,7 @@
> > >  #define __uint(name, val) int (*name)[val]
> > >  #define __type(name, val) typeof(val) *name
> > >  #define __array(name, val) typeof(val) *name[]
> > > +#define __ulong(name, val) enum name##__enum { name##__value =3D val=
 } name
> >
> > Can you try using __ulong() twice in the same file? enum type and
> > value names have global visibility, so I suspect second use with the
> > same field name would cause compilation error
>
> Good point will change it to:
>
> #define __ulong(name, val) enum { __PASTE(__unique_value,__COUNTER__)
> =3D val } name

yep, that should work. We still can have name collisions across
multiple files, but it doesn't matter when linking two .bpf.o files.

