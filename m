Return-Path: <bpf+bounces-33179-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DBA9187C5
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 18:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 368AD1C203C0
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 16:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021B518FC6C;
	Wed, 26 Jun 2024 16:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThQB7Fe0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1F318FC84;
	Wed, 26 Jun 2024 16:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719420306; cv=none; b=rvaNbYRAWumhPWRylxPlRmykschp5ARlG3zJQ7RFZcUGRlC+06XhJ1Bt020LtaG/tI4HHyC4I0W1G1chxD2IabQQ8ebVfYI7WuIF/I5sZ183Y7auabxnZcDzPtbEF1029EPJv0mvlX2yRjpYp51vnkfXpq5JEcvw0rPSmWF4AZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719420306; c=relaxed/simple;
	bh=mlBnDkLc5vdN5Xf1UqgoyroohZBVkgQART3baZm2PRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZFRNnChDqwtj0dpsJGq8LrVzvC+onEbGf3sGKU0lp8hFgJmabloHCSmJJpuwnLfT4J6sJFcJMTgmMKBLofGShuXdxHtJv5swNv6c1/edoXSlj95yzcakWMb8lNzlT31NNlHyk8K7NZbCISkr6xiyEz66WGhoV5e2jnFKpHh1jqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ThQB7Fe0; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2c889d6995aso2698480a91.3;
        Wed, 26 Jun 2024 09:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719420304; x=1720025104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K0LuZrbW3yrKmMbuLhbIboOtF2jhmY0rlSkVoCyBwJw=;
        b=ThQB7Fe039xkvw58x7MPmG7KZ5wLlDC5FwsgV95ZRzb2XfeV6whadwCZNVL1amJowH
         so8FPfBvVl2Ao9ulN9Y91Q5Zp+Y4WLoUEYg7MpgfqH1UHUNpLLWvmp4gCSq/PcMO+iyi
         xoUmXRK6vjtccTKRS2MPHjYyoIVclrEXS+MyxLE4pbCt8x1xbzUlc3RMokC+bj/rKfgn
         /5nALRhdcw1F+C5SRjJOiggjdKbmKmEJugXRRQ4Jv3g2s0hKNdKg5MVVwHqyKDf0EEUc
         isMrfryRCTavU0rb4rUecAfD2n6fGHsPesinEyGTbls1jKyiMwwlvhCA66hv7SUliNSo
         zmOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719420304; x=1720025104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K0LuZrbW3yrKmMbuLhbIboOtF2jhmY0rlSkVoCyBwJw=;
        b=Jcqiu7OKw1+4YDR841kOgvevq38IEoG9w/8xgB/APxfAUxknt2wKR22rC/jG8U0RBD
         xoGadjQt+FHrpZX7skIYjnpKNjc0/BdxoS+EoOSydULqouSynGGRXqgXZ9O5ytlOBiuO
         D5XU/5Iy1esmxafAKZaURmxmOsZd+xSBdf1kfafWp3L8hSRSJWopwmtM2/2vu8cdfJse
         vd/5BqAQ0SyJ4k0+eq39Xy0Ntb+7oYzEf19WA+zINBdGB0YWeBN4qHrykTDXemSolpo1
         +sV+41Ma5eurB/aUuF+tBVCJjsf9P36lBOwhiL6UErNvw+0gLdfug1tTJGnn0Bo1qn+D
         9GFg==
X-Forwarded-Encrypted: i=1; AJvYcCW6U/3OfY+l09M7oDK7xQNEFbHUhaCTuAzEofESEg7VYRwIAHZ6xCdmMnoIpFXbiqH3fZMIAuZaLj8tc2lM+5A+AR45yN2/Y/nVxHaQWDns9UOnLziz5BIL9VxE1S14Vg2ThYTQq2lq
X-Gm-Message-State: AOJu0YxVexftRzqT308ZDDf6geva3dliNtxkiv1pnO83x8RnxXp6V5z6
	X63CRM/IQABCBxqPPPv7jdYqGTmm7mL1BEonpUWNsu5dnR5kiE5BR4gwM3kMQ7D8JqqOod35G1q
	5f2ter34/zWpk9FJ41Xdik/yfRNU=
X-Google-Smtp-Source: AGHT+IEr3A2+2/21oHyFyfoV3ROCY6qiBnL1vYyoB2HRbHH3uspDZ9Uoa2kkNuoN4tj8NRkLfQtjRACV+gzjES3QXWk=
X-Received: by 2002:a17:90b:710:b0:2c8:f3b4:421 with SMTP id
 98e67ed59e1d1-2c8f3b405a6mr112154a91.4.1719420304369; Wed, 26 Jun 2024
 09:45:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625002144.3485799-1-andrii@kernel.org> <20240625002144.3485799-7-andrii@kernel.org>
 <Znv7BZGwdEunAETt@krava>
