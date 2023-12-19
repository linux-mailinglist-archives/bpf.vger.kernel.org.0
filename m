Return-Path: <bpf+bounces-18267-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E13F581812E
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 06:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 001B3B23980
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 05:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356E66FCE;
	Tue, 19 Dec 2023 05:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0HSxaQe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E008829;
	Tue, 19 Dec 2023 05:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55193d5e8cdso4673279a12.1;
        Mon, 18 Dec 2023 21:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702965185; x=1703569985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4gaURpT7NV/Brr6JBDJIIcjGXCm84WBBQp9TOCcnomg=;
        b=R0HSxaQeOVBwQqvyO3Ir3TOr+NWAF4DZixYb3ojZH67EMc1rqY98FTh0gjrLiQ1bwW
         +OUKCz4ChwlgNlBnwgO1ZrVfvgueO5Gq3BpzS0dq3+NO28FJsd/jj1GDOidb1qJrfPyy
         eu8qAzvvJThSq7xoxQR52tIaEY+zWXOb+UPyQU+Y71xfBnLepP8rHM538sRSXNbPwiip
         LSAAisGlUxdoWZxSBK7DOBH9SncsXE0TawYLBZhyZqC7PnQa/DmbJK4G9L+oI81ZIE6U
         mIeEL4tYvegTHQuiaJRiv33YzEPbYOYbxmP4HSWypJC+6JKHr5Fv2xcdtJmnWjA+RLr+
         HLug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702965185; x=1703569985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4gaURpT7NV/Brr6JBDJIIcjGXCm84WBBQp9TOCcnomg=;
        b=bl+pWbrCbwNsIDOUQ8TAo2mq5QZqB5GignkZ5G0veWGEeTJ3y3d4zsZvMuwbtQEJIe
         d1Pg6NvbOpivvqdGvEEM0VAyhkIaJ/8dF3mGM9cywIwYa8guIejaDpBvpi9PZ1VIhpn8
         Xm06li5nAnjaOEwDqswe4dnxOvEsp//H4nfObSXZJI5ofdjO/Gmv46ZDVFLkiQ9rSE/M
         AjbKXk999YT7rYMn7DGnMKgOix1dpzgLl6AaZUCWFMlnvwIJgoH5Ab88HJ8PHga4Xudr
         MD++35Vy2cF0T0FYhl2rIg3bqTRezAf8GFYSI9crdRzTTVnM5ebWTvk70UsyONsDgjTC
         KPdA==
X-Gm-Message-State: AOJu0YyZNxQahgV8TiN5YFEDGcGLv61NoxlBI06jzCDKU5pV9g+Aqvpt
	JsdtTC6E/Uc43Az8zHsGpE48+Sw4+inL7O4FpJI=
X-Google-Smtp-Source: AGHT+IFm4H8sQM5TjV4IZ8XOtuDF2H6wdfh0sDHzOa1cB4zCqCTtk1DKSRm6TfLoSMqMiZSP+cIZWTOivMgtQ4Bi/6s=
X-Received: by 2002:a05:6402:798:b0:553:7e49:206a with SMTP id
 d24-20020a056402079800b005537e49206amr727623edy.65.1702965185012; Mon, 18 Dec
 2023 21:53:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231217131716.830290-1-menglong8.dong@gmail.com>
 <20231217131716.830290-4-menglong8.dong@gmail.com> <CAEf4BzZc3edO35FJwxgRscE4n5_qkpwQOJXjUAYjjfWwLkcANg@mail.gmail.com>
 <CADxym3bSbxccDSnS1E2ywRMibCOtTb4Mmf0nMMB-YXtO5PonXQ@mail.gmail.com>
