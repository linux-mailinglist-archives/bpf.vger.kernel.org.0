Return-Path: <bpf+bounces-45816-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 633E29DB2B9
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 07:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BB21282DEB
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 06:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB201459F6;
	Thu, 28 Nov 2024 06:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOpFU5HG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265F51FAA;
	Thu, 28 Nov 2024 06:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732774560; cv=none; b=SrNi3LRRQ9pxm8vuVm2oYrzsZP7IeK0+BUdYR3yNQ94VRLHKezwp+XsSWnifjJaf+4Z4i3KeZm4TWgXrLNpxojkXlDxPVbiQRDNnxd4Imr4eB0Ngkn1kS6Ux1tVGTz5GDVfQZU9sLNKoj5+twfkTgzzzfs1EN/HfveNGjZLFsl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732774560; c=relaxed/simple;
	bh=PK/arR/OpCva9Si6sMR8C07Gollf4Gpwse4YyxvelKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tYeFT7EUEkW89lrrzZPmu0z7TpKWOAYm+gr6te01+4m2uww7Pv89cXrxqfPFxxYvkIr16UH2wSqgAR1Suassxs2qj+vqZcRzYcQbzXi2N1/NSud4Gjv9xmUF4U28i+pu0n+KxGCm2xGaKs2lIvW/iuMOXkXOTZkmmNq5sGShofk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FOpFU5HG; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ea1bc2a9c5so1237977a91.0;
        Wed, 27 Nov 2024 22:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732774558; x=1733379358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t9hulB0hmZP976BENN+I0AIRiL4RBKGiyoTRhyPlTUk=;
        b=FOpFU5HGpsGWQHCdsGg4tR6CYUwmiXvXK6Sj1pMp3F/Ity+lSv3IM0BIidr9b5E65n
         v7khdpSfrY1EzbjgHb1K68vZOCH3FHj2oihVFfki8v6HMO+CGOItKH2szQ6JSaA5uCXA
         0YOFbGfzPZMs+xWUjZbbblhiXLAbTbkpL/LJFHosd6/b+j1ltK5visGef4ad3QAx+taO
         p5/Z3vR0qwty5BaU9TaUGbEjvnQ2MOd2n03X8bizmVg6JElp84WgQKz5Qj/n379QDpQq
         6+/Gmsvinldelz2SizFD8YggU+1VAQy65s59cISH7eN1QQAnbj7bmPeupyuP41nOE1T+
         JhEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732774558; x=1733379358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t9hulB0hmZP976BENN+I0AIRiL4RBKGiyoTRhyPlTUk=;
        b=CS72p2KXKdm0M21grVpd7TNtKroK9a1p/6VlH+dC8sMiAkzNLUuWKtMYuIR05EvqOM
         tSr4n9RWY4geakEEby4OlAneaK0269E3OasbYjMNtpJcIvtqXUXrntYml/4HkmxxmyuS
         u98fcrgLdQVp17AOgH/FSuTPFKGSRvKFR5LTDZOpUre0cfhhkUXR7/d6kP69xO/cdV5l
         v1BP67q4SVbtsVhN/eP7G4M3GqjUiKH8uLaWOtrIUJpoXNDBVCubZzcDgeTnIJ686fCm
         oftMYwGtj8gI8BSukt+T9ymLaNykvGL+0c8n31FVamTggdn5AYS7unOV2ih8q7Az2mcR
         O1lA==
X-Forwarded-Encrypted: i=1; AJvYcCVZkGGU7/OThSS+IrBtPhrL5pF/ksENtbzv0FCgOzyeda+Y1g0T4MvJK8KhHuQwEaw9+Fw=@vger.kernel.org, AJvYcCXY4N50TtYE7L31fKD2nlkkO1bguLCGn/PqSjyCInOqLG0lm3Yzp47QRZ8p0sG4d79q0R4IHuVhKtwtgsIf@vger.kernel.org
X-Gm-Message-State: AOJu0YwJtgOt1oCqr3tmGkCMCUuHxwmX8E/TRCoqcfKtlKuOSXiHbRD/
	y7s0IMjVQhrWvpyLy0GvrFIihtNRQExdoZRXQtQTTWsdRonYWZ+2PJmBATpQjpZ6cu2ClaahDmO
	diB/8/FuI62SXyXhshML98APvGsk=
X-Gm-Gg: ASbGnctHi+q+fcmndg9aepCECSnHJ8WJppv0km85HAsmhufXDwEDWiEHVOcGY8gVEoN
	awiFgopmCYwGThejsMYY+6ZQphP9ls3ft
X-Google-Smtp-Source: AGHT+IEQK0cR25zq5qjC+4Bytz5AHFtaBX8N6nJdTjqJ5g1IdCYdZ5mWoAGWSgcLjQbKWdan36sR/M10du4pc7Fd3rQ=
X-Received: by 2002:a17:90b:4b90:b0:2e2:b94c:d6a2 with SMTP id
 98e67ed59e1d1-2ee259eb8aemr3767807a91.0.1732774558404; Wed, 27 Nov 2024
 22:15:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126005206.3457974-1-andrii@kernel.org> <20241127165848.42331fd7078565c0f4e0a7e9@linux-foundation.org>
In-Reply-To: <20241127165848.42331fd7078565c0f4e0a7e9@linux-foundation.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 27 Nov 2024 22:15:46 -0800
Message-ID: <CAEf4BzZF8Gt_H=7J9SYXGorcjukQAqPJoX-a8vqBFdo73ZnXFA@mail.gmail.com>
Subject: Re: [PATCH mm/stable] mm: fix vrealloc()'s KASAN poisoning logic
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-mm@kvack.org, urezki@gmail.com, 
	hch@infradead.org, vbabka@suse.cz, dakr@kernel.org, mhocko@suse.com, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 4:58=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Mon, 25 Nov 2024 16:52:06 -0800 Andrii Nakryiko <andrii@kernel.org> wr=
ote:
>
> > When vrealloc() reuses already allocated vmap_area, we need to
> > re-annotate poisoned and unpoisoned portions of underlying memory
> > according to the new size.
>
> What are the consequences of this oversight?
>
> When fixing a flaw, please always remember to describe the visible
> effects of that flaw.
>

See [0] for false KASAN splat. I should have left a link to that, sorry.

  [0] https://lore.kernel.org/bpf/67450f9b.050a0220.21d33d.0004.GAE@google.=
com/

> > Note, hard-coding KASAN_VMALLOC_PROT_NORMAL might not be exactly
> > correct, but KASAN flag logic is pretty involved and spread out
> > throughout __vmalloc_node_range_noprof(), so I'm using the bare minimum
> > flag here and leaving the rest to mm people to refactor this logic and
> > reuse it here.
> >
> > Fixes: 3ddc2fefe6f3 ("mm: vmalloc: implement vrealloc()")
>
> Because a cc:stable might be appropriate here.  But without knowing the
> effects, it's hard to determine this.

This is KASAN-related, so the effect is a KASAN mis-reporting issue
where there is none.

>
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -4093,7 +4093,8 @@ void *vrealloc_noprof(const void *p, size_t size,=
 gfp_t flags)
> >               /* Zero out spare memory. */
> >               if (want_init_on_alloc(flags))
> >                       memset((void *)p + size, 0, old_size - size);
> > -
> > +             kasan_poison_vmalloc(p + size, old_size - size);
> > +             kasan_unpoison_vmalloc(p, size, KASAN_VMALLOC_PROT_NORMAL=
);
> >               return (void *)p;
> >       }
> >
>

