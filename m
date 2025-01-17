Return-Path: <bpf+bounces-49224-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6874A1567B
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 19:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2CB3188CFDE
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 18:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC56E1A4E98;
	Fri, 17 Jan 2025 18:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNwsEKem"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6373146D59
	for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 18:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737138394; cv=none; b=gFBNTmVuKwds4EmSvPDYoWPs7sxpmYPcJbVlWqEtWfQ70JNYhHpwVECm10MGpuhVbE8oAnlwfeMOiyXjfSjAImn7nATXLHO9vlR6kYpjc6KGYdTCJmLl5ze9a1YVunB8aBc1Up0KbjpdsRnEfBHfovexsVcs7AhYooQZPhHiGiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737138394; c=relaxed/simple;
	bh=gI8LVY28mHfUGtjk+NYPbiw2UD+bf9lEiSPsoaTOLBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kRtQ1Pn21vNO7EayuxlM1KlXwbUIMeCcityOzYNM8KlLURPlQSXt1k5YdilPJew4PUI9aa6hCE/0png+xweXdzj4tNhpqMxnsiLV6RxhE/bGrAsV9tlg8LZ2QtUkRFB2zdNwMDW+oRAJGz5zhcLvwiW2SfXK0hhuXf0bRgkP7Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WNwsEKem; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2f13acbe29bso5824167a91.1
        for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 10:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737138392; x=1737743192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dnHoadIwYK/Wt8MRhqgcPpj9OF17j1TPxqTvlq/l6TI=;
        b=WNwsEKemmmPpqNZF0+x/g4ZHsqEcZuj45Cx5UU7TDXD+tTbsujambT+dBmupM6G3oU
         7y4qOoyvoCKbMW7UuiOgriWhl4XWlvxg3Ql1b/nzRGQ0swSH5yKI2DrMTLCO+7HHrunM
         S9E+z0fbtH3oArne5yA3kntcjCVUzhJSxBOlpML4WkL+DwSFTBlpipkHC9FzUg9IzRL0
         7kXQrlKz74GYFsgJBx2euQ8urf54D/hBvVtuWqc6KaE4440AzSIFoUx4kk2VgsUqBa25
         IJAVE87UYSKSIw3LnM7gH0V/Hs34jnt1S0emULhjN9ruAtknGeLLcw3r3MUPjW9Rj9yJ
         YDlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737138392; x=1737743192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dnHoadIwYK/Wt8MRhqgcPpj9OF17j1TPxqTvlq/l6TI=;
        b=e4EMDK0w+EnNZeuiKhYPKOOTy+rVZcUHo78PdH5v9+7j8bmqgY5ApxNikUYDCE6Wsj
         RKB5roLuQPJDNlCHDwoNDIygxn4VmD9Q51bRAa6P3oouhAS5MsRYda418rDMCgRScrxG
         ENq9ZhZEaCUNYf13S9O3+/SwhhE+VFYLvfCO/bwXKSZwftyiZl/NajRwLJmlRS8FApCO
         E0HL/pR2YagDg2Hd5twtP3ogGN/ZCdqQPsfOyNQDXq/iTNP49Q6SpanWOYDsTOKeRbM6
         sLeV+Pwuo1+FQ0M2fpOhmflIoKICnhmQtw5qjRHRlc97GUBkEvpJuUoPaxF/X/xeBQ8g
         uKkA==
X-Gm-Message-State: AOJu0YzL50w3+K+7EcAUdAtSUP3RBsEsD/0cocMVzlTUBS7DRTBqzX78
	wU/K0VpQ9c80awtuqAxapf9kd7WCBnW3zH1Ins+mozsO3cdLiNXNMTLCsm9+fPZmfZD8KhAOYc1
	7zsey/Az2op547Tp/H9poqa2lLVw=
X-Gm-Gg: ASbGncvs9kgWnZmiVCO8X9Fo6NvGRpzyAXZCMb3CJSenuqjZahUJuCLJ1KjFipvrgD4
	YJU/D49//TKHZ8CGiY0bi5JSWMnZ9h8MSqWGc
X-Google-Smtp-Source: AGHT+IFkxGtnKk8igo/8jz4MKbkAS4RENt6m8hGazJbLMabHSy2k+vce6W4EYji5InkAOJvTX4npa1q4b8adf0+lmIs=
X-Received: by 2002:a17:90b:258b:b0:2f2:a974:1e45 with SMTP id
 98e67ed59e1d1-2f782d21048mr5370401a91.16.1737138392075; Fri, 17 Jan 2025
 10:26:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107020632.170883-1-linux@jordanrome.com> <CAEf4BzZuAmSn=HxzNBHrAnx3beem+e97ANHTgR-S4Q8yn2A7CA@mail.gmail.com>
 <CA+QiOd4iq-UTxayaO7dACFdnJC=qM_FZi7=_LRqzvZEa7vgYEg@mail.gmail.com>