In-Reply-To: <CADxym3bSbxccDSnS1E2ywRMibCOtTb4Mmf0nMMB-YXtO5PonXQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 18 Dec 2023 21:52:52 -0800
Message-ID: <CAEf4BzaKyARO0E+9N7myGoFbbQLMh14=6bnJ2x7ejSFpZQPMyA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 3/3] selftests/bpf: add testcase to
 verifier_bounds.c for JMP_NE
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev, 
	alexei.starovoitov@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 6:27=E2=80=AFPM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> On Tue, Dec 19, 2023 at 2:03=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Sun, Dec 17, 2023 at 5:18=E2=80=AFAM Menglong Dong <menglong8.dong@g=
mail.com> wrote:
> > >
> > > Add testcase for the logic that the verifier tracks the BPF_JNE for r=
egs.
> > > The assembly function "reg_not_equal()" that we add is exactly conver=
ted
> > > from the following case:
> > >
> > >   u32 a =3D bpf_get_prandom_u32();
> > >   u64 b =3D 0;
> > >
> > >   a %=3D 8;
> > >   /* the "a > 0" here will be optimized to "a !=3D 0" */
> > >   if (a > 0) {
> > >     /* now the range of a should be [1, 7] */
> > >     bpf_skb_store_bytes(skb, 0, &b, a, 0);
> > >   }
> > >
> > > Signed-off-by: Menglong Dong <menglong8.dong@gmail.com>
> > > ---
> > >  .../selftests/bpf/progs/verifier_bounds.c     | 27 +++++++++++++++++=
++
> > >  1 file changed, 27 insertions(+)
> > >
> >
> > LGTM, but please add a comment that we rely on bpf_skb_store_byte's
> > 4th argument being defined as ARG_CONST_SIZE, so zero is not allowed.
> > And that r4 =3D=3D 0 check is providing us this exclusion of zero from
> > initial [0, 7] range.
> >
>
> Okay, sounds great! BTW, should I add such a comment to the
> commit log or to the assembly function?
>

I'd leave it in the code, next to the function itself

> >
> > > diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/to=
ols/testing/selftests/bpf/progs/verifier_bounds.c
> > > index ec430b71730b..3fe2ce2b3f21 100644
> > > --- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
> > > +++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
> > > @@ -1075,4 +1075,31 @@ l0_%=3D:   r0 =3D 0;                          =
               \
> > >         : __clobber_all);
> > >  }
> > >
> > > +SEC("tc")
> > > +__description("bounds check with JMP_NE for reg edge")
> > > +__success __retval(0)
> > > +__naked void reg_not_equal(void)
> >
> > technically, you are testing `r4 =3D=3D 0` :) so maybe call the test
> > reg_equal_const or something. And then add similar test where you
> > actually have `r4 !=3D 0`, called req_no_equal_const?
> >
>
> Yeah, that makes sense. I'll add such a test in the next version.
>
> Thanks!
> Menglong Dong
>
> > > +{
> > > +       asm volatile ("                                 \
> > > +       r6 =3D r1;                                        \
> > > +       r1 =3D 0;                                         \
> > > +       *(u64*)(r10 - 8) =3D r1;                          \
> > > +       call %[bpf_get_prandom_u32];                    \
> > > +       r4 =3D r0;                                        \
> > > +       r4 &=3D 7;                                        \
> > > +       if r4 =3D=3D 0 goto l0_%=3D;                          \
> > > +       r1 =3D r6;                                        \
> > > +       r2 =3D 0;                                         \
> > > +       r3 =3D r10;                                       \
> > > +       r3 +=3D -8;                                       \
> > > +       r5 =3D 0;                                         \
> > > +       call %[bpf_skb_store_bytes];                    \
> > > +l0_%=3D: r0 =3D 0;                                         \
> > > +       exit;                                           \
> > > +"      :
> > > +       : __imm(bpf_get_prandom_u32),
> > > +         __imm(bpf_skb_store_bytes)
> > > +       : __clobber_all);
> > > +}
> > > +
> > >  char _license[] SEC("license") =3D "GPL";
> > > --
> > > 2.39.2
> > >

