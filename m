Return-Path: <bpf+bounces-33007-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 820CB915D54
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 05:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CB022814EA
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 03:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D2E61FEF;
	Tue, 25 Jun 2024 03:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEzJze/l"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7EA61694;
	Tue, 25 Jun 2024 03:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719286116; cv=none; b=FpjUwnpRcloYM48o/6cKRF4RCUf/srxvYvpkidKvMhjIGZ7PqCJKgGw9kul/sQGHn5+qmjJcmJIWzQM1Bh9cUxvAgYbWgZF921bp1nnA2rPi/FfpYcFPKvASEZC/htBpbBnHbv8lFB8MfRWxnWb1uKUWbyZfcVdUlcDEHWVWf8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719286116; c=relaxed/simple;
	bh=mqc4LyTEfkWWu1uG74WZcylkmxzfciDMtJcW8ILFoLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MwW+DEbZJf6NJ8T5PYDMDrkE1Wvs5ZOb2WspmZFzZ6CYby4k2EsSHJBOJWxJb8Ozf2KolNY55i7Y8LTDH3eBFdA//oUcg3wpXf8o0JdutS+/oKQ/7Rfzpl0hEnpVLrnkKPQZzIKbVmktSinwjkqlkJrULr1KHrBbp8DnDA4oKxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AEzJze/l; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-71910dfb8c0so1715078a12.3;
        Mon, 24 Jun 2024 20:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719286114; x=1719890914; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5opo2TySnAvHGvpphalt1sYZCdpyst0SZZz7vY3LDc=;
        b=AEzJze/lz0Z+kKx6l8OCc3lK1z1jMborEon98k1sosUJj/nKFLjdagfe+sE3wNJPXP
         kxCmRrjEDB50zGsfpEHa0yBk5/8MNJ9wl5L4OXh3iD1I/B7dUn5ZYwIgqaotSY3bTJ9J
         yqpl+7DX7Gm+jtVKoL1ePWXDWFWnsq1ouxZNLPDUB2fc3TukpAb1d/8LEIQNZkAldqi0
         sqHa1VzTbBttW0wO8MtrR9nd8CKlv6i/KbYwXpDi8vrLxnf+lLu+Gj5sBGCbXkbU1r9G
         mW50fYCGENx7xsEh4UhP7j0g+jkoK3z5vJT5Y/OKCgrmAnqI5mqVH/W5xjBgZhX/CzWw
         QAIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719286114; x=1719890914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t5opo2TySnAvHGvpphalt1sYZCdpyst0SZZz7vY3LDc=;
        b=txqejegHAaWgFlQiUhQhdtBqV2vspQfVRUYIhH8lUni6eCBl/diShBpUn0zWerHyJf
         TPZgtHvztpiAzK2lB+onKcL8sQYN9DclY4/Qti2zlSSEHeBQNl79zCW2G2Y3y6/grSGI
         ASFl3tkwHPR1h6UKQx9zCCaUUfYH+6YT9Lkn3lfWZ7lvfoobgsILC824iUWirkGWGO/C
         z0N6MQcZ+HkpSn5iW5GrD2oUsTtn0lOwVaB3XFYk0BPIkOvB9p4CtjiakaauUJLFk+if
         xo2AumN6ESwc4DlBX01h2gMYTy/amY0gcnW0jCI3Wtjsf+lFT4KOOVIGmGL4LRYnYCd7
         Z28w==
X-Forwarded-Encrypted: i=1; AJvYcCVfI5y67GbVNlRgScEvH9/lOzkfL5eJJfaIXOAD9hGarYXKVscmbIOzW45BqUjrya/mnZO3QNSN9bYVEjDhkeiHB/JwBPhkZiTRykO6OLD++IyrvCcHbYvsG0S0R17JoP2c
X-Gm-Message-State: AOJu0YxTGRHn0k4ARPKaqXW25Mc0BctchnC9m2bqYjko9Tl6IYH6EhtT
	B4BIEnNe+HcO1NLcTrB1vHBvBl4BOHbJCOOLQZhnbIKTxWEwpjs6ZL9BetNVafvA4ydK+a09tIF
	pG+KgLYeZ4FMTxp0OiIdBJJsli9M=
