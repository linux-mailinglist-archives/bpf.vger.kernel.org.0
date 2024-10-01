Return-Path: <bpf+bounces-40725-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A5A98C97B
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 01:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A8CC1C218A9
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 23:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E98B194AD1;
	Tue,  1 Oct 2024 23:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Anv/RH5V"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AF61CF5FD
	for <bpf@vger.kernel.org>; Tue,  1 Oct 2024 23:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727825198; cv=none; b=BWoYdp3o9YvIIBE66XzRy5un2xsCN44DCCBIrkQdmtjyT1VgWueiypWtzoQuvYsfTSvZbcuPqrj3XjbIMKpRRpd9KW+yuggWq+tFqex+xxgZDXF+otMGM3gPQWwouXZgh0rINwnvL6CQXbFh84oEgibKF1x7S4fCpoRwGpxCzCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727825198; c=relaxed/simple;
	bh=cmpQfu+OyRFtuOvGHdX1QJtWC9d8C1jcP9xR6Gdli84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d7BumY2RAhpS8bASEGxeZZ6yZhJ2dZA8jWz4sF0+z9m3O4Xte6d6W88D0Ny80UAKEmzB9HAQ0ULmUwQ/+J4dFwlrOGYOtFnf9B9gKEo7T7lV5aLosRF2vNjS3Pbc7dQtGSON+w8GD+Fr5opAZKtgfuCR4lVd4QFtzmPNq/bVzBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Anv/RH5V; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a1a22a7fa6so1321895ab.1
        for <bpf@vger.kernel.org>; Tue, 01 Oct 2024 16:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727825195; x=1728429995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a1yfOXukuNk9DP1ctMqKrXZfugScjxsLEB+xt0eT/mc=;
        b=Anv/RH5VwXrvRhRdQDY2hju/s7+O6FTG+v5hxFywfbLYRiCWLKn6pcwmD3e+DXMlnu
         0bBBqqNoGA1JB6g+Yb4VBQcj2H0RL9la7vrKQNA2UoEQzExahVK3bAuVA8fA5dP1pIGJ
         gmIdjSA+90rlElT0x97ApUF90/zgjp3Bl+eqzamoOBSehT2fwFnYEuFepSY6V3aGicPC
         PqAqD655rE7wS3/D5qfLIPrw3PmPJ+9JWWXAoHVTvJsp3BCZ6GUOfPoVMDDLB5HXxUCJ
         MVbY8yXEouoU9kH7RBvX3cu8MikdAaglNexctPMeO9RQ7lzBh4bTlt41i4lRW39/eJnZ
         a/Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727825195; x=1728429995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a1yfOXukuNk9DP1ctMqKrXZfugScjxsLEB+xt0eT/mc=;
        b=TKJrKWOPGrkJee69fjaw+DwOyd+CMsrC1teq3z1r/xKlGkwiXlTu/e14jnVZSSv1wR
         rhiVCahUzoC/GQXdlmamHJY5EUibs/BF1iu/vBqBeFdrWgWW+EPuXBlmqM1u/xjdJwLX
         hzjXY+m7VYpOG1sXESRN9U6pN+y2S+AETn3FhxoKJM8jSx6d0f8eP6ZDpyyNIqRhWCpB
         0v2LAR+dv2hyOVVy9FAVs0rgW8+t3vzXjy8kPtuv/Loy5USArOm0VZZ06mvui97o6mPy
         ebAQHDLIE5+jzGK6CX0flrdbNfNTXq9CDMPEj7tRdlchCcjCCZJ73MCBBfQkbI8/8voR
         1n5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUN3+r3x3scEJkEqJDEKNhMyu5ZsLmcioN5DAiSW7cQkpJhKLqvQCVbRm2+qdTLUFBKUpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlX1v8vSSf/7kSJOFQS9bty82gLoCabsXvQz9VhxETcglxzPOD
	1AHRU94y7ZIqLt+2I40hEX/CVnEiGJ/nrXgKqpqQX2hxFV5mK55cq8x2s8lBq+rncvJfty/NAl5
	G5VJkZSd1eYjnJJ2LQJfKNHkkaPu+Qim0
X-Google-Smtp-Source: AGHT+IF+rf9dRUxcM6HX38uSlP1F+9NvmLpWoMdZpZKaOQNfqWmlkikQe6kwmsskvtrpE1TnALZ46D9PKXLaBpBi2sU=
X-Received: by 2002:a05:6e02:1807:b0:3a0:abd0:122 with SMTP id
 e9e14a558f8ab-3a35eb61616mr40211045ab.8.1727825195534; Tue, 01 Oct 2024
 16:26:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001012540.39007-1-kerneljasonxing@gmail.com> <CAEf4Bzb6vkSLt+t2FOq=amNiU-6zwx1=rN43W2cn11JmzEn5Qg@mail.gmail.com>
In-Reply-To: <CAEf4Bzb6vkSLt+t2FOq=amNiU-6zwx1=rN43W2cn11JmzEn5Qg@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 2 Oct 2024 07:25:58 +0800
Message-ID: <CAL+tcoAhFZGCv50pJQnBFnw=LR8vPZuEpFm7P9_QN0_ZkKY7Gw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: syscall_nrs: disable no previous
 prototype warnning
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Andrii,

On Wed, Oct 2, 2024 at 1:15=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Sep 30, 2024 at 6:25=E2=80=AFPM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > In some environments (gcc treated as error in W=3D1, which is default),=
 if we
> > make -C samples/bpf/, it will be stopped because of
> > "no previous prototype" error like this:
> >
> >   ../samples/bpf/syscall_nrs.c:7:6:
> >   error: no previous prototype for =E2=80=98syscall_defines=E2=80=99 [-=
Werror=3Dmissing-prototypes]
> >    void syscall_defines(void)
> >         ^~~~~~~~~~~~~~~
> >
> > Actually, this file meets our expectatations because it will be convert=
ed to
> > a .h file. In this way, it's correct. Considering the warnning stopping=
 us
> > compiling, we can remove the warnning directly.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> > v2
> > Link: https://lore.kernel.org/all/CAEf4BzaVdr_0kQo=3D+jPLN++PvcU6pwTjaP=
VEA880kgDN94TZYw@mail.gmail.com/
> > 1. use #pragma GCC diagnostic ignored to disable warnning (Andrii Nakry=
iko)
> > ---
> >  samples/bpf/syscall_nrs.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/samples/bpf/syscall_nrs.c b/samples/bpf/syscall_nrs.c
> > index 88f940052450..8f6ae21d358f 100644
> > --- a/samples/bpf/syscall_nrs.c
> > +++ b/samples/bpf/syscall_nrs.c
> > @@ -2,6 +2,11 @@
> >  #include <uapi/linux/unistd.h>
> >  #include <linux/kbuild.h>
> >
> > +#pragma GCC diagnostic push
>
> please add matching pop as well
>
> > +#ifndef __clang__
>
> I don't think you need this, clang supports this pragma as well (even
> though it says "GCC")

Thanks for your review. I will fix those two in the next version.