In-Reply-To: <Znv7BZGwdEunAETt@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 26 Jun 2024 09:44:52 -0700
Message-ID: <CAEf4BzajQvNNROwn_a63sX1v5ow=DY1_A-f9hfajEcd23mKo7w@mail.gmail.com>
Subject: Re: [PATCH 06/12] uprobes: add batch uprobe register/unregister APIs
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	rostedt@goodmis.org, mhiramat@kernel.org, oleg@redhat.com, 
	peterz@infradead.org, mingo@redhat.com, bpf@vger.kernel.org, 
	paulmck@kernel.org, clm@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 4:27=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Mon, Jun 24, 2024 at 05:21:38PM -0700, Andrii Nakryiko wrote:
>
> SNIP
>
> > +     for (i =3D 0; i < cnt; i++) {
> > +             uc =3D get_uprobe_consumer(i, ctx);
> > +
> > +             /* Each consumer must have at least one set consumer */
> > +             if (!uc || (!uc->handler && !uc->ret_handler))
> > +                     return -EINVAL;
> > +             /* Racy, just to catch the obvious mistakes */
> > +             if (uc->offset > i_size_read(inode))
> > +                     return -EINVAL;
> > +             if (uc->uprobe)
> > +                     return -EINVAL;
> > +             /*
> > +              * This ensures that copy_from_page(), copy_to_page() and
> > +              * __update_ref_ctr() can't cross page boundary.
> > +              */
> > +             if (!IS_ALIGNED(uc->offset, UPROBE_SWBP_INSN_SIZE))
> > +                     return -EINVAL;
> > +             if (!IS_ALIGNED(uc->ref_ctr_offset, sizeof(short)))
> > +                     return -EINVAL;
> > +     }
> >
> > -     down_write(&uprobe->register_rwsem);
> > -     consumer_add(uprobe, uc);
> > -     ret =3D register_for_each_vma(uprobe, uc);
> > -     if (ret)
> > -             __uprobe_unregister(uprobe, uc);
> > -     up_write(&uprobe->register_rwsem);
> > +     for (i =3D 0; i < cnt; i++) {
> > +             uc =3D get_uprobe_consumer(i, ctx);
> >
> > -     if (ret)
> > -             put_uprobe(uprobe);
> > +             uprobe =3D alloc_uprobe(inode, uc->offset, uc->ref_ctr_of=
fset);
> > +             if (IS_ERR(uprobe)) {
> > +                     ret =3D PTR_ERR(uprobe);
> > +                     goto cleanup_uprobes;
> > +             }
> > +
> > +             uc->uprobe =3D uprobe;
> > +     }
> > +
> > +     for (i =3D 0; i < cnt; i++) {
> > +             uc =3D get_uprobe_consumer(i, ctx);
> > +             uprobe =3D uc->uprobe;
> > +
> > +             down_write(&uprobe->register_rwsem);
> > +             consumer_add(uprobe, uc);
> > +             ret =3D register_for_each_vma(uprobe, uc);
> > +             if (ret)
> > +                     __uprobe_unregister(uprobe, uc);
> > +             up_write(&uprobe->register_rwsem);
> > +
> > +             if (ret) {
> > +                     put_uprobe(uprobe);
> > +                     goto cleanup_unreg;
> > +             }
> > +     }
> > +
> > +     return 0;
> >
> > +cleanup_unreg:
> > +     /* unregister all uprobes we managed to register until failure */
> > +     for (i--; i >=3D 0; i--) {
> > +             uc =3D get_uprobe_consumer(i, ctx);
> > +
> > +             down_write(&uprobe->register_rwsem);
> > +             __uprobe_unregister(uc->uprobe, uc);
> > +             up_write(&uprobe->register_rwsem);
> > +     }
> > +cleanup_uprobes:
>
> when we jump here from 'goto cleanup_uprobes' not all of the
> consumers might have uc->uprobe set up
>
> perhaps we can set cnt =3D i - 1 before the goto, or just check uc->uprob=
e below

yep, you are right, I missed this part during multiple rounds of
refactorings. I think the `if (uc->uprobe)` check is the cleanest
approach here.

>
>
> > +     /* put all the successfully allocated/reused uprobes */
> > +     for (i =3D cnt - 1; i >=3D 0; i--) {
>
> curious, any reason why we go from the top here?

No particular reason. This started as (i =3D i - 1; i >=3D 0; i--), but
then as I kept splitting steps I needed to do this over all uprobes.
Anyways, I can do a clean `i =3D 0; i < cnt; i++` with `if (uc->uprobe)`
check.

>
> thanks,
> jirka
>
> > +             uc =3D get_uprobe_consumer(i, ctx);
> > +
> > +             put_uprobe(uc->uprobe);
> > +             uc->uprobe =3D NULL;
> > +     }
> >       return ret;
> >  }
> >
> >  int uprobe_register(struct inode *inode, struct uprobe_consumer *uc)
> >  {
> > -     return __uprobe_register(inode, uc->offset, uc->ref_ctr_offset, u=
c);
> > +     return uprobe_register_batch(inode, 1, uprobe_consumer_identity, =
uc);
> >  }
> >  EXPORT_SYMBOL_GPL(uprobe_register);
> >
> > --
> > 2.43.0
> >

