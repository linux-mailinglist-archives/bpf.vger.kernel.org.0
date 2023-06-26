Return-Path: <bpf+bounces-3518-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD2573EF77
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 01:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F0F21C20A21
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 23:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF09C15AF5;
	Mon, 26 Jun 2023 23:49:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF2012B66
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 23:49:44 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DF3198D
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 16:49:42 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fa96fd7a04so18238525e9.2
        for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 16:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687823381; x=1690415381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zpgbwsdO4eJ0b0KRU2In9RLovxxf2S9iXjxF6HtvK+o=;
        b=Aok1GQwLDm7U0D7h242RckMqXTakYksM8GQ6UEm/iFIy+Mu0XSPFJJan+uQxCOFvcY
         iAb/D1VVy3s8X+IDPzBsyEcfR8SMcYMZi+pzzIJEDrly8zHgQ9FvNkXKv1hDCSToEIFF
         EynYqt84uB0tSG8S/lwXJMW+gqrkNXHMEWSF0laGk/nVPd1bYeTainzXc4Ws8Jpyj6Ry
         ci7QX+4x8bdR/SU++7XygHBuQeY8u7UJeop/TN9UN3eEnvv8hCmPntRO68RlCRCaSKJ7
         RlqAFGtAlcL5wr8NFkIHlrD8MRNt6TolJ7rCuf3qRECyPG5jyI98PmFGVk+4dG/tFIC2
         LWWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687823381; x=1690415381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zpgbwsdO4eJ0b0KRU2In9RLovxxf2S9iXjxF6HtvK+o=;
        b=eW9gqGcbeAZLc+nrZ0gvocXE1qxq09rRAr4Rzhgsr30STQ/zxjtkdlL2Ne0rddfc6i
         YG9vlgdvurpACBfzGPAwRwuVF0RQdormaQ2ze+oKpVS1LaAgChxfDIhkufqs4P6XCsIU
         dGyEi+WxhyMil+OnvND4CXDheeCHuJhyFiROcunLWTtfhz8ATZNA1cy6eGGgXV24DbeY
         gV248D4A9W0vNXhoukgtkHobtf1m6J6nhOy/VInL5gyOAgtgFpvIr62A2ZW95pZGlY0d
         z46d2SC4r5zJTpp8Kca5jR5G3nw7YKQuAZ4zKa3YhdImm+nY2mCZHYOQx0LQjdwggDxZ
         wEsQ==
X-Gm-Message-State: AC+VfDxDTxGIPnmvXhbDQQElCkADeJnhaTF/HUIfS9i0fM0EAkV1iEXh
	GAqT2gtAdyMugTJu0MyUbC+py93lJ/biQZmkV6g=
X-Google-Smtp-Source: ACHHUZ7LgtsBMOCwWxZBdpwho1JcdFJZK/NFYZtAJx3Judkpg4tmoQur4b5T+Wyik8UYwmGNkyVslI4hvPEXnUcGZSw=
X-Received: by 2002:a05:600c:2182:b0:3fa:79af:15c8 with SMTP id
 e2-20020a05600c218200b003fa79af15c8mr8654032wme.23.1687823381015; Mon, 26 Jun
 2023 16:49:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230625021816.1734617-1-liu.yun@linux.dev> <ZJmYRMGue8LvvchL@krava>
In-Reply-To: <ZJmYRMGue8LvvchL@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 26 Jun 2023 16:49:29 -0700
Message-ID: <CAEf4BzZHjzLtCDpudvtb3840T8CH5wvPywQfMjPibPq-VmQBVA@mail.gmail.com>
Subject: Re: [PATCH] libbpf: kprobe.multi: feedback function counts by kernel traced
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Jackie Liu <liu.yun@linux.dev>, andrii@kernel.org, martin.lau@linux.dev, 
	song@kernel.org, yhs@fb.com, bpf@vger.kernel.org, liuyun01@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 26, 2023 at 6:53=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Sun, Jun 25, 2023 at 10:18:16AM +0800, Jackie Liu wrote:
> > From: Jackie Liu <liuyun01@kylinos.cn>
> >
> > When tracking functions through kprobe.multi, the number of tracked
> > functions cannot be directly obtained. Sometimes in order to calculate
> > this value, it is necessary to recalculate according to the pattern in
> > the program. This is unnecessary. It is calculated by libbpf feedback
> > through opts.cnt value, which can save resources. Example at [1].
> >
> > [1] https://github.com/JackieLiu1/ketones/blob/master/src/funccount/fun=
ccount.c#L317
> >
> > Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> > ---
> >  tools/lib/bpf/libbpf.c | 3 ++-
> >  tools/lib/bpf/libbpf.h | 2 +-
> >  2 files changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index fca5d2e412c5..ed3f1202c570 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -10506,7 +10506,7 @@ static void kprobe_multi_resolve_reinit(struct =
kprobe_multi_resolve *res)
> >  struct bpf_link *
> >  bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
> >                                     const char *pattern,
> > -                                   const struct bpf_kprobe_multi_opts =
*opts)
> > +                                   struct bpf_kprobe_multi_opts *opts)
> >  {
> >       LIBBPF_OPTS(bpf_link_create_opts, lopts);
> >       struct kprobe_multi_resolve res =3D {
> > @@ -10582,6 +10582,7 @@ bpf_program__attach_kprobe_multi_opts(const str=
uct bpf_program *prog,
> >       }
> >       link->fd =3D link_fd;
> >       free(res.addrs);
> > +     OPTS_SET(opts, cnt, res.cnt);
>
> hum I'm not sure it's good idea to use opts for output values
>

We do use opts for output parameters in some cases, but in this case I
think it's not strictly necessary for libbpf to report back on the
number of resolved addresses. If an application really needs it, then
getting it from BPF link info is one way, but I'd argue that an
application should just do its own resolution if this is important for
its logic.


> there's ongoing patchset adding possibility to get this
> info/value via BPF_OBJ_GET_INFO_BY_FD syscall [1]
>
> jirka
>
> [1] https://lore.kernel.org/bpf/20230623141546.3751-1-laoar.shao@gmail.co=
m/
>
> >       return link;
> >
> >  error:
> > diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> > index 0b7362397ea3..f860dacc6add 100644
> > --- a/tools/lib/bpf/libbpf.h
> > +++ b/tools/lib/bpf/libbpf.h
> > @@ -527,7 +527,7 @@ struct bpf_kprobe_multi_opts {
> >  LIBBPF_API struct bpf_link *
> >  bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
> >                                     const char *pattern,
> > -                                   const struct bpf_kprobe_multi_opts =
*opts);
> > +                                   struct bpf_kprobe_multi_opts *opts)=
;
> >
> >  struct bpf_ksyscall_opts {
> >       /* size of this struct, for forward/backward compatibility */
> > --
> > 2.25.1
> >

