Return-Path: <bpf+bounces-46900-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 655EB9F17DA
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 22:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A10CF7A0427
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 21:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAD81922DE;
	Fri, 13 Dec 2024 21:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWNoLYkK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B80188704;
	Fri, 13 Dec 2024 21:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734124305; cv=none; b=OkVlR4rLg+frhSrHh8XMqvEqPXm3jcmFDMmeMenAGLkdpOHMIzcSnTojU5TzUXIp3zowZ8Gb5Da6DChDnz4RLuNSwpXwUblblsoZtPKPB5vlCfrZiqIVs6XvU1YpBu1EbiZNOawty15Lo47I5BiBYnc8WzxwsogF0q54sHVRiRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734124305; c=relaxed/simple;
	bh=y97Fks8kEdq1LSzRrSJtzGk58JlmQt104eWxGCLhLzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e6igtvGlb9EK36kL1NH0o5+FBz+rcewePYYF5TMWI2e6gq3QxLq2jDFs7Lt/v/ql1XwxXcz8hrj9wIMFIlpVtOfYgL5ruEHDi/B4Vujff0KTc+ZRpO4+BRncd5eS2qycELuW15oQ/rKC2dQkG+6GvzmRrQ56MqVM38shtKwQ3Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gWNoLYkK; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ef72924e53so1912934a91.3;
        Fri, 13 Dec 2024 13:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734124303; x=1734729103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p6VPBJyV+Owj/Rwn3WXs70TtPuWHSr1THRUnh6czWrE=;
        b=gWNoLYkKaWbVSqDFEMCzz3/quHvwoVEnxeWAyH97n7ljJf/eZRxPoDKMMW6KIxYjLd
         QyYryQmI4XG+pzORaPn1JIxeEX1MAXKWG90hQ8TSSg/xmNqKg5E4dUefB3Bts5yAlUcm
         8k4E4TAJ2HMzXjAbCrvD6FwIHa8uH0VzEeEqf9IX0BibmL+3U4P+jJtNJa8Ia2JI+lnM
         ZosYom5exrEFqtS8EWrAILY8sh7LvUj3FgaH682bXEE9ZhNLefm8h72d6wfdnAZXLZ2m
         at3vQKQawttMhaafB/uE2eEnI6b7ovb9tvyqwg0gmAbStNAwCxGLNRr2/YesGe+/2ctF
         E5Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734124303; x=1734729103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p6VPBJyV+Owj/Rwn3WXs70TtPuWHSr1THRUnh6czWrE=;
        b=n92MJmHCaMshPnLILquhCQOtWv5s4TD5BaZ2Zm/+vaxqiB7qgeGM1jJ/6YrQJwUFpW
         y6N9yqjwT+5Aku0slgPr6U0WpHt7x3VpxbwKVZ0untAKSlLF/zhsnlav355IKlEPuN70
         OIfITjUZD5w0GDNYnDFVXa6qe/vbomKSZhc5gYEoeY0hINXgq49w3IaWTSLIom6y7X+w
         pxVZ8WPwi0W1Tjsd3le09FpSKpPmoTEmng/YrZDn4lM8IUH3StIiJSTD47VBvQJHhXAu
         vnD+lICkQIx0VKvACWXwVkYRXkFwxh8d6XWDu9y5HStMzrQIFfqWD0hNyNc8xpAHWBDv
         jwFQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+CXvYCtjOQd/cRSugcCHyepgoOKwJxq36uuJxP68zSMm+7X9/4plGmQdCOQrjPjE4dnRzkskd/Bh1cxxL@vger.kernel.org, AJvYcCV9EyKRjvV/4YeTSvPKtyktnzZDVlzkFtMSm47YUkKEOICczXrdqmYDCjrlFMGmTtxOoDE=@vger.kernel.org, AJvYcCWbgvaKbQpyOymhPWubnKgVWY4NounDaTUhw6W64BXmhoMVN8baQQ3xXh9bkbA8oT3yRfb+s3pkOiggsWLle6dYC9aO@vger.kernel.org
X-Gm-Message-State: AOJu0YxPoJ6rZhua8C/yecD7cI9W1wx5CfhQEUzjHf+BNFHHwuvqRx8T
	8RJW5aDZcUibwk4jERZWmK0d9+8919ZUOF5EgI9SxaoS8E/aWJ2OyXFtcmtn7oLLX20zJ1GpAC4
	29qDyKijDvM9I7uQrui0f6cZunaolfg==
X-Gm-Gg: ASbGnctc5GbVqpaJlCfrRARNsXW2GwMwuYcCWYXp198oFu8ZyhXyPGFKPX6Cuy7SqZl
	s8nymEa36Pcljn9pkEbCHH/69IrgAUF/9dDElZKvx3s8leGywWymadQ==
X-Google-Smtp-Source: AGHT+IE4I6FX9eL+J0ZbDZaGKY7e3qXFxo9fK/76I8fjZvq8aCKbsGP+/8NinL+B99w6xPi9TEDieFTIArby7boWOw8=
X-Received: by 2002:a17:90b:3c8a:b0:2ee:d193:f3d5 with SMTP id
 98e67ed59e1d1-2f28fa5b800mr7207214a91.7.1734124303462; Fri, 13 Dec 2024
 13:11:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211133403.208920-1-jolsa@kernel.org> <20241211133403.208920-5-jolsa@kernel.org>
 <CAEf4BzZ2g6PwY+Ah-39F7Dw2AFZUE7AxEqOuNbs5LouHtKMZbQ@mail.gmail.com> <Z1w0z2KSgFGggAVD@krava>