In-Reply-To: <CA+QiOd4iq-UTxayaO7dACFdnJC=qM_FZi7=_LRqzvZEa7vgYEg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 17 Jan 2025 10:26:20 -0800
X-Gm-Features: AbW1kvbCV10PTidPtdHfVntQ7qds7adKSMibnCh45gpLwuFhCVVEAGZwaAr1-pc
Message-ID: <CAEf4BzYaB=tEPrqbfX0AhcE=6YE5Rfjdk2fXtB-ejSFWd9g0Hg@mail.gmail.com>
Subject: Re: [bpf-next v2 1/2] bpf: Add bpf_copy_from_user_task_str kfunc
To: Jordan Rome <linux@jordanrome.com>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Kernel Team <kernel-team@fb.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Shakeel Butt <shakeel.butt@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 6:22=E2=80=AFPM Jordan Rome <linux@jordanrome.com> =
wrote:
>
> On Fri, Jan 10, 2025 at 4:50=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Jan 6, 2025 at 6:12=E2=80=AFPM Jordan Rome <linux@jordanrome.co=
m> wrote:
> > >
> > > This new kfunc will be able to copy a string
> > > from another process's/task's address space.
> >
> > nit: this is kernel code, task is unambiguous, so I'd drop the
> > "process" reference here
> >
> > > This is similar to `bpf_copy_from_user_str`
> > > but accepts a `struct task_struct*` argument.
> > >
> > > This required adding an additional function
> > > in memory.c, namely `copy_str_from_process_vm`,
> > > which works similar to `access_process_vm`
> > > but utilizes the `strncpy_from_user` helper
> > > and only supports reading/copying and not writing.
> > >
> > > Signed-off-by: Jordan Rome <linux@jordanrome.com>
> > > ---
> > >  include/linux/mm.h   |   3 ++
> > >  kernel/bpf/helpers.c |  46 ++++++++++++++++++++
> > >  mm/memory.c          | 101 +++++++++++++++++++++++++++++++++++++++++=
++
> > >  3 files changed, 150 insertions(+)
> > >
> >
> > please check kernel test bot's complains as well
>
> Maybe I need an entry in nommu.c as well for 'copy_remote_vm_str'?

yep, probably, I see that access_remote_vm has two implementations as well

>
> >
> > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > index c39c4945946c..52b304b20630 100644
> > > --- a/include/linux/mm.h
> > > +++ b/include/linux/mm.h

[...]

> > > +/*
> > > + * Copy a string from another process's address space as given in mm=
.
> > > + * Don't return partial results. If there is any error return -EFAUL=
T.
> >
> > What does "don't return partial results" mean? What happens if we read
> > part of a string and then fail to read the rest?
>
> As per the last sentence, if we fail to read the rest of the string then
> an -EFAULT is returned.

This is confusing because the buffer will contain the partially read
string contents even with -EFAULT. And this "Don't return partial
results" can be interpreted as this API sanitizing the buffer (by
zeroing or something). So I'd drop the "Don't return partial results"
part, as it just creates confusion.

>
> >
> > > + */

[...]

> >
> > > +               if (IS_ERR(page)) {
> > > +                       /*
> > > +                        * Treat as a total failure for now until we =
decide how
> > > +                        * to handle the CONFIG_HAVE_IOREMAP_PROT cas=
e and
> > > +                        * stack expansion.
> > > +                        */
> > > +                       err =3D -EFAULT;
> > > +                       break;
> > > +               }
> > > +
> > > +               bytes =3D len;
> > > +               offset =3D addr & (PAGE_SIZE - 1);
> > > +               if (bytes > PAGE_SIZE - offset)
> > > +                       bytes =3D PAGE_SIZE - offset;
> > > +
> > > +               maddr =3D kmap_local_page(page);
> > > +               retval =3D strncpy_from_user(buf, (const char __user =
*)addr, bytes);
> >
> > you are not using maddr... that seems wrong (even if it works due to
> > how kmap_local_page is currently implemented)
>
> How do you think we should handle it then?

Use (maddr + offset_within_the_page) instead of addr itself?

>
> >
> > > +               unmap_and_put_page(page, maddr);
> > > +
> > > +               if (retval < 0) {
> > > +                       err =3D retval;
> > > +                       break;
> > > +               }
> > > +
> > > +               len -=3D retval;
> > > +               buf +=3D retval;
> > > +               addr +=3D retval;
> > > +
> > > +               /* Found the end of the string */
> > > +               if (retval < bytes)
> > > +                       break;
> > > +       }
> >

[...]

