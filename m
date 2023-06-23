Return-Path: <bpf+bounces-3288-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4260273BC8F
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 18:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1EDB281C65
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 16:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C865100B8;
	Fri, 23 Jun 2023 16:29:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC39100A6
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 16:29:29 +0000 (UTC)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D18189
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 09:29:27 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f954d78bf8so1119438e87.3
        for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 09:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687537766; x=1690129766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8G5cUOjROyfafnQmZG+7nVziUpAb6qlfVHt8x51WPJU=;
        b=IQlrzicA2Apfbvt13NPKUiqayI1VGzF6HcNPeCYgfwP1HfLiN3jB7pTJteS4o67w0R
         6g5DipwB6svs3udJAn5sCIlM4DJIh5hDeF7ao23BIpTElCykSizIfIgZS/79mMm391x7
         9UQCmwDjUSWl2JmOkKP4nxedb+fBvrI9Va7YqAeCg0S2zIyQjoxpKTCkIreJCrfGcFf3
         mtM2+y+B2mhIJCQc6UGIKykAaKuUYWp+STm4R/I1tBh3ys4zJIenVz5cNH0V4ssBHa4d
         smt8FZszQqTcF7nsUwPpskPSdbMOS7PpRplQI1Ncta6O/Y1FrVE/NLW1W2S9GGIrL84G
         spmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687537766; x=1690129766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8G5cUOjROyfafnQmZG+7nVziUpAb6qlfVHt8x51WPJU=;
        b=QyWlKLDQ3RzZK1ItbFZP+JPkhgKXbRIvOcY/9MG3MGwvgkwKxsyHZ7VzKZroVxXd8g
         rup6LtLopIEyRBmaQKKxuzizqsKhnRWd7UsxFL5cRd/MpWPTAxUwGfn5/XgulxbYOJ/W
         0T4UeUjbPI1Ky4AY4d3ZA1WH3J0bRZwfuSpPx37Bq+jQ0HZ580DPKO3xqlbN23BOitIB
         3G/E6c6RN90fYDTnj+4VvbJvzAhZHCUMq6oOe2YfEsETIZaVcHWJDcxhmqzetcIPJCX2
         zk9FD/KXY10ZrAi1xO7l8uHAnADqK7uoWgWi+ZVZpY2MkcnChBPUwnEoGrKoHJAPWXsq
         81YA==
X-Gm-Message-State: AC+VfDwE/F4GDK1FSkyYeJlQyGD7xLBd5fxkXD12OQknjH0jXvL/WsFA
	B+GF+DMMQ0p6WLGYCrh69JZSqraa7DT5Sm+YY/8=
X-Google-Smtp-Source: ACHHUZ5hKtA5/ocQMKsk+923qcIDCEBILjdoEQuSNxXI4HTt+edtlbMkc14Q52KrAj1uq/fWngwNCqNzdW2U2wEsHog=
X-Received: by 2002:a19:384a:0:b0:4f8:5637:2cd0 with SMTP id
 d10-20020a19384a000000b004f856372cd0mr12462806lfj.26.1687537765553; Fri, 23
 Jun 2023 09:29:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230620083550.690426-1-jolsa@kernel.org> <20230620083550.690426-7-jolsa@kernel.org>
 <CAEf4BzbVJ4y2-y8WFicA_iSkVUoieWWHbv_f1mLwoY3fSPeTRw@mail.gmail.com> <ZJVVf2Ml/gvUSF+I@krava>
In-Reply-To: <ZJVVf2Ml/gvUSF+I@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 23 Jun 2023 09:29:13 -0700
Message-ID: <CAEf4BzbAJt2NBup=Puyxd=tT8hf8jmiP6X88U=pQ3Eys1RXgwg@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 06/24] libbpf: Add elf symbol iterator
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 23, 2023 at 1:19=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Thu, Jun 22, 2023 at 05:31:58PM -0700, Andrii Nakryiko wrote:
> > On Tue, Jun 20, 2023 at 1:36=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wr=
ote:
> > >
> > > Adding elf symbol iterator object (and some functions) that follow
> > > open-coded iterator pattern and some functions to ease up iterating
> > > elf object symbols.
> > >
> > > The idea is to iterate single symbol section with:
> > >
> > >   struct elf_symbol_iter iter;
> > >   struct elf_symbol *sym;
> > >
> > >   if (elf_symbol_iter_new(&iter, elf, binary_path, SHT_DYNSYM))
> > >         goto error;
> > >
> > >   while ((sym =3D elf_symbol_iter_next(&iter))) {
> > >         ...
> > >   }
> > >
> > > I considered opening the elf inside the iterator and iterate all symb=
ol
> > > sections, but then it gets more complicated wrt user checks for when
> > > the next section is processed.
> > >
> > > Plus side is the we don't need 'exit' function, because caller/user i=
s
> > > in charge of that.
> > >
> > > The returned iterated symbol object from elf_symbol_iter_next functio=
n
> > > is placed inside the struct elf_symbol_iter, so no extra allocation o=
r
> > > argument is needed.
> > >
> > > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  tools/lib/bpf/libbpf.c | 179 ++++++++++++++++++++++++++-------------=
--
> > >  1 file changed, 114 insertions(+), 65 deletions(-)
> > >
> >
> > This is great. Left a few nits below. I'm thinkin maybe we should add
> > a separate elf.c file for all these ELF-related helpers and start
> > offloading code from libbpf.c, which got pretty big already. WDYT?
>
> yes, I thought doing the move after this is merged might be better,
> because it's quite big already

true (and btw, please give me a bit more time to review the rest of
patches before posting a new version), but I'm ok with just going
straight to elf.c move. Either way it's a lot of +++ and ---, whether
it's in the same file or not doesn't matter all that much.


>
> >
> >
> > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > index af52188daa80..cdac368c7ce1 100644
> > > --- a/tools/lib/bpf/libbpf.c
> > > +++ b/tools/lib/bpf/libbpf.c
> > > @@ -10824,6 +10824,109 @@ static Elf_Scn *elf_find_next_scn_by_type(E=
lf *elf, int sh_type, Elf_Scn *scn)
> > >         return NULL;
> > >  }
> > >
> > > +struct elf_symbol {
> > > +       const char *name;
> > > +       unsigned long offset;
> > > +       int bind;
> > > +};
> > > +
> > > +struct elf_symbol_iter {
> >

[...]