In-Reply-To: <Z1w0z2KSgFGggAVD@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 13 Dec 2024 13:11:30 -0800
Message-ID: <CAEf4BzZ+nkvZFADq9HzLUUcDGNa44G+hPfzOhUexKW7WqBxS6A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 04/13] uprobes: Add arch_uprobe_verify_opcode function
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 5:21=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Thu, Dec 12, 2024 at 04:48:05PM -0800, Andrii Nakryiko wrote:
> > On Wed, Dec 11, 2024 at 5:34=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wr=
ote:
> > >
> > > Adding arch_uprobe_verify_opcode function, so we can overload
> > > verification for each architecture in following changes.
> > >
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  include/linux/uprobes.h |  5 +++++
> > >  kernel/events/uprobes.c | 19 ++++++++++++++++---
> > >  2 files changed, 21 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> > > index cc723bc48c1d..8843b7f99ed0 100644
> > > --- a/include/linux/uprobes.h
> > > +++ b/include/linux/uprobes.h
> > > @@ -215,6 +215,11 @@ extern void uprobe_handle_trampoline(struct pt_r=
egs *regs);
> > >  extern void *arch_uretprobe_trampoline(unsigned long *psize);
> > >  extern unsigned long uprobe_get_trampoline_vaddr(void);
> > >  extern void uprobe_copy_from_page(struct page *page, unsigned long v=
addr, void *dst, int len);
> > > +extern int uprobe_verify_opcode(struct page *page, unsigned long vad=
dr, uprobe_opcode_t *new_opcode);
> > > +extern int arch_uprobe_verify_opcode(struct arch_uprobe *auprobe, st=
ruct page *page,
> > > +                                    unsigned long vaddr, uprobe_opco=
de_t *new_opcode,
> > > +                                    int nbytes);
> > > +extern bool arch_uprobe_is_register(uprobe_opcode_t *insn, int nbyte=
s);
> > >  #else /* !CONFIG_UPROBES */
> > >  struct uprobes_state {
> > >  };
> > > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > > index 7c2ecf11a573..8068f91de9e3 100644
> > > --- a/kernel/events/uprobes.c
> > > +++ b/kernel/events/uprobes.c
> > > @@ -263,7 +263,13 @@ static void uprobe_copy_to_page(struct page *pag=
e, unsigned long vaddr, const vo
> > >         kunmap_atomic(kaddr);
> > >  }
> > >
> > > -static int verify_opcode(struct page *page, unsigned long vaddr, upr=
obe_opcode_t *new_opcode)
> > > +__weak bool arch_uprobe_is_register(uprobe_opcode_t *insn, int nbyte=
s)
> > > +{
> > > +       return is_swbp_insn(insn);
> >
> > a bit weird that we ignore nbytes here... should we have nbytes =3D=3D
> > UPROBE_SWBP_INSN_SIZE check somewhere here or inside is_swbp_insn()?
>
> the original is_swbp_insn function does not need that and we need
> nbytes in the overloaded arch_uprobe_is_register to distinguish
> between 1 byte and 5 byte update..
>

and that's my point, if some architecture forgot to override it for
nop5 (or similar stuff), this default implementation should reject
instruction that's not an original nop, no?


> jirka
>
> >
> > > +}
> > > +
> > > +int uprobe_verify_opcode(struct page *page, unsigned long vaddr,
> > > +                        uprobe_opcode_t *new_opcode)
> > >  {
> > >         uprobe_opcode_t old_opcode;
> > >         bool is_swbp;
> > > @@ -291,6 +297,13 @@ static int verify_opcode(struct page *page, unsi=
gned long vaddr, uprobe_opcode_t
> > >         return 1;
> > >  }
> > >
> > > +__weak int arch_uprobe_verify_opcode(struct arch_uprobe *auprobe, st=
ruct page *page,
> > > +                                    unsigned long vaddr, uprobe_opco=
de_t *new_opcode,
> > > +                                    int nbytes)
> > > +{
> > > +       return uprobe_verify_opcode(page, vaddr, new_opcode);
> >
> > again, dropping nbytes on the floor here
> >
> > > +}
> > > +
> > >  static struct delayed_uprobe *
> > >  delayed_uprobe_check(struct uprobe *uprobe, struct mm_struct *mm)
> > >  {
> > > @@ -479,7 +492,7 @@ int uprobe_write_opcode(struct arch_uprobe *aupro=
be, struct mm_struct *mm,
> > >         bool orig_page_huge =3D false;
> > >         unsigned int gup_flags =3D FOLL_FORCE;
> > >
> > > -       is_register =3D is_swbp_insn(insn);
> > > +       is_register =3D arch_uprobe_is_register(insn, nbytes);
> > >         uprobe =3D container_of(auprobe, struct uprobe, arch);
> > >
> > >  retry:
> > > @@ -490,7 +503,7 @@ int uprobe_write_opcode(struct arch_uprobe *aupro=
be, struct mm_struct *mm,
> > >         if (IS_ERR(old_page))
> > >                 return PTR_ERR(old_page);
> > >
> > > -       ret =3D verify_opcode(old_page, vaddr, insn);
> > > +       ret =3D arch_uprobe_verify_opcode(auprobe, old_page, vaddr, i=
nsn, nbytes);
> > >         if (ret <=3D 0)
> > >                 goto put_old;
> > >
> > > --
> > > 2.47.0
> > >