X-Google-Smtp-Source: AGHT+IExrDJLkP/MTI9vXe1i+CGPkntAi0uGgZLjKlFhTPRGZkeiSvcKSupl+N2ymACISDFn/RYjl8G6hM3bbCb57no=
X-Received: by 2002:a05:6a20:1aa5:b0:1bd:1d0e:90fc with SMTP id
 adf61e73a8af0-1bd1d0e95d8mr629377637.1.1719286114239; Mon, 24 Jun 2024
 20:28:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0e13fa2e-2d1c-4dac-968e-b1a0c7a05229@p183> <20240621100752.ea87e0868591dd3f49bbd271@linux-foundation.org>
 <d58bc281-6ca7-467a-9a64-40fa214bd63e@p183> <ZnlXFF2sV-JNjGl2@krava>
In-Reply-To: <ZnlXFF2sV-JNjGl2@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 24 Jun 2024 20:28:22 -0700
Message-ID: <CAEf4BzaAKAwO=-=0qZQfkHhBodN0MQUHpL-RY7tCHdcFidjv-Q@mail.gmail.com>
Subject: Re: [PATCH v2] build-id: require program headers to be right after
 ELF header
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 4:23=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> ccing bpf list
>
> On Fri, Jun 21, 2024 at 09:39:33PM +0300, Alexey Dobriyan wrote:
> > Neither ELF spec not ELF loader require program header to be placed
> > right after ELF header, but build-id code very much assumes such placem=
ent:
> >
> > See
> >
> >       find_get_page(vma->vm_file->f_mapping, 0);
> >
> > line and checks against PAGE_SIZE.
> >
> > Returns errors for now until someone rewrites build-id parser
> > to be more inline with load_elf_binary().
> >
> > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> > ---
> >
> >  lib/buildid.c |   14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >

LGTM, but let's please route this through the bpf-next/master tree.
Can you please send it to bpf@vger.kernel.org?

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> > --- a/lib/buildid.c
> > +++ b/lib/buildid.c
> > @@ -73,6 +73,13 @@ static int get_build_id_32(const void *page_addr, un=
signed char *build_id,
> >       Elf32_Phdr *phdr;
> >       int i;
> >
> > +     /*
> > +      * FIXME
>
> nit, FIXME is usually on the same line as the rest of the comment,
> otherwise looks good
>
> Reviewed-by: Jiri Olsa <jolsa@kernel.org>
>
> thanks,
> jirka
>
>
> > +      * Neither ELF spec nor ELF loader require that program headers
> > +      * start immediately after ELF header.
> > +      */
> > +     if (ehdr->e_phoff !=3D sizeof(Elf32_Ehdr))
> > +             return -EINVAL;
> >       /* only supports phdr that fits in one page */
> >       if (ehdr->e_phnum >
> >           (PAGE_SIZE - sizeof(Elf32_Ehdr)) / sizeof(Elf32_Phdr))
> > @@ -98,6 +105,13 @@ static int get_build_id_64(const void *page_addr, u=
nsigned char *build_id,
> >       Elf64_Phdr *phdr;
> >       int i;
> >
> > +     /*
> > +      * FIXME
> > +      * Neither ELF spec nor ELF loader require that program headers
> > +      * start immediately after ELF header.
> > +      */
> > +     if (ehdr->e_phoff !=3D sizeof(Elf64_Ehdr))
> > +             return -EINVAL;
> >       /* only supports phdr that fits in one page */
> >       if (ehdr->e_phnum >
> >           (PAGE_SIZE - sizeof(Elf64_Ehdr)) / sizeof(Elf64_Phdr))
>

