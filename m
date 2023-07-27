Return-Path: <bpf+bounces-6081-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F5C7655E4
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 16:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7A132823B4
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 14:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36CC17751;
	Thu, 27 Jul 2023 14:26:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AD8174D0
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 14:26:25 +0000 (UTC)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CCF30D8
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 07:26:21 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-63d09d886a3so7037206d6.2
        for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 07:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690467980; x=1691072780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iG8sQ2cXuUFhOBJOfXd2cTvYqOb3QhhgdK9IHAFunfA=;
        b=SondfhqtildiwdGLeRMAHRfDQQtL1/u/iztKURWQu0LShgEH2xxXLXL0fFhxYkajOz
         Ggs9Webs0fEbD7xchmKkXVL6vC7ZA/sqKj1vZnMmM1MYyQQOzV8zl7ngtaPR3HEjbC7u
         I0ZY7fCnO+XWM5rdLzy6HQgu/QmuXIqOgbgodnRG9pWvf4c5fk9TbCFrxaLSAochsxoE
         r+NhDvv7yqxaWFFQy2poTh578/6McXQMb6i6YQSLj2IHHAYJb8wSYcYl565rOdoyMQ9a
         ckjvvVRjbh1cVoIdctDAjcryaz2Y44wp7WRphIPgSqD1nhTbOtYYUeuTBSeqJlXDg5Sm
         tDfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690467980; x=1691072780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iG8sQ2cXuUFhOBJOfXd2cTvYqOb3QhhgdK9IHAFunfA=;
        b=eBRV2/j8Iw1fZzj9mttbQqMuCMrRb0Zl9S0ELS6g/OOFz72k0qz8SKYxDgYN7kxR73
         mNpUF3eDb0dKCZERYqyvnlz8vcYxJ6XjIHtSBBEIhNRAFttlkE7N5TS3uexwiIuEEGgN
         o0DuU1GTG3oo3ECqKD9FDxKOEfHGe4C0FkD+Hf7vQhC/BEuhH269u+Cq2ulMbCiwlXay
         891FrY7YYt7x3mkl9MhYoCj5Bi3jByX8aKKz3+bBwusR2WH8XwUxEX2cfrTESBHCsqW3
         3CR799yGo7zQI0+ONQcRBTmZYDG0bG9lodYu0baXV0wia2chGra6Ef2kcrCRTBE2kGJL
         zuoQ==
X-Gm-Message-State: ABy/qLaEAPOEcT567LBJ9/akIBh/en4d27ulZfx0zcXa+zxpiDhnvsUF
	PTEmjGGUUudsCATP6ZCtWylzFJh6BWNc9bDhSa5jblZi3AvGRQ==
X-Google-Smtp-Source: APBJJlFmSIIXZEwuiMUAJ8geVAe0ACDpRwcBFkXSuTpXWm8jWo5Bw5ii2yrk3hrzfD3tzi+x+K/i82wGJL92ELpyclE=
X-Received: by 2002:a05:6214:268f:b0:63d:572:566 with SMTP id
 gm15-20020a056214268f00b0063d05720566mr127906qvb.46.1690467980193; Thu, 27
 Jul 2023 07:26:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230727114309.3739-1-laoar.shao@gmail.com> <20230727114309.3739-2-laoar.shao@gmail.com>
 <ZMJsETrHUF1X05t/@krava>
In-Reply-To: <ZMJsETrHUF1X05t/@krava>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 27 Jul 2023 22:25:44 +0800
Message-ID: <CALOAHbDGW=vTyHWyThJN+5dScczyVrntoZWjax5O6uQKNReN3A@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Fix uninitialized symbol in bpf_perf_link_fill_kprobe()
To: Jiri Olsa <olsajiri@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, bpf@vger.kernel.org, 
	Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 27, 2023 at 9:07=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Thu, Jul 27, 2023 at 11:43:08AM +0000, Yafang Shao wrote:
> > The patch 1b715e1b0ec5: "bpf: Support ->fill_link_info for
> > perf_event" from Jul 9, 2023, leads to the following Smatch static
> > checker warning:
> >
> >     kernel/bpf/syscall.c:3416 bpf_perf_link_fill_kprobe()
> >     error: uninitialized symbol 'type'.
> >
> > That can happens when uname is NULL. So fix it by verifying the uname
> > when we really need to fill it.
> >
> > Fixes: 1b715e1b0ec5 ("bpf: Support ->fill_link_info for perf_event")
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Closes: https://lore.kernel.org/bpf/85697a7e-f897-4f74-8b43-82721bebc46=
2@kili.mountain/
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  kernel/bpf/syscall.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index 7f4e8c3..ad9360d 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -3376,16 +3376,16 @@ static int bpf_perf_link_fill_common(const stru=
ct perf_event *event,
> >       size_t len;
> >       int err;
> >
> > -     if (!ulen ^ !uname)
> > -             return -EINVAL;
>
> would it make more sense to keep above check in place and move the
> !uname change below? I'd think we want to return error in case of
> wrong arguments as soon as possible

Good point. Will change it.

>
> > -     if (!uname)
> > -             return 0;
> > -
> >       err =3D bpf_get_perf_event_info(event, &prog_id, fd_type, &buf,
> >                                     probe_offset, probe_addr);
> >       if (err)
> >               return err;
> >
> > +     if (!ulen ^ !uname)
> > +             return -EINVAL;
> > +     if (!uname)
> > +             return 0;
>
> and here we just return 0 if we do not store the name to provided buffer

Will do it.

--=20
Regards
Yafang

